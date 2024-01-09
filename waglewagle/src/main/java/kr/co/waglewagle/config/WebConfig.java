package kr.co.waglewagle.config;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.zaxxer.hikari.HikariDataSource;

import kr.co.waglewagle.admins.util.AdminInterceptor;
import kr.co.waglewagle.admins.util.AdminInterceptor2;
import kr.co.waglewagle.auctions.won.AutionGoodsArgumentResolver;
import kr.co.waglewagle.users.ty.util.LoginInterceptor;
import kr.co.waglewagle.users.ty.util.LogoutInterceptor;
import lombok.extern.slf4j.Slf4j;

@Configuration
@ComponentScan(basePackages = "kr.co.waglewagle")
@EnableWebMvc
@MapperScan(basePackages = "kr.co.waglewagle", annotationClass = Mapper.class)
//스케쥴링 실행을 위한 어노테이션
@EnableScheduling
@EnableTransactionManagement
public class WebConfig implements WebMvcConfigurer {
	
	@Value("${db.driver}")
	private String driver;
	@Value("${db.url}")
	private String url;
	@Value("${db.username}")
	private String username;
	@Value("${db.userpassword}")
	private String userpassword;
	@Value("${file.dir}")
	private String filePath;
	//외부 파일과 실제 디렉토리 경로 설정을 위해 추가
	@Value("${os.root}")
	private String osRoot;

	// 로그인 페이지로 이동하는 인터셉터의 예외 경로
	private String[] loginIntercepterExclude = { 
		"/",
		"/resources/**", 
		"/upload/**", 
		"/users/**", 
		"/board/noticelist/**",
		"/admin/**",
		"/goods/search/**",
		"/goods/searchScroll",
		"/error/**"
	};

	// 관리 페이지 권한별 접근 가능 여부 판별 인터셉터의 예외 경로
	private String[] adminIntercepterExclude = {
		"/admin/login",
		"/admin/stop",
		"/admin/check/duplication",
		"/admin/add/admin_account",
		"/admin/usersStatus",
		"/admin/goodsStatus",
		"/admin/delete/admin_account"
	};
	
	@Autowired
	MypageInterceptor mypageInterceptor; // 마이페이지 인터셉터
	@Autowired
	AdminInterceptor adminInterceptor; // 관리자 페이지 인터셉터
	@Autowired
	AdminInterceptor2 adminInterceptor2; // 관계자 외 관리자 페이지 접근을 막는 인터셉터 
	@Autowired
	LoginInterceptor loginInterceptor; // 로그인 인터셉터
	@Autowired
	LogoutInterceptor logoutInterceptor; // 비회원 체크 인터셉터
	@Autowired
	RelCaculateInterceptor relCaculateInterceptor; // 친밀도 계산 인터셉터
	@Autowired
	ReloadSessionInterceptor reloadSessionInterceptor; // 세션 업로드 인터셉터

	//argumentResolver등록
	@Override
	public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
		resolvers.add(auctionArgumentResolver());
	}

	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver rs = new InternalResourceViewResolver();
		rs.setPrefix("/WEB-INF/views/");
		rs.setSuffix(".jsp");
		registry.viewResolver(rs);
	}

	// 이미지 경로 지정
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/"); // 화면 디자인 이미지
		registry.addResourceHandler("/upload/**").addResourceLocations("file:///"+osRoot+"/"); // 상품 및 유저 이미지
	}

	// db관련 bean등록
	@Bean(destroyMethod = "close")
	public HikariDataSource dataSource() {
		HikariDataSource dataSource = new HikariDataSource();
		dataSource.setDriverClassName(driver);
		dataSource.setJdbcUrl(url);
		dataSource.setUsername(username);
		dataSource.setPassword(userpassword);
		return dataSource;
	}

	// mybatis
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean ssf = new SqlSessionFactoryBean();
		ssf.setDataSource(dataSource());
		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
		ssf.setMapperLocations(resolver.getResources("classpath:/*/**.xml"));
		return ssf.getObject();
	}

	// sqlSessionFactory
	@Bean
	public SqlSessionTemplate sqlSessionTemplate() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}

	// 프로퍼티설정 파일 읽기
	@Bean
	public static PropertyPlaceholderConfigurer property() {
		PropertyPlaceholderConfigurer pro = new PropertyPlaceholderConfigurer();
		pro.setLocations(new ClassPathResource("db.properties"), new ClassPathResource("file.properties"),
				new ClassPathResource("mail.properties"));
		return pro;
	}

	// 인터셉터 모음
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// [모든 페이지 인터셉터] 로그인이 필요한 페이지에 비회원 접근 시, 로그인 페이지로 리다이렉트
		registry.addInterceptor(loginInterceptor).addPathPatterns("/**").excludePathPatterns(loginIntercepterExclude).order(1);
		// [비회원 페이지 인터셉터] 이미 로그인이 되어있을 때 접근할 필요가 없는 페이지(로그인, 회원가입, 회원찾기)로 접근 시, 이전 페이지로 되돌아가게 함
		registry.addInterceptor(logoutInterceptor).addPathPatterns("/users/login","/users/join", "/users/find_info").order(2);
		// [친밀도 업데이트 인터셉터] 친밀도가 변동되는 상황(거래 완료, 거래 파기, 거래글 접근금지)에 친밀도 업데이트 
		registry.addInterceptor(relCaculateInterceptor).addPathPatterns("/auctions/comfirm/**", "/auctions/report/comfirm/**", "/auctions/end/**", "/admin/goodsStatus").excludePathPatterns().order(3);
    // [마이페이지용 인터셉터] 마이페이지의 모든 페이지에 필요한 공통 작업 수행
		registry.addInterceptor(mypageInterceptor).addPathPatterns("/mypage/**").excludePathPatterns().order(4);
		// [세션 인터셉터] 세션에 있는 유저 정보를 다시 불러옴(마이페이지 접속 시)
		registry.addInterceptor(reloadSessionInterceptor).addPathPatterns("/", "/mypage/auctions").excludePathPatterns().order(5);
		// [관리자 페이지 인터셉터] 관계자 외 관리자 페이지 접속 시, 에러 페이지로 이동
		registry.addInterceptor(adminInterceptor2).addPathPatterns("/admin/**").excludePathPatterns("/admin/login").order(6);
	    // [관리자 페이지 인터셉터] 관리자 등급별 접근 페이지 제한
	    registry.addInterceptor(adminInterceptor).addPathPatterns("/admin/**").excludePathPatterns(adminIntercepterExclude).order(7);
	}

	// 파일 업로드를 위한 bean
	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver resolver = new CommonsMultipartResolver();
		resolver.setMaxUploadSize(2000000);
		resolver.setDefaultEncoding("UTF-8");
		return resolver;
	}
		
	// messages를 읽기 위한 Bean
	@Bean 
	public MessageSource messageSource() {
		final ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasename("/errorMessage/error");
		messageSource.setDefaultEncoding("utf-8");
		return messageSource;
	}
		
	// 트랜잭션 설정
	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager dtm = new DataSourceTransactionManager();
		dtm.setDataSource(dataSource());
		return dtm;
	}
	
	// ArgumentResolver 등록
	@Bean
	public HandlerMethodArgumentResolver auctionArgumentResolver() {
		return new AutionGoodsArgumentResolver();
	}
}

package kr.co.waglewagle.users.ty.mailauth;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import lombok.extern.slf4j.Slf4j;

@Configuration
@PropertySource("classpath:mail.properties")
@Slf4j
public class MailConfig {
	@Value("${mail.username}")
	private String username;
	@Value("${mail.password}")
	private String password;

	@Bean
	public JavaMailSender javaMailSender() {
		JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
		javaMailSender.setHost("smtp.naver.com");
		javaMailSender.setPort(587);
		javaMailSender.setUsername(username);
		javaMailSender.setPassword(password);
		
		javaMailSender.setJavaMailProperties(getMailProperties());
		
		return javaMailSender;//
	}
	
	private Properties getMailProperties() {
		Properties properties = new Properties();
		properties.setProperty("mail.transport.protocol", "smtp");
		properties.setProperty("mail.smtp.auth", "true");
		properties.setProperty("mail.smtp.starttls.enable", "true");
		properties.setProperty("mail.debug", "true");
		properties.setProperty("mail.smtp.ssl.trust", "smtp.naver.com");
		//properties.setProperty("mail.smtp.ssl.enable", "false");
		properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
		
		
		return properties;
	}
	
}

package kr.co.waglewagle.goods.won;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GoodsFormVO {
	//form을 통해 받지 않지만, 추후에 DB에 데이터 추가시 필요
	private Integer users_id;
	private Integer goods_id;
	@NotNull(message = " 상품 이미지는 최소 1개이상 등록해주세요")
	private List<MultipartFile> images;
	
	@NotBlank(message="대표 이미지는 반드시 지정해야합니다.")
	private String goods_th_img;
	
	@NotBlank(message = " 게시물 제목은 필수 값입니다.")
	private String goods_title;
	private String goods_comment;
	
	@NotNull(message = " 카테고리를 지정해주세요")
	private Integer goods_category1;
	@NotNull(message = " 카테고리를 지정해주세요")
	private Integer goods_category2;
	
	@NotNull(message = " 상품 가격을 입력해주세요")
	@Min(value = 0, message = " 가격은 음수일 수 없습니다.")
	private Integer goods_start_price;
	@NotNull(message = " 경매 날짜를 지정해주세요")
	private Date goods_exp;
	@NotBlank(message = " 주소를 입력해주세요")
	private String goods_addr;
	
	
	private String goods_dong;
}

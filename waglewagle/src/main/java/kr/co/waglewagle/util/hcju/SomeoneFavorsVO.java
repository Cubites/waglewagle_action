package kr.co.waglewagle.util.hcju;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SomeoneFavorsVO {
	private Integer goods_id;
	private String goods_title;
	private Integer goods_start_price;
	private Integer goods_avg_price;
	private Date goods_exp;
	private String goods_th_img;
	private Integer goods_access;
	private Integer users_id;
}

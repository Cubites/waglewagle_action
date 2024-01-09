package kr.co.waglewagle.util.hcju;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SomeoneAuctionsFailVO {
	private Integer goods_id;
	private String goods_title;
	private String goods_th_img;
	private Integer goods_start_price;
	private Date post_date;
	private Date goods_exp;
}

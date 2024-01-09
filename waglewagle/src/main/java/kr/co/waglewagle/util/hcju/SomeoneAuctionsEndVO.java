package kr.co.waglewagle.util.hcju;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SomeoneAuctionsEndVO {
	private Integer goods_id;
	private String goods_th_img;
	private String goods_title;
	private Integer purchase_price;
	private Date auctions_end_date;
	private Integer seller_id;
	private Integer buyer_id;
}

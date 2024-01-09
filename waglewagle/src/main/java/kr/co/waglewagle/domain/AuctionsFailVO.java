package kr.co.waglewagle.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuctionsFailVO {
	private Integer auctions_fail_id;
	private Integer auctions_fail_seller;
	private Integer goods_id;
	private Integer goods_start_price;
	private Date goods_date;
	private String goods_th_img;
}

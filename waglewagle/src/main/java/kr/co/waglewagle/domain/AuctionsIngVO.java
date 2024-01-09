package kr.co.waglewagle.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuctionsIngVO {
	private Integer auctions_ing_id;
	private Integer auctions_ing_seller;
	private Integer auctions_ing_buyer;
	private Integer auctions_ing_price;
	private Date auctions_date;
	private Integer goods_id;
	private Integer auctions_seller_read;
	private Integer auctions_buyer_read;
}

package kr.co.waglewagle.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuctionsEndVO {
	private Integer auctions_end_id;
	private Integer auctions_end_seller;
	private Integer auctions_end_buyer;
	private Integer auctions_end_price;
	private Date auctions_end_date;
	private Integer goods_id;
}

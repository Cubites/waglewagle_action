package kr.co.waglewagle.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuctionsBreakVO {
	private Integer auctions_break_id;
	private Integer auctions_break_user;
	private Integer auctions_break_reason;
	private String auctions_break_detail;
	private Date auctions_break_date;
	private Integer goods_id;
}

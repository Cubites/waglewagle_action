package kr.co.waglewagle.util.hcju;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SomeoneAuctionsBreakVO {
	private Integer goods_id;
	private String goods_th_img;
	private String goods_title;
	private Date auctions_break_date;
}

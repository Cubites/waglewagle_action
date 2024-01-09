package kr.co.waglewagle.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BidsVO {
	private Integer bids_id;
	private Integer users_id;
	private Integer goods_id;
	private Integer bids_price;
}

package kr.co.waglewagle.bids.won;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import javax.validation.constraints.PositiveOrZero;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BidsFormVO {
	@NotNull(message = "제출된 가격을 확인해주세요")
	@Positive(message = "0이상의 값을 제출해 주세요")
	private Integer bids_price;
	@NotNull(message = "상품 id값은 빈 값일 수 없습니다.")
	private Integer goods_id;
	@NotNull(message = "유저 id값은 빈 값일 수 없습니다.")
	private Integer users_id;
	@NotNull(message = "가용 포인트가 부족합니다")
	@Positive(message="가용 포인트는 0원보다 작을 수 없습니다.")
	private Integer point_usable;
	private Integer goods_start_price;
}

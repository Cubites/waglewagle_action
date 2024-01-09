package kr.co.waglewagle.reports.won;

import java.util.Arrays;

public enum AuctionBreakReason {
	
	TYPE0("이미지와 실제 상품이 너무 다름",0),TYPE1("판매자가 거래 장소에 나오지 않음",1),TYPE2("기타 사유",2);
	private String reson;
	private Integer type;
	AuctionBreakReason(String reson, Integer type){
		this.reson = reson;
		this.type = type;
	}
	public static Integer getBreakType(String Reason) {
		
		return Arrays.stream(AuctionBreakReason.values())
					 .filter(type -> {return type.reson.equals(Reason);})
		             .map(types -> types.type).findFirst().orElse(null);
		
	}
}

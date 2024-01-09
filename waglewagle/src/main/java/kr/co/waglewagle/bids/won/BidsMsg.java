package kr.co.waglewagle.bids.won;

public enum BidsMsg {
	MSG1("제출된 가격을 확인해 주세요",6),MSG2("본인의 글에는 호가할 수 없습니다",2),MSG3("가용 포인트가 부족합니다",3),
	MSG4("시작 가격보다 작은 금액은 호가할 수 없습니다.",4),MSG5("이미 최대호가를 제출하셨습니다.",5)
	,MSG6("알 수 없는 오류로 호가등록에 실패했습니다. 잠시후 다시 시도해 주세요",0);
	
	private String msg;
	private Integer msgNumber;
	
	private BidsMsg(String msg,Integer msgNumber) {
		this.msg = msg;
		this.msgNumber = msgNumber;
	}
	
	public String getMsg() {
		return this.msg;
	}
	
	public Integer getMsgNumber() {
		return this.msgNumber;
	}
	
	public static BidsMsg gethighPriorityMsg(BidsMsg m1, BidsMsg m2) {
			return m1.msgNumber < m2.msgNumber ? m1 : m2;
	}
	
	
}

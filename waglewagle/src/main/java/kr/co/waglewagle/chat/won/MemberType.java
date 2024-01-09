package kr.co.waglewagle.chat.won;

public enum MemberType {

	Seller("seller"),Buyer("buyer");
	
	private String type;
	private MemberType(String type) {
		this.type = type;
	}
	public String getType() {
		return this.type;
	}
	
}

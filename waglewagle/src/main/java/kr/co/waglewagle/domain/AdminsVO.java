package kr.co.waglewagle.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminsVO {
	private Integer admins_id;
	private String admins_email;
	private String admins_pwd;
	private String admins_phone;
	private Integer admins_role; 
	
	//추가수정함 ( 전체 관리자가 역할 수정시에 구분할때 필요하다고 판단 )
	private String admins_name;

}

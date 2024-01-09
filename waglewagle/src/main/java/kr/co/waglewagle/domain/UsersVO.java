package kr.co.waglewagle.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UsersVO {
	private Integer users_id;
	private String users_nick;
	private String users_pwd;
	private String users_name;
	private Integer users_gender;
	private String users_phone;
	private String users_email;
	private Date users_join;
	private Integer users_rel;
	private String users_image;
	private Integer users_status;
	private String users_addr_list;
	
	private Integer cnt;
	
	//페이징 + 검색 추가
	private Integer page;
	private Integer startIdx;
	private String searchWord;
	
	public UsersVO() {
		this.page = 1;
	}
	public int getStartIdx() {
		return (page-1) * 10;
	}
		
}

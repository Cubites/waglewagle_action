package kr.co.waglewagle.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticesVO {
	private Integer notices_id;
	private String notices_title;
	private String notices_content;
	private Date notices_date;
	private Integer admins_id;
	
	//페이징 + 검색 추가
	private Integer page;
	private Integer startIdx;
	private String searchWord;
	
	public NoticesVO() {
		this.page = 1;
		this.startIdx = 0;
	}
	public int getStartIdx() {
		return (page-1) * 10;
	}
}

package kr.co.waglewagle.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QnasVO {
	private Integer qnas_id;
	private String qnas_title;
	private String qnas_content;
	private Date qnas_date;
	private Integer users_id;
	private String qnas_reply;
	private Date qnas_reply_date;
	private Integer qnas_read;
	private Integer admins_id;
	private Integer rownum;
	
	
	//페이징 + 검색 추가
	private Integer page;
	private Integer startIdx;
	private String searchWord;
	
	public QnasVO() {
		this.page = 1;
	}
	public int getStartIdx() {
		return (page-1) * 10;
	}

}

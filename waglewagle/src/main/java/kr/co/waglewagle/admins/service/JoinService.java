package kr.co.waglewagle.admins.service;

import kr.co.waglewagle.domain.AdminsVO;

public interface JoinService {
	// 관리자 아이디 중복 체크
	Integer checkDuplicationId(String admins_email);
	// 관리자 계정 추가
	int addAdminAccount(AdminsVO vo);
	
}

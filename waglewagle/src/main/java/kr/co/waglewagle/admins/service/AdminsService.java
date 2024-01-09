package kr.co.waglewagle.admins.service;

import java.util.List;
import java.util.Map;

import kr.co.waglewagle.domain.AdminsVO;

public interface AdminsService {
	// 테스트용 세션 추가
	AdminsVO addSessionForTest(Integer admins_id);
	// 관리자 계정 수 조회
	Integer countAdmins(String searchWord);
	// 관리자 계정 목록 조회
	List<AdminsVO> showAdmins(Map<String, Object> dataForSearch);
	// 관리자 계정 삭제
	int deleteAdmin(Integer admins_id);
}

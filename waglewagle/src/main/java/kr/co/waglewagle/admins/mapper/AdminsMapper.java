package kr.co.waglewagle.admins.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.AdminsVO;

@Mapper
public interface AdminsMapper {
	// 테스트용 세션 추가
	AdminsVO addSessionForTest(Integer admins_id);
	// 관리자 계정 수 조회
	Integer countAdmins(String searchWord);
	// 관리자 계정 목록 조회
	List<AdminsVO> showAdmins(Map<String, Object> dataForSearch);
	// 관리자 계정 삭제
	int deleteAdmin(Integer admins_id);
}

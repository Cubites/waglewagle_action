package kr.co.waglewagle.admins.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.AdminsVO;

@Mapper
public interface JoinMapper {
	// 관리자 아이디 중복 체크
	Integer checkDuplicationId(String admins_email);
	// 관리자 계정 추가
	int addAdminAccount(AdminsVO vo);
}

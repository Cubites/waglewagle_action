package kr.co.waglewagle.admins.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.AdminsVO;

@Mapper
public interface LoginMapper {
	AdminsVO adminInfo(String admins_email);

	int changePwd(Map<String, String> admin);

}

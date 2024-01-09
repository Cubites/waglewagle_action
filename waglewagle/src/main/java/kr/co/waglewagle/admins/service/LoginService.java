package kr.co.waglewagle.admins.service;


import java.util.Map;

import kr.co.waglewagle.domain.AdminsVO;

public interface LoginService {
	AdminsVO adminInfo(String admins_email);
	boolean changePwd(Map<String, String> admin);
	
}

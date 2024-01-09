package kr.co.waglewagle.admins.service;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.waglewagle.admins.mapper.LoginMapper;
import kr.co.waglewagle.domain.AdminsVO;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private LoginMapper mapper;
	
	@Override
	public AdminsVO adminInfo(String admins_email) {
		return mapper.adminInfo(admins_email);
	}

	//비밀번호 변경
	@Override
	public boolean changePwd(Map<String, String> admin) {
		
		String pwd = admin.get("admins_pwd");
		//암호화 비밀번호 변경
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodePwd = encoder.encode(pwd);
		
		admin.put("admins_pwd", encodePwd);
		
		return mapper.changePwd(admin) > 0 ? true:false;
	}

}

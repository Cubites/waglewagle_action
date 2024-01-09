package kr.co.waglewagle.admins.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.waglewagle.admins.mapper.UserManageMapper;
import kr.co.waglewagle.domain.UsersVO;


@Service
public class UserManageServiceImpl implements UserManageService {

	@Autowired
	private UserManageMapper mapper;

	@Override
	public List<UsersVO> userList() {
		return mapper.userList();
	}

	@Override
	public int usersAccess(Map<String, Integer> usersInfo) {
		return mapper.usersAccess(usersInfo);
	}


	@Override
	public List<UsersVO> adminUsersList(UsersVO param) {
		return mapper.adminUsersList(param);
	}

	@Override
	public int count(UsersVO param) {
		return mapper.count(param);
	}



	
	


	
}

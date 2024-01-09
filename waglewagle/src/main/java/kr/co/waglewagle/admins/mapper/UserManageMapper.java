package kr.co.waglewagle.admins.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.UsersVO;


@Mapper
public interface UserManageMapper {
	List<UsersVO> userList();
	int usersAccess(Map<String,Integer> usersInfo); 
	int count(UsersVO param);
	List<UsersVO> adminUsersList(UsersVO param);

}

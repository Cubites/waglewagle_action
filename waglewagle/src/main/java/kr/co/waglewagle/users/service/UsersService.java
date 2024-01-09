package kr.co.waglewagle.users.service;

import java.util.List;
import java.util.Map;

import kr.co.waglewagle.domain.CategoryVO;
import kr.co.waglewagle.domain.PointVO;
import kr.co.waglewagle.domain.QnasVO;
import kr.co.waglewagle.domain.UsersVO;

public interface UsersService {
	UsersVO userInfo(Integer users_id);
	PointVO getPoint(Integer users_id);

	boolean join(UsersVO vo);
	int selectUsersId(String users_email);
	boolean createPoint(int users_id);
	boolean isEmailDup(String users_email);
	boolean isNickDup(String users_nick);
	UsersVO login(UsersVO vo);
	UsersVO findId(Map<String, String> user_info);
	UsersVO findPwd(Map<String, String> user_info);
	boolean changePwd(Map<String, String> user_info);
	
	int relCalculate(Integer users_id);
	int relUpdate(Map<String, Integer> dataForRelUpdate);

	PointVO checkPoint(Integer users_id);
	String checkFavorAreas(Integer users_id);
	int updateAreas(Map<String, Object> dataForAreaUpdate);
	String selectPwd(Integer users_id);
	int pwdChange(Map<String, Object> dataForValidPwd);
	int countQnas(Integer users_id);
	List<QnasVO> checkQnas(Map<String, Integer> dataForCheckQnas);
	
	int deleteAccount(Integer users_id);

	int readQna(Integer qnas_id);
	
	int updateProfile(Map<String, Object> dataForUpdateProfile);
}

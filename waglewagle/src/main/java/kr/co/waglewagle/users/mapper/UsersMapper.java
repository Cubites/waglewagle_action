package kr.co.waglewagle.users.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.CategoryVO;
import kr.co.waglewagle.domain.PointVO;
import kr.co.waglewagle.domain.QnasVO;
import kr.co.waglewagle.domain.UsersVO;

@Mapper
public interface UsersMapper {
	UsersVO userInfo(Integer users_id);
	
	PointVO selectPointByUsersId(Integer users_id);
	
	int join(UsersVO vo);
	int selectUsersId(String users_email);
	int createPoint(int users_id);
	int isEmailDup(String users_email);
	int isNickDup(String users_nick);
	UsersVO login(UsersVO vo);
	UsersVO findId(Map<String, String> user_info);
	UsersVO findPwd(Map<String, String> user_info);
	int changePwd(Map<String, String> user_info);
	
	Integer relCalculate(Integer users_id);
	int relUpdate(Map<String, Integer> dataForRelUpdate);

	PointVO checkPoint(Integer users_id); // 포인트 조회
	String checkFavorAreas(Integer users_id); // 관심지역 조회
	int updateAreas(Map<String, Object> dataForAreaUpdate); // 관심지역 수정
	String selectPwd(Integer users_id); // 비민번호 조회
	int pwdChange(Map<String, Object> dataForValidPwd); // 비밀번호 변경
	int countQnas(Integer users_id); // 문의내역 갯수
	List<QnasVO> checkQnas(Map<String, Integer> dataForCheckQnas); // 문의내역 조회
	
	int deleteAccount(Integer users_id); // 회원탈퇴

	int readQna(Integer qnas_id);
	
	int updateProfile(Map<String, Object> dataForUpdateProfile);
}

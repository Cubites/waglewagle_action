package kr.co.waglewagle.admins.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.NoticesVO;

@Mapper
public interface NoticeMapper {	
//	List<NoticesVO> noticeList(); //리스트
	void Noticewrite(NoticesVO vo); //공지작성
	Object Noticeview(int notices_id); //공지확인
 	NoticesVO detail(int notices_id); //공지 확인
	int Noticedelete(int notices_id); //공지 삭제하기 
	int NoticeModifyUpdate(NoticesVO vo); //공지수정
	
	//추가( 페이징 )
	int count(NoticesVO param);
	List<NoticesVO> noticeList(NoticesVO param);

}

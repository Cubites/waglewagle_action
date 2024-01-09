package kr.co.waglewagle.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.NoticesVO;

@Mapper
public interface UsernoticesMapper {	
	void Noticewrite(NoticesVO vo);
	Object Noticeview(int notices_id);
	NoticesVO detail(int notices_id);
	int Noticedelete(int notices_id); //공지 삭제하기 
}

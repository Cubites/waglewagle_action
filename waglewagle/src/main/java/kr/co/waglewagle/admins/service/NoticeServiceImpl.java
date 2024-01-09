package kr.co.waglewagle.admins.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.waglewagle.admins.mapper.NoticeMapper;
import kr.co.waglewagle.domain.NoticesVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeMapper mapper;

	
	// 게시글 수
	@Override
	public int count(NoticesVO param) { 
		return mapper.count(param); 
	}
	
	//검색
	@Override
	public List<NoticesVO> noticeList(NoticesVO param) {
		return mapper.noticeList(param); // 목록;
	}

	//공지 글 등록하기
	@Override
	public void Noticewrite(NoticesVO vo,HttpServletRequest request) {
		mapper.Noticewrite(vo);
	}
		
	//공지 삭제하기
	@Override
	public void Noticedelete(int notices_id) {
		//System.out.println("====>"+notices_id);
		mapper.Noticedelete(notices_id);
	}


	//공지 상세보기
	@Override
	public NoticesVO Noticeview(int notices_id) {
		return mapper.detail(notices_id);
	}

	//공지확인
	@Override
	public Object Noticeview(NoticesVO vo, boolean b) {
		return null;
	}
	
	//공지수정
	@Override
	public NoticesVO Noticemodify(int notices_id) {
		return mapper.detail(notices_id);
	}

	//공지 수정 업로드
	@Override
	public int NoticeModifyUpdate(NoticesVO vo, HttpServletRequest request) {
		int r = mapper.NoticeModifyUpdate(vo);
		return r;
	}

}

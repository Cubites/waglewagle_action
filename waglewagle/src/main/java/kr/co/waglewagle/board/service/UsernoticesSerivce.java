package kr.co.waglewagle.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import kr.co.waglewagle.domain.NoticesVO;

public interface UsernoticesSerivce {
	public Object list(NoticesVO vo);
	public NoticesVO Noticeview(int notices_id);
	public Object Noticeview(NoticesVO vo, boolean b);
}

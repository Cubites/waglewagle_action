package kr.co.waglewagle.boards.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.waglewagle.boards.service.BoardsService;
import kr.co.waglewagle.domain.QnasVO;
import kr.co.waglewagle.domain.UsersVO;
import kr.co.waglewagle.users.service.UsersService;

@Controller
public class BoardsController {

	@Autowired
	private BoardsService service;
	
	@Autowired
	private UsersService usersService;

	// 문의 작성 페이지로 이동
	@GetMapping("/boards/qnas/write")
	public String wrtieQnas(Model model) {
		return "qna/main";
	}
	
	// 문의 작성
	@ResponseBody
	@PostMapping("/boards/qnas/write")
	public boolean addQna(HttpSession sess, @RequestBody Map<String, String> qnaContents) {
		UsersVO usersVO = (UsersVO) sess.getAttribute("users_info");
		QnasVO qnasVO = new QnasVO();
		qnasVO.setQnas_title(qnaContents.get("title"));
		qnasVO.setQnas_content(qnaContents.get("content"));
		qnasVO.setUsers_id(usersVO.getUsers_id());
		
		return service.addQna(qnasVO) == 1 ? true : false;
	}
	
	// 마이페이지 - 문의내역 상세 페이지 이동
	@GetMapping("/mypage/qnas/detail")
	public String mypageQnasDetail(Model model, Integer id) {
		model.addAttribute("menuTab", 1);
		model.addAttribute("menuNum", 3);
		model.addAttribute("qnaDetail", service.showQnaDetail(id));
		
		int updateReadcnt = usersService.readQna(id);
		return "mypage/main";
	}
}

package kr.co.waglewagle.admins.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.waglewagle.admins.service.AdminsService;
import kr.co.waglewagle.domain.AdminsVO;

@Controller
public class AdminsController {

	@Autowired
	private AdminsService service;
	
	// 관리자 계정 목록 페이지 이동(조회 및 검색 포함)
	@GetMapping("/admin/adminmanage")
	public String index(Model model, String searchWord, Integer page, Integer scroll) {

		int itemsNumPerPage = 10;
		int totalAuctionsNum = 0;
		totalAuctionsNum = service.countAdmins(searchWord);
		totalAuctionsNum = (int) Math.ceil(((double)totalAuctionsNum) / itemsNumPerPage);
		int nowPage1 = 0;
		int nowPage10 = 0;
		
		// 거래중 게시글 조회에 필요한 값(유저 id, 페이지 번호) 저장
		Map<String, Object> dataForSearch = new HashMap<>();
		if(page == null || page > totalAuctionsNum) {
			dataForSearch.put("start_page", 0);
			nowPage1 = 1;
			nowPage10 = 0;
		} else {
			dataForSearch.put("start_page", (page-1)*itemsNumPerPage);
			nowPage1 = page;
			nowPage10 = ((int)(page-1)/10) * 10;
		}
		// 글 목록, 메뉴 index 저장
		dataForSearch.put("searchWord", searchWord);
		model.addAttribute("ListData", service.showAdmins(dataForSearch));
		
		// 페이지 번호
		model.addAttribute("pageNum1", nowPage1);
		model.addAttribute("pageNum10", nowPage10);
		model.addAttribute("pageNumMax", totalAuctionsNum);
		
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("scrollY", scroll);
		return "admin/adminmanage";
	}
	
	// 관리자 계정 삭제
	@ResponseBody
	@PostMapping("/admin/delete/admin_account")
	public boolean deleteAdminAccount(HttpSession sess, @RequestBody Map<String, Integer> dataForDeleteAdmin) {
		AdminsVO vo = (AdminsVO) sess.getAttribute("admin_info");
		if(vo != null && vo.getAdmins_role() == 0 && dataForDeleteAdmin.get("admins_id") != 1) {	
			return service.deleteAdmin(dataForDeleteAdmin.get("admins_id")) == 1 ? true : false;
		} else {
			return false;
		}
	}
}
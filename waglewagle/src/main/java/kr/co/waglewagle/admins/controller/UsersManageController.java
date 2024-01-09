package kr.co.waglewagle.admins.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.waglewagle.admins.service.UserManageService;
import kr.co.waglewagle.domain.NoticesVO;
import kr.co.waglewagle.domain.UsersVO;

@Controller
public class UsersManageController {
	@Autowired
	private UserManageService service;

	
	@GetMapping("/admin/userManageList")
	public String userList(Model model,UsersVO vo) {
		int count = service.count(vo); // 총개수
        // 총페이지수
        int totalPage = count / 10;
        if (count % 10 > 0) totalPage++;
        
        List<UsersVO> list = service.adminUsersList(vo);
        
        // 하단에 페이징처리
        int endPage = (int)(Math.ceil(vo.getPage()/10.0)*10);
        int startPage = endPage - 9;
        if (endPage > totalPage) endPage = totalPage;
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;
        System.out.println(startPage);
        System.out.println(endPage);
        System.out.println(totalPage);
        
        // model에 담음(페이징 정보)
        model.addAttribute("endPage", endPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("prev", prev);
        model.addAttribute("next", next);
        
		// model에 담음(공지 정보)
		model.addAttribute("list",list);
		return "/admin/userManageList";
	}

	
	@ResponseBody 
	@PostMapping("/admin/usersStatus")
	public Integer userStatus(Model model,@RequestBody Map<String,Integer> status) {
		int a = service.usersAccess(status);
		return a==1 ? status.get("users_status") : (status.get("users_status")==0 ? 1:0);
	}	
	
	
	
	
	
	
}
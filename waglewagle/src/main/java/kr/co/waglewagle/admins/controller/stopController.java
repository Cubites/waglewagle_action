package kr.co.waglewagle.admins.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.waglewagle.domain.NoticesVO;

@Controller
public class stopController {

	@GetMapping("/admin/stop")
	public String index(Model model,NoticesVO vo) {
		return "/admin/stop";
	}
	
	
	
}
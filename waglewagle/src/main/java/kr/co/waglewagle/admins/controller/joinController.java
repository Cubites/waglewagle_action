package kr.co.waglewagle.admins.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.waglewagle.admins.service.JoinService;
import kr.co.waglewagle.domain.AdminsVO;
//import kr.co.waglewagle.admins.service.ReplyService;
import kr.co.waglewagle.domain.NoticesVO;

@Controller
public class joinController {

	@Autowired
	private JoinService service;
	
	@GetMapping("/admin/join")
	public String index() {
		return "admin/join";
	}
	
	// 아이디(이메일) 중복 체크
	@ResponseBody
	@PostMapping("/admin/check/duplication")
	public boolean checkIdDuplicated(@RequestBody Map<String, String> dataForIdDuplicationCheck) {
		if("".equals(dataForIdDuplicationCheck.get("admins_email")) || dataForIdDuplicationCheck.get("admins_email") == null) {
			return false;
		}
		return service.checkDuplicationId(dataForIdDuplicationCheck.get("admins_email")) > 0 ? false : true;
	}
	
	@ResponseBody
	@PostMapping("/admin/add/admin_account")
	public boolean addAdmin(@RequestBody AdminsVO vo) {
		
		return service.addAdminAccount(vo) == 1 ? true : false;
	}
	
}
package kr.co.waglewagle.admins.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.waglewagle.admins.service.LoginService;
import kr.co.waglewagle.domain.AdminsVO;


@Controller
public class LoginController {
	
	@Autowired
	private LoginService service;
	
	//관리자로그인
	@GetMapping("/admin/login")
	public String loginForm() {
		return "admin/login";
	}
	
	//로그인
	@PostMapping("/admin/login")
	public String login(HttpSession session,Model model,String admins_email,String admins_pwd,HttpServletRequest request) {
		
		AdminsVO loginAdminsVO = service.adminInfo(admins_email);
		boolean isValid = false;
		
		if(loginAdminsVO != null)  {//회원 정보가 존재하지 않음
			isValid = BCrypt.checkpw(admins_pwd,loginAdminsVO.getAdmins_pwd());
			System.out.println(isValid);
			if(isValid) {//로그인 성공!
				session.setAttribute("admin_info", loginAdminsVO);
				AdminsVO vo = (AdminsVO) session.getAttribute("admin_info");
				System.out.println(vo.getAdmins_email());
				return "redirect:/admin/stats";
			}
		}
		return "/admin/login";
	}

	
	
	//관리자 비밀번호 변경
	@GetMapping("/admin/changePwd")
	public String changePwd() {
		return "admin/changePwd";
	}
	
	//비밀번호 변경
	@PostMapping("/admin/changePwd")
	public String changePwdProcess(Model model, String admins_pwd, HttpSession session,HttpServletRequest request) {
		AdminsVO vo = (AdminsVO) session.getAttribute("admin_info");
		System.out.println(vo.getAdmins_email());
		Map<String, String> admin = new HashMap<String, String>();
		admin.put("admins_pwd", admins_pwd);
		admin.put("admins_id",vo.getAdmins_id().toString());
		boolean pwdChange = service.changePwd(admin);
		
		if(pwdChange) {
			return "redirect:/admin/login";
		}
		return "/admin/changePwd";
		
	}
	
}
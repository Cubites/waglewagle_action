package kr.co.waglewagle.payment.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.co.waglewagle.domain.PaylogVO;
import kr.co.waglewagle.domain.UsersVO;
import kr.co.waglewagle.payment.service.PaymentService;

@Controller
public class PaymentController {

	@Autowired
	private PaymentService service;

	// 포인트 충전 페이지로 이동
	@GetMapping("/payment")
	public String goPayment() {
		return "payment/payment";
	}
	
	// 포인트 충전
	@PostMapping("/payment")
	@ResponseBody
	public String savePayment(@SessionAttribute("users_info") UsersVO loginUser, HttpServletRequest request) {
		PaylogVO vo = new PaylogVO();
		vo.setUsers_id(loginUser.getUsers_id());
		vo.setPaylog_cash(Integer.parseInt(request.getParameter("paylog_cash")));
		vo.setPaylog_type(request.getParameter("paylog_type"));
		// 결제와 포인트 변경까지 온전히 실행됐는지 확인
		boolean result = service.savePayment(vo);
		if (result) {
			return "/payment";
		} else {
			return "";
		}
	}

}

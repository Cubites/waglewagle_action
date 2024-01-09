package kr.co.waglewagle.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.waglewagle.auctions.service.AuctionsService;
import kr.co.waglewagle.domain.UsersVO;
import kr.co.waglewagle.users.service.UsersService;

@Component
public class MypageInterceptor implements HandlerInterceptor {
	
	@Autowired
	private UsersService service;
	
	@Autowired
	private AuctionsService auctionsService;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		UsersVO vo = (UsersVO) req.getSession().getAttribute("users_info");
		
		req.setAttribute("pointInfo", service.checkPoint(vo.getUsers_id()));
		req.setAttribute("countAuctions", auctionsService.countAllAuctions(vo.getUsers_id()));
		return true;
	}

}
package kr.co.waglewagle.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import kr.co.waglewagle.domain.UsersVO;
import kr.co.waglewagle.users.service.UsersService;

@Component
public class RelCaculateInterceptor implements HandlerInterceptor {
	
	@Autowired
	private UsersService service;
	
	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView mv) throws Exception {
		service.relCalculate(Integer.parseInt(req.getAttribute("user1") + ""));
		if(req.getAttribute("user2") != null) {
			service.relCalculate(Integer.parseInt(req.getAttribute("user2") + ""));
		}
	}
}

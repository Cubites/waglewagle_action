package kr.co.waglewagle.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.waglewagle.domain.UsersVO;
import kr.co.waglewagle.users.service.UsersService;

@Component
public class ReloadSessionInterceptor implements HandlerInterceptor {
	
	@Autowired
	private UsersService service;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		UsersVO vo = (UsersVO) req.getSession().getAttribute("users_info");
		if(vo != null) {
			req.getSession().setAttribute("users_info", service.userInfo(vo.getUsers_id()));
		}
		return true;
	}

}
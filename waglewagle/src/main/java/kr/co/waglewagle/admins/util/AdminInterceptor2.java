package kr.co.waglewagle.admins.util;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;


import kr.co.waglewagle.domain.AdminsVO;

@Component
public class AdminInterceptor2 implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		//false -> 되돌아 가게 함 , true -> 가던길 가게 함
		HttpSession sess = request.getSession();
		AdminsVO admin = (AdminsVO)sess.getAttribute("admin_info");
		
		if(admin==null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script>");
			writer.print("location.href='/error/notFound404';");
			writer.print("</script>");
		
		}
		return true;
	}
		
}

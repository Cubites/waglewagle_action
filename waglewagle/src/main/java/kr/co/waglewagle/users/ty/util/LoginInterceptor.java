package kr.co.waglewagle.users.ty.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.mysql.cj.Session;

import kr.co.waglewagle.domain.UsersVO;

@Component
public class LoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		//false -> 되돌아 가게 함 , true -> 가던길 가게 함
		HttpSession sess = request.getSession();
		UsersVO login = (UsersVO)sess.getAttribute("users_info");
		if(login == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.print("<script>");
			writer.print("alert('로그인이 필요한 페이지입니다.');");
			writer.print("location.href='/users/login';");
			writer.print("</script>");
			
			return false;
		}
		
		return true;
	}

}

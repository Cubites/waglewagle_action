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
public class AdminInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {


		//false -> 되돌아 가게 함 , true -> 가던길 가게 함
		HttpSession sess = request.getSession();
		AdminsVO admin = (AdminsVO)sess.getAttribute("admin_info");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		
		Map<String, Integer> adminGrade = new HashMap<String, Integer>();
		adminGrade.put("/admin/noticelist",2);
		adminGrade.put("/admin/noticewrite", 2);
		adminGrade.put("/admin/noticedelete",2);
		adminGrade.put("/admin/noticeModify",2);
		adminGrade.put("/admin/noticemodify",2);
		
		adminGrade.put("/admin/qnalist", 2);
		adminGrade.put("/admin/delReply",2);
		adminGrade.put("/admin/writeReply",2);
		adminGrade.put("/admin/modifyReply",2);
		adminGrade.put("/admin/qnaDelete",2);
		
		adminGrade.put("/admin/stats", 2);
		adminGrade.put("/admin/changePwd", 2);
		
		adminGrade.put("/admin/goodsManageList", 1);
		adminGrade.put("/admin/userManageList", 1);
		adminGrade.put("/admin/adminmanage", 0);
		adminGrade.put("/admin/join", 0);
		adminGrade.put("/admin/delete/admin_account",0);
		

		boolean result = false;
		
		if(admin == null) {
			writer.print("<script>");
			writer.print("location.href='/admin/stop';");
			writer.print("</script>");
			result = false;
			
		}else {
			String[] paths = request.getRequestURI().split("/");
			String path = "";
			for (int i=1; i<paths.length; i++) {
				path = path + "/" + paths[i];
				if (i == 2) break;
			}
			System.out.println("path:"+path);
			if(admin.getAdmins_role() <= adminGrade.get(path)) {
				result=true;
			}else {
				writer.print("<script>");
				writer.print("location.href='/admin/stop';");
				writer.print("</script>");
				result=false;
			}
		}
		return result;
	}

}

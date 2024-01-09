package kr.co.waglewagle.admins.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.waglewagle.admins.service.GoodsManageService;
import kr.co.waglewagle.domain.GoodsVO;
import kr.co.waglewagle.goods.service.GoodsService;


@Controller
public class GoodsManageController{
	@Autowired
	private GoodsManageService service;
	@Autowired
	private GoodsService goodsService;


	//검색 + 페이징
	@GetMapping("/admin/goodsManageList")
	public String adminGoodsList(Model model,GoodsVO vo) {
		Map<String, Object> list = service.adminGoodsList(vo);
		model.addAttribute("list",list);
		return "/admin/goodsManageList";
	}

	//ajax이용 상태 변경
	@ResponseBody
	@PostMapping("/admin/goodsStatus")
	public Integer goodsStatus(@RequestBody Map<String, Integer> status ,Model model, HttpServletRequest req) {
		int a = service.goodsAccess(status);
		
		// 친밀도 업데이트를 위한 값(업데이트 대상 유저 id)을 인터셉터에 전달
		GoodsVO vo = goodsService.getGoods(status.get("goods_id"));
		req.setAttribute("user1", Integer.toString(vo.getUsers_id()));
		
		return a==1 ? status.get("goods_access") :(status.get("goods_access")==0 ? 1:0 );
	}
}
package kr.co.waglewagle.admins.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.waglewagle.admins.service.StatsService;

@Controller
public class statsController {

	@Autowired
	private StatsService service;
	
	@GetMapping("/admin/stats")
	public String index(Model model) throws Exception {
		var om = new ObjectMapper();
		List<Map<String, Object>> cgc = service.countGoodsByCategory();
		List<Map<String, Object>> cgfc = service.countGoodsFailByCategory();
		List<Map<String, Object>> cbc = service.countBidsByCategory();
		
		List<Map<String, Object>> cgca = service.countGoodsByCategoryAll();
		List<Map<String, Object>> cbca = service.countBidsByCategoryAll();
		
		List<Map<String, Object>> cuml = service.countUsersByMonthLatestYear();
		
		List<Map<String, Object>> cug = service.countUsersGender();
		
		model.addAttribute("goods_category", om.writeValueAsString(cgc));
		model.addAttribute("goods_fail_category", om.writeValueAsString(cgfc));
		model.addAttribute("bids_category", om.writeValueAsString(cbc));
		
		model.addAttribute("goods_category_all", om.writeValueAsString(cgca));
		model.addAttribute("bids_category_all", om.writeValueAsString(cbca));

		model.addAttribute("users_month_latestyear", om.writeValueAsString(cuml));
		
		model.addAttribute("users_gender", om.writeValueAsString(cug));
		return "admin/stats";
	}
	
}
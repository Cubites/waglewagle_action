package kr.co.waglewagle.reports.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.waglewagle.auctions.won.AuctionIng;
import kr.co.waglewagle.domain.GoodsVO;
import kr.co.waglewagle.domain.ReportsVO;
import kr.co.waglewagle.domain.UsersVO;
import kr.co.waglewagle.goods.service.GoodsService;
import kr.co.waglewagle.reports.service.ReportsService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReportsController {

	@Autowired
	private ReportsService service;
	@Autowired
	private GoodsService goodsService;

	// 신고글과 신고 상품 받음
	@GetMapping("/report/{goods_id}/{users_id}")
	public String reportPage(@PathVariable("goods_id") Integer goods_id, @PathVariable("users_id") Integer users_id,
			Model model, RedirectAttributes rs) {

		// 신고상품정보 찾아옴
		GoodsVO reportedGoods = goodsService.getGoods(goods_id);

		// 만약 자신의 글에 신고하는거면 막음
		if (reportedGoods.getUsers_id() == users_id) {
			rs.addFlashAttribute("rejectmsg", "본인이 올린 글은 신고할 수 없습니다.");
			rs.addAttribute("goods_id", reportedGoods.getGoods_id());
			return "redirect:/goods/{goods_id}";
		}

		// redirect하면서 goods정보 가지고감
		model.addAttribute("goods",  goodsService.getGoods(goods_id));
	
		return "/report/reportForm";
	}



	@PostMapping("/report/goods")
	public String report(@ModelAttribute ReportsVO report, Model model,
			@SessionAttribute("users_info") UsersVO loginUser) {
		
		
		String resultMessage = "신고 등록에 성공했습니다.";
		log.info("report post ReportsVO {}", report);
		
		if (report.getReports_type() == 0) {

			try {
				boolean result = service.reportUser(report, loginUser.getUsers_id());
				model.addAttribute("path", "/");
			} catch (Exception e) {
				//트랜잭션 과정에서 오류 발생시 나오는 메시지
				resultMessage = "신고등록에 실패했습니다. 잠시후 다시 시도해주세요";
				model.addAttribute("path", "/chat/"+report.getGoods_id());
			}

		} else {

			boolean result = service.reportGoods(report);
			
		}
		
		model.addAttribute("result", resultMessage);
		model.addAttribute("goods_id", report.getGoods_id());
		return "/report/reportForm";
	}

	

	
		@GetMapping("/report/user/{users_id}/{myid}/{reports_type}/{goods_id}")
		public String reportUser(@PathVariable Integer users_id
				,@AuctionIng Integer goods_id
				,@PathVariable Integer reports_type
				,@PathVariable Integer myid
				,@SessionAttribute(name = "users_info") UsersVO loginUser
				,Model model) {
			
			
			//auctions_ing에 없는 goods면 신고 못함 
			if(goods_id == null) {
				return "redirect:/";
			}
			//상대방이 신고하러오거나, 거래자가 아닌 사람이 신고하러 오는 것 막기
			if(loginUser.getUsers_id().equals(users_id) || !loginUser.getUsers_id().equals(myid)) {
				return "redirect:/";
			}
			
			ReportsVO report = new ReportsVO();
			report.setGoods_id(goods_id);
			report.setUsers_id(users_id);
			report.setReports_type(reports_type);	
			model.addAttribute("report", report);
		
			return "/report/reportForm";
		}
}

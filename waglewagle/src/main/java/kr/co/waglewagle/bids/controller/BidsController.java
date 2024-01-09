package kr.co.waglewagle.bids.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.server.reactive.HttpHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.co.waglewagle.bids.service.BidsService;
import kr.co.waglewagle.bids.won.BidsException;
import kr.co.waglewagle.bids.won.BidsFormVO;
import kr.co.waglewagle.bids.won.BidsMsg;
import kr.co.waglewagle.domain.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BidsController {

	@Autowired
	private BidsService service;
	
	
	@PostMapping("/bids/askPrice")
	@ResponseBody
	public ResponseEntity<String> askPrice(@Validated BidsFormVO vo, BindingResult rs, @SessionAttribute("users_info") UsersVO loginuser ) {
			
		ResponseEntity<String> response;
		HttpHeaders headers = new HttpHeaders();
		headers.add("content-type", "text/plain;charset=UTF-8");
		boolean result;
		
		BidsMsg msgs = BidsMsg.MSG1;
		
		//------------오류 검사 코드 
		
		
		//자신의 글에 호가 
		if(vo.getUsers_id().equals(loginuser.getUsers_id())) {
			
			rs.rejectValue("users_id", null,null,"자신이 올린 글에는 호가 불가함");
			msgs = BidsMsg.gethighPriorityMsg(msgs, BidsMsg.MSG2);
			
		}
		//오류 가 없다면, 호가 vo에 id를 세션id로 교체 
		vo.setUsers_id(loginuser.getUsers_id());
		
		//가용 포인트 검사
		if(vo.getPoint_usable()-vo.getBids_price() <0) {
			rs.reject("pointError", "가용 포인트 부족");
			msgs = BidsMsg.gethighPriorityMsg(msgs, BidsMsg.MSG3);
		}
		//시작 가격보다 작은 호가 금액 검사
		if(vo.getGoods_start_price() > vo.getBids_price()) {
			rs.reject("error","시작가격보다 작은 금액 호가");
			msgs = BidsMsg.gethighPriorityMsg(msgs, BidsMsg.MSG4);
		}
		
		
		// 첫호가 최대호가 검사 
		Integer bidsCheck = service.bidsCheck(vo);
		
		if(bidsCheck == null) {
			rs.reject("호가오류","호가오류");
			msgs = BidsMsg.gethighPriorityMsg(msgs, BidsMsg.MSG5);
		}
		// 오류 발생시 다시 이전페이지로 돌려보냄
		if(rs.hasErrors()) {
			
			
			response = new ResponseEntity<String>(msgs.getMsg(),headers,HttpStatus.BAD_REQUEST);
			return response;
		}
		
		// ------------여기까지 
		
		//오류 검사 후 정상 로직 

		
		try {
			
			result = service.askPrice(vo,bidsCheck);
		} catch (BidsException e) {
			msgs = BidsMsg.gethighPriorityMsg(msgs, BidsMsg.MSG6);
			response = new ResponseEntity<String>("알 수 없는 오류로 호가등록에 실패했습니다. 잠시후 다시 시도해 주세요",headers,HttpStatus.BAD_REQUEST);
			return response;
		}

		response = new ResponseEntity<String>("호가 등록에 성공했습니다.",headers,HttpStatus.ACCEPTED);
		
		
		
		return response;
	}
}

package kr.co.waglewagle.reports.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.waglewagle.auctions.mapper.AuctionsMapper;
import kr.co.waglewagle.domain.ReportsVO;
import kr.co.waglewagle.reports.mapper.ReportsMapper;

@Service
public class ReportsServiceImpl implements ReportsService {
	
	@Autowired
	private ReportsMapper mapper;
	@Autowired
	private AuctionsMapper auctionsMapper;
	@Override
	public boolean reportGoods(ReportsVO report) {
		Integer result = mapper.insertReport(report);
		return result > 0 ? true:false ;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor = Exception.class)
	public boolean reportUser(ReportsVO report,Integer userId) throws Exception {
		
		
			
			//report에 값 넣기 
		 Integer reportResult = mapper.insertReport(report);
		
		 Map<String,Object> paramMap = getParamMap(report,userId);
		
		 //auctions_break 테이블에 넣기 값 넣기
		 Integer breakResult= auctionsMapper.insertAuctionsBreak(paramMap);
		
		 //돈 환불해주기 정확하지 않아서 일단 막아둠
		Integer breakRefundResult = auctionsMapper.updateBreakRefund(paramMap);
	
		 //auctions_ing테이블에서 삭제하기 일단 막아둠
		 Integer deleteResult = auctionsMapper.deleteAuctionIng(paramMap);
		
		 	if(reportResult == 0 || breakResult == 0 
		 			|| breakRefundResult == 0 || deleteResult == 0) {
		 		
		 		throw new Exception("과정 중 하나 이상 문제 발생으로 롤백");
		 	}
		 
		 return true;
	}
	
	private Map<String,Object> getParamMap(ReportsVO report,Integer userId) {
		 String[] reportTypeAndContent = report.getReports_content().split("-");
		 Integer reportReason = Integer.parseInt(reportTypeAndContent[0]);
		 String reportContent = reportTypeAndContent[1];
		 Map<String, Object> map = new ConcurrentHashMap<>();
		 map.put("breakReason", reportReason);
		 map.put("breakDetail", reportContent);
		 map.put("goods_id", report.getGoods_id());
		 map.put("userId", report.getUsers_id());
		 map.put("refoundUserId", userId);
		 return map;
	}
	
}

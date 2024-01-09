package kr.co.waglewagle.goods.won;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.co.waglewagle.auctions.service.AuctionsService;
import kr.co.waglewagle.domain.GoodsVO;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ScheduledLogicForGoodsAndAuctionsIng {
	
	@Autowired
	AuctionsService auctionService;
	//자정마다 실행되도록 지정
	//@Scheduled(cron="0 0 0 * * *")
	@Scheduled(cron="0 0 0 * * *")
	public void goodscheck() {
		
		
		/* goods_id, users_id, goods_exp, goods_date -> targetGoods는 auctions들에 포함 안된 goods들*/
		List<GoodsVO> targetGoods = auctionService.getTargetGoods();
		log.info("targetGoods = {}",targetGoods);
		if(targetGoods.size() >0) {
		try {
			boolean goodsToAuctionsIngResult = auctionService.goodsToAuctionsIng(targetGoods);
			boolean goodsTofailResult = auctionService.goodsToAuctionsFail(targetGoods);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		}
	}
	
	@Scheduled(cron="0 0 0 * * *")
	public void autionsIngCheck() {
		
		//auctions_ing중에 auctions_ing 데이트 +7 자동으로 거래 완료 
		//1번 auctions_ing+ 7일 된거 뽑기
		List<Map<String,Object>> paramMap =  auctionService.getGoodsIngDateExpired();
		if(paramMap.size() >0 ) {
			paramMap.stream().forEach((param)->{
				try {
					auctionService.auctionEnd(param);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
		}
	}
}

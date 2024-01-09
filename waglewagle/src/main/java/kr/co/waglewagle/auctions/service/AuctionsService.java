package kr.co.waglewagle.auctions.service;

import java.util.List;
import java.util.Map;

import kr.co.waglewagle.domain.AuctionsIngVO;
import kr.co.waglewagle.domain.GoodsVO;
import kr.co.waglewagle.util.hcju.SomeoneAuctionsBreakVO;
import kr.co.waglewagle.util.hcju.SomeoneAuctionsEndVO;
import kr.co.waglewagle.util.hcju.SomeoneAuctionsIngVO;
import kr.co.waglewagle.util.hcju.SomeoneAuctionsVO;
import kr.co.waglewagle.util.hcju.SomeoneFavorsVO;
import kr.co.waglewagle.domain.ReportsVO;

public interface AuctionsService {
	Map<String, Integer> countAllAuctions(Integer users_id);

	Integer countAuctions(Integer users_id);

	List<SomeoneAuctionsVO> checkAuctions(Map<String, Integer> auctionsVal);

	Integer countAuctionsIng(Integer users_id);

	List<SomeoneAuctionsIngVO> checkAuctionsIng(Map<String, Integer> auctionsIngVal);

	Integer countAuctionsEndSold(Integer users_id);

	List<SomeoneAuctionsEndVO> checkAuctionsEndSold(Map<String, Integer> auctionsIngVal);

	Integer countAuctionsEndBought(Integer users_id);

	List<SomeoneAuctionsEndVO> checkAuctionsEndBought(Map<String, Integer> auctionsIngVal);

	Integer countAuctionsBreak(Integer users_id);

	List<SomeoneAuctionsBreakVO> checkAuctionsBreak(Map<String, Integer> auctionsIngVal);

	Integer countAuctionsFail(Integer users_id);

	List<SomeoneAuctionsBreakVO> checkAuctionsFail(Map<String, Integer> auctionsIngVal);

	Integer countFavors(Integer users_id);

	List<SomeoneFavorsVO> checkFavors(Map<String, Integer> auctionsIngVal);


	

	boolean auctionEnd(Map<String, Object> paramMap) throws Exception;

	

  
	Map<String, String> getAuctionIngGoods(Integer users_id, Integer goods_id);
	void completeAuction(Integer goods_id);
	boolean saveReport(ReportsVO vo, Integer user_id);
	
	boolean updateAuctionIngView(Map<String, Object>me);

	

	List<GoodsVO> getTargetGoods();

	boolean goodsToAuctionsIng(List<GoodsVO> targetGoods) throws Exception;

	boolean goodsToAuctionsFail(List<GoodsVO> targetGoods);

	List<Map<String, Object>> getGoodsIngDateExpired();

}
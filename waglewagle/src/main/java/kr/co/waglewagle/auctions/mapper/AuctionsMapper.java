package kr.co.waglewagle.auctions.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.AuctionsBreakVO;
import kr.co.waglewagle.domain.AuctionsEndVO;
import kr.co.waglewagle.domain.AuctionsIngVO;
import kr.co.waglewagle.domain.GoodsVO;
import kr.co.waglewagle.util.hcju.SomeoneAuctionsBreakVO;
import kr.co.waglewagle.util.hcju.SomeoneAuctionsEndVO;
import kr.co.waglewagle.util.hcju.SomeoneAuctionsIngVO;
import kr.co.waglewagle.util.hcju.SomeoneAuctionsVO;
import kr.co.waglewagle.util.hcju.SomeoneFavorsVO;
import kr.co.waglewagle.domain.ReportsVO;

@Mapper
public interface AuctionsMapper {
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
  
	// 거래 중인 물품인지 확인하기
	int checkAuctionIng(Integer goods_id);
	// 거래 중 정보 가져오기
	Map<String, String> getAuctionIngInfo(Integer goods_id);
	// 거래 중 테이블에서 데이터 꺼내기
	AuctionsIngVO getAunctionIngData(Integer goods_id);
	// 경매 완료 테이블에 저장하기
	int saveAuctionEnd(AuctionsEndVO vo);
	// 거래 중 테이블에서 삭제하기
	int deleteAuctionIngData(Integer auctions_ing_id);
	// 판매자에게 돈 넣어주기
	int updateSellerPoint(AuctionsEndVO vo);
	// 구매자 총 포인트 빼기
	int updateBuyerPoint(AuctionsEndVO vo);
	// 신고된 물품인지 확인하기
	int checkReport(Integer goods_id);
	// 신고 접수하기
	int saveReport(ReportsVO vo);
	// 신고자에게 낙찰가 돌려주기
	int returnToBuyer(Map<String, Integer> backToBuyer);

	Integer checkgoodsInAuctionIng(Integer goods_id);
	
	//신고 받은 물품 break테이블에 넣기
	Integer insertAuctionsBreak(Map<String, Object> map);

	Integer updateBreakRefund(Map<String,Object> paramMap);

	Integer deleteAuctionIng(Map<String, Object> paramMap);

	Integer insertAuctionEnd(Map<String, Object> paramMap);

	// 거래 파기 테이블에 저장하기
	int saveAuctionBreak(AuctionsBreakVO vo);
	
	Integer updateAuctionIngView(Map<String, Object> map);

	List<GoodsVO> selectBalanceGoods();

	List<Map<String,Object>> selectBalnaceBids(List<GoodsVO> targetGoods);

	List<Map<String,Object>> selectfailGoods(List<GoodsVO> targetGoods);

	Integer insertAuctionIng(List<Map<String,Object>> targetGoods);

	Integer updateSubtractPoint(List<Map<String,Object>> targetGoods);

	Integer insertAuctionsFail(List<Map<String, Object>> failMap);

	List<Map<String,Object>> selectGoodsIngDateExpired();

	List<Map<String, Object>> selectGoodsBidsMax(List<GoodsVO> targetGoods);

	Integer updateAllUsablePoint(List<Map<String, Object>> bisMax);

}
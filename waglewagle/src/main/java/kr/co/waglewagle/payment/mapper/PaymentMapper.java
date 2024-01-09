package kr.co.waglewagle.payment.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.PaylogVO;
import kr.co.waglewagle.domain.PointVO;

@Mapper
public interface PaymentMapper {
	// 포인트 충전
	int savePayment(PaylogVO vo);
	// 포인트 변경
	int updateTotalPoint(PaylogVO vo);
	Integer updateSellerPoint(Map<String, Object> paramMap);
	Integer updateBuyerPoint(Map<String, Object> paramMap);
//	Integer deleteAuctionIng(Integer goods_id);
//	Integer insertAuctionEnd(Map<String, Integer> paramMap);
}

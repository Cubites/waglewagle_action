package kr.co.waglewagle.bids.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.bids.won.BidsFormVO;

@Mapper
public interface BidsMapper {

	Integer countBidsByGoodsId(int goodsId);

	Integer checkPoint(BidsFormVO vo);

	Integer insertBids(BidsFormVO vo);

	Integer updateUsablePoint(BidsFormVO vo);

	Integer checkInitial(BidsFormVO vo);

	Integer selectMaxBidsPriceByUsersId(Map userAndgoods);
	
	Integer updateAvgPrice(Integer goods_id);
	
}

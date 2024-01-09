package kr.co.waglewagle.bids.service;

import kr.co.waglewagle.bids.won.BidsException;
import kr.co.waglewagle.bids.won.BidsFormVO;

public interface BidsService {

	Integer getBidsCnt(int goodsId);

	boolean askPrice(BidsFormVO vo,Integer check) throws BidsException;

	Integer selectMaxBidsByUsersId(Integer users_id, Integer goodsId);

	Integer bidsCheck(BidsFormVO vo);
	
}

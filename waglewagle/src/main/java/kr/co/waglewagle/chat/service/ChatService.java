package kr.co.waglewagle.chat.service;

import java.util.List;
import java.util.Map;

import kr.co.waglewagle.domain.ChatVO;

public interface ChatService {

	List<Map<String,Object>> getAuctionInfoByGoodsId(Integer goodsId);

	List<ChatVO> getAllChat(Integer users_id, Integer goodsId);

	Integer saveChat(ChatVO chat);
	
	Integer readBid(Map<String, Integer> info);
}

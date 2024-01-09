package kr.co.waglewagle.chat.service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.ibatis.javassist.ClassMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.waglewagle.chat.mapper.ChatMapper;
import kr.co.waglewagle.domain.ChatVO;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatMapper mapper;

	@Override
	public List<Map<String, Object>> getAuctionInfoByGoodsId(Integer goodsId) {
		//userId seller, buyer 담긴 리스트	
		List<Map<String,Object>> mapList = mapper.selectAuctionIngAndUsers(goodsId);
			
		return mapList;
	}

	@Override
	public List<ChatVO> getAllChat(Integer userId, Integer goodsId) {
		Map<String, Integer> chatParam = new ConcurrentHashMap<>();
		chatParam.put("userId", userId);
		chatParam.put("goodsId", goodsId);
		return mapper.selectAllChat(chatParam);
	}

	@Override
	public Integer saveChat(ChatVO chat) {
		
		return mapper.insertChat(chat);
	}
	
	@Override
	public Integer readBid(Map<String, Integer> info) {
		return mapper.readBid(info);
	}

}

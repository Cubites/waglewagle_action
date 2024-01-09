package kr.co.waglewagle.chat.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.ChatVO;

@Mapper
public interface ChatMapper {

	List<Map<String, Object>> selectAuctionIngAndUsers(Integer goodsId);

	

	List<ChatVO> selectAllChat(Map<String, Integer> chatParam);



	Integer insertChat(ChatVO chat);
	
	Integer readBid(Map<String, Integer> info);
	
}

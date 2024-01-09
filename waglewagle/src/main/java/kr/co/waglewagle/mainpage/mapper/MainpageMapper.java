package kr.co.waglewagle.mainpage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.GoodsVO;

@Mapper
public interface MainpageMapper {
	List<GoodsVO> popularList();
	List<GoodsVO> newRegList();
	List<GoodsVO> nearList(List<String> users_addrList);
	int countUnread_bid(int users_id);
	int countUnread_qna(int users_id);
}

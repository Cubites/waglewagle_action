package kr.co.waglewagle.mainpage.service;

import java.util.List;

import kr.co.waglewagle.domain.GoodsVO;

public interface MainpageService {
	List<GoodsVO> popularList();
	List<GoodsVO> newRegList();
	List<GoodsVO> nearList(List<String> users_addrList);
	boolean isReadBidNotice(int users_id);
	boolean isReadQnaNotice(int users_id);
}

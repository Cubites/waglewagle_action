package kr.co.waglewagle.mainpage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.waglewagle.domain.GoodsVO;
import kr.co.waglewagle.mainpage.mapper.MainpageMapper;

@Service
public class MainpageServiceImpl implements MainpageService {

	@Autowired
	private MainpageMapper mapper;
	
	@Override
	public List<GoodsVO> popularList() {
		
		return mapper.popularList();
	}
	
	@Override
	public List<GoodsVO> newRegList(){
		return mapper.newRegList();
	}
	
	@Override
	public List<GoodsVO> nearList(List<String> users_addrList){
		return mapper.nearList(users_addrList);
	}

	@Override
	public boolean isReadBidNotice(int users_id) {
		return mapper.countUnread_bid(users_id) > 0 ? false : true;
	}
	
	@Override
	public boolean isReadQnaNotice(int users_id) {
		return mapper.countUnread_qna(users_id) > 0 ? false : true;
	}
}

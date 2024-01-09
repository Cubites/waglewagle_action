package kr.co.waglewagle.admins.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.waglewagle.admins.mapper.GoodsManageMapper;
import kr.co.waglewagle.domain.GoodsVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class GoodsManageServiceImpl implements GoodsManageService {

	@Autowired
	private GoodsManageMapper mapper;

	@Override
	public List<GoodsVO> goodsList() {
		return mapper.goodsList();
	}


	@Override
	public int goodsAccess(Map<String, Integer> goodsInfo) {
		return mapper.goodsAccess(goodsInfo);
	}


	@Override
	public Map<String, Object> adminGoodsList(GoodsVO vo) {
		int count = mapper.count(vo); // 총개수
		
        // 총페이지수
        int totalPage = count / 10;
        if (count % 10 > 0) totalPage++;
        
        List<Map<String, Object>> list = mapper.adminGoodsList(vo); // 목록
        
        log.info("list {}",list);
        
        Map<String, Object> map = new HashMap<>();
        map.put("count", count);
        map.put("totalPage", totalPage);
        map.put("list", list);
        
        // 하단에 페이징처리
        int endPage = (int)(Math.ceil(vo.getPage()/10.0))*10;
        int startPage = ((endPage-1)/10)*10+1;
        if (endPage > totalPage) endPage = totalPage;
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;
        
        map.put("endPage", endPage);
        map.put("startPage", startPage);
        map.put("prev", prev);
        map.put("next", next);
        return map; 
	}
	 



	
	


	
}

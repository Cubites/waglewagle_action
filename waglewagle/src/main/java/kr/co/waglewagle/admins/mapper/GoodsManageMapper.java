package kr.co.waglewagle.admins.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.GoodsVO;
import kr.co.waglewagle.domain.NoticesVO;
import kr.co.waglewagle.domain.QnasVO;

@Mapper
public interface GoodsManageMapper {
	List<GoodsVO> goodsList();
	void goodsDelete(int goods_id);
	int goodsAccess(Map<String, Integer> goodsInfo);
	int count(GoodsVO param);
	List<Map<String, Object>> adminGoodsList(GoodsVO param);
}

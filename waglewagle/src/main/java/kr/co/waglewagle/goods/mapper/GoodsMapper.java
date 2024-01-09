package kr.co.waglewagle.goods.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.CategoryVO;
import kr.co.waglewagle.domain.GoodsVO;
import kr.co.waglewagle.domain.ImagesVO;
import kr.co.waglewagle.goods.won.GoodsFormVO;
import kr.co.waglewagle.goods.won.GoodsPageVO;

@Mapper
public interface GoodsMapper {
	List<CategoryVO> allCategory();
	List<CategoryVO> getLowerCategory(Integer lowerId);
	Integer insertGoods(GoodsFormVO vo);
	Integer insertImages(Map map);
	GoodsVO selectGoodsById(Integer goodsId);
	List<ImagesVO> selectImagesById(Integer goodsId);
	Integer countFavorsByGoodsId(int goodsId);
	Integer countFavorsByUsersId(Map<String,Integer> favorMap);
	Integer insertFavor(Map<String,Integer> favorMap);
	Integer deleteFavor(Map<String, Integer> favorMap);
	
	// 검색
	List<Map<String,Object>> selectGoodsSearch(GoodsPageVO page);
}

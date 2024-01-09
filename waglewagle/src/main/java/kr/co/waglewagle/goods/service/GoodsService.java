package kr.co.waglewagle.goods.service;

import java.util.List;
import java.util.Map;

import kr.co.waglewagle.domain.CategoryVO;
import kr.co.waglewagle.domain.GoodsVO;
import kr.co.waglewagle.domain.ImagesVO;
import kr.co.waglewagle.goods.won.GoodsFormVO;
import kr.co.waglewagle.goods.won.GoodsPageVO;
import kr.co.waglewagle.goods.won.UploadImage;

public interface GoodsService {
	List<CategoryVO> allCategory();
	List<CategoryVO> getLowerCategory(Integer lower);
	Integer registGoods(GoodsFormVO vo);
	Integer registImages(Integer goods_id, List<UploadImage> list);
	GoodsVO getGoods(Integer goodsId);
	List<ImagesVO> getImages(Integer goodsId);
	Integer getFavorsCnt(Integer goodsId);
	boolean isFavoritGoods(Integer usersId,Integer goodsId);
	Integer addGoodsFavor(Integer users_id, Integer goods_id,boolean status);
	
	List<Map<String,Object>> searchGoods(GoodsPageVO page);
	//List<Map<String, Object>> sortingGoods(Integer category_id, String searchWord, String sortingType);
}

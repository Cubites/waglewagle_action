package kr.co.waglewagle.admins.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StatsMapper {
	List<Map<String, Object>> countGoodsByCategory();
	List<Map<String, Object>> countGoodsFailByCategory();
	List<Map<String, Object>> countBidsByCategory();
	
	List<Map<String, Object>> countGoodsByCategoryAll();
	List<Map<String, Object>> countBidsByCategoryAll();
	
	List<Map<String, Object>> countUsersByMonthLatestYear();
	
	List<Map<String, Object>> countUsersGender();
}

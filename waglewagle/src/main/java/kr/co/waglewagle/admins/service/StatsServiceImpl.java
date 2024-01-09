package kr.co.waglewagle.admins.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.waglewagle.admins.mapper.StatsMapper;

@Service
public class StatsServiceImpl implements StatsService {
	
	@Autowired
	private StatsMapper mapper;

	@Override
	public List<Map<String, Object>> countGoodsByCategory() { return mapper.countGoodsByCategory(); }
	@Override
	public List<Map<String, Object>> countGoodsFailByCategory() { return mapper.countGoodsFailByCategory(); }
	@Override
	public List<Map<String, Object>> countBidsByCategory() { return mapper.countBidsByCategory(); }
	

	@Override
	public List<Map<String, Object>> countGoodsByCategoryAll() {return mapper.countGoodsByCategoryAll(); }
	@Override
	public List<Map<String, Object>> countBidsByCategoryAll() { return mapper.countBidsByCategoryAll(); }
	
	@Override
	public List<Map<String, Object>> countUsersByMonthLatestYear() { return mapper.countUsersByMonthLatestYear(); }
	
	@Override
	public List<Map<String, Object>> countUsersGender() { return mapper.countUsersGender(); }

}

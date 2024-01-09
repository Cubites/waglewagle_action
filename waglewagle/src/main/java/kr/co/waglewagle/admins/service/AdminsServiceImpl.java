package kr.co.waglewagle.admins.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.waglewagle.admins.mapper.AdminsMapper;
import kr.co.waglewagle.domain.AdminsVO;

@Service
public class AdminsServiceImpl implements AdminsService {
	
	@Autowired
	private AdminsMapper mapper;

	@Override
	public AdminsVO addSessionForTest(Integer admins_id) {
		return mapper.addSessionForTest(admins_id);
	}
	
	@Override
	public Integer countAdmins(String searchWord) { return mapper.countAdmins(searchWord); }
	@Override
	public List<AdminsVO> showAdmins(Map<String, Object> dataForSearch) { 
		return mapper.showAdmins(dataForSearch);	
	}
	@Override
	public int deleteAdmin(Integer admins_id) {
		return mapper.deleteAdmin(admins_id);
	}


}

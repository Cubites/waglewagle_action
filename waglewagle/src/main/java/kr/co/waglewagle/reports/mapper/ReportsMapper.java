package kr.co.waglewagle.reports.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.ReportsVO;

@Mapper
public interface ReportsMapper {

	Integer insertReport(ReportsVO report);
	
}

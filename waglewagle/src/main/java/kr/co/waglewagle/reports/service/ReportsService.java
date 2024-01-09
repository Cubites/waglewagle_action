package kr.co.waglewagle.reports.service;

import kr.co.waglewagle.domain.ReportsVO;

public interface ReportsService {

	boolean reportGoods(ReportsVO report);

	boolean reportUser(ReportsVO report,Integer userId) throws Exception;
	
}

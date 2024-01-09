package kr.co.waglewagle.payment.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.waglewagle.domain.PaylogVO;
import kr.co.waglewagle.payment.mapper.PaymentMapper;

@Service
public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	private PaymentMapper mapper;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public boolean savePayment(PaylogVO vo) {
		
		// 1. 결제
		boolean result = mapper.savePayment(vo) > 0 ? true : false;
		if (result) {
			// 2. 해당 유저의 총 포인트 변경
			mapper.updateTotalPoint(vo);
			return true;
		}
		return false;
	}
}

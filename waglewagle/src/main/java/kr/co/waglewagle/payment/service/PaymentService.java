package kr.co.waglewagle.payment.service;

import kr.co.waglewagle.domain.PaylogVO;

public interface PaymentService {
	boolean savePayment(PaylogVO vo);
}

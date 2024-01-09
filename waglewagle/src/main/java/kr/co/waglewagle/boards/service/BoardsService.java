package kr.co.waglewagle.boards.service;

import kr.co.waglewagle.domain.QnasVO;

public interface BoardsService {
	int addQna(QnasVO vo);
	QnasVO showQnaDetail(Integer qnas_id);
}

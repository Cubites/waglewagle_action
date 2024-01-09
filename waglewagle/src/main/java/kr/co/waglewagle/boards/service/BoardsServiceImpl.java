package kr.co.waglewagle.boards.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.waglewagle.boards.mapper.BoardsMapper;
import kr.co.waglewagle.domain.QnasVO;

@Service
public class BoardsServiceImpl implements BoardsService {
	
	@Autowired
	private BoardsMapper mapper;

	@Override
	public int addQna(QnasVO vo) { return mapper.addQna(vo); }

	@Override
	public QnasVO showQnaDetail(Integer qnas_id) {
		return mapper.showQnaDetail(qnas_id);
	}

}

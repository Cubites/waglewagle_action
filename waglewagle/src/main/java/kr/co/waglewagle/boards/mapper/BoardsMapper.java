package kr.co.waglewagle.boards.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.QnasVO;

@Mapper
public interface BoardsMapper {
	int addQna(QnasVO vo);
	QnasVO showQnaDetail(Integer qnas_id);
}

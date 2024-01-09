package kr.co.waglewagle.admins.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.waglewagle.domain.NoticesVO;
import kr.co.waglewagle.domain.QnasVO;

@Mapper
public interface QnaMapper {
	
	List<QnasVO> QnaList();
	QnasVO detail(int qnas_id);	
	Object Qnaview(int qnas_id);
	int qnaDelete(int qnas_id);

	//답글
	void writeReply(QnasVO vo); //답글 작성
	void delReply(int qnas_id);
	int delReply(QnasVO vo);	
	int modifyReply(QnasVO vo);
	int count(QnasVO param);
	List<NoticesVO> qnaList(QnasVO param);
}

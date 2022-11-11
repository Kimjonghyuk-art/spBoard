package com.app.reply.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.app.reply.dao.ReplyDAO;
import com.app.reply.vo.ReplyVO;

@Service("replyService")
public class ReplyService {

	@Resource(name="replyDAO")
	private ReplyDAO replyDAO;
	//댓글등록
	public int insertReply(ReplyVO replyVO) {
		return replyDAO.insertReply(replyVO);
	}
	
	//댓글조회
	public List<ReplyVO> findAllReply(ReplyVO replyVO) {
		return replyDAO.findAllReply(replyVO);
	}

	//댓글 삭제
  public int delReply(ReplyVO replyVO) {
		return replyDAO.delReply(replyVO);
  }
}

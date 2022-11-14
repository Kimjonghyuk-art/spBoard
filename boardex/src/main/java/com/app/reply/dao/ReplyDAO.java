package com.app.reply.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.app.reply.vo.ReplyVO;

@Repository("replyDAO")
public class ReplyDAO {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sql;

	// 댓글 등록
	public int insertReply(ReplyVO replyVO) {
		return sql.insert("replyDAO.insertReply", replyVO);
	}

	// 댓글 조회
	public List<ReplyVO> findAllReply(ReplyVO replyVO) {
		return sql.selectList("replyDAO.findAllReply", replyVO);
	}

	// 댓글 삭제
	public int delReply(ReplyVO replyVO) {
		return sql.delete("replyDAO.delReply", replyVO);
	}

	// 댓글 수정
	public int updateReply(ReplyVO replyVO) {
		return sql.update("replyDAO.updateReply", replyVO);
	}
}

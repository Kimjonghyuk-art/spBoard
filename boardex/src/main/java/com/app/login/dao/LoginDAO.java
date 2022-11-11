package com.app.login.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.app.login.vo.UserVO;

@Repository("loginDAO")
public class LoginDAO {
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sql;
	//회원가입
	public int signUp(UserVO userVO) {
		
		return sql.insert("loginDAO.signUp",userVO);
	}
	//유저정보 겟
	public UserVO getInfo(String userId) {
		
		return sql.selectOne("loginDAO.getInfo",userId);
	}
	//유저 정보 수정
	public int updateUser(UserVO userVO) {
		return sql.update("loginDAO.updateUser",userVO);
	}
	//아이디 중복 검사
	public int idDuplicateCheck(String userId) {
		return sql.selectOne("loginDAO.idDuplicateCheck",userId);
	}

	//비밀번호 업데이트 
	public int updatePw(UserVO userVO) {
		return sql.update("loginDAO.updatePw",userVO);
	}
	
}

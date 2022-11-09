package com.app.login.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.app.login.vo.UserVO;

@Repository("loginDAO")
public class LoginDAO {
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sql;

	public int signUp(UserVO userVO) {
		
		return sql.insert("loginDAO.signUp",userVO);
	}

	public UserVO getInfo(String userId) {
		
		return sql.selectOne("loginDAO.getInfo",userId);
	}

	public int updateUser(UserVO userVO) {
		return sql.update("loginDAO.updateUser",userVO);
	}

	public int idDuplicateCheck(String userId) {
		System.out.println("DAO->"+userId);
		return sql.selectOne("loginDAO.idDuplicateCheck",userId);
	}
	
}

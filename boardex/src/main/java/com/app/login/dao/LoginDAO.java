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

	public UserVO getInfo(String email) {
		
		return sql.selectOne("loginDAO.getInfo",email);
	}
	
}

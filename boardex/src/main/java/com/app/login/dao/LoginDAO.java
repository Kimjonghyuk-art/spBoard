package com.app.login.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("loginDAO")
public class LoginDAO {
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sql;
	
}

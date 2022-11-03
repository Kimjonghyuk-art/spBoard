package com.app.login.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.app.login.dao.LoginDAO;

@Service("loginService")
public class LoginService {

	@Resource(name="loginDAO")
	private LoginDAO loginDAO;
}

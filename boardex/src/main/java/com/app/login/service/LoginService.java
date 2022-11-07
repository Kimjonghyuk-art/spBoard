package com.app.login.service;

import javax.annotation.Resource;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.app.login.dao.LoginDAO;
import com.app.login.vo.UserVO;

@Service("loginService")
public class LoginService implements UserDetailsService {

	@Resource(name="loginDAO")
	private LoginDAO loginDAO;

	public int signUp(UserVO userVO) {
	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	System.out.println("Befor Encoder : " + userVO.getUserPw());
	String endcodedPassword = passwordEncoder.encode(userVO.getUserPw());
	System.out.println("After Encoder : " + endcodedPassword);
	System.out.println("Resister User Info : " + userVO);
	userVO.setUserPw(endcodedPassword);	
		return loginDAO.signUp(userVO);
	}
	
	//로그인 정보 가지고 오기
//	public UserVO getInfo(UserVO userVO) {
//		return loginDAO.getInfo(userVO);
//	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		UserVO userVO = loginDAO.getInfo(username);
		
		return userVO;
	}
	
}

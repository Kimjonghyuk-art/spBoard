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
public class LoginService  {

	@Resource(name="loginDAO")
	private LoginDAO loginDAO;

	public int signUp(UserVO userVO) {
	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	System.out.println("Befor Encoder : " + userVO.getPassword());
	String endcodedPassword = passwordEncoder.encode(userVO.getPassword());
	//endcodedPassword = getEncodedPassword(endcodedPassword);
	System.out.println("After Encoder : " + endcodedPassword);
	System.out.println("Resister User Info : " + userVO);
	userVO.setUserPassword(endcodedPassword);	
		return loginDAO.signUp(userVO);
	}
	
	//유저 정보 가지고 오기
	public UserVO getInfo(String userId) {
		return loginDAO.getInfo(userId);
	}
	//유저 정보 수정
	public int updateUser(UserVO userVO) {
		return loginDAO.updateUser(userVO);
	}
	//회원가입시 아이디 중복체크
	public int idDuplicateCheck(String userId) {
		return loginDAO.idDuplicateCheck(userId);
		
	}

}

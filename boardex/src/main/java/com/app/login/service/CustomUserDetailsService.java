package com.app.login.service;

import javax.annotation.Resource;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.app.login.dao.LoginDAO;
import com.app.login.vo.UserVO;

public class CustomUserDetailsService  implements UserDetailsService {

	@Resource(name="loginDAO")
	private LoginDAO loginDAO;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		
		UserVO user = loginDAO.getInfo(userName);
		//System.out.println("########user???#####"+userName);
		if(user == null) {
			System.out.println("########user IS NULL#####");
			throw new UsernameNotFoundException(userName);
		}

		return user;
	}
	
	
	
}

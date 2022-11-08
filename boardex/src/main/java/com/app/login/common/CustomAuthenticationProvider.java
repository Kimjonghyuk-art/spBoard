package com.app.login.common;

import javax.annotation.Resource;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.app.login.vo.UserVO;

public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	@Resource
	private UserDetailsService userDetailsService;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		System.out.println("authentication : " + authentication);

		String loginUserName = String.valueOf(authentication.getPrincipal());
		String loginPassword = String.valueOf(authentication.getCredentials());
		System.out.println("loginUserName : " + loginUserName);
		System.out.println("loginPassword : " + loginPassword);

		UserVO user = (UserVO) userDetailsService.loadUserByUsername(loginUserName);

		if(!matchPassword(loginPassword, user.getPassword())) {

			System.out.println();

			throw new BadCredentialsException(loginUserName);
		}

		if(!user.isEnabled()) {
			throw new BadCredentialsException(loginUserName);
		}


		return new UsernamePasswordAuthenticationToken(loginUserName, loginPassword, user.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}
	
	
	private boolean matchPassword(String loginPassword, String password) {

		return loginPassword.equals(password);

	}

	
	
}

package com.app.login.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.app.login.service.LoginService;
import com.app.login.vo.UserVO;

@RestController("/users/json")
public class LoginRestController {

	@Resource(name = "loginService")
	private LoginService loginService;

	//수정
	@RequestMapping("/update.ajax")
	public void update(UserVO userVO) throws Exception {
		//ModelAndView mav = new ModelAndView("jsonView");
			System.out.println(userVO);
			
		//return mav;
	}
	
}

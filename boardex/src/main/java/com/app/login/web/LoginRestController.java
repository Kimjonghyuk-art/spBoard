package com.app.login.web;

import javax.annotation.Resource;

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
	
	//회원 등록
	@RequestMapping("/signup.ajax")
	public ModelAndView singup(@RequestBody UserVO userVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		loginService.signUp(userVO);
		return mav;
	}
	
	//
	/*
	 * @RequestMapping("/signup.ajax") public ModelAndView singup(@RequestBody
	 * UserVO userVO) throws Exception { ModelAndView mav = new
	 * ModelAndView("jsonView"); loginService.signUp(userVO); return mav; }
	 */
	
}

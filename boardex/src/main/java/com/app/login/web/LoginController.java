package com.app.login.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.login.service.LoginService;
import com.app.login.vo.UserVO;


@Controller
@RequestMapping("/users")
public class LoginController {
	
	@Resource(name = "loginService")
	private LoginService loginService;
	

	//로그인 페이지이동
	@RequestMapping("/loginpage.do")
	public String singInPage() {
		return "/users/signin.tiles";
	}
	
	//회원가입페이지 이동
	@RequestMapping("/signuppage.do")
	public String signUpPage() {
		return "/users/signup.tiles";
	}
	
	//회원가입 실행
	@RequestMapping("/signup.do")
	
	public String signUp(UserVO userVO) {
		ModelAndView mav = new ModelAndView("jsonView");
		loginService.signUp(userVO);
		return "redirect:/";
	}
	
	//로그인 실행 
	@RequestMapping("/login.do")
	public String login(UserVO userVO) {
		System.out.println(userVO);
		//ModelAndView mav = new ModelAndView("jsonView");
		
		//loginService.signUp(userVO);
		return "redirect:/";
	}
	


	
	
	
	
	
}

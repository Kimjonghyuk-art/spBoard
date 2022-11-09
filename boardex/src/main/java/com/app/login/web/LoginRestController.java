package com.app.login.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.app.login.service.LoginService;
import com.app.login.vo.UserVO;

@RestController
@RequestMapping("/users/json")
public class LoginRestController {

	@Resource(name = "loginService")
	private LoginService loginService;

	// 아이디체크
	@RequestMapping("/idduplicatecheck.ajax")
	public int idDuplicateCheck(@RequestBody UserVO userVO) throws Exception {
		// ModelAndView mav = new ModelAndView("jsonView");
		System.out.println(userVO.getUsername());
		int result = loginService.idDuplicateCheck(userVO.getUserId());
		System.out.println(result);
		return result;
	}

	// 회원가입 실행
	@RequestMapping("/signup.ajax")
	public ModelAndView signUp(@RequestBody UserVO userVO) {
		ModelAndView mav = new ModelAndView("jsonView");
		loginService.signUp(userVO);
		return mav;
	}

}

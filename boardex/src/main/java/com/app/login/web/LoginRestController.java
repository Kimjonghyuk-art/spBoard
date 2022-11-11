package com.app.login.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.app.login.service.LoginService;
import com.app.login.vo.UserVO;

@RestController
@RequestMapping("/users/json")
public class LoginRestController {

	@Resource(name = "loginService")
	private LoginService loginService;

	//메일 보내기 
	@RequestMapping("/sendemail.ajax")
	public ModelAndView sendEamil(String userId,String email) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		String addr = "jhkim02@sppartners.co.kr";
		
		String subject = "[😀😀] 알림메일 입니다.";
		
		System.out.println(email);
		System.out.println(userId);
		loginService.sendEmail(userId,email, addr, subject);
		return mav;
	}
	
	
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
	
	//비밀번호 수정
	@RequestMapping("/updatepw.ajax")
	public ModelAndView updatepw(@RequestBody UserVO userVO) {
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("##유저 비밀번호 업데이트##");
		loginService.updatePw(userVO);
		return mav;
	}

}

package com.app.login.web;

import java.security.Principal;

import javax.annotation.Resource;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.login.service.LoginService;
import com.app.login.vo.UserVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/users")
public class LoginController {

	@Resource(name = "loginService")
	private LoginService loginService;

	// 로그인 페이지이동
	@RequestMapping("/loginpage.do")
	public String singInPage() {
		return "/users/signin.tiles";
	}

	// 회원가입페이지 이동
	@RequestMapping("/signuppage.do")
	public String signUpPage() {
		return "/users/signup.tiles";
	}

	// 수정페이지이동
	@RequestMapping("/update.do")
	public String updateUser(Principal principal, Model model) throws JsonProcessingException {

		ObjectMapper mapper = new ObjectMapper();

		model.addAttribute("user", mapper.writeValueAsString(loginService.getInfo(principal.getName())));
		return "/users/update.tiles";
	}

	// 비밀번호 찾기 페이지 이동
	@RequestMapping("/passwordreset.do")
	public String passwordreset() {
		return "/users/passwordreset.tiles";
	}
	//비밀번호 변경페이지 이동
	@RequestMapping("/updatepwpage.do") 
	public String updatepw(Principal principal, Model model) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();

		model.addAttribute("user", mapper.writeValueAsString(loginService.getInfo(principal.getName())));
		return "/users/updatepw.tiles";
	}

	// 회원 정보 보기
	@RequestMapping("/info.do")
	public String info(Principal principal, Model model) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();

		String userName = principal.getName();

		model.addAttribute("user", mapper.writeValueAsString(loginService.getInfo(userName)));

		return "/users/info.tiles";
	}

	// 회원정보 수정
	@RequestMapping("/updateAction.do")
	public String updateAction(UserVO userVO) {
		System.out.println(userVO);

		loginService.updateUser(userVO);
		return "redirect:/users/info.do";
	}

	// 메일 보내기
//	@RequestMapping("/sendemail.do")
//	public String sendEamil(String userId,String email) throws Exception {
//
//		String addr = "jhkim02@sppartners.co.kr";
//		String subject = "[😀😀] 임시비밀번호 변경 알림입니다.";
//		
//		loginService.sendEmail(userId, email, addr, subject);
//		return "redirect:/";
//	}

}

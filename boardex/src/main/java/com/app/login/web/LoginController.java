package com.app.login.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class LoginController {

	@RequestMapping("/signup.do")
	public String SignUpPage() {
		return "login/signup.tiles";
	}
}

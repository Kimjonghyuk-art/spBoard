package com.app.admin.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@RequestMapping("/main.do")
	public String main() {
		return "/admin/main.tiles";
	}
	
}

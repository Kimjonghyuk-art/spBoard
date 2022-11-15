package com.app.admin.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.app.admin.service.AdminService;
import com.app.admin.vo.FileVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Resource(name="adminService")
	private AdminService adminService;
	
	@RequestMapping("/main.do")
	public String main() {
		return "/admin/main.tiles";
	}

	@RequestMapping("/readexcelpage.do")
	public String readExcelPage() {
		return "/admin/read.tiles";
	}

	
}

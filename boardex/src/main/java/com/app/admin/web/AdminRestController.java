package com.app.admin.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.app.admin.service.AdminService;
import com.app.admin.vo.FileVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/admin/json")
public class AdminRestController {
	
	@Resource(name="adminService")
	private AdminService adminService;
	
	@RequestMapping("/read.ajax")
	public ModelAndView readExcel(@RequestParam("file") MultipartFile file, Model model) throws IOException{
			ModelAndView mav = new ModelAndView("jsonView");
		  	FileVO fileVO = new FileVO();
		    
		    fileVO.setFileOriginalName(file.getOriginalFilename()); // 파일
		    fileVO.setFileContentType(file.getContentType());
		    fileVO
					.setFileStoredName(UUID.randomUUID().toString().replaceAll("-", "") + file.getOriginalFilename());
			// boardFile.setFilePath("/Users/jonghyuk/temp/" +
			// boardFile.getFileStoredName());
		    fileVO.setFilePath("C:/fileTest/" + fileVO.getFileStoredName());
			File uploadFile = new File(fileVO.getFilePath());
			uploadFile.getParentFile().mkdirs();

			file.transferTo(uploadFile);

			String path = "C:/fileTest/";
			String fileName = fileVO.getFileStoredName();
			//서비스단에서 등록
			List<Map<Object, Object>> excelData = adminService.readExcel(path, fileName);
			// 결과 확인!
			for (int i = 0; i < excelData.size(); i++) {
				System.out.println(excelData.get(i));
			}
			
			uploadFile.delete();
			
			mav.addObject("excelData", excelData);

		return mav;
	}

}

package com.board.app.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriUtils;

import com.board.app.service.BoardService;
import com.board.app.vo.BoardFileVO;
import com.board.app.vo.BoardLikeVO;
import com.board.app.vo.BoardVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/board/json")
public class BoardRestController {

	@Resource(name = "boardService")
	private BoardService boardService;

	// 삭제
	@RequestMapping("/del.ajax")
	public ModelAndView del(@RequestBody BoardVO boardVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		boardService.delBoard(boardVO);
		return mav;
	}

	// 등록 및 수정
	@RequestMapping("/upsert.ajax")
	public ModelAndView upsert(BoardVO boardVO, MultipartFile file) throws Exception {
		BoardFileVO boardFileVO = new BoardFileVO();
		ModelAndView mav = new ModelAndView("jsonView");
		boardService.upsertAction(boardVO);

		// 첨부파일 있을 떄
		if (!file.isEmpty()) {
			System.out.println("첨부파일ㅇ ㅣㅆ음 ");
			boardFileVO.setFileOriginalName(file.getOriginalFilename()); // 파일
			boardFileVO.setFileContentType(file.getContentType());
			boardFileVO
					.setFileStoredName(UUID.randomUUID().toString().replaceAll("-", "") + file.getOriginalFilename());
			// boardFile.setFilePath("/Users/jonghyuk/temp/" +
			// boardFile.getFileStoredName());
			boardFileVO.setFilePath("C:/Temp/" + boardFileVO.getFileStoredName());
			boardFileVO.setIdx(boardService.getMaxIdx());
			File uploadFile = new File(boardFileVO.getFilePath());
			uploadFile.getParentFile().mkdirs();

			file.transferTo(uploadFile);

			boardService.fileUpsertAction(boardFileVO);

		}

		return mav;
	}

	// 게시판 페이징 이동
	@RequestMapping("/list.ajax")
	public ModelAndView list(@RequestBody BoardVO boardVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		ObjectMapper mapper = new ObjectMapper();

		int totalCnt = boardService.getBoardsCnt(boardVO);
		boardVO.setTotalCnt(totalCnt);

		mav.addObject("list", mapper.writeValueAsString(boardService.findAllBoards(boardVO)));
		mav.addObject("page", mapper.writeValueAsString(boardVO));
		return mav;
	}

	@RequestMapping("/findlike.ajax")
	public int findLike(@RequestBody BoardLikeVO boardLikeVO) throws Exception {
		// ModelAndView mav = new ModelAndView("jsonView");
		int result = boardService.findLike(boardLikeVO);
		return result;
	}

	// 좋아요 등록
	@RequestMapping("/insertlike.ajax")
	public ModelAndView insertLike(@RequestBody BoardLikeVO boardLikeVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		boardService.insertLike(boardLikeVO);
		System.out.println(boardLikeVO.getUserId());

		return mav;
	};

	// 좋아요 삭제
	@RequestMapping("/deletelike.ajax")
	public ModelAndView deleteLike(@RequestBody BoardLikeVO boardLikeVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		boardService.deleteLike(boardLikeVO);
		System.out.println(boardLikeVO.getUserId());

		return mav;
	};

	// 첨부파일 다운
//	@RequestMapping("/download.ajax")
//	public ResponseEntity<Resource> download(@RequestBody BoardFileVO boardFileVO,HttpServletRequest request) throws IOException {
//	
//		String path = "C:/Temp/";
//		
//		System.out.println(path);
//		
//		Resource resource = (Resource) new FileSystemResource(path+boardFileVO.getFileOriginalName());
//		//파일 명
//				String resourceName = resource.getFileName();
//				
//				//Http헤더에 옵션을 추가하기 위해서 헤더 변수 선언
//				HttpHeaders headers = new HttpHeaders();
//				
//				try {
//					//헤더에 파일명으로 첨부파일 추가
//					headers.add("Content-Disposition", "attachment; filename=" + new String(resourceName.getBytes("UTF-8"),
//								"ISO-8859-1"));
//				} catch(UnsupportedEncodingException e) {
//					e.printStackTrace();
//				}
////		ModelAndView mav = new ModelAndView("jsonView");
////		System.out.println(boardFileVO.getFileContentType());
////		System.out.println(boardFileVO.getFileOriginalName());
////		System.out.println(boardFileVO.getFilePath());
////		System.out.println(boardFileVO.getFileStoredName());
////		
////		//변수명, 값
////		File file = new File(boardFileVO.getFilePath());
////		FileInputStream in = new FileInputStream(file);
//		
// 
//        //return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
//		return null;
//	}
	
//	

	 // 첨부 파일 다운로드
    @RequestMapping("/download.ajax")
    public ResponseEntity<UrlResource> downloadAttach(@RequestBody BoardFileVO boardFileVO) throws MalformedURLException {

        UrlResource resource = new UrlResource("file:" + boardFileVO.getFilePath());

        String encodedFileName = UriUtils.encode(boardFileVO.getFileOriginalName(), StandardCharsets.UTF_8);

        // 파일 다운로드 대화상자가 뜨도록 하는 헤더를 설정해주는 것
        // Content-Disposition 헤더에 attachment; filename="업로드 파일명" 값을 준다.
        String contentDisposition = "attachment; filename=\"" + encodedFileName + "\"";

        return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,contentDisposition).body(resource);
    
    }
    
    @RequestMapping("/downloadtest.ajax")
    public void downloadTest(HttpServletResponse response) throws Exception {
    	String path = "C:/Temp/349bc87c15ba490b868eb8d0364470b8계약현황.xlsx";
    	
    	File file = new File(path);
    	response.setHeader("Content-Disposition", "Attachment;filename="+ file.getName());
    	
    	FileInputStream fileInputStream = new FileInputStream(path); // 파일 읽어오기 
    	OutputStream out = response.getOutputStream();
    	
    	int read = 0;
        byte[] buffer = new byte[1024];
        while ((read = fileInputStream.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이 없음
            out.write(buffer, 0, read);
        }
    	
    	
    }
    
    
}

package com.app.board.web;

import java.io.File;
import java.net.MalformedURLException;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriUtils;

import com.app.board.service.BoardService;
import com.app.board.vo.BoardFileVO;
import com.app.board.vo.BoardLikeVO;
import com.app.board.vo.BoardVO;
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
	public ModelAndView upsert(BoardVO boardVO, HttpServletRequest request) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");
		boardService.upsertAction(boardVO);

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		MultipartFile file = multi.getFile("uploadFile");

		System.out.println("file -> " + file);

		if (file.isEmpty()) {
			System.out.println("널!!!!!!!!!!!!################");

		} else {
			System.out.println("파라미터명" + file.getName());
			System.out.println("파일크기" + file.getSize());
			System.out.println("파일 존재" + file.isEmpty());
			System.out.println("오리지날 파일 이름" + file.getOriginalFilename());

			BoardFileVO boardFileVO = new BoardFileVO();
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

	// 첨부파일 삭제
	@RequestMapping("/delfile.ajax")
	public ModelAndView delfile(@RequestBody BoardFileVO boardFileVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		BoardFileVO bfVO = boardService.getFile(boardFileVO.getIdx());
		boardService.delFile(boardFileVO.getFileNo());
		String filePath = bfVO.getFilePath();

		File file = new File(filePath);
		if (file.exists()) {
			// 파일 삭제
			file.delete();
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
	public int insertLike(@RequestBody BoardLikeVO boardLikeVO) throws Exception {
		//ModelAndView mav = new ModelAndView("jsonView");
		boardService.insertLike(boardLikeVO);
		System.out.println(boardLikeVO.getUserId());
		System.out.println("#####좋아요 등록######");
		System.out.println("boardLikeVO->"+boardLikeVO.getBoardIdx());
		int result = boardService.getLikeCnt(boardLikeVO.getBoardIdx());
		return result;
	};

	// 좋아요 삭제
	@RequestMapping("/deletelike.ajax")
	public int deleteLike(@RequestBody BoardLikeVO boardLikeVO) throws Exception {
		//ModelAndView mav = new ModelAndView("jsonView");
		boardService.deleteLike(boardLikeVO);
		System.out.println(boardLikeVO.getUserId());
		int result = boardService.getLikeCnt(boardLikeVO.getBoardIdx());
		return result;
	};

	// 첨부 파일 다운로드
	@RequestMapping("/download.ajax")
	public ResponseEntity<UrlResource> downloadAttach(@RequestBody BoardFileVO boardFileVO)
			throws MalformedURLException {

		UrlResource resource = new UrlResource("file:" + boardFileVO.getFilePath());

		String encodedFileName = UriUtils.encode(boardFileVO.getFileOriginalName(), StandardCharsets.UTF_8);

		// 파일 다운로드 대화상자가 뜨도록 하는 헤더를 설정해주는 것
		// Content-Disposition 헤더에 attachment; filename="업로드 파일명" 값을 준다.
		String contentDisposition = "attachment; filename=\"" + encodedFileName + "\"";

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition).body(resource);

	}

}

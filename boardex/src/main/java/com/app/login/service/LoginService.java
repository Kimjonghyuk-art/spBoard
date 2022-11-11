package com.app.login.service;

import javax.annotation.Resource;

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.app.login.dao.LoginDAO;
import com.app.login.vo.UserVO;

@Service("loginService")
public class LoginService {

	@Resource(name = "loginDAO")
	private LoginDAO loginDAO;

	@Resource(name = "mailSender")
	private JavaMailSender mailSender;
	
	///메일 보내기
	public void sendEmail(String userId, String toAddress, String fromAddress, String subject) {
		SimpleMailMessage smm = new SimpleMailMessage();
		String resetPw = randomPw();
		System.out.println("userId-> " + userId);
		UserVO userVO = getInfo(userId);//유저정보 가지고오기
		String endcodedPassword = encode(resetPw); //비밀번호 인코딩
		userVO.setUserPassword(endcodedPassword);
		
		updatePw(userVO); //비밀번호 업데이트
		
		String body = "안녕하세요?\r\n비밀번호 설정입니다~\r\n SMTP메일 테스트입니다.\n";
		body+="임시비밀번호 : "+ resetPw;
		body+= " \n입력하세여";
		smm.setFrom(fromAddress);
		smm.setTo(toAddress);
		smm.setSubject(subject);
		smm.setText(body);
		
		mailSender.send(smm);
	}
	
	public String randomPw() {
		String  pswd = "";
		StringBuffer sb = new StringBuffer();
		StringBuffer sc = new StringBuffer("!@#$%^&*-=?~");  // 특수문자 모음, {}[] 같은 비호감문자는 뺌

		// 대문자 4개를 임의 발생 
		sb.append((char)((Math.random() * 26)+65));  // 첫글자는 대문자, 첫글자부터 특수문자 나오면 안 이쁨

		for( int i = 0; i<3; i++) {
		   sb.append((char)((Math.random() * 26)+65));  // 아스키번호 65(A) 부터 26글자 중에서 택일
		} 
		// 소문자 4개를 임의발생
		for( int i = 0; i<4; i++) {
		    sb.append((char)((Math.random() * 26)+97)); // 아스키번호 97(a) 부터 26글자 중에서 택일
		}  

		// 숫자 2개를 임의 발생
		for( int i = 0; i<2; i++) {
		    sb.append((char)((Math.random() * 10)+48)); //아스키번호 48(1) 부터 10글자 중에서 택일
		}

		// 특수문자를 두개  발생시켜 랜덤하게 중간에 끼워 넣는다 
		sb.setCharAt(((int)(Math.random()*3)+1), sc.charAt((int)(Math.random()*sc.length()-1))); //대문자3개중 하나   
		sb.setCharAt(((int)(Math.random()*4)+4), sc.charAt((int)(Math.random()*sc.length()-1))); //소문자4개중 하나

		pswd = sb.toString();
		return pswd;
	}
	
	
	//비밀번호 업데이트
	public int updatePw(UserVO userVO) {
		String endcodedPassword = encode(userVO.getPassword()); //비밀번호 인코딩
		userVO.setUserPassword(endcodedPassword);
		return loginDAO.updatePw(userVO);
	}

	// 회원가입
	public int signUp(UserVO userVO) {
		System.out.println("Befor Encoder : " + userVO.getPassword());
		String endcodedPassword = encode(userVO.getPassword());
		System.out.println("After Encoder : " + endcodedPassword);
		System.out.println("Resister User Info : " + userVO);
		userVO.setUserPassword(endcodedPassword);
		return loginDAO.signUp(userVO);
	}
	
	//비밀번호 인코딩
	public String encode(String password) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String endcodedPassword = passwordEncoder.encode(password);
		return endcodedPassword;
	}

	// 유저 정보 가지고 오기
	public UserVO getInfo(String userId) {
		return loginDAO.getInfo(userId);
	}

	// 유저 정보 수정
	public int updateUser(UserVO userVO) {
		return loginDAO.updateUser(userVO);
	}

	// 회원가입시 아이디 중복체크
	public int idDuplicateCheck(String userId) {
		return loginDAO.idDuplicateCheck(userId);

	}

}

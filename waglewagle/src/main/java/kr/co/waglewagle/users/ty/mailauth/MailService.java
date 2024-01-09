package kr.co.waglewagle.users.ty.mailauth;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MailService{
	
	private final JavaMailSender mailSender;
	
	//인증번호
	private String authNum;
	
	public MimeMessage createMessage(String to) throws MessagingException, UnsupportedEncodingException{
		MimeMessage message = mailSender.createMimeMessage();
		
		message.addRecipients(Message.RecipientType.TO, to); //받는 사람
		message.setSubject("회원가입 인증 번호"); //메일 제목
		
		String msg = "";

		msg += "<div style='margin:100px;'>";
        msg += "<h1> 안녕하세요</h1>";
        msg += "<h1> 와글와글입니다</h1>";
        msg += "<br>";
        msg += "<p>아래 코드를 회원가입 창으로 돌아가 입력해주세요<p>";
        msg += "<br>";
        msg += "<div align='center' style='border:1px solid black; font-family:verdana';>";
        msg += "<h3 style='color:blue;'>회원가입 인증 코드입니다.</h3>";
        msg += "<div style='font-size:130%'>";
        msg += "<strong>";
        msg += authNum + "</strong><div><br/> "; // 인증번호
        msg += "</div>";
        message.setText(msg, "utf-8", "html");// 내용, charset 타입, subtype
        // 보내는 사람의 이메일 주소, 보내는 사람 이름
        message.setFrom(new InternetAddress("teayun357@naver.com", "와글와글"));// 보내는 사람

        return message;

	}
	
	public String createKey() {
		StringBuffer key = new StringBuffer();
		Random rnd = new Random();
		
		for(int i=0; i<8; i++) {
			int index = rnd.nextInt(3);
			
			switch(index) {
				case 0: // a-z
					key.append((char)((int)(rnd.nextInt(26)) + 97));
					break;
				case 1: //A-Z
					key.append((char)((int)(rnd.nextInt(26)) + 65));
					break;
				case 2:
					key.append(rnd.nextInt(10));
					break;
			}
		}
		
		return key.toString();
	}
	
	public String sendSimpleMessage(String to) throws Exception{
		authNum = createKey();
		
		MimeMessage message = createMessage(to);
		try {
			log.info("mailesender {}",mailSender);
			log.info("mailesender {}",mailSender.toString());
			mailSender.send(message);
		} catch(MailException e) {
			e.printStackTrace();
			throw new IllegalArgumentException();
		}
		
		return authNum;
	}
}

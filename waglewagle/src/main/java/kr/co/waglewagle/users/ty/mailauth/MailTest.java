package kr.co.waglewagle.users.ty.mailauth;

import org.springframework.beans.factory.annotation.Autowired;

public class MailTest {

	public static void main(String[] args) {
		
		MailConfig mailConfig = new MailConfig();
		
		MailService ms = new MailService(mailConfig.javaMailSender());

		try {
			ms.sendSimpleMessage("teayun357@naver.com");
		}catch(Exception e){
			e.printStackTrace();
		}

		
	}

}

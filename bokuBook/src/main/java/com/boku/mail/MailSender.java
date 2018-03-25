package com.boku.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component("mail")
public class MailSender {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private SimpleMailMessage message;
	
	public void sendMail(String to, String subject, String content) {
		message.setTo(to);
		message.setSubject(subject);
		message.setText(content);
		mailSender.send(message);
	}
}

package bokuBook;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.boku.mail.MailSender;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class Test1 {
	
	@Autowired
	private MailSender sender;
	
	@Resource(name = "dataSource")
	private DriverManagerDataSource source;
	
	
	
	@Test
	public void sendSingleTest(){   
        sender.sendMail("1743497583@qq.com", "验证你的邮箱", "请验证你的邮箱");  
    }  
}

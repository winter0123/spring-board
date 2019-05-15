package kr.co.uclick.service;

import java.util.List;

import javax.jdo.annotations.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import kr.co.uclick.configuration.SpringConfiguration;
import kr.co.uclick.entity.Phone;
import kr.co.uclick.entity.User;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = SpringConfiguration.class)
public class PhoneServiceFindPhoneNumberTest {

	@Autowired
	private UserService userService;
	
	@Autowired
	private PhoneService phoneService;
	
	@Test
	@Transactional
	public void findByNameTest() {
		String phoneNumber = "010-1111-1111";
		
		Phone p = phoneService.findByPhoneNumber(phoneNumber);
		
		//User 리스트
			System.out.println("PhoneID:"+p.getId()+", PhoneNumber:"+ p.getPhoneNumber()+", UserName:"+p.getUser().getName());	
	}
	
}

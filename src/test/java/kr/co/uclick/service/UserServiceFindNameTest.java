package kr.co.uclick.service;

import java.util.List;

import javax.jdo.annotations.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import kr.co.uclick.configuration.SpringConfiguration;
import kr.co.uclick.entity.User;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = SpringConfiguration.class)
public class UserServiceFindNameTest {

	@Autowired
	private UserService userService;
	
	@Autowired
	private PhoneService phoneService;
	
	@Test
	@Transactional
	public void findByNameTest() {
		String name = "Dong";
		int userId = 1452;
		
		List<User> result = userService.findUserByNameLike(name);
//		List<User> result1 = userService.findUserById(id);
		User result2 = userService.findById(userId);
		
		
		System.out.println("UserID:"+result2.getId()+", Name:"+ result2.getName());	
		
		//User 리스트
		for( User u : result ) {							//for문을 list길이 만큼 돌려서 출력
			System.out.println("UserID:"+u.getId()+", Name:"+ u.getName());	
		}
	}
	
}

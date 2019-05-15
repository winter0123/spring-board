package kr.co.uclick.repository;

import java.util.List;

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
public class PhoneRepositoryTest {
	
	@Autowired
	private PhoneRepository phoneRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Test
	public void findAllByUser() {
		
		User u = userRepository.findById(1452).get();
		
		List<Phone> list = phoneRepository.findAllByUser(u);
		for(Phone item: list) {
			System.out.println(item.getPhoneNumber());
		}
		
		
	}
	
}

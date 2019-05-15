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
import kr.co.uclick.repository.UserRepository;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = SpringConfiguration.class)
public class PhoneServiceAddTest {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private PhoneService phoneService;
	
	@Test
	@Transactional
	public void oneToMany_TwoWay() {
		User user1 = new User("Jung1");			//첫번째 맴버 Jung
		User user2 = new User("Jung2");			//첫번째 맴버 Jung
		User user3 = new User("Jung3");			//첫번째 맴버 Jung
		
		userRepository.save(user1);				//첫번째 저장
		userRepository.save(user2);				//첫번째 저장
		userRepository.save(user3);				//첫번째 저장

		Phone phone1 = new Phone(user1, "010-yyyy-yyyy");
		Phone phone2 = new Phone(user2, "010-zzzz-zzzz");
		Phone phone3 = new Phone(user3, "010-kkkk-kkkk");
		
		phoneService.save(phone1);				//첫번째 저장
		phoneService.save(phone2);				//두번째 저장
		phoneService.save(phone3);				//세번째 저장
		
		//서버 돌고나서 결과값을 띄울때 보기좋게 띄울려고 하는 부분(각각 따로 조회하기 위해서는 아래의 형식으로 하면 됨)
		List<User> list = userRepository.findAll();		//User에 전체 데이터를 리스트로 불러옴
		List<Phone> list1 = phoneService.findAll();	//Phone에 전체 데이터를 리스트로 불러옴
		
		//User 리스트
		for( User u : list ) {							//for문을 list길이 만큼 돌려서 출력
			System.out.println("UserID:"+u.getId()+", Name:"+ u.getName());	
		}
		
		//Phone 리스트(1대 다에서는 다에서 1을 불러오는게 좋기 때문에 Phone에서 user쪽 목록을 불러오는게 효율성이 좋음)
		for( Phone p : list1 ) {						//for문을 list길이 만큼 돌려서 출력
			System.out.println("PhoneID:"+p.getId()+", PhoneNumber:"+ p.getPhoneNumber()+", Name:"+p.getUser().getName());
		}
	}
}

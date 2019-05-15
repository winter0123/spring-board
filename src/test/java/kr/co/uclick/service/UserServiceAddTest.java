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
public class UserServiceAddTest {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PhoneService phoneService;
	
	@Test
	public void oneToMany_TwoWay() {
		User first = new User("Jung");			//첫번째 맴버 Jung
		first.addPhone(new Phone("010-xxxx-xxxx"));//첫번째 맴버 Jung 폰1 추가
		first.addPhone(new Phone("010-yyyy-yyyy"));//첫번째 맴버 Jung 폰2 추가
		
		User second = new User("Dong");			//두번째 맴버 Dong
		second.addPhone(new Phone("010-zzzz-zzzz"));//두번째 맴버 Dong 폰1 추가
		
		User third = new User("Min");			//세번째 맴버 Min
		third.addPhone(new Phone("010-kkkk-kkkk"));//세번째 맴버  Min 폰1 추가
		
		userService.save1(first);				//첫번째 저장
		userService.save1(second);			//두번째 저장
		userService.save1(third);				//세번째 저장
		
//		//20바이트 넘는 이름 안들어가는지 확인
//		User four = new User("이름 20바이트가 넘어요 넘어요 넘어요 넘어요");	
//		userService.save(four);
		
		//서버 돌고나서 결과값을 띄울때 보기좋게 띄울려고 하는 부분(각각 따로 조회하기 위해서는 아래의 형식으로 하면 됨)
		List<User> list = userService.findAll();		//User에 전체 데이터를 리스트로 불러옴
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

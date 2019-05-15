package kr.co.uclick.repository;

import java.util.List;

import javax.jdo.annotations.Transactional;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import kr.co.uclick.configuration.SpringConfiguration;
import kr.co.uclick.entity.Phone;
import kr.co.uclick.entity.User;
import kr.co.uclick.repository.PhoneRepository;
import kr.co.uclick.repository.UserRepository;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = SpringConfiguration.class)
public class UserRepositoryTest {
	//Repository = 저장소
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private PhoneRepository phoneRepository;
	
	@Test
	@Transactional
	public void oneToMany_TwoWay() {
		User first = new User("Jung");			//첫번째 맴버 Jung
		first.addPhone(new Phone("010-xxxx-xxxx"));//첫번째 맴버 Jung 폰1 추가
		first.addPhone(new Phone("010-yyyy-yyyy"));//첫번째 맴버 Jung 폰2 추가
		
		User second = new User("Dong");			//두번째 맴버 Dong
		second.addPhone(new Phone("010-zzzz-zzzz"));//두번째 맴버 Dong 폰1 추가
		
		User third = new User("Min");			//세번째 맴버 Min
		
		userRepository.save(first);				//첫번째 저장
		userRepository.save(second);			//두번째 저장
		userRepository.save(third);				//세번째 저장
		
		//서버 돌고나서 결과값을 띄울때 보기좋게 띄울려고 하는 부분(각각 따로 조회하기 위해서는 아래의 형식으로 하면 됨)
		List<User> list = userRepository.findAll();		//User에 전체 데이터를 리스트로 불러옴
		List<Phone> list1 = phoneRepository.findAll();	//Phone에 전체 데이터를 리스트로 불러옴
		
		//User 리스트
		for( User u : list ) {							//for문을 list길이 만큼 돌려서 출력
			System.out.println("UserID:"+u.getId()+", Name:"+ u.getName());	
		}
		
		//Phone 리스트(1대 다에서는 다에서 1을 불러오는게 좋기 때문에 Phone에서 user쪽 목록을 불러오는게 효율성이 좋음)
		for( Phone p : list1 ) {						//for문을 list길이 만큼 돌려서 출력
			System.out.println("PhoneID:"+p.getId()+", PhoneNumber:"+ p.getPhoneNumber()+", Name:"+p.getUser().getName());
		}
		
//		//1대 다 관계에서는 다에서 1을 불러와서 조회하는게 좋음(효율성을 위해) 아래의 형식이 보기는 편하지만 서버에 부담이 됨
//		domain의 User.jave에 @Override해서 써준부분과 연결되어 있음
//		List<User> list = userRepository.findAll();//맴버에 전체 데이터를 리스트로 불러옴
//		for( User m : list ) {					//for문을 list길이 만큼 돌려서 출력
//			System.out.println(m.toString());	//서버 돌고나서 결과값을 띄울때 보기좋게 띄울려고 하는 부분
//		}			
		
//		userRepository.deleteAll();				//전체 제거(안됨...직접 지우고 다시 돌려야 오류없음)
	}
	
//	@Test
//	@Transactional
//	public void deleteTest() {
//		Phone phone = phoneRepository.findById(1352).get();
//		System.out.println(phone.getPhoneNumber());
////		phoneRepository.delete(phone);
//		phoneRepository.deleteById(1352);
//	}
}

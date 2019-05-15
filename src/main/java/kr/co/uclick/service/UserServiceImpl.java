package kr.co.uclick.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.uclick.entity.Phone;
import kr.co.uclick.entity.User;
import kr.co.uclick.repository.UserRepository;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private PhoneService phoneService;

	public void save(String name, String phonenumber) {
		
		User user = new User(name);
		userRepository.save(user);
		
		Phone phone = new Phone(user, phonenumber);
		phoneService.save(phone);				//첫번째 저장
	}
	
	//UserServiceAddTest를 위해 남겨둠
	public void save1(User user) {
		userRepository.save(user);
	}
	
	public void update(int userId, String name) {
		User user = userRepository.getOne(userId);
		user.setName(name);
		userRepository.save(user);
	}
	
	@Override
	public void delete(int userId) {
		userRepository.deleteById(userId);
	}

	@Transactional(readOnly = true)
	public List<User> findAll() {
		return userRepository.findAll();
	}

	public User findById(int userId) {
		return userRepository.findById(userId).get();
	}
	
	@Override
	public List<User> findUserByNameLike(String name) {
		// TODO Auto-generated method stub
		return userRepository.findUserByNameLike("%"+name+"%");
	}
	
    //상세 화면
   @Override
   public User view(int id) {
      return userRepository.findById(id).get();
   }
}

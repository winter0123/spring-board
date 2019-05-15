package kr.co.uclick.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.uclick.entity.User;

@Service
public interface UserService {
	
	public void save(String name, String phonenumber);
	public void update(int userId, String name);
	public void delete(int userId);
	public List<User> findAll();
	public List<User> findUserByNameLike(String name);
	public User findById(int userId);
	public User view(int id);
	
	public void save1(User user); //UserServiceAddTest를 위해 남겨둠

}

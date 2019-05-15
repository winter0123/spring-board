package kr.co.uclick.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.uclick.entity.Phone;
import kr.co.uclick.entity.User;
import kr.co.uclick.repository.PhoneRepository;
import kr.co.uclick.repository.UserRepository;

@Service
@Transactional
public class PhoneServiceImpl implements PhoneService {

	@Autowired
	private PhoneRepository phoneRepository;
	
	@Autowired
	private UserRepository userRepository;

	public void save(Phone phone) {
		phoneRepository.save(phone);
	}
	
	public void update(int phoneId, String phoneNumber) {
		int id = phoneId;
		Phone phone = phoneRepository.getOne(id);
		phone.setPhoneNumber(phoneNumber);
		phoneRepository.save(phone);
	}

	@Transactional(readOnly = true)
	public List<Phone> findAll() {
		return phoneRepository.findAll();
	}

	@Override
	public void delete(int phoneId) {
		phoneRepository.deleteById(phoneId);
	}
	
	@Override
	public Phone findByPhoneNumber(String phoneNumber) {
		return phoneRepository.findByPhoneNumber(phoneNumber);
	}
	
	@Override
	public List<Phone> findAllByUserId(int user_id) {
		List<Phone> res = new ArrayList<Phone>();
		User u = userRepository.findById(user_id).get();
		List<Phone> list = phoneRepository.findAllByUser(u);
		for(Phone item: list) {
			res.add(item);
		}
		return res;
	}

	@Override
	public Phone findAllById(int phoneId) {
		return phoneRepository.findById(phoneId).get();
	}

	@Override
	public List<Phone> findByPhoneNumberContaining(String title) {
		return phoneRepository.findByPhoneNumberContaining(title);
	}
}

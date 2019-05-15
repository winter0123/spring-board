package kr.co.uclick.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.uclick.entity.Phone;

@Service
public interface PhoneService {
	
	public void save(Phone phone);		//폰 저장
	public void update(int phoneId, String phoneNumber); //폰 수정
	public void delete(int phoneId);
	public List<Phone> findAll();		//전체 리스트
	public Phone findByPhoneNumber(String phoneNumber);
	
	public List<Phone> findAllByUserId(int user_id);
	public Phone findAllById(int phoneId);
	public List<Phone> findByPhoneNumberContaining(String title);
}

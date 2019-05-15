package kr.co.uclick.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.QueryHints;
import org.springframework.stereotype.Repository;

import kr.co.uclick.entity.Phone;
import kr.co.uclick.entity.User;

import javax.persistence.QueryHint;

@Repository
public interface PhoneRepository  extends JpaRepository<Phone, Integer>{
	
	@QueryHints(value= {
			@QueryHint(name="org.hibernate.cacheable", value="true"),
			@QueryHint(name="org.hibernate.cacheMode", value="NORMAL"),
	})
	public List<Phone> findAllByUser(User user);
	
	public List<Phone> findByPhoneNumberContaining(String title);
	public Phone findByPhoneNumber(String phoneNumber);
}

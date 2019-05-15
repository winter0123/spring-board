package kr.co.uclick.entity;

import javax.persistence.Cacheable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

import org.hibernate.annotations.CacheConcurrencyStrategy;


@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name="phone")
public class Phone {
	
	@Id
	@TableGenerator(name = "phone")
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "phone")
	@Column
	private Integer id;
	
	@Column
	private String phoneNumber;	//휴대폰 번호
	
	@ManyToOne	//여러개 -- >하나만
	@JoinColumn(name="user_id")
	private User user;
	
	public Phone() {	
	}
	
	public Phone(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	public Phone(User user, String phoneNumber) {
		this.user = user;
		this.phoneNumber = phoneNumber;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
	@Override 	//서버 돌고나서 결과값을 띄울때 보기좋게 띄울려고 하는 부분
	public String toString() {
		String result = "[phone_" + id + "]" + phoneNumber;	//id와 phoneNumber를 뽑아서 result에 저장
		return result;
	}


}

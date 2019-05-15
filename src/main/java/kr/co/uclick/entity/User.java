package kr.co.uclick.entity;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.Cacheable;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

import org.hibernate.annotations.CacheConcurrencyStrategy;


@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name="user")
public class User {
	@Id	//primary key를 가지는 변수에 설정
	@TableGenerator(name = "user")
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "user")
	@Column
	private Integer id;
	
	@Column(name = "name", length = 20)	//이름 컬럼 20yte 길이 제한
	private String name;
	
	//fetch=FetchType.EAGER //fetch타입의 기본형태는 LAZY임 but LAZY는 하위 항목을 안들고와서 밑의 toString을 할때 문제가 생김
	//1대 다(999..)의 관계에서는 다의 리스트에서 1을 조회하는게 시스템에 무리가 안감 
//	@OneToMany(mappedBy="user", fetch=FetchType.LAZY, cascade = CascadeType.MERGE)
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="user")	// 하나 --> 여러개
	@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.NONE)	
	private Collection<Phone> phones;
	
	//생성자 함수 = 클래스 이름과 같은 부분이 생성자 함수
	//기본 생성자는 꼭 필요함
	
	public User() {
	}
	
	public User(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getId() {		
		return id;
	}
	
	public void setId(Integer id) {	
		this.id = id;			
	}								



	public Collection<Phone> getPhones() {
		if( phones == null) {
			phones = new ArrayList<Phone>();
		}
		return phones;
	}
	
	public void setPhones(Collection<Phone> phones) {
		this.phones = phones;
	}
	
	public void addPhone(Phone p) {
		Collection<Phone> phones = getPhones();
		p.setUser(this);
		phones.add(p);
	}
	

	
	@Override
	//서버 돌고나서 결과값을 띄울때 보기좋게 띄울려고 하는 부분(FATCH에서 .EAGER을 사용해야 조회가 됨:시스템에 무리가 갈 수 있음)
	public String toString() {
		String result = "[" + id + "]" + name;	//User에서 id와 name을 result에 저장
		for( Phone p : getPhones() ) {
			result += "\n" + p.toString();		//Phone에서 toString을 불러와서 위의 result의 뒤에 붙임(for구문을 돌려 휴대폰 수만큼 뽑음)
		}
		return result;
	}
}

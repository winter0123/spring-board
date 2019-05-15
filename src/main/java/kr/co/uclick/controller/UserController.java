package kr.co.uclick.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.uclick.entity.Phone;
import kr.co.uclick.entity.User;
import kr.co.uclick.service.PhoneService;
import kr.co.uclick.service.UserService;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;
	
	@Autowired
	private PhoneService phoneService;

	@SuppressWarnings("null")
	@RequestMapping(value = "list")
	public String list(@RequestParam HashMap<String, String>map, Model model) {
		model.addAttribute("users", userService.findAll());
        
        // 검색관련기능
        String opt = map.get("opt");
        String title = map.get("title");
        boolean search = false; // false 검색, true 미검색
        
        List<User> list = null;
    	List<Phone> phones = new ArrayList<Phone>();
        //미검색일 때
        if(title==null || title.equals("")) {
           search = true;
           list = userService.findAll(); //리스트 변수에 결과값을 담는다.
        } 
        //검색일 때
        else {
           search = false;
           if(opt.equals("name")) {
        	   
        	   list = userService.findUserByNameLike(title); //리스트 변수에 결과값을 담는다.
           } else if(opt.equals("phone")) {
	          	phones = phoneService.findByPhoneNumberContaining(title);
	    		list = new ArrayList<User>(); //(빈 list에 객체를 담는다.)
	          	for(Phone phone : phones) {
	          		if(!list.contains(phone.getUser())) {	//list에 User가 포함되지 않는다면
	          			list.add(phone.getUser());			//list에 User를 추가함
	          		}
	          	}
           }
        }

        model.addAttribute("list",list); //모델에 name, value 를 담는다.
        model.addAttribute("search",search);
        model.addAttribute("opt",opt);
        model.addAttribute("title",title);

		return "list";
	}
	
	@RequestMapping(value = "view")	//상세보기
	public String view(int id, Model model) {
        User user = userService.view(id);
        List<Phone> phones = phoneService.findAllByUserId(id);
        model.addAttribute("user",user);
        model.addAttribute("phones",phones);
		return "view";
	}
	
	@RequestMapping(value = "newform")	//신규 유저 생성
	public String newForm(Model model) {
		return "newform";
	}
	
	@RequestMapping(value = "phoneAddform")	//휴대폰 추가(기존유저에)
	public String phoneNewForm(int userId,Model model) {
		User user = userService.view(userId);
		model.addAttribute("user",user);
		return "phoneAddform";
	}
	
	@RequestMapping(value = "phoneEditform")	//휴대폰 번호 수정
    public String phoneEditform(int phoneId, Model model) {
        Phone phone = phoneService.findAllById(phoneId);
        model.addAttribute("phone",phone);
		return "phoneEditform";
	}

	@RequestMapping(value = "save", method = RequestMethod.POST)//신규 유저 저장
	public String save(@RequestParam HashMap<String, String>map, Model model) {
		User user = new User(map.get("name"));
		user.addPhone(new Phone(map.get("phonenumber")));
		userService.save1(user);
		return "redirect:list.html";
	}
	
	@RequestMapping(value = "phoneSave", method = RequestMethod.POST) //신규 휴대폰 추가(기존유저)
	public String phoneSave(@RequestParam HashMap<String, String>map) {
		int userid =  Integer.parseInt(map.get("id"));
		User userId = userService.findById(userid);
		String phoneNumber = map.get("phoneNumber");
		Phone p = new Phone(userId, phoneNumber);
		phoneService.save(p);
		return "redirect:view?id="+userId.getId();
	}
	
	@RequestMapping(value = "update", method = {RequestMethod.GET, RequestMethod.POST})	//유저 이름 수정
	public String update(@RequestParam HashMap<String, String>map, Model model) {
		String name = map.get("name");
		int userId = Integer.parseInt(map.get("id"));
		userService.update(userId,name);
		return "redirect:list.html";
	}
	
	@RequestMapping(value = "phoneUpdate", method = {RequestMethod.GET, RequestMethod.POST})//휴대폰 번호 수정
	public String phoneUpdate(@RequestParam HashMap<String, String>map) {
		int phoneId = Integer.parseInt(map.get("id"));
		String phoneNumber = map.get("phoneNumber");
		phoneService.update(phoneId,phoneNumber);
		Phone phone = phoneService.findAllById(phoneId);
		int userId = phone.getUser().getId();
		return "redirect:view?id="+userId;
	}

	@RequestMapping(value = "delete")	//유저 삭제
	public String delete(int userId, Model model) {
		userService.delete(userId);
		return "redirect:list";
	}
	
	@RequestMapping(value = "phoneDelete")	//휴대폰 번호 삭제
	public String phonedelete(int phoneId, Model model) {
		Phone phone = phoneService.findAllById(phoneId);
		int userId = phone.getUser().getId();
		phoneService.delete(phoneId);
		return "redirect:view?id="+userId;
	}

}

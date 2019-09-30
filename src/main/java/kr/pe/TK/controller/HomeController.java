package kr.pe.TK.controller;

import java.io.File;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.pe.TK.domain.CafeVO;
import kr.pe.TK.domain.MemberVO;
import kr.pe.TK.domain.PageMaker;
import kr.pe.TK.domain.SearchCriteria;
import kr.pe.TK.service.BoardService;

@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired                                                                                                                              
	private BoardService service;                                                                                                           
	     
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "cafe";
	}
	
	@RequestMapping(value="newid", method = RequestMethod.GET)                                                                           
	public String newid() throws Exception {
		return "Newid";
	}
	
	@RequestMapping(value="login", method = RequestMethod.POST)                                                                           
	public ResponseEntity<String> login(@RequestBody MemberVO vo, HttpServletRequest request) throws Exception {
		MemberVO member = new MemberVO();
		member = service.login(vo);
		HttpSession session = request.getSession();
		ResponseEntity<String> entity = null;
		try {
			if(member.getUserid()!=null) {
				if(member.getUserpw().equals(vo.getUserpw())) {
					session.setAttribute("userid",member.getUserid());
					session.setAttribute("usernick",member.getUsernick());
					entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				}else {
					entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
				}
			}else {
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
		}catch(Exception e) {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
		return entity;
	}
	
	@RequestMapping(value="logout", method = RequestMethod.GET)                                                                           
	public String logout(MemberVO vo, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	
	@RequestMapping(value="chkcafeurl", method = RequestMethod.GET)                                                                           
	public ResponseEntity<Integer> chkcafeurl(@RequestParam Map map) throws Exception {
		ResponseEntity<Integer> entity = new ResponseEntity<Integer>(service.chkcafeurl(map), HttpStatus.OK);
		// 매개변수로 숫자가 들어가면 되고 영어가 들어가면 안됨 왜? 왜옹애애ㅗ애ㅗ애ㅗ애ㅗ앵!?!?		
		return entity;
	}

	@RequestMapping(value="makecafe", method = RequestMethod.POST)                                                                           
	public String makecafe(@RequestParam Map map, MultipartHttpServletRequest multi, Model model) throws Exception {
		List<MultipartFile> files = multi.getFiles("cafeinfoimg");
		String filePath ="C:\\upload\\temp\\";
		File file = new File(filePath);

		for(int i=0; i<files.size(); i++) {
			file = new File(filePath+files.get(i).getOriginalFilename());
			//files.get(i).transferTo(file); 
			}      

		map.put("cafeinfoimg", files.get(0).getOriginalFilename());
		map.put("cafeheadimg", files.get(1).getOriginalFilename());
		String cafeurl="";
		for(int i=0; i<5; i++) {
		int abc = (int)(Math.random()*26)+65;
		cafeurl+=(char)abc;
		}
		map.put("cafeurl", cafeurl);
		service.makecafe(map);
		return "redirect:/cafe/list/"+map.get("cafeurl")+"/main";
	}
	
	@RequestMapping(value="iscafe", method = RequestMethod.POST)                                                                           
	public ResponseEntity<String> iscafe(@RequestBody MemberVO vo) throws Exception {
		ResponseEntity<String> entity = null;
		int iscafe = service.iscafe(vo);
		if(iscafe==0) {
			entity = new ResponseEntity<String>("0", HttpStatus.OK);
		}
		if(iscafe==1) {
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		}
		return entity;
	}
	
	@RequestMapping(value="isid", method = RequestMethod.POST)                                                                           
	public ResponseEntity<String> isid(@RequestBody MemberVO vo) throws Exception {
		ResponseEntity<String> entity = null;
		String isid = service.isid(vo);
		if(isid!=null) {
			entity = new ResponseEntity<String>("0", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		}
		return entity;
	}
	
	@RequestMapping(value="makeid", method = RequestMethod.POST)                                                                           
	public String makeid(MemberVO vo) throws Exception {
		service.newid(vo);
		return "redirect:/";
	}
	
	@RequestMapping(value="cafeinfo/{userid}", method = RequestMethod.GET)                                                                           
	public ResponseEntity<CafeVO> cafeinfoget(@PathVariable("userid") String userid, Model model) throws Exception {
		ResponseEntity<CafeVO> entity = new ResponseEntity<>(service.cafeinfo(userid), HttpStatus.OK);
		return entity;
	}
	
	
	
	
	@RequestMapping(value="test", method = RequestMethod.GET)
	public String ajaxTest() {
		return "test";
	}
	
}

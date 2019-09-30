package kr.pe.TK.controller;                                                                                                               
                                                                                                                                            
import java.net.URLEncoder;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.pe.TK.domain.BoardVO;
import kr.pe.TK.domain.BoardlistVO;
import kr.pe.TK.domain.CafeVO;
import kr.pe.TK.domain.MemberVO;
import kr.pe.TK.domain.PageMaker;
import kr.pe.TK.domain.ReplyVO;
import kr.pe.TK.domain.SearchCriteria;
import kr.pe.TK.service.BoardService;                                                                                                      
                                                                                                                                            
@Controller                                                                                                                                 
@RequestMapping("cafe")                                                                                                                   
public class CafeController {                                                                                                        
	private static final Logger logger = LoggerFactory.getLogger(CafeController.class);                                              

	@Autowired                                                                                                                              
	private BoardService service;                                                                                                           

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpServletRequest request, @RequestParam Map map) throws Exception {
		cri.setPerPageNum(8);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		model.addAttribute("btllist", service.getbtllist(cri));
		pageMaker.setTotalCount(service.getbtllistcount(cri));
		model.addAttribute("pageMaker", pageMaker);
		return "CafeAll";
	}
	
	@RequestMapping(value="list/{url}/{category}", method = RequestMethod.GET)                                                                               
	public String listPage(@ModelAttribute("cri") SearchCriteria cri, Model model, @PathVariable("url") String cafeurl, @PathVariable("category") String category, HttpServletRequest request, @RequestParam Map map) throws Exception {                                       
		model.addAttribute("action", "Boardlist");
		PageMaker pageMaker = new PageMaker();
		if(category.equals("main")) {
			category = "공지사항";
		}
		if(category.equals("Write")) {
			model.addAttribute("action", "Write");
		}else if(category.equals("Readpage")){
			
			cri.setPerPageNum(15);
			map.put("pageStart", cri.getPageStart());
			map.put("perPageNum", cri.getPerPageNum());
			pageMaker.setCri(cri);
			model.addAttribute("reply", service.replylist(map));
			System.out.println("asddsd"+cri.getBno());
			pageMaker.setTotalCount(service.getreplylistcount(cri));
			model.addAttribute("pageMaker", pageMaker);
			
			model.addAttribute(service.read(map));
			model.addAttribute("action", "Readpage");
		}else if(category.equals("Modifypage")){
			model.addAttribute(service.read(map));
			model.addAttribute("action", "Modifypage");
			
		}else if(category.equals("전체글보기")) {
			cri.setCafeurl(cafeurl);
			cri.setCategory2(category);
			pageMaker.setCri(cri);
			model.addAttribute("list", service.listSearchCriteriaAll(cri));
			pageMaker.setTotalCount(service.listSearchCountAll(cri));
			model.addAttribute("pageMaker", pageMaker);
		}else {
			pageMaker.setCri(cri);
			cri.setCafeurl(cafeurl);
			cri.setCategory2(category);
			model.addAttribute("list", service.listSearchCriteria(cri));
			pageMaker.setTotalCount(service.listSearchCount(cri));
			model.addAttribute("pageMaker", pageMaker);
		}
		
		
		request.setAttribute("cafeurl", cafeurl);
		model.addAttribute("category", category);
		model.addAttribute("cafe", service.getcafe(cafeurl));
		map.put("cafeurl", cafeurl);
		model.addAttribute("boardlist", service.getboardlist(map));
		
		HttpSession session = request.getSession();
		model.addAttribute("userid", (String)session.getAttribute("userid"));
		return "Board";
		
		
	}
	
	@RequestMapping(value="boardlist/{cafeurl}", method = RequestMethod.GET)                                                                           
	public ResponseEntity<List<BoardlistVO>> cafeinfoget(@PathVariable("cafeurl") String cafeurl, @RequestParam Map map) throws Exception {
		map.put("cafeurl", cafeurl);
		ResponseEntity<List<BoardlistVO>> entity = null;
		try {
			entity = new ResponseEntity<>(service.getboardlist(map), HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	                                                                                                                                        
	@RequestMapping(value = "removePage", method = RequestMethod.POST)                                                                      
	public String remove(@RequestParam Map map, @ModelAttribute("cri") SearchCriteria cri, RedirectAttributes rttr) throws Exception {      
		service.remove(map);                                                                                                                
		rttr.addFlashAttribute("page", cri.getPage());                                                                                      
		rttr.addFlashAttribute("perPageNum", cri.getPerPageNum());                                                                          
		rttr.addFlashAttribute("searchType", cri.getSearchType());                                                                          
		rttr.addFlashAttribute("keword", cri.getKeyword());                                                                                 
		rttr.addFlashAttribute("msg", "SUCCESS");     
		String cafeurl = URLEncoder.encode((String)map.get("cafeurl"), "UTF-8");
		String category = URLEncoder.encode((String)map.get("category2"), "UTF-8");
		return "redirect:list/"+cafeurl+"/"+category;
	}                                                                                                                                                                                                                                                                    
	
	@RequestMapping(value = "modifypwchk", method = RequestMethod.GET)                                                                      
	public ResponseEntity<String> modifypwchk(@RequestParam Map map) throws Exception{
		ResponseEntity<String> entity = new ResponseEntity<String>(service.chkboardpw(map), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value = "modifyPage", method = RequestMethod.POST)                                                                      
	public String modifyPaging(@RequestParam Map map, @ModelAttribute("cri") SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("page", cri.getPage());                                                                                      
		rttr.addFlashAttribute("perPageNum", cri.getPerPageNum());                                                                          
		rttr.addFlashAttribute("searchType", cri.getSearchType());                                                                          
		rttr.addFlashAttribute("keword", cri.getKeyword());                                                                                 
		rttr.addFlashAttribute("msg", "SUCCESS");
		String cafeurl = URLEncoder.encode((String)map.get("cafeurl"), "UTF-8");
		
		service.modify(map);
		return "redirect:list/"+cafeurl+"/Readpage?bno="+map.get("bno");
	}
                                                                                                                                            
	@RequestMapping(value="register", method = RequestMethod.POST)                                                                          
	public String registerPOST(BoardVO board) throws Exception {                                        
		service.regist(board);
		String category = URLEncoder.encode(board.getCategory2(), "UTF-8");
		return "redirect:list/"+board.getCafeurl()+"/"+category;
	}      
	
	
	@RequestMapping(value="login", method = RequestMethod.POST)                                                                           
	public ResponseEntity<String> login(@RequestBody MemberVO vo, Model model, HttpServletRequest request) throws Exception {
		MemberVO member = new MemberVO();
		member = service.login(vo);
		HttpSession session = request.getSession();
		ResponseEntity<String> entity = null;
		
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
		return entity;
	}
	
	@RequestMapping(value="logout", method = RequestMethod.POST)                                                                           
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String logout="";
		session.invalidate();
		
		return logout;
	}
	
	@RequestMapping(value="getcafe", method = RequestMethod.GET)                                                                           
	public ResponseEntity<CafeVO> getcafe(@RequestParam String cafeurl, HttpServletRequest request) throws Exception {
		ResponseEntity<CafeVO> entity = new ResponseEntity<CafeVO>(service.getcafe(cafeurl),HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="addboardcate2", method = RequestMethod.GET)                                                                           
	public String addboardcate2(@RequestParam Map map, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String name = URLEncoder.encode((String)map.get("name"), "UTF-8");
		int count = service.addboardcate2_count(map);
		int cate1 = service.addboardcate2_cate1(map);
		map.put("cate2", count+1);
		map.put("cate1", cate1);
		map.put("kindcate", "cate2");
		int end = service.lineupend(map);
		service.addboardcate2(map);
		return "redirect:/cafe/list/"+map.get("cafeurl")+"/"+name;
	}
	
	@RequestMapping(value="addboardcate1", method = RequestMethod.GET)                                                                           
	public String addboardcate1(@RequestParam Map map, HttpServletRequest request, HttpServletResponse response) throws Exception {
		int count = service.addboardcate1_count(map)+1;
		int random = (int)(Math.random()*100000);
		String name = URLEncoder.encode("기본게시판"+random, "UTF-8");
		map.put("basic", random);
		map.put("cate1", count);
		service.addboardcate1(map);
		return "redirect:/cafe/list/"+map.get("cafeurl")+"/"+name;
	}
	
	@RequestMapping(value="prikeycate/{cafeurl}/{kind}", method = RequestMethod.GET)                                                                           
	public ResponseEntity<List<BoardlistVO>> prikeycate(@PathVariable() Map map) throws Exception {
		ResponseEntity<List<BoardlistVO>> entity = new ResponseEntity<>(service.prikeycate(map), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="adjcate", method = RequestMethod.GET)                                                                           
	public String adjcate(@RequestParam Map map) throws Exception {
		
		if(map.get("kind").equals("category1")) {
			map.put("kindcate", "category1");
		}else {
			map.put("kindcate", "category2");
		}
		service.adjcateboard(map);
		service.adjcate(map);
		return "redirect:/cafe/list/"+map.get("cafeurl")+"/main";
	}

	@RequestMapping(value="removeboard", method = RequestMethod.GET)                                                                           
	public String removeboard(@RequestParam Map map) throws Exception {
		if(map.get("kind").equals("category2")) {

			map.put("kindcate", "cate1");
			int cate1inthis = service.lineupcount(map);
			map.put("kindcate", "cate2");
			int cate2inthis = service.lineupcount(map);
			map.put("cate1inthis", cate1inthis);
			int end = service.lineupend(map);
			
			/* category2의 마지막게시물 삭제 시 방지처리 */
			/*if(end==1) {
				service.removeboard(map);
				service.removeboardNO(map);
				return "redirect:/cafe/list/"+map.get("cafeurl")+"/main";
			}*/
			for(int i=cate2inthis; i<end; i++) {
				map.put("cate2inthis", i);
				service.lineup(map);
			}
			
		}else {
			map.put("kindcate", "cate1");
			int cate1inthis = service.lineupcount(map);
			int end = service.lineupend(map);
			for(int i=cate1inthis; i<end; i++) {
				map.put("cate2inthis", i);	//cate2inthis 이름!=뜻 냅두면됨.
				service.lineup(map);
			}

		}
		service.removeboardlist(map);
		service.removeboard(map);
		return "redirect:/cafe/list/"+map.get("cafeurl")+"/main";
	}
	
	@RequestMapping(value="removeboardnone", method = RequestMethod.GET)                                                                           
	public ResponseEntity<Integer> removeboardnone(@RequestParam Map map) throws Exception {
		map.put("kindcate", "cate1");
		int cate1inthis = service.lineupcount(map);
		map.put("kindcate", "cate2");
		int cate2inthis = service.lineupcount(map);
		map.put("cate1inthis", cate1inthis);
		Integer abc = service.lineupend(map);
		ResponseEntity<Integer> entity = new ResponseEntity<>(abc, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="position", method = RequestMethod.GET)                                                                           
	public String position(@RequestParam Map map) throws Exception {
			int base = 0;
			int data = 0;
			if(map.get("kind").equals("category1")) {
				map.put("kindcate", "cate1");
				base = service.lineupcount(map);
				if(map.get("updown").equals("up")) {
					data = base-1;
				}else {
					data = base+1;
				}
			}else {
				map.put("kindcate", "cate1");
				int cate1inthis = service.lineupcount(map);
				map.put("cate1inthis", cate1inthis);
				map.put("kindcate", "cate2");
				base = service.lineupcount(map);
				if(map.get("updown").equals("up")) {
					data = base-1;
				}else {
					data = base+1;
				}
			}
			int[] ary = {base, data, 1000, base, data};
			for(int i=0; i<3; i++) {
				map.put("data1", ary[i]);
				map.put("data2", ary[i+2]);
				service.positionup(map);
			}
		return "redirect:/cafe/list/"+map.get("cafeurl")+"/main";
	}
	
	@RequestMapping(value="setreply", method = RequestMethod.POST)                                                                           
	public ResponseEntity<String> setreply(@RequestBody ReplyVO vo, Model model, HttpServletRequest request) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			if(vo.getMethod().equals("대댓")) {
				service.setre_reply(vo);
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}else {
				service.setreply(vo);
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="delreply", method = RequestMethod.POST)                                                                           
	public ResponseEntity<String> delreply(@RequestBody ReplyVO vo) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			service.delreply(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
		
		return entity;
	}
}                                                                                                                                           
                                                                                                                                            
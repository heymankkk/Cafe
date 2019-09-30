package kr.pe.TK.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.TK.domain.BoardVO;
import kr.pe.TK.domain.BoardlistVO;
import kr.pe.TK.domain.CafeVO;
import kr.pe.TK.domain.Criteria;
import kr.pe.TK.domain.MemberVO;
import kr.pe.TK.domain.ReplyVO;
import kr.pe.TK.domain.SearchCriteria;
import kr.pe.TK.persistence.BoardDAO;

@Service
public class BoardService {
	@Autowired
	private BoardDAO dao;
	
	public MemberVO login(MemberVO vo) throws Exception{
		return dao.login(vo);
	}
	
	public void regist(BoardVO board) throws Exception {
		dao.create(board);
	}
	
	public void modify(Map map) throws Exception {
		dao.update(map);
	}
	
	public void remove(Map map) throws Exception {
		dao.delete(map);
	}
	
	public List<BoardVO> listAll() throws Exception {
		return dao.listAll();
	}
	
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return dao.listCriteria(cri);
	}
	
	public int listcountCriteria(Criteria cri) throws Exception {
		return dao.countPaging(cri);
	}
	
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}
	public List<BoardVO> listSearchCriteriaAll(SearchCriteria cri) throws Exception {
		return dao.listSearchAll(cri);
	}
	
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}
	public int listSearchCountAll(SearchCriteria cri) throws Exception {
		return dao.listSearchCountAll(cri);
	}

	public void makecafe(Map map) throws Exception {
		dao.makecafe(map);
	}

	public int iscafe(MemberVO vo) throws Exception {
		return dao.iscafe(vo);
	}

	public CafeVO cafeinfo(String userid) throws Exception {
		return dao.cafeinfo(userid);
	}

	public CafeVO getcafe(String cafeurl) {
		return dao.getcafe(cafeurl);
	}

	public List<BoardlistVO> getboardlist(Map map) {
		return dao.getboardlist(map);
	}

	public String isid(MemberVO vo) {
		return dao.getisid(vo);
	}

	public void newid(MemberVO vo) {
		dao.newid(vo);
	}

	public void addboardcate2(Map map) {
		dao.addboardcate2(map);
	}

	public int addboardcate2_count(Map map) {
		return dao.addboardcate2_count(map);
	}

	public int addboardcate2_cate1(Map map) {
		return dao.addboardcate2_cate1(map);
	}

	public void addboardcate1(Map map) {
		dao.addboardcate1(map);
	}

	public int addboardcate1_count(Map map) {
		return dao.addboardcate1_count(map);
	}

	public void adjcate(Map map) {
		dao.adjcate(map);
	}
	public void adjcateboard(Map map) {
		dao.adjcateboard(map);
	}

	public List<BoardlistVO> prikeycate(Map map) {
		return dao.prikeycate(map);
	}

	public void removeboard(Map map) {
		dao.removeboard(map);
	}
	
	public void removeboardlist(Map map) {
		dao.removeboardlist(map);
	}
	
	public int lineupcount(Map map) {
		return dao.lineupcount(map);
	}

	public void lineup(Map map) {
		dao.lineup(map);
	}

	public int lineupend(Map map) {
		return dao.lineupend(map);
	}

	public void positionup(Map map) {
		dao.positionup(map);
	}

	public BoardVO read(Map map) {
		return dao.read(map);
	}

	public String chkboardpw(Map map) {
		return dao.chkboardpw(map);
		
	}

	public Integer chkcafeurl(Map map) {
		return dao.chkcafeurl(map);
	}

	public List<CafeVO> getbtllist(SearchCriteria cri) {
		return dao.getbtllist(cri);
	}

	public int getbtllistcount(SearchCriteria cri) {
		return dao.getbtllistcount(cri);
	}

	public List<ReplyVO> replylist(Map map) {
		return dao.replylist(map);
	}

	public void setreply(ReplyVO vo) {
		dao.setreply(vo);
	}

	public void setre_reply(ReplyVO vo) {
		dao.setre_rply(vo);
	}

	public void delreply(ReplyVO vo) {
		dao.delreply(vo);
	}

	public int getreplylistcount(SearchCriteria cri) {
		return dao.getreplylistcount(cri);
	}

	/*public void removeboardNO(Map map) {
		dao.removeboardNO(map);
	}*/


}

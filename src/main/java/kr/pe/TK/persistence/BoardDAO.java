package kr.pe.TK.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.pe.TK.domain.BoardVO;
import kr.pe.TK.domain.BoardlistVO;
import kr.pe.TK.domain.CafeVO;
import kr.pe.TK.domain.Criteria;
import kr.pe.TK.domain.MemberVO;
import kr.pe.TK.domain.ReplyVO;
import kr.pe.TK.domain.SearchCriteria;

@Repository
public class BoardDAO {
	@Autowired
	private SqlSession session;
	
	public MemberVO login(MemberVO vo) throws Exception{
		return session.selectOne("board.login", vo);
	}
	public void create(BoardVO vo) throws Exception {
		session.insert("cafe.create", vo);
	}
	
	public void update(Map map) throws Exception {
		session.update("cafe.update", map);
	}
	
	public void delete(Map map) throws Exception {
		session.delete("cafe.delete", map);
	}
	
	public List<BoardVO> listAll() throws Exception {
		return session.selectList("board.listAll");
	}
	
	public List<BoardVO> listPage(int page) throws Exception {
		if(page <= 0) {page = 1;}
		page = (page -1) *10;
		return session.selectList("board.listPage", page);
	}
	
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return session.selectList("board.listCriteria",cri);
	}
	
	public int countPaging(Criteria cri) throws Exception {
		return session.selectOne("board.countPaging", cri);
	}
	
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList("board.listSearch",cri);
	}
	public List<BoardVO> listSearchAll(SearchCriteria cri) throws Exception {
		return session.selectList("board.listSearchAll",cri);
	}
	
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne("board.listSearchCount", cri);
	}
	public int listSearchCountAll(SearchCriteria cri) throws Exception {
		return session.selectOne("board.listSearchCountAll", cri);
	}
	
	public void makecafe(Map map) throws Exception {
		session.insert("cafe.makecafe", map);
		session.update("cafe.upiscafe", map);
		String[] category1 = {
								"공지사항",
								"공지사항",
								"가입인사/등업신청",
								"가입인사/등업신청",
								"게시판",
								"게시판",
								"게시판"
							  };
		int[] cate1 = {1,1,2,2,3,3,3};
		String[] category2 = {
						    	"공지사항",
						    	"문의",
						    	"가입인사",
						    	"등업신청",
						    	"자유게시판1",
						    	"자유게시판2",
						    	"자유게시판3"
							 };
		int[] cate2 = {1,2,1,2,1,2,3};
		for(int i=0; i<category1.length; i++) {
			map.put("category1", category1[i]);
			map.put("category2", category2[i]);
			map.put("cate1", cate1[i]);
			map.put("cate2", cate2[i]);
			session.insert("cafe.basicboard", map);
		}
	}
	public int iscafe(MemberVO vo) throws Exception {
		return session.selectOne("cafe.iscafe", vo);
	}
	public CafeVO cafeinfo(String userid) throws Exception {
		return session.selectOne("cafe.cafeinfo", userid);
	}
	public CafeVO getcafe(String cafeurl) {
		return session.selectOne("board.getcafe", cafeurl);
	}
	public List<BoardlistVO> getboardlist(Map map) {
		return session.selectList("board.getboardlist", map);
	}
	public String getisid(MemberVO vo) {
		return session.selectOne("board.getisid", vo);
	}
	public void newid(MemberVO vo) {
		session.insert("board.newid", vo);		
	}
	public void addboardcate2(Map map) {
		session.insert("cafe.addboardcate2", map);
	}
	public int addboardcate2_count(Map map) {
		return session.selectOne("cafe.addboardcate2_count", map);
	}
	public int addboardcate2_cate1(Map map) {
		return session.selectOne("cafe.addboardcate2_cate1", map);
	}
	public void addboardcate1(Map map) {
		session.insert("cafe.addboardcate1", map);
	}
	public int addboardcate1_count(Map map) {
		return session.selectOne("cafe.addboardcate1_count", map);
	}
	public void adjcate(Map map) {
		session.update("cafe.adjcate", map);
	}
	public void adjcateboard(Map map) {
		session.update("cafe.adjcateboard", map);
	}

	public List<BoardlistVO> prikeycate(Map map) {
		return session.selectList("cafe.prikeycate", map);
	}

	public void removeboard(Map map) {
		session.delete("cafe.removeboard", map);
	}
	public void removeboardlist(Map map) {
		session.delete("cafe.removeboardlist", map);
	}
	public int lineupcount(Map map) {
		return session.selectOne("cafe.lineupcount", map);
	}
	public void lineup(Map map) {
		session.update("cafe.lineup", map);
		
	}
	public int lineupend(Map map) {
		return session.selectOne("cafe.lineupend", map);
	}
	/*public void removeboardNO(Map map) {
		session.update("cafe.removeboardNO", map);
	}*/
	public void positionup(Map map) {
		session.update("cafe.positionup", map);
		
	}
	public BoardVO read(Map map) {
		session.update("cafe.view", map);
		return session.selectOne("cafe.read", map);
	}
	public String chkboardpw(Map map) {
		return session.selectOne("cafe.chkboardpw", map);
	}
	public Integer chkcafeurl(Map map) {
		return session.selectOne("cafe.chkcafeurl", map);
	}
	public List<CafeVO> getbtllist(SearchCriteria cri) {
		return session.selectList("board.getbtllist", cri);
	}
	public int getbtllistcount(SearchCriteria cri) {
		return session.selectOne("board.getbtllistcount", cri);
	}
	public List<ReplyVO> replylist(Map map) {
		return session.selectList("cafe.replylist", map);
	}

	public void setreply(ReplyVO vo) {
		String maxrno = session.selectOne("cafe.getmaxrno");
		if(maxrno==null) {
			maxrno="0";
		}
		vo.setRno(Integer.parseInt(maxrno)+1);
		session.insert("cafe.setreply", vo);		
	}
	public void setre_rply(ReplyVO vo) {
		int num = session.selectOne("cafe.getmaxnum",vo);
		vo.setNum(num+1);
		session.insert("cafe.setre_reply", vo);		
	}
	public void delreply(ReplyVO vo) {
		session.delete("cafe.delreply", vo);		
	}
	public int getreplylistcount(SearchCriteria cri) {
		return session.selectOne("cafe.getreplylistcount", cri);
	}
}
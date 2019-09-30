package kr.pe.TK.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.TK.domain.Criteria;
import kr.pe.TK.domain.ReplyVO;
import kr.pe.TK.persistence.ReplyDAO;

@Service
public class ReplyService {
	@Autowired
	private ReplyDAO dao;
	
	public void create(ReplyVO vo) throws Exception {
		dao.create(vo);
	}
	public List<ReplyVO> list(Integer bno) throws Exception {
		return dao.list(bno);
	}
	public void update(ReplyVO vo) throws Exception {
		dao.update(vo);
	}
	public void delete(int rno) throws Exception {
		dao.delete(rno);
	}
	public List<ReplyVO> listReplayPage(int bno, Criteria cri) throws Exception{
		return dao.listPage(bno, cri);
	}
	public int count(int bno) throws Exception{
		return dao.count(bno);
	}
}

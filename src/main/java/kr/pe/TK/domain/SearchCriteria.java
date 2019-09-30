package kr.pe.TK.domain;

public class SearchCriteria extends Criteria {
	private String searchType;
	private String keyword;
	private String cafeurl;
	private String category1;
	private String category2;
	private String bno;
	
	public String getBno() {
		return bno;
	}
	public void setBno(String bno) {
		this.bno = bno;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getCafeurl() {
		return cafeurl;
	}
	public void setCafeurl(String cafeurl) {
		this.cafeurl = cafeurl;
	}
	public String getCategory1() {
		return category1;
	}
	public void setCategory1(String category1) {
		this.category1 = category1;
	}
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + ", cafeurl=" + cafeurl
				+ ", category1=" + category1 + ", category2=" + category2 + "]";
	}
	
	
	
}

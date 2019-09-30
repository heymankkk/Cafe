package kr.pe.TK.domain;

public class BoardlistVO {
	private String cafeurl;
	private String category1;
	private String category2;
	
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
		return "BoardlistVO [cafeurl=" + cafeurl + ", category1=" + category1 + ", category2=" + category2 + "]";
	}
	
	
	
}

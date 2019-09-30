package kr.pe.TK.domain;

public class CafeVO {
	private String userid;
	private String cafename;
	private String cafeintro;
	private String cafeurl;
	private String cafepopulation;
	private String cafeinfoimg;
	private String cafeheadimg;
	private String regdate;

	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getCafename() {
		return cafename;
	}
	public void setCafename(String cafename) {
		this.cafename = cafename;
	}
	public String getCafeintro() {
		return cafeintro;
	}
	public void setCafeintro(String cafeintro) {
		this.cafeintro = cafeintro;
	}
	public String getCafeurl() {
		return cafeurl;
	}
	public void setCafeurl(String cafeurl) {
		this.cafeurl = cafeurl;
	}
	public String getCafepopulation() {
		return cafepopulation;
	}
	public void setCafepopulation(String cafepopulation) {
		this.cafepopulation = cafepopulation;
	}
	public String getCafeinfoimg() {
		return cafeinfoimg;
	}
	public void setCafeinfoimg(String cafeinfoimg) {
		this.cafeinfoimg = cafeinfoimg;
	}
	public String getCafeheadimg() {
		return cafeheadimg;
	}
	public void setCafeheadimg(String cafeheadimg) {
		this.cafeheadimg = cafeheadimg;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "CafeVO [userid=" + userid + ", cafename=" + cafename + ", cafeurl=" + cafeurl + ", cafepopulation="
				+ cafepopulation + ", cafeinfoimg=" + cafeinfoimg + ", cafeheadimg=" + cafeheadimg + ", regdate="
				+ regdate + "]";
	}
	
}

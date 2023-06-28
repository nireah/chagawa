package com.chagawa.starPoint.vo;

public class StarPointVO {
	// 번호, 카풀번호, 작성자, 대상자, 별점
	private long no, cpNo;
	private String starter, receiver;
	private long star;
	
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public long getCpNo() {
		return cpNo;
	}
	public void setCpNo(long cpNo) {
		this.cpNo = cpNo;
	}
	public String getStarter() {
		return starter;
	}
	public void setStarter(String starter) {
		this.starter = starter;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public long getStar() {
		return star;
	}
	public void setStar(long star) {
		this.star = star;
	}
	
	@Override
	public String toString() {
		return "StarPointVO [no=" + no + ", cpNo=" + cpNo + ", starter=" + starter + ", receiver=" + receiver
				+ ", star=" + star + "]";
	}

} // end of StarPointVO class

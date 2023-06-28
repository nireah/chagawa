package com.chagawa.carpool.vo;

import java.util.List;

public class CarpoolVO {

	private Long no;
	private String regTime, id, nickname, profileImage, startRegion, startAddress, arriveRegion, arriveAddress,
			startTimePre, arriveTimePre, startTime, arriveTime, status, carModel, carNo, memo, pstatus;
	private Integer price, point, seats, reviewed, star, driveCount, starCount, psgAppCount, psgFixCount, psgGotCount,
			psgArrCount;
	private Double starAvg, startLat, startLng, arriveLat, arriveLng;
	private List<PassengerVO> psgList;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getRegTime() {
		return regTime;
	}
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public String getStartRegion() {
		return startRegion;
	}
	public void setStartRegion(String startRegion) {
		this.startRegion = startRegion;
	}
	public String getStartAddress() {
		return startAddress;
	}
	public void setStartAddress(String startAddress) {
		this.startAddress = startAddress;
	}
	public String getArriveRegion() {
		return arriveRegion;
	}
	public void setArriveRegion(String arriveRegion) {
		this.arriveRegion = arriveRegion;
	}
	public String getArriveAddress() {
		return arriveAddress;
	}
	public void setArriveAddress(String arriveAddress) {
		this.arriveAddress = arriveAddress;
	}
	public String getStartTimePre() {
		return startTimePre;
	}
	public void setStartTimePre(String startTimePre) {
		this.startTimePre = startTimePre;
	}
	public String getArriveTimePre() {
		return arriveTimePre;
	}
	public void setArriveTimePre(String arriveTimePre) {
		this.arriveTimePre = arriveTimePre;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getArriveTime() {
		return arriveTime;
	}
	public void setArriveTime(String arriveTime) {
		this.arriveTime = arriveTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCarModel() {
		return carModel;
	}
	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}
	public String getCarNo() {
		return carNo;
	}
	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getPstatus() {
		return pstatus;
	}
	public void setPstatus(String pstatus) {
		this.pstatus = pstatus;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getPoint() {
		return point;
	}
	public void setPoint(Integer point) {
		this.point = point;
	}
	public Integer getSeats() {
		return seats;
	}
	public void setSeats(Integer seats) {
		this.seats = seats;
	}
	public Integer getReviewed() {
		return reviewed;
	}
	public void setReviewed(Integer reviewed) {
		this.reviewed = reviewed;
	}
	public Integer getStar() {
		return star;
	}
	public void setStar(Integer star) {
		this.star = star;
	}
	public Integer getDriveCount() {
		return driveCount;
	}
	public void setDriveCount(Integer driveCount) {
		this.driveCount = driveCount;
	}
	public Integer getStarCount() {
		return starCount;
	}
	public void setStarCount(Integer starCount) {
		this.starCount = starCount;
	}
	public Integer getPsgAppCount() {
		return psgAppCount;
	}
	public void setPsgAppCount(Integer psgAppCount) {
		this.psgAppCount = psgAppCount;
	}
	public Integer getPsgFixCount() {
		return psgFixCount;
	}
	public void setPsgFixCount(Integer psgFixCount) {
		this.psgFixCount = psgFixCount;
	}
	public Integer getPsgGotCount() {
		return psgGotCount;
	}
	public void setPsgGotCount(Integer psgGotCount) {
		this.psgGotCount = psgGotCount;
	}
	public Integer getPsgArrCount() {
		return psgArrCount;
	}
	public void setPsgArrCount(Integer psgArrCount) {
		this.psgArrCount = psgArrCount;
	}
	public Double getStarAvg() {
		return starAvg;
	}
	public void setStarAvg(Double starAvg) {
		this.starAvg = starAvg;
	}
	public Double getStartLat() {
		return startLat;
	}
	public void setStartLat(Double startLat) {
		this.startLat = startLat;
	}
	public Double getStartLng() {
		return startLng;
	}
	public void setStartLng(Double startLng) {
		this.startLng = startLng;
	}
	public Double getArriveLat() {
		return arriveLat;
	}
	public void setArriveLat(Double arriveLat) {
		this.arriveLat = arriveLat;
	}
	public Double getArriveLng() {
		return arriveLng;
	}
	public void setArriveLng(Double arriveLng) {
		this.arriveLng = arriveLng;
	}
	public List<PassengerVO> getPsgList() {
		return psgList;
	}
	public void setPsgList(List<PassengerVO> psgList) {
		this.psgList = psgList;
	}
	@Override
	public String toString() {
		return "CarpoolVO [no=" + no + ", regTime=" + regTime + ", id=" + id + ", nickname=" + nickname
				+ ", profileImage=" + profileImage + ", startRegion=" + startRegion + ", startAddress=" + startAddress
				+ ", arriveRegion=" + arriveRegion + ", arriveAddress=" + arriveAddress + ", startTimePre="
				+ startTimePre + ", arriveTimePre=" + arriveTimePre + ", startTime=" + startTime + ", arriveTime="
				+ arriveTime + ", status=" + status + ", carModel=" + carModel + ", carNo=" + carNo + ", memo=" + memo
				+ ", pstatus=" + pstatus + ", price=" + price + ", point=" + point + ", seats=" + seats + ", reviewed="
				+ reviewed + ", star=" + star + ", driveCount=" + driveCount + ", starCount=" + starCount
				+ ", psgAppCount=" + psgAppCount + ", psgFixCount=" + psgFixCount + ", psgGotCount=" + psgGotCount
				+ ", psgArrCount=" + psgArrCount + ", starAvg=" + starAvg + ", startLat=" + startLat + ", startLng="
				+ startLng + ", arriveLat=" + arriveLat + ", arriveLng=" + arriveLng + ", psgList=" + psgList + "]";
	}

	

}

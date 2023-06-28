package com.chagawa.carpool.service;

import com.chagawa.carpool.dao.CarpoolDAO;
import com.chagawa.carpool.vo.CarpoolVO;
import com.chagawa.carpool.vo.PassengerVO;
import com.chagawa.main.ServiceInterface;

public class CarpoolStartServiceImpl implements ServiceInterface {

	private CarpoolDAO dao;

	@Override
	public void setDao(Object obj) {
		this.dao = (CarpoolDAO) obj;
	}

	@Override
	public Object service(Object obj) throws Exception {
		Long no = (Long) obj;
		
		PassengerVO pvo = new PassengerVO();
		pvo.setStatus("미탑승");
		pvo.setCpNo(no);
		dao.updatePsgStatus(pvo); //미탑승 동승자 상태 변경
		
		CarpoolVO vo = new CarpoolVO();
		vo.setNo(no);
		vo.setStatus("운행중");
		return dao.updateCpStatus(vo); //카풀 상태 운행중으로 변경
	} 
}

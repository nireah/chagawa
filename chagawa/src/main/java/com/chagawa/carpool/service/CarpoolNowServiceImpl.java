package com.chagawa.carpool.service;

import com.chagawa.carpool.dao.CarpoolDAO;
import com.chagawa.carpool.vo.CarpoolVO;
import com.chagawa.main.ServiceInterface;

public class CarpoolNowServiceImpl implements ServiceInterface {

	private CarpoolDAO dao;

	@Override
	public void setDao(Object obj) {
		this.dao = (CarpoolDAO) obj;
	}

	@Override
	public Object service(Object obj) throws Exception {
		String id = (String) obj;
		CarpoolVO vo = dao.nowDriving(id); //운전자로 검색
		if (vo == null)
			vo = dao.nowPsging(id); //없으면 동승자로 검색
		return vo;
	}

}

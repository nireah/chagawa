// 포인트 내역 작성

package com.chagawa.point.service;

import com.chagawa.main.ServiceInterface;
import com.chagawa.point.dao.PointDAO;
import com.chagawa.point.vo.PointVO;

public class PointWriteServiceImpl implements ServiceInterface {

	private PointDAO dao;

	@Override
	public void setDao(Object obj) {
		// TODO Auto-generated method stub
		this.dao = (PointDAO) obj;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.write((PointVO) obj);
	}

}

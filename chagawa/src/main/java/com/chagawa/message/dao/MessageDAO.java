package com.chagawa.message.dao;

import com.chagawa.message.vo.MessageVO;

//import com.chagawa.util.PageObject;

public interface MessageDAO {



	public Object list(String id,String par1,long no) throws Exception;


	public Object write(String id, String wpar1, long wno, MessageVO vo) throws Exception;


	public Object alert(String id) throws Exception;


	public Object utc(long no, String id, int x) throws Exception;


	public int findpar(long roomno, String id) throws Exception;


//	public int findopposite(long no, String id) throws Exception;




//	public Object count(String id, long mrno) throws Exception;
	

	


//	public long getTotalRow(PageObject pageObject) throws Exception;
//	
//	public NoticeVO view(long no) throws Exception;
//	
//	public int increase(long no) throws Exception;
//
//	public int write(NoticeVO vo) throws Exception;
//
//	public int update(NoticeVO vo) throws Exception;
//
//	public int delete(NoticeVO vo) throws Exception;
//	
	
}

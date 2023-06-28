package com.chagawa.message.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.chagawa.message.vo.MessageVO;
import com.chagawa.main.Execute;
import com.chagawa.main.ServiceInterface;
import com.chagawa.member.vo.LoginVO;

public class MessageController {

	// private 변수로 MessageService
	private ServiceInterface messageLogService;
	private ServiceInterface messageWriteService;
	private ServiceInterface messageAlertService;
	private ServiceInterface UTCService;
	private ServiceInterface messageRoomIncreaseService;
	// setter를 만들어서 생성된 service를 받는다.
	public void setMessageLogService(ServiceInterface messageLogService) {
		this.messageLogService = messageLogService;
	}
	public void setMessageAlertService(ServiceInterface messageAlertService) {
		this.messageAlertService = messageAlertService;
	}
	public void setMessageWriteService(ServiceInterface messageWriteService) {
		this.messageWriteService = messageWriteService;
	}
	public void setUTCService(ServiceInterface UTCService) {
		this.UTCService = UTCService;
	}
	public void setMessageRoomIncreaseService(ServiceInterface messageRoomIncreaseService) {
		this.messageRoomIncreaseService = messageRoomIncreaseService;
	}
	// 실행 메서드 -> 리턴 String 데이터를 jsp 또는 url 정보가 된다.
	public String execute(HttpServletRequest request) throws Exception{
		System.out.println("MessageController.execute().request : " + request);
		// 어떤 요청
		LoginVO loginVO = (LoginVO) request.getSession().getAttribute("login");
		String uri = request.getRequestURI();
		String jsp = null;
		// 처리 
		switch (uri) {
		case "/message/messagelog.do":
			
			String noStr = request.getParameter("roomNo");
			String par1 = request.getParameter("par1");
			long no = Long.parseLong(noStr);
			System.out.println(no);
			
			
			
			Execute.run(UTCService, new Object[] { no, loginVO.getId() });
			Execute.run(messageAlertService, loginVO.getId());
		request.setAttribute("list", Execute.run(messageLogService, new Object[] { loginVO.getId(), par1, no } ));
			jsp = "message/messagelog";
			break;
			
		case "/message/write.do":
			
			if(request.getMethod().equals("GET")) {
				jsp = "message/write";
			} else {
				String wpar1 = request.getParameter("par1");
				String noStr1 = request.getParameter("roomNo");
				long wno = Long.parseLong(noStr1);
			
				MessageVO vo = new MessageVO();
				vo.setContent(request.getParameter("content"));
				 request.setAttribute("messagewrite", Execute.run(messageWriteService, new Object[] { loginVO.getId(), wpar1, wno, vo } ));
				 Execute.run(messageRoomIncreaseService, new Object[] { wno, wpar1 });
				jsp = "redirect:messagelog.do?roomNo=" + request.getParameter("roomNo") + "&par1=" +request.getParameter("par1");
				System.out.println(jsp);
			}
			break;
			
	
			
		
			
		default:
			throw new Exception("잘못된 페이지를 요청하셨습니다.");
		}
		return jsp;
	}
	
}

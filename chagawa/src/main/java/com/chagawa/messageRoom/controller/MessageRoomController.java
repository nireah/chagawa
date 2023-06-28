package com.chagawa.messageRoom.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.chagawa.message.service.MessageLogServiceImpl;
import com.chagawa.message.vo.MessageVO;
import com.chagawa.messageRoom.vo.MessageRoomVO;
import com.chagawa.main.Execute;
import com.chagawa.main.ServiceInterface;
import com.chagawa.member.vo.LoginVO;
import com.chagawa.member.vo.MemberVO;

public class MessageRoomController {

	// private 변수로 MessageService
	private ServiceInterface messageRoomListService;
	private ServiceInterface messageRoomWriteService;
	private ServiceInterface messageRoomDeleteService;
	private ServiceInterface messageRoomLeaveService;
	private ServiceInterface messageRoomFRNService;
	

	// setter를 만들어서 생성된 service를 받는다.
	public void setMessageRoomListService(ServiceInterface messageRoomListService) {
		this.messageRoomListService = messageRoomListService;
	}

	public void setMessageRoomWriteService(ServiceInterface messageRoomWriteService) {
		this.messageRoomWriteService = messageRoomWriteService;
	}

	public void setMessageRoomDeleteService(ServiceInterface messageRoomDeleteService) {
		this.messageRoomDeleteService = messageRoomDeleteService;
	}

	public void setMessageRoomLeaveService(ServiceInterface messageRoomLeaveService) {
		this.messageRoomLeaveService = messageRoomLeaveService;
	}

	public void setMessageRoomFRNService(ServiceInterface messageRoomFRNService) {
		this.messageRoomFRNService = messageRoomFRNService;
	}

	// 실행 메서드 -> 리턴 String 데이터를 jsp 또는 url 정보가 된다.
	public String execute(HttpServletRequest request) throws Exception {
		System.out.println("MessageRoomController.execute().request : " + request);
		// 어떤 요청
		String uri = request.getRequestURI();
		String jsp = null;
		LoginVO loginVO = (LoginVO) request.getSession().getAttribute("login");
		// 처리
		switch (uri) {
		case "/messageroom/list.do":
//			Execute.run(messageRoomDeleteService, null);
			
			request.setAttribute("list", Execute.run(messageRoomListService, loginVO.getId()));
			jsp = "messageRoom/list";
			break;

		case "/messageroom/write.do":
			String par1 = request.getParameter("par1");
			long roomno = (long) Execute.run(messageRoomFRNService, new Object[] { par1, loginVO.getId() });
			System.out.println(roomno);
			if (roomno == 0) {
				System.out.println(par1);
				System.out.println(loginVO.getId());
				Execute.run(messageRoomWriteService, new Object[] { par1, loginVO.getId() });
				
				roomno = (long) Execute.run(messageRoomFRNService, new Object[] { par1, loginVO.getId() });
					jsp = "redirect:/message/messagelog.do?roomNo=" + roomno + "&par1=" + par1;

				
			} else {
				jsp = "redirect:/message/messagelog.do?roomNo=" + roomno + "&par1=" + par1;

			}
			break;

		case "/messageroom/leave.do":

			String updateNoStr = request.getParameter("roomNo");
			long roomNo = Long.parseLong(updateNoStr);

			request.setAttribute("messageroomleave",
					Execute.run(messageRoomLeaveService, new Object[] { roomNo, loginVO.getId() }));
			jsp = "redirect:list.do";

			break;

		default:
			jsp = "redirect:/error/404.do";
			request.getSession().setAttribute("uri", uri);
		}
		return jsp;
	}

}

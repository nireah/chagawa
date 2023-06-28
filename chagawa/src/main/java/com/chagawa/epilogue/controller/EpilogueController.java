package com.chagawa.epilogue.controller;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.chagawa.epilogue.vo.EpilogueVO;
import com.chagawa.main.Execute;
import com.chagawa.main.ServiceInterface;
import com.chagawa.member.vo.LoginVO;
import com.webjjang.util.PageObject;

public class EpilogueController {

	// epilogueService 변수
	private ServiceInterface epilogueListService;
	private ServiceInterface epilogueViewService;
	private ServiceInterface epilogueWriteService;
	private ServiceInterface epilogueUpdateService;
	private ServiceInterface epilogueDeleteService;
	// 카풀 리뷰 변수
	private ServiceInterface carpoolUnreviewedService;
	private ServiceInterface carpoolReviewedService;
	
	// setter 생성해서 service받기
	public void setEpilogueListService(ServiceInterface epilogueListService) {
		this.epilogueListService = epilogueListService;
	}
	public void setEpilogueViewService(ServiceInterface epilogueViewService) {
		this.epilogueViewService = epilogueViewService;
	}
	public void setEpilogueWriteService(ServiceInterface epilogueWriteService) {
		this.epilogueWriteService = epilogueWriteService;
	}
	public void setEpilogueUpdateService(ServiceInterface epilogueUpdateService) {
		this.epilogueUpdateService = epilogueUpdateService;
	}
	public void setEpilogueDeleteService(ServiceInterface epilogueDeleteService) {
		this.epilogueDeleteService = epilogueDeleteService;
	}
	
	public void setCarpoolUnreviewedService(ServiceInterface carpoolUnreviewedService) {
		this.carpoolUnreviewedService = carpoolUnreviewedService;
	}
	public void setCarpoolReviewedService(ServiceInterface carpoolReviewedService) {
		this.carpoolReviewedService = carpoolReviewedService;
	}
	
	// 실행 메서드
	@SuppressWarnings("unchecked")
	public String execute(HttpServletRequest request) throws Exception{
		System.out.println("EpilogueController.execute().request : " + request);
		
		// 요청
		String uri = request.getRequestURI();
		String method = request.getMethod();
		System.out.println("EpilogueController.execute().method : " + method);
		String jsp = null;
		
		// 처리
		switch (uri) {
		// List
		case "/epilogue/list.do":
			
			// 페이지 정보와 검색 정보 받는 메서드 호출
			PageObject pageObject = PageObject.getInstance(request);
			// 리스트 -> request에 담는다.
			request.setAttribute("list", Execute.run(epilogueListService, pageObject));
			// jsp - 리스트 데이터 아래의 페이지 네비게이션을 위한 데이터 저장
			request.setAttribute("pageObject", pageObject);
			jsp = "epilogue/list";
			
			break;
			
		// View
		case "/epilogue/view.do":
			// 데이터 수집
			String noStr = request.getParameter("no");
			long no = Long.parseLong(noStr);
			String incStr = request.getParameter("inc");
			int inc = Integer.parseInt(incStr);
			// request에 데이터 담기
			EpilogueVO viewVO 
			= (EpilogueVO) Execute.run(epilogueViewService, new Object[] {no,inc});
			// 내용 줄바꿈 처리
			viewVO.setContent(viewVO.getContent().replace("\n", "<br/>"));
			request.setAttribute("vo", viewVO);
			jsp = "epilogue/view";
			
			break;
			
		//	Write
		case "/epilogue/write.do":
			
			if(request.getMethod().equals("GET")) {
				// 로그인정보
				LoginVO login = (LoginVO) request.getSession().getAttribute("login");
				// 카풀번호 리스트 CarpoolDAOImpl -> unreviewedCpNo
				List<Long> cplist = (List<Long>) Execute.run(carpoolUnreviewedService, login.getId());
				request.setAttribute("list", cplist);
				jsp = "epilogue/write";
			} else {
				
				// 페이지 데이터 수집 -> perPageNumStr을 URL 뒤에 붙여서 사용.
				// 데이터 수집
				EpilogueVO writeVO = new EpilogueVO();
				writeVO.setTitle(request.getParameter("title"));
				writeVO.setContent(request.getParameter("content"));
				writeVO.setWriter(request.getParameter("writer"));
				long cpNo = Long.parseLong(request.getParameter("cpNo"));
				writeVO.setReviewed(1);
				writeVO.setCpNo(cpNo);
				
				// 글등록 처리
				Execute.run(epilogueWriteService, writeVO);
				Execute.run(carpoolReviewedService, writeVO);
				jsp = "redirect:list.do?perPageNum="
						+ request.getParameter("perPageNum");
				
			} // end of if
			
			break;
			
		// Update	
		case "/epilogue/update.do":
			
			// 데이터수집
			String updateNoStr = request.getParameter("no");
			long updateNo = Long.parseLong(updateNoStr);
			if(request.getMethod().equals("GET")) {
			// 데이터 처리 -> request에 담는다. -> jsp에서 꺼내 쓴다. EL 객체 사용
			request.setAttribute("vo",
			Execute.run(epilogueViewService, new Object[] {updateNo,0}));
			jsp = "epilogue/update";
			} else {
			EpilogueVO updateVO = new EpilogueVO();
			// 데이터 수집 vo 넣기
			updateVO.setNo(updateNo);
			updateVO.setTitle(request.getParameter("title"));
			updateVO.setContent(request.getParameter("content"));
							
			// DB 처리
			Execute.run(epilogueUpdateService, updateVO);
							
			// 글보기로 자동이동 - 글번호와  inc가 필요하다. inc는 무조건 0이다.
			jsp = "redirect:view.do?no=" + updateNo + "&inc=0"
					+ "&page=" + request.getParameter("page")
					+ "&perPageNum=" + request.getParameter("perPageNum")
					+ "&key=" + request.getParameter("key")
					+ "&word=" + URLEncoder.encode(request.getParameter("word"), "utf-8")
					;
			}
			
			break;
			
		// Delete
		case "/epilogue/delete.do":
			// 데이터 수집 - 글번호
			// 로그인정보
			LoginVO login = (LoginVO) request.getSession().getAttribute("login");
			
			long deleteNo =Long.parseLong(request.getParameter("no"));
			EpilogueVO deleteVO = new EpilogueVO();
			deleteVO.setNo(deleteNo);
			long deleteCpNo = Long.parseLong(request.getParameter("cpNo"));
			deleteVO.setCpNo(deleteCpNo);
			deleteVO.setWriter(login.getId());
			deleteVO.setReviewed(0);
//			if(deleteVO.getWriter() == login.getId() || login.getGradeNo() == 9) {
//			deleteVO.setReviewed(0);
//			} // 23 03 03
			// 글삭제 처리
			Execute.run(epilogueDeleteService, deleteVO);
			Execute.run(carpoolReviewedService, deleteVO);
			jsp = "redirect:list.do?perPageNum="
					+ request.getParameter("perPageNum");
			break;

		default:
			
			jsp = "redirect:/error/404.do";
			request.getSession().setAttribute("uri", uri);
			
		} // end of switch ~ case
		
		return jsp;
		
	} // end of execute()
	
} // end of EpilogueController class

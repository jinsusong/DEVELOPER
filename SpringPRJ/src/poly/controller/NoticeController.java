package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.NoticeDTO;
import poly.service.INoticeService;
import poly.util.CmmUtil;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class NoticeController {
	private Logger log = Logger.getLogger(this.getClass());


	/*
	 * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
	 * */
	@Resource(name = "NoticeService")
	private INoticeService noticeService;
	
	/*
	 * 함수명 위의 value="notice/NoticeList" => /notice/NoticeList.do로 호출되는 url은 무조건 이 함수가 실행된다.
	 * method=RequestMethod.GET => 폼 전송방법을 지정하는 것으로 get방식은 GET, post방식은 POST이다.
	 * method => 기입안하면 GET, POST 모두 가능하나, 가급적 적어주는 것이 좋다.
	 * */
	
	@RequestMapping(value="main")
	public String main(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
		
		System.out.println("main");
		return "/index";
	}
	/**
	 * 게시판 리스트 보여주기
	 * */
	@RequestMapping(value="notice/NoticeList", method=RequestMethod.GET)
	public String NoticeList(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws Exception {
		//로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
		log.info(this.getClass().getName() + ".noticeList start!");
		
		//공지사항 리스트 가져오기
		
		List<NoticeDTO> nList = noticeService.getNoticeList();
		
		if (nList == null) {
			nList = new ArrayList<NoticeDTO>();

		}
		
		model.addAttribute("nList", nList);
 
		//조회된 리스트 결과값 넣어주기 model.addAttribute("rList", rList);
		  
		//변수 초기화(메모리 효율화 시키기 위해 사용함) 
		nList = null;
		  
		//함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp) 
		log.info(this.getClass().getName() + ".noticeList end!");
		return "/notice/noticeList";
	}
	
	//공지사항 글등록 화면
	@RequestMapping(value="notice/noticeRegView")
	public String noticeRegView() throws Exception{
		log.info("noticeRegView start ~~" );
		log.info("noticeRegView end ~~" );
		return "/notice/noticeRegView";
	}
	
	//공지사항 글 DB에 등록
	@RequestMapping(value="notice/noticeReg")
	public String noticeReg(HttpServletRequest request, Model model) throws Exception{
		log.info("noticeReg start ~~ " );
		String nTitle = CmmUtil.nvl(request.getParameter("nTitle"));
		String nContent = CmmUtil.nvl(request.getParameter("nContent"));
		
		
		
		
		log.info("ntitle : " + nTitle);
		log.info("nContnet " + nContent);
		
		NoticeDTO nDTO = new NoticeDTO();
		nDTO.setTitle(StringEscapeUtils.unescapeHtml4(nTitle));
		nDTO.setContents(StringEscapeUtils.unescapeHtml4(nContent));
		
		log.info("nDTO get : " + nDTO.getTitle());
		log.info("nDTO get : " + nDTO.getContents());
		

		int res = noticeService.noticeReg(nDTO);
		log.info("res " + res);
		String msg = "";
		String url = "";
		
		if(res == 1) {
			msg ="등록 성공";
		}else {
			msg ="등록 실패";
		}
		url ="/main.do";
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		msg = null;
		url = null;
		nDTO = null;
		
		log.info("noticeReg end ~~ " );
		return "/alert";
	}
	
	
	
	
}

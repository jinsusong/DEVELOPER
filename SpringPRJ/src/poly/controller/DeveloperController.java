package poly.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import poly.dto.DeveloperDTO;
import poly.dto.FileDTO;
import poly.service.IDeveloperService;
import poly.util.CmmUtil;
import poly.util.FileUtil;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class DeveloperController {
	private Logger log = Logger.getLogger(this.getClass());
	
	/*
	 * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
	 * */
	@Resource(name = "DeveloperService")
	private IDeveloperService developerService;
	
	
	/**
	 * 게시판 리스트 보여주기
	 * */
	@RequestMapping(value="developer/developerList", method=RequestMethod.GET)
	public String NoticeList(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws Exception {
		//로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
		log.info(this.getClass().getName() + ".developerList start!");
		
		//공지사항 리스트 가져오기
		
		
	  List<DeveloperDTO> dList =  developerService.getdeveloperList();
	  
	  if (dList == null) { 
		  dList = new ArrayList<DeveloperDTO>();
	  }
	  
	  model.addAttribute("dList", dList);
	  
	  //조회된 리스트 결과값 넣어주기 model.addAttribute("rList", rList);
	  
	  //변수 초기화(메모리 효율화 시키기 위해 사용함) nList = null;
		 
		log.info(this.getClass().getName() + ".developerList end!");
		return "/developer/developerList";
	}
	
	/*상세화면*/
	@RequestMapping(value="developer/detailDev", method=RequestMethod.GET)
	public String detailDev(HttpServletRequest request, Model model ) throws Exception{
		log.info(this.getClass().getName() + " .detailDev start~");
		String devNo = CmmUtil.nvl(request.getParameter("devNo"));
		log.info("devNo : " + devNo);
		
		DeveloperDTO dDTO = new DeveloperDTO();
		DeveloperDTO dDTO2 = new DeveloperDTO();
		
		dDTO.setNo(devNo);
		dDTO2.setTeamId(devNo);
		
		//dev detail 정보 가져오기
		dDTO = developerService.getdetailDev(dDTO);
		
		//팀원 정보 가져오기, teamId , userName
		List<DeveloperDTO> dList = developerService.getTeamMem(dDTO2);
		
		log.info("dList size : " + dList.size());
		
		
		if(dDTO == null) {
			dDTO = new DeveloperDTO();
		}
		
		model.addAttribute("dDTO", dDTO);
		model.addAttribute("dList" , dList);
		
		dDTO = null;
		devNo = null;
		
		log.info(this.getClass().getName() + " .detailDev end~");
		return "/developer/detailDev";
	}
	
	/* 팀 등록하기 */
	@RequestMapping(value="developer/devRegView", method=RequestMethod.GET)
	public String devRegView() throws Exception{
		log.info(this.getClass().getName() + " .devRegView start ~~ ");
		log.info(this.getClass().getName() + " .devRegView end ~~ ");
		return "/developer/devRegView";
	}
	/* 파일 업로드 */
	@RequestMapping(value="developer/fileUpload", method=RequestMethod.POST)
	public String fileUpload(HttpServletRequest request, HttpSession session, Model model ) throws Exception{
		log.info(this.getClass().getName() + " . fileUpload start !!");
		String userName = CmmUtil.nvl((String)session.getAttribute("name"));
		log.info("userName : " + userName);
		
		String dtitle = CmmUtil.nvl(request.getParameter("dtitle"));
		String dclassfi = CmmUtil.nvl(request.getParameter("dclassfi"));
		String dcontents = CmmUtil.nvl(request.getParameter("dcontents"));
		String dterm = CmmUtil.nvl(request.getParameter("dterm"));
		
		DeveloperDTO dDTO = new DeveloperDTO();
		dDTO.setTitle(dtitle);
		dDTO.setContents(dcontents);
		dDTO.setClassification(dclassfi);
		dDTO.setTerm(dterm);
		dDTO.setUserName(userName);
		
		log.info(" file Upload : " + dtitle);
		log.info(" file Upload : " + dclassfi);
		log.info(" file Upload : " + dcontents);
		log.info(" file Upload : " + dterm);
		
		String path = request.getSession().getServletContext().getRealPath("/upload/");
	     log.info("파일이 들어갈 경로: "+path);
	     MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)request;
	     
	     //1차적으로 mhsr.get("file")  있는지 없는지 
	     log.info(mhsr.getFile("file"));
	    
	     FileDTO fDTO = new FileDTO();
	     if(mhsr.getFile("file").getSize() == 0) {
	    	 log.info("파일없음");
	
	    	
	 		fDTO.setOrgName("NONE");
	 		fDTO.setChgName("NONE");
	 		fDTO.setFilePath("NONE");
	 		fDTO.setUserName(userName);
	 		
	 		int result = developerService.insertFileDTO(fDTO);
	    	 
	     } else {
		     
		     String[] fileArray = FileUtil.fileNewString("file",mhsr,path);	
		     log.info("fileServerName: "+fileArray[0]);
		     log.info("fileOrgNameLoc: "+fileArray[1]);	  
			
			//파일업로드 FILE_INFO에 정보저장할 서비스 호출
			fDTO = new FileDTO();
			fDTO.setOrgName(mhsr.getFile("file").getOriginalFilename());
			fDTO.setChgName(fileArray[0]);
			fDTO.setFilePath(path);
			fDTO.setUserName(userName);
		
			log.info("OrgName : " + fDTO.getOrgName());
			log.info("chgname : " + fDTO.getChgName());
			log.info("filepath : " + fDTO.getFilePath());
			log.info("userName: " + fDTO.getUserName());
			
			//성공했는지 안했는지
			
			//db에 저장할 서비스 호출 // service에서 파일 번호 가져온 후에 fDTO에 셋팅 해줌
			int result = developerService.insertFileDTO(fDTO);
			
			log.info("결과: "+result);
			
			//파일디렉토리 존재하지 않으면 새롭게 생성
			File dir = new File(fileArray[1]);
			if (!dir.isDirectory()) {
					dir.mkdirs();
			}
			
			//파일생성을 위한 객체 생성
			File serverFile = new File(fileArray[1]);
			log.info(serverFile.getPath());
			//파일저장
			mhsr.getFile("file").transferTo(serverFile);
			
			log.info("result : " + result);
			
			//게시판
			/*if (bType.equals("A")) { 일단 DB에 타입이 없다고 해서 주석처리 하겠습니다.*/
			//등록된 파일 정보에서 파일번호를 다시 가져오겠음 고유값인 chgName을 where절에 사용하겠음 
			FileDTO fDTO2 = developerService.getFileInfo(fDTO);
			log.info("fDTO2 : " + fDTO2.getFileNo());
			String fileNo2 = fDTO2.getFileNo();
			
			//파일 업로드 게시판 함수호출
			//insertCommuProc(fileNo2);
			
		 }
	     log.info(this.getClass().getName() + " . fileUpload end !!");
	     return insertCommuProc(dDTO, request, session, model, fDTO);
	}

	@RequestMapping(value = "/insertCommuProc", method = RequestMethod.POST)
	public String insertCommuProc(DeveloperDTO dDTO2, HttpServletRequest request, HttpSession session, Model model, FileDTO fDTO ) throws Exception {
			log.info(this.getClass().getName() + " . insertCommuProc start ~~");
		
			
			String userName = CmmUtil.nvl(dDTO2.getUserName());
			log.info("회원명: "+userName);
			String title = CmmUtil.nvl(dDTO2.getTitle());
			log.info("제목: "+title);
			String contents = CmmUtil.nvl(dDTO2.getContents());
			contents = contents.replace("\r\n", "<br>");
			log.info("내용: "+contents);
			String fileNo = (String) fDTO.getFileNo();
			log.info("파일번호: " + fileNo);
			String term = CmmUtil.nvl(dDTO2.getTerm());
			log.info("개발기간 : " + term);
			String classifi = CmmUtil.nvl(dDTO2.getClassification());
			log.info("분류 : " + classifi);
			
			String userNo = (String) session.getAttribute("userNo");
			log.info("회원번호: "+userNo);
	
			DeveloperDTO dDTO = new DeveloperDTO();
			dDTO.setUserName(userName);
			dDTO.setTitle(title);
			dDTO.setContents(contents);
			dDTO.setFileNo(fileNo);
			dDTO.setTerm(term);
			dDTO.setClassification(classifi);
			
			//dDTO.setUserNo(userNo);
	
			int result = developerService.insertDevProc(dDTO);
			log.info("RESULT : " + result);
	
			String msg = "";
			String url = "";
	
			if (result == 1) {
				msg = "게시글이 등록되었습니다";
				url = "/developer/developerList.do";
			} else {
				msg = "실패하였습니다.";
				url = "/main.do";
			}
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
	
			dDTO = null;
	
			log.info(this.getClass().getName() + " . insertCommuProc end ~~");
			return "/alert";
	
	}
	@RequestMapping(value="developer/joinUs", method=RequestMethod.POST)
	public @ResponseBody List<DeveloperDTO> joinUs(HttpServletRequest request, Model model) throws Exception{
		log.info(this.getClass().getName() + " .joinUs start ~~");
		String userName = CmmUtil.nvl(request.getParameter("userName"));
		log.info("userName : " + userName);
		String teamId = CmmUtil.nvl(request.getParameter("teamId"));
		log.info("teamId : " + teamId);
		
		DeveloperDTO dDTO = new DeveloperDTO();
		dDTO.setUserName(userName);
		dDTO.setTeamId(teamId);
		
		int res = developerService.insertJoinUs(dDTO);
		log.info("res : " + res);
		
		//팀원 정보 가져오기, teamId , userName
		List<DeveloperDTO> dList = developerService.getTeamMem(dDTO);
		log.info("dList size : " + dList.size());
		
		log.info(this.getClass().getName() + " .joinUs end ~~");
		//return dList;
		return dList;
	}
	
}

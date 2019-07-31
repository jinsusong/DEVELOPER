package poly.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;

import poly.util.CmmUtil;
import poly.util.KakaoAccessToken;
import poly.util.KakaoSignOut;
import poly.util.KakaoUserInfo;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class UserController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="user/signIn")
	public String signIn() throws Exception{
		
		log.info("signIn");
		
		return "/user/login";
	}
	@RequestMapping(value="/kakaologin", produces="application/json", method=RequestMethod.GET)
	public String kakaoLogin( @RequestParam("code") String code , RedirectAttributes ra, HttpSession session, HttpServletResponse response, Model model)throws IOException{
		log.info("kakaologin start~~!!");
		log.info("kakao code : " + code);
		
		 // JsonNode트리형태로 토큰받아온다
        JsonNode jsonToken = KakaoAccessToken.getKakaoAccessToken(code);
        // 여러 json객체 중 access_token을 가져온다
        JsonNode accessToken = jsonToken.get("access_token");
 
        System.out.println("access_token : " + accessToken);
        
        
        //////////////////////
        //access_token을 통해 사용자 정보 요청
        JsonNode userInfo = KakaoUserInfo.getKakaoUserInfo(accessToken);
 
        // Get id
        String id = userInfo.path("id").asText();
        String name = null;
        String email = null;
 
        // 유저정보 카카오에서 가져오기 Get properties
        JsonNode properties = userInfo.path("properties");
        JsonNode kakao_account = userInfo.path("kakao_account");
 
        name = properties.path("nickname").asText();
        email = kakao_account.path("email").asText();
 
        System.out.println("id : " + id);
        System.out.println("name : " + name);
        System.out.println("email : " + email);
        
        String msg = "";
        String url = "";
        
        if(name.isEmpty()) {
        	msg = "로그인 실패";
        }
        else {
        	msg = "로그인 성공";
        	session.setAttribute("name", name);
        }
        
        session.setAttribute("accessToken",	accessToken);
        log.info("sess : " + accessToken);
        url = "/main.do";
        
        model.addAttribute("msg", msg);
        model.addAttribute("url", url);
		
        code = null;
        jsonToken = null;
        accessToken = null;
        
        
		log.info("kakaologin end~~!!");
		return "/alert";
	
	}
	
	//로그아웃
	@RequestMapping(value="/signOut", produces = "application/json")
	public String signOut(HttpSession session, Model model ) throws Exception{
		log.info("signOut start~~");
		
		//kakao restapi 객체 선언
		KakaoSignOut kr = new KakaoSignOut();
		//노드에 로그아웃한 결과값음 담아줌 매개변수는 세션에 잇는 token을 가져와 문자열로 변환
		
		System.out.println(session.getAttribute("accessToken"));
        JsonNode node = kr.Logout(session.getAttribute("accessToken").toString());
        //결과 값 출력
        JsonNode id = node.get("id");
        System.out.println("로그아웃 후 반환되는 아이디 : " + node.get("id"));
        System.out.println(session.getAttribute("accessToken"));
        
      //kakao restapi 객체 선언

        System.out.println(session.getAttribute("accessToken"));
              JsonNode node2 = kr.Unlink(session.getAttribute("accessToken").toString());
              //결과 값 출력
              JsonNode id2 = node2.get("id");
              System.out.println("연결 종료 후 반환되는 아이디 : " + node2.get("id2"));
        
        	String msg = "";
	        String url = "";
	        
	        if(id.isNull()) {
	        	msg = "로그아웃 실패";
	        }
	        else {
	        	msg = "로그아웃 성공";
	        	
	        	session.setAttribute("accessToken", "");
	        	session.invalidate();
	        }
	        
	        url = "/main.do";
	        
	        model.addAttribute("msg", msg);
	        model.addAttribute("url", url);
			
			log.info("signOut end~~");
			return "/alert";
	}
	
	
	/*
	 * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
	 * */
	/*
	 * @Resource(name = "UserService") private IUserService userService;
	 */
	/*
	 * 함수명 위의 value="notice/NoticeList" => /notice/NoticeList.do로 호출되는 url은 무조건 이 함수가 실행된다.
	 * method=RequestMethod.GET => 폼 전송방법을 지정하는 것으로 get방식은 GET, post방식은 POST이다.
	 * method => 기입안하면 GET, POST 모두 가능하나, 가급적 적어주는 것이 좋다.
	 * */
	
	/**/
	
}

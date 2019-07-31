<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<%@ include file="/WEB-INF/view/headLink.jsp" %>

	<style>
	    .join_user{
	    	float:left;
	    }
	    .info_user{
    	    position: static;
		    padding-top: 12px;
		    border-top: 0 none;
		    font-size: 12px;
	    }
	    .info_user a{
		    color: #333;
			text-decoration: none;
	    }
	    .list_user{
	    	float: right;
	    }
	    .list_user li {
	    	float: left;
	    }
	    form.text-white input{
	    	width:100%;
	    }
    </style>
</head>
<body>
	<div class="culmn">
		<%@ include file="/WEB-INF/view/topNav.jsp" %>
		<!--Home Sections-->

		<section>
			<div class="container">
				<div class="row">
					<div class="main_home">
						<div class="home_text">
							<a href="http://kauth.kakao.com/oauth/authorize?client_id={79c1a7644e3f2503cd9d8b7c54ee0677}&redirect_uri={http://54.180.192.10:8080/kakaologin}&response_type=code"></a>
							<form class="text-white" action="#" method="post">
								<input type="text" placeholder="이메일 또는 전화번호"/><br/>
								<input type="password" placeholder="비밀번호"/>
							</form>
							<div>
						      <input type="checkbox" id="staySignedIn" name="stay_signed_in" value="true" class="inp_check">
						      <label class="lab_check " for="staySignedIn">로그인 상태 유지</label>
						      <button type="button" class="btn_emailaccount login_by_email hide" style="display: none;">이메일 주소로 로그인</button>
						    </div>	
						</div>
						<div class="home_btns m-top-40">
												
							<a href="#"><img src="/assets/images/user/kakao_login_btn.png"/></a>
							
							<div class="info_user">
						      <div class="join_user">
						        <a href="#"id="signUp">회원가입</a>
						      </div>
						      <ul class="list_user">
						        <li>
						          <a href="#">카카오계정 찾기</a><span class="txt_bar">|</span>
						        </li>
						        <li>
						          <a href="#">비밀번호 재설정</a>
						        </li>
						      </ul>
						    </div>
						    
						    
						</div>
					</div>
				</div>
				<!--End off row-->
			</div>
			<!--End off container -->
		</section>
		<!--End off Home Sections-->
		
	</div>
	
	<%@ include file="/WEB-INF/view/footer.jsp" %>
	<%@ include file="/WEB-INF/view/footerScript.jsp" %>
</body>
</html>
<%@page import="poly.dto.DeveloperDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<DeveloperDTO> dList = (List<DeveloperDTO>)request.getAttribute("dList");  
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>공지사항</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<%@ include file="/WEB-INF/view/headLink.jsp" %>

</head>
<body data-spy="scroll" data-target=".navbar-collapse">


	<!-- Preloader -->
	<div id="loading">
		<div id="loading-center">
			<div id="loading-center-absolute">
				<div class="object" id="object_one"></div>
				<div class="object" id="object_two"></div>
				<div class="object" id="object_three"></div>
				<div class="object" id="object_four"></div>
			</div>
		</div>
	</div>
	<!--End off Preloader -->


	<div class="culmn">
		<!--Home page style-->

		<%@ include file="/WEB-INF/view/topNav.jsp" %>
		
	<div class="container">
			<div class="row">
				<div class="main_featured m-top-100">
					<div class="col-sm-12">
						<div class="head_title text-center">
							<h2>Recruitment of <br/>Development Team Members</h2>
							<div class="separator_auto"></div>
							<p>개발에 참여하고 싶은 아이디어를 선택하시면 상세 내용을 볼 수 있습니다. <br/>
							당신을 기다리는 팀원들이 있습니다. <b><a href="/developer/devRegView.do">아이디어를 등록 하고 </a></b> 함께 하세요.
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="featured_slider" style="height:100%;">
			<%if(dList.size()>0 && dList.size() < 10){ %>
				<%for(int i=0; i< dList.size(); i++){ %>
				<div>
					<div class="featured_img">
						
						<!-- Preview Image-->
		          		<%if(dList.get(i).getOrgName().equals("NONE")) {%>
		          		
		   				<%}else {%>
		          		<img src="http://54.180.192.10:8080/upload/<%=dList.get(i).getOrgName()%>">
						<%}%>
						
						<a href="/developer/detailDev.do?devNo=<%=dList.get(i).getNo()%>"></a>
						<div>
							<span><%= dList.get(i).getTitle() %></span>
						</div>
					</div>
				</div>
				<%}%>
			<%}else{%>
				<%for(int i=0; i<10; i++){ %>
					<div>
						<div class="featured_img">
							
							<!-- Preview Image-->
			          		<%if(dList.get(i).getOrgName().equals("NONE")) {%>
			          		
			   				<%}else {%>
			          		<img src="http://54.180.192.10:8080/upload/<%=dList.get(i).getOrgName()%>">
							<%}%>
							
							<a href="/developer/detailDev.do?devNo=<%=dList.get(i).getNo()%>"></a>
							<div>
								<span><%= dList.get(i).getTitle() %></span>
							</div>
						</div>
					</div>
				<%}%>
			<%} %>
		</div>
		<!-- End off featured slider -->
		<div class="featured_slider" style="height:100%;">
			<%if(dList.size()>0 && dList.size()>10 ){ %>
				<%for(int i=10; i< dList.size(); i++){ %>
				<div>
					<div class="featured_img">
						
						<!-- Preview Image-->
		          		<%if(dList.get(i).getOrgName().equals("NONE")) {%>
		          		
		   				<%}else {%>
		          		<img src="http://54.180.192.10:8080/upload/<%=dList.get(i).getOrgName()%>">
						<%}%>
						
						<a href="/developer/detailDev.do?devNo=<%=dList.get(i).getNo()%>"></a>
						<div>
							<span><%= dList.get(i).getTitle() %></span>
						</div>
					</div>
				</div>
				<%}%>
			<%}%>
		</div>
		<!-- End off featured slider -->
		
		
		
		
		<!-- scroll up-->
		<div class="scrollup">
			<a href="#"><i class="fa fa-chevron-up"></i></a>
		</div>
		<!-- End off scroll up -->


		<%@ include file="/WEB-INF/view/footer.jsp" %>


	</div>

	<%@ include file="/WEB-INF/view/footerScript.jsp" %>

</body>

</body>
</html>

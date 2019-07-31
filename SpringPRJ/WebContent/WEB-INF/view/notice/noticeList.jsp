<%@page import="poly.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  List<NoticeDTO> nList = (List<NoticeDTO>)request.getAttribute("nList");  
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
		<!--Service Section-->
		<section id="service" class="service">
			<div class="container">
				<div class="row">
					<div class="main_service roomy-100">
						<div class="col-md-8 col-sm-10 mr-md-auto ml-md-auto mr-sm-auto ml-sm-auto">
							<div class="head_title text-center">
								<h2>NOTICE</h2>
								<div class="separator_auto"></div>
								<p>This is a notice. <br/>
								Click on the title to see the content.</p>
							</div>
						</div>
						
						
						<div class="col-md-12">
							<div class="about_accordion wow fadeIn">
								<div id="faq_main_content" class="faq_main_content">
									<%for(int i=0; i<nList.size(); i++){%>
										<h6><i class="fa fa-angle-right"></i> <%= nList.get(i).getNoticeNo() %> . <%= CmmUtil.replace( nList.get(i).getTitle()) %> </h6>
										<div>
											<div class="content">
												<p> <%=CmmUtil.replace( nList.get(i).getContents() ) %></p>
	
											</div>
										</div>
									<%} %>
									<!-- End off accordion item-1 -->

								</div>
							</div>
							<div align="center">
								<a href="/notice/noticeRegView.do" style="color:#6a6b6d; border-color: #2b2b2b;" class="btn btn-default m-top-20">글쓰기</a>
							</div>
						</div>
					</div>
				</div>
				<!--End off row -->
			</div>
			<!--End off container -->
		</section>
		<!--End off Featured section-->
		
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

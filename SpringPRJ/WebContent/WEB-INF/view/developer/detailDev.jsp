<%@page import="poly.dto.DeveloperDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	DeveloperDTO dDTO = (DeveloperDTO)request.getAttribute("dDTO");  
	List<DeveloperDTO> dList = (List<DeveloperDTO>)request.getAttribute("dList");
	String name2 = CmmUtil.nvl ((String)session.getAttribute("name"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>상세보기</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<%@ include file="/WEB-INF/view/headLink.jsp" %>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script type="text/javascript">
	
	function joinUs(){
		$.ajax({
			url: "/developer/joinUs.do",
			method : "post",
			data : {
				"userName" :"<%=name2 %>",
				"teamId" : <%=dList.get(0).getTeamId()%>
			},
			dataType: "json",
			success: function(data){
				var contents = "";
				
				 $.each(data,function(key, value){
					console.log("value : " +value);
					console.log(value.userName);
					console.log(value.chgDt);
					contents +="<div>Mem. "+value.userName+ " " +value.chgDt + "</div>";
				}) 
				
				console.log("contents : " + contents);
				$('#joinUs').html(contents);
			}
		});
	}
	
	</script>

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

		<%@ include file="/WEB-INF/view/topNav.jsp" %>
		
	<!--About Sections-->
		<section id="about" class="about roomy-100" style="padding-top:150px;">
			<div class="container">
				<div class="row">
					<div class="main_about">
						<div class="col-md-6">
							<div class="about_content">
								<h2>개발자 모집</h2>
								<div class="separator_left"></div>
								<div>
									
									<h4> NO : <%= dDTO.getNo() %></h4>
									<h5>TITLE : <%= dDTO.getTitle() %></h5>
									
								</div>
								<div>
									<h6>CONTENTS</h6>
									 <i class="fa fa-angle-right"></i> <%= dDTO.getContents() %>
								</div>
								

								<div class="about_btns m-top-40">
									<a href="JavaScript:joinUs()" class="btn btn-primary">JOIN US</a>
								</div>
							</div>
						</div>
						
						<div class="col-md-6">
							<div>
								<h2>&nbsp;</h2>
							</div>
							<div>
								<h6>개발 기간</h6>
								<span><%=dDTO.getTerm() %></span>
							</div>
							<hr />
							<div>
								<div>
									<h5>TEAM ID : <%=dDTO.getTeamId() %> </h5>
									<b>HEAD : <%= dDTO.getUserName() %></b>
								</div>
								<div id="joinUs">
									<%if (dList.size() >0 ){ %>
										<%for (int i=0; i< dList.size(); i++){ %>
											<div>Mem. <%= dList.get(i).getUserName() %> <%= dList.get(i).getChgDt() %></div>
										<%} %>
									<%} %>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				<!--End off row-->
			</div>
			<!--End off container -->
			<br />
			<br />
			<br />
			<br />
			<hr />
			
		</section>
		<!--End off About section -->

		
		
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

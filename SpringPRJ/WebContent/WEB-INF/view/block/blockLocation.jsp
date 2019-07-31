<%@page import="poly.dto.BlockDTO"%>
<%@page import="poly.dto.DeveloperDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<BlockDTO> bList = (List<BlockDTO>)request.getAttribute("bList");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>팀 등록하기</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<%@ include file="/WEB-INF/view/headLink.jsp" %>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c449b1cbc3c291def2d6edada3e87082"></script>
	

	<style>
	.area {
	    position: absolute;
	    background: #fff;
	    border: 1px solid #888;
	    border-radius: 3px;
	    font-size: 12px;
	    top: -5px;
	    left: 15px;
	    padding:2px;
	};
	
	.info {
	    font-size: 12px;
	    padding: 5px;
	};
	.info .title {
	    font-weight: bold;
	};
	
	#chartdiv {
	  width: 100%;
	  height: 500px;
	};

	</style>
	

	
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
						<div class="col-md-12">
							<div class="about_content">
								
									<h2>블록 생성 위치 확인</h2>
									<div class="separator_left"></div>
									
									<div>
										<div id="map" style="width:100%;height:350px;"></div>
									
										<%-- 	
										var array = [];
										<%for(int i= 0; i < (bList.size()-1); i++){%>
										  array[<%=i%>] =  {  
									      	title : "<%=bList.get(i).getBlocknumber()%>",
									      	latlng : new daum.maps.LatLng(<%=bList.get(i).getLatitude()%>, <%=bList.get(i).getLongitude()%>)
									      };
										<%}%>
										--%>
											<%@include file="/WEB-INF/view/block/locationScript.jsp"%> 
									</div>
							</div>
						</div>
					</div>
				</div>
				<!--End off row-->
			</div>
			<div id="blockAnalysis">
				<%@include file="/WEB-INF/view/block/blockAnalysis.jsp" %>
			</div>
					<div id="chartdiv" style="height:350px;"></div>
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

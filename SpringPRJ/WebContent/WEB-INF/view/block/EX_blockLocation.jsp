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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c449b1cbc3c291def2d6edada3e87082"></script>

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
										<script>
										var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
										    mapOption = { 
										        center: new daum.maps.LatLng(37.549566, 126.836463), // 지도의 중심좌표
										        level: 9// 지도의 확대 레벨
										    };
										
										var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

										var array = [];
										<%for(int i= 0; i < (bList.size()-1); i++){%>
										  array[<%=i%>] =  {  
									      	title : "<%=bList.get(i).getBlocknumber()%>",
									      	latlng : new daum.maps.LatLng(<%=bList.get(i).getLatitude()%>, <%=bList.get(i).getLongitude()%>)
									      };
										<%}%> 
										
										
										// 마커를 표시할 위치와 title 객체 배열입니다 
										var positions = array;
										
										// 마커 이미지의 이미지 주소입니다
										var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
										    
										for (var i = 0; i < positions.length; i ++) {
										    
										    // 마커 이미지의 이미지 크기 입니다
										    var imageSize = new daum.maps.Size(24, 35); 
										    
										    // 마커 이미지를 생성합니다    
										    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
										    
										    // 마커를 생성합니다
										    var marker = new daum.maps.Marker({
										        map: map, // 마커를 표시할 지도
										        position: positions[i].latlng, // 마커를 표시할 위치
										        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
										        image : markerImage // 마커 이미지 
										    });
										}
										</script>
									
									
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

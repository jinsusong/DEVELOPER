<%@page import="poly.dto.DeveloperDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>팀 등록하기</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<%@ include file="/WEB-INF/view/headLink.jsp" %>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c449b1cbc3c291def2d6edada3e87082&libraries=services"></script>
	

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script>
	var geoLat ;
	var geoLong;
	
	 $(function() {        
	        // Geolocation API에 액세스할 수 있는지를 확인
	       /*  if (navigator.geolocation) {
	            //위치 정보를 얻기
	            navigator.geolocation.getCurrentPosition (function(pos) {
	                $('#latitude').html(pos.coords.latitude);     // 위도
	                $('#longitude').html(pos.coords.longitude); // 경도
	                
	                var latitude = pos.coords.latitude
	                console.log("latitude : " + latitude);
	                $('#latitude2').attr("value", latitude);
	                
	                var longitude = pos.coords.longitude
	                console.log("longitude : " + longitude);
	                $('#longitude2').attr("value", longitude);
	                
	                
	            });
	        } else {
	            alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
	        } */
	        
	        var apiGeolocationSuccess = function(position) {
	            alert("API geolocation success!\n\nlat = " + position.coords.latitude + "\nlng = " + position.coords.longitude);
	        };

	        var tryAPIGeolocation = function() {
	            jQuery.post( "https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyDCa1LUe1vOczX1hO_iGYgyo8p_jYuGOPU", function(success) {
	                apiGeolocationSuccess({coords: {latitude: success.location.lat, longitude: success.location.lng}});
	            })
	            .fail(function(err) {
	                alert("API Geolocation error! \n\n"+err);
	            });
	        };

	        var browserGeolocationSuccess = function(position) {
	        	 $('#latitude').html(position.coords.latitude);     // 위도
                $('#longitude').html(position.coords.longitude); // 경도
                
                var latitude = position.coords.latitude
                console.log("latitude : " + latitude);
                $('#latitude2').attr("value", latitude);
                
                var longitude = position.coords.longitude
                console.log("longitude : " + longitude);
                $('#longitude2').attr("value", longitude);
	        	//alert("Browser geolocation success!\n\nlat = " + position.coords.latitude + "\nlng = " + position.coords.longitude);
	        	
	        	
	        	geoLat = latitude;
	        	geoLong = longitude;
	        	console.log("test2 : " + geoLat);
	        	console.log("test2 : " + geoLong);
	        	geo(geoLat, geoLong);
	        };

	        var browserGeolocationFail = function(error) {
	            switch (error.code) {
	                case error.TIMEOUT:
	                    alert("Browser geolocation error !\n\nTimeout.");
	                    break;
	                case error.PERMISSION_DENIED:
	                    if(error.message.indexOf("Only secure origins are allowed") == 0) {
	                        tryAPIGeolocation();
	                    }
	                    break;
	                case error.POSITION_UNAVAILABLE:
	                    alert("Browser geolocation error !\n\nPosition unavailable.");
	                    break;
	            }
	        };

	        var tryGeolocation = function() {
	            if (navigator.geolocation) {
	                navigator.geolocation.getCurrentPosition(
	                        browserGeolocationSuccess,
	                        browserGeolocationFail,
	                        {maximumAge: 50000, timeout: 20000, enableHighAccuracy: true});
	            }
	        };

	        tryGeolocation();
	    });
	 
	 function geo(a,b){
		var geocoder = new daum.maps.services.Geocoder();
	
		var callback = function(result, status) {
		    if (status === daum.maps.services.Status.OK) {
	
		        console.log('지역 명칭 : ' + result[0].address_name);
		        console.log('행정구역 코드 : ' + result[0].code);
		        $('#geoAddr').attr("value", result[0].address_name);
		    }	
		};
	
		geocoder.coord2RegionCode(b, a, callback);
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
					<form action="/block/blockRegProc.do" method="post" style="width:100%">
						<div class="main_about">
							<div class="col-md-12">
								<div class="about_content">
									<h2>저작권 등록</h2>
									<div class="separator_left"></div>
									<div>
										<h4>TITLE</h4>
										<input type="text" name="title" value="" placeholder="등록할 저작권 제목을 작성해주세요." style="margin-bottom: 10px; width:100%"/>
									</div>
									<div>
										<h6>CONTENTS</h6>
										<textarea rows="10" style="width:100%" name="contents" placeholder="아이디어에 대해 설명을 작성해주세요."></textarea>
									</div>
									<div>
										<h6>LOCATION</h6>
										<div>
											위도 : <span id="latitude"></span>
											<input type="hidden" name="latitude" value="" id="latitude2">
										</div>
										<div>
											경도 : <span id="longitude"></span>
											<input type="hidden" name="longitude" value="" id="longitude2">
											<!-- 주소 -->
											<input type="hidden" name="geoAddr" value="" id="geoAddr">
										</div>
									</div>
								</div>
								<div class="about_btns m-top-40">
									<input type="submit" class="btn btn-primary" value="등록하기"/>
								</div>
							</div>
							
							
						</div>
					</form>
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

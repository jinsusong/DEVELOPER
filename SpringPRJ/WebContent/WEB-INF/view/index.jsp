<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<!-- <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>index</title>
</head>
<html class="no-js" lang="en">
<![endif]

Designerd by: http://bootstrapthemes.co -->

<head>
	<meta charset="utf-8">
	<title>index.jsp</title>
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

		<!--Home Sections-->

		<section id="hello" class="home bg-mega">
			<div class="overlay"></div>
			<div class="container">
				<div class="row">
					<div class="main_home">
						<div class="home_text">
							<h1 class="text-white">WE’RE <br /> CREATIVE DEVELOPER!</h1>
						</div>

						<div class="home_btns m-top-40">
							<a href="/developer/developerList.do" class="btn btn-primary m-top-20">DEVELOPER</a>
							<a href="/block/blockRegView.do" class="btn btn-default m-top-20" style="margin-bottom:14px">COPYRIGHT</a>
						</div>

					</div>
				</div>
				<!--End off row-->
			</div>
			<!--End off container -->
		</section>
		<!--End off Home Sections-->

		<!--Maps Section-->
		<div class="main_maps text-center fix">
			<div class="overlay"></div>
			<div class="maps_text">
				<h3 class="text-white" onclick="showmap()">FIND US ON THE MAP <i class="fa fa-angle-down"></i></h3>
				<div id="map_canvas" class="mapheight"></div>
			</div>
		</div>
		<!-- End off Maps Section-->

		<!-- scroll up-->
		<div class="scrollup">
			<a href="#"><i class="fa fa-chevron-up"></i></a>
		</div>
		<!-- End off scroll up -->


		<%@ include file="/WEB-INF/view/footer.jsp" %>


	</div>

	<%@ include file="/WEB-INF/view/footerScript.jsp" %>

</body>

</html>
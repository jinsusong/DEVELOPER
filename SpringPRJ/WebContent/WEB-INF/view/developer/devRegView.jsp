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
				<form action="/developer/fileUpload.do" method="post" enctype="multipart/form-data" style="width:100%">
					<div class="main_about">
						<div class="col-md-6">
							<div class="about_content">
								
									<h2>팀 등록하기</h2>
									<div class="separator_left"></div>
									
									<div>
										<h4>TITLE</h4>
										<input type="text" name="dtitle" value="" placeholder="등록할 팀의 아이디어 제목을 작성해주세요." style="margin-bottom: 10px; width:100%"/>
									</div>
									<div>
										<h5>Classification: </h5>
										<select class="form-control" name="dclassfi" style="margin-bottom:10px;">
											<option>빅데이터</option>
											<option>인공지능</option>
											<option>증강현실</option>
											<option>블록체인</option>
											<option>음성인식</option>
										</select>
									</div>
									<div>
										<h6>CONTENTS</h6>
										<textarea rows="10" style="width:100%"name="dcontents" placeholder="모집되는 팀원을 위해 아이디어에 관한 설명을 작성해주세요."></textarea>
									</div>
							</div>
						</div>
						
						<div class="col-md-6">
							<div>
								<h2>&nbsp;</h2>
								<div class="separator_left" style="background: white;"></div>
							</div>
							<div>
								<h4>개발 기간</h4>
								<span><input type="text" name="dterm" placeholder="ex) 2019.01.10 ~ 2019.10.10" style="width:100%"/></span>
							</div>
							<hr />
							<div>
								<div>
									<input type="file" name="file"/>
									<div>
										<small>팀을 대표하는 사진을 선택해주세요.</small>
									</div>
									<div>
									<img src="http://placehold.it/300x150" style="width:100%"/>
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>공지사항 글쓰기</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<%@ include file="/WEB-INF/view/headLink.jsp" %>

	<style>
	.Reg_home {
	    overflow: hidden;
	    padding-top: 100px;
	    padding-bottom: 230px;
	    position: relative;
	    z-index: 1;
	}
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
		<!--Home page style-->

		<%@ include file="/WEB-INF/view/topNav.jsp" %>
		
		<!--Service Section-->
		<section id="service" class="service">
			<div class="container">
				<div class="row">
					<div class="main_service roomy-100">
						<div class="col-md-8 col-sm-10 mr-md-auto ml-md-auto mr-sm-auto ml-sm-auto">
							<div class="head_title text-center">
								<h2>NOTICE REG</h2>
								<div class="separator_auto"></div>
								<p>Please fill out the writing.</p>
							</div>
						</div>
						
						
						<div class="col-md-12">
							<form action="/notice/noticeReg.do" method="POST">
								<div class="about_accordion wow fadeIn">
									<div id="faq_main_content" class="faq_main_content">
										<h6 class="open"><i class="fa fa-angle-right"></i> Title</h6>
										<div class="open">
											<div class="content">
												<input style="width:100%; border:none;" type="text" name="nTitle" placeholder="제목을 입력해주세요."/>
											</div>
										</div>
										<!-- End off accordion item-1 -->
	
										<h6 class="open"><i class="fa fa-angle-right"></i> Contents</h6>
										<div class="open">
											<div class="content">
												<input style="width:100%; border:none;" type="text" name="nContent" placeholder="내용을 입력해주세요."/>
											</div>
										</div>
										<!-- End off accordion item-2 -->
									</div>
								</div>
								<div align="center">
									<input type="submit" class="btn btn-default m-top-20" style="color:#6a6b6d; border-color: #2b2b2b;" value="글등록"/>
								</div>
							</form>
						<!-- 	
						<div>
								<div>
									<form action="/notice/noticeReg.do" method="POST">
										<div>
											제목 : <input type="text" name="nTitle" placeholder="제목을 입력해주세요."/>
										</div>
										<div>
											내용 : <input type="text" name="nContent" placeholder="내용을 입력해주세요."/>
										</div>
										<div align="right">
											<input type="submit" value="글등록"/>
										</div>
									</form>
								</div>
							</div> -->
						</div>
					</div>
				</div>
				<!--End off row -->
			</div>
			<!--End off container -->
		</section>
		<!--End off Featured section-->
		
		<!--Home Sections-->

		<!-- <section id="hello">
			<div class="overlay"></div>
			<div class="container">
				<div class="row">
					<div class="Reg_home">
						 공지사항 글쓰기
						<div>
							<form action="/notice/noticeReg.do" method="POST">
								<div>
									제목 : <input type="text" name="nTitle" placeholder="제목을 입력해주세요."/>
								</div>
								<div>
									내용 : <input type="text" name="nContent" placeholder="내용을 입력해주세요."/>
								</div>
								<div align="right">
									<input type="submit" value="글등록"/>
								</div>
							</form>
						</div>
					</div>
				</div>
				End off row
			</div>
			End off container
		</section> -->
		<!--End off Home Sections-->
		
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

<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = CmmUtil.nvl ((String)session.getAttribute("name"));
	/* String accessToken = CmmUtil.nvl((String)session.getAttribute("accessToken")); */
%>
<nav class="navbar navbar-light navbar-expand-lg  navbar-fixed white no-background bootsnav">
			<!-- Start Top Search -->
			<div class="top-search">
				<div class="container">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-search"></i></span>
						<input type="text" class="form-control" placeholder="Search">
						<span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
					</div>
				</div>
			</div>
			<!-- End Top Search -->

			<div class="container">
				<!-- Start Atribute Navigation -->
				<div class="attr-nav">
					<ul>
						<li class="search"><a href="#"><i class="fa fa-search" style="color:#2b2b2b;"></i></a></li>
						<li >
							<%if(name.isEmpty()){ %>
								<a href="https://kauth.kakao.com/oauth/authorize?client_id=79c1a7644e3f2503cd9d8b7c54ee0677&redirect_uri=http://54.180.192.10:8080/kakaologin.do&response_type=code" style="color:#2b2b2b;">
									Sign in
								</a>
							<%} else{ %>
								<a href="/signOut.do" style="color:#2b2b2b;"><%=name %>님 Sign Out </a>
							<%} %>
						</li>
					</ul>
				</div>
				<!-- End Atribute Navigation -->

				<!-- Start Header Navigation -->
				<div class="navbar-header">
						<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbar-menu">
                            <span></span>
                            <span></span>
                            <span></span>
                        </button>

					<a class="navbar-brand" href="/main.do">
                            <img src="/assets/images/logo.png" class="logo logo-display m-top-10" alt="">
                            <img src="/assets/images/logo.jpg" class="logo logo-scrolled" alt="">
                        </a>
				</div>
				<!-- End Header Navigation -->

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="navbar-menu">
					<ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
						<li><a href="/main.do" style="color:#2b2b2b;">HOME</a></li>
						<li><a href="/block/blockRegView.do" style="color:#2b2b2b;">저작권 블록 생성 </a></li>
						<li><a href="/block/blockMonitoring.do" style="color:#2b2b2b;">블록 모니터링 </a></li>
						<li><a href="/developer/developerList.do" style="color:#2b2b2b;">개발자 모집</a></li>
						<li><a href="/notice/NoticeList.do" style="color:#2b2b2b;">공지사항</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>

			<!-- End Side Menu -->

		</nav>
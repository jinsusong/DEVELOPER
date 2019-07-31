<%@page import="poly.dto.BlockDTO"%>
<%@page import="poly.util.Block"%>
<%@page import="poly.dto.DeveloperDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 

	List<BlockDTO> bList = (List<BlockDTO>)request.getAttribute("bList"); 
	List<Block> blockchain = (List<Block>)request.getAttribute("blockchain");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>블록 모니터링</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<%@ include file="/WEB-INF/view/headLink.jsp" %>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script type="text/javascript">
	function updateBlock(){
		alert("비정상적인 블록 생성입니다.");
		$.ajax({
			url: "/blockAdd.do",
			method : "post",
			data : {
				"privioushash" :"",
				"contents" : ""
			},
			dataType: "json",
			success: function(data){
				//console.log(data);
				var contents = "";
				
				 $.each(data,function(key, value){
					console.log(value.hash);
					console.log(value.nonce);
					console.log(value.previousHash);
					console.log(value.timeStamp);
					contents +="<div>HASH. "+value.hash+ " *data*  PREVIOUSHASH" +value.previousHash + "</div>";
				});
				contents += "<div>";
				contents += "<a href='/blockDel.do'>블록 제거</a>";
				contents += "</div>"
				console.log("contents : " + contents);
				
				$('#blockError').html(contents); 
				
			}
		});
	}
	</script>
	
	<!-- Styles -->
		<style>
		#chartdiv {
		  width: 100%;
		height:550px;
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

		<%@ include file="/WEB-INF/view/topNav.jsp" %>
		
		<!--Service Section-->
		<section id="service" class="service">
			<div class="container">
				<div class="row">
					<div class="main_service roomy-100">
						<div class="col-md-8 col-sm-10 mr-md-auto ml-md-auto mr-sm-auto ml-sm-auto">
							<div id="blockError">
								<div class="head_title text-center">
									<h2>BLOCK MONITOR</h2>
									<div class="separator_auto"></div>
									<p><i class="icofont icofont-imac"></i>You can view data for blocks that are linked by blockchain. <br/>
										<a href="JavaScript:updateBlock();">CREATE BlOCK ERROR</a>
									</p>
								</div>
							
								
							</div>
							
							<!-- Resources -->
							<script src="https://www.amcharts.com/lib/4/core.js"></script>
							<script src="https://www.amcharts.com/lib/4/charts.js"></script>
							<script src="https://www.amcharts.com/lib/4/plugins/forceDirected.js"></script>
							<%-- <%@include file="/WEB-INF/view/block/blockChart.jsp" %> --%>
								
							<div id="chart">
								<div id='chartdiv'></div>
							</div>
						</div>
						<div class="row">
						<%if(bList.size()>0){ %>
							<div class="col-md-2">
								<div class="service_item">
									<h6 class="m-top-30">NUMBER</h6>
									<div class="separator_small"></div>
								</div>
							</div>
							<div class="col-md-2">
								<div class="service_item">
									<h6 class="m-top-30">TIMESTAMP</h6>
									<div class="separator_small"></div>
								</div>
							</div>
							<div class="col-md-2">
								<div class="service_item">
									<h6 class="m-top-30">BLOCKHASH</h6>
									<div class="separator_small"></div>
								</div>
							</div>
							<div class="col-md-2">
								<div class="service_item">
									<h6 class="m-top-30">NONCE</h6>
									<div class="separator_small"></div>
								</div>
							</div>
							<div class="col-md-2">
								<div class="service_item">
									<h6 class="m-top-30">PRIEVIOUSHASH</h6>
									<div class="separator_small"></div>
								</div>
							</div>
							<div class="col-md-2">
								<div class="service_item">
									<h6 class="m-top-30">TRANSACTION</h6>
									<div class="separator_small"></div>
								</div>
							</div>
							<%for(int i=0; i<bList.size(); i++){ %>
									<div class="col-md-2">
										<div class="service_item">
											<p style="text-overflow: ellipsis; overflow: hidden;"><%=bList.get(i).getBlocknumber()%></p>
										</div>
									</div>
									<div class="col-md-2">
										<div class="service_item">
											<p style="text-overflow: ellipsis; overflow: hidden;"><%=bList.get(i).getTimestamp()%></p>
										</div>
									</div>
									<div class="col-md-2">
										<div class="service_item">
											<p style="text-overflow: ellipsis; overflow: hidden;"><%=bList.get(i).getBlockhash()%></p>
										</div>
									</div>
									<div class="col-md-2">
										<div class="service_item">
											<p style="text-overflow: ellipsis; overflow: hidden;"><%=bList.get(i).getNonce()%></p>
										</div>
									</div>
									<div class="col-md-2">
										<div class="service_item">
											<p style="text-overflow: ellipsis; overflow: hidden;"><%=bList.get(i).getPreviousHash()%></p>
										</div>
									</div>
									<div class="col-md-2">
										<div class="service_item">
											<p style="text-overflow: ellipsis; overflow: hidden;"><%=bList.get(i).getTransaction()%></p>
										</div>
									</div>
							<%} %>
						<%} %>
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

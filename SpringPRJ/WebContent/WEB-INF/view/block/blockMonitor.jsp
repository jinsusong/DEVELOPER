<%@page import="poly.dto.BlockDTO"%>
<%@page import="poly.util.Block"%>
<%@page import="poly.dto.DeveloperDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% List<BlockDTO> bList = (List<BlockDTO>)request.getAttribute("bList"); %>

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
	
	
	<script src="/assets/js/chartCore.js"></script>
	<!-- <script src="https://www.amcharts.com/lib/4/core.js"></script> -->
	<script src="/assets/js/charts.js"></script>
	<!-- <script src="https://www.amcharts.com/lib/4/charts.js"></script> -->
	<!-- <script stc="/assets/js/forceDirected.js"></script> -->
	<script src="https://www.amcharts.com/lib/4/plugins/forceDirected.js"></script>
	
	
	
	<script type="text/javascript">
	
	function ajaxPage(){
		alert("ajaxPage");
		$.ajax({
	   		
	   		url:"/ajaxPage.do",
	  		method:"get",
	  		dataType:'text',
	  		success:function(data){
	  		$("div").remove("#chartdiv", "#chartScriptDel");
	  		$('#blockError').html(data);
	  			
	  		},
	  		error:function(){
	  			
	  		}
	  	})
	}
	
	function updateBlock(){
		alert("n번째 블록을 수정하시겠습니까?\n비정상적인 블록 생성입니다.");
		$.ajax({
			url: "/blockAdd.do",
			method : "post",
			data : {
				"privioushash" :"",
				"contents" : ""
			},
			//text로 해서 렌더링된 page를 통째로 반환
			dataType: "text",
			success: function(data){
				//console.log(data);
				$('#blockError').html(data); 
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
							<div class="head_title text-center">
								<h2>BLOCK MONITOR</h2>
								<div class="separator_auto"></div>
								<p><i class="icofont icofont-imac"></i>You can view data for blocks that are linked by blockchain. <br/>
									<!-- <a href="JavaScript:updateBlock();">CREATE BlOCK ERROR</a><br/> -->
									<a href="/ajaxPage.do">리스트로 보기</a>, <a href="/blockLocation.do">블록 위치</a>
								</p>
							</div>
						</div>
						
						<div class="row">
						<%if(bList.size()>0){ %>
							
							<div id="chartScriptDel">
								<!-- Resources -->
								
								
								<!-- Chart code -->
								<script>
								am4core.ready(function() {
								
								// Themes begin
								// Themes end
								
								var chart = am4core.create("chartdiv", am4plugins_forceDirected.ForceDirectedTree);
								
								var networkSeries = chart.series.push(new am4plugins_forceDirected.ForceDirectedSeries())
								networkSeries.dataFields.linkWith = "linkWith";
								networkSeries.dataFields.name = "name";
								networkSeries.dataFields.id = "name";
								networkSeries.dataFields.value = "value";
								networkSeries.dataFields.children = "children";
								
								networkSeries.nodes.template.label.text = "{name}"
								networkSeries.fontSize = 8;
								networkSeries.linkWithStrength = 0;
								
								var nodeTemplate = networkSeries.nodes.template;
								nodeTemplate.tooltipText = "{name}";
								nodeTemplate.fillOpacity = 1;
								nodeTemplate.label.hideOversized = true;
								nodeTemplate.label.truncate = true;
								
								var linkTemplate = networkSeries.links.template;
								linkTemplate.strokeWidth = 1;
								var linkHoverState = linkTemplate.states.create("hover");
								linkHoverState.properties.strokeOpacity = 1;
								linkHoverState.properties.strokeWidth = 2;
								
								nodeTemplate.events.on("over", function (event) {
								    var dataItem = event.target.dataItem;
								    dataItem.childLinks.each(function (link) {
								        link.isHover = true;
								    })
								})
								
								nodeTemplate.events.on("out", function (event) {
								    var dataItem = event.target.dataItem;
								    dataItem.childLinks.each(function (link) {
								        link.isHover = false;
								    })
								})
								
								var array =[];
								console.log(<%=bList.size()%>);
								<%if(bList.size()>10){%>
									<%for(int i= (bList.size()-11); i < (bList.size()-1); i++){%>
										array[<%=i%>] =  {  
									      "name":"<%=bList.get(i).getBlockhash()%>",
									      "value":0.05,
									      "linkWith":[
									    	  <%if(bList.size()>5){%>
									         "<%=bList.get(i-1).getBlocknumber()%>",
									         "<%=bList.get(i-2).getTimestamp()%>",
									         "<%=bList.get(i-3).getBlockhash()%>",
									         "<%=bList.get(i-1).getNonce()%>",
									         "<%=bList.get(i-2).getPreviousHash()%>",
									         "<%=bList.get(i-3).getTransaction()%>"
									       	<%}%>
									      ],
									      "children":[  
									         {  
									            "name":"<%=bList.get(i).getTimestamp()%>",
									            "value":0.001
									         },
									         {  
									            "name":"<%=bList.get(i).getNonce()%>",
									            "value":0.001
									         },
									         {  
									            "name":"<%=bList.get(i).getPreviousHash()%>",
									            "value":0.001
									         },
									         {  
									            "name":"<%=bList.get(i).getTransaction()%>",
									            "value":0.001
									         }
									         
									      ]
									   };
									<%}%>
								<%}%>
								
								networkSeries.data = array;
								
								}); // end am4core.ready()
								</script>
							</div>
							<div id="blockError" class="row">
							</div>
							<div id='chartdiv'></div>
						<%}else{ %>
						<div>생성된 블록이 없습니다.</div>
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

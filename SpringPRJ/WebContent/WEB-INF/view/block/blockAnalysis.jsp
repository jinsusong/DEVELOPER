<%@page import="poly.dto.BlockDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<BlockDTO> bList2 = (List<BlockDTO>)request.getAttribute("bList2");

%>
	<!-- Resources -->
	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/frozen.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	
	<script>
		am4core.ready(function() {
		
		// Themes begin
		am4core.useTheme(am4themes_frozen);
		am4core.useTheme(am4themes_animated);
		// Themes end
		
		// Create chart instance
		var chart = am4core.create("chartdiv", am4charts.XYChart);
		
		var arrayChgdt = [];
		<%for(int i= 0; i < (bList2.size()-1); i++){%>
		  
		var hour = <%=bList2.get(i).getChgdt().substring(11,12)%>;
		var hourSuccess;
		var hourNum;
		
		if(hour==0){
			console.log("hour ==0 success");
			hourSuccess = <%=bList2.get(i).getChgdt().substring(12,13)%>
			hourNum = parseFloat(hourSuccess);
			console.log("hour ==0 12,13 : " +<%=bList2.get(i).getChgdt().substring(12,13)%>);
			console.log("parseFloat(hourNum).toFixed(1) : " + parseFloat(hourNum).toFixed(1));
			arrayChgdt[<%=i%>] =  {  
			  "date": "<%=bList2.get(i).getChgdt()%>",
			  "ay": hourNum.toFixed(1),
			  "by": 2.0,
			  "aValue": 1,
			  "bValue": 1
	      	};
		}else if(hour==1 || hour==2){
			hourSuccess = <%=bList2.get(i).getChgdt().substring(11,13)%>
			hourNum = parseFloat(hourSuccess);
			console.log("hour !=0 11,13 : " +<%=bList2.get(i).getChgdt().substring(11,13)%>);
			arrayChgdt[<%=i%>] =  {  
			  "date": "<%=bList2.get(i).getChgdt()%>",
			  "ay": hourNum.toFixed(1),
			  "by": 2.0,
			  "aValue": 1,
			  "bValue": 1
	      	};
		};
		console.log("hourSuccess : " + hourSuccess);
		console.log("hourNum : " + hourNum);
		console.log("typeOf : " + typeof hourNum);
		hourSuccess = null;
		hourNum =null;
		
		<%}%>
		
		// Add data
		chart.data = arrayChgdt;
		
		// Create axes
		var xAxis = chart.xAxes.push(new am4charts.DateAxis());
		xAxis.dataFields.category = "category";
		xAxis.renderer.grid.template.location = 0;
		//xAxis.renderer.minGridDistance = 30;
		
		var yAxis = chart.yAxes.push(new am4charts.ValueAxis());
		
		// Create series
		var series1 = chart.series.push(new am4charts.LineSeries());
		series1.dataFields.valueY = "ay";
		series1.dataFields.dateX = "date";
		series1.dataFields.value = "aValue";
		series1.strokeOpacity = 0;
		series1.cursorTooltipEnabled = false;
		
		var bullet1 = series1.bullets.push(new am4charts.CircleBullet());
		bullet1.tooltipText = "x:{valueX} y:{valueY}";
		series1.heatRules.push({
		  target: bullet1.circle,
		  min: 10,
		  max: 60,
		  property: "radius"
		});
		
		var series2 = chart.series.push(new am4charts.LineSeries());
		series2.dataFields.valueY = "by";
		series2.dataFields.dateX = "date";
		series2.dataFields.value = "bValue";
		series2.strokeOpacity = 0;
		series2.cursorTooltipEnabled = false;
		
		var bullet2 = series2.bullets.push(new am4charts.Bullet());
		bullet2.tooltipText = "x:{valueX} y:{valueY}";
		
		var rectangle2 = bullet2.createChild(am4core.Rectangle);
		rectangle2.verticalCenter = "middle";
		rectangle2.horizontalCenter = "middle";
		rectangle2.width = 10;
		rectangle2.height = 10;
		rectangle2.rotation = 45;
		rectangle2.stroke = am4core.color("#fff");
		rectangle2.strokeWidth = 1;
		rectangle2.nonScalingStroke = true;
		series2.heatRules.push({
		  target: rectangle2,
		  min: 1,
		  max: 6,
		  property: "scale"
		});
		
		// Add scrollbars
		chart.scrollbarX = new am4core.Scrollbar();
		chart.scrollbarY = new am4core.Scrollbar();
		
		// Add cursor
		chart.cursor = new am4charts.XYCursor();
		chart.cursor.behavior = "zoomXY";
		
		
		arrayChgdt = [];
		}); // end am4core.ready()
		</script>
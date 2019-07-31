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

<div class="col-md-12">
	<input type="text">
	<a href="JavaScript:updateBlock();">CREATE BlOCK ERROR</a>
</div>


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

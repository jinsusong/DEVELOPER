<%@page import="poly.dto.BlockDTO"%>
<%@page import="poly.util.Block"%>
<%@page import="poly.dto.DeveloperDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 

	List<BlockDTO> bList = (List<BlockDTO>)request.getAttribute("bList"); 
	List<Block> blockchain = (List<Block>)request.getAttribute("blockchain");
	List<Block> blockchainError = (List<Block>)request.getAttribute("blockchainError");
%>			
<div>
	<!-- <a href='/blockDel.do'>블록 제거</a> -->
	
	
		<!--About Sections-->
		<section id="about" class="about roomy-100" style="padding-top:0;">
			<div class="container">
				<div class="container">
				<div class="row">
					<div class="skill_bottom_content text-center">
						<div class="col-md-4">
							<div class="skill_bottom_item">
								<h2 class="statistic-counter">3468</h2>
								<div class="separator_small"></div>
								<h5><em>BLOCK</em></h5>
							</div>
						</div>
						<div class="col-md-4">
							<div class="skill_bottom_item">
								<h2 class="statistic-counter">1</h2>
								<div class="separator_small"></div>
								<h5><em>ERROR</em></h5>
							</div>
						</div>
						<div class="col-md-4">
							<div class="skill_bottom_item">
								<h2 class="statistic-counter">100</h2>
								<div class="separator_small"></div>
								<h5><em>SUCCESS</em></h5>
							</div>
						</div>
					</div>
				</div>
				<!--End off row-->
			</div>
			<br />
			<br />
			<br />
			<br />
			<!--End off container -->
			
			
				<div>
					<span>Blockchain is Valid : false</span>
					<span>Previous Hashes not equal : 이전 해쉬가 같지 않음<br/></span>
				</div>
				
				<div class="row">
					<div class="main_about">
						<div class="col-md-12">
							<div class="about_content">
								<h2>Error Block</h2>
								<div class="separator_left"></div>
								<div style="text-overflow: ellipsis; overflow: hidden;">
									<%=blockchainError.get((blockchainError.size()-1)).hash %>.
								</div>
								<div style="text-overflow: ellipsis; overflow: hidden;">
									<%=blockchainError.get((blockchainError.size()-1)).nonce %>.
								</div>
								<div style="text-overflow: ellipsis; overflow: hidden;">
									<%=blockchainError.get((blockchainError.size()-1)).previousHash %>.
								</div>
								<div style="text-overflow: ellipsis; overflow: hidden;">
 									<%=blockchainError.get((blockchainError.size()-1)).timeStamp %>.
								</div>
							</div>
						</div>
						<%-- <div class="col-md-6">
							<div class="about_content">
								<h2>Normal Block</h2>
								<div class="separator_left"></div>
								<div style="text-overflow: ellipsis; overflow: hidden;">
									<%=blockchain.get((blockchain.size()-1)).hash %>.
								</div>
								<div style="text-overflow: ellipsis; overflow: hidden;">
									<%=blockchain.get((blockchain.size()-1)).nonce %>.
								</div>
								<div style="text-overflow: ellipsis; overflow: hidden;">
									<%=blockchain.get((blockchain.size()-1)).previousHash %>. 
								</div>
								<div style="text-overflow: ellipsis; overflow: hidden;">
 									<%=blockchain.get((blockchain.size()-1)).timeStamp %>.
								</div>
							</div>
						</div> --%>
						<div class="about_btns m-top-40">
							<a href="/blockDel.do" class="btn btn-primary">ERROR BLOCK UPDATE</a>
						</div>
					</div>
				</div>
				<!--End off row-->
			</div>
			<!--End off container -->
			
			
			
		</section>
		<!--End off About section -->
</div>

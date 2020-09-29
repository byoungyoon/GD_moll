<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prodcutList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%
	// 로그인 되어있을 때만 접근 가능
	if(session.getAttribute("sessionToLogin") == null){
		response.sendRedirect("/moll_admin/login/login.jsp");
		return;
	}
	// 인코딩 형식
	request.setCharacterEncoding("UTF-8");
	
	// 회원의 아이디는 그 상품 주문내역 출력할때 필요하기 때문에 항상 데려다녀야함
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	String memberEmail = request.getParameter("memberEmail");
	
	//System.out.println(memberEmail + "<---memeberEmail");
	//System.out.println(categoryId + "<---categoryId");

	ArrayList<Product> list = new ArrayList<Product>();
	ProductDao productDao = new ProductDao();
	
	list = productDao.selectProductName(categoryId);
%>
	<div class="container">
		<div class="row">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<jsp:include page="/inc/menu2.jsp"></jsp:include>
		
		<br>
			
		<div>
			<h3><i class="fa fa-glide-g" style="font-size:36px"></i> 카테고리 상품 전체 보기</h3>
		</div>
		
		<div class="row">
		<%
			for(Product p : list){
				%>
					<!-- 줄을 12로 나눈것을 4개씩 계속 출력-->
					<div class="col-sm-4 text-center">
						<div class="card" style="width:300px;">
							<!-- product의 사진을 default 사진으로 지정// 나는 1.jpg -->
	 						<img class="card-img-top" src="<%=request.getContextPath()%>/image/1.jpg" alt="Card image">
	 						<a href="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=p.getProductId() %>&memberEmail=<%=memberEmail %>" class="btn btn-outline-secondary">
		 						<div class="card-body">
		 							<!-- 한 묷음의 이름 -->
		 							<%
		 								// 이름이 너무 긴거 같아서 자르는 알고리즘
		 								// 이름 기준을 limit로 하여 limit보다 길면 ... 을 붙임
		 								int limit = 12;
		 								
		 								// str의 변수에 product이름을 분할하여 배열에 저장
		 								String[] str = p.getProductName().split("");
		 								String len = "";
		 								
		 								// str의 변수의 길이가 limit보다 작을때 그냥 저장
		 								// 아닐때는 뒤에 ...을 붙임
		 								if(str.length < limit){
			 								for(int i=0; i<str.length; i++){
			 									len += str[i];
			 								}
		 								}
		 								else{
		 									for(int i=0; i<limit; i++){
			 									len += str[i];
			 								}
		 									len += " ...";
		 								}
		 								%>
		 									<!-- len을 이름으로 출력 -->
		 									<h4 class="card-title"><%=len %> </h4>
									<!-- 한 묷음의 설명 -->
	 								<p class="card-text"><%=p.getProductPrice() %></p>
		 						</div>
	 						</a>
						</div>
					</div>
				<%
				}
		%>
		</div>
	</div>
</body>
</html>
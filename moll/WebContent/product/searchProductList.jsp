<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchProductList</title>
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
	Object ob = session.getAttribute("sessionToLogin");
	String memberEmail = "";
	if(ob != null){
		memberEmail = (String)ob;
	}
	
	// 인코딩 형식
	request.setCharacterEncoding("UTF-8");
	
	String searchProduct = request.getParameter("searchProduct");
	
	ProductDao productDao = new ProductDao();
	ArrayList<Product> list = productDao.searchProductList(searchProduct);
%>
	<div class="container">
		<!-- 메뉴바 -->
		<div class="row">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<jsp:include page="/inc/menu2.jsp"></jsp:include>
		
		<br>
		<!-- 소제목 -->
		<div>
			<h3><i class="fa fa-glide-g" style="font-size:36px"></i>상품 검색</h3>
		</div>
		
		<!-- 본문 -->
		<div class="row">
		<%
			if(list.size() == 0){
			%>
				<div class="text-danger" style="font-size:36px">
					검색하신 상품이 없습니다.
				</div>
			<% 
			}
			for(Product p : list){
			%>
				<div class="col-sm-4 text-center">
					<div class="card" style="width:350px;">
						<!-- product의 사진을 default 사진으로 지정// 나는 1.jpg -->
	 					<img class="card-img-top" src="/moll_admin/image/<%=p.getProductPic() %>" alt="Card image" style="height:300px;">
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
		
		<br>
	</div>
</body>
</html>












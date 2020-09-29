<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productOne</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%
	// 로그인 되어 있을때만 사용가능
	if(session.getAttribute("sessionToLogin") == null){
		response.sendRedirect("/moll_admin/login/login.jsp");
		return;
	}

	// 인코딩 형식
	request.setCharacterEncoding("UTF-8");
	
	// orders테이블에 넣을 데이터에 필요한 prodcutid와 memberemial값을 받아옴
	int productId = Integer.parseInt(request.getParameter("productId"));
	String memberEmail = request.getParameter("memberEmail");
	
	Product paramProduct = new Product();
	paramProduct.setProductId(productId);
	
	ProductDao productDao = new ProductDao();
	Product product = productDao.selectProductOne(paramProduct);
%>
	<div class="container">
		<div class="row">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<jsp:include page="/inc/menu2.jsp"></jsp:include>
		
		<br>
			
		<div>
			<h3><i class="fa fa-glide-g" style="font-size:36px"></i> 상품 구매 하기</h3>
		</div>
		
		<br>
		
		<form method="post" action="<%=request.getContextPath() %>/product/ordersInputAction.jsp">
			<div class="row">
				<div class="col-sm-6">
					<img src="<%=request.getContextPath() %>/image/<%=product.getProductPic() %>">
				</div>
				<div class="col-sm-6">
					<table class="table text-center">
						<tr>	
							<th>상품 명</th>
							<td><%=product.getProductName() %></td>
						</tr>
						<tr>	
							<th>상품 설명</th>
							<td><%=product.getProductContent() %></td>
						</tr>
						<tr>	
							<th>가격</th>
							<td><%=product.getProductPrice() %></td>
							<td><input type="hidden" name="productPrice" value="<%=product.getProductPrice() %>"></td>
						</tr>
						<tr>	
							<th>상품 여부</th>
							<td><%=product.getProductSoldout() %></td>
						</tr>
						<tr>	
							<th>수량</th>
							<td>
								<select name="ordersAmount" style="font-size:20px">
									<option value="0">0</option>
									<%
										for(int i=1; i<10; i++){
										%>
											<option value=<%=i %>><%=i %></option>
										<%
										}
									%>
								</select>
							</td>
						</tr>
						<tr>	
							<th>주소</th>
							<td><textarea name="ordersAddr" cols="50" rows="5"></textarea></td>
						</tr>
					</table>
					<input type="hidden" name="memberEmail" value=<%=memberEmail %>>
					<input type="hidden" name="productId" value=<%=productId %>>
				</div>
			</div>
			
			<div class="row">
				<div class="col-sm-10"></div>
				<div class="col-sm-2">
					<%
						// 관리자는 구매 버튼 활성화 금지(관리자 계정으로 물품을 시킬일은 없을것 같다)
						if(memberEmail.equals("Admin")){
						%>
							<button class="btn btn-outline-secondary btn-block disabled" type="submit" disabled="disabled">구매</button>
						<%
						}
						else{
						%>
							<button class="btn btn-outline-secondary btn-block" type="submit">구매</button>
						<%
						}
					%>
				</div>
			</div>
		</form>
	</div>
</body>
</html>	








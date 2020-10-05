<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectProductList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%
	//로그인 되어 있을때만 사용가능
	if(session.getAttribute("sessionToLogin") == null){
		response.sendRedirect("/moll_admin/login/login.jsp");
		return;
	}
	
	// 사용자 이메일을 세션값에서 받아옴
	Object ob = session.getAttribute("sessionToLogin");
	String memberEmail = "";
	if(ob != null){
		memberEmail = (String)ob;
	}

	ArrayList<ShoppingAndProduct> list = new ArrayList<ShoppingAndProduct>();
	ShoppingDao shoppingDao = new ShoppingDao();
	
	ShoppingAndProduct paramSap = new ShoppingAndProduct();
	paramSap.product = new Product();
	paramSap.shopping = new Shopping();
	paramSap.shopping.setMemberEmail(memberEmail);
	
	list = shoppingDao.selectShoppingList(paramSap);
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
			<h3><i class="fa fa-glide-g" style="font-size:36px"></i> 장바구니</h3>
		</div>
		<form method="post" action="<%=request.getContextPath() %>/product/selectProductDeleteAction.jsp">
			<table class="table text-center">
				<thead>
					<tr>
						<th>shopping_count</th>
						<th>product_name</th>
						<th>product_price</th>
						<th>product_pic</th>
						<th></th>
					</tr>
				</thead>
				
				<tbody>
					<%
						int count = 1;
						for(ShoppingAndProduct sap : list){
						%>
							<tr>
								<td class="align-middle"><a href="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=sap.shopping.getProductId() %>"><%=count %></a></td>
								<td class="align-middle"><%=sap.product.getProductName() %></td>
								<td class="align-middle"><%=sap.product.getProductPrice() %></td>
								<td><img src="/moll_admin/image/<%=sap.product.getProductPic() %>" width="35%"></td>
								<td class="align-middle"><input type="checkbox" name="shoppingId" value=<%=sap.shopping.getShoppingId() %> class="form-check-input"></td>
							</tr>
						<%
						count++;
						}
					%>
				</tbody>
			</table>
			
			<div class="row">
				<div class="col-sm-10"></div>
				<div class="col-sm-2">
					<button type="submit" class="btn btn-outline-secondary btn-block">삭제</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
















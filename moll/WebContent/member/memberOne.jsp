<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberOne.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%
	// 로그인 되어 있을 때만 사용가능       / 세션 처리 해줘야함 관리자가 못 들어오게(미완)
	if(session.getAttribute("sessionToLogin") == null){
		response.sendRedirect("/moll_admin/login/login.jsp");
		return;
	}

	// 인코딩 형식
	request.setCharacterEncoding("UTF-8");
	String memberEmail = request.getParameter("memberEmail");
	
	// 마이페이지의 신상 정보
	Member paramMember = new Member();
	paramMember.setMemberEamil(memberEmail);
	
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberOne(paramMember);
	
	// 마이페이지의 구매 목록
	ArrayList<OrdersAndProduct> list = new ArrayList<OrdersAndProduct>();
	OrdersAndProduct paramOap = new OrdersAndProduct();
	paramOap.product = new Product();
	paramOap.orders = new Orders();
	paramOap.orders.setMemberEmail(memberEmail);
	
	OrdersDao ordersDao = new OrdersDao();
	list = ordersDao.selectOrdersList(paramOap);
%>
	<div class="container">
		<div class="row">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
	
		<jsp:include page="/inc/menu2.jsp"></jsp:include>
	
		<br>
		<!-- 신사 정보란 member 테이블에서 데이터 받아옴 -->
		<div>
			<h3><i class="fa fa-glide-g" style="font-size:36px"></i> 신상 정보</h3>
		</div>
		
		<table class="table">
			<tr>
				<th>member_email</th>
				<td><%=member.getMemberEamil() %></td>
			</tr>
			
			<tr>
				<th>member_name</th>
				<td><%=member.getMemberName() %></td>
			</tr>
			
			<tr>
				<th>member_date</th>
				<td><%=member.getMemberDate() %></td>
			</tr>
			
		</table> 
		
		<br>
		<!-- 구매 목록란 orders 테이블에서 데이터 받아옴 -->
		<div>
			<h3><i class="fa fa-glide-g" style="font-size:36px"></i> 구매 목록</h3>
		</div>
		
		<table class="table">
			<thead>
				<tr>
					<th>prodcut_name</th>
					<th>orders_amount</th>
					<th>orders_price</th>
					<th>orders_addr</th>
					<th>orders_state</th>
					<th>orders_date</th>
				</tr>
			</thead>
			
			<tbody>
				<%
					for(OrdersAndProduct oap : list){
					%>
						<tr>
							<td><%=oap.product.getProductName() %></td>
							<td><%=oap.orders.getOrdersAmount() %></td>
							<td><%=oap.orders.getOrdersPrice() %></td>
							<td><%=oap.orders.getOrdersAddr() %></td>
							<td><%=oap.orders.getOrdersState() %></td>
							<td><%=oap.orders.getOrdersDate() %></td>
						</tr>
					<%
					}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>












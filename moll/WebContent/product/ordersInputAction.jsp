<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 로그인 되어 있을때만 사용가능
	if(session.getAttribute("sessionToLogin") == null){
		response.sendRedirect(request.getContextPath() + "/login/login.jsp");
		return;
	}

	Object ob = session.getAttribute("sessionToLogin");
	String memberEmail = "";
	if(ob != null){
		memberEmail = (String)ob;
	}

	int productId = Integer.parseInt(request.getParameter("productId"));
	int ordersAmount = Integer.parseInt(request.getParameter("ordersAmount"));
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int ordersPrice = ordersAmount * productPrice;
	String ordersAddr = request.getParameter("ordersAddr");
	
	// orders 테이블에 데이터를 추가하기 위해 객체 선언
	Orders paramOrders = new Orders();
	paramOrders.setProductId(productId);
	paramOrders.setOrdersAmount(ordersAmount);
	paramOrders.setOrdersPrice(ordersPrice);
	paramOrders.setOrdersAddr(ordersAddr);
	paramOrders.setMemberEmail(memberEmail);
	
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.selectOrdersOne(paramOrders);
	
	// 구매 후 장바구니에 있는 정보를 지우기 위해 객체 선언
	Shopping paramShopping = new Shopping();
	paramShopping.setMemberEmail(memberEmail);
	paramShopping.setProductId(productId);
	
	ShoppingDao shoppingDao = new ShoppingDao();
	// 장바구니에 있는 정보 삭제
	shoppingDao.deleteShoppingToProduct(paramShopping);
	
	response.sendRedirect(request.getContextPath() + "/mollIndex.jsp");
%>
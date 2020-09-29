<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	int productId = Integer.parseInt(request.getParameter("productId"));
	int ordersAmount = Integer.parseInt(request.getParameter("ordersAmount"));
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int ordersPrice = ordersAmount * productPrice;
	String memberEmail = request.getParameter("memberEmail");
	String ordersAddr = request.getParameter("ordersAddr");
	
	Orders paramOrders = new Orders();
	paramOrders.setProductId(productId);
	paramOrders.setOrdersAmount(ordersAmount);
	paramOrders.setOrdersPrice(ordersPrice);
	paramOrders.setOrdersAddr(ordersAddr);
	paramOrders.setMemberEmail(memberEmail);
	
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.selectOrdersOne(paramOrders);
	
	response.sendRedirect(request.getContextPath() + "/mollIndex.jsp");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 인코딩 형식
	request.setCharacterEncoding("UTF-8");
	
	// 저장할 데이터 가져옴
	String memberEmail = request.getParameter("memberEmail");
	int productId = Integer.parseInt(request.getParameter("productId"));
	
	// 객체에 저장
	Shopping paramShopping = new Shopping();
	paramShopping.setMemberEmail(memberEmail);
	paramShopping.setProductId(productId);
	
	// shopping 테이블에 데이터 저장
	ShoppingDao shoppingDao = new ShoppingDao();
	shoppingDao.insertShopping(paramShopping);
	
	// 메인 홈으로 복귀
	response.sendRedirect(request.getContextPath()+"/mollIndex.jsp");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 로그인 되어 있을때만 사용가능
	if(session.getAttribute("sessionToLogin") == null){
		response.sendRedirect("/moll_admin/login/login.jsp");
		return;
	}
	// selectProductList에서 체크박스를 체크하지 않았을 경우 다시 return
	if(request.getParameterValues("shoppingId") == null){
		response.sendRedirect("selectProductList.jsp");
		return;
	}
	
	String[] shoppingIdStr = request.getParameterValues("shoppingId");
	
	Shopping paramShopping = new Shopping();
	ShoppingDao shoppingDao = new ShoppingDao();
	
	for(int i=0; i<shoppingIdStr.length; i++){
		int shoppingId = Integer.parseInt(shoppingIdStr[i]);
		
		paramShopping.setShoppingId(shoppingId);
		shoppingDao.deleteShopping(paramShopping);
	}
	
	response.sendRedirect("selectProductList.jsp");
%>
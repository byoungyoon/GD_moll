<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%	
	request.setCharacterEncoding("UTF-8");
	
	// 로그인한 id와 pw를 받아온다
	String memberEamil = request.getParameter("loginEmail");
	String memberPw = request.getParameter("loginPw");
	
	// admin 데이터베이스 관련
	Member member = new Member();
	member.setMemberEamil(memberEamil);
	member.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();		
	
	Object ob = null;
	String ses = "";
	
	// 관리자 계정을 입력하였을 때 쇼핑몰 홈페이지로 이동
	// 세션 관리자를 선언하고 그때 ses변수로 Admin을 보낸다
	if(memberDao.selectMemberLogin(member) == 1){
		session.setAttribute("sessionToLogin", memberEamil);
		ob = session.getAttribute("sessionToLogin");
		ses = (String)ob;
		response.sendRedirect(request.getContextPath()+"/mollIndex.jsp?ses=" + ses);
		return;
	}
	
	response.sendRedirect(request.getContextPath() + "/login/login.jsp");
%>




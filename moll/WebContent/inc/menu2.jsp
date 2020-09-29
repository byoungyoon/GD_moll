<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- flex 브투스트랩 , reverse반대로, bg 배경, text 색깔 -->
<div class="d-flex p-2 flex-row-reverse bg-dark text-white">
	<%
		// 세션값을 String 형으로 받기 위해서 object형으로 형변환을 하였다.
		Object ob = session.getAttribute("sessionToLogin");
		String memberEmail = (String)ob;
		
		// 세션이 선언이 안되어 있으면 로그인,회원가입을 표시하고, 되어있으면 그 사용자의 이름과 로그아웃 표시
		if(memberEmail == null){
		%>
			<a class="nav-link btn btn-outline-secondary" href="/moll_admin/login/login.jsp">로그인</a>
 			<a class="nav-link nav-link btn btn-outline-secondary" href="/moll_admin/login/createLogin.jsp">회원가입</a>
		<%
		}
		else if(memberEmail.equals("Admin")){
			%>
				<a class="nav-link btn btn-outline-secondary" href="<%=request.getContextPath() %>/mollLogoutAction.jsp">로그아웃</a>
				<!-- 로그인이 되었을 때 그 로그인한 사용자를 표시해준다. -->
				<span class="nav-link"><%=memberEmail %>님 어서오세요.</span>
			<%
		}
		else{
			Member paramMember = new Member();
			paramMember.setMemberEamil(memberEmail);
			
			MemberDao memberDao = new MemberDao();
			Member member = memberDao.selectMemberName(paramMember);
		%>
			<a class="nav-link btn btn-outline-secondary" href="<%=request.getContextPath() %>/mollLogoutAction.jsp">로그아웃</a>
			<!-- 로그인이 되었을 때 그 로그인한 사용자를 표시해준다. -->
			<span class="nav-link"><%=member.getMemberName() %>님 어서오세요.</span>
		<%
		}
	%>
</div>
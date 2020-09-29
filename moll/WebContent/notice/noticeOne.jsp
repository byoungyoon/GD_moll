<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeOne</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	int noticeId = Integer.parseInt(request.getParameter("noticeId"));
	
	Notice paramNotice = new Notice();
	paramNotice.setNoticeId(noticeId);
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(paramNotice);
%>

	<div class="container">
		<div class="row">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<jsp:include page="/inc/menu2.jsp"></jsp:include>
		
		<br>
		
		<div>
			<h3><i class="fa fa-glide-g" style="font-size:36px"></i> 공지 사항</h3>
		</div>
	
		<table class="table">
			<tr>	
				<th>notice_id</th>
				<td><%=notice.getNoticeId() %></td>
			</tr>
			
			<tr>	
				<th>notice_title</th>
				<td><%=notice.getNoticeTitle() %></td>
			</tr>
			
			<tr>	
				<th>notice_content</th>
				<td><%=notice.getNoticeContent() %></td>
			</tr>
			
			<tr>	
				<th>notice_date</th>
				<td><%=notice.getNoticeDate() %></td>
			</tr>
		</table>
	</div>
</body>
</html>
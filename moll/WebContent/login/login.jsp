<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 
	로그인 시작 페이지
	
	로그인이 맞을 경우 index.jsp로 틀릴경우 이 페이지로 돌아온다.
 -->
 <script>
 	$(document).ready(function() {
		$("#btn").click(function(){
			if($("#loginEmail").val().length < 1){
				$("#err").text("아이디를 입력하여 주세요");
				return;
			} else if($("#loginPw").val().length < 1){
				$("#err").text("비닐번호를 입력하여 주세요");
				return;
			}
			$("#loginForm").submit();
		});
	});
 </script>
</head>
<body>
<%
	// 세션 입력이 되어있다면 login.jsp는 생략된다
	if(session.getAttribute("adminLogin") != null || session.getAttribute("memberLogin") != null){
		System.out.println("이미 로그인이 되어 있습니다");
		response.sendRedirect("/moll/mollIndex.jsp");
		return;
	}
	
	// 인코딩 형식
	request.setCharacterEncoding("UTF-8");
	
%>
	<div class="container">
		<br><br><br>
		<!-- 사이트 이름 -->
		<a href="#" class="text-dark"><h1 class="font-weight-bold & text-center">Goodee Shop</h1></a>
		<br><br><br><br><br>

		<div class="row">
			<!-- 여백 -->
			<div class="col-sm-3"></div>
			
			<!-- 로그인 창 -->
			<div class="col-sm-6 text-center">
			<form method="post" action="<%=request.getContextPath() %>/login/loginAction.jsp" id="loginForm">
				<!--아이디 입력 -->
				<div class="input-group mb-3 input-group-lg">
					<div class="input-group-prepend">
						<span class="input-group-text"><i class="fa fa-user" style="font-size:30px"></i></span>
					</div>
					<input type="text" class="form-control" placeholder="UserEmail" name="loginEmail" id="loginEmail" value="bur5698@naver.com" style="font-size:30px">
				</div>
			
				<!-- 비닐번호 입력 -->
				<div class="input-group mb-3 input-group-lg">
					<div class="input-group-append">
						<span class="input-group-text"><i class='fas fa-key' style='font-size:30px'></i></span>
					</div>
					<input type="password" class="form-control" placeholder="******" name="loginPw" id="loginPw" value="1234" style='font-size:30px'>
				</div>
				
			<div class="text-right">	
				<a href="<%=request.getContextPath() %>/mollIndex.jsp" class="btn btn-outline-secondary" style='font-size:25px; float:left;'>돌아가기</a>
			</div>
			<div class="text-right">	
				<button type="button" id="btn" class="btn btn-outline-secondary" style='font-size:25px'>로그인</button>
			</div>
				<!-- 색깔 발깐색  에러 출력-->
				<div id="err" class="text-danger text-right">
				</div>
			</form>
			</div>
			
			<div class="col-sm-3"></div>
		</div>
	</div>
</body>							
</html>












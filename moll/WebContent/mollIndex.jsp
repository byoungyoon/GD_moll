<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mollIndex</title>
<!-- 부트스트랩 링크 설정 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body>
<%
	// 인코딩 형식
	request.setCharacterEncoding("UTF-8");
	
	// /moll_admin/login/loginAction.jsp에서 ses의 값을 받아온다
	String ses = request.getParameter("ses");
	if(ses != null){
		session.setAttribute("sessionToLogin", ses);
	}
	
	Object ob = session.getAttribute("sessionToLogin");
	String sessionCk = "";
	if(ob != null){
		sessionCk = (String)ob;
	}
	
	//System.out.println(session.getAttribute("sessionToLogin"));

	// category의 기본키를 받아옴
	int categoryId = 0;
	if(request.getParameter("categoryId") != null){
		categoryId = Integer.parseInt(request.getParameter("categoryId"));	
	}

	// 객체선언
	CategoryDao categoryDao = new CategoryDao();
	ProductDao productDao = new ProductDao();
	NoticeDao noticeDao = new NoticeDao();
	
	// 카테고리 페이징을 위한 함수
	// 시작 값은 0이고 끝의 값은 한칸 씩 이동을 하므로 전체 페이즈의 카운터에서 5를 뺀것
	int currentPage = 0;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int lastPage = categoryDao.categoryCount() - 5;
	
	System.out.println(lastPage + "<--- lastPage");
	System.out.println(currentPage + "<--- currnetPage");
	
	if(currentPage == -1){
		currentPage = 0;
	}
	if(currentPage == lastPage + 1){
		currentPage = lastPage;
	}
	
	// 각각 전체 카테고리 리스트, 이미지를 위한 리스트, 제품 리스트
	ArrayList<Category> list = new ArrayList<Category>();
	ArrayList<Category> list2 = new ArrayList<Category>();
	ArrayList<Category> imageList = new ArrayList<Category>();
	ArrayList<Product> productList = new ArrayList<Product>();
	ArrayList<Notice> noticeList = new ArrayList<Notice>();
	
	if(categoryId == 0){
		productList = productDao.selectProductList();
	}
	else{
		productList = productDao.selectProductName(categoryId);
	}
	// 위의 리스트를 각각 메서드를 불러온다
	list = categoryDao.selectCategoryList(currentPage);
	list2 = categoryDao.selectCategoryList2();
	imageList = categoryDao.selectCategoryCkList();
	noticeList = noticeDao.selectNoticeList();
	
%>
	<!-- 전체 class 컨테이너 선언 -->
	<div class="container">
		<!-- 한 줄 12분할 왼쪽부터 1 오른쪽 마지막 12-->
		<div class="row">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
			<div class="col-sm-3">
				<input type="text" class="form-control" placeholder="검색할 키워드를 입력해주세요" name="">
			</div>
			<!-- 12분할 중 1개 검색 버튼 -->	
			<div class="col-sm-1">
				<a href="" class="btn btn-dark">검색</a>
			</div>
			
			<div class="col-sm-2"></div>
			
			<div class="col-sm-1 text-right">
				<%
					if(sessionCk.equals("Admin")){
					%>
				
						<a href="/moll_admin/index.jsp" class="text-dark">
							<i class="fa fa-user-circle" style="font-size:40px"></i>
						</a>
				
					<% 
					}
					else{
					%>
						<a href="<%=request.getContextPath()%>/member/memberOne.jsp" class="text-dark">
							<i class="fa fa-user-circle" style="font-size:40px"></i>
						</a>
					<% 
					}
				%>
			</div>
			<!-- 12분할 중 1개 카트 -->	
			
			<div class="col-sm-1 text-right">
				<i class="fa fa-shopping-cart" style="font-size:40px"></i>
			</div>
		</div>
		
		<jsp:include page="/inc/menu2.jsp"></jsp:include>
			
		<br>
		
		<!-- 한 줄 12분할 왼쪽부터 1 오른쪽 마지막 12-->
		<div class="row">
			<div class="col-sm-1"></div>
			<div class="col-sm-3">
					<!-- 위 카테고리 위로 화살표 -->
					<a class="btn btn-outline-secondary btn-block" href="<%=request.getContextPath() %>/mollIndex.jsp?currentPage=<%=currentPage-1 %>"><i class='fas fa-angle-double-up' style='font-size:23px'></i></a>
					<br><br>
					 	<%
					 		// 위 카테고리 목록 출력(여기서는 5개씩 페이징)
							for(Category c : list){
							%>
							   <a class="btn btn-outline-secondary btn-block" href="<%=request.getContextPath() %>/product/productList.jsp?categoryId=<%=c.getCategoryId() %>&memberEmail=<%=sessionCk %>"><%=c.getCategoryName() %></a>
							   <br><br>
							<%
						}
						%>
					<!--  위 카테고리 아래로 화살표 -->
					<a class="btn btn-outline-secondary btn-block" href="<%=request.getContextPath() %>/mollIndex.jsp?currentPage=<%=currentPage+1 %>"><i class='fas fa-angle-double-down' style='font-size:23px'></i></a>
			</div>
			<!-- 맨 위 사진 -->
			<div class="col-sm-8 text-center">
				<img src="<%=request.getContextPath()%>/image/1.jpg">
			</div>
		</div>
		
		<br>
		
		<!-- 한 줄 12분할 왼쪽부터 1 오른쪽 마지막 12-->
		<div class="row">	
			<div class="col-sm-3">
				<h3><i class="fa fa-star" style="font-size:36px"></i> 추천 카테고리</h3>
			</div>
		</div>
		
		<br>
		
		<!-- 한 줄 12분할 왼쪽부터 1 오른쪽 마지막 12-->
		<div class="row">
			<!-- 앞 뒤로 12분할 중 1개 여백 -->	
			<div class="col-sm-1"></div>
			
			<!-- 나머지 부분에 이미지 둥글게 -->
			<div class="col-sm-10">
				<!-- 12분할중 10개중에 또 12분할을 함 -->
				<div class="row">
				<%
					// 중간 추천 카테고리 리스트 출력(4개)
					for(Category c : imageList){
					%>
						<div class="col-sm-3 text-center">
							<img src="/moll_admin/image/<%=c.getCategoryPic() %>" class="rounded-circle" width="210px" height="210px">
							<a href="<%=request.getContextPath() %>/product/productList.jsp?categoryId=<%=c.getCategoryId() %>&memberEmail=<%=sessionCk %>" class="text-dark"><%=c.getCategoryName() %></a>
						</div>
					<%
					}
				%>
				</div>
			</div>
			
			<div class="col-sm-1"></div>
		</div>
		
		<br>
		
		<%
			// 캘린더 // 오늘 날짜
			Calendar today = Calendar.getInstance();
		%>
		
		<!-- 한 줄 12분할 왼쪽부터 1 오른쪽 마지막 12-->
		<div class="row">	
			<div class="col-sm-3">
				<h3><i class="fa fa-star" style="font-size:36px"></i> 오늘 추천 상품</h3>
			</div>
			<div class="col-sm-2">
				<span class="d-flex p-2 bg-dark text-white justify-content-center">
					<%=today.get(Calendar.YEAR) %>.<%=today.get(Calendar.MONTH)+1 %>.<%=today.get(Calendar.DAY_OF_MONTH) %>
				</span>
			</div>
		</div>
		
		<br>
		
		<!-- 한 줄 12분할 왼쪽부터 1 오른쪽 마지막 12-->
		<!-- 눌렀을때의 상품 목록 검색 -->
		<div class="row">
			<a class="nav-link btn btn-outline-secondary btn-lg" href="<%=request.getContextPath()%>/mollIndex.jsp?categoryId=0">전체</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
				for(Category c : list2){
				%>
					<a class="nav-link btn btn-outline-secondary btn-lg" href="<%=request.getContextPath()%>/mollIndex.jsp?categoryId=<%=c.getCategoryId() %>"><%=c.getCategoryName() %></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
				<%
				}
			%>
		</div>
		
		<br>
		
		<!-- 한 줄 12분할 왼쪽부터 1 오른쪽 마지막 12-->
		<div class="row">
		<%
			for(Product p : productList){
				%>
					<!-- 줄을 12로 나눈것을 4개씩 계속 출력-->
					<div class="col-sm-4 text-center">
						<div class="card" style="width:300px;">
							<!-- product의 사진을 default 사진으로 지정// 나는 1.jpg -->
	 						<img class="card-img-top" src="<%=request.getContextPath()%>/image/1.jpg" alt="Card image">
	 						<a href="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=p.getProductId() %>&memberEmail=<%=sessionCk %>" class="btn btn-outline-secondary">
		 						<div class="card-body">
		 							<!-- 한 묷음의 이름 -->
		 							<%
		 								// 이름이 너무 긴거 같아서 자르는 알고리즘
		 								// 이름 기준을 limit로 하여 limit보다 길면 ... 을 붙임
		 								int limit = 12;
		 								
		 								// str의 변수에 product이름을 분할하여 배열에 저장
		 								String[] str = p.getProductName().split("");
		 								String len = "";
		 								
		 								// str의 변수의 길이가 limit보다 작을때 그냥 저장
		 								// 아닐때는 뒤에 ...을 붙임
		 								if(str.length < limit){
			 								for(int i=0; i<str.length; i++){
			 									len += str[i];
			 								}
		 								}
		 								else{
		 									for(int i=0; i<limit; i++){
			 									len += str[i];
			 								}
		 									len += " ...";
		 								}
		 								%>
		 									<!-- len을 이름으로 출력 -->
		 									<h4 class="card-title"><%=len %> </h4>
									<!-- 한 묷음의 설명 -->
	 								<p class="card-text"><%=p.getProductPrice() %></p>
		 						</div>
	 						</a>
						</div>
					</div>
				<%
				}
		%>
		</div>
		
		<br>
		
		<!-- 공지 -->
		<div class="row">
			<div class="col-sm-3 text-center">
				<h4>공지사항</h4>
			</div>
			<div class="col-sm-9">
				<ul>
				<%
					// 공지 리스트를 목록표로 출력
					for(Notice n : noticeList){
					%>
						<li>
							<a href="<%=request.getContextPath() %>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId() %>" class="text-dark"><%=n.getNoticeTitle() %></a>
						</li>
					<%
					}
				%>
				</ul>
			</div>
		</div>
		
	</div>
</body>
</html>





















<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prodcutList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%
	// 로그인 되어있을 때만 접근 가능
	if(session.getAttribute("sessionToLogin") == null){
		response.sendRedirect(request.getContextPath() + "/login/login.jsp");
		return;
	}
	Object ob = session.getAttribute("sessionToLogin");
	String memberEmail = "";
	if(ob != null){
		memberEmail = (String)ob;
	}

	// 인코딩 형식
	request.setCharacterEncoding("UTF-8");
	
	// 상품 주문내역 출력할때 필요하기 때문에 항상 데려다녀야함
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	
	//System.out.println(memberEmail + "<---memeberEmail");
	//System.out.println(categoryId + "<---categoryId");
	
	Category paramCategory = new Category();
	paramCategory.setCategoryId(categoryId);
	
	CategoryDao categoryDao = new CategoryDao();
	Category category = categoryDao.selectCategoryName(paramCategory);
	
	ProductDao productDao = new ProductDao();
	
	// 페이징을 위한 보이는 페이지와 마지막 페이지를 선언
	int currentPage = 0;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	Product paramProduct = new Product();
	paramProduct.setCategoryId(categoryId);
	int lastPage = productDao.selectProductNameCount(paramProduct);
	if(lastPage % 9 != 0){
		lastPage = lastPage / 9 + 1;
	}
	else{
		lastPage = lastPage / 9;
	}
	// 페이지의 한계값이 나오면 돌아가도록 설정
	if(currentPage == -1){
		currentPage = 0;
	}
	if(currentPage == lastPage){
		currentPage = lastPage-1;
	}
	
	//System.out.println(lastPage + "<--lastPage");
	//System.out.println(currentPage + "<--currentPage");
	
	paramProduct.setCurrentPage(currentPage);
	
	ArrayList<Product> list = new ArrayList<Product>();
	list = productDao.selectProductNamePaging(paramProduct);
%>
	<div class="container">
		<!-- 메뉴바 -->
		<div class="row">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<jsp:include page="/inc/menu2.jsp"></jsp:include>
		
		<br>
		<!-- 소제목 -->
		<div>
			<h3><i class="fa fa-glide-g" style="font-size:36px"></i> 카테고리 상품 전체 보기(<%=category.getCategoryName() %>)</h3>
		</div>
		
		<!-- 본문 -->
		<div class="row">
		<%
			for(Product p : list){
				%>
					<div class="col-sm-4 text-center">
						<div class="card" style="width:350px;">
							<!-- product의 사진을 default 사진으로 지정// 나는 1.jpg -->
	 						<img class="card-img-top" src="/moll_admin/image/<%=p.getProductPic() %>" alt="Card image" style="height:300px;">
	 						<a href="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=p.getProductId() %>&memberEmail=<%=memberEmail %>" class="btn btn-outline-secondary">
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
		<!-- 밑에 페이지바 순서대로 처음,뒤로,페이지 번호(페이지 수에 맞게), 다음, 마지막으로 -->
		<!-- 각각 변수로는 productId, memberEmail, currentPage를 보낸다 -->
		<ul class="pagination pagination-lg justify-content-center">
			<li class="page-item"><a class="page-link text-dark" href="<%=request.getContextPath() %>/product/productList.jsp?currentPage=<%=0 %>&categoryId=<%=categoryId %>&memberEmail=<%=memberEmail %>">first</a></li>
			<li class="page-item"><a class="page-link text-dark" href="<%=request.getContextPath() %>/product/productList.jsp?currentPage=<%=currentPage-1 %>&categoryId=<%=categoryId %>&memberEmail=<%=memberEmail %>">Previous</a></li>
			<%
				for(int i=0; i<lastPage; i++){
				%>
					<li class="page-item"><a class="page-link text-dark" href="<%=request.getContextPath() %>/product/productList.jsp?currentPage=<%=i %>&categoryId=<%=categoryId %>&memberEmail=<%=memberEmail %>"><%=i+1 %></a></li>
				<%
				}
			%>
			<li class="page-item"><a class="page-link text-dark" href="<%=request.getContextPath() %>/product/productList.jsp?currentPage=<%=currentPage+1 %>&categoryId=<%=categoryId %>&memberEmail=<%=memberEmail %>">Next</a></li>
			<li class="page-item"><a class="page-link text-dark" href="<%=request.getContextPath() %>/product/productList.jsp?currentPage=<%=lastPage-1 %>&categoryId=<%=categoryId %>&memberEmail=<%=memberEmail %>">last</a></li>
		</ul>
	</div>
</body>
</html>




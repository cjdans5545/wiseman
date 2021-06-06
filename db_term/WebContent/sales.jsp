<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import = "java.sql.*,javax.naming.*,javax.sql.*,db.term.*,java.util.*" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Sales</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />

	</head>
	<body class="is-preload">
	

	<%
		//현재 페이지 넘버
  		String tempage = request.getParameter("page");
  		//System.out.println("page parameter"+tempage);
   		int currentPage = 0;
  		if(tempage == null || tempage.length()==0){
  			currentPage=1;
  		}
  	
  		try{
  			currentPage = Integer.parseInt(tempage);
  		}catch(NumberFormatException e){
  			currentPage = 1;
  		}
	%>
		<div id="content">
				<header>
					<h2>판매 목록</h2>
					<p>OT전자 등록된 모든 고객 확인 				
					<section class="box search" style="width:50%;">
							<form method="post" action="#">
								<input type="text" class="text" name="search" placeholder="Search" />
							</form>
						</section>
						</p>
				</header>
					<div class="inner">
					
					<!-- Post -->
						<article class="box post post-excerpt">
							<div id=data-container>				
							<table>
							<tr> <th>NO <th> 고객명 <th> 배송상태 <th> 판매자명 <th> 주문일</tr>
							
							<% 						  
								Class.forName("oracle.jdbc.OracleDriver");
								Connection conn = DriverManager.getConnection(
										"jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe","DB201512121","201512121"); 
														                		
								int Startcol = (currentPage-1)*15;						
								String sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY order_id) NUM, A.* FROM (SELECT * from orders) A ORDER BY order_id) WHERE NUM BETWEEN "+ Startcol+" AND "+(Startcol+15);
								PreparedStatement stmt = conn.prepareStatement(sql);
								ResultSet rs = stmt.executeQuery();
												
								while(rs.next()){
									int num = rs.getInt("num");		
									int order_id = rs.getInt("order_id");
									int customer_id = rs.getInt("customer_id");			
									String status = rs.getString("status");
									int salesman_id = rs.getInt("salesman_id");
									String order_date = rs.getString("order_date");
									%>
								<tr> 
								 <td>  <%=num %>   </td>
								 <td> <%=order_id %>  </td>
								 <td> <%=customer_id %>  </td>
								 <td> <%=status %>  </td>
								 <td> <%=salesman_id %>  </td>
								 <td> <%=order_date %>  </td>
								</tr>	
								<%	}%>
	
							</table>
     				</div>	
			</article>

					<!-- Pagination -->
						<div class="pagination">
							<%
							String total_ = "select count(*) from orders";
							
							stmt = conn.prepareStatement(total_);
							rs = stmt.executeQuery();
							int totalcount = 0;
							while(rs.next()){
								totalcount = rs.getInt(1);				
							}
							int totalpage = totalcount/15;
							//System.out.println("product join invertories TOTAL PAGE = "+totalpage);
							int dec = (currentPage/10) * 10;
							//System.out.println("dec "+dec);
							if(dec-9 > 0){
							%>
								<a href="sales.jsp?page=<%=dec-1%>" class="button next">이전</a>
							
							<%} %>
							<div class="pages">
							<%
							for(int i=dec+1;i<=dec+9;i++){
								if(i <= totalpage){
									if(currentPage%10==i){
										%><a href="sales.jsp?page=<%=i%>" class="active"><%=i%></a><%
									}else{
										%><a href="sales.jsp?page=<%=i%>"> <%=i%></a><% 
									}
								}else
									break;
							}
							dec+=10;
							//System.out.println("after dec "+dec);
							%>
							</div>
							<% if(totalpage>dec){ %>
							<a href="sales.jsp?page=<%=dec %>" class="button next">다음</a>
							<% } %>
						</div>
				</div>
			</div>
		
		<!-- Sidebar -->
			<div id="sidebar">

				<!-- Logo -->
					<h1 id="logo"><a href="index.jsp">OT</a></h1>
				<!-- Text -->
					<section class="box text-style1">
						<div class="inner">
							<p>
								<strong>[알림]</strong><br>
								OT전자 직원 시스템에 오신것을 환영합니다
							</p>
						</div>
					</section>
				<!-- Nav -->
					<nav id="nav">
						<ul>
							<li ><a href="index.jsp">Home</a></li>
							<li class="current"><a href="#">Sales</a></li>
							<li><a href="products.jsp?page=1&searchword= ">Product</a></li>
							<li><a href="customer.jsp?page=1&searchword= ">Customer</a></li>
							<li><a href="#">Contact</a></li>
						</ul>
					</nav>

				<!-- Copyright -->
					<ul id="copyright">
						<li>&copy; Copyright Banzo</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
					</ul>

			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>
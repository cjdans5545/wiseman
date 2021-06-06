<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import = "java.sql.*,javax.naming.*,javax.sql.*,db.term.*,java.util.*" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Customer</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
	
	</head>
	<body class="is-preload">
  <%  
  	String tempage = request.getParameter("page");
  
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
		<!-- Content -->
			<div id="content">
				<header>
					<h2>고객 목록</h2>
					<p>				
					<section class="box search">
							<form method="post" action="#">
								<input type="text" class="text" name="search" placeholder="고객의 성명을 입력하세요" />
							</form>
						</section>
						</p>
				</header>
					<div class="inner">
					
					<!-- Post -->
						<article class="box post post-excerpt">
							<div id=data-container>				
							<table>
							<tr> <th>NO <th> 성  명 <th> 웹 주소 <th> 거래횟수 </tr>
							
							<% 						  
								Class.forName("oracle.jdbc.OracleDriver");
								Connection conn = DriverManager.getConnection(
										"jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe","DB201512121","201512121"); 
														                		
								int Startcol = (currentPage-1)*15;						
								String sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY customer_id) NUM, A.* FROM (SELECT * from  customers left outer join (select customer_id,count(order_id) from orders group by customer_id) using(customer_id)) A ORDER BY customer_id) WHERE NUM BETWEEN "+ Startcol+" AND "+(Startcol+15);						
								PreparedStatement stmt = conn.prepareStatement(sql);
								ResultSet rs = stmt.executeQuery();
												
								while(rs.next()){
									//Product item = new Product();
									int num = rs.getInt("num");											
									int customer_id = rs.getInt("customer_id");												
									String name = rs.getString("name");
									String website = rs.getString("website");
									int count = rs.getInt("count(order_id)");		
												
									%>
								<tr> 
								 <td>  <%=num %>   </td>
								 <td><a href="item-customer.jsp?customer_id=<%=customer_id%>"  onclick="window.open(this.href, '_blank', 'width=600px,height=700px,toolbars=no,scrollbars=no'); return false;"> <%=name%></a></td>
								 <td><a href="<%=website %>"><%=website %></a></td>
								 <td> <%=count %> </td>
								</tr>	
								<%	}%>
	
							</table>
     				</div>	
			</article>

					<!-- Pagination -->
						<div class="pagination">
							<%
							String total_ = "select count(*) from customers";
							
							stmt = conn.prepareStatement(total_);
							rs = stmt.executeQuery();
							int totalcount = 0;
							while(rs.next()){
								totalcount = rs.getInt(1);				
							}
							int totalpage = totalcount/15;
							if(totalcount%15 !=0){
								totalpage+=1;
							}
							
							//페이지를 10단위로 계산하기 위한 변수
							int dec = (currentPage/10) * 10;
						
							if(dec-9 > 0){
							%>
								<a href="customer.jsp?page=<%=dec-1%>" class="button next">이전</a>
							
							<%} %>
							<div class="pages">
							<%
							for(int i=dec+1;i<=dec+9;i++){
								if(i <= totalpage){
									if(currentPage%10==i){
										//현재페이지는 활성화
										%><a href="#" class="active"><%=i%></a><%
									}else{
										%><a href="customer.jsp?page=<%=i%>"> <%=i%></a><% 
									}
								}else
									break;
							}
							dec+=10;
							
							%>
							</div>
								<% if(totalpage>dec){ %>
							<a href="customer.jsp?page=<%=dec %>" class="button next">다음</a>
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
							<li><a href="sales.jsp">Sales</a></li>
							<li ><a href="products.jsp?page=1&searchword= ">Product</a></li>
							<li class="current"><a href="#">Customer</a></li>
							<li><a href="contact.html">Contact</a></li>
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
	<%
	rs.close();
	stmt.close();
	conn.close();
	%>
	</body>

</html>
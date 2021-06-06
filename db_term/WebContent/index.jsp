<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*,javax.naming.*,javax.sql.*,db.term.*,java.util.*" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>OT 직원 판매 시스템</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>
	<body class="is-preload">
		<% 						  
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection(
		"jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe","DB201512121","201512121"); %>
		
		<!-- Content -->
			<div id="content">
			
				<div class="inner">
				<a class="image featured"><img src="images/main_img1.png" alt="" /></a>

						<article class="box info">
							<header>
								<h2><a href="#">연도별 회사 매출액</a></h2>
								<p>회사의 매출액 합계</p>
							</header>
							<div id=data-container>			
								<% 		
									String condition_date = "'17/01/01'";
									String amount_sql = "select product_id, sum(order_items.quantity*order_items.unit_price) from order_items natural join orders natural join products where TO_CHAR( orders.order_date, 'YY/MM/DD') > ? group by product_id";						
									PreparedStatement stmt = conn.prepareStatement(amount_sql);
									stmt.setString(1,condition_date);
									ResultSet rs = stmt.executeQuery();
									%>
									<table>
									<tr> <th> 연도 <th> 매출액 </tr>
									<%
									double sum = 0;
									while(rs.next()){
										int product_id = rs.getInt("product_id");								
										sum += rs.getFloat("sum(order_items.quantity*order_items.unit_price)");
										%>
									<%	}%>
									<tr> <td>20<%=condition_date.substring(1,3) %></td> <td> <%=sum%></td> </tr>
									</table>
     				</div>	
						</article>
						<article class="box info">
							<header>
								<h2><a href="customer.jsp?page=1&searchword= ">최근 거래한 고객 정보</a></h2>
								<p>직원 이름으로 기록된 거래내역 목록</p>
							</header>
							<div id=data-container>				
							<table>
							<tr> <th> 성  명 <th> 거래일자 <th> 거래상태 <th style="text-align:center"> 상세보기</tr>
							<% 						  
								String sql = "select * from customers natural join orders where salesman_id = ? order by order_date desc";
								stmt.clearParameters();
								stmt = conn.prepareStatement(sql);
								stmt.setInt(1,56);
								rs = stmt.executeQuery();
								int count = 0;			
								while(rs.next()){
									if(count > 5)
										break;
									count++;									
									int customer_id = rs.getInt("customer_id");	
									int order_id = rs.getInt("order_id");		
									String name = rs.getString("name");
									String order_date = rs.getString("order_date");
									String order_status = rs.getString("status");		
									%>
								<tr> 
								 <td><a href="item-customer.jsp?customer_id=<%=customer_id%>"  onclick="window.open(this.href, '_blank', 'width=600px,height=700px,toolbars=no,scrollbars=no'); return false;"> <%=name%></a></td>
								 <td> <%=order_date.substring(0,11) %>  </td>
								 <td> <%=order_status %> </td>
								 <td style="text-align:center"> <a href="item-order.jsp?order_id=<%=order_id %>" onclick="window.open(this.href, '_blank', 'width=600px,height=600px,toolbars=no,scrollbars=no'); return false;">※</a></strong></td>
								</tr>	
								<%	}%>
	
							</table>
     				</div>	
			</article>
				</div>
			</div>

		<!-- Sidebar -->
			<div id="sidebar">

				<!-- Logo -->
					<h1 id="logo"><a href="#">OT</a></h1>
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
							<li class="current"><a href="#">Home</a></li>
							<li><a href="sales.jsp">Sales</a></li>
							<li><a href="products.jsp?page=1&searchword= ">Product</a></li>
							<li><a href="customer.jsp?page=1&searchword= ">Customer</a></li>
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
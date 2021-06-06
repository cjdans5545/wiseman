<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
      <%@ page import = "java.sql.*,javax.naming.*,javax.sql.*,db.term.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
<title>거래내역 상세</title>
</head>
<body class="is-preload" style="padding:10px">
 <%  
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection(
			"jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe","DB201512121","201512121"); 
	
  	String order_id = request.getParameter("order_id");
  	int oi = 0;
  	try{
  		oi = Integer.parseInt(order_id);
  	}catch(NumberFormatException e){}

 	String sql = "select * from order_items left outer join products on order_items.product_id = products.product_id natural join orders where order_id = ?";
 	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,oi);
	ResultSet rs = stmt.executeQuery();
	%>
	<div id="content">
		<header>
			<h2>거래내역 상세</h2>		
		</header>
		<table>
			<tr> <th>제품명<th> 단가 <th> 수량 <th> 금액</tr>
			<%
			float total_price = 0;
			while(rs.next()){

				String product_name = rs.getString("product_name");
				int quantity = rs.getInt("quantity");
				//float standard_cost = rs.getInt("standard_cost");
				float unit_price = rs.getFloat("unit_price");
				float item_price = quantity*unit_price ;
				total_price+=item_price;
				%>
				<tr><td><%=product_name%></td><td>$<%=unit_price%></td><td><%=quantity%></td><td>$<%=item_price %></td></tr>
			<% } %>
			<tr><th colspan = "3" style="text-align:center">총  액 </th><td>$<%=total_price%></td></tr>
		</table>
	</div>
	
	
		<!-- Scripts -->
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
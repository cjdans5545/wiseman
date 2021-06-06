<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
      <%@ page import = "java.sql.*,javax.naming.*,javax.sql.*,db.term.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
<title>제품 상세보기</title>
</head>
<body class="is-preload" style="padding:10px">
 <%  
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection(
			"jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe","DB201512121","201512121"); 
	
  	String product_id = request.getParameter("product_id");
  	int pi = 0;
  	try{
  		pi = Integer.parseInt(product_id);
  	}catch(NumberFormatException e){}
  	
 	String sql = "select * from products natural join product_categories where product_id = ?";
 	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,pi);
	ResultSet rs = stmt.executeQuery();
	%>
	<div id="content">
		<header>
			<h2>제품 상세</h2>		
		</header>
		<%
		while(rs.next()){
			
			String product_name = rs.getString("product_name");
			float standard_cost = rs.getInt("standard_cost");													
			float list_price = rs.getInt("list_price");																								
			String description = rs.getString("description");
			String category_name = rs.getString("category_name");	
			%>
			
			<table>
			<tr> <th colspan = "2" >제품 명  <th colspan = "2"> 종류 </tr>
			<tr> <td colspan = "2"><%=product_name%></td> <td colspan = "2"><%=category_name%></td></tr>
			
			<tr><th colspan = "4"> 제품 정보 </tr>
			<tr><td colspan = "4"><%=description%></td></tr>
			
			<tr><th colspan = "2"> 단가 <th colspan = "2"> 정가 </tr>
			<tr> <td colspan = "2">$<%=standard_cost%></td> <td colspan = "2">$<%=list_price%></td></tr>
			</table>
			<%
		}
	  	
	%>
	
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
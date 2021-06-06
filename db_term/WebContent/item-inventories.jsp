<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
      <%@ page import = "java.sql.*,javax.naming.*,javax.sql.*,db.term.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
<title>재고 확인</title>
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
  
 	String sql = "select * from inventories natural join (select * from warehouses natural join locations) where product_id = ?";
 	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,pi);
	ResultSet rs = stmt.executeQuery();
	%>
	<div id="content">
		<header>
			<h2>재고</h2>		
		</header>
		<%

		while(rs.next()){
			String warehouse_name = rs.getString("warehouse_name");													
			int quantity = rs.getInt("quantity");
			String address = rs.getString("address");
			String postal_code = rs.getString("postal_code");
			String city = rs.getString("city");
			String state = rs.getString("state");	
			%>
			<hr width="100%"/>
			<table>
			<tr> <th colspan = "2" >창고명  <td colspan = "2"><%=warehouse_name%></td> </tr>
			<tr><th colspan = "2" > 수량 <td colspan = "2"><%=quantity%></td> </tr>
			<tr><th colspan = "4" style="text-align: center;"> 주소 </tr>
			<tr><td colspan = "4">
			<%=postal_code%> <%=state%> <%=city%> <br> <%=address%>
			</td>
			</tr>
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
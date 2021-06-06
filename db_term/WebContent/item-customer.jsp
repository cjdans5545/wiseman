<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
      <%@ page import = "java.sql.*,javax.naming.*,javax.sql.*,db.term.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
<title>고객정보 확인</title>
</head>
<body class="is-preload" style="padding:10px">
 <%  
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection(
			"jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe","DB201512121","201512121"); 
	
  	String customer_id = request.getParameter("customer_id");
  	int ci = 0;
  	try{
  		ci = Integer.parseInt(customer_id);
  	}catch(NumberFormatException e){}
  	
 	String sql = "select * from customers natural join contacts where customer_id = ?";
 	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,ci);
	ResultSet rs = stmt.executeQuery();
	%>
	<div id="content">
		<header>
			<h2>고객 정보</h2>		
		</header>
		<%
		while(rs.next()){
			//customer
			String name = rs.getString("name");
			String address = rs.getString("address");
			String website = rs.getString("website");
			int credit_limit = rs.getInt("credit_limit");
			
			//contact
			String first_name = rs.getString("first_name");
			String last_name = rs.getString("last_name");
			String email = rs.getString("email");
			String phone = rs.getString("phone");
			%>
			<table>
			<tr> <th>성 명 <td colspan = "3"><%=name%></td></tr>
			<tr> <th>웹사이트 <td colspan = "3"><%=website%></td></tr>
			<tr> <th>신용한도 <td colspan = "3"><%=credit_limit%></td></tr>
			<tr><th> 주소 <td colspan = "3"> <%=address%></td> </tr>
		
			<tr><th rowspan="3" style="item-align: center;"> 담당자 <th>성 명 <td><%=first_name%>&nbsp;<%=last_name%> </td> </tr>
			<tr><th>Email<td><%=email%><td/></tr>
			<tr><th>phone<td><%=phone%><td/></tr>
			</table>
			<%
		}
		
		String order_sql = "select * from orders where customer_id = ? order by order_date";
	 	
		stmt.clearParameters();
		stmt =conn.prepareStatement(order_sql);
		stmt.setString(1,customer_id);
		rs = stmt.executeQuery();
		
		%>
		<hr width="100%"/>
		
			<header>
				<h2>거래 내역</h2>
				<p>No 뒤에 숫자 클릭하면 거래내역 상세보기를 하실 수 있습니다.</p>		
			</header>
			<%
			int num = 1;
			while(rs.next()){
				int order_id = rs.getInt("order_id");	
				String order_date = rs.getString("order_date");
				String order_status = rs.getString("status");	
				%>
				<strong>NO.<a href="item-order.jsp?order_id=<%=order_id %>" onclick="window.open(this.href, '_blank', 'width=600px,height=600px,toolbars=no,scrollbars=no'); return false;"><%=num++ %></a></strong>
				<table>
				<tr> <th>거래일자 <th>거래상태</tr>
				<tr> 
				<td> <%=order_date.substring(0,11) %>  </td>
				<td> <%=order_status %> </td>
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
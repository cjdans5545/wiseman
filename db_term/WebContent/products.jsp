<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import = "java.sql.*,javax.naming.*,javax.sql.*,db.term.*,java.util.*" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Products</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />

	</head>
	<body class="is-preload">
  <%  
  	//현재 페이지 넘버
  	String tempage = request.getParameter("page");
   	int currentPage = 0;
  	try{
  		currentPage = Integer.parseInt(tempage);
  	}catch(NumberFormatException e){
  		currentPage = 1;
  	}
  	

	String tempsearch = request.getParameter("searchword");
	if(tempsearch == null || tempsearch.equals("null")){
		tempsearch = "";
	}
	
	String tempcategory_id = request.getParameter("category_id");
	int ci = 0;
	try{
	 ci = Integer.parseInt(tempcategory_id);
	}catch(NumberFormatException e){
		ci = 0;
	}
  	
  	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection(
			"jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe","DB201512121","201512121"); 
  	%>											
		<!-- Content -->
			<div id="content">
				<header>
					<h2>제품 목록</h2>
					<p>OT전자 등록된 모든 제품 확인 				
					<section class="box search" >
							<form method="post" action="products.jsp?page=<%=1%>&searchword=${searchword}">
								<input type="text" class="text" name="searchword" placeholder="검색할 단어를 입력하세요" />
							</form>
						</section>
						</p>
						
				</header>
					<div class="inner">
						<div class="info">
							<h2>제품 카테고리</h2><br>
							<%
							if(ci==0){
								%>
								<strong>전체</strong>
								<%
							}else{
								%>
								<strong><a href="products.jsp?page=1&category_id=0">전체</a></strong>
								<%
							}
							
							
							String category_sql = "select * from product_categories";
		
							PreparedStatement stmt = conn.prepareStatement(category_sql);
							ResultSet rs = stmt.executeQuery();
							while(rs.next()){
								int cate_id = rs.getInt("category_id");
								String category_name = rs.getString("category_name");
								if(ci==cate_id){
								%>
								<strong>&nbsp;/&nbsp;<%=category_name%></strong>
								<%
								}else{
								%>
								<strong>&nbsp;/&nbsp;<a href="products.jsp?page=1&category_id=<%=cate_id%>"><%=category_name%></a></strong>
								<%
								}
							}
							%>
						</div>
						
						
						<br>
						<article class="box post post-excerpt">
							<div id=data-container>				
							<table>
							<tr> <th>NO <th> 제품명 <th> 제품정보 <th> 단가 <th> 재고수량</tr>
							
							<% 						  						                		
								int Startcol = (currentPage-1)*15;	
								
								String sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY product_id) NUM, A.* FROM (SELECT * from  products natural join  (select product_id,  sum(quantity) from inventories group by product_id)";	
								
								if((tempsearch != null && tempsearch.length() > 0) || ci != 0){
									
									sql +=" where ";
									boolean ismuli = false;
									if(tempsearch != null && tempsearch.length() > 0){
										sql+="product_name like ?";
										ismuli = true;
										//System.out.println(sql);
									}
									
									if(ci != 0){
										if(ismuli){
											sql+=" AND ";
										}
										sql+="category_id = ?";
										//System.out.println(sql);
									}

								}
								sql+=") A ORDER BY product_id) WHERE NUM BETWEEN "+ Startcol+" AND "+(Startcol+15);
								//System.out.println(sql);
							
								stmt.clearParameters();
								stmt = conn.prepareStatement(sql);

								if((tempsearch != null && tempsearch.length() > 0)|| ci != 0){

									boolean ismuli = false;
									if(tempsearch != null && tempsearch.length() > 0){
										String searchword = "'%"+tempsearch+"%'";
										stmt.setString(1,searchword);
										ismuli = true;
									}
									
									if(ci != 0){
										if(ismuli){
											stmt.setInt(2,ci);
										}else{
											stmt.setInt(1,ci);
										}
									
									}
								}
								rs = stmt.executeQuery();
												
								while(rs.next()){

									int num = rs.getInt("num");											
									int category_id = rs.getInt("category_id");										
									int product_id = rs.getInt("product_id");			
									String product_name = rs.getString("product_name");
									int standard_cost = rs.getInt("standard_cost");													
									//int list_price = rs.getInt("list_price");														
									int quantity = rs.getInt("sum(quantity)");													
									String description = rs.getString("description");										
									%>
								<tr> 
								 <td>  <%=num %>   </td>
								 <td> <a href="item-product.jsp?product_id=<%=product_id %>" onclick="window.open(this.href, '_blank', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;"><%=product_name %></a>  </td>
								 <td> <%=description %>  </td>
								 <td> $<%=standard_cost %>  </td>
								 <td> <a href="item-inventories.jsp?product_id=<%=product_id %>" onclick="window.open(this.href, '_blank', 'width=500px,height=600px,toolbars=no,scrollbars=no'); return false;"><%=quantity %></a>  </td>
								</tr>	
								<%	}%>
	
							</table>
     				</div>	
			</article>

					<!-- Pagination -->
						<div class="pagination">
							<%
							String total_ = "select count(*) from products natural join (select count(*),product_id from inventories group by product_id)";
							
							if((tempsearch != null && tempsearch.length() > 0) || ci != 0){
								
								total_ +=" where ";
								boolean ismuli = false;
								if(tempsearch != null && tempsearch.length() > 0){
									total_+="product_name like ?";
									ismuli = true;
								}
								
								if(ci != 0){
									if(ismuli){
										sql+=" AND ";
									}
									total_+="category_id = ?";
								}
									
							}

							stmt.clearParameters();
							stmt = conn.prepareStatement(total_);
							
							if((tempsearch != null && tempsearch.length() > 0)|| ci != 0){

								boolean ismuli = false;
								if(tempsearch != null && tempsearch.length() > 0){
									String searchword = "'%"+tempsearch+"%'";
									stmt.setString(1,searchword);
									ismuli = true;
								}
								
								if(ci != 0){
									if(ismuli){
										stmt.setInt(2,ci);
									}else{
										stmt.setInt(1,ci);
									}
								}
							}
							
							rs = stmt.executeQuery();
							int totalcount = 0;
							while(rs.next()){
								totalcount = rs.getInt(1);
								System.out.println("total count = "+totalcount);
							}
							int totalpage = totalcount/15;
							if(totalcount%15 !=0){
								totalpage+=1;
							}
							int dec = (currentPage/10) * 10;
					
							if(dec-9 > 0){
							%>
								<a href="products.jsp?page=<%=dec-1%>&searchword=<%=tempsearch%>&category_id=<%=ci%>" class="button next">이전</a>
							
							<%} %>
							<div class="pages">
							<%
							for(int i=dec+1;i<=dec+9;i++){
								if(i <= totalpage){
									if(currentPage%10==i){
										%><a href="#" class="active"><%=i%></a><%
									}else{
										%><a href="products.jsp?page=<%=i%>&searchword=<%=tempsearch%>&category_id=<%=ci%>"> <%=i%></a><% 
									}
								}else
									break;
							}
							dec+=10;

							%>
							</div>
							<% if(totalpage>dec){ %>
							<a href="products.jsp?page=<%=dec %>&searchword=<%=tempsearch%>&category_id=<%=ci%>" class="button next">다음</a>
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
							<li class="current"><a href="#">Product</a></li>
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
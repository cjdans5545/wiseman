<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import = "java.sql.*" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>OT 직원 판매 시스템</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="is-preload">
	<div style="width:380px; left:0; right:0; margin-top:100px; margin-left:auto; margin-right:auto;">
		<h2 style="text-align: center;"><strong>OT 전자 직원 시스템</strong> </h2><br>
		<section class="box post" style="padding: 20px;">
			
				<form method="post" action="j_security_check">
					<input type="text" class="text" name="j_username" placeholder="id" />
					<input type="text" class="text" name="j_password" placeholder="password" />
				</form>
				<br>
				<input width="100%" value="Login"type="submit"/>
		</section>
	</div>
	
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>
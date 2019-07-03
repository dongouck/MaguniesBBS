<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>About Magunie's BBS Host</title>
</head>
<body>
	<%
		String userID=null;
		if(session.getAttribute("userID") !=null){
			userID=(String)session.getAttribute("userID");
		}
	
	%>

	<nav class="navBar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-nav-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Magunie's Bulletin Board</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-nav-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">Main</a></li>
				<li><a href="bbs.jsp">Board</a></li>
			</ul>
			<%
				if(userID==null){
			%>
				<!-- <ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggele"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">Tab<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">Log In</a></li>
							<li><a href="join.jsp">Join</a></li>
						</ul>
					</li>
				</ul> -->
				<ul class="nav navbar-nav navbar-right">
					<li><a href="login.jsp">Log In</a></li>
					<li><a href="join.jsp">Join</a></li>
				</ul>
			<%		
				}else{
			%>
				<ul class="nav navbar-nav navbar-right">
				<li>
					<ul class="navbar-brand">ID: <%=session.getAttribute("userID")%></ul>
					<li><a href="logoutAction.jsp">Log Out</a></li>
				</li>
				<!-- <li class="dropdown">
					<a href="#" class="dropdown-toggele"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Tab<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">Log Out</a></li>
					</ul>
				</li> -->
			</ul>
			
			<% 		
				}
			%>
			
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron" style="height:600px; margin-top:25px;">
			<h1>Magunie's BBS</h1>
			<p><img src="img/host01.gif"></p>
			<p style="font-size:medium;">에러 문의는 깨톡 또는 이메일</br>
			여러분의 쓴 소리가 약이 됩니다.</br>
			dongouck2000@naver.com</br>
			</p>
			</br>
			</br>
			</br>
			<a class="btn btn-default" href="main.jsp" role="button">Back</a>
		</div>
	</div>
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>
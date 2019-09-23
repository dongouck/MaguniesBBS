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
<title>Magunie's Bulletin Board</title>
</head>
<style>
/* img.absolute { 
        position: absolute;
        left: 800px;
        top: 160px;
      } */

</style>
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
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Magunie's Bulletin Board</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
				} else {
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
	<div class="container" style="margin-top: 25px">
		<div class="jumbotron" style="height:600px;">
			<h1>Magunie's BBS</h1>
			<p>(Bootstrap ver. 3.3.7)</p>
			<p>2019-9-16 Update Note</br>
						<p style="font-size:small;">＊호스팅 연장 및 디자인 소스 변경
						</p></p>
			<img class="absolute" width="210" src="img/main7.png" >
			<div style="margin-top:20px">
				<a class="btn btn-primary btn-pull" href="bbs.jsp" role="button">Enter</a>
				<a class="btn btn-default" href="aboutHost.jsp" role="button">About Host</a>
			</div>
			
		</div>
	</div>
	<div class="container">
		<div class="row">
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>
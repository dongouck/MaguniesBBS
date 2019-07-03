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
<body>
	<%
		String userID= null;
		if(session.getAttribute("userID")!=null){
			userID=(String) session.getAttribute("userID");
		}
		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
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
		<div class="collapse navbar-collapse" id="bs-example-nav-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">Main</a></li>
				<li class="active"><a href="bbs.jsp">Board</a></li>
			</ul>
			<%
				if(userID==null){
			%>
				<ul class="nav navbar-nav navbar-right">
					<li>
						
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggele"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">Tab<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">Log In</a></li>
							<li><a href="join.jsp">Join</a></li>
						</ul>
					</li>
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
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style="margin-top:25px; text-align: center; border:1px solid #ddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeee; text-align: center;" >Wassssup?</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="Title" name="bbsTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="Content" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="submit">
		</form>
		<div>
		
		</div>
		<div align="center" style="margin-top: 70px">
			<img height="110px" src="img/write01.jpg">
		</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>
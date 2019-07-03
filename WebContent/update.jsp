<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 Website</title>
</head>
<body>
	<%
		String userID=null;
		if(session.getAttribute("userID") !=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID =	Integer.parseInt(request.getParameter("bbsID"));
			
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글 내용을 입력하세요.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs= new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
			
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
				<li><a href="main.jsp">Main</a></li>
				<li><a href="bbs.jsp">Board</a></li>
			</ul>
			<!-- <ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggele"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Tab<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">Log In</a></li>
						<li><a href="join.jsp">Join</a></li>
					</ul>
				</li>
			</ul> -->
			<ul class="nav navbar-nav navbar-right">
				<li><a href="logoutAction.jsp">Log Out</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
			<table class="table table-striped" style="text-align: center; border:1px solid #ddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeee; text-align: center;" >수정하기 전에 생각했나요~?</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbs.getBbsContent() %></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="수정 완료">
		</form>
	</div>	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>
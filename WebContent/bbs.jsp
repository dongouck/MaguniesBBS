<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Magunie's Bulletin Board</title>
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration:none;
	}
</style>
</head>
<body>
	<%
		String userID=null;
		if(session.getAttribute("userID") !=null){
			userID=(String)session.getAttribute("userID");
		}
		int pageNumber=1;
		if(request.getParameter("pageNumber")!=null){
			pageNumber =Integer.parseInt(request.getParameter("pageNumber"));
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
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Magunie's Bulletin Board</a>
		<%
		if(userID!=null){
		%>
			<div class="navbar-toggle collapsed">
				ID: <%=session.getAttribute("userID")%>
			</div>
		<% 
		}
		%>
		</div>
		
		<div class="collapse navbar-collapse" id="bs-example-nav-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">Main</a></li>
				<li class="active"><a href="bbs.jsp">Board</a></li>
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
		<table class="table table-striped" style="margin-top:25px; text-align: center; border:1px solid #ddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeee; text-align: center;" >No</th>
					<th style="background-color: #eeeee; text-align: center;" >Topic</th>
					<th style="background-color: #eeeee; text-align: center;" >Author</th>
					<th style="background-color: #eeeee; text-align: center;" >Date</th>
				</tr>
			</thead>
			<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list=bbsDAO.getList(pageNumber);
					for(int i=0; i < list.size();i++){
							//System.out.println(list.get(i));
				%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll("\n", "<br>") %> <span style="color:#58D3F7;">[ <%= list.get(i).getReplyCount()%> ]</span></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(11,13)+":"+list.get(i).getBbsDate().substring(14,16)+" "+list.get(i).getBbsDate().substring(8,10)+"-"+list.get(i).getBbsDate().substring(5,7)+"-"+list.get(i).getBbsDate().substring(2,4) %></td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
		
		<%	
			if(pageNumber != 1){
		%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">Prev</a>
		<% 
			} 
			if(bbsDAO.nextPage(pageNumber + 1)) {
		%>		
			<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">Next</a>
		<% 
			}
			//페이지 목록 인덱스 구현**
			//int pageNo=Integer.parseInt(request.getParameter("pageNumber"));
			/* while(pageNumber=next()){
				
			} */
		%>
		
		<a href="write.jsp" class="btn btn-primary pull-right">Write</a>
		<div style="margin-top:15px;"align="center">
			<a href="" onclick="alert('5252 들어온김에 글이나 쓰라구')">
				<img src="img/bbs09.gif" width="480" >
			</a>
		</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
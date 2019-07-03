<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.Bbsr" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Magunie's Bulletin Board</title>
<script>

	//댓글 수정 기능 추후 완성
	 function modifyReplyFn(modifyButtonTag){
		//var a=$("#reply_"+i).attr();
		//console.log(replyBarTag);
		console.log(modifyButtonTag);
		//console.log($modifyButtonTag.parents("tr").attr("value"));
		
		if($(modifyButtonTag).parent().val()=="수정"){
			//console.log(modifyButtonTag);
			$(modifyButtonTag).parent("tr").val(1);
			
			var replyTag=$(modifyButtonTag).attr("id");
			var replyID="reply_"+replyTag.substring(12);
			var replyVal=$("#"+replyID).children().text();
			$("#"+replyID).children().remove();
			
			$("#"+replyID).append(
					"<form method='post' action='BbsDAO.rewriteReply'><input type='textbox' value="
					+replyVal+"><button type='submit' class ='btn btn-primary'>수정</button></form>");
			//deleteAction.jsp?bbsID=<  = bbsID %>
			console.log($(modifyButtonTag).parent("tr").value);
		}else{
			alert("else");
		}
	} 

</script>
</head>

<body>
	
	<%
		String userID=null;
		if(session.getAttribute("userID") !=null){
			userID=(String)session.getAttribute("userID");
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
		<table class="table table-striped" style="margin-top:25px; text-align: center; border:1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align: center;" >게시글 보기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 20%;">글제목 </td>
					<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll("\n", "<br>") %></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><%= bbs.getUserID() %></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td><%= bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><div colspan="2" class="form-control-static" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll("\n", "<br>") %></div></td>
				</tr>
			</tbody>
		</table>
		<a href="bbs.jsp" class="btn btn-primary">목록</a>
		<%
			if(userID != null && userID.equals(bbs.getUserID())){
		%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class ="btn btn-primary">수정</a>
				<a onclick="return confirm('삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class ="btn btn-primary">삭제</a>
		<%
			}
		%>
		<%
			if(userID != null){
		%>
			<form method="post" action="writeReplyAction.jsp">
				<table style="margin-top:20px;">
					<tr>
						<td><%= userID %></td>
						<input type="hidden" name="userID" value=<%= userID %>>
						<input type="hidden" name="bbsID" value=<%= bbsID %>>
						<td style="padding: 10px; width: 700px;"><input type="text" name="reply" maxlength="1000" class="form-control" placeholder="Comment Here"></td>
						<td><input type="submit" class="btn btn-primary" value="submit"></td>
					</tr>
				</table>
			</form>
		<%
			}else{
				
			}
		%>
		<table class="table" style="margin-top:15px;  ">
			<%
			if(true){
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbsr> listReply=bbsDAO.getReplyList(bbsID);
					//System.out.println("after listReply : "+listReply);
					
				for(int i=0; i < listReply.size();i++){
			%>
					<tr id="replyTr_<%=i+1%>">
						<td width="140" style="text-align: left; padding-left: 25px;" class="active"><%= listReply.get(i).getUserID()%></td>
						<td id="reply_<%=i+1%>" style="padding-left: 20px;"><span><%= listReply.get(i).getReply()%></span></td>
						<td style="text-align: right; font-size: 12px;"><%= (listReply.get(i).getBbsrDate()).substring(2) %></td>
			<%
						//System.out.println(userID);
						//System.out.println("list:"+listReply.get(i).getUserID());
						if(userID!=null&&userID.equals(listReply.get(i).getUserID())){
			%>
						<td align="center"><a id="replyModify_<%=i+1%>" onclick="modifyReplyFn(this)" class="glyphicon glyphicon-pencil" ></a></td>
						<td align="center"><a onclick="return confirm('삭제하시겠습니까?')" class="glyphicon glyphicon-trash" href="deleteReplyAction.jsp?bbsrID=<%= listReply.get(i).getBbsrID()%>&bbsID=<%= listReply.get(i).getBbsID()%>"></a></td>
			<%			
						}else{
			%>				
							<td></td>
							<td></td>
			<%				
							}
			%>
					</tr>
			<% 		
				}
			}
			%>
		</table>
	</div>	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>
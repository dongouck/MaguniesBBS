<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="java.io.PrintWriter" %> 
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:useBean id="bbsr" class="bbs.Bbsr" scope="page" />
<jsp:setProperty name="bbsr" property="reply" />
<jsp:setProperty name="bbsr" property="userID" />

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Magunie's Bulletin Board</title>
</head>
<script>
</script>
<body>
	<%	
	if(bbsr.getReply() == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글을 입력하세요.')");
		script.println("history.back()");
		script.println("</script>");
		}else{ 

			BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
			
			int bbsID=	Integer.parseInt(request.getParameter("bbsID"));
			int result = bbsDAO.writeReply(bbsID, bbsr.getReply(), bbsr.getUserID());
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('저장이 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='view.jsp?bbsID="+bbsID+"'");
				script.println("</script>");
			}
		}
	
	%>
	
</body>
</body>
</html>
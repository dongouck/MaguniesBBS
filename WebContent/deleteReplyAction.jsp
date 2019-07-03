<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="bbs.Bbs" %> 
<%@ page import="java.io.PrintWriter" %> 
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<%	
	String userID	= null;
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
	int bbsrID = 0;
	if(request.getParameter("bbsrID") != null){
		bbsrID =	Integer.parseInt(request.getParameter("bbsrID"));
		
	}
	if(bbsrID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('내용을 입력하세요.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
		int result = bbsDAO.deleteReply(bbsrID);
		String bbsID=request.getParameter("bbsID");
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('에러 발생! 삭제가 실패했습니다 :(')");
			script.println("history.back()");
			script.println("</script>");
			} else {
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'view.jsp?bbsID="+bbsID+"'");
				script.println("</script>");
			}
	}
	%>
</body>
</body>
</html>
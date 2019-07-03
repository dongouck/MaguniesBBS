<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="java.io.PrintWriter" %> 
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	}else{
		if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 정보가 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			System.out.println(bbs.getBbsTitle());
			BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기 저장이 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='bbs.jsp'");
				script.println("alert('게시글이 저장됐습니다 :)')");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</body>
</html>
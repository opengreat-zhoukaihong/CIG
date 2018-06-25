<%@ page import="java.util.*, java.net.*" %> 
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" />
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" /> 
<%
    
String username=request.getParameter("username").trim();
String passwd = request.getParameter("passwd");
   String currentPage=UserInfo.getCurrentPage();
    UserInfo.setUsername(Convert.b2g(username));
    UserInfo.setLangCode("GB");
    String info="";
if(passwd==null)
passwd="";
passwd=passwd.trim();
if(passwd.length()>0){
    UserInfo.setPassword(Convert.b2g(passwd));
    String answer = request.getParameter("answerInput");
    
    if (answer.equals("")){
         UserInfo.login();
    }else{
         UserInfo.login_forget();
    }
    
    if (UserInfo.getAuthorized()){
     if(currentPage.length()>0){
       UserInfo.setCurrentPage("");
       response.sendRedirect(currentPage);
       }else{
	response.sendRedirect("/big/signup_ok.htm");
	}
}else{
response.sendRedirect("/big/login_sorry.htm");
}
}else{
  String question="";
  question=UserInfo.getQuestion();
  if(question==null)
  question="";
  if(question.length()>0){
  response.sendRedirect("get_passwd.jsp?question="+question);
  }else{
  String title="取回密碼";
  info="對不起，沒找到此用戶或此用戶沒要求此項服務!";
  response.sendRedirect("failed.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
  }
}
%>
<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

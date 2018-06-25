<%@ page import="java.util.*, java.net.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" /> 
<%
String username=request.getParameter("username").trim();
String passwd = request.getParameter("passwd");
   String currentPage=UserInfo.getCurrentPage();
    UserInfo.setUsername(username);
    UserInfo.setLangCode("GB");
    String info="";
if(passwd==null)
passwd="";
passwd=passwd.trim();
if(passwd.length()>0){
    UserInfo.setPassword(passwd);
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
	response.sendRedirect("/gb/signup_ok.htm");
	}
}else{
response.sendRedirect("/gb/login_sorry.htm");
}
}else{
  String question="";
  question=UserInfo.getQuestion();
  if(question==null)
  question="";
  if(question.length()>0){
  response.sendRedirect("/cnbooking/gb/get_passwd.jsp?question="+question);
  }else{
  String title="取回密码";
  info="对不起，没找到此用户或此用户没要求此项服务!";
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
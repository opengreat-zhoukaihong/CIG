<%@ page import="java.util.*, java.net.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" /> 
<%
    
String username=request.getParameter("username").trim();
String passwd = request.getParameter("passwd");
  String currentPage=UserInfo.getCurrentPage();
    UserInfo.setUsername(username);
    UserInfo.setLangCode("EN");
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
	response.sendRedirect("/en/signup_ok.htm");
       }
}else{
response.sendRedirect("/en/login_sorry.htm");
}
}else{
  String question="";
  question=UserInfo.getQuestion();
  if(question==null)
  question="";
  if(question.length()>0){
  response.sendRedirect("/cnbooking/en/get_passwd.jsp?question="+question);
  }else{
  String title="Get Password";
  info="Sorry, the name you entered is incorrect or the user does not need this service!";
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
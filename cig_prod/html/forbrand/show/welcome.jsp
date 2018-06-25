<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language='java' %>
<jsp:useBean id="login" scope="request" class="com.forbrand.member.LoginBean"/>
<jsp:setProperty name="login" property="*"/>
<%! int userType;%>
<% userType = login.getUserType(); %>
<% if(userType==1) { %>
   	<% session.setAttribute("userid",login.getLogin()); %>
        <% session.removeAttribute("operator"); %>
	<jsp:forward page="car.jsp"/>
<% }
	else
	{	%>
<html><title>Login Wrong -- Forbrand.com</title>
<link rel="stylesheet" href="../../public.css">

	
<body bgcolor="#FFFFFF">
<p align="center" class="dalei">Login name or passwd is wrong!</p>
<p class="contact" align="center">Forgotten your password? <a href="passwdrecover.jsp" target="_blank">click 
  here</a>. We will send it to you. </p>
<p class="contact" align="center"> If you are not a registered membe, <a href="regform.jsp" target="_blank">click 
  here to regist</a>. </p>

	</body>
</html>
<%}	%>
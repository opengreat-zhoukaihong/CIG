<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="error.jsp"%>
<jsp:useBean id="login" scope="request" class="com.forbrand.member.LoginBean"/>
<jsp:setProperty name="login" property="*"/>
<%! int userType;%>
<% userType = login.getUserType(); %>
<% if(userType==2) { %>
        <% session.setAttribute("operator",request.getParameter("login")); %>
        <% session.removeAttribute("userid"); %>
		<jsp:forward page="/operator/welcome.jsp"/>
<%		}	%>
<% if(userType==1) { %>
   	<% session.setAttribute("userid",login.getLogin()); %>
        <% session.removeAttribute("operator"); %>
	<jsp:forward page="/login/afterlog.html"/>
<% }
	if(userType==0)
	{%>
        <% session.removeAttribute("userid"); %>
        <% session.removeAttribute("operator"); %>
		<jsp:forward page="/login/forbid.html"/>
<% 	} 	%>

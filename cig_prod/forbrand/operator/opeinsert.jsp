<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="../login/error.jsp"%>
<% if(session.getAttribute("operator")==null) {%>
<jsp:forward page="../bst/BackResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnOpeMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../bst/BackResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>

<jsp:useBean id="operator" scope="request" class="com.forbrand.member.OperatorInfoBean"/>
<jsp:setProperty name="operator" property="*"/>
<html>
<head>
	<title>Insert Operator Failed</title>
<link rel="stylesheet" href="../../public.css">
</head>

<body bgcolor="#FFFFFF">
<div align="center" class="contact">
<% if(operator.insertOperator())
	{ %> 

  <p>You have successfully insert an operator. <%	}	
	else
	{	%> </p>
  <p>You have failed to insert this operator.</p>
  <p>Maybe the Ope_ID is already used by other user,</p>
  <p>please reselect an Ope_ID.</p>
  <p> Or you can contact the webmaster.<%	}	%> </p>
  Click <a href="insertoperator.jsp">here</a> to back to the Insert Operator page. 
</div>
</body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="../login/error.jsp"%>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/main_middle.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnSecMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>


<jsp:useBean id="operator" scope="request" class="com.cig.permission.OperatorInfoBean"/>
<jsp:setProperty name="operator" property="*"/>

<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT"> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

	<title>Insert Operator Failed</title>
<link rel="stylesheet" href="/public.css">
</head>

<body bgcolor="#FFFFFF">
<div align="center" class="contact">
<% if( operator.insertOperator()) { %> 
  <p>You have successfully insert an operator. </p>
<%   } else { %> 
  <p>You have failed to insert this operator.</p>
  <p>Maybe the Ope_ID is already used by other user,</p>
  <p>please reselect an Ope_ID.</p>
  <p> Or you can contact the webmaster.</p>
<%   }  %>
  Click <a href="insertoperator.jsp">here</a> to back to the Insert Operator page. 
</div>
</body>
</html>

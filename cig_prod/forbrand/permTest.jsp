<%@ page import="java.sql.*,java.io.* " session="true" language="java" %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnGiftMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
%>
<jsp:forward page="BackResultsError.jsp" >
    <jsp:param name="message" value="Sorry! You have no permission!" />
</jsp:forward>

<html>
<head>
<title>Permission Test</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >


</body>
</html>

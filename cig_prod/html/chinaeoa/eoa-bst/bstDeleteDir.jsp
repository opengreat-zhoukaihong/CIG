<%@ page language="java" import="java.sql.*"%>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<html>
<head>
</head>
<title>Dir</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >

<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />


<%
String DirId = request.getParameter("DirId");

String SQL = "delete from  Dir_setting  " +  
		" where dirid = " + DirId;   


if (Result.IsExecute(SQL))
{ 
  
  response.sendRedirect("bstDirList.jsp");
}
else
{
  out.println("Error!");
}

Result.CloseStm();

%>


</body>
</html>
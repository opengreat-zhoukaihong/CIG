<%@ page language="java" import="java.sql.*"%>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<html>
<head>
</head>
<title>DeleteSpec</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >

<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />


<%

String SpecId = request.getParameter("SpecId");
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");

String SQL = "delete from  Spec  " +  
		" where SpecId = " + SpecId + " and Lang_code = '" + LangCode + "'";   


if (Result.IsExecute(SQL))
{ 
  
  response.sendRedirect("bstSpecList.jsp?TypeId="+ TypeId + "&LangCode=" + LangCode);
}
else
{
  out.println("Error!");
}

Result.CloseStm();

%>


</body>
</html>
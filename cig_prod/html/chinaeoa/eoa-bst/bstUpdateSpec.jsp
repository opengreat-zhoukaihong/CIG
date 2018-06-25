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
String SpecId = request.getParameter("SpecId");
String Spec = request.getParameter("Spec");
String TypeId = request.getParameter("TypeId");
String Query = request.getParameter("Query");
if (Query == null)
  Query = "";
String LangCode = request.getParameter("LangCode");
if (LangCode == null)
  LangCode = "GB";
String Desc = request.getParameter("Desc");
String SQL = "";
if (Desc == null)
  Desc = "";

SQL = "update Spec  " +  
		"set  Name = '" +  Spec + "'," + 
        " Query = '" + Query + "'," + 
         
        " Descr = '" + Desc + "' where Specid = " + SpecId
        + " and Lang_code = '" + LangCode + "'";   


if (Result.IsExecute(SQL))
{ 
  
  response.sendRedirect("bstSpecList.jsp?LangCode=" + LangCode + "&TypeId=" + TypeId);
}
else
{
  out.println("Error!");
}

Result.CloseStm();

%>


</body>
</html>
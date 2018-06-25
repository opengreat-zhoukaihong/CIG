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
String TypeId = request.getParameter("TypeId");
String Spec = request.getParameter("Spec");
String LangCode = request.getParameter("LangCode");
if (LangCode == null)
  LangCode = "GB";
String Query = request.getParameter("Query");
String Desc = request.getParameter("Desc");
String SQL = "";
if (Query == null)
  Query = "";
if (Desc == null)
  Desc = "";

SQL = "insert into Spec (SpecId, Name, descr, Lang_code,typeid,query)  " +  
		"values ( seq_Specid.nextval ,'" + 
                       Spec+ "','" + 
                       Desc+ "','" + 
                       LangCode+ "','" + 
                       TypeId+ "','" + 
                       Query + "')";   


if (Result.IsExecute(SQL))
{ 
  
  response.sendRedirect("bstSpecList.jsp?TypeId=" + TypeId + "&LangCode=" + LangCode);
}
else
{
  out.println("Error!");
}

Result.CloseStm();

%>


</body>
</html>
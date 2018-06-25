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

String ProdId = request.getParameter("ProdId");
String StartDate = request.getParameter("StartDate");
String Location = request.getParameter("Location");

String SQL = "delete from  Speci_Sale  " +  
		" where ProdId = " + ProdId +
	    " and Location = '" + Location + "' and To_char(be_date,'YYYY-MM-DD') = '" 
		+ StartDate + "'";   


if (Result.IsExecute(SQL))
{ 
  
  response.sendRedirect("bstHotList.jsp");
}
else
{
  out.println("Error!");
}

Result.CloseStm();

%>


</body>
</html>
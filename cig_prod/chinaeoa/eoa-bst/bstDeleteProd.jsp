<%@ page language="java" import="java.sql.*"%>
<%@ include file="bstChkLogin.jsp"%>
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
String LangCode = request.getParameter("LangCode");
if (LangCode == null)
  LangCode = "GB";

String SQL = "delete from  product_l  " +  
		" where ProdId = " + ProdId +  " and Lang_Code = '" + LangCode + "'" ;

//out.println(SQL);

if (Result.IsExecute(SQL))
{
  SQL = "delete from  product  " +  
		" where ProdId = " + ProdId ;
  out.println(SQL);

  if (Result.IsExecute(SQL))
  { 
    out.println("<p><p><center>删除成功!</center>");  
  }
  else
  {
    //out.println("Error!");
  }
}
else
  out.println("Error!");

Result.CloseStm();

%>


</body>
</html>
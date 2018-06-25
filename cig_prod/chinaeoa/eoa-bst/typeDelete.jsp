<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%!
  String typeID,langCodeID;
  int errorCode;
%>

<jsp:useBean id="typeManager" scope="page" class="com.cig.chinaeoa.bst.TypeManager" />

<%
  try
  {
    typeID = request.getParameter("typeID");
    langCodeID = request.getParameter("langCode");

    typeManager.setTypeID(typeID);
    typeManager.setLang_code(langCodeID);

    typeManager.typeDelete();
    errorCode = typeManager.getErrorCode();
    if(errorCode == 0)
    {
%>
    <p  class="font1">删除成功!</p>
    <p  class="font3"><a href="typeList.jsp">返回</a></p>
<%
    }
    else
    {
%>
     <p  class="font1">修改失败!</p>
     <p  class="font3"><a href="javascript:history.go(-1);">返回</a></p>
<%
    }

  }
  catch(Exception e)
  {
    e.printStackTrace();
  }

%>


</body>
</html>

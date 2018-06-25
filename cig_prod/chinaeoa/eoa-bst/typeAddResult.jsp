<%@ page language="java" import="java.sql.* " %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="typeManager" scope="page" class="com.cig.chinaeoa.bst.TypeManager" />


<html>
<head>
</head>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">

<body bgcolor="#FFFFFF" >

<%!
  String typeName = "";
  String langCode = "";
  int errorCode;
%>
<%
  typeName = request.getParameter("typeName");
  langCode = request.getParameter("langCode");

  typeManager.setName(typeName);

  typeManager.addType();

  errorCode = typeManager.getErrorCode();
  if(errorCode == 0)
  {
%>
    <p  class="font1">该产品大类的所有语言版本均已增加成功!</p>
    <p  class="font1">请不要再次增加该产品大类的任何语言版本!!</p>
    <p  class="font1">如要修改各语言版本的产品大类名称,</p>
    <p  class="font1">请选择左侧菜单中的类别列表进行产品大类信息的修改.</p>
<%
  }
  else
  {
%>
     <p  class="font1">操作失败!</p>
<%
  }
%>

</body>
</html>
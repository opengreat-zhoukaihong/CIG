<%@ page language="java" import="java.sql.* " %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="cateManager" scope="page" class="com.cig.chinaeoa.bst.CateManager" />


<html>
<head>
</head>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">

<body bgcolor="#FFFFFF" >

<%!
  String cateID = "";
  String cateName = "";
  String langCode = "";
  int errorCode;
  String tempStr="";
%>
<%
  cateID = request.getParameter("cateID");
  cateName = request.getParameter("cateName");
  langCode = request.getParameter("langCode");

  cateManager.setCateID(cateID);
  cateManager.setLang_code(langCode);
  cateManager.setName(cateName);

  cateManager.modifyCate();

  errorCode = cateManager.getErrorCode();
  if(errorCode == 0)
  {
%>
    <p  class="font1">��Ϣ�޸ĳɹ�!</p>
    <p  class="font3"><a href="typeList.jsp">����</a></p>
<%
  }
  else
  {
%>
     <p  class="font1">�޸�ʧ��!</p>
     <p  class="font3"><a href="javascript:history.go(-1);">����</a></p>
<%
  }
%>

</body>
</html>
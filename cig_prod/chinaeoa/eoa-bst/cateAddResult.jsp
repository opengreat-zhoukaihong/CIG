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
  String cateName = "";
  String typeID = "";
  String langCode = "";
  int errorCode;
%>
<%
  cateName = request.getParameter("cateName");
  typeID = request.getParameter("typeID");
  langCode = request.getParameter("langCode");

  cateManager.setName(cateName);
  cateManager.setTypeID(typeID);

  cateManager.addCate();

  errorCode = cateManager.getErrorCode();
  if(errorCode == 0)
  {
%>
    <p  class="font1">�ò�ƷС����������԰汾�������ӳɹ�!</p>
    <p  class="font1">�벻Ҫ�ٴ����Ӹò�ƷС����κ����԰汾!!</p>
    <p  class="font1">��Ҫ�޸ĸ����԰汾�Ĳ�ƷС������,</p>
    <p  class="font1">��ѡ�����˵��е�����б���в�ƷС����Ϣ���޸�.</p>
<%
  }
  else
  {
%>
     <p  class="font1">����ʧ��!</p>
<%
  }
%>

</body>
</html>
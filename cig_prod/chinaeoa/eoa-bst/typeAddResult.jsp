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
    <p  class="font1">�ò�Ʒ������������԰汾�������ӳɹ�!</p>
    <p  class="font1">�벻Ҫ�ٴ����Ӹò�Ʒ������κ����԰汾!!</p>
    <p  class="font1">��Ҫ�޸ĸ����԰汾�Ĳ�Ʒ��������,</p>
    <p  class="font1">��ѡ�����˵��е�����б���в�Ʒ������Ϣ���޸�.</p>
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
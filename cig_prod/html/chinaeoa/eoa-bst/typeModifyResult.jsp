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
  String typeID = "";
  String typeName = "";
  String langCode = "";
  int errorCode;
  String tempStr="";
%>
<%
  typeID = request.getParameter("typeID");
  typeName = request.getParameter("typeName");
  langCode = request.getParameter("langCode");

  typeManager.setTypeID(typeID);
  typeManager.setLang_code(langCode);
  typeManager.setName(typeName);

  typeManager.modifyType();

  errorCode = typeManager.getErrorCode();
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
<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>
<%@ include file="bstChkLogin.jsp"%>

<html>
<head>
<title>ɾ����ƷС��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%!
  String cateID,langCodeID;
  int errorCode;
%>

<jsp:useBean id="cateManager" scope="page" class="com.cig.chinaeoa.bst.CateManager" />

<%
  try
  {
    cateID = request.getParameter("cateID");
    langCodeID = request.getParameter("langCode");

    cateManager.setCateID(cateID);
    cateManager.setLang_code(langCodeID);

    cateManager.cateDelete();
    errorCode = cateManager.getErrorCode();
    if(errorCode == 0)
    {
%>
    <p  class="font1">ɾ���ɹ�!</p>
    <p  class="font3"><a href="cateList.jsp">����</a></p>
<%
    }
    else
    {
%>
     <p  class="font1">�޸�ʧ��!</p>
     <p  class="font3"><a href="javascript:history.go(-1);">����</a></p>
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

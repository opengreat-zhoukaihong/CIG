<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="IndusCorpBKDel" scope="page" class="com.cnbooking.bst.IndusCorpBKDel" />
<%
String parameteres=request.getParameter("parameteres");
String pageNo=request.getParameter("pageNo");
String ope_ID=request.getParameter("ope_ID");
String str=request.getParameter("str");

String info="";
info+=parameteres.substring(0,1);
String ends=parameteres.substring(1,parameteres.length());

IndusCorpBKDel.setOpeID(ope_ID);
IndusCorpBKDel.setParameteres(ends);
        
 if(IndusCorpBKDel.DelIndusCorps()){ 
	info += "��ϲ,ͬ�й�˾ɾ�����ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,ͬ�й�˾ɾ��δ�ܳɹ�����������!";
  }
response.sendRedirect("IndusCorpBKList.jsp?pageNo="+pageNo+"&ope_ID="+ope_ID+str);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

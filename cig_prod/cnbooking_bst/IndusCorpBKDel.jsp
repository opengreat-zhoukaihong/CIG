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
	info += "恭喜,同行公司删除更改成功!<br>";
    }
    else{
	info +="很抱歉,同行公司删除未能成功，请检查数据!";
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

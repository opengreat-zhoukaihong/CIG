<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKAirDel" scope="page" class="com.cnbooking.bst.flight.FlightBKAirDel" />
<%
String parameteres=request.getParameter("parameteres");
String pageNo=request.getParameter("pageNo");
String ope_ID=request.getParameter("ope_ID");
String str=request.getParameter("str");

String info="";
info+=parameteres.substring(0,1);
String ends=parameteres.substring(1,parameteres.length());

FlightBKAirDel.setOpeID(ope_ID);
FlightBKAirDel.setParameteres(ends);
        
 if(FlightBKAirDel.DelAirLines()){ 
	info += "��ϲ,���չ�˾ɾ�����ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,���չ�˾ɾ��δ�ܳɹ�����������!";
  }
response.sendRedirect("FlightBKAirList.jsp?pageNo="+pageNo+"&ope_ID="+ope_ID+str);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKPortDel" scope="page" class="com.cnbooking.bst.flight.FlightBKPortDel" />
<%
String parameteres=request.getParameter("parameteres");
String pageNo=request.getParameter("pageNo");
String ope_ID=request.getParameter("ope_ID");
String str=request.getParameter("str");

String info="";
info+=parameteres.substring(0,1);
String ends=parameteres.substring(1,parameteres.length());

FlightBKPortDel.setOpeID(ope_ID);
FlightBKPortDel.setParameteres(ends);
        
 if(FlightBKPortDel.DelAirPorts()){ 
	info += "��ϲ,����ɾ�����ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,����ɾ��δ�ܳɹ�����������!";
  }
response.sendRedirect("FlightBKPortList.jsp?pageNo="+pageNo+"&ope_ID="+ope_ID+str);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKLineDel" scope="page" class="com.cnbooking.bst.flight.FlightBKLineDel" />
<%
String parameteres=request.getParameter("parameteres");
String pageNo=request.getParameter("pageNo");
String ope_ID=request.getParameter("ope_ID");
String str=request.getParameter("str");

String info="";
info+=parameteres.substring(0,1);
String ends=parameteres.substring(1,parameteres.length());

FlightBKLineDel.setOpeID(ope_ID);
FlightBKLineDel.setParameteres(ends);
        
 if(FlightBKLineDel.DelAirLines()){ 
	info += "恭喜,航线删除更改成功!<br>";
    }
    else{
	info +="很抱歉,航线删除未能成功，请检查数据!";
  }
response.sendRedirect("FlightBKLineList.jsp?pageNo="+pageNo+"&ope_ID="+ope_ID+str);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>
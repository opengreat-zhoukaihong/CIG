<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKPortChang" scope="page" class="com.cnbooking.bst.flight.FlightBKPortChang" />
<%
String ope_ID=request.getParameter("ope_ID");
String city_ID=request.getParameter("city_ID");

String info="";
String portNameGB=request.getParameter("portNameGB");
String portNameEN = request.getParameter("portNameEN");
String portDescrGB = request.getParameter("portDescrGB");
String portDescrEN = request.getParameter("portDescrEN");

 FlightBKPortChang.setOpeID(ope_ID);
 FlightBKPortChang.setCityID(city_ID);
 
 String portID=FlightBKPortChang.getPortID();
 
 FlightBKPortChang.setLangCode("GB");
 FlightBKPortChang.setPortName(portNameGB);
 FlightBKPortChang.setPortDescr(portDescrGB);
 if(FlightBKPortChang.InsertFlightPort()){ 
	info += "恭喜,机场中文添加成功!<br>";
    }
    else{
	info +="很抱歉,机场中文添加未能成功，请检查数据!";
  }
 
 FlightBKPortChang.setLangCode("EN");
 FlightBKPortChang.setPortName(portNameEN);
 FlightBKPortChang.setPortDescr(portDescrEN);
 
 if(FlightBKPortChang.InsertFlightPort()){ 
	info += "恭喜,机场英文添加成功!<br>";
    }
    else{
	info +="很抱歉,机场英文添加未能成功，请检查数据!";
  }
String title="机场添加";
response.sendRedirect("../success.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

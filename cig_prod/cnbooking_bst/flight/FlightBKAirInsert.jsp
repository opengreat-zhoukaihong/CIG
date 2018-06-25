<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKAirChang" scope="page" class="com.cnbooking.bst.flight.FlightBKAirChang" />
<%
String ope_ID=request.getParameter("ope_ID");

String info="";
String airNameGB=request.getParameter("airNameGB");
String airNameEN = request.getParameter("airNameEN");

 FlightBKAirChang.setOpeID(ope_ID);
 
 String airID=FlightBKAirChang.getAirID();
 
 FlightBKAirChang.setLangCode("GB");
 FlightBKAirChang.setAirName(airNameGB);
 if(FlightBKAirChang.InsertFlightAir()){ 
	info += "恭喜,航空公司中文添加成功!<br>";
    }
    else{
	info +="很抱歉,航空公司中文添加未能成功，请检查数据!";
  }
 
 FlightBKAirChang.setLangCode("EN");
 FlightBKAirChang.setAirName(airNameEN);
  
 if(FlightBKAirChang.InsertFlightAir()){ 
	info += "恭喜,航空公司英文添加成功!<br>";
    }
    else{
	info +="很抱歉,航空公司英文添加未能成功，请检查数据!";
  }
String title="航空公司添加";
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

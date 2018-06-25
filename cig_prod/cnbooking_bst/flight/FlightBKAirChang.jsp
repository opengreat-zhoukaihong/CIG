<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKAirChang" scope="page" class="com.cnbooking.bst.flight.FlightBKAirChang" />
<%
String ope_ID=request.getParameter("ope_ID");
String air_ID=request.getParameter("air_ID");

String info="";
String airNameGB=request.getParameter("airNameGB");
String airNameEN = request.getParameter("airNameEN");

 FlightBKAirChang.setOpeID(ope_ID);
 FlightBKAirChang.setAirID(air_ID);

 FlightBKAirChang.setLangCode("GB");
 FlightBKAirChang.setAirName(airNameGB);
  if(FlightBKAirChang.UpdateFlightAir()){ 
	info += "恭喜,航空公司中文更改成功!<br>";
    }
    else{
	info +="很抱歉,航空公司中文更改未能成功，请检查数据!";
  }
 
 FlightBKAirChang.setLangCode("EN");
 FlightBKAirChang.setAirName(airNameEN);
 
 if(FlightBKAirChang.UpdateFlightAir()){
 	info += "恭喜,航空公司英文更改成功!<br>";
    }
    else{
	info +="很抱歉,航空公司英文更改未能成功，请检查数据!";
  }
String title="航空公司更改";
response.sendRedirect("../ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

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
	info += "��ϲ,���չ�˾������ӳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,���չ�˾�������δ�ܳɹ�����������!";
  }
 
 FlightBKAirChang.setLangCode("EN");
 FlightBKAirChang.setAirName(airNameEN);
  
 if(FlightBKAirChang.InsertFlightAir()){ 
	info += "��ϲ,���չ�˾Ӣ����ӳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,���չ�˾Ӣ�����δ�ܳɹ�����������!";
  }
String title="���չ�˾���";
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

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
	info += "��ϲ,���չ�˾���ĸ��ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,���չ�˾���ĸ���δ�ܳɹ�����������!";
  }
 
 FlightBKAirChang.setLangCode("EN");
 FlightBKAirChang.setAirName(airNameEN);
 
 if(FlightBKAirChang.UpdateFlightAir()){
 	info += "��ϲ,���չ�˾Ӣ�ĸ��ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,���չ�˾Ӣ�ĸ���δ�ܳɹ�����������!";
  }
String title="���չ�˾����";
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

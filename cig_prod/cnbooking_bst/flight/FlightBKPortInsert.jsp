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
	info += "��ϲ,����������ӳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,�����������δ�ܳɹ�����������!";
  }
 
 FlightBKPortChang.setLangCode("EN");
 FlightBKPortChang.setPortName(portNameEN);
 FlightBKPortChang.setPortDescr(portDescrEN);
 
 if(FlightBKPortChang.InsertFlightPort()){ 
	info += "��ϲ,����Ӣ����ӳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,����Ӣ�����δ�ܳɹ�����������!";
  }
String title="�������";
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

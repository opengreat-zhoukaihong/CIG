<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKPortChang" scope="page" class="com.cnbooking.bst.flight.FlightBKPortChang" />
<%
String ope_ID=request.getParameter("ope_ID");
String port_ID=request.getParameter("port_ID");
String city_ID=request.getParameter("city_ID");

String info="";
String portNameGB=request.getParameter("portNameGB");
String portNameEN = request.getParameter("portNameEN");
String portDescrGB = request.getParameter("portDescrGB");
String portDescrEN = request.getParameter("portDescrEN");

 FlightBKPortChang.setOpeID(ope_ID);
 FlightBKPortChang.setCityID(city_ID);
 FlightBKPortChang.setPortID(port_ID);

 FlightBKPortChang.setLangCode("GB");
 FlightBKPortChang.setPortName(portNameGB);
 FlightBKPortChang.setPortDescr(portDescrGB);
 if(FlightBKPortChang.UpdateFlightPort()){ 
       info += "��ϲ,�������ĸ��ĳɹ�!<br>";
    }
    else{
       info +="�ܱ�Ǹ,�������ĸ���δ�ܳɹ�����������!";
  }
 
 FlightBKPortChang.setLangCode("EN");
 FlightBKPortChang.setPortName(portNameEN);
 FlightBKPortChang.setPortDescr(portDescrEN);
 
 if(FlightBKPortChang.UpdateFlightPort()){
 	info += "��ϲ,����Ӣ�ĸ��ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,����Ӣ�ĸ���δ�ܳɹ�����������!";
  }
String title="��������";
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

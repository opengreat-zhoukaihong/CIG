<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKBookUpdate" scope="page" class="com.cnbooking.bst.flight.FlightBKBookUpdate" />
<%
String ope_ID=request.getParameter("ope_ID");
String dealID=request.getParameter("dealID");
String dealSeq=request.getParameter("dealSeq");
String dealStatus=request.getParameter("dealStatus");

String info="";
 FlightBKBookUpdate.setOpeID(ope_ID);
 FlightBKBookUpdate.setDealID(dealID);
 FlightBKBookUpdate.setDealSeq(dealSeq);
 FlightBKBookUpdate.setStatus(dealStatus);
        
 if(FlightBKBookUpdate.UpdateBookingStatus()){ 
	info += "��ϲ,Ԥ��׳̬���ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,Ԥ��׳̬����δ�ܳɹ�����������!";
  }

String title="�ɻ�Ԥ��";
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

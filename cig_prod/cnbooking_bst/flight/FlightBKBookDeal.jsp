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
	info += "恭喜,预定壮态更改成功!<br>";
    }
    else{
	info +="很抱歉,预定壮态更改未能成功，请检查数据!";
  }

String title="飞机预定";
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

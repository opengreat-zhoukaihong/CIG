<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKBookStatus" scope="page" class="com.cnbooking.bst.flight.FlightBKBookStatus" />
<%
String parameteres=request.getParameter("parameteres");
String actions=request.getParameter("actions");
String pageNo=request.getParameter("pageNo");
String ope_ID=request.getParameter("ope_ID");
String dealStatus=request.getParameter("dealStatus");
String str=request.getParameter("str");

String info="";
info+=parameteres.substring(0,1);
String ends=parameteres.substring(1,parameteres.length());

FlightBKBookStatus.setLangCode("GB");
FlightBKBookStatus.setOpeID(ope_ID);
FlightBKBookStatus.setParameteres(ends);
FlightBKBookStatus.setStatus(dealStatus);
        
 if(FlightBKBookStatus.UpdateBooksStatus()){ 
	info += "恭喜,预定壮态更改成功!<br>";
    }
    else{
	info +="很抱歉,预定壮态更改未能成功，请检查数据!";
  }

response.sendRedirect("FlightBK_List.jsp?actions="+actions+"&pageNo="+pageNo+"&ope_ID="+ope_ID+str);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

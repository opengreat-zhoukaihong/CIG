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
	info += "��ϲ,Ԥ��׳̬���ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,Ԥ��׳̬����δ�ܳɹ�����������!";
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

<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="TourBKBookStatus" scope="page" class="com.cnbooking.bst.tour.TourBKBookStatus" />
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

TourBKBookStatus.setLangCode("GB");
TourBKBookStatus.setOpeID(ope_ID);
TourBKBookStatus.setParameteres(ends);
TourBKBookStatus.setStatus(dealStatus);
        
 if(TourBKBookStatus.UpdateBooksStatus()){ 
	info += "恭喜,预定壮态更改成功!<br>";
    }
    else{
	info +="很抱歉,预定壮态更改未能成功，请检查数据!";
  }

response.sendRedirect("tourBKList.jsp?actions="+actions+"&pageNo="+pageNo+"&ope_ID="+ope_ID+str);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="TourBKBookUpdate" scope="page" class="com.cnbooking.bst.tour.TourBKBookUpdate" />
<%
String ope_ID=request.getParameter("ope_ID");
String book_ID=request.getParameter("book_ID");
String line_ID=request.getParameter("line_ID");
String dealStatus=request.getParameter("dealStatus");

String info="";
 TourBKBookUpdate.setOpeID(ope_ID);
 TourBKBookUpdate.setBook_ID(book_ID);
 TourBKBookUpdate.setLine_ID(line_ID);
 TourBKBookUpdate.setStatus(dealStatus);
        
 if(TourBKBookUpdate.UpdateBookingStatus()){ 
	info += "恭喜,预定壮态更改成功!<br>";
    }
    else{
	info +="很抱歉,预定壮态更改未能成功，请检查数据!";
  }

String title="城市旅游预定";
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

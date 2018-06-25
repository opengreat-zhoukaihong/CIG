<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="TourBKLineChang" scope="page" class="com.cnbooking.bst.tour.TourBKLineChang" />
<%
String ope_ID=request.getParameter("ope_ID");

String info="";
String titleGB=request.getParameter("titleGB");
String titleEN = request.getParameter("titleEN");
String scheGB = request.getParameter("scheGB");
String scheEN = request.getParameter("scheEN");
String servicesGB = request.getParameter("servicesGB");
String servicesEN = request.getParameter("servicesEN");

 TourBKLineChang.setOpeID(ope_ID);

 String lineID=TourBKLineChang.getLineID();

 TourBKLineChang.setLangCode("GB");
 TourBKLineChang.setTitle(titleGB);
 TourBKLineChang.setSche(scheGB);
 TourBKLineChang.setServices(servicesGB);
 if(TourBKLineChang.InsertTourLine()){ 
       info += "恭喜,旅游线路中文添加成功!<br>";
    }
    else{
       info +="很抱歉,旅游线路中文添加未能成功，请检查数据!";
  }
 TourBKLineChang.setLangCode("EN");
 TourBKLineChang.setTitle(titleEN);
 TourBKLineChang.setSche(scheEN);
 TourBKLineChang.setServices(servicesEN);
 if(TourBKLineChang.InsertTourLine()){ 
 	info += "恭喜,旅游线路英文添加成功!<br>";
    }
    else{
	info +="很抱歉,旅游线路英文添加未能成功，请检查数据!";
  }
String title="旅游线路添加";
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

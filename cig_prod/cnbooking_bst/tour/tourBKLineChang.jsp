<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="TourBKLineChang" scope="page" class="com.cnbooking.bst.tour.TourBKLineChang" />
<%
String ope_ID=request.getParameter("ope_ID");
String line_ID=request.getParameter("line_ID");

String info="";
String titleGB=request.getParameter("titleGB");
String titleEN = request.getParameter("titleEN");
String scheGB = request.getParameter("scheGB");
String scheEN = request.getParameter("scheEN");
String servicesGB = request.getParameter("servicesGB");
String servicesEN = request.getParameter("servicesEN");

 TourBKLineChang.setOpeID(ope_ID);
 TourBKLineChang.setLineID(line_ID);

 TourBKLineChang.setLangCode("GB");
 TourBKLineChang.setTitle(titleGB);
 TourBKLineChang.setSche(scheGB);
 TourBKLineChang.setServices(servicesGB);
 if(TourBKLineChang.UpdateTourLine()){ 
       info += "恭喜,旅游线路中文更改成功!<br>";
    }
    else{
       info +="很抱歉,旅游线路中文更改未能成功，请检查数据!";
  }
 if(titleEN!=null){
 TourBKLineChang.setLangCode("EN");
 TourBKLineChang.setTitle(titleEN);
 TourBKLineChang.setSche(scheEN);
 TourBKLineChang.setServices(servicesEN);
 if(!(titleEN.trim().equals(""))){
 if(TourBKLineChang.UpdateTourLine()){ 
 	info += "恭喜,旅游线路英文更改成功!<br>";
    }
    else{
	info +="很抱歉,旅游线路英文更改未能成功，请检查数据!";
  }
  }
  }
String title="旅游线路更改";
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


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
       info += "��ϲ,������·������ӳɹ�!<br>";
    }
    else{
       info +="�ܱ�Ǹ,������·�������δ�ܳɹ�����������!";
  }
 TourBKLineChang.setLangCode("EN");
 TourBKLineChang.setTitle(titleEN);
 TourBKLineChang.setSche(scheEN);
 TourBKLineChang.setServices(servicesEN);
 if(TourBKLineChang.InsertTourLine()){ 
 	info += "��ϲ,������·Ӣ����ӳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,������·Ӣ�����δ�ܳɹ�����������!";
  }
String title="������·���";
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

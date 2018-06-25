<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="TourBKLineDel" scope="page" class="com.cnbooking.bst.tour.TourBKLineDel" />
<%
String parameteres=request.getParameter("parameteres");
String pageNo=request.getParameter("pageNo");
String ope_ID=request.getParameter("ope_ID");
String str=request.getParameter("str");
String currPage=request.getParameter("currPage");

String info="";
info+=parameteres.substring(0,1);
String ends=parameteres.substring(1,parameteres.length());

TourBKLineDel.setOpeID(ope_ID);
TourBKLineDel.setParameteres(ends);
        
 if(TourBKLineDel.DelTourLines()){ 
	info += "恭喜,旅游线路删除更改成功!<br>";
    }
    else{
	info +="很抱歉,旅游线路删除未能成功，请检查数据!";
  }
response.sendRedirect(""+currPage+"?pageNo="+pageNo+"&ope_ID="+ope_ID+str);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

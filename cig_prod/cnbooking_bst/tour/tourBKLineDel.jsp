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
	info += "��ϲ,������·ɾ�����ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,������·ɾ��δ�ܳɹ�����������!";
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

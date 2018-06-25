<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>

<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% } 
     String str;
    String hotel_ID = request.getParameter("hotel_ID");
    if(hotel_ID!=null){
%>
<jsp:useBean id="CalPrice" scope="page" class="com.cnbooking.bst.hotel.CalPrice" /> 
<% 
    CalPrice.setHotelId(hotel_ID);
    str = CalPrice.calPrice();
}else{
    str="请传递好酒店的参数!";
}
%>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr > 
    <td width="80">&nbsp; </td>
        <table width="150" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff" align="center">
          <tr> 
            <td colspan="2" class="font9"><%=str%></td>
          </tr>
        </table>
    </td>
  </tr>
  <tr > 
    <td width="80">&nbsp; </td>
        <table width="150" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff" align="center">
          <tr> 
            <td colspan="2" class="font9"><a href="javascript:window.history.go(-1)">返回</a></td>
          </tr>
        </table>
    </td>
  </tr>
</table>
</body>
</html>

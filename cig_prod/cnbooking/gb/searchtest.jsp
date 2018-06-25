<html>
<head>
<title>test</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none; color: #000000; font-family: "宋体"}
a:visited {  text-decoration: none; color: #000000; font-family: "宋体"}
a:active {  text-decoration: none; color: #000000; font-family: "宋体"}
a:hover {  color: #330099; text-decoration: underline; font-family: "宋体"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "宋体"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.hotel.*" %> 

<jsp:useBean id="HotelList" scope="page" class="com.cnbooking.hotel.HotelList" /> 
<jsp:setProperty name="HotelList" property="langCode" value="EN"/> 
<jsp:setProperty name="HotelList" property="pageFlag" value="Y"/> 
<jsp:setProperty name="HotelList" property="pageNo" value="1"/>
<jsp:setProperty name="HotelList" property="promotion"/>
<jsp:setProperty name="HotelList" property="stateId" value="0"/>
<jsp:setProperty name="HotelList" property="cityId" value="0"/> 
<jsp:setProperty name="HotelList" property="starId" value="0"/>
<jsp:setProperty name="HotelList" property="priceFrom"/> 
<jsp:setProperty name="HotelList" property="priceTo"/>
<jsp:setProperty name="HotelList" property="hotelName"/>

<%
    int hotel_count = 0;
    int total_page = 0;
    String[][] hotel_list;
      
    
    hotel_list = HotelList.getHotelList();
    hotel_count = HotelList.getHotelCount();
    total_page = HotelList.getTotalPage();
        
%> 

<body>
<%=hotel_count%><BR>
<% for (int i=0;i<30;i++) {%>
<%=hotel_list[i][0]%><br>
<%=hotel_list[i][1]%><br>
<%=hotel_list[i][2]%><br>
<%=hotel_list[i][3]%><br>
<%=hotel_list[i][4]%><br>
<%=hotel_list[i][5]%><br>
<%=hotel_list[i][6]%><br>
<%=hotel_list[i][7]%><br>
<%=hotel_list[i][8]%><br>
<%}%>
<%=HotelList.error%>

</body>
</html>

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

<jsp:useBean id="HotelDetail" scope="page" class="com.cnbooking.hotel.HotelDetail" /> 
<jsp:setProperty name="HotelDetail" property="langCode" value="GB"/> 
<jsp:setProperty name="HotelDetail" property="hotelId" value="16"/> 


<%
    int price_count = 0;
    String[][] price;
    
 
    
    HotelDetail.getHotelDetail();
    
    
    price_count = HotelDetail.getPriceCount();
    price = HotelDetail.getPrice();
    
    String hotelName = HotelDetail.getHotelName();
    String starRating = HotelDetail.getStarRating();
    String starImageFile = HotelDetail.getStarImageFile();
    String fullDesc = HotelDetail.getFullDesc();
    String facilityDrink = HotelDetail.getFacilityDrink();
    String facilityEnt = HotelDetail.getFacilityEnt();
    String facilityServ = HotelDetail.getFacilityServ();
    String address = HotelDetail.getAddress();
    String city = HotelDetail.getCity();
    String state = HotelDetail.getState();
    String location = HotelDetail.getLocation();
    String postCode = HotelDetail.getPostCode();
    String telephone = HotelDetail.getTelephone();
    String fax = HotelDetail.getFax();
    String url = HotelDetail.getUrl();
    String imageDir = HotelDetail.getImageDir();
    String image1 = HotelDetail.getImage1();
    String image2 = HotelDetail.getImage2();
    String image3 = HotelDetail.getImage3();
    String mapDir = HotelDetail.getMapDir();
    String mapFile = HotelDetail.getMapFile();   
    
    
        
%> 

<%=hotelName%>
<%=starRating%>
<%=starImageFile%>
<%=fullDesc%>
<%=facilityDrink%>
<%=facilityEnt%>
<%=facilityServ%>
<%=address%>
<%=city%>
<%=state%>
<%=location%>
<%=postCode%>
<%=telephone%>
<%=fax%>
<%=url%>
<%=imageDir%>
<%=image1%>
<%=image2%>
<%=image3%>
<%=mapDir%>
<%=mapFile%>   
<body>
<%=price_count%><BR>
<% for (int i=0;i<price_count;i++) {%>
<%=price[i][0]%><br>
<%=price[i][1]%><br>
<%=price[i][2]%><br>
<%=price[i][3]%><br>
<%=price[i][4]%><br>
<%=price[i][5]%><br>
<%}%>
<%=HotelDetail.error%>

</body>
</html>

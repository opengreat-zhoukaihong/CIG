<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="HotelBKPriceView" scope="page" class="com.cnbooking.bst.hotel.HotelBKPriceView" />
<%
String ope_ID=request.getParameter("ope_ID");
String hotel_ID=request.getParameter("hotel_ID");

String room_Type_ID1=request.getParameter("room_Type_ID1");
String price_Type_ID1=request.getParameter("price_Type_ID1");
String source_ID1=request.getParameter("source_ID1");

String bgn_Date1=request.getParameter("bgn_Date1");
String end_Date1=request.getParameter("end_Date1");
String weekDay_Price=request.getParameter("weekDay_Price");
String week5_Price=request.getParameter("week5_Price");
String week6_Price=request.getParameter("week6_Price");
String week7_Price=request.getParameter("week7_Price");
String holiday_Price=request.getParameter("holiday_Price");
String currency1=request.getParameter("currency1");

String market_Price;
String level;
String published;
String remark;

market_Price=request.getParameter("market_Price");
level=request.getParameter("level");
published=request.getParameter("published");
remark=request.getParameter("remark");

HotelBKPriceView.setOpe_ID(ope_ID);
HotelBKPriceView.setLangCode("GB");
HotelBKPriceView.setHotel_ID(hotel_ID);

if(room_Type_ID1 !=null)
HotelBKPriceView.setRoom_Type_ID1(room_Type_ID1);
if(price_Type_ID1 !=null)
HotelBKPriceView.setPrice_Type_ID1(price_Type_ID1);
if(source_ID1 !=null)
HotelBKPriceView.setSource_ID1(source_ID1);
if(bgn_Date1 !=null)
HotelBKPriceView.setBgn_Date1(bgn_Date1);
if(end_Date1 !=null)
HotelBKPriceView.setEnd_Date1(end_Date1);
if(weekDay_Price !=null)
HotelBKPriceView.setWeekDay_Price(weekDay_Price);
if(week5_Price !=null)
HotelBKPriceView.setWeek5_Price(week5_Price);
if(week6_Price !=null)
HotelBKPriceView.setWeek6_Price(week6_Price);
if(week7_Price !=null)
HotelBKPriceView.setWeek7_Price(week7_Price);
if(holiday_Price !=null)
HotelBKPriceView.setHoliday_Price(holiday_Price);
if(currency1 !=null)
HotelBKPriceView.setCurrency1(currency1);
if(market_Price !=null)
HotelBKPriceView.setMarket_Price(market_Price);
if(level !=null)
HotelBKPriceView.setLevel(level);
if(published !=null)
HotelBKPriceView.setPublished(published);
if(remark!=null)
HotelBKPriceView.setRemark(remark);
String info="";

 if(HotelBKPriceView.AddHotelPrice()){ 
	info += "恭喜,价格添加成功!<br>";
    }
    else{
	info +="很抱歉,价格添加未能成功，请检查数据!";
  }
String title="价格添加";
response.sendRedirect("ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

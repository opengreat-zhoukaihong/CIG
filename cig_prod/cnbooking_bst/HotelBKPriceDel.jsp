<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="HotelBKPriceView" scope="page" class="com.cnbooking.bst.hotel.HotelBKPriceView" />
<%
String hotel_ID=request.getParameter("hotel_ID");
String pageNo=request.getParameter("pageNo");
String room_Type_ID=request.getParameter("room_Type_ID");
String price_Type_ID=request.getParameter("price_Type_ID");
String bgn_Date=request.getParameter("bgn_Date");
String end_Date=request.getParameter("end_Date");
String currency=request.getParameter("currency");
String source_ID=request.getParameter("source_ID");
String ope_ID=request.getParameter("ope_ID");

HotelBKPriceView.setOpe_ID(ope_ID);
HotelBKPriceView.setLangCode("GB");
HotelBKPriceView.setHotel_ID(hotel_ID);

HotelBKPriceView.setRoom_Type_ID(room_Type_ID);
HotelBKPriceView.setPrice_Type_ID(price_Type_ID);
HotelBKPriceView.setBgn_Date(bgn_Date);
HotelBKPriceView.setEnd_Date(end_Date);
if(currency!=null)
HotelBKPriceView.setCurrency(currency);
if(source_ID!=null)
HotelBKPriceView.setSource_ID(source_ID);

String info="";

 if(HotelBKPriceView.DelHotelPrice()){ 
	info += "恭喜,价格删除成功!<br>";
    }
    else{
	info +="很抱歉,价格删除未能成功，请检查数据!";
  }
response.sendRedirect("HotelBKPriceList.jsp?pageNo="+pageNo+"&hotel_ID="+hotel_ID+"&ope_ID="+URLEncoder.encode(ope_ID));
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>
<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKLineInsert" scope="page" class="com.cnbooking.bst.flight.FlightBKLineInsert" />
<%
String ope_ID=request.getParameter("ope_ID");
String fromCity_ID=request.getParameter("fromCity_ID");
String toCity_ID=request.getParameter("toCity_ID");
String takeOff_ID=request.getParameter("takeOff_ID");
String land_ID=request.getParameter("land_ID");
String airline_ID=request.getParameter("airline_ID");
String plane_Type_ID=request.getParameter("plane_Type_ID");

String flightID=request.getParameter("flightID");
String d_Hour=request.getParameter("d_Hour");
String d_Minute=request.getParameter("d_Minute");
String a_Hour=request.getParameter("a_Hour");
String a_Minute=request.getParameter("a_Minute");
String stay=request.getParameter("stay");
String round_Trip_=request.getParameter("round_Trip_");
String seatClass_=request.getParameter("seatClass_");
String weekday_=request.getParameter("weekday_");
String price=request.getParameter("price");
String curr_price=request.getParameter("curr_price");
String currency=request.getParameter("currency");

if((Integer.valueOf(d_Hour)).intValue()<10)
d_Hour="0"+d_Hour;
if((Integer.valueOf(d_Minute)).intValue()<10)
d_Minute="0"+d_Minute;
if((Integer.valueOf(a_Hour)).intValue()<10)
a_Hour="0"+a_Hour;
if((Integer.valueOf(a_Minute)).intValue()<10)
a_Minute="0"+a_Minute;
String takeoff_Time="1970-01-01 "+d_Hour+":"+d_Minute+":00";
String arrival_Time="1970-01-01 "+a_Hour+":"+a_Minute+":00";

String info="";

 FlightBKLineInsert.setOpeID(ope_ID);
 if(fromCity_ID!=null)
 FlightBKLineInsert.setFromCity_ID(fromCity_ID);
 if(toCity_ID!=null)
 FlightBKLineInsert.setToCity_ID(toCity_ID);
 if(takeOff_ID!=null)
 FlightBKLineInsert.setTakeOff_ID(takeOff_ID);
 if(land_ID!=null)
 FlightBKLineInsert.setLand_ID(land_ID);
 if(airline_ID!=null)
 FlightBKLineInsert.setAirLine_ID(airline_ID);
 if(plane_Type_ID!=null)
 FlightBKLineInsert.setPlane_Type(plane_Type_ID);
 if(flightID!=null)
 FlightBKLineInsert.setFlightID(flightID);
 if(stay!=null)
 FlightBKLineInsert.setStay(stay);
 FlightBKLineInsert.setRound_Trip_(round_Trip_);
 FlightBKLineInsert.setSeatClass_(seatClass_);
 FlightBKLineInsert.setWeekday_(weekday_);
 if(price!=null)
 FlightBKLineInsert.setPrice(price);
 if(curr_price!=null)
 FlightBKLineInsert.setCurr_Price(curr_price);
 if(currency!=null)
 FlightBKLineInsert.setCurrency(currency);

 FlightBKLineInsert.setTakeoff_Time(takeoff_Time);
 FlightBKLineInsert.setArrival_Time(arrival_Time);
 
 
 FlightBKLineInsert.setLangCode("GB");

 if(FlightBKLineInsert.InsertFlightLine()){ 
	info += "恭喜,航线添加成功!<br>";
    }
    else{
	info +="很抱歉,航线添加未能成功，请检查数据!";
  }
String title="航线添加";
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
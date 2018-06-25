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
String stay=request.getParameter("stay");
String round_Trip_=request.getParameter("round_Trip_");
String seatClass_=request.getParameter("seatClass_");
String weekday_=request.getParameter("weekday_");
String price=request.getParameter("price");
String curr_price=request.getParameter("curr_price");
String currency=request.getParameter("currency");

String takeoff_Time=request.getParameter("takeoff_Time");
String arrival_Time=request.getParameter("arrival_Time");
String line_Seq=request.getParameter("line_Seq");
String round_Trip=request.getParameter("round_Trip");
String seatClass=request.getParameter("seatClass");
String weekday=request.getParameter("weekday");

takeoff_Time="1970-01-01 "+takeoff_Time;
arrival_Time="1970-01-01 "+arrival_Time;
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
 FlightBKLineInsert.setFlight_Seq(line_Seq);
 FlightBKLineInsert.setRound_Trip(round_Trip);
 FlightBKLineInsert.setSeatClass(seatClass);
 FlightBKLineInsert.setWeekday(weekday);
 
 
 FlightBKLineInsert.setLangCode("GB");

 if(FlightBKLineInsert.UpdateFlightLine()){ 
	info += "恭喜,航线更改成功!<br>";
    }
    else{
	info +="很抱歉,航线更改未能成功，请检查数据!";
  }
String title="航线更改";
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
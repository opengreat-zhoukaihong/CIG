<%@ page import="com.cnbooking.flight.*, java.util.*, java.net.*" %>
<jsp:useBean id="PostNew" scope="page" class="com.cnbooking.flight.PostNew" />
<%
    String info="";
String cust_ID=request.getParameter("cust_id").trim();
String userName = request.getParameter("userName").trim();
String gender = request.getParameter("gender").trim();
String postcode = request.getParameter("postcode").trim();
String address = request.getParameter("address").trim();
String email = request.getParameter("email").trim();
String mobile = request.getParameter("mobile").trim();
String phone = request.getParameter("phone").trim();
String fax = request.getParameter("fax").trim();

PostNew.setGender(gender);
PostNew.setPostCode(postcode);
PostNew.setAddress(address);
PostNew.setEmail(email);
PostNew.setMobile(mobile);
PostNew.setRealName(userName);
PostNew.setPhone(phone);
PostNew.setFax(fax);

    int bookingID=0;
    String ticketAgencyID = request.getParameter("ticketAgencyID").trim();
    String seatClass = request.getParameter("seatClass").trim();
    String d_Year = request.getParameter("d_Year").trim();
    String d_Month = request.getParameter("d_Month").trim();
    String d_Day = request.getParameter("d_Day").trim();
    String flight_ID = request.getParameter("flight_ID").trim();
    String flight_Seq = request.getParameter("flight_Seq");

    String takeoff_Time = request.getParameter("takeoff_Time").trim();
    String curr_Price = request.getParameter("curr_Price").trim();
    String currency= request.getParameter("currency").trim();
    
    String passenger = request.getParameter("passenger").trim();
    String quantity= request.getParameter("quantity").trim();
    if(!(takeoff_Time.length()>0))
    takeoff_Time="10:00:00";
    
    takeoff_Time=d_Year+"-"+d_Month+"-"+d_Day+" "+takeoff_Time;

    String round_Trip = request.getParameter("round_Trip").trim();
    PostNew.setTakeOff_Time(takeoff_Time);
    
    String a_Year = "";
    String a_Month = "";
    String a_Day = "";
    String seatClass_A = "";
    String flight_ID_A = "";
    String takeoff_Time_A = "";
    String curr_Price_A = "";
    String currency_A = "";
    String passenger_A = "";
    String passenger2_A = "";
    String quantity_A= "";
    String flight_Seq_A="";
    
    if(round_Trip.equals("R")){
    a_Year = request.getParameter("a_Year").trim();
    a_Month = request.getParameter("a_Month").trim();
    a_Day = request.getParameter("a_Day").trim();
    seatClass_A = request.getParameter("seatClass_A").trim();
    flight_ID_A = request.getParameter("flight_ID_A").trim();
    takeoff_Time_A = request.getParameter("takeoff_Time_A").trim();
    curr_Price_A = request.getParameter("curr_Price_A").trim();
    currency_A = request.getParameter("currency_A").trim();
    flight_Seq_A = request.getParameter("flight_Seq_A");
    if(!(takeoff_Time_A.length()>0))
    takeoff_Time_A="11:00:00";
    
    takeoff_Time_A=a_Year+"-"+a_Month+"-"+a_Day+" "+takeoff_Time_A;
        
    passenger_A = request.getParameter("passenger_A").trim();
    quantity_A= request.getParameter("quantity_A").trim();
    }
    else{round_Trip="O";}

    PostNew.setFlight_ID(flight_ID);
    PostNew.setLangCode("GB");
    PostNew.setPrice(curr_Price);
    PostNew.setQuantity(quantity);
    
    PostNew.setCurrency(currency);
    PostNew.setRound_Trip(round_Trip);
    PostNew.setCust_ID(cust_ID);
    PostNew.setPassenger(passenger);
    PostNew.setSeatclass(seatClass);
    PostNew.setFlight_Seq(flight_Seq);
    
    if(round_Trip.equals("R")){
    PostNew.setReturn_Time(takeoff_Time_A);
    bookingID=PostNew.gettingBookingID();
    }
        
    if(PostNew.addFlightBooking()){ 
	info += "恭喜,出发预定发布成功!<br>";
    }
    else{
	info +="很抱歉,出发预定未能发布成功，请检查数据!";
    }
    if(round_Trip.equals("R")){
    PostNew.setBookingID(bookingID);
    PostNew.setTakeOff_Time(takeoff_Time_A);
    
    PostNew.setLangCode("GB");
    PostNew.setPrice(curr_Price_A);
    PostNew.setQuantity(quantity_A);
    PostNew.setFlight_ID(flight_ID_A);
    PostNew.setCurrency(currency_A);
    PostNew.setRound_Trip(round_Trip);
    PostNew.setCust_ID(cust_ID);
    PostNew.setPassenger(passenger_A);
    PostNew.setSeatclass(seatClass_A);
    PostNew.setFlight_Seq(flight_Seq_A);
    if(PostNew.addFlightBooking()){ 
	info += "恭喜,飞机回程预定请求成功!<br>";
    }
    else{
	info +="很抱歉,飞机回程预定请求未能发布成功，请检查数据!";
    }
   }
  String title="飞机预定";
  response.sendRedirect("/cnbooking/gb/ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>


<%@ page import="com.cnbooking.flight.*, java.util.*, java.net.*" %>
<%@ page import="com.cig.*" %>
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" /> 
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

PostNew.setGender(Convert.b2g(gender));
PostNew.setPostCode(Convert.b2g(postcode));
PostNew.setAddress(Convert.b2g(address));
PostNew.setEmail(Convert.b2g(email));
PostNew.setMobile(Convert.b2g(mobile));
PostNew.setRealName(Convert.b2g(userName));
PostNew.setPhone(Convert.b2g(phone));
PostNew.setFax(Convert.b2g(fax));

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
    takeoff_Time=Convert.b2g("10:00:00");
    
    takeoff_Time=d_Year+"-"+d_Month+"-"+d_Day+" "+takeoff_Time;

    String round_Trip = request.getParameter("round_Trip").trim();
    PostNew.setTakeOff_Time(Convert.b2g(takeoff_Time));
    
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
    takeoff_Time_A=Convert.b2g("11:00:00");
    
    takeoff_Time_A=a_Year+"-"+a_Month+"-"+a_Day+" "+takeoff_Time_A;
        
    passenger_A = request.getParameter("passenger_A").trim();
    quantity_A= request.getParameter("quantity_A").trim();
    }
    else{round_Trip="O";}

    PostNew.setFlight_ID(Convert.b2g(flight_ID));
    PostNew.setLangCode("GB");
    PostNew.setPrice(Convert.b2g(curr_Price));
    PostNew.setQuantity(Convert.b2g(quantity));
    
    PostNew.setCurrency(Convert.b2g(currency));
    PostNew.setRound_Trip(round_Trip);
    PostNew.setCust_ID(cust_ID);
    PostNew.setPassenger(Convert.b2g(passenger));
    PostNew.setSeatclass(Convert.b2g(seatClass));
    PostNew.setFlight_Seq(Convert.b2g(flight_Seq));
    
    if(round_Trip.equals("R")){
    PostNew.setReturn_Time(Convert.b2g(takeoff_Time_A));
    bookingID=PostNew.gettingBookingID();
    }
        
    if(PostNew.addFlightBooking()){ 
	info += "恭喜,出發預定發布完成!<br>";
    }
    else{
	info +="很抱歉,出發預定未能發布完成，請檢查數据!";
    }
    if(round_Trip.equals("R")){
    PostNew.setBookingID(bookingID);
    PostNew.setTakeOff_Time(Convert.b2g(takeoff_Time_A));
    
    PostNew.setLangCode("GB");
    PostNew.setPrice(Convert.b2g(curr_Price_A));
    PostNew.setQuantity(Convert.b2g(quantity_A));
    PostNew.setFlight_ID(Convert.b2g(flight_ID_A));
    PostNew.setCurrency(Convert.b2g(currency_A));
    PostNew.setRound_Trip(round_Trip);
    PostNew.setCust_ID(cust_ID);
    PostNew.setPassenger(Convert.b2g(passenger_A));
    PostNew.setSeatclass(Convert.b2g(seatClass_A));
    PostNew.setFlight_Seq(Convert.b2g(flight_Seq_A));
    if(PostNew.addFlightBooking()){ 
	info += "恭喜,飛机回程預定請求完成!<br>";
    }
    else{
	info +="很抱歉,飛机回程預定請求未能發布完成，請檢查數据!";
    }
   }
  String title="飛机預定";
  response.sendRedirect("/cnbooking/big/ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>


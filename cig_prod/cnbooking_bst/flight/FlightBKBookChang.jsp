<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="FlightBKBookUpdate" scope="page" class="com.cnbooking.bst.flight.FlightBKBookUpdate" />
<%
String ope_ID=request.getParameter("ope_ID");
String dealID=request.getParameter("dealID");
String dealSeq=request.getParameter("dealSeq");

String info="";
String price=request.getParameter("price");
String contact = request.getParameter("contact");
String cont_PostCode = request.getParameter("cont_PostCode");
String cont_Tel = request.getParameter("cont_Tel");
String cont_Mobile = request.getParameter("cont_Mobile");
String cont_Fax = request.getParameter("cont_Fax");
String cont_Email = request.getParameter("cont_Email");
String cont_Address = request.getParameter("cont_Address");
String cont_Gender = request.getParameter("cont_Gender");
String quantity=request.getParameter("quantity");
String passenger=request.getParameter("passenger");
String seatClass=request.getParameter("seatClass");
String round_Trip=request.getParameter("round_Trip");

 FlightBKBookUpdate.setPassenger(passenger);
 FlightBKBookUpdate.setQuantity(quantity);
 FlightBKBookUpdate.setGender(cont_Gender);
 FlightBKBookUpdate.setAddress(cont_Address);
 FlightBKBookUpdate.setEmail(cont_Email);
 FlightBKBookUpdate.setFax(cont_Fax);
 FlightBKBookUpdate.setMobile(cont_Mobile);
 FlightBKBookUpdate.setTel(cont_Tel);
 FlightBKBookUpdate.setPostCode(cont_PostCode);
 FlightBKBookUpdate.setContact(contact);
 FlightBKBookUpdate.setOpeID(ope_ID);
 FlightBKBookUpdate.setDealID(dealID);
 FlightBKBookUpdate.setDealSeq(dealSeq);
 FlightBKBookUpdate.setSeatClass(seatClass);
 FlightBKBookUpdate.setRound_Trip(round_Trip);
 if((price!=null)&&(price!=""))
 FlightBKBookUpdate.setPrice(price);

 if(FlightBKBookUpdate.UpdateFlightBooking()){ 
	info += "恭喜,预定更改成功!<br>";
    }
    else{
	info +="很抱歉,预定更改未能成功，请检查数据!";
  }
String title="飞机预定";
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

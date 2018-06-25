<%@ page import="com.cnbooking.tour.*, java.util.*, java.net.*" %>
<jsp:useBean id="TourPostNew" scope="page" class="com.cnbooking.tour.TourPostNew" />
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

TourPostNew.setGender(gender);
TourPostNew.setPostCode(postcode);
TourPostNew.setAddress(address);
TourPostNew.setEmail(email);
TourPostNew.setMobile(mobile);
TourPostNew.setRealName(userName);
TourPostNew.setPhone(phone);
TourPostNew.setFax(fax);

    String d_Year = request.getParameter("d_Year").trim();
    String d_Month = request.getParameter("d_Month").trim();
    String d_Day = request.getParameter("d_Day").trim();
    String tour_Line_ID = request.getParameter("tour_Line_ID").trim();

    String curr_Price = request.getParameter("curr_Price").trim();
    String currency= request.getParameter("currency").trim();
    
    String quantity= request.getParameter("quantity").trim();


    
    String bgn_Time="08:00:00";
    
    bgn_Time=d_Year+"-"+d_Month+"-"+d_Day+" "+bgn_Time;


    TourPostNew.setBgn_Time(bgn_Time);
    
    

    TourPostNew.setTour_Line_ID(tour_Line_ID);
    TourPostNew.setLangCode("EN");
    TourPostNew.setPrice(curr_Price);
    TourPostNew.setQuantity(quantity);
    
    TourPostNew.setCurrency(currency);
    TourPostNew.setCust_ID(cust_ID);
    TourPostNew.setPassenger(userName);
 
    
       
    if(TourPostNew.addTourBooking()){ 
	info += "Congratulations!,tour booking successfully!<br>";
    }
    else{
	info +="Sorry,tour booking failed, please check !";
    }
 
 String title="booking";
 response.sendRedirect("/cnbooking/en/ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>
<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

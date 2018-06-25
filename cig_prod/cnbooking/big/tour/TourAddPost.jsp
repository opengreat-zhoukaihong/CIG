<%@ page import="com.cnbooking.tour.*, java.util.*, java.net.*" %>
<%@ page import="com.cig.*" %>
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" /> 
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

TourPostNew.setGender(Convert.b2g(gender));
TourPostNew.setPostCode(Convert.b2g(postcode));
TourPostNew.setAddress(Convert.b2g(address));
TourPostNew.setEmail(Convert.b2g(email));
TourPostNew.setMobile(Convert.b2g(mobile));
TourPostNew.setRealName(Convert.b2g(userName));
TourPostNew.setPhone(Convert.b2g(phone));
TourPostNew.setFax(Convert.b2g(fax));

    String d_Year = request.getParameter("d_Year").trim();
    String d_Month = request.getParameter("d_Month").trim();
    String d_Day = request.getParameter("d_Day").trim();
    String tour_Line_ID = request.getParameter("tour_Line_ID").trim();

    String curr_Price = request.getParameter("curr_Price");
    String currency= request.getParameter("currency").trim();
    
    String quantity= request.getParameter("quantity").trim();


    
    String bgn_Time="08:00:00";
    
    bgn_Time=d_Year+"-"+d_Month+"-"+d_Day+" "+bgn_Time;


    TourPostNew.setBgn_Time(bgn_Time);
    
    

    TourPostNew.setTour_Line_ID(tour_Line_ID);
    TourPostNew.setLangCode("GB");
    TourPostNew.setPrice(curr_Price);
    TourPostNew.setQuantity(Convert.b2g(quantity));
    
    TourPostNew.setCurrency(Convert.b2g(currency));
    TourPostNew.setCust_ID(cust_ID);
    TourPostNew.setPassenger(Convert.b2g(userName));
 
    
       
    if(TourPostNew.addTourBooking()){ 
	info += "尺,村箇﹚祇ガЧΘ!<br>";
    }
    else{
	info +="╆簆,村箇﹚ゼ祇ガЧΘ叫浪琩计誹!";
    }
 
 String title="村箇﹚";
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

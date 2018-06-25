<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="TourBKBookUpdate" scope="page" class="com.cnbooking.bst.tour.TourBKBookUpdate" />
<%
String ope_ID=request.getParameter("ope_ID");
String book_ID=request.getParameter("book_ID");
String line_ID=request.getParameter("line_ID");

String info="";
String price=request.getParameter("price");
String contact = request.getParameter("contact");
String cont_PostCode = request.getParameter("cont_PostCode");
String cont_Tel = request.getParameter("cont_Tel");
String cont_Mobile = request.getParameter("cont_Mobile");
String cont_Fax = request.getParameter("cont_Fax");
String cont_Email = request.getParameter("cont_Email");
String cont_Address1 = request.getParameter("cont_Address1");
String cont_Address2 = request.getParameter("cont_Address2");
String cont_Gender = request.getParameter("cont_Gender");
String quantity=request.getParameter("quantity");
String passenger=request.getParameter("passenger");


 TourBKBookUpdate.setPassenger(passenger);
 TourBKBookUpdate.setQuantity(quantity);
 TourBKBookUpdate.setGender(cont_Gender);
 TourBKBookUpdate.setAddress1(cont_Address1);
 TourBKBookUpdate.setAddress2(cont_Address2);
 TourBKBookUpdate.setEmail(cont_Email);
 TourBKBookUpdate.setFax(cont_Fax);
 TourBKBookUpdate.setMobile(cont_Mobile);
 TourBKBookUpdate.setTel(cont_Tel);
 TourBKBookUpdate.setPostCode(cont_PostCode);
 TourBKBookUpdate.setContact(contact);
 TourBKBookUpdate.setOpeID(ope_ID);
 TourBKBookUpdate.setBook_ID(book_ID);
 TourBKBookUpdate.setLine_ID(line_ID);
 if((price!=null)&&(price!=""))
 TourBKBookUpdate.setPrice(price);

 if(TourBKBookUpdate.UpdateTourBooking()){ 
	info += "恭喜,预定更改成功!<br>";
    }
    else{
	info +="很抱歉,预定更改未能成功，请检查数据!";
  }
String title="城市旅游预定";
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

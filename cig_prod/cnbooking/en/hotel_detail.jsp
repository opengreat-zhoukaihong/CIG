 
<html>
<!-- #BeginTemplate "/Templates/main_gb.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" -->
<title>Specialist of hotelbooking in Mainland China, Hong Kong and Macao</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
 input {font-family: "Verdana"; font-size: 12px ;color:#666666}
 select {font-family: "Verdana"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: Verdana}
 A:visited {text-decoration: none; color: #715922; font-family: Verdana}
 A:active {text-decoration: none; font-family: Verdana}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "Verdana", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "Verdana"; font-size: 12px}
-->
</style>
</head>

<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.hotel.*" %> 

<jsp:useBean id="HotelDetail" scope="page" class="com.cnbooking.hotel.HotelDetail" /> 
<jsp:setProperty name="HotelDetail" property="langCode" value="EN"/> 
<jsp:setProperty name="HotelDetail" property="hotelId"/> 


<%
    int price_count = 0;
    String[][] price;
    

    
    HotelDetail.getHotelDetail();
    
    String hotelId=request.getParameter("hotelId");
    price_count = HotelDetail.getPriceCount();
    price = HotelDetail.getPrice();
    
    String hotelName = HotelDetail.getHotelName();
    String starRating = HotelDetail.getStarRating();
    String starImageFile = HotelDetail.getStarImageFile();
    String fullDesc = HotelDetail.getFullDesc();
    String facilityDrink = HotelDetail.getFacilityDrink();
    String facilityEnt = HotelDetail.getFacilityEnt();
    String facilityServ = HotelDetail.getFacilityServ();
    String address = HotelDetail.getAddress();
    String city = HotelDetail.getCity();
    String state = HotelDetail.getState();
    String location = HotelDetail.getLocation();
    String postCode = HotelDetail.getPostCode();
    String telephone = HotelDetail.getTelephone();
    String fax = HotelDetail.getFax();
    String url = HotelDetail.getUrl();
    String imageDir = HotelDetail.getImageDir();
    String image1 = HotelDetail.getImage1();
    String image2 = HotelDetail.getImage2();
    String image3 = HotelDetail.getImage3();
    String mapDir = HotelDetail.getMapDir();
    String mapFile = HotelDetail.getMapFile();        
    
        
%> 

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language="JavaScript" src="../../javascript/en/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr> 
    <td width="664" height="34"> 
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr> 
          <td width="30" background="../../images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/en/index.jsp"><img src="../../images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="../../images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;Hotel Information</font><!-- #EndEditable --></td>
          <td width="415" background="../../images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="../../images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> <br>
      <table border=0 width=600 cellpadding=0 cellspacing=0 align=CENTER>
        <tr valign=top> 
          <td width=115 align="center">
            <% if (!image1.equals("")){%> 
            <table width="0" border="0" cellspacing="0" cellpadding="0" height="70">
              <tr> 
                <td></td>
              </tr>
            </table>
            <img width="140" src="<%=imageDir%><%=image1%>" > 
            <%}%>
            <% if (!image2.equals("")){%> 
            <table width="0" border="0" cellspacing="0" cellpadding="0" height="2">
              <tr> 
                <td></td>
              </tr>
            </table>
            <img width="140" src="<%=imageDir%><%=image2%>" > 
            <%}%>
            <% if (!image3.equals("")){%> 
            <table width="0" border="0" cellspacing="0" cellpadding="0" height="2">
              <tr> 
                <td></td>
              </tr>
            </table>
            <img width="140" src="<%=imageDir%><%=image3%>" > 
            <%}%>            
          </td>
          <td width="4"><img src="../../images/space.gif" width="4" height="1" border="0"></td>
          <td width="1" bgcolor="#999999"><img src="../../images/space.gif" width="1" height="1" border="0"></td>
          <td width="5"><img src="../../images/space.gif" width="5" height="1" border="0"></td>
          <td width=500><br>
            <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
              <tr align="center" bgcolor="#CFC8CF"> 
                <td height="3"><img src="../../images/space.gif" width="1" height="3"></td>
              </tr>
              <tr align="center"> 
                <td><span class="bigtxt"><font color="#000000"><%=hotelName%></font></span><font color="#000000"><br>
                  <font face="Verdana, Arial, Helvetica, sans-serif">
                  <% 
                     int wid=11;
            	     String width="";
            	     wid = 11 * (Integer.valueOf(starRating).intValue());
                     width = String.valueOf(wid);
                     if (!starRating.equals("0")){%>
                  <img src="<%=starImageFile%>" width="<%=width%>" height="11"> 
                  <%}%>
                  </font></font></td>
              </tr>
              <tr align="center"> 
                <td bgcolor="#CFC8CF" height="3"><img src="../../images/space.gif" width="1" height="3"></td>
              </tr>
            </table>
            <br>
            <table border="0" width="100%" cellpadding="0" cellspacing="0">
              <tr> 
                <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp;<%=fullDesc%><br>
                  <br>
                  <b><font color="#000000">Facilities</font></b><font color="#000000">: </font><br>
                  &nbsp; 
                  <table width="450" border="0" cellspacing="0" cellpadding="2">
                    <tr> 
                      <td width="72" valign="top">Food &amp; beverages: </td>
                      <td width="378"><%=facilityDrink%></td>
                    </tr>
                    <tr> 
                      <td width="72" valign="top">Leisures: </td>
                      <td width="378"><%=facilityEnt%></td>
                    </tr>
                    <tr> 
                      <td width="72" valign="top">Services: </td>
                      <td width="378"><%=facilityServ%></td>
                    </tr>
                  </table>
                  <br>
                  <br>
                  <font color="#000000"><b>Rate</b></font>: <br>
                  <table width="500" border="0" cellspacing="2" cellpadding="0">
                    <tr> 
                      <td colspan="2"> 
                        <table width="500" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#CCCCCC" bordercolordark="#FFFFFF">
                          <tr> 
                            <td height="26" width="60"> 
                              <div align="center"><font color="#666666">Room Type</font></div>
                            </td>
                            <td height="26" width="50"> 
                              <div align="center"><font color="#666666">With Breakfast</font></div>
                            </td>
                            <td height="26" width="110"> 
                              <div align="center"><font color="#666666">Date</font></div>
                            </td>
                            <td height="26" width="50"> 
                              <div align="center"><font color="#666666">Normal</font></div>
                            </td>
                            <td height="26" colspan="2"> 
                              <div align="center"><font color="#666666">Weekend</font></div>
                              </td>
                            <td height="26" width="50"> 
                              <div align="center"><font color="#666666">Holiday</font></div>
                            </td>
                          </tr>
                          <%
                            String str1="",str2="", str3="";
                            String tmp_str1="", tmp_str2="",tmp_str3="";
                            String str="";
                            String break1="",break2="";
                            for (int i=0;i<price_count;i++){
                          %>
                          <tr> 
                            <td height="26" width="60"> 
                              <div align="center"><%=price[i][0]%></div>
                            </td>
                            <td height="26" width="50"> 
                              <div align="center"><%=price[i][1]%></div>
                            </td>
                            <% if (!price[i][7].equals(price[i][8])){%>
                            <td height="26" width="110"> 
                              <div align="center">From <%=price[i][7]%><br>To <%=price[i][8]%></div>
                            </td>
                            <% }else{%>                 
                            <td height="26" width="110"> 
                              <div align="center"><%=price[i][7]%></div>
                            </td>
                            <% }%>                                     
                            <td height="26"> 
                              <div align="center" width="50"><%=price[i][2]%></div>
                            </td>
                            <% if (price[i][3].equals(price[i][2]))
                            	  str1 = "";
                               else 
                               	  str1 = price[i][3];
                               if (price[i][4].equals(price[i][2]))
                               	  str2 = "";
                               else 
                                  str2 = price[i][4];
                               if (price[i][5].equals(price[i][2]))
                            	  str3 = "";
                               else 
                                  str3 = price[i][5];
                               
                               if (!str1.equals("")){
                               	 if (str1.equals(str2) && str1.equals(str3))
                                    str = str1 + "(Fri.- Sun.)";
                                 else if (str1.equals(str2) && !str1.equals(str3)){
	                            str3 = str3.equals("")?"":str3+"(Sun.)";
                               	    str = str1 + "(Fri.- Sat.)" + str3;
                               	    } 
                            	 else if (str1.equals(str3) && !str1.equals(str2)){
                            	    str2 = str2.equals("")?"":str2+"(Sat.)";
                               	    str = str1 + "(Fri./ Sun.)" + str2;
                               	    } 
                               	 else 
                            	    tmp_str1 = str1 + "(Fri.)";
                            	    
                               }
                               if (!str2.equals("")){
                                 if (str2.equals(str3) && !str1.equals(""))
                                    tmp_str2 = str2 + "(Sat.- Sun.)";
                                 else if (str2.equals(str3) && str1.equals(""))
                                    str = str2 + "(Sat.- Sun.)";
                                 else 
                                    tmp_str2 = str2 + "(Sat.)";                              
                               }
                               if (!str3.equals("")){
                               	    tmp_str3 = str3 + "(Sun.)";
                               }
                               break1 = tmp_str1.equals("")?"":"<br>";
                               break2 = tmp_str2.equals("")?"":"<br>";
                               str = str.equals("")?tmp_str1+break1+tmp_str2+break2+tmp_str3:str;
                               str = str.equals("")?"&nbsp;":str;
                               %>
                            <td height="26" colspan="2"> 
                              <div align="center"><%=str%></div>
                              </td>
                            <% if (price[i][6].equals(price[i][2]))  
                            	price[i][6] = "&nbsp;";
                            %>
                            <td height="26" width="50"> 
                              <div align="center"><%=price[i][6]%></div>
                            </td>
                          </tr>
                          <%   str="";
                               str1=""; str2=""; str3="";
                               tmp_str1=""; tmp_str2=""; tmp_str3="";
                            }
                          %>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <br>
                  <a href="HotelBooking.jsp?hotelId=<%=hotelId%>"><img border="0" src="../../images/en/booking.gif" width="138" height="18" align="right"></a><br>
                  <a href="CShowHotelMap.jsp?HotelID=<%=hotelId%>"><b><font color="#000000">Location</font></b></a> 
                  : <%=city%><%=location%>&nbsp;<a href="CShowHotelMap.jsp?HotelID=<%=hotelId%>"><img src="../../images/map.gif" width="20" height="20" border="0"></a> 
                  <p>&nbsp; </p>
            </table>
      </table>
          <br>
          <% if (!telephone.equals("") || !fax.equals("") || !address.equals("")) {%>
          <table border=0 cellspacing=2 cellpadding=2 width="600" >
            <tr align="center"><font color="#666666"> 
              <td> 
                <p class="txt">Tel: <%=telephone%> Fax: <%=fax%><br>
                  Address: <%=address%>
              </td>
            </tr>
          </table>
          <br>
          <%}%>
      <!-- #EndEditable --></td>
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="../../javascript/en/foot.js">
  </script>
</table>
</body>
<!-- #EndTemplate -->
</html>

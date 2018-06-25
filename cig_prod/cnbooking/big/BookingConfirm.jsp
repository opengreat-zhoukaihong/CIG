<%@ page import="java.util.*" %>
<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="quHotel" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="bookInfo" scope="session" class="com.cnbooking.hotel.BookInfo" />

<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" />

<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" />
<% 
  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page = "notAuthorized.jsp" />
	
<%}
%>


<%
quHotel.setConnection(db.getConnection());
sqlProvide.setLangCode("GB");
int rowCount = 0;
String hotelId = request.getParameter("hotelId");
String hotelName = request.getParameter("hotelName");
String custId = UserInfo.getCustId(); 

String cusNotes = request.getParameter("note");
String namePy = request.getParameter("name_py");
String name = request.getParameter("name");
String adult = request.getParameter("adult");
String children = request.getParameter("children");
String payment = request.getParameter("payment");
String tel = request.getParameter("phone0") + request.getParameter("phone1") + request.getParameter("phone");
String fax = request.getParameter("fax0") + request.getParameter("fax1") + request.getParameter("fax0");
String email = request.getParameter("email");
String contact = request.getParameter("linkman");
String inYear = request.getParameter("in_year");
String inMonth = request.getParameter("in_month");
if (inMonth.length() == 1)
 inMonth = "0" + inMonth;
String inDay = request.getParameter("in_day");
if (inDay.length() == 1)
 inDay = "0" + inDay;
String outYear = request.getParameter("out_year");
String outMonth = request.getParameter("out_month");
if (outMonth.length() == 1)
 outMonth = "0" + outMonth;
String outDay = request.getParameter("out_day");
if (outDay.length() == 1)
 outDay = "0" + outDay;
String arrivalDate = inYear + "-" + inMonth + "-" + inDay;
String leaveDate = outYear + "-" + outMonth + "-" + outDay;

bookInfo.setHotelId(hotelId);
bookInfo.setCustId(custId);
bookInfo.setCusNotes(cusNotes);
bookInfo.setName(name);
bookInfo.setNamePy(namePy);
bookInfo.setAdult(adult);
bookInfo.setChildren(children);
bookInfo.setPayment(payment);
bookInfo.setTel(tel);
bookInfo.setFax(fax);
bookInfo.setEmail(email);
bookInfo.setContact(contact);
bookInfo.setArrivalDate(arrivalDate);
bookInfo.setLeaveDate(leaveDate);


sqlProvide.setHotelId(request.getParameter("hotelId"));
quHotel.executeQuery(sqlProvide.getSql("Hotel.Price"));
rowCount = quHotel.rowCount();
%>

<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>ƨ�A�D�s�z�q�s�M�a</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "��@�y"; font-size: 12px ;color:#666666}
 select {font-family: "��@�y"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: ��@�y}
 A:visited {text-decoration: none; color: #715922; font-family: ��@�y}
 A:active {text-decoration: none; font-family: ��@�y}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "��@�y", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "��@�y"; font-size: 12px}
-->
</style>

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">

<script language="JavaScript" src="../../javascript/gb/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="../../images/top_back.gif" height="34" valign="bottom"><a href="javascript:window.history.go(-1)"><img src="../../images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="../../images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;�s���w�w</font><!-- #EndEditable --></td>
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
      <table width="500" border="1" cellpadding="0" cellspacing="0" bordercolor="#FFBC04" align="center">
        <tr align="center"> 
          <td> 
            <table border="0" cellpadding="3" cellspacing="1" width="500">
              <tr> 
                <td colspan="2" height="14"></td>
              </tr>
              <tr bgcolor="#CFC8CF" > 
                <td colspan="2" height="1"></td>
              </tr>
              <tr bgcolor="#CFC8CF"> 
                <td align="center" colspan="2"><strong class="bigtxt">�H�U�O�z���檺�q�ЫH��,���̻{�I</strong></td>
              </tr>
              <tr bgcolor="#CFC8CF"> 
                <td colspan="2" height="1"></td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>�w�q�s��</strong>�G </td>
                <td width="342"><%=Convert.g2b(quHotel.getFieldValue(1,"Hotel_name"))%></td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>�J �� �H</strong>�G </td>
                <td width="342"> <%=name%>�]����W�^ 
                  &nbsp;<%=namePy%>�]��������^ </td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>�J��H��</strong>�G </td>
                <td width="342"> <%=adult%>&nbsp;�Ӧ��H�A&nbsp;<%=children%> 
                  �ӤI��</td>
              </tr>
              <tr> 
                <td colspan="2" height="14"></td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>�J����</strong>�G </td>
                <td width="342"> <%=inYear%> �~ <%=inMonth%> 
                  �� <%=inDay%> ��</td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>�h�Ф��</strong>�G </td>
                <td width="342"> <%=outYear%> �~ <%=outMonth%> �� <%=outDay%> ��</td>
              </tr>
              <tr> 
                <td colspan="2" height="14"></td>
              </tr>
              <tr> 
                <td align="right" height="28" valign="top"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="4"></td>
                    </tr>
                    <tr align="right" valign="top"> 
                      <td><strong>�ȩмЭ�</strong>�G </td>
                    </tr>
                  </table>
                </td>
                <td> 
                  <table border="0" cellpadding="3" cellspacing="0" width="100%">
                    <input type="hidden" name="roomTypeID1" value="1">
                    <input type="hidden" name="roomType1" value="���H�Э��">
                    <input type="hidden" name="roomAmount1" value="2">
                    <input type="hidden" name="price1" value="610">
                    <input type="hidden" name="currency1" value="RMB">
                    <tr> 
                      <td colspan="3"> 
                        <table width="380" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#CCCCCC" bordercolordark="#FFFFFF">
                          <tr> 
                            <td height="26" width="80"> 
                              <div align="center"><font color="#666666">�Ы�</font></div>
                            </td>
                            <td height="26" width="50"> 
                              <div align="center"><font color="#666666">���\</font></div>
                            </td>
                            <td height="26" width="50"> 
                              <div align="center"><font color="#666666">����ɲ</font></div>
                            </td>
                            <td height="26" colspan="2"> 
                              <div align="center"><font color="#666666">�P��ɲ</font></div>
                            </td>
                            <td height="26" width="73"> 
                              <div align="center"><font color="#666666">�ж���</font></div>
                            </td>
                          </tr>
                          <%
                            	
				out.print(quHotel.getMessage());
				String price;
				String price5;
				String price6;
				String price7;
				String currency;
				String bookType;
				String bookQty;
				if (rowCount > 5)
				  rowCount = 5;
				for (int i = 1; i <= rowCount ; i++)
				{
   				  quHotel.setRow(i);
   				  bookType = quHotel.getFieldValue("Room_code") + 
   				  	       "_" + quHotel.getFieldValue("Price_code");
   				  bookQty = request.getParameter(bookType);
   				  if (bookQty != null && !bookQty.equals("0"))
   				  {
   				    bookInfo.addBookQty(bookType, bookQty);
   				    switch (i) 
   				    {
  					case 1: bookInfo.setRoomType1(quHotel.getFieldValue("Room_code"));
  						bookInfo.setPriceType1(quHotel.getFieldValue("Price_code"));
  						bookInfo.setRoomQty1(bookQty);
  						break;
  					       
  					case 2: bookInfo.setRoomType2(quHotel.getFieldValue("Room_code"));
  						bookInfo.setPriceType2(quHotel.getFieldValue("Price_code"));
  						bookInfo.setRoomQty2(bookQty);
  						break;
  						
  					case 3: bookInfo.setRoomType3(quHotel.getFieldValue("Room_code"));
  						bookInfo.setPriceType3(quHotel.getFieldValue("Price_code"));
  						bookInfo.setRoomQty3(bookQty);
  						break;
  						
  					case 4: bookInfo.setRoomType4(quHotel.getFieldValue("Room_code"));
  						bookInfo.setPriceType4(quHotel.getFieldValue("Price_code"));
  						bookInfo.setRoomQty4(bookQty);
  						break;
  						
  					case 5: bookInfo.setRoomType5(quHotel.getFieldValue("Room_code"));
  						bookInfo.setPriceType5(quHotel.getFieldValue("Price_code"));
  						bookInfo.setRoomQty5(bookQty);
  						break;
				    }	
   				    
			
			    %> 
                          <tr> 
                            <td height="26" width="80"> 
                              <div align="center"><%=Convert.g2b(quHotel.getFieldValue("room_type"))%> 
                              </div>
                            </td>
                            <td height="26" width="50"> 
                              <div align="center"><%=Convert.g2b(quHotel.getFieldValue("price_type"))%> 
                              </div>
                            </td>
                            <td height="26" width="50"> 
                              <div align="center"><% 
if (!quHotel.getFieldValue("weekday_price").equals("null"))
  out.print(quHotel.getFieldValue("currency")+
             quHotel.getFieldValue("weekday_price"));
else
  out.print("�йq");
%> </div>
                            </td>
                            <td height="26" colspan="2"> 
                              <div align="center"> <%
                                
                                currency = quHotel.getFieldValue("currency");
                                price = quHotel.getFieldValue("weekday_price");
                                if (price.equals("null"))
                                {
                                  price = "�йq";
                                  currency = "";
                                }
                                price5 = quHotel.getFieldValue("week5_price");
                                price6 = quHotel.getFieldValue("week6_price");
                                price7 = quHotel.getFieldValue("week7_price");
                                if ((price5.equals("null")) && (price6.equals("null")) && (price7.equals("null")))
                                  out.println(currency + price);
                                else 
                                {
                                   if ((!price5.equals("null")) && (!price6.equals("null")) && (!price7.equals("null")))
                                   {
                                      out.println(currency + price5 + "  �P��<br>" + 
                                      		  currency + price6 + "  �P��<br>" +
                                      		  currency + price7 + "  �P��<br>" );
                                   }
                                   else
                                   {
                                     if ((!price5.equals("null")) && (!price6.equals("null")))
                                     {
                                       out.println(currency + price5 + "  �P��<br>" + 
                                      		   currency + price6 + "  �P��<br>");
                                     }
                                     else if ((!price6.equals("null")) && (!price7.equals("null")))
                                     {
                                       out.println(currency + price6 + "  �P��<br>" +
                                      		   currency + price7 + "  �P��<br>" );
                                     }
                                     else if ((!price5.equals("null")) && (!price7.equals("null")))
                                     {
                                       out.println(currency + price5 + "  �P��<br>" + 
                                                   currency + price7 + "  �P��<br>" );
                                     }
                                     else if ((!price5.equals("null")) && (price6.equals("null")) && (price7.equals("null")))
                                     {
                                       out.println(currency + price5 + "  �P��");
                                     }
                                     else if ((price5.equals("null")) && (!price6.equals("null")) && (price7.equals("null")))
                                     {
                                     	out.println(currency + price6 + "  �P��");
                                     }
                                     else if ((price5.equals("null")) && (price6.equals("null")) && (!price7.equals("null")))
                                     {
                                        out.println(currency + price7 + "  �P��");
                                     }
                                   }
                                }
                                
                                
                                %></div>
                            </td>
                            <td height="26" width="73"> 
                              <div align="center"> <%=bookQty%>��</div>
                            </td>
                          </tr>
                          <%    
                          	}
                             }
                            %> 
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>����覡</strong>�G </td>
                <td width="342"><%if (payment.equals("M"))
                                    out.print("�{����I");
                                  else
                                    out.print("�I�W��I");%></td>
              </tr>
              <tr> 
                <td valign="top" align="right" width="141" ><strong>�d&nbsp;&nbsp;&nbsp;&nbsp;��</strong>�G 
                </td>
                <td width="342" valign="top"><%=cusNotes%></td>
              </tr>
              <tr> 
                <td colspan="2" height="14"></td>
              </tr>
              <tr bgcolor="#CFC8CF"> 
                <td colspan="2" height="1"></td>
              </tr>
              <tr bgcolor="#CFC8CF"> 
                <td height="20" colspan="2" align="center"><strong class="bigtxt">�H�U�O�z���p�t�H��</strong></td>
              </tr>
              <tr bgcolor="#CFC8CF"> 
                <td colspan="2" height="1"></td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>�p �t �H</strong>�G </td>
                <td width="342"><%=contact%></td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>�q�l�l��</strong>�G </td>
                <td width="342"><%=email%></td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>�q&nbsp;&nbsp;&nbsp;&nbsp;��</strong>�G 
                </td>
                <td width="342"><%=tel%></td>
              </tr>
              <tr> 
                <td align="right" width="141"><strong>��&nbsp;&nbsp;&nbsp;&nbsp;�u</strong>�G</td>
                <td width="342"><%=fax%></td>
              </tr>
            </table>
            <table width="80%" border="0" cellspacing="0" cellpadding="10">
              <tr align="center"> 
                <td class="bigtxt"><strong>���̻{�H�W�z�Ҷ�g���H���O�_���̵L�~�I</strong></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
      <form method="post" action="BookResult.jsp">
      <table width="300" align="center">
        <tr align="center"> 
          <td> 
            <input align=middle border=0 name=enter src="../../images/gb/order_confirm.gif" type=image width="138" height="18">
          </td>
          <td><a href="javascript:window.history.go(-1)"><img src="/images/gb/cancel.gif" width="138" height="18" border="0"></a></td>
        </tr>
      </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
  <tr>
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3" height="2" bgcolor="#FFCC00"><img src="../../images/space.gif" width="500" height="2" align="middle"></td>
  </tr>
  <tr valign="middle" align="center"> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="../../javascript/gb/foot.js">
  </script>
</table>

</body>
<!-- #EndTemplate --></html>
<%db.closeConection();%>

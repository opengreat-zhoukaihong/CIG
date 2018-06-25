<%@ page import="java.util.*" %>
<%
String hotelId = request.getParameter("hotelId");
String currentPage="HotelBooking.jsp?hotelId=" + hotelId;
%>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" />
<% UserInfo.setCurrentPage(currentPage);
  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%}
%>
<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="quHotel" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" /> 
<%
quHotel.setConnection(db.getConnection());
sqlProvide.setLangCode("GB");
int rowCount = 0;
sqlProvide.setHotelId(hotelId);
quHotel.executeQuery(sqlProvide.getSql("Hotel.Price"));
rowCount = quHotel.rowCount();


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

<script languange="javascript">
<!-- Hide from old browsers


function validNumber(number)
{
	if(number == "")
	{
		return false
	}

	allZero = true
	for(i = 0; i < number.length; i++)
	{
		if(number.charAt(i) < "0")
		{
			return false
		}

		if(number.charAt(i) > "9")
		{
			return false
		}

		if(allZero)
		{
			if(number.charAt(i) != "0")
			{
				allZero = false
			}
		}
	}

	if(allZero)
	{
		return false
	}
	
	return true
}

function submitIt(form)
{       
        /*for (j=0;j<form.elements.length;++j)
   	{ 
       
          if (form.elements[j].type == "select-one")
          {
      	     if (fmList.elements[j].value == "0")
             {
                alert("�z������g�q�мƶq�I")
                return false;
             }
          }
        }*/
	
	
	if(form.name.value == "")
	{
		alert("�z������g�J��H�m�W�I")
		return false
	}

	if(form.name_py.value == "")
	{
		alert("�z������g�J��H�m�W����������I")
		return false
	}

	if((!validNumber(form.adult.value)) && (!validNumber(form.children.value)))
	{
		alert("�z������g�J��H�ơI")
		return false
	}

	/*choiceMonth	= form.in_month.selectedIndex
	choiceDay 	= form.in_day.selectedIndex
	choiceYear 	= form.in_year.selectedIndex

	startDate = new Date(choiceYear + 2000, choiceMonth, choiceDay + 1)

	choiceMonth	= form.out_month.selectedIndex
	choiceDay 	= form.out_day.selectedIndex
	choiceYear 	= form.out_year.selectedIndex

	endDate = new Date(choiceYear + 2000, choiceMonth, choiceDay + 1)

	if(startDate.getTime() < (now.getTime() - 86400 * 1000))
	{
		alert("�z�u��w�w ���� �H�Z���ж��I")
		return false
	}
	
	if((startDate.getTime() + 86400 * 1000) > endDate.getTime())
	{
		alert("�h�Ф������e�_�J�����I")
		return false		
	}

	*/
        
        



	if(form.linkman.value == "")
	{
		alert("�z������J�p�t�H�m�W�I")
		return false
	}
 
	if(form.phone.value == "")
	{
		alert("�z������J�q�ܸ��X�I")
		return false
	}
 
	return true
}

// end hiding script -->
</script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">

<table width="663" border="0" cellspacing="0" cellpadding="0" height="60" align="center">
  <tr>
    <td width="194" height="60"><img src="../../images/logo.gif" width="190" height="60"></td>
    <td width="469" height="60"><a href="http://www.cnbooking.com" target="_blank"><img src="../../images/gb/banner.gif" width="468" height="60" border="0"></a></td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="../../images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/gb/index.jsp"><img src="../../images/home.gif" width="14" height="14" align="right" border="0"></a></td>
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
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --><br>
      <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
        <tr align="center" bgcolor="#CFC8CF"> 
          <td height="3"><img src="../../images/space.gif" width="1" height="3"></td>
        </tr>
        <tr align="center"> 
          <td><span class="bigtxt"><font color="#000000"><%=Convert.g2b(quHotel.getFieldValue(1,"Hotel_name"))%></font></span><font color="#000000"> 
            </font></td>
          <input type="hidden" name="HotelID" value="20">
       
        </tr>
        <tr align="center"> 
          <td bgcolor="#CFC8CF" height="3"><img src="/chinese/images/space.gif" width="1" height="3"></td>
        </tr>
      </table>
      <br>
      <form name="frmBook" onSubmit="return submitIt(this)" action="BookingConfirm.jsp?hotelId=<%=hotelId%>" method="POST">
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
                  <td align="center" colspan="2"><strong class="bigtxt">�J �� �H 
                    ��</strong></td>
                </tr>
                <tr bgcolor="#CFC8CF"> 
                  <td colspan="2" height="1"></td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>�J �� �H</strong>�G </td>
                  <td width="342"> 
                    <input type="text" name="name" size="10">
                    �]����W�^ 
                    <input type="text" name="name_py" size="10">
                    �]��������^ </td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>�J��H��</strong>�G </td>
                  <td width="342"> 
                    <input maxlength="2" name="adult" class="small" id="Number" size="3" value="1">
                    &nbsp;�Ӧ��H�A&nbsp; 
                    <input maxlength="2" name="children" class="small" id="Number" size="3">
                    �ӤI��</td>
                </tr>
                <tr> 
                  <td colspan="2" height="14"></td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>�J����</strong>�G </td>
                  <td width="342"> 
                    <select name=in_year size=1>
                      <option value="2000" selected>2000</option>
                      <option value="2001">2001</option>
                      <option value="2002">2002</option>
                    </select>
                    �~<img src="/chinese/images/space.gif" width="22" height="1"> 
                    <select name=in_month size=1>
                      <option value="1">1 </option>
                      <option value="2">2 </option>
                      <option value="3">3 </option>
                      <option value="4">4 </option>
                      <option value="5">5 </option>
                      <option value="6" selected>6 </option>
                      <option value="7">7 </option>
                      <option value="8">8 </option>
                      <option value="9">9 </option>
                      <option value="10">10 </option>
                      <option value="11">11 </option>
                      <option value="12">12</option>
                    </select>
                    ��<img src="/chinese/images/space.gif" width="10" height="1"> 
                    <select name=in_day size=1>
                      <option value="1" selected>1 </option>
                      <option value="2">2 </option>
                      <option value="3">3 </option>
                      <option value="4">4 </option>
                      <option value="5">5 </option>
                      <option value="6">6 </option>
                      <option value="7">7 </option>
                      <option value="8">8 </option>
                      <option value="9">9 </option>
                      <option value="10">10 </option>
                      <option value="11">11 </option>
                      <option value="12">12 </option>
                      <option value="13">13 </option>
                      <option value="14">14 </option>
                      <option value="15">15 </option>
                      <option value="16">16 </option>
                      <option value="17">17 </option>
                      <option value="18">18 </option>
                      <option value="19">19 </option>
                      <option value="20">20 </option>
                      <option value="21">21 </option>
                      <option value="22">22 </option>
                      <option value="23">23 </option>
                      <option value="24">24 </option>
                      <option value="25">25 </option>
                      <option value="26">26 </option>
                      <option value="27">27 </option>
                      <option value="28">28 </option>
                      <option value="29">29 </option>
                      <option value="30">30 </option>
                      <option value="31">31</option>
                    </select>
                    ��
                    <input type="hidden" name="hotelName">
                    <input type="hidden" name="custId">
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>�h�Ф��</strong>�G </td>
                  <td width="342"> 
                    <select name=out_year size=1>
                      <option value="2000" selected>2000</option>
                      <option value="2001">2001</option>
                      <option value="2002">2002</option>
                    </select>
                    �~<img src="/chinese/images/space.gif" width="22" height="1"> 
                    <select name=out_month size=1>
                      <option value="1">1 </option>
                      <option value="2">2 </option>
                      <option value="3">3 </option>
                      <option value="4">4 </option>
                      <option value="5">5 </option>
                      <option value="6" selected>6 </option>
                      <option value="7">7 </option>
                      <option value="8">8 </option>
                      <option value="9">9 </option>
                      <option value="10">10 </option>
                      <option value="11">11 </option>
                      <option value="12">12</option>
                    </select>
                    ��<img src="/chinese/images/space.gif" width="10" height="1"> 
                    <select name=out_day size=1>
                      <option value="1">1 </option>
                      <option value="2" selected>2 </option>
                      <option value="3">3 </option>
                      <option value="4">4 </option>
                      <option value="5">5 </option>
                      <option value="6">6 </option>
                      <option value="7">7 </option>
                      <option value="8">8 </option>
                      <option value="9">9 </option>
                      <option value="10">10 </option>
                      <option value="11">11 </option>
                      <option value="12">12 </option>
                      <option value="13">13 </option>
                      <option value="14">14 </option>
                      <option value="15">15 </option>
                      <option value="16">16 </option>
                      <option value="17">17 </option>
                      <option value="18">18 </option>
                      <option value="19">19 </option>
                      <option value="20">20 </option>
                      <option value="21">21 </option>
                      <option value="22">22 </option>
                      <option value="23">23 </option>
                      <option value="24">24 </option>
                      <option value="25">25 </option>
                      <option value="26">26 </option>
                      <option value="27">27 </option>
                      <option value="28">28 </option>
                      <option value="29">29 </option>
                      <option value="30">30 </option>
                      <option value="31">31</option>
                    </select>
                    ��</td>
                </tr>
                <tr> 
                  <td colspan="2" height="10"></td>
                </tr>
                <tr> 
                  <td align="right" valign="top" rowspan="2" height="28"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr valign="top" align="right"> 
                        <td height="4"></td>
                      </tr>
                      <tr valign="top" align="right"> 
                        <td><strong>�ȩмЭ�</strong>�G </td>
                      </tr>
                    </table>
                  </td>
                  <td rowspan="2" valign="top"> 
                    <table width="400" border="0" cellspacing="2" cellpadding="0">
                      <tr> 
                        <td colspan="2"> 
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
				for (int i = 1; i <= rowCount ; i++)
				{
   				  quHotel.setRow(i);
			
			    %>
                            <tr> 
                              <td height="26" width="80"> 
                                <div align="center"><%=Convert.g2b(quHotel.getFieldValue("room_type"))%> </div>
                              </td>
                              <td height="26" width="50"> 
                                <div align="center"><%=Convert.g2b(quHotel.getFieldValue("price_type"))%> </div>
                              </td>
                              <td height="26" width="50"> 
                                <div align="center"><%
if (!quHotel.getFieldValue("weekday_price").equals("null"))
  out.print(quHotel.getFieldValue("currency") + quHotel.getFieldValue("weekday_price"));
else
  out.print("�йq");
%> </div>
                              </td>
                              <td height="26" colspan="2"> 
                                <div align="center">
                                <%
                                
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
                                <div align="center"> 
                                  <select name="<%=quHotel.getFieldValue("Room_code") + "_" + 
                                                   quHotel.getFieldValue("Price_code")%>">
                                    <option>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                    <option>6</option>
                                    <option>7</option>
                                    <option>8</option>
                                    <option>9</option>
                                    <option>10</option>
                                    <option>11</option>
                                    <option>12</option>
                                    <option>13</option>
                                    <option>14</option>
                                    <option>15</option>
                                    <option>16</option>
                                    <option>17</option>
                                    <option>18</option>
                                    <option>19</option>
                                    <option>20</option>
                                    <option>21</option>
                                    <option>22</option>
                                    <option>23</option>
                                    <option>24</option>
                                    <option>25</option>
                                    <option>26</option>
                                    <option>27</option>
                                    <option>28</option>
                                    <option>29</option>
                                    <option>30</option>
                                  </select>
                                  ��</div>
                              </td>
                            </tr>
                            <%
                             }
                            %>
                            
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> </tr>
                <tr> 
                  <td align="right" width="141"><strong>����覡</strong>�G </td>
                  <td width="342"> 
                    <input type="radio" name="payment" value="M" checked>
                    �{����I &nbsp;&nbsp; 
                    <input type="radio" name="payment" value="N">
                    �I�W��I </td>
                </tr>
                <tr> 
                  <td valign="top" align="right" width="141" ><strong>�d&nbsp;&nbsp;&nbsp;&nbsp;��</strong>�G 
                  </td>
                  <td width="342" valign="top"> 
                    <textarea name="note" cols="40" rows="5"></textarea>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" height="14"></td>
                </tr>
                <tr bgcolor="#CFC8CF"> 
                  <td colspan="2" height="1"></td>
                </tr>
                <tr bgcolor="#CFC8CF"> 
                  <td height="20" colspan="2" align="center"><strong class="bigtxt">�p 
                    �t �H ��</strong></td>
                </tr>
                <tr bgcolor="#CFC8CF"> 
                  <td colspan="2" height="1"></td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>�p �t �H</strong>�G </td>
                  <td width="342" valign="top"> 
                    <input type="text" name="linkman" size="20" maxlength="50">
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>�q�l�l��</strong>�G </td>
                  <td width="342" valign="top"> 
                    <input type="text" name="email" size="30" maxlength="100">
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>�q&nbsp;&nbsp;&nbsp;&nbsp;��</strong>�G 
                  </td>
                  <td width="342"> 
                    <input type="text" name="phone0" size="5">
                    �]��a�N�X�^ 
                    <input type="text" name="phone1" size="5">
                    �]�a�ϥN�X�^</td>
                </tr>
                <tr> 
                  <td align="right" width="141">&nbsp;</td>
                  <td width="342"> 
                    <input type="text" name="phone" size="15">
                    (�榡�G0086-755-2208051)</td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>��&nbsp;&nbsp;&nbsp;&nbsp;�u</strong>�G 
                  </td>
                  <td width="342"> 
                    <input type="text" name="fax0" size="5">
                    �]��a�N�X�^ 
                    <input type="text" name="fax1" size="5">
                    �]�a�ϥN�X�^ </td>
                </tr>
                <tr> 
                  <td align="right" width="141" rowspan="2">&nbsp;</td>
                  <td width="342"> 
                    <input type="text" name="fax" size="15">
                    (�榡�G0086-755-2208051)</td>
                </tr>
                <tr> 
                  <td width="342">&nbsp;</td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      
      <br>
      <table width="300" align="center">
        <tr align="center"> 
          <td> 
            <input align=middle border=0 name=enter src="../../images/gb/sent.gif" type=image width="138" height="18">
          </td>
          <td><a href="index.html"><img src="../../images/gb/cancel.gif" width="138" height="18" border="0"></a></td>
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
  <script language="JavaScript" src="../../javascript/en/foot.js">
  </script>
</table>

</body>
<!-- #EndTemplate --></html>
<%db.closeConection();%>

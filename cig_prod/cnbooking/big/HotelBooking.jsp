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
<title>い翠澳酒┌訂┬專家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "燦　砰"; font-size: 12px ;color:#666666}
 select {font-family: "燦　砰"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 燦　砰}
 A:visited {text-decoration: none; color: #715922; font-family: 燦　砰}
 A:active {text-decoration: none; font-family: 燦　砰}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "燦　砰", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "燦　砰"; font-size: 12px}
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
                alert("您必須填寫訂房數量！")
                return false;
             }
          }
        }*/
	
	
	if(form.name.value == "")
	{
		alert("您必須填寫入住人姓名！")
		return false
	}

	if(form.name_py.value == "")
	{
		alert("您必須填寫入住人姓名的中文拼音！")
		return false
	}

	if((!validNumber(form.adult.value)) && (!validNumber(form.children.value)))
	{
		alert("您必須填寫入住人數！")
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
		alert("您只能預定 今天 以后的房間！")
		return false
	}
	
	if((startDate.getTime() + 86400 * 1000) > endDate.getTime())
	{
		alert("退房日期不能前于入住日期！")
		return false		
	}

	*/
        
        



	if(form.linkman.value == "")
	{
		alert("您必須填入聯系人姓名！")
		return false
	}
 
	if(form.phone.value == "")
	{
		alert("您必須填入電話號碼！")
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
          <td width="200" background="../../images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;酒店預定</font><!-- #EndEditable --></td>
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
                  <td align="center" colspan="2"><strong class="bigtxt">入 住 信 
                    息</strong></td>
                </tr>
                <tr bgcolor="#CFC8CF"> 
                  <td colspan="2" height="1"></td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>入 住 人</strong>： </td>
                  <td width="342"> 
                    <input type="text" name="name" size="10">
                    （中文名） 
                    <input type="text" name="name_py" size="10">
                    （中文拼音） </td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>入住人數</strong>： </td>
                  <td width="342"> 
                    <input maxlength="2" name="adult" class="small" id="Number" size="3" value="1">
                    &nbsp;個成人，&nbsp; 
                    <input maxlength="2" name="children" class="small" id="Number" size="3">
                    個儿童</td>
                </tr>
                <tr> 
                  <td colspan="2" height="14"></td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>入住日期</strong>： </td>
                  <td width="342"> 
                    <select name=in_year size=1>
                      <option value="2000" selected>2000</option>
                      <option value="2001">2001</option>
                      <option value="2002">2002</option>
                    </select>
                    年<img src="/chinese/images/space.gif" width="22" height="1"> 
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
                    月<img src="/chinese/images/space.gif" width="10" height="1"> 
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
                    日
                    <input type="hidden" name="hotelName">
                    <input type="hidden" name="custId">
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>退房日期</strong>： </td>
                  <td width="342"> 
                    <select name=out_year size=1>
                      <option value="2000" selected>2000</option>
                      <option value="2001">2001</option>
                      <option value="2002">2002</option>
                    </select>
                    年<img src="/chinese/images/space.gif" width="22" height="1"> 
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
                    月<img src="/chinese/images/space.gif" width="10" height="1"> 
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
                    日</td>
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
                        <td><strong>客房標准</strong>： </td>
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
                                <div align="center"><font color="#666666">房型</font></div>
                              </td>
                              <td height="26" width="50"> 
                                <div align="center"><font color="#666666">早餐</font></div>
                              </td>
                              <td height="26" width="50"> 
                                <div align="center"><font color="#666666">平日价</font></div>
                              </td>
                              <td height="26" colspan="2"> 
                                <div align="center"><font color="#666666">周末价</font></div>
                              </td>
                              <td height="26" width="73"> 
                                <div align="center"><font color="#666666">房間數</font></div>
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
  out.print("請電");
%> </div>
                              </td>
                              <td height="26" colspan="2"> 
                                <div align="center">
                                <%
                                
                                currency = quHotel.getFieldValue("currency");
                                price = quHotel.getFieldValue("weekday_price");
                                if (price.equals("null"))
                                {
                                  price = "請電";
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
                                      out.println(currency + price5 + "  周五<br>" + 
                                      		  currency + price6 + "  周六<br>" +
                                      		  currency + price7 + "  周日<br>" );
                                   }
                                   else
                                   {
                                     if ((!price5.equals("null")) && (!price6.equals("null")))
                                     {
                                       out.println(currency + price5 + "  周五<br>" + 
                                      		   currency + price6 + "  周六<br>");
                                     }
                                     else if ((!price6.equals("null")) && (!price7.equals("null")))
                                     {
                                       out.println(currency + price6 + "  周六<br>" +
                                      		   currency + price7 + "  周日<br>" );
                                     }
                                     else if ((!price5.equals("null")) && (!price7.equals("null")))
                                     {
                                       out.println(currency + price5 + "  周五<br>" + 
                                                   currency + price7 + "  周日<br>" );
                                     }
                                     else if ((!price5.equals("null")) && (price6.equals("null")) && (price7.equals("null")))
                                     {
                                       out.println(currency + price5 + "  周五");
                                     }
                                     else if ((price5.equals("null")) && (!price6.equals("null")) && (price7.equals("null")))
                                     {
                                     	out.println(currency + price6 + "  周六");
                                     }
                                     else if ((price5.equals("null")) && (price6.equals("null")) && (!price7.equals("null")))
                                     {
                                        out.println(currency + price7 + "  周日");
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
                                  間</div>
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
                  <td align="right" width="141"><strong>結算方式</strong>： </td>
                  <td width="342"> 
                    <input type="radio" name="payment" value="M" checked>
                    現金支付 &nbsp;&nbsp; 
                    <input type="radio" name="payment" value="N">
                    网上支付 </td>
                </tr>
                <tr> 
                  <td valign="top" align="right" width="141" ><strong>留&nbsp;&nbsp;&nbsp;&nbsp;言</strong>： 
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
                  <td height="20" colspan="2" align="center"><strong class="bigtxt">聯 
                    系 信 息</strong></td>
                </tr>
                <tr bgcolor="#CFC8CF"> 
                  <td colspan="2" height="1"></td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>聯 系 人</strong>： </td>
                  <td width="342" valign="top"> 
                    <input type="text" name="linkman" size="20" maxlength="50">
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>電子郵件</strong>： </td>
                  <td width="342" valign="top"> 
                    <input type="text" name="email" size="30" maxlength="100">
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>電&nbsp;&nbsp;&nbsp;&nbsp;話</strong>： 
                  </td>
                  <td width="342"> 
                    <input type="text" name="phone0" size="5">
                    （國家代碼） 
                    <input type="text" name="phone1" size="5">
                    （地區代碼）</td>
                </tr>
                <tr> 
                  <td align="right" width="141">&nbsp;</td>
                  <td width="342"> 
                    <input type="text" name="phone" size="15">
                    (格式：0086-755-2208051)</td>
                </tr>
                <tr> 
                  <td align="right" width="141"><strong>傳&nbsp;&nbsp;&nbsp;&nbsp;真</strong>： 
                  </td>
                  <td width="342"> 
                    <input type="text" name="fax0" size="5">
                    （國家代碼） 
                    <input type="text" name="fax1" size="5">
                    （地區代碼） </td>
                </tr>
                <tr> 
                  <td align="right" width="141" rowspan="2">&nbsp;</td>
                  <td width="342"> 
                    <input type="text" name="fax" size="15">
                    (格式：0086-755-2208051)</td>
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

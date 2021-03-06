<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="prBook" scope="page" class="com.cnbooking.hotel.Procedure" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="bookInfo" scope="session" class="com.cnbooking.hotel.BookInfo" />
<%
prBook.setConnection(db.getConnection());
sqlProvide.setLangCode("GB");
prBook.setSql(sqlProvide.getSql("Hotel.Book"));
prBook.setCS();
prBook.setInParameter(1, "GB");
prBook.setInParameter(2, bookInfo.getHotelId());
prBook.setInParameter(3, bookInfo.getCustId());
prBook.setInParameter(4, bookInfo.getName());
prBook.setInParameter(5, bookInfo.getNamePy());
prBook.setInParameter(6, bookInfo.getAdult());
prBook.setInParameter(7, bookInfo.getChildren());
prBook.setInParameter(8, bookInfo.getPayment());
prBook.setInParameter(9, bookInfo.getCusNotes());
prBook.setInParameter(10, bookInfo.getContact());
prBook.setInParameter(11, bookInfo.getTel());
prBook.setInParameter(12, bookInfo.getFax());
prBook.setInParameter(13, bookInfo.getEmail());
prBook.setInParameter(14, bookInfo.getArrivalDate());
prBook.setInParameter(15, bookInfo.getLeaveDate());
prBook.setInParameter(16, bookInfo.getRoomType1());
prBook.setInParameter(17, bookInfo.getPriceType1());
prBook.setInParameter(18, bookInfo.getRoomQty1());
prBook.setInParameter(19, bookInfo.getRoomType2());
prBook.setInParameter(20, bookInfo.getPriceType2());
prBook.setInParameter(21, bookInfo.getRoomQty2());
prBook.setInParameter(22, bookInfo.getRoomType3());
prBook.setInParameter(23, bookInfo.getPriceType3());
prBook.setInParameter(24, bookInfo.getRoomQty3());
prBook.setInParameter(25, bookInfo.getRoomType4());
prBook.setInParameter(26, bookInfo.getPriceType4());
prBook.setInParameter(27, bookInfo.getRoomQty4());
prBook.setInParameter(28, bookInfo.getRoomType5());
prBook.setInParameter(29, bookInfo.getPriceType5());
prBook.setInParameter(30, bookInfo.getRoomQty5());
prBook.setOutParameter(31);
prBook.setOutParameter(32);
prBook.setOutParameter(33);
prBook.callProc();
String bookId =  prBook.getOutParm(31);
String errCode =  prBook.getOutParm(32);
String errText =  prBook.getOutParm(33);

    
%>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" />
<% 
  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	
<%}
%>
<html><!-- #BeginTemplate "/Templates/main_gb.dwt" -->
<head> <!-- #BeginEditable "doctitle" --> 
<title>中港澳酒店订房专家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
 input {font-family: "宋体"; font-size: 12px ;color:#666666}
 select {font-family: "宋体"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 宋体}
 A:visited {text-decoration: none; color: #715922; font-family: 宋体}
 A:active {text-decoration: none; font-family: 宋体}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "宋体", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "宋体"; font-size: 12px}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<%
/*out.print(errCode);
out.print(errText);
out.print(prBook.getMessage());
out.println(prBook.getSql());
out.print("<br>");
out.println("GB");
out.println(bookInfo.getHotelId());
out.println(bookInfo.getCustId());
out.println(bookInfo.getName());
out.println(bookInfo.getNamePy());
out.print("<br>");
out.println(bookInfo.getAdult());
out.println(bookInfo.getChildren());
out.println(bookInfo.getPayment());
out.println(bookInfo.getCusNotes());
out.println(bookInfo.getContact());
out.print("<br>");
out.println(bookInfo.getTel());
out.println(bookInfo.getFax());
out.println(bookInfo.getEmail());
out.println(bookInfo.getArrivalDate());
out.println(bookInfo.getLeaveDate());
out.println("<br>");
out.println(bookInfo.getRoomType1());
out.println(bookInfo.getPriceType1());
out.println(bookInfo.getRoomQty1());
out.println(bookInfo.getRoomType2());
out.println(bookInfo.getPriceType2());
out.println(bookInfo.getRoomQty2());
out.println(bookInfo.getRoomType3());
out.println(bookInfo.getPriceType3());
out.println(bookInfo.getRoomQty3());
out.println(bookInfo.getRoomType4());
out.println(bookInfo.getPriceType4());
out.println(bookInfo.getRoomQty4());
out.println(bookInfo.getRoomType5());
out.println(bookInfo.getPriceType5());
out.println(bookInfo.getRoomQty5());*/
%>

<script language="JavaScript" src="../../javascript/gb/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="../../images/top_back.gif" height="34" valign="bottom"><a href="javascript:window.history.go(-1)"><img src="../../images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="../../images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;预订订单</font><!-- #EndEditable --></td>
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
      <table width="420" border="1" cellspacing="0" bordercolor="#FFBC04" cellpadding="2" align="center">
        <tr align="center"> 
          <td class="txt"><span class="bigtxt"><font color="#666666">谢谢您！</font></span><font color="#666666"><br>
            您的订单已被接受，订单号是</font> <b><font color="#000000"><%=bookId%></font></b>，<br>
            <font color="#666666">我们将在最快的时间内确认您的定房！<br>
            您可以通过网站联系电话随时查询您的订房信息。</font></td>
        </tr>
      </table>
      <div align="center"><br>
        <a href="index.html"><img src="../../images/gb/continue_booking.gif" width="138" height="18" border="0"></a> 
      </div>
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

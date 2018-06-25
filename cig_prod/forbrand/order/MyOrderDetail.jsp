<%@ page import="java.util.*, java.sql.*,java.io.*,java.text.*" session="true" language="java" %> 
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ForBrand.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
<SCRIPT language=JavaScript>
function js_callpage(htmlurl) {
  var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=566,height=327");
  return false;
}
function js_callpage2(htmlurl) {
  var cart=window.open(htmlurl,"cart","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=650,height=420");
  return false;
}
function js_call() {
  pick_tai=document.tv_form.tai_select.options[document.tv_form.tai_select.selectedIndex].value;
  pick_week=document.tv_form.week_select.options[document.tv_form.week_select.selectedIndex].value;
  parent.window.location.href=pick_tai+"-"+pick_week+"\.html";
}
</SCRIPT>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width=758 border=0 cellpadding=0 cellspacing=0>
  <tr> 
    <td> <img src="/images/img-sea/spacer-blu.gif" width=54 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=73 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=443 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=40 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=93 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=35 height=1></td>
    <td> <img src="/images/img-sea/spacer-right.gif" width=20 height=1></td>
  </tr>
  <tr> 
    <td rowspan=2> <a href="../../index.html"><img src="/images/img-sea/search_01.gif" width=54 height=50 border="0"></a></td>
    <td colspan=6> <img src="/images/img-sea/search_02.gif" width=704 height=32 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="381,13,459,26" href="../show/portinfo.jsp"><area shape="rect" coords="482,13,555,26" href="../login/myaccount.jsp"><area shape="rect" coords="583,12,692,26" href="../show/cart.jsp" onClick="return js_callpage2(this.href)"></map></td>
  </tr>
  <tr> 
    <td> <img src="/images/img-sea/search_03.gif" width=73 height=18></td>
    <td colspan=5> <img src="/images/img-sea/search_04.gif" width=631 height=18 usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="116,3,204,15" href="../show/showroom.jsp"><area shape="rect" coords="302,3,407,12" href="../show/giftoccasion.jsp?langCode=EN"><area shape="rect" coords="429,3,535,14" href="../login/specialorder.jsp"><area shape="rect" coords="550,3,617,14" href="../show/showinside.jsp?act=4&langCode=EN"><area shape="rect" coords="222,4,284,14" href="../show/showinside.jsp?act=3&langCode=EN"></map></td>
  </tr>
  <tr> <!-- #BeginEditable "replace" --> 
    <td colspan=3 rowspan=3 background="/images/background1_05.gif" class="orange-title1"> 
      <!--   <blockquote>
        <p>MY ACCOUNT</p>
      </blockquote>--> </td>
    <!-- #EndEditable --> 
    <td colspan=4> <img src="/images/img-sea/search_06.gif" width=188 height=42 usemap="#Map3" border="0"><map name="Map3"><area shape="rect" coords="13,9,121,22" href="../show/search.jsp"></map></td>
  </tr>
   <tr> 
    <td rowspan=2> <img src="../../images/img-sea/search_07.gif" width=40 height=37></td>
    <form name="form1" action="../show/showinside.jsp">
      <td bgcolor="#D7D8C0"> 
        <input type="text" name="keyWord" maxlength="20" size="7">
		<input type="hidden" name="langCode" value="EN">
		<input type="hidden" name="act" value="2">
      </td>
    
    <td><input type="image" src="../../images/img-sea/search_09.gif" width=35 height=26 border="0"></td>
	</form>
    <td rowspan=2> <img src="../../images/img-sea/search_10.gif" width=20 height=37></td>
  </tr> <tr> 
    <td colspan=2> <img src="/images/img-sea/search_11.gif" width=128 height=11></td>
  </tr>
</table>
<!-- #BeginEditable "body" --> <%!
	public String getStatusName(String status)
	{
	  String statusName = null;
          switch(Integer.parseInt(status))
	  {
	    case 1:
	      statusName = "new";
	      break;
	    case 2:
	      statusName = "received";
	      break;
	    case 3:
	      statusName = "processing";
	      break;
	    case 4:
	      statusName = "manufacturing";
	      break;
	    case 5:
	      statusName = "designing";
	      break;
	    case 6:
	      statusName = "sample sent";
	      break;
	    case 7:
	      statusName = "is sending";
	      break;
	    case 8:
	      statusName = "all sent";
	      break;
	    case 9:
	      statusName = "buyer received";
	      break;
	    case 10:
	      statusName = "cancelled";
	      break;	
	  }
	  return statusName;
	}
	String order_id = null;
	Hashtable[] results = null;
	String sql = null;
	String status = null;
	String descr = null;
	String totalDue = null;
	double totalDue0 = 0.0;
	String amountpaid = null;
	String samplescale = null;
	double subtotal = 0.0;
	String userName = null;
	String city = null;
	String addr = null;
//	String postcode = null;
	String tel = null;
	String fax = null;
	String email = null;
	String mobile = null;
	String remark = null;
	String discount = null;
	String users_id = null;
	int count ;
%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<jsp:useBean id="format" scope="page" class="com.forbrand.order.FormatData" />
<%
	try
	{
		users_id = session.getValue("userid").toString();
	} catch (Exception e)
	{
	   e.printStackTrace(System.out);
	%> <jsp:forward page="../ResultsError.jsp?message=No userID in Session!" /> 
	<%}
	count = 0;
	format.setLocale(Locale.US);
	format.setPattern("#,##0.0#");
	order_id = request.getParameter("order_id");
	sql = "select b.order_id,b.users_id,b.status,a.firstname,a.lastname,a.sex,b.destaddress addr,a.tel,a.fax,b.city,a.email,a.mobile,";
	sql+="c.gift_id,d.giftname,c.quantity,c.quantity_send,c.price,c.saleprice,c.saleprice*c.quantity sq,b.discount,";
	sql+="b.paymethod,b.totaldue,b.amountpaid,to_char(b.estimatedate,'YYYY-MM-DD') estimate,to_char(c.shipdate,'YYYY-MM-DD') ship,";
	sql+="b.remark,b.samplescale,b.status ";
	sql+="from users a,orders b,orderdetail c,gift_l d ";
	sql+="where c.gift_id = d.gift_id and b.order_id=c.order_id and b.order_id = \'"+order_id+"\' and a.login = b.users_id and b.users_id = \'"+users_id+"\'";
	System.out.println(sql);
	try
	{
	   results = jdbc.executeQuery(sql);
   	   if (results[0] == null)
	   {	%> <jsp:forward page="../ResultsError.jsp?message=No Record!" /> <%}

	} catch (SQLException e)
	{
	   e.printStackTrace(System.out);
	%> <jsp:forward page="../ResultsError.jsp?message=No Record!" /> <%

	}

	session.putValue("results_de",results);
	res.setResult(results);
	System.out.println("size of res is "+res.size());
%> 
<table width="755" border="0" cellspacing="4" cellpadding="4">
  <tr> 
    <td colspan="2" valign="top" align="center"> 
      <p align="left"><span class="xiaolei"> <%
	if (res.getObject("sex").toString().equals("M"))
	{
		userName = "Mr. "+res.getObject("firstname").toString();
	}
	else
	{
		userName = "Mrs. "+res.getObject("firstname").toString();
	}
      %> <b>DEAR <%=userName%></b></span><b><br>
        </b> <span class="xiaolei">Status of order <%=order_id%> is <%=getStatusName(res.getObject("status").toString())%>.<br>
        Here are what you purchased.</span></p>
      <table width="80%" border="0" cellspacing="4">
        <tr> 
          <td class="xiaolei" width="24%"><b>Gift ID</b></td>
          <td class="xiaolei" width="12%"><b>Gift Name</b></td>
          <td class="xiaolei" width="12%"><b>QTY</b></td>
          <td class="xiaolei" width="13%"><b>Price</b></td>
          <td class="xiaolei" width="21%"><b>Special Price ( If )</b></td>
          <td class="xiaolei" width="18%"><b>Total</b></td>
        </tr>
        <tr> 
          <td colspan="6"> 
            <hr noshade>
          </td>
        </tr>
        <%
	  while (res.hasNext())
	  {%> 
        <tr> 
          <td class="xiaolei"><%=res.getObject("gift_id").toString()%></td>
          <td class="xiaolei"><%=res.getObject("giftname").toString()%></td>
          <td class="xiaolei"><%=res.getObject("quantity").toString()%></td>
	  <%
	  format.setCurrency(Double.parseDouble(res.getObject("price").toString()));
	  %> 
          <td class="xiaolei">$<%=format.getCurrency()%></td>
	    <%
	  format.setCurrency(Double.parseDouble(res.getObject("saleprice").toString()));	
	  %>
          <td class="xiaolei">$<%=format.getCurrency()%></td>
	  <%
	  format.setCurrency(Double.parseDouble(res.getObject("sq").toString()));	
	  %>
          <td class="xiaolei">$<%=format.getCurrency()%></td>
        </tr>
        <%
	  if (count == 0)
	  {
	  totalDue = res.getObject("totaldue").toString();
  	  discount = res.getObject("discount").toString();
	  totalDue0 = Double.parseDouble(totalDue)/((100.0-Double.parseDouble(discount))/100.0);
	  amountpaid = res.getObject("amountpaid").toString();
          samplescale = res.getObject("samplescale").toString();
	  city =res.getObject("city").toString();
	  addr = res.getObject("addr").toString();
//	  postcode = res.getObject("postcode").toString();
	  email = res.getObject("email").toString();
	  tel = res.getObject("tel").toString();	
	  fax = res.getObject("fax").toString();
	  mobile = res.getObject("mobile").toString();
	  remark = res.getObject("remark").toString();
	  descr = session.getValue(res.getObject("paymethod").toString()).toString();
  	  subtotal = totalDue0/Double.parseDouble(samplescale);    
	  count = 1 ;
	  System.out.println("done.");
	  }
	  res.next();
	  }%> 
        <tr> 
          <td colspan="6"> 
            <hr noshade size="1">
          </td>
        </tr>
        <tr> 
          <td class="xiaolei" width="24%">Sub Total</td>
          <td width="12%">&nbsp;</td>
          <td width="12%">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
	  <%
		format.setCurrency(subtotal);
	  %>
          <td class="xiaolei" width="18%">$<%=format.getCurrency()%></td>
        </tr>
        <tr> 
          <td class="xiaolei" width="24%">Sample Surchange Rate</td>
          <td width="12%">&nbsp;</td>
          <td width="12%">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
          <td class="xiaolei" width="18%"><%=(new Double(Double.parseDouble(samplescale)*100.0)).intValue()%>%</td>
        </tr>
        <tr> 
          <td class="xiaolei" width="24%">Total</td>
          <td width="12%">&nbsp;</td>
          <td width="12%">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
         <%
		format.setCurrency(totalDue0);
	  %> 
          <td class="xiaolei" width="18%">$<%=format.getCurrency()%></td>
        </tr>
	<tr> 
          <td class="xiaolei" width="24%">DisCount</td>
          <td width="12%">&nbsp;</td>
          <td width="12%">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
	  <td class="xiaolei" width="18%"><%=discount%>%</td>
        </tr>

	<tr> 
          <td class="xiaolei" width="24%">Order Total</td>
          <td width="12%">&nbsp;</td>
          <td width="12%">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
     	<%
		format.setCurrency(Double.parseDouble(totalDue));
	  %> 
          <td class="xiaolei" width="18%">$<%=format.getCurrency()%></td>
        </tr>

        <tr> 
          <td class="xiaolei" width="24%">Payment Mythod:</td>
          <td width="12%">&nbsp;</td>
          <td width="12%">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
          <td class="xiaolei" width="18%"><%=descr%></td>
        </tr>
        <tr> 
          <td class="xiaolei" colspan="6"> 
            <hr noshade size="1">
          </td>
        </tr>
        <tr> 
          <td class="xiaolei" width="24%">Total Charge:</td>
          <td width="12%">&nbsp;</td>
          <td width="12%">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
	 <%
		format.setCurrency(Double.parseDouble(totalDue));
	  %> 
          <td class="xiaolei" width="18%">$<%=format.getCurrency()%></td>
        </tr>
        <tr> 
          <td class="xiaolei" width="24%">Total Paid:</td>
          <td width="12%">&nbsp;</td>
          <td width="12%">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
	 <%
		if(amountpaid == null || amountpaid.equals(""))
			format.setCurrency(0);
		else
			format.setCurrency(Double.parseDouble(amountpaid));
	  %> 
          <td class="xiaolei" width="18%">$<%=format.getCurrency()%></td>
        </tr>
        <tr> 
          <td class="xiaolei" colspan="6"> 
            <hr noshade size="1">
          </td>
        </tr>
        <tr> 
          <td class="xiaolei" width="24%" valign="top">Receiver Info:</td>
          <td colspan="5" class="xiaolei"> <%=userName%> <br>
            <%=addr%> <br>
            <%=city%> <br>
            email: <%=email%><br>
            Tele: <%=tel%><br>
            Fax: <%=fax%> <br>
            Mobile:<%=mobile%> </td>
        </tr>
        <tr> 
          <td class="xiaolei" width="24%" valign="top"> Your request.</td>
          <form name="form2" >
            <td colspan="5" class="xiaolei" valign="top"> 
              <textarea name="textfield2" cols="30" rows="3" wrap="VIRTUAL"><%=remark%></textarea>
              <span class="white-title"> </span> </td>
          </form>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
<!-- #EndEditable --> 
<table width=758 border=0 cellpadding=0 cellspacing=0>
  <tr> 
    <td> <img src="/images/img-foot/footer_01.gif" width=376 height=23></td>
    <td> <a href="../../html/aboutus.html"><img src="/images/img-foot/footer_02.gif" width=65 height=23 border="0"></a></td>
    <td> <a href="../../html/contactus.html"><img src="/images/img-foot/footer_03.gif" width=76 height=23 border="0"></a></td>
    <td> <a href="../../html/sitemap.html"><img src="/images/img-foot/footer_04.gif" width=65 height=23 border="0"></a></td>
    <td> <a href="../../html/help.html"><img src="/images/img-foot/footer_05.gif" width=39 height=23 border="0"></a></td>
    <td> <a href="../../html/privacy.html"><img src="/images/img-foot/footer_06.gif" width=55 height=23 border="0"></a></td>
    <td> <img src="/images/img-foot/footer_07.gif" width=82 height=23></td>
  </tr>
</table>

</body>
<!-- #EndTemplate --></html>

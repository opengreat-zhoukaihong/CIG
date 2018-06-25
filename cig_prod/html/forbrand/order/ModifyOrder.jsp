<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%> 
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
      <!--<blockquote>
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
	String order_id_de = null;
	Hashtable[] results_de = null;
	String sqlUpdate = null;
	String sqlUpdate_de = null;
	String sqlInsert=null;
	String status_de = null;
	String users_id_de = null;
	String history = "";
	String remark = "";
	String[] quantity_send = null;
	String[] shipdate = null;
	String[] gift_id = null;
	String amountpaid = null;
	String estimate = null;
	int i , j , n;
%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<%
	order_id_de = session.getValue("order_id_de").toString();
	System.out.println("www0");
	results_de = (Hashtable[])session.getValue("results_de");
	res.setResult(results_de);
	order_id_de = res.getObject("order_id").toString();
	users_id_de = res.getObject("users_id").toString();
	status_de = res.getObject("status").toString();
	quantity_send = request.getParameterValues("quantity_send");
	shipdate = request.getParameterValues("shipdate");
	gift_id = request.getParameterValues("gift_id");
	amountpaid = request.getParameter("amountpaid");
	estimate = request.getParameter("estimate");
	
%> 
<table width="755" border="0" cellspacing="4" cellpadding="4">
  <tr> 
    <td class="xiaolei" colspan="2" valign="top" align="center"> <!--modify status --> <%
	for (int m=0;m<quantity_send.length;m++)
	{
		sqlUpdate_de = "update orderdetail set quantity_send = "+Integer.parseInt(quantity_send[m])+
		               ",shipdate = to_date(\'"+shipdate[m]+"\','YYYY-MM-DD') where gift_id = \'"+
			       gift_id[m]+"\' and order_id = \'"+order_id_de+"\'";
		System.out.println(sqlUpdate_de);
		i = jdbc.executeUpdate(sqlUpdate_de);
		if (i>0)
		{%> 
      <p class="xiaolei">Process <%=res.getObject("gift_id").toString()%> in orderDetail Success</p>
      <%
		}
		else
		{
		%> 
      <p class="xiaolei">Process <%=res.getObject("gift_id").toString()%> Fail in orderDetail,please 
        try again.</p>
      <%}
		res.next();
	}

	sqlUpdate = "update orders set amountpaid = "+Integer.parseInt(amountpaid)+
		    ",estimatedate = to_date(\'"+estimate+"\','YYYY-MM-DD') where order_id = \'"+order_id_de+"\'";
	System.out.println(sqlUpdate);
	n = jdbc.executeUpdate(sqlUpdate);
	if (n>0)
	{%> 
      <p class="xiaolei">Process <%=order_id_de%> in orders Success</p>
      <%
	}
	else
	{
	%> 
      <p class="xiaolei">Process <%=order_id_de%> Fail in orders,please try again.</p>
      <%}
	%> <!--write log in the history table --> <%
	sqlInsert = "insert into ordershis values (\'"+order_id_de+"\',\'"+users_id_de+"\',\'"+history+
	            "\',\'"+remark+"\',\'"+status_de+"\',Sysdate)";
	System.out.println(sqlInsert);
	j = jdbc.executeUpdate(sqlInsert);
	if (j>0)
	{%> 
      <p class="xiaolei">Process History Success</p>
      <%
	}
	else
	{
        %> 
      <p class="xiaolei">Process History Fail,please try again.</p>
      <%}
      
     %> </td>
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

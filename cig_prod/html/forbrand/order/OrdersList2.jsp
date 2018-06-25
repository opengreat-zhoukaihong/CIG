<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%> 
<%!
	String status = null;
	String payMethod = null;
	String sql = null;
	String statusName = null;
	String order_id = null;
	Hashtable[] results = null;
%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<%
	order_id = request.getParameter("order_id");
	sql = "select order_id,users_id,totaldue,paymethod,to_char(orderdate,'YYYY-MM-DD') odate,status from orders ";
	sql+= "where order_id = \'"+order_id+"\'";
	System.out.println(sql);
//	results = jdbc.executeQuery(sql);
	try
	{
	   results = jdbc.executeQuery(sql);
	} catch (SQLException e)
	{
	   e.printStackTrace(System.out);
	%> <jsp:forward page="../ResultsError.jsp?message=No Records!" /> <%

	}
	res.setResult(results);
%> 
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
      <blockquote> 
        <p>MY ACCOUNT: <span class="dalei">PURCHASE HISTORY</span></p>
      </blockquote>
    </td>
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
<!-- #BeginEditable "body" --> 
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td WIDTH="200" valign="top" align="center"><span class="dalei"><img src="/images/hanging.jpg" width="144" height="101"></span> 
    </td>
    <td valign="top"> <%
	  status = res.getObject("status").toString();
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
	  session.putValue("status",status);
          session.putValue("statusName",statusName);
	%> 
      <p><span class="black-m-text"><b>Order Status:<%=statusName%></b></span></p>
      <table width="100%" border="0" cellspacing="4" cellpadding="4">
        <tr> 
          <td class="xiaolei" width="11%"><b>Order ID</b></td>
          <td bgcolor="#FFFFFF" width="13%"><span class="xiaolei"><b>Users ID</b></span></td>
          <td bgcolor="#FFFFFF" width="19%" class="xiaolei"><b>Total Due</b></td>
          <td bgcolor="#FFFFFF" width="12%" class="xiaolei"><b>Pay Metohd <span class="xiaolei">(pcs/sets)</span></b></td>
          <td bgcolor="#FFFFFF" width="24%" class="xiaolei"><b>Order Date</b></td>
        </tr>
        <%
  	  while (res.hasNext())
	  {%> 
        <tr> 
          <td><%=res.getObject("order_id").toString()%></td>
          <td><%=res.getObject("users_id").toString()%></td>
          <td><%=res.getObject("totaldue").toString()%></td>
          <td><%=session.getValue(res.getObject("paymethod").toString()).toString()%></td>
          <td><%=res.getObject("odate").toString()%></td>
          <td><a href="OrderProcess2.jsp?order_id=<%=res.getObject("order_id").toString()%>" target="_blank">Process 
            Status</a></td>
          <td><a href="OrderDetail.jsp?order_id=<%=res.getObject("order_id").toString()%>" target="_blank">Modify 
            Detail</a></td>
        </tr>
        <%  
	   res.next();
	   }%> 
      </table>
      <p><span class="product-name"></span></p>
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

<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%> 
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ForBrand.com</title>
<script language="Javascript"><!--
 function received()
  {
    document.orderProcess.action.value = "2";
    document.orderProcess.submit();
  }
 function cancelled()
  {
    if(document.orderProcess.remark.value == null || document.orderProcess.remark.value == "")
      {
        alert("please write the reason for cancelling the order above the memo");
        return;
      }
    else
    {
    document.orderProcess.action.value = "10";
    document.orderProcess.submit();
    }
  }
 function processing()
  {
    document.orderProcess.action.value = "3";
    document.orderProcess.submit();
  }
 function manufacturing()
  {
    document.orderProcess.action.value = "4";
    document.orderProcess.submit();
  }
 function designing()
  {
    document.orderProcess.action.value = "5";
    document.orderProcess.submit();
  }
 function sampleSent()
  {
    document.orderProcess.action.value = "6";
    document.orderProcess.submit();
  }
 function isSending()
  {
    document.orderProcess.action.value = "7";
    document.orderProcess.submit();
  }
 function allSent()
  {
    document.orderProcess.action.value = "8";
    document.orderProcess.submit();
  }
 function buyerReceived()
  {
    document.orderProcess.action.value = "9";
    document.orderProcess.submit();
  }
//-->
</script>
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
	String order_id = null;
	String sql = null;
	Hashtable[] results = null;
	String status = null;
	String statusName = null;

%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<%
	order_id = request.getParameter("order_id");
	session.putValue("order_id",order_id);
	status = session.getValue("status").toString();
	statusName = session.getValue("statusName").toString();
	sql = "select a.users_id,b.email,a.orderstyle,a.paymethod,to_char(a.orderdate,'YYYY-MM-DD') ordate,";
	sql +="to_char(a.requdate,'YYYY-MM-DD') requ,to_char(a.estimatedate,'YYYY-MM-DD') estimate,a.totaldue,a.amountpaid ";
	sql +="from orders a,users b where a.order_id = \'"+order_id+"\' and a.users_id = b.login ";
	System.out.println(sql);
	//results = jdbc.executeQuery(sql);
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
	//System.out.println("www");
	session.putValue("results",results);
	res.setResult(results);
		
%> 
<table width="600" border="0" cellspacing="0" cellpadding="0" height="300" align="center">
  <tr valign="top" >
    <td> 
      <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr class="black-m-text">
          <td height="13">Process Order Status:</td>
          <td height="13" >&nbsp;</td>
          <td height="13">&nbsp;</td>
        </tr>
        <tr> 
          <td >&nbsp; </td>
          <td align="right">&nbsp; </td>
        </tr>
        <tr> 
          <td colspan="3"> 
            <table width="600" border="1" cellspacing="2" cellpadding="0" bordercolorlight="#6666FF">
              <tr align="center" bgcolor="#FFFFFF" class="black-m-text"> 
                <td height="20" width="107"> 
                  <div align="right">Order ID:</div>
                </td>
                <td height="20" width="186">&nbsp;<%=order_id%></td>
                <td height="20" width="135"> 
                  <div align="right">User ID:</div>
                </td>
                <td height="20" width="152">&nbsp;<%=res.getObject("users_id").toString()%></td>
              </tr>
              <tr align="center" bgcolor="#FFFFFF" class="black-m-text">
                <td height="20" width="107">
                  <div align="right">Order Style:</div>
                </td>
                <td height="20" width="186">&nbsp;
		<%
		if(res.getObject("orderstyle").toString().equals("W"))
		{%>
		Whole Sale
		<%}
		else
		{%>
		Retail
		<%}%>
		</td>
                <td height="20" width="135">
                  <div align="right">Status:</div>
                </td>
                <td height="20" width="152">&nbsp;<%=statusName%></td>
              </tr>
              <tr align="center" bgcolor="#FFFFFF" class="black-m-text">
                <td height="20" width="107">
                  <div align="right">Order Date:</div>
                </td>
                <td height="20" width="186">&nbsp;<%=res.getObject("ordate").toString()%></td>
                <td height="20" width="135">
                  <div align="right">Request Date:</div>
                </td>
                <td height="20" width="152">&nbsp;<%=res.getObject("requ").toString()%></td>
              </tr>
              <tr align="center" bgcolor="#FFFFFF">
                <td height="20" width="107">
                  <div align="right">Pay Method:</div>
                </td>
                <td height="20" width="186">&nbsp;<%=session.getValue(res.getObject("paymethod").toString()).toString()%></td>
                <td height="20" width="135">
                  <div align="right">Estimate Date:</div>
                </td>
                <td height="20" width="152">&nbsp;<%=res.getObject("estimate").toString()%></td>
              </tr>
              <tr align="center" bgcolor="#FFFFFF" class="black-m-text">
                <td height="20" width="107">
                  <div align="right">Total Charge:</div>
                </td>
                <td height="20" width="186">&nbsp;<%=res.getObject("totaldue").toString()%></td>
                <td height="20" width="135">
                  <div align="right">Total Paid:</div>
                </td>
                <td height="20" width="152">&nbsp;<%=res.getObject("amountpaid").toString()%></td>
              </tr>
            </table>
          </td>
        </tr>
        <form name="orderProcess" action="OrderProcess3.jsp" method="post">
          <tr> 
            <td colspan="3" height="18">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3" height="15"> 
              <div align="left"><font color="#CC0000">Memo(If cancell the order,please 
                write the reason to the below):</font></div>
            </td>
          </tr>
          <tr> 
            <td colspan="3" height="75"> 
              <textarea name="remark" cols="70" rows="3"></textarea>
            </td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <input type="hidden" name="action" >
              <%
        if(status.equals("1")) {
%> <a href="javascript:received()"> <b>Received</b> </a>&nbsp;&nbsp; <a href="javascript:cancelled()"><b>Cancelled</b></a> 
              <%      }
        if(status.equals("2")) {
%> <a href="javascript:processing()"> <b>Processing</b></a>&nbsp;&nbsp; <a href="javascript:manufacturing()"> 
              <b>Manufacturing</b></a>&nbsp;&nbsp; <a href="javascript:designing()"> 
              <b>Designing</b></a> &nbsp;&nbsp; <a href="javascript:cancelled()"><b>Cancelled</b></a> 
              <%      }
        if(status.equals("3")||status.equals("4")||status.equals("5")) {
%> <a href="javascript:sampleSent()"> <b>Sample Sent</b></a>&nbsp;&nbsp; <a href="javascript:isSending()"> 
              <b>Is Sending</b></a>&nbsp;&nbsp; <a href="javascript:cancelled()"><b>Cancelled</b></a> 
              <%      }
        if(status.equals("6")||status.equals("7")) {
%> <a href="javascript:allSent()"> <b>All Sent</b></a>&nbsp;&nbsp; <a href="javascript:cancelled()"><b>Cancelled</b></a> 
              <%      }
        if(status.equals("8")) {
%> <a href="javascript:buyerReceived()"> <b>Buyer Received</b></a>&nbsp;&nbsp; 
              <a href="javascript:cancelled()"><b>Cancelled</b></a> <%      }
%> </td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
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

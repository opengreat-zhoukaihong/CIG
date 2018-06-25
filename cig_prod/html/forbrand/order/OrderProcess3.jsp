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
	String sqlUpdate = null;
	String sqlInsert=null;
	String status = null;
	String statusName = null;
	String users_id = null;
	String history = "";
	String remark = "";
	String strContent = null;
	String email = null;
	int i , j;
	int iEmail;
%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<jsp:useBean id="sendmail" scope="page" class="com.forbrand.order.SendMail" /> 
<%
	order_id = session.getValue("order_id").toString();
	status = request.getParameter("action");
	results = (Hashtable[])session.getValue("results");
	res.setResult(results);
	users_id = res.getObject("users_id").toString();
	email = res.getObject("email").toString();
%> 
<table width="755" border="0" cellspacing="4" cellpadding="4">
  <tr> 
    <td colspan="2" valign="top" align="center"> <!--modify status --> <%
	sqlUpdate = "update orders set status = \'"+status+"\' where order_id = \'"+order_id+"\'";
	System.out.println(sqlUpdate);
	i = jdbc.executeUpdate(sqlUpdate);
	if (i>0)
	{%> 
      <p>Process Success</p>
      <%
	}
	else
	{
        %> 
      <p>Process Fail,please try again.</p>
      <%}%> <!--write log in the history table --> <%
	sqlInsert = "insert into ordershis values (\'"+order_id+"\',\'"+users_id+"\',\'"+history+
	            "\',\'"+remark+"\',\'"+status+"\',Sysdate)";
	System.out.println(sqlInsert);
	j = jdbc.executeUpdate(sqlInsert);
	if (j>0)
	{%> 
      <p>Process History Success</p>
      <%
	}
	else
	{
        %> 
      <p>Process History Fail,please try again.</p>
      <%}%> <!--send mail --> <%
      if (status.equals("2")||status.equals("10")||status.equals("8")||status.equals("6"))
      {
         //System.out.println("Content is "+strContent);	
	 strContent = "<html><body><table><tr>";
	 strContent+= "<th>order_id</th>";
	 strContent+= "<th>users_id</th>";
 	 strContent+= "<th>paymethod</th>";
	 strContent+= "<th>orderdate</th>";
	 strContent+= "<th>requestdate</th>";
	 strContent+= "<th>estimatedate</th>";
	 strContent+= "<th>totaldue</th>";
	 strContent+= "<th>amountpaid</th>";
	 strContent+= "<th>status</th></tr>";
	 strContent+= "<tr><td>"+order_id+"</td><td>"+users_id+"</td><td>"+res.getObject("paymethod").toString()+"</td>";
	 strContent+= "<td>"+res.getObject("ordate").toString()+"</td><td>"+res.getObject("requ").toString()+"</td>";
         strContent+= "<td>"+res.getObject("estimate").toString()+"</td><td>"+res.getObject("totaldue").toString()+"</td>";
	 strContent+= "<td>"+res.getObject("amountpaid").toString()+"</td><td>"+getStatusName(status)+"</td>";
	 strContent+= "</tr></table></body></html>";
	 System.out.println("Content is "+strContent);
	 System.out.println("email is "+email);

	 sendmail.setProperty(strContent,"cig.com.cn","Order Info","text/html","sales@forbrand.com",email);	
	 iEmail = sendmail.send();	
	 if(iEmail == 0)
	 {
	%>
	<p>send mail success!</p>
	<%}
	else
	{%> 
	<p>send mail fail!</p>
	<%}
      }%>
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

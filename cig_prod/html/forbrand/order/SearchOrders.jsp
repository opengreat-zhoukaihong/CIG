<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%> 
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ForBrand.com</title>
<script language="Javascript"><!--
function checkDate(checkedDate)
  {
    var tempDate = checkedDate;
    if(tempDate != "")
    {
      if((tempDate.charAt(4)!="-")||(tempDate.charAt(7)!="-"))
      {
	alert("date format error,please input correct format!");
        return false;
      }
      if(tempDate.length != 10)
      {
	alert("date format error,please input correct format!");
        return false;
      }
      tempDate = checkedDate.substring(0,4);
      if(tempDate<'1980'||tempDate>'2099')
      {
	alert("year inputed error!");
        return false;
      }
      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
	  alert("please input digit!");
          return false;
        }
      }
      tempDate = checkedDate.substring(5,7);
      if(tempDate<'01'||tempDate>'12')
      {
	alert("month inputed error!");
        return false;
      }
      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
	  alert("please input digit!");
          return false;
        }
      }
      tempDate = checkedDate.substring(8,10);
      if(tempDate<'01'||tempDate>'31')
      {
	alert("date inputed error!");
        return false;
      }

      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
  	  alert("please input digit!");
          return false;
        }
      }
    }
    return true;
  }

function validateForm(formName)
  {
    if(!checkDate(document.ordersList.bgnDate.value))
    {
      document.ordersList.bgnDate.focus();
      return false;
    }
    if(!checkDate(document.ordersList.endDate.value))
    {
      document.ordersList.endDate.focus();
      return false;
    }
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
    <td colspan=3 rowspan=3 background="/images/background1_05.gif"> 
      <blockquote class="orange-title1">ADVANCED SEARCH</blockquote>
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
	Hashtable[] results = null;
	String sql = null;
        String userID = null;
	String funcID = null;
%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<jsp:useBean id="perm" scope="page" class="com.cig.permission.Permission" /> <%
  funcID = "fnOrderMg";
  try
  {
  userID = session.getValue("operator").toString();
  } catch (Exception e)
  {
  e.printStackTrace(System.out);
  %> <jsp:forward page="../ResultsError.jsp?message=operator is Null in session!" /> 
<%
  }
  perm.setFuncID(funcID);
  perm.setUserID(userID);
  if(!perm.isPermitted()) {
%> <jsp:forward page="../ResultsError.jsp?message=Sorry! You have no permission!" /> 
<% }
     sql = "select code,descr from parameters where Parameter_Id = '1' and Lang_Code = 'EN' ";

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
     System.out.println(sql);
     res.setResult(results);
%> 
<table width="755" border="0" cellspacing="9" cellpadding="0">
  <form name="ordersList" method="post" action="OrdersList.jsp?first="1"" onSubmit="return validateForm(ordersList)">
    <tr> 
      <td width = "130" rowspan="9" valign="top"><img src="/images/handling.jpg" width="126" height="116"></td>
      <td width="160"> <span class="legal-notice">the order status:: </span></td>
      <td> 
        <select name="status">
          <option value="1">new</option>
          <option value="2">received</option>
          <option value="3">processing</option>
          <option value="4">manufacturing</option>
          <option value="5">designing</option>
          <option value="6">sample sent</option>
          <option value="7">is sending</option>
          <option value="8">all sent</option>
          <option value="9">buyer received</option>
          <option value="10">cancelled</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td  class="legal-notice" rowspan="2" width="160">the buyer is: </td>
      <td>
        <input type="text" name="login">
      </td>
    </tr>
    <tr> </tr>
    <tr> 
      <td class="legal-notice" width="160">the payment type is: </td>
      <td > 
        <select name="payMethod" >
          <option value="none" selected>--choose--</option>
	<%
	  while (res.hasNext())
	  {%>
	          <option value=<%=res.getObject("code").toString()%>><%=res.getObject("descr").toString()%></option>
			
	<% session.putValue(res.getObject("code").toString(),res.getObject("descr").toString());
	// System.out.println(session.getValue(res.getObject("code").toString()));
	   res.next();
	  }
	  res = null;
	%>    
        </select>
      </td>
    </tr>
    <tr> 
      <td  class="legal-notice" width="160">purchase date from:</td>
      <td > 
        <input type="text" name="bgnDate" size="15">
        to 
        <input type="text" name="endDate" size="15">
        (yyyy-mm-dd) </td>
    </tr>
    <tr> 
      <td width="160" height="2" ><font size="1"></font> </td>
      <td > <!--      <font size="1"><a href="OrdersList.jsp"><img src="/images/find-buttom.jpg" width="68" height="25" border="0"></a></font> --> 
        <input type="image" src="/images/find-buttom.jpg" name="find" >
      </td>
    </tr>
  </form>
  <form name="ordersList2" method="post" action="OrderDetail.jsp" >
    <tr> 
      <td class="legal-notice" width="160" >the orderID is::</td>
      <td > 
        <input type="text" name="order_id" size="20" maxlength="8">
      </td>
    </tr>
    <tr> 
      <td  class="legal-notice" width="160">&nbsp;</td>
      <td  > <!--      <a href="#"><img src="/images/find-buttom.jpg" width="68" height="25" border="0"></a> --> 
        <input type="image" src="/images/find-buttom.jpg" name="find" >
      </td>
    </tr>
    <tr> 
      <td width="160">&nbsp;</td>
      <td >&nbsp;</td>
    </tr>
  </form>
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

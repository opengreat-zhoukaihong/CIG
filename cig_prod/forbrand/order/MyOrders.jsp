<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%> 
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ForBrand.com</title>
<script language="Javascript"><!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

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
    if(!checkDate(document.myOrderList.bgnDate.value))
    {
      document.myOrderList.bgnDate.focus();
      return false;
    }
    if(!checkDate(document.myOrderList.endDate.value))
    {
      document.myOrderList.endDate.focus();
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
	Hashtable[] results = null;
	String sql = null;
%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<%
     sql = "select code,descr from parameters where Parameter_Id = '1' and Lang_Code = 'EN' ";

//     results =  jdbc.executeQuery(sql);
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
<table width="755" border="0" cellspacing="4" cellpadding="4">
  <form name="myOrderList" method="post" action="MyOrderList.jsp?first="1"" onSubmit="return validateForm(myOrderList)">
    <tr> 
      <td width = "130" rowspan="10" valign="top"><img src="/images/handling.jpg" width="126" height="116"></td>
    </tr>
    <tr> 
      <td  class="contact" colspan="2" valign="top">Please select from the lists 
        to view your order(s).</td>
    </tr>
    <tr> 
      <td  class="legal-notice" width="160" valign="top">purchase date from: </td>
      <td > 
        <input type="text" name="bgnDate" size="15">
        to 
        <input type="text" name="endDate" size="15">
        (yyyy-mm-dd) </td>
    </tr>
    <tr> 
      <td width="160" class="legal-notice" valign="top" >Payment Mythod:</td>
      <td > 
        <select name="payMethod">
          <option value="none">--choose--</option>
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
    <td width="160" >&nbsp;</td>
    <td > <!--    <a href="#"><img src="/images/find-buttom.jpg" width="68" height="25" border="0"></a>--> 
      <input type="image" src="/images/find-buttom.jpg" name="find" >
    </td>
  </tr>
  </form>
  <form name="myOrderDetail" method="post" action="MyOrderDetail.jsp" >
    <tr> 
      <td  class="legal-notice" width="160" valign="top">Search Order with its 
        No.</td>
      <td  > 
        <input type="text" name="order_id" size="8" maxlength="8">
      </td>
    </tr>
    <tr> 
      <td width="160">&nbsp;</td>
      <td > <!--<a href="#"><img src="/images/find-buttom.jpg" width="68" height="25" border="0"></a>--> 
        <input type="image" src="/images/find-buttom.jpg" name="find" >
      </td>
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

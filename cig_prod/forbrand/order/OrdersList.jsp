<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%> 
<%!
	public String getPageNo(HttpServletRequest request,String pageNo)
	{
	if(request.getParameter(pageNo) == null)
		return "1";
	else
		return request.getParameter(pageNo);
	}
	int pageNo,prePageNo,nextPageNo;
	int pageCount;
	int rowCount;
	int pages;
	int rowPerPage = 10;
	String status = null;
	String login = null;
	String bgnDate = null;
	String endDate = null;
	String sqlCond = null;
	String payMethod = null;
	String sql = null;
	String subSql = null;
	String statusName = null;
	Hashtable[] results = null;
%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<%
	pageNo = (Integer.valueOf(getPageNo(request,"pageNo"))).intValue();

	System.out.println("pageNo is "+pageNo);

	prePageNo = pageNo - 1;
	nextPageNo = pageNo + 1;
	if (pageNo == 1 && request.getParameter("first") != null)
	{
	 System.out.println("first is not null");
	 status = request.getParameter("status");
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
        login = request.getParameter("login");
	payMethod = request.getParameter("payMethod");
	bgnDate = request.getParameter("bgnDate");
	endDate = request.getParameter("endDate");
	sqlCond = " where status = \'"+status+"\'";
	if (login != null && !login.equals(""))
	{
	   sqlCond += " and user_id = \'"+login+"\'";
	}
        if (payMethod != null && !payMethod.equals("none"))
	{
	   sqlCond += " and paymethod = \'"+payMethod+"\'";
	}
	if (bgnDate != null && !bgnDate.equals(""))
	{
	   sqlCond += " and orderdate >= to_date(\'"+bgnDate+"\','YYYY-MM-DD')";
	}
	if (endDate != null && !endDate.equals(""))
	{
	   sqlCond += " and orderdate <= to_date(\'"+endDate+"\','YYYY-MM-DD')";
	}
	rowCount = jdbc.getRowCount("orders",sqlCond);
	if ((rowCount%rowPerPage)==0)
		pageCount = rowCount/rowPerPage ;
	else
		pageCount = rowCount/rowPerPage + 1;
	subSql = "select order_id,users_id,totaldue,paymethod,orderdate,RowNum rid from orders"+
		      sqlCond;
	session.putValue("subSql",subSql);
	session.putValue("pageCount",(new Integer(pageCount)));
	}
	else
	{
        System.out.println("first is null");
	subSql = session.getValue("subSql").toString();
	pageCount = Integer.parseInt(session.getValue("pageCount").toString());
	}

	sql = "select order_id,users_id,totaldue,paymethod,to_char(orderdate,'YYYY-MM-DD') odate from ("+subSql+
	      ") where rid > " +(pageNo-1)*rowPerPage+" and rid <= "+pageNo*rowPerPage+" order by order_id desc";
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

	res.setResult(results);
	System.out.println("row count is "+rowCount);
	System.out.println("page count is "+pageCount);
	System.out.println("pre page is "+prePageNo);
	System.out.println("next page is "+nextPageNo);
%> 
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ForBrand.com</title>
<script language="Javascript"><!--
function getNewPage(pageno)
  {
    document.QueryForm.pageNo.value=pageno;
    document.QueryForm.submit();
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
      <!--<blockquote>
        <p>MY ACCOUNT: <span class="dalei">PURCHASE HISTORY</span></p>
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
<!-- #BeginEditable "body" --> 
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td WIDTH="200" valign="top" align="center"><span class="dalei"><img src="/images/hanging.jpg" width="144" height="101"></span> 
    </td>
    <td valign="top"> 
      <p><span class="black-m-text"><b>Order Status:<%=statusName%></b></span></p>
      <%if(prePageNo > 0)
	{
	%> 
      <p><a href="javascript:getNewPage(<%=prePageNo%>)">previous</a> <%
	}
	if(nextPageNo <= pageCount)
	{
	%> <a href="javascript:getNewPage(<%=nextPageNo%>)">next</a></p>
      <%
	}
	%> 
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
          <td class="xiaolei"><%=res.getObject("order_id").toString()%></td>
          <td class="xiaolei"><%=res.getObject("users_id").toString()%></td>
          <td class="xiaolei"><%=res.getObject("totaldue").toString()%></td>
          <%
	  try
	  {%> 
          <td class="xiaolei"><%=session.getValue(res.getObject("paymethod").toString()).toString()%></td>
          <%} catch (Exception e)
	  {
		e.printStackTrace(System.out);
	  %> <jsp:forward page="../ResultsError.jsp?message=PayMethod is Null in Database!" /> 
          <%
	  }%> 
          <td class="xiaolei"><%=res.getObject("odate").toString()%></td>
          <td class="xiaolei"><a href="OrderProcess2.jsp?order_id=<%=res.getObject("order_id").toString()%>" target="_blank">Process 
            Status</a></td>
          <td class="xiaolei"><a href="OrderDetail.jsp?order_id=<%=res.getObject("order_id").toString()%>" target="_blank">Modify 
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
<form name="QueryForm" method="post" action="OrdersList.jsp">
  <input type="hidden" name="pageNo">
</form>
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

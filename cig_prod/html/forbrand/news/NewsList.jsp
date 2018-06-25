<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" %> 
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
	String dir = null;
	String sql = null;
	String subSql = null;
	Hashtable[] results = null;
%> <jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> <jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<%
	pageNo = (Integer.valueOf(getPageNo(request,"pageNo"))).intValue();

	System.out.println("pageNo is "+pageNo);

	prePageNo = pageNo - 1;
	nextPageNo = pageNo + 1;
	if (pageNo == 1 && request.getParameter("first") != null)
	{
		rowCount = jdbc.getRowCount("news","");
		if ((rowCount%rowPerPage)==0)
			pageCount = rowCount/rowPerPage ;
		else
			pageCount = rowCount/rowPerPage + 1;
		subSql = "select a.news_id,a.publish_date,a.order_no,b.title,a.template_id,c.dir,b.htmlfile,b.lang_code,RowNum rid ";
		subSql+= "from news a,news_l b,dir_setting c where a.news_id = b.news_id and (c.dir_id = b.html_dirid or c.dir_id = a.dirid) and b.lang_code = 'EN'";
		session.putValue("NewsSubSql",subSql);
		session.putValue("pageCount",new Integer(pageCount));
	}
	else
	{
		System.out.println("first is null");
		subSql = session.getValue("NewsSubSql").toString();
		pageCount = Integer.parseInt(session.getValue("pageCount").toString());
	}

	sql = "select news_id ,to_char(publish_date,'YYYY-MM-DD') publish,title,template_id,dir,htmlfile,lang_code from ("+subSql+
	      ") where rid > " +(pageNo-1)*rowPerPage+" and rid <= "+pageNo*rowPerPage+" order by order_no desc"; 
	System.out.println(sql);
        try
	{
	   results = jdbc.executeQuery(sql);
	   if (results[0] == null)
	   {	%> <jsp:forward page="../ResultsError.jsp?message=No Record!" /> <%}
	} catch (Exception e)
	{	
	   e.printStackTrace(System.out);
	%> <jsp:forward page="../ResultsError.jsp?message=No Record!" /> <%
	}
	res.setResult(results);
	
%> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"> 
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<script language=JavaScript>
function getNewPage(pageno)
  {
    document.NewsListForm.pageNo.value=pageno;
    document.NewsListForm.submit();
  }
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
    <TD background=ForBrand_com.files/background1_05.gif class=orange-title1
    colSpan=3 rowSpan=3> 
      <BLOCKQUOTE> 
        <P>NEWS and EVENTS</P>
      </BLOCKQUOTE>
    </TD>
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
<table width="75%" border="0">
  <tr> 
    <td width="15%" height="30">&nbsp;</td>
    <td width="85%" height="30"> <%if(prePageNo > 0)
	  {
	  %> <a href="javascript:getNewPage(<%=prePageNo%>)">previous</a> <%
	}
	if(nextPageNo <= pageCount)
	{
	%> <a href="javascript:getNewPage(<%=nextPageNo%>)">next</a><%
	}
	%> </td>
  </tr>
</table>
<TABLE border=0 cellSpacing=4 width=755>
  <TBODY> 
  <TR> 
    <TD>&nbsp; </TD>
    <TD width="80%"> 
      <P class=legal-notice> <%
  	  while (res.hasNext())
      {%> <BR>
        <%=res.getObject("publish").toString()%><A target=_blank
      <%
        if (res.getObject("template_id").toString().equals("0"))
	{
	  dir = res.getObject("dir").toString();
	 if (!dir.endsWith("/"))
              dir += "/";
      %>
         href=<%=dir+res.getObject("htmlfile").toString()%>> <%}
        else
	{%> href="NewsStyle<%=res.getObject("template_id").toString()%>.jsp?news_id=<%=res.getObject("news_id").toString()%>&&lang_code=<%=res.getObject("lang_code").toString()%>"> 
        <%}
      %> <BR>
        <%=res.getObject("title").toString()%> </A><BR>
        <%
	 res.next();
      }%> </P>
    </TD>
    <TD width="10%">&nbsp;</TD>
  </TR>
  </TBODY> 
</TABLE>
<BR>
<form name="NewsListForm" method="post" action="NewsList.jsp">
  <input type="hidden" name="pageNo">
</form>
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

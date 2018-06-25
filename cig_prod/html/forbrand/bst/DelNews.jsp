<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" %> 
<%!
	public String getPageNo(HttpServletRequest request,String pageNo)
	{
	if(request.getParameter(pageNo) == null || request.getParameter(pageNo).equals(""))
		return "1";
	else
		return request.getParameter(pageNo);
	}
	int pageNo,prePageNo,nextPageNo;
	int pageCount;
	int rowCount;
	int pages;
	int rowPerPage = 2;
	String dir = null;
	String sql = null;
	String subSql = null;
	String sql_del_news = null;
	String sql_del_news_l = null;
	String[] sql_del_array = null;
	String news_id = null;
	Hashtable[] results = null;
	String funcID = null;
	String userID = null;
%> 
<jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" /> 
<jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" /> 
<jsp:useBean id="perm" scope="page" class="com.cig.permission.Permission" />

<%
  funcID = "fnNewsMg";
  try
  {
  userID = session.getValue("operator").toString();
  } catch (Exception e)
  {
  e.printStackTrace(System.out);
  %>
  <jsp:forward page="BackResultsError.jsp?message=operator is Null in session!" />
  <%
  }
  perm.setFuncID(funcID);
  perm.setUserID(userID);
  if(!perm.isPermitted())
{%>
<jsp:forward page="BackResultsError.jsp?message=Sorry! You have no permission!" />

<%}
	pageNo = (Integer.valueOf(getPageNo(request,"pageNo"))).intValue();

	System.out.println("pageNo is "+pageNo);

	prePageNo = pageNo - 1;
	nextPageNo = pageNo + 1;
	news_id = request.getParameter("news_id");
	System.out.println("news id "+news_id);
	if (news_id != null && !news_id.equals(""))
	{
		sql_del_news_l = "delete from news_l where news_id = \'"+news_id+"\'";
		sql_del_news = "delete from news where news_id = \'"+news_id+"\'";
		sql_del_array = new String[2];
		sql_del_array[0] = sql_del_news_l;
		sql_del_array[1] = sql_del_news;
		if (!jdbc.executeUpdate(sql_del_array))
		{%>
		<jsp:forward page="../ResultsError.jsp?message=Delete Record in News Fail!" />
		<%}
	}
	rowCount = jdbc.getRowCount("news","");
	if ((rowCount%rowPerPage)==0)
		pageCount = rowCount/rowPerPage ;
	else
		pageCount = rowCount/rowPerPage + 1;
	subSql = "select a.news_id,a.publish_date,a.order_no,b.title,a.template_id,c.dir,b.htmlfile,b.lang_code,RowNum rid ";
	subSql+= "from news a,news_l b,dir_setting c where a.news_id = b.news_id and (c.dir_id = b.html_dirid or c.dir_id = a.dirid) and b.lang_code = 'EN'";

	sql = "select news_id ,to_char(publish_date,'YYYY-MM-DD') publish,title,template_id,dir,htmlfile,lang_code from ("+subSql+
	      ") where rid > " +(pageNo-1)*rowPerPage+" and rid <= "+pageNo*rowPerPage+" order by order_no desc"; 
	System.out.println(sql);
        try
	{
	   results = jdbc.executeQuery(sql);
   	   if (results[0] == null)
	   {	%> <jsp:forward page="BackResultsError.jsp?message=No Record!" /> <%}

	} catch (Exception e)
	{	
	   e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=No Record!" /> <%
 	//System.out.println(sql);
	}
	res.setResult(results);
%> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"> 
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --><!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
<SCRIPT language=JavaScript>
<!--
function js_callpage(htmlurl) {
  var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=566,height=327");
  return false;
}
function js_call() {
  pick_tai=document.tv_form.tai_select.options[document.tv_form.tai_select.selectedIndex].value;
  pick_week=document.tv_form.week_select.options[document.tv_form.week_select.selectedIndex].value;
  parent.window.location.href=pick_tai+"-"+pick_week+"\.html";
}
function getNewPage(pageno)
  {
    document.NewsDel.pageNo.value=pageno;
    document.NewsDel.submit();
  }

  function NewsDelete(news_id,pageno)
  {
    document.NewsDel.news_id.value = news_id;
    if(confirm("Do you want to delete the news?"))
    {
      document.NewsDel.submit();
    }
  }
//-->
</SCRIPT>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
     <P class=legal-notice> <%
  	  while (res.hasNext())
      {%> 
      <TR> 
	<TD>&nbsp; </TD>
	<TD width="80%">
      <BR>
        <%=res.getObject("publish").toString()%><A target="_blank"
      <%
        if (res.getObject("template_id").toString().equals("0"))
	{
	  dir = res.getObject("dir").toString();
	 if (!dir.endsWith("/"))
              dir += "/";
      %>
         href="<%=dir+res.getObject("htmlfile").toString()%>"> <%}
        else
	{%> href="../news/NewsStyle<%=res.getObject("template_id").toString()%>.jsp?news_id=<%=res.getObject("news_id").toString()%>&&lang_code=<%=res.getObject("lang_code").toString()%>"> 
        <%}
      %> <BR>
        <%=res.getObject("title").toString()%> </A>
	<div align="right"><a href="javascript:NewsDelete('<%=res.getObject("news_id").toString()%>')">[Delete]</a>
	<BR>
	</td>

	</TR>
        <%
	 res.next();
      }%> </P>
    
  </TBODY> 
</TABLE>
<BR>
<form name="NewsDel" method="post" action="DelNews.jsp">
  <input type="hidden" name="pageNo">
  <input type="hidden" name="news_id">
</form>
<!-- #EndEditable --> 
</body>
<!-- #EndTemplate --></html>

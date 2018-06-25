<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>


<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ForBrand.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="public.css">
<SCRIPT language=JavaScript>

function js_callpage(htmlurl) {
  var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=566,height=327");
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

<!-- #BeginEditable "body" --> 
<%!
	String sql_ins_news = null;
	String sql_ins_news_l=null;
	String sql_seq_news = null;
	String[] sql_array = null;
	Hashtable[] results = null;

	String lang_code = null;
	String template_code = null;
	String image_title= null;
	String image_dir = null;
	String i_filename = null;
	String sn_dir = null;
	String sn_filename = null;
	String source = null;
	String order_no = null;
	String publish_date = null;
	String title = null;
	String sub_title = null;
	String detail = null;

	String news_id = null;
	String fileField = null;
	String tempStr = null;
	int i,count;

%>

<jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" />
<jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" />
<jsp:useBean id="upload" scope="page" class="com.jspsmart.upload.SmartUpload" />

<%

	upload.initialize(pageContext);
	upload.upload();
        template_code = upload.getRequest().getParameter("template_code");
	try
	  {
	    if (template_code.equals("0"))
	    {
	        count = upload.save("/usr/local/apache/htdocs"+upload.getRequest().getParameter("sn_dirname"));
	    }
	    else
	    {

	        System.out.println("/usr/local/apache/htdocs"+upload.getRequest().getParameter("i_dirname"));
		count = upload.save("/usr/local/apache/htdocs"+upload.getRequest().getParameter("i_dirname"));
	    }
	%>

	    <p><%=count%> files is uploaded.</p>
	<%
      
	 for (int i=0;i<upload.getFiles().getCount();i++)
	  {
	    fileField = upload.getFiles().getFile(i).getFieldName();
	    System.out.println(fileField);
	    if (fileField.equals("i_filename"))
	    {
	      i_filename = upload.getFiles().getFile(i).getFileName();
	      System.out.println(i_filename);
	    }
	    if (fileField.equals("sn_filename"))
	    {
	      sn_filename = upload.getFiles().getFile(i).getFileName();
	      System.out.println(sn_filename);
	    }
	  }
	}//try
	catch (Exception e)
	{
	   e.printStackTrace(System.out);
	}
	
	lang_code = upload.getRequest().getParameter("lang_code");
	if (template_code.equals("0"))
	{
		sn_dir = upload.getRequest().getParameter("sn_dir");
		//sn_filename = upload.getRequest().getParameter("sn_filename");
	}
	else
	{
		image_title = upload.getRequest().getParameter("image_title");
		image_dir = upload.getRequest().getParameter("image_dir");
		//i_filename = upload.getRequest().getParameter("i_filename");
		detail = upload.getRequest().getParameter("detail");
	}

	order_no = upload.getRequest().getParameter("order_no");
	publish_date = upload.getRequest().getParameter("publish_date");
	source = upload.getRequest().getParameter("source");
	title = upload.getRequest().getParameter("title");
	sub_title = upload.getRequest().getParameter("sub_title");

	sql_seq_news = "select seq_news_id.NEXTVAL news_id from dual";
	results = jdbc.executeQuery(sql_seq_news);
	res.setResult(results);
	if(res.hasNext())
	{
	   news_id = res.getObject("news_id").toString();
	}
	System.out.println("news_id is "+news_id);
	System.out.println("");
	if (template_code.equals("0"))
	{
	sql_ins_news = "insert into news values("+Integer.parseInt(news_id)+",'',to_date(\'"+publish_date+"\','YYYY-MM-DD'),'','',"+
			Integer.parseInt(template_code)+","+Integer.parseInt(order_no)+",'',Sysdate,Sysdate,'N')";
	sql_ins_news_l = "insert into news_l values("+Integer.parseInt(news_id)+",\'"+lang_code+"\',\'"+title+"\',\'"+sub_title+"\','none','',\'"+
			source+"\',"+Integer.parseInt(sn_dir)+",\'"+sn_filename+"\','N')";
	}
	else
	{
	sql_ins_news = "insert into news values("+Integer.parseInt(news_id)+",'',to_date(\'"+publish_date+"\','YYYY-MM-DD'),"+
			Integer.parseInt(image_dir)+",\'"+i_filename+"\',"+Integer.parseInt(template_code)+","+
			Integer.parseInt(order_no)+",'',Sysdate,Sysdate,'N')";
	sql_ins_news_l = "insert into news_l values("+Integer.parseInt(news_id)+",\'"+lang_code+"\',\'"+title+"\',\'"+sub_title+"\',\'"+
			detail+"\',\'"+image_title+"\',\'"+source+"\','','','N')";
	}
	System.out.println("sql_ins_news is "+sql_ins_news);
	System.out.println("sql_ins_news_l is "+sql_ins_news_l);
	sql_array = new String[2];
	sql_array[0] = sql_ins_news;
	sql_array[1] = sql_ins_news_l;

	try
	{
	if (jdbc.executeUpdate(sql_array))
	{%>
<!--	<p>Insert News and News_L Success</p>-->
	  <jsp:forward page="BackResultsError.jsp?message=Insert News and News_L Success!" />
	<%
	}
	else
	{
        %>
<!--	  <p>Insert News and News_L Fail,please try again.</p>-->
	  <jsp:forward page="BackResultsError.jsp?message=Insert News and News_L Fail,please try again." />
	<%}
	}catch(Exception e)
	{e.printStackTrace(System.out);}
	
%>
<table width="755" border="0" cellspacing="4" cellpadding="4">
  <tr> 
	
  </tr>
</table>
<br>
<!-- #EndEditable --> 

</body>
<!-- #EndTemplate --></html>

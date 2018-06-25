<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>


<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ForBrand.com</title>
<!-- #EndEditable --> 
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
function i_setDir()
  {
    document.addNews.i_dirname.value = document.addNews.image_dir.options[document.addNews.image_dir.selectedIndex].text;
//    alert(document.addNews.i_dirname.value);
  }
function sn_setDir()
  {
    document.addNews.sn_dirname.value = document.addNews.sn_dir.options[document.addNews.sn_dir.selectedIndex].text;
  }

function display(index)
{
   window.location.href ="http://dbserver/forbrand/bst/AddNews.jsp?id="+index;   
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
    if(!checkDate(document.addNews.publish_date.value))
    {
      document.addNews.publish_date.focus();
      return false;
    }
  }
//-->
</SCRIPT>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- #BeginEditable "body" --> 
<%!
	String sql = null;
	Hashtable[] results = null;
	String id = null;
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
	id = request.getParameter("id");
%>

<form name="addNews" method="post" action="AddNews2.jsp" enctype="multipart/form-data" onSubmit="return validateForm(addNews)">
<table width="755" border="0" cellspacing="4" cellpadding="4">
  <tr> 
    <td class="xiaolei">Language:</td>
<%
	sql = "select * from lang_desc";
	System.out.println(sql);
	results = jdbc.executeQuery(sql);
	res.setResult(results);
%>
    <td class="xiaolei"><select name="lang_code">
        <%
	while(res.hasNext())
	{
	if (res.getObject("lang_code").toString().equals("EN"))
	{
	%>
		<option class="xiaolei" value=<%=res.getObject("lang_code").toString()%> selected><%=res.getObject("descr").toString()%></option>
	<%}
	else
	{%>
		<option class="xiaolei" value=<%=res.getObject("lang_code").toString()%>><%=res.getObject("descr").toString()%></option>
	<%}
	res.next();
	}
	sql = null;
	%>
	</select>
    </td>
    <td class="xiaolei">Template:</td>
    <td class="xiaolei"><select name="template_code" onChange="display(this.selectedIndex)">
    <% if (id.equals("0"))
       {%>
        <option class="xiaolei" value='0' selected>Static Page</option>
	<option class="xiaolei" value='1'>Image on the left</option>
      <%}
       if (id.equals("1"))
      {%>
        <option class="xiaolei" value='0'>Static Page</option>
	<option class="xiaolei" value='1' selected>Image on the left</option>
      <%}%>
	</select>
    </td>
  </tr>
  <tr>
  <% if (id.equals("1"))
       {%>
    <td class="xiaolei">Image Title:</td>
    <td class="xiaolei"><input type=text name="image_title"></td>
    <td class="xiaolei">Image SaveAs Dir:</td>
<%
	sql = "select dir_id,dir from dir_setting";
	System.out.println(sql);
	results = jdbc.executeQuery(sql);
	res.setResult(results);
%>

    <td class="xiaolei"><select name="image_dir" onChange="i_setDir()">
        <option value="">---choose---</option>
	<%while(res.hasNext())
	{%>
	<option class="xiaolei" value=<%=res.getObject("dir_id").toString()%>><%=res.getObject("dir").toString()%></option>
	<%
	res.next();
	}
	sql = null;
	%>
	</select>
	<input type=hidden name="i_dirname">
    </td>
  </tr>
  <tr>
  <td class="xiaolei">Image FileName:</td>
  <td class="xiaolei"><input type=file name="i_filename"></td>
   <%}
      if (id.equals("0"))
   {%>
  <td class="xiaolei">StaticNews SaveAs Dir:</td>
<%
	sql = "select dir_id,dir from dir_setting";
	System.out.println(sql);
	results = jdbc.executeQuery(sql);
	res.setResult(results);
%>

    <td class="xiaolei"><select name="sn_dir" onChange="sn_setDir()">
        <option class="xiaolei" value="">---choose---</option>
	<%while(res.hasNext())
	{%>
	<option class="xiaolei" value=<%=res.getObject("dir_id").toString()%>><%=res.getObject("dir").toString()%></option>
	<%
	res.next();
	}
	sql = null;
	%>
	</select>
	<input type="hidden" name="sn_dirname">
    </td>
  <td class="xiaolei">StaticNews FileName:</td>
  <td class="xiaolei"><input class="xiaolei" type=file name="sn_filename"></td></tr><tr>
  <%}%>
  <td class="xiaolei">News Source:</td>
  <td class="xiaolei"><input class="xiaolei" type=text name="source"></td>	
  </tr>
  <tr>
  <td class="xiaolei">News Order_No:</td>
  <td class="xiaolei"><input class="xiaolei" type=text name="order_no"></td>	
  <td class="xiaolei">Publish Date:</td>
  <td class="xiaolei"><input class="xiaolei" type=text name="publish_date">(yyyy-mm-dd)</td>	
  </tr>
  </tr>
  </table>
  <table border="0">
  <tr>
  <td class="xiaolei">News Title:</td>
  <td class="xiaolei"><input class="xiaolei" type=text name="title" ></td>	
  </tr>
   <tr>
  <td class="xiaolei">News SubTitle:</td>
  <td class="xiaolei"><input class="xiaolei" type=text name="sub_title" ></td>	
  </tr>
<%  if (id.equals("1"))
{%>
  <tr>
  <td class="xiaolei">News Detail:</td>
  <td class="xiaolei"><textarea class="xiaolei" name="detail" cols="50" rows="25"></textarea></td>	
  </tr>
  <%}%>
  </table>

  <table align="center" border = 0>
  <tr>
  <td class="xiaolei"><input type=submit name=submit value="Add"></td>
  <td class="xiaolei" colspan="10">&nbsp;</td>
  <td class="xiaolei"><input type=reset name=reset value="Reset"></td>
  </tr>
  </table>
</form>
<br>
<!-- #EndEditable --> 
</body>
<!-- #EndTemplate --></html>

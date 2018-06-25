<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" %>

<html>
<head>
<title>Forbrand Gift</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="/public.css">
<style type="text/css">
<!--
.layer1 {  background-color: #CCCCFF; border-color: #3333FF #FFFFFF #FFFFFF #3333FF; filter: Alpha(Opacity=100, FinishOpacity=0, Style=1, StartX=0, StartY=0, FinishX=100, FinishY=100); border-style: solid; border-top-width: 1px; border-left-width: 1px; height: 177px; width: 616px; left: 53px; clip:  rect(   )}
-->
</style>
<SCRIPT language=JavaScript>
<!--
  function setDir()
  {
    document.addGift.pic_dirname.value = document.addGift.pic_dir.options[document.addGift.pic_dir.selectedIndex].text;
//    alert(document.addGift.pic_dirname.value);
  }

//-->
</SCRIPT>
</head>

<body bgcolor="#FFFFFF">
<!-- #BeginEditable "body" --> 
<%!
	String sql = null;
	Hashtable[] results = null;
	String funcID = null;
	String userID = null;
%>

<jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" />
<jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" />
<jsp:useBean id="perm" scope="page" class="com.cig.permission.Permission" />

<%
  funcID = "fnGiftMg";
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

<%}%>

<form name="addGift" method="post" action="AddGift2.jsp" enctype="multipart/form-data">
  <div id="Layer8" style="position:absolute; left:54px; top:13px; width:498px; height:177px; z-index:2" class="layer1"> 
    <table width="54%" border="0" height="91" class="black-m-text" align="left">
      <tr> 
        <td class="dalei" height="17">Gift Name</td>
        <td height="17"> 
          <input type="text" name="gift_name" size="10">
        </td>
        <td class="dalei">Language:</td>
        <td> 
	<%
	sql = "select * from lang_desc";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in lang_desc!" /><%} 
	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in lang_desc!" /> 
        <%
	}

	res.setResult(results);
	%> 

        <select name="lang_code">
        <%
	while(res.hasNext())
	{
	if (res.getObject("lang_code").toString().equals("EN"))
	{
	%> 
            <option value=<%=res.getObject("lang_code").toString()%> selected><%=res.getObject("descr").toString()%></option>
        <%}
	else
	{%> 
	    <option value=<%=res.getObject("lang_code").toString()%>><%=res.getObject("descr").toString()%></option>
        <%}
	res.next();
	}
	sql = null;
	%> 
          </select>
        </td>
      </tr>
      <tr> 
        <td class="dalei">Color Desc</td>
        <td> 
          <input type="text" name="colordesc" size="10">
        </td>
        <td class="dalei">Descr</td>
        
        <td> 
          <input type="text" name="descr" size="10">
        </td>
      </tr>
      <tr> 
        <td class="dalei">Category</td>
        <td>
	<%
	sql = "select * from category";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in Category!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in Category!" /> 
        <%
	}
	res.setResult(results);
	%> 
        <select name="category">
            <option value="">---choose---</option>
        <%while(res.hasNext())
	{%> 
            <option value=<%=res.getObject("cate_id").toString()%>><%=res.getObject("catename").toString()%></option>
        <%
	res.next();
	}
	sql = null;
	%> 
        </select>
        </td>
        <td class="dalei">Material</td>
        <td> 
	<%
	sql = "select * from material";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in Material!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in Material!" /> 
        <%
	}
	res.setResult(results);
	%> 
        <select name="material">
            <option value="">---choose---</option>
        <%while(res.hasNext())
	{%> 
            <option value=<%=res.getObject("material_id").toString()%>><%=res.getObject("materialname").toString()%></option>
        <%
	res.next();
	}
	sql = null;
	%> 
          </select>
        </td>
      </tr>
      <tr> 
        <td class="dalei" >Manufacture</td>
        <td> 
          <input type="text" name="manufacture" size="10">
        </td>
        <td class="dalei" >Product No.</td>
        <td> 
          <input type="text" name="product_no" size="10">
        </td>
      </tr>
      <tr> 
        <td class="dalei" >Custom MadeInfo</td>
        <td> 
          <input type="text" name="custommadeinfo" size="10">
        </td>
        <td class="dalei">Part Material</td>
        <td> 
          <input type="text" name="partmaterial" size="10">
        </td>
      </tr>
    </table>
</div>
  <div id="Layer4" style="position:absolute; left:56px; top:586px; width:497px; height:204px; z-index:2" class="layer1"> 
    <table width="47%" border="0" height="91" class="black-m-text" align="left">
      <tr align="center" valign="bottom"> 
        <td height="23" class="dalei" colspan="4"> 
          <div align="left">Pack</div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="13%">Length</td>
        <td width="24%"> 
          <input type="text" name="p_length" size="10">
        </td>
        <td width="22%" class="dalei"> 
          <div align="center">Unit_M</div>
        </td>
        <td width="24%" class="dalei"> 
          <div align="center">Unit_I</div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="13%">Width</td>
        <td width="24%"> 
          <input type="text" name="p_width" size="10">
        </td>

        <td width="22%">
	<%
	sql = "select * from unit where unitflag = 'L' and measure = 'M'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LM)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LM)!" /> <%
	}
	res.setResult(results);
       %>
          <div align="center"> 
            <select name="p_unit_lm">
		 <option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
            </select>
          </div>
        </td>
        <td width="24%"> 
	<%
	sql = "select * from unit where unitflag = 'L' and measure = 'I'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LI)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LI)!" /> <%
	}
	res.setResult(results);
        %>
          <div align="center"> 
            <select name="p_unit_li">
		<option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
		</select>
          </div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="13%">Height</td>
        <td width="24%"> 
          <input type="text" name="p_height" size="10">
        </td>
        <td width="22%">&nbsp; </td>
        <td width="24%">&nbsp;</td>
      </tr>
      <tr> 
        <td class="dalei" width="13%">GrsWt</td>
        <td width="24%"> 
          <input type="text" name="p_grswt" size="10">
        </td>
        <td width="22%"> 
	<%
	sql = "select * from unit where unitflag = 'W' and measure = 'M'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(WM)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(WM)!" /> <%
	}
	res.setResult(results);
        %>
          <div align="center"> 
            <select name="p_unit_wm">
              	<option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
            </select>
          </div>
        </td>
        <td width="24%"> 
	<%
	sql = "select * from unit where unitflag = 'W' and measure = 'I'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(WI)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(WI)!" /> <%
	}
	res.setResult(results);
        %>
          <div align="center"> 
            <select name="p_unit_wi">
              	<option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
            </select>
          </div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="13%" height="5">NetWt</td>
        <td width="24%" height="5"> 
          <input type="text" name="p_netwt" size="10">
        </td>
        <td width="22%" height="5">&nbsp; </td>
        <td width="24%" height="5">&nbsp; </td>
      </tr>
    </table>
</div>
  <div id="Layer2" style="position:absolute; left:54px; top:204px; width:497px; height:177px; z-index:2" class="layer1"> 
    <table width="60%" border="0" height="91" class="black-m-text" align="left">
      <tr> 
        <td class="dalei" height="9" width="40%">&nbsp;</td>
        <td height="9" width="60%">&nbsp; </td>
    </tr>
    <tr> 
      <td class="dalei" width="40%">Picture Dir</td>
      <%
	sql = "select dir_id,dir from dir_setting";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in dir_setting!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in dir_setting!" /> <%
	}
	res.setResult(results);
     %>
      <td width="60%"> 
        <select name="pic_dir" onChange="setDir()">
        <option value="">---choose---</option>
	<%while(res.hasNext())
	{%>
	<option value=<%=res.getObject("dir_id").toString()%>><%=res.getObject("dir").toString()%></option>
	<%
	res.next();
	}
	sql = null;
	%>
        </select>
	<input type=hidden name="pic_dirname">
      </td>
    </tr>
    <tr> 
      <td class="dalei" width="40%">SmallPicture File name </td>
      <td width="60%"> 
        <input type="file" name="smallpic_file">
      </td>
    </tr>
    <tr> 
      <td class="dalei" width="40%">LargePicture File name</td>
      <td width="60%"> 
        <input type="file" name="largepic_file">
      </td>
    </tr>
  </table>
</div>
  <div id="Layer3" style="position:absolute; left:55px; top:395px; width:498px; height:177px; z-index:2" class="layer1"> 
    <table width="47%" border="0" height="91" class="black-m-text" align="left">
      <tr align="center" valign="bottom"> 
        <td height="23" class="dalei" colspan="4"> 
          <div align="left">Gift</div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="13%">Length</td>
        <td width="24%"> 
          <input type="text" name="g_length" size="10">
        </td>
        <td width="22%" class="dalei"> 
          <div align="center">Unit_M</div>
        </td>
        <td width="25%" class="dalei"> 
          <div align="center">Unit_I</div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="13%">Width</td>
        <td width="24%"> 
          <input type="text" name="g_width" size="10">
        </td>
        <td width="22%">
	<%
	sql = "select * from unit where unitflag = 'L' and measure = 'M'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LM)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LM)!" /> <%
	}
	res.setResult(results);
        %>

          <div align="center"> 
            <select name="g_unit_lm">
             <option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
            </select>
          </div>
        </td>
        <td width="25%"> 
	<%
	sql = "select * from unit where unitflag = 'L' and measure = 'I'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LI)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LI)!" /> <%
	}
	res.setResult(results);
        %>
          <div align="center"> 
            <select name="g_unit_li">
		<option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
		</select>
          </div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="13%">Height</td>
        <td width="24%"> 
          <input type="text" name="g_height" size="10">
        </td>
        <td width="22%" class="dalei">&nbsp; </td>
        <td width="25%">&nbsp;</td>
      </tr>
      <tr> 
        <td class="dalei" width="13%">Weight</td>
        <td width="24%"> 
          <input type="text" name="g_weight" size="10">
        </td>
        <td width="22%"> 
	<%
	sql = "select * from unit where unitflag = 'W' and measure = 'M'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(WM)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(WM)!" /> <%
	}
	res.setResult(results);
        %>
          <div align="center"> 
            <select name="g_unit_wm">
              <option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
            </select>
          </div>
        </td>
        <td width="25%">
	<%
	sql = "select * from unit where unitflag = 'W' and measure = 'I'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(WI)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(WI)!" /> <%
	}
	res.setResult(results);
        %>
          <div align="center"> 
            <select name="g_unit_wi">
              <option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
            </select>
          </div>
        </td>
      </tr>
    </table>
</div>
  <div id="Layer5" style="position:absolute; left:56px; top:1196px; width:498px; height:149px; z-index:2" class="layer1"> 
    <table width="38%" border="0" height="91" class="black-m-text" align="left">
      <tr align="center" valign="bottom"> 
        <td height="16" class="dalei" colspan="3"> 
          <div align="center"></div>
      </td>
    </tr>
    <tr> 
      <td class="dalei" colspan="2">Consignment Date</td>
      <td width="46%"> 
        <input type="text" name="consignment_date" size="10">
      </td>
    </tr>
    <tr> 
      <td class="dalei" colspan="2">Quantity / Pack</td>
      <td width="46%"> 
        <input type="text" name="quantity_pack" size="10">
      </td>
    </tr>
  </table>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <table align="left" border = 0>
      <tr> 
        <td>
          <input type=submit name=submit value="Add">
        </td>
        <td colspan="10">&nbsp;</td>
        <td>
          <input type=reset name=reset value="Reset">
        </td>
      </tr>
    </table>
    <p>&nbsp;</p>
  </div>
  <div id="Layer6" style="position:absolute; left:56px; top:805px; width:499px; height:152px; z-index:2" class="layer1"> 
    <table width="47%" border="0" height="91" class="black-m-text" align="left">
      <tr align="center" valign="bottom"> 
        <td height="25" class="dalei" colspan="4"> 
          <div align="left">Color Pack</div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="14%">Length</td>
        <td width="22%"> 
          <input type="text" name="cp_length" size="10">
        </td>
        <td width="21%" class="dalei"> 
          <div align="center">Unit_M</div>
        </td>
        <td width="25%" class="dalei"> 
          <div align="center">Unit_I</div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="14%">Width</td>
        <td width="22%"> 
          <input type="text" name="cp_width" size="10">
        </td>
        <td width="21%"> 
	<%
	sql = "select * from unit where unitflag = 'L' and measure = 'M'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LM)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LM)!" /> <%
	}
	res.setResult(results);
        %>
          <div align="center"> 
            <select name="cp_unit_lm">
		<option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
		</select>
          </div>
        </td>
        <td width="25%"> 
	<%
	sql = "select * from unit where unitflag = 'L' and measure = 'I'";
	System.out.println(sql);
	try
	{
	results = jdbc.executeQuery(sql);
	if(results[0] == null)
	{%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LI)!" /><%} 

	}catch(Exception e)
	{
	e.printStackTrace(System.out);
	%> <jsp:forward page="BackResultsError.jsp?message=Empty Data in unit(LI)!" /> <%
	}
	res.setResult(results);
        %>
          <div align="center"> 
            <select name="cp_unit_li">
              <option value="">---choose---</option>
		<%while(res.hasNext())
		{%>
		<option value=<%=res.getObject("unit").toString()%>><%=res.getObject("unit").toString()%></option>
		<%
		res.next();
		}
		sql = null;
		%>
            </select>
          </div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" width="14%">Height</td>
        <td width="22%"> 
          <input type="text" name="cp_height" size="10">
        </td>
        <td width="21%">&nbsp; </td>
        <td width="25%">&nbsp;</td>
      </tr>
    </table>
</div>
  <div id="Layer7" style="position:absolute; left:56px; top:971px; width:497px; height:211px; z-index:2" class="layer1"> 
    <table width="31%" border="0" height="91" class="black-m-text" align="left">
      <tr align="center" valign="bottom"> 
        <td height="11" class="dalei" colspan="5"> 
          <div align="center"></div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" colspan="2"></td>
        <td width="43%" class="dalei"> 
          <div align="center">Price </div>
        <td width="43%" class="dalei"> 
          <div align="center">Quantity_Low </div>
        </td>
        <td width="42%" class="dalei"> 
          <div align="center">Quantity_High</div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" colspan="2">1</td>
        <td width="43%"> 
          <div align="center"> 
            <input type="text" name="price" size="10">
          </div>
        </td>
        <td width="43%"> 
          <div align="center"> 
            <input type="text" name="quantity_l" size="10">
          </div>
        </td>
        <td width="42%"> 
          <div align="center"> 
            <input type="text" name="quantity_u" size="10">
          </div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" colspan="2">2</td>
        <td width="43%"> 
          <div align="center"> 
            <input type="text" name="price" size="10">
          </div>
        </td>
        <td width="42%"> 
          <div align="center"> 
            <input type="text" name="quantity_l" size="10">
          </div>
        </td>
        <td width="43%"> 
          <div align="center"> 
            <input type="text" name="quantity_u" size="10">
          </div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" colspan="2">3</td>
        <td width="43%"> 
          <div align="center"> 
            <input type="text" name="price" size="10">
          </div>
        </td>
        <td width="42%"> 
          <div align="center"> 
            <input type="text" name="quantity_l" size="10">
          </div>
        </td>
        <td width="43%"> 
          <div align="center"> 
            <input type="text" name="quantity_u" size="10">
          </div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" colspan="2">4</td>
        <td width="43%" height="5"> 
          <div align="center"> 
            <input type="text" name="price" size="10">
          </div>
        </td>
        <td width="42%" height="5"> 
          <div align="center"> 
            <input type="text" name="quantity_l" size="10">
          </div>
        </td>
        <td width="43%"> 
          <div align="center"> 
            <input type="text" name="quantity_u" size="10">
          </div>
        </td>
      </tr>
      <tr> 
        <td class="dalei" colspan="2">5</td>
        <td width="43%" height="5"> 
          <div align="center"> 
            <input type="text" name="price" size="10">
          </div>
        </td>
        <td width="42%" height="5"> 
          <div align="center"> 
            <input type="text" name="quantity_l" size="10">
          </div>
        </td>
        <td width="43%"> 
          <div align="center"> 
            <input type="text" name="quantity_u" size="10">
          </div>
        </td>
      </tr>
    </table>
  </div>
  
</form>
<!-- #EndEditable --> 
</body>
</html>

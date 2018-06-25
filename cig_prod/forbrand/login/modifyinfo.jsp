<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="error.jsp"%>
<jsp:useBean id="login" scope="request" class="com.forbrand.member.LoginBean"/>
<jsp:setProperty name="login" property="*"/>


<% if(session.getAttribute("userid")==null) {%>
<jsp:forward page="../ResultsError.jsp?message=You haven't log in."/>
<% } %>
<% login.getUserInfo((String)session.getAttribute("userid"));%>

<jsp:setProperty name="login" property="*"/>

<html><!-- #BeginTemplate "/Templates/usermenu.dwt" -->
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
function js_call() {
  pick_tai=document.tv_form.tai_select.options[document.tv_form.tai_select.selectedIndex].value;
  pick_week=document.tv_form.week_select.options[document.tv_form.week_select.selectedIndex].value;
  parent.window.location.href=pick_tai+"-"+pick_week+"\.html";
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="initselect()">
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
    <td rowspan=2> <a href="../../index.html"><img src="../../images/img-sea/search_01.gif" width=54 height=50 border="0"></a></td>
    <td colspan=6> <img src="../../images/img-sea/search_02.gif" width=704 height=32 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="380,13,458,26" href="../show/portinfo.jsp"><area shape="rect" coords="482,13,555,26" href="myaccount.jsp"><area shape="rect" coords="583,12,692,26" href="../show/cart.jsp"></map></td>
  </tr>
  <tr> 
    <td> <img src="../../images/img-sea/search_03.gif" width=73 height=18></td>
    <td colspan=5> <img src="../../images/img-sea/search_04.gif" width=631 height=18 usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="116,3,204,15" href="../show/showroom.jsp"><area shape="rect" coords="301,4,405,13" href="../show/giftoccasion.jsp?langCode=EN"><area shape="rect" coords="429,3,535,14" href="specialorder.jsp"><area shape="rect" coords="550,3,617,14" href="../show/showinside.jsp?act=4&langCode=EN"><area shape="rect" coords="222,4,284,14" href="../show/showinside.jsp?act=3&langCode=EN"></map></td>
  </tr>
  <tr> 
    <td colspan=3 rowspan=3 background="/images/background1_05.gif"> 
      <blockquote> 
        <p><span class="orange-title1">MY ACCOUNT</span>:<span class="dalei"><!-- #BeginEditable "subtitle" -->Modify my regist information.<!-- #EndEditable --></span></p>
      </blockquote>
      </td> 
    <td colspan=4> <img src="../../images/img-sea/search_06.gif" width=188 height=42 usemap="#Map3" border="0"><map name="Map3"><area shape="rect" coords="13,9,121,22" href="../show/search.jsp"></map></td>
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
  </tr>
  <tr> 
    <td colspan=2> <img src="/images/img-sea/search_11.gif" width=128 height=11></td>
  </tr>
</table>
<table width="753" border="0">
  <tr> 
    <td width="180" height="235" valign="top" align="center"> 
      <p><span class="dalei"><!-- #BeginEditable "imgchange" --><span class="dalei"><img src="../../images/hanging.jpg" width="144" height="101"></span><!-- #EndEditable --><br>
        <br>
        <br>
        <a href="afterlog.html" class="xiaolei">Back to My Account 
        Main</a></span></p>
    </td>
    <td width="566" height="235" valign="top"><!-- #BeginEditable "mainbody" -->
<% login.fetchCityInfo("EN"); %>
          <script src="/js/formcheck.js"></script>
          <script language="JavaScript">
	var countryStr = "<jsp:getProperty name='login' property='country'/>"
	var countryID = "<jsp:getProperty name='login' property='countryID'/>"
	var stateStr = "<jsp:getProperty name='login' property='state'/>"
	var stateID = "<jsp:getProperty name='login' property='stateID'/>"
	var cityStr = "<jsp:getProperty name='login' property='city'/>"

	function citychange()
	{
		savect()
		if(document.modform.city_ID1.selectedIndex!=0)
			document.modform.city_name.style.visibility = "hidden"
		else
			document.modform.city_name.style.visibility = "visible"
	}

	function statechange(num1,num2)
	{
		savest()
		var temp1 = cityStr.split(";")
		var temp2 = temp1[num1].split(":")
		var str = temp2[num2].split(",")

		if(str == null)
		{
			document.modform.city_ID1.length = 1
			document.modform.city_ID1.options[0].value = 0
			document.modform.city_ID1.options[0].text = "select:"
			document.modform.ctselect.value = 0
			return
		}

		document.modform.city_ID1.length = str.length
		document.modform.city_ID1.options[0].text = "select:"

		if(str!=null&&str.length>0)
		{
			for(i=1;i<str.length;i++)
			{
				document.modform.city_ID1.options[i].text = str[i-1]
				document.modform.city_ID1.options[i].value = str[i-1]
			}
		}
		if(document.modform.ctselect.value==null||document.modform.ctselect.value=="")
		{
			document.modform.city_ID1.options[0].selected = true
			document.modform.ctselect.value = 0
		}
		else
		{
			document.modform.city_ID1.selectedIndex = document.modform.ctselect.value
		}

	}

	function countrychange(num)
	{
		savecn()
		var temp1 = stateStr.split(";")
		var str = temp1[num].split(":")

		var temp2 = stateID.split(";")
		var sid = temp2[num].split(":")

		if(str == null)
		{
			document.modform.state_ID.length = 1
			document.modform.state_ID.options[0].value = 0
			document.modform.state_ID.options[0].text = "select:"
			statechange(num,0)
			return
		}

		document.modform.state_ID.length = str.length-1
		for(i=0;i<str.length-1;i++)
		{
			document.modform.state_ID.options[i].value = sid[i]
			document.modform.state_ID.options[i].text = str[i]
		}
		if(document.modform.stselect.value==null||document.modform.stselect.value=="")
		{
			document.modform.state_ID.options[0].selected = true
			document.modform.stselect.value = 0
			statechange(num,0)
		}
		else
		{
			document.modform.state_ID.selectedIndex = document.modform.stselect.value
			statechange(num,document.modform.stselect.value)
		}
	}

	function showCountry()
	{
		var str = countryStr.split(";")
		var cnid = countryID.split(";")

		document.modform.country_ID.length = str.length-1
		for(i=0;i<str.length-1;i++)
		{
			document.modform.country_ID.options[i].value = cnid[i]
			document.modform.country_ID.options[i].text = str[i]
		}
		if(document.modform.cnselect.value==null||document.modform.cnselect.value=="")
		{
			document.modform.country_ID.options[0].selected = true
			document.modform.cnselect.value = 0
			countrychange(0)
		}
		else
		{
			document.modform.country_ID.selectedIndex = document.modform.cnselect.value
			countrychange(document.modform.cnselect.value)
		}
	}

	function setSelected(strvalue,itemtoset)
	{
		var selitem = strvalue
		for(i=0;i<itemtoset.length;i++)
		{	if(itemtoset.options[i].value==selitem)
			{	itemtoset.options[i].selected = true
				itemtoset.selectedIndex  = i
				break
			}
		}
	}
	
	function initselect()
	{
		showCountry()
		if(document.modform.cnselect.value==0)
		{
				setSelected("<jsp:getProperty name='login' property='country_ID'/>",document.modform.country_ID)
				countrychange(document.modform.country_ID.selectedIndex)
				setSelected("<jsp:getProperty name='login' property='state_ID'/>",document.modform.state_ID)
				statechange(document.modform.country_ID.selectedIndex,document.modform.state_ID.selectedIndex)
				setSelected("<jsp:getProperty name='login' property='city_ID'/>",document.modform.city_ID)
		}
	}

	function savecn()
	{
		document.modform.cnselect.value = document.modform.country_ID.selectedIndex
	}

	function savest()
	{
		document.modform.stselect.value = document.modform.state_ID.selectedIndex
	}

	function savect()
	{
		document.modform.ctselect.value = document.modform.city_ID1.selectedIndex
	}
	
	function chkmodform()
	{
		<!-- check the formvalue -->
		if(document.modform.firstname.value=="")
		{
			alert("Please enter your firstname!")
			return false
		}
		if(document.modform.lastname.value=="")
		{
			alert("Please enter your lastname!")
			return false
		}
		<!-- to decide the city_ID  -->
		if(document.modform.city_ID1.selectedIndex==0&&document.modform.city_name.value=="")
		{
			alert("Please specify you city!")
			return false
		}

		if(document.modform.city_ID1.selectedIndex==0)
		{	document.modform.city_ID.value =document.modform.city_name.value
		}
		else
		{	document.modform.city_ID.value =document.modform.city_ID1.options[document.modform.city_ID1.selectedIndex].value
		}
		<!-- finish city_ID -->
		if(document.modform.addr.value=="")
		{
			alert("Please enter your address!")
			return false
		}
		if(document.modform.postCode.value=="")
		{
			alert("Please enter your postcode!")
			return false
		}
		if(document.modform.tel.value=="")
		{
			alert("Please enter your phone number!")
			return false
		}
		if(document.modform.email.value=="")
		{
			alert("Please enter your email address!")
			return false
		}
		if(!checkEmail(document.modform.email))
		{
			alert("Invalaid Email Address!")
			return false
		}
		
		return true
	}
	</script>

            <form name="modform" method="post" action="modinforesult.jsp" onSubmit="return chkmodform()">
              
        <table width="100%" border="0" cellspacing="4" class="black-m-text">
          <tr> 
            <td class="black-m-text" width="19%">Email Address:</td>
            <td width="36%"> 
              <input type="text" name="email" size="20" maxlength="50" value="<jsp:getProperty name='login' property='email'/>">
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="19%"><span class="black-m-text">Phone</span>:</td>
            <td width="36%" > 
              <input type="text" name="tel" size="20" maxlength="20" value="<jsp:getProperty name='login' property='tel'/>">
              <font color="#FF0000">*</font> </td>
            <td width="45%" >&nbsp;</td>
          </tr>
          <tr> 
            <td class="black-m-text" width="19%">Title:</td>
            <td width="36%"> 
              <select
      name=sex>
                <option value="M" selected>Mr. </option>
                <option value="F">Ms.</option>
              </select>
              <font color="#FF0000">*</font> </td>
            <script language="JavaScript">
				setSelected("<jsp:getProperty name='login' property='sex'/>",document.modform.sex)
			</script>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">First Name: </td>
            <td width="36%"> 
              <input type="text" name="firstname" size="20" maxlength="50" value="<jsp:getProperty name='login' property='firstname'/>">
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">Last Name:</td>
            <td width="36%"> 
              <input type="text" name="lastname" size="20" maxlength="50" value="<jsp:getProperty name='login' property='lastname'/>">
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">Address: </td>
            <td width="36%"> 
              <input type="text" name="addr" maxlength="200" size="25" value="<jsp:getProperty name='login' property='addr'/>">
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text"><span class="black-m-text">Country:</span> 
            </td>
            <td width="36%"> 
              <select
      name=country_ID onChange="countrychange(this.selectedIndex)" onBlur="savecn()">
              	<option value=" "> 
              	<option value=" "> 
              </select>
              <font color="#FF0000">*</font> 
              <input type="hidden" name="login" value="<%=(String)session.getAttribute("userid")%>">
            </td>
            <td width="45%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">State or Province: </td>
            <td width="36%"> 
              <select
            name=state_ID onChange="statechange(document.modform.country_ID.selectedIndex,this.selectedIndex)" onBlur="savest()">
              	<option value=" "> 
              	<option value=" "> 
              </select>
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text" rowspan="2">City:</td>
            <td width="36%"> 
              <select
            name=city_ID1 onChange="citychange()" onBlur="savect()">
              	<option value=" "> 
              	<option value=" "> 
              </select>
              <font color="#FF0000">*</font> </td>
            <td width="45%" rowspan="2" class="black-m-text">(If your city isn't 
              in the list, please fill this input box.)</td>
          </tr>
          <tr>
            <td width="36%">
              <input type="text" name="city_name" value="<jsp:getProperty name='login' property='city_ID'/>">
              <input type="hidden" name="city_ID" value="">
            </td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text" height="30">Zip Code:</td>
            <td width="36%" height="30"> 
              <input
      maxlength=10 name=postCode size=10 value="<jsp:getProperty name='login' property='postCode'/>">
              <font color="#FF0000">*</font> </td>
            <td width="45%" height="30">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">Mobile:</td>
            <td width="36%"> 
              <input type="text" name="mobile" maxlength="50" size="30" value="<jsp:getProperty name='login' property='mobile'/>">
            </td>
            <td width="45%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">Fax:</td>
            <td width="36%"> 
              <input type="text" name="fax" maxlength="50" size="30" value="<jsp:getProperty name='login' property='fax'/>">
            </td>
            <td width="45%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">&nbsp;</td>
            <td width="36%"> 
              <div align="right"><input type="image" src="../../images/update-buttom.jpg" border="0">
							</div>
            </td>
            <td width="45%"> 
							<input type="hidden" name="cnselect" value="">
							<input type="hidden" name="stselect" value="">
							<input type="hidden" name="ctselect" value="">
            </td>
          </tr>
        </table>
            </form>
            <p class="contact">&nbsp;</p>

<br>
      <!-- #EndEditable --></td>
  </tr>
</table>
<br>
<table width=758 border=0 cellpadding=0 cellspacing=0>
  <tr> 
    <td> <img src="../../images/img-foot/footer_01.gif" width=376 height=23></td>
    <td> <a href="../../html/aboutus.html"><img src="../../images/img-foot/footer_02.gif" width=65 height=23 border="0"></a></td>
    <td> <a href="../../html/contactus.html"><img src="../../images/img-foot/footer_03.gif" width=76 height=23 border="0"></a></td>
    <td> <a href="../../html/sitemap.html"><img src="../../images/img-foot/footer_04.gif" width=65 height=23 border="0"></a></td>
    <td> <a href="../../html/help.html"><img src="../../images/img-foot/footer_05.gif" width=39 height=23 border="0"></a></td>
    <td> <a href="../../html/privacy.html"><img src="../../images/img-foot/footer_06.gif" width=55 height=23 border="0"></a></td>
    <td> <img src="../../images/img-foot/footer_07.gif" width=82 height=23></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

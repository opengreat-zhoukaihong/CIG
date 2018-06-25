<%@ page language="java" errorPage="error.jsp"%> <jsp:useBean id="login" scope="request" class="com.forbrand.member.LoginBean"/>
<jsp:setProperty name="login" property="*"/>
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
    <td rowspan=2> <a href="../../index.html"><img src="/images/img-sea/search_01.gif" width=54 height=50 border="0"></a></td>
    <td colspan=6> <img src="/images/img-sea/search_02.gif" width=704 height=32 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="381,13,459,26" href="../show/portinfo.jsp"><area shape="rect" coords="482,13,555,26" href="myaccount.jsp"><area shape="rect" coords="583,12,692,26" href="../show/cart.jsp" onClick="return js_callpage2(this.href)"></map></td>
  </tr>
  <tr> 
    <td> <img src="/images/img-sea/search_03.gif" width=73 height=18></td>
    <td colspan=5> <img src="/images/img-sea/search_04.gif" width=631 height=18 usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="116,3,204,15" href="../show/showroom.jsp"><area shape="rect" coords="302,3,407,12" href="../show/giftoccasion.jsp?langCode=EN"><area shape="rect" coords="429,3,535,14" href="specialorder.jsp"><area shape="rect" coords="550,3,617,14" href="../show/showinside.jsp?act=4&langCode=EN"><area shape="rect" coords="222,4,284,14" href="../show/showinside.jsp?act=3&langCode=EN"></map></td>
  </tr>
  <tr> <!-- #BeginEditable "replace" -->
    <td colspan=3 rowspan=3 background="../../html/images/background1_05.gif">
      <blockquote>
        <p><span class="orange-title1">MY ACCOUNT:</span> <span class="dalei">COMPLETE
          THE FOLLOWING FORM TO BECOME A REGISTER.</span></p>
      </blockquote>
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
<!-- #BeginEditable "body" -->
<table width="757" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="140" valign="top" align="center"> <img src="../../images/two.jpg" width="94" height="141"></td>
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
		if(document.regform.city_ID1.selectedIndex!=0)
		{	document.regform.city_name.style.visibility = "hidden" }
		else
		{	document.regform.city_name.style.visibility = "visible" }
	}

	function statechange(num1,num2)
	{
		savest()
		var temp1 = cityStr.split(";")
		var temp2 = temp1[num1].split(":")
		var str = temp2[num2].split(",")

		if(str == null)
		{
			document.regform.city_ID1.length = 1
			document.regform.city_ID1.options[0].value = 0
			document.regform.city_ID1.options[0].text = "select:"
			document.regform.ctselect.value = 0
			return
		}

		document.regform.city_ID1.length = str.length
		document.regform.city_ID1.options[0].text = "select:"
		if(str!=null&&str.length>0)
		{
			for(i=1;i<str.length;i++)
			{
				document.regform.city_ID1.options[i].text = str[i-1]
				document.regform.city_ID1.options[i].value = str[i-1]
			}
		}
		if(document.regform.ctselect.value==null||document.regform.ctselect.value=="")
		{
			document.regform.city_ID1.options[0].selected = true
			document.regform.ctselect.value = 0
		}
		else
		{
			document.regform.city_ID1.selectedIndex = document.regform.ctselect.value
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
			document.regform.state_ID.length = 1
			document.regform.state_ID.options[0].value = 0
			document.regform.state_ID.options[0].text = "select:"
			statechange(num,0)
			return
		}

		document.regform.state_ID.length = str.length-1
		for(i=0;i<str.length-1;i++)
		{
			document.regform.state_ID.options[i].value = sid[i]
			document.regform.state_ID.options[i].text = str[i]
		}
		if(document.regform.stselect.value==null||document.regform.stselect.value=="")
		{
			document.regform.state_ID.options[0].selected = true
			document.regform.stselect.value = 0
			statechange(num,0)
		}
		else
		{
			document.regform.state_ID.selectedIndex = document.regform.stselect.value
			statechange(num,document.regform.stselect.value)
		}
	}

	function showCountry()
	{
		var str = countryStr.split(";")
		var cnid = countryID.split(";")

		document.regform.country_ID.length = str.length-1
		for(i=0;i<str.length-1;i++)
		{
			document.regform.country_ID.options[i].value = cnid[i]
			document.regform.country_ID.options[i].text = str[i]
		}
		if(document.regform.cnselect.value==null||document.regform.cnselect.value=="")
		{
			document.regform.country_ID.options[0].selected = true
			document.regform.cnselect.value = 0
			countrychange(0)
		}
		else
		{
			document.regform.country_ID.selectedIndex = document.regform.cnselect.value
			countrychange(document.regform.cnselect.value)
		}
	}
	
	function savecn()
	{
		document.regform.cnselect.value = document.regform.country_ID.selectedIndex
	}

	function savest()
	{
		document.regform.stselect.value = document.regform.state_ID.selectedIndex
	}

	function savect()
	{
		document.regform.ctselect.value = document.regform.city_ID1.selectedIndex
	}

	function chkregform()
	{
		<!-- check the formvalue -->
		if(document.regform.login.value=="")
		{
			alert("Please enter your login name!")
			return false
		}
		if(!isValidChar(document.regform.login.value))
		{
			alert("Login name should not have invalid characters!")
			return false
		}
		if(document.all.passwd.value=="")
		{
			alert("Passwd should not be empty!")
			return false
		}
		if(document.regform.passwd.value.length<6)
		{
			alert("Passwd should not less than 6 characters!")
			return false
		}
		if(!isValidChar(document.regform.passwd.value))
		{
			alert("Passwd should not have invalid characters!")
			return false
		}
		if(!checkPasswd(document.regform.passwd,document.regform.passwdChk))
		{
			alert("The two Passwd are not same!")
			return false
		}
		if(document.regform.firstname.value=="")
		{
			alert("Please enter your firstname!")
			return false
		}
		if(document.regform.lastname.value=="")
		{
			alert("Please enter your lastname!")
			return false
		}
		<!-- to decide the city_ID -->

		if(document.regform.city_ID1.selectedIndex==0&&document.regform.city_name.value=="")
		{
			alert("Please specify you city!")
			return false
		}
		if(document.regform.city_ID1.selectedIndex==0)
		{	document.regform.city_ID.value =document.regform.city_name.value
		}
		else
		{	document.regform.city_ID.value =document.regform.city_ID1.options[document.regform.city_ID1.selectedIndex].value
		}
		<!-- finish city_ID -->
		if(document.regform.addr.value=="")
		{
			alert("Please enter your address!")
			return false
		}
		if(document.regform.postCode.value=="")
		{
			alert("Please enter your Postcode!")
			return false
		}
		if(document.regform.tel.value=="")
		{
			alert("Please enter your phone number!")
			return false
		}
		if(document.regform.email.value=="")
		{
			alert("Please enter your email address!")
			return false
		}
		if(!checkEmail(document.regform.email))
		{
			alert("Invalaid Email Address!")
			return false
		}
		if(document.regform.question.value=="")
		{
			alert("Please enter your hint question!")
			return false
		}
		if(document.regform.answer.value=="")
		{
			alert("Please enter your hint answer!")
			return false
		}

		<!-- save hiddenfield values -->
		savecn()
		savest()
		savect()

		return true
	}
	

	function initselect()
	{
		showCountry()	

	}
	</script>
    <td valign="top" width="617">
      <form name="regform" method="post" action="regaccess.jsp" onSubmit="return chkregform()">
        <table width="100%" border="0" cellspacing="4">
          <tr> 
            <td width="19%"><span class="black-m-text">Enter your account name.</span></td>
            <td width="36%"> 
              <input type="text" name="login" maxlength="20" size="20">
              <font color="#FF0000">*</font> </td>
            <td width="45%" class="black-m-text">(Begin with a letter, and use 
              only letters (a-z), numbers (0-9), the underscore (_), and no spaces.)</td>
          </tr>
          <tr> 
            <td class="black-m-text" width="19%">Email Address:</td>
            <td width="36%"> 
              <input type="text" name="email" size="20" maxlength="50">
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%"><span class="black-m-text">Phone</span>:</td>
            <td width="36%" > 
              <input type="text" name="tel" size="20" maxlength="20">
              <font color="#FF0000">*</font> </td>
            <td width="45%" >&nbsp;</td>
          </tr>
          <tr> 
            <td class="black-m-text" width="19%">Enter Password:</td>
            <td width="36%"> 
              <input type="password" name="passwd" size="20" maxlength="20">
              <font color="#FF0000">*</font> </td>
            <td rowspan="2" width="45%" class="black-m-text">(Must be at least 
              eight (6) characters long, may contain numbers (0-9) and upper and 
              lowercase letters (A-Z, a-z), but no spaces. Make sure it is difficult 
              for others to guess!)</td>
          </tr>
          <tr> 
            <td class="black-m-text" width="19%">Verify password:</td>
            <td width="36%"> 
              <input type="password" name="passwdChk" size="20" maxlength="20">
              <font color="#FF0000">*</font> </td>
          </tr>
          <tr> 
            <td width="19%" height="56" class="black-m-text"> Secret Question:</td>
            <td width="36%" height="56"> 
              <input type="text" name="question" size="25" maxlength="30">
              <font color="#FF0000">*</font> </td>
            <td rowspan="2" width="45%" class="black-m-text">(Choose a question 
              only you know the answer to and that has nothing to do with your 
              password. If you forget your password, we'll verify your identity 
              by asking you this question.)</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text"> Answer to Secret Question:</td>
            <td width="36%"> 
              <input type="text" name="answer" size="25" maxlength="30">
              <font color="#FF0000">*</font> </td>
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
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">First Name: </td>
            <td width="36%"> 
              <input type="text" name="firstname" size="20" maxlength="50">
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">Last Name:</td>
            <td width="36%"> 
              <input type="text" name="lastname" size="20" maxlength="50">
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">Address: </td>
            <td width="36%"> 
              <input type="text" name="addr" maxlength="200" size="25">
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
							
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">State or Province: </td>
            <td width="36%"> 
              <select
            name=state_ID onChange="statechange(document.regform.country_ID.selectedIndex,this.selectedIndex)" onBlur="savest()">
              	<option value=" "> 
              	<option value=" "> 
              </select>
              <font color="#FF0000">*</font> </td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">City:</td>
            <td width="36%"> 
              <select
            name=city_ID1 onChange="citychange()" onBlur="savect()">
              	<option value=" "> 
              	<option value=" "> 
              </select>
              <font color="#FF0000">*</font> </td>
            <td width="45%" rowspan="2" class="black-m-text">(If your city is 
              not in the list, please fill this input box.)</td>
          </tr>
          <tr>
            <td width="19%" class="black-m-text">&nbsp;</td>
            <td width="36%"> 
              <input type="text" name="city_name" value="">
              <input type="hidden" name="city_ID">
            </td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text" height="30">Zip Code:</td>
            <td width="36%" height="30"> 
              <input
      maxlength=10 name=postCode size=10>
              <font color="#FF0000">*</font> </td>
            <td width="45%" height="30">&nbsp;</td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">Mobile:</td>
            <td width="36%"> 
              <input type="text" name="mobile" maxlength="50" size="30">
            </td>
            <td width="45%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">Fax:</td>
            <td width="36%"> 
              <input type="text" name="fax" maxlength="50" size="30">
            </td>
            <td width="45%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text">&nbsp;</td>
            <td width="36%"> 
              <div align="right"><input type="image" src="../../images/submit-buttom.jpg" border="0">
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

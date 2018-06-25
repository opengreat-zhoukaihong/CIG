<jsp:useBean id="userInfo" scope="session" class="com.forbrand.member.LoginBean" />
<%
String userID = (String) session.getAttribute("userid");
if (userID == null) {
%>
<jsp:forward page="login.jsp" />
<%
}

String tmp = request.getParameter("langCode");
String langCode = "EN";
if ( tmp != null ) langCode = tmp;

userInfo.getUserInfo(userID);
userInfo.fetchCityInfo(langCode);
String gender = userInfo.getSex();
if ( gender.equals("F") ) {
  gender = "Mrs.";
}
else {
  gender = "Mr.";
}

%>
<head>
<title>ForBrand.com</title>
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

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width=758 border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td colspan=3 height="5" background="/images/background1_05.gif" class="orange-title1">&nbsp;</td>
  </tr>
  <tr>
    <td colspan=3 rowspan=3 background="/images/background1_05.gif" class="orange-title1">
      <blockquote>
        <p>MY ACCOUNT: CHECK OUT</p>
      </blockquote>
    </td>
  </tr>
</table>
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td WIDTH="180" valign="top" align="center"><img src="/images/step1.jpg" width="152" height="76">
    </td>
    <td valign="top">
      <p class="black-m-text"><b>DEAR <%=gender%> <%=userID%>:<br>
        </b> Please verify your registered information listed below is current and make your changes here if necessary. We will update your record in our system.
        change. <br>
        Press NEXT buttom to continue.</p>

<% userInfo.fetchCityInfo(langCode); %>
          <script src="/js/formcheck.js"></script>
          <script language="JavaScript">
	var countryStr = "<jsp:getProperty name='userInfo' property='country'/>"
	var countryID = "<jsp:getProperty name='userInfo' property='countryID'/>"
	var stateStr = "<jsp:getProperty name='userInfo' property='state'/>"
	var stateID = "<jsp:getProperty name='userInfo' property='stateID'/>"
	var cityStr = "<jsp:getProperty name='userInfo' property='city'/>"

	function citychange()
	{
		if(document.all.city_ID1.selectedIndex!=0)
			document.all.city_name.style.visibility = "hidden"
		else
			document.all.city_name.style.visibility = "visible"
	}

	function statechange(num1,num2)
	{
		var temp1 = cityStr.split(";")
		var temp2 = temp1[num1].split(":")
		var str = temp2[num2].split(",")

		if(str == null)
		{
			document.all.city_ID1.length = 1
			document.all.city_ID1.options[0].value = 0
			document.all.city_ID1.options[0].text = "select:"
			return
		}

		document.all.city_ID1.length = str.length
		document.all.city_ID1.options[0].text = "select:"
		for(i=1;i<str.length;i++)
		{
			document.all.city_ID1.options[i].text = str[i-1]
			document.all.city_ID1.options[i].value = str[i-1]
		}
		document.all.city_ID1.options[0].selected = true
	}

	function countrychange(num)
	{
		var temp1 = stateStr.split(";")
		var str = temp1[num].split(":")

		var temp2 = stateID.split(";")
		var sid = temp2[num].split(":")

		if(str == null)
		{
			document.all.state_ID.length = 1
			document.all.state_ID.options[0].value = 0
			document.all.state_ID.options[0].text = "select:"
			statechange(num,0)
			return
		}

		document.all.state_ID.length = str.length-1
		for(i=0;i<str.length-1;i++)
		{
			document.all.state_ID.options[i].value = sid[i]
			document.all.state_ID.options[i].text = str[i]
		}
		document.all.state_ID.options[0].selected = true
		statechange(num,0)
	}

	function showCountry()
	{
		var str = countryStr.split(";")
		var cnid = countryID.split(";")

		document.all.country_ID.length = str.length-1
		for(i=0;i<str.length-1;i++)
		{
			document.all.country_ID.options[i].value = cnid[i]
			document.all.country_ID.options[i].text = str[i]
		}
		document.all.country_ID.options[0].selected = true
		countrychange(0)
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

	function chkAll()
	{
		<!-- check the formvalue -->
		if(document.all.firstname.value=="")
		{
			alert("Please enter your firstname!")
			return false
		}
		if(document.all.lastname.value=="")
		{
			alert("Please enter your lastname!")
			return false
		}
		<!-- to decide the city_ID  -->
		if(document.all.city_ID1.selectedIndex==0&&document.all.city_name.value=="")
		{
			alert("Please specify you city!")
			return false
		}

		if(document.all.city_ID1.selectedIndex==0)
		{	document.all.city_ID.value =document.all.city_name.value
		}
		else
		{	document.all.city_ID.value =document.all.city_ID1.options[document.all.city_ID1.selectedIndex].value
		}
		<!-- finish city_ID -->
		if(document.all.addr.value=="")
		{
			alert("Please enter your address!")
			return false
		}
		if(document.all.postCode.value=="")
		{
			alert("Please enter your postcode!")
			return false
		}
		if(document.all.tel.value=="")
		{
			alert("Please enter your phone number!")
			return false
		}
		if(document.all.email.value=="")
		{
			alert("Please enter your email address!")
			return false
		}
		if(!checkEmail(document.all.email))
		{
			alert("Invalaid Email Address!")
			return false
		}

		document.modform.submit()
	}
	</script>

            <form name="modform" method="post" action="<%=response.encodeURL("infocheck.jsp")%>">
              <input type="hidden" name="fax" value="<%=userInfo.getFax()%>">
              <input type="hidden" name="langCode" value="<%=langCode%>" >
              <table width="100%" border="0" cellspacing="4">
                <tr>
                  <td class="black-m-text" width="19%">Email Address:</td>
                  <td width="36%">
                    <input type="text" name="email" size="20" maxlength="20" value="<jsp:getProperty name='userInfo' property='email'/>">
                    <font color="#FF0000">*</font> </td>
                  <td width="45%">&nbsp; </td>
                </tr>
                <tr>
                  <td width="19%"><span class="black-m-text">Phone</span>:</td>
                  <td width="36%" >
                    <input type="text" name="tel" size="20" maxlength="20" value="<jsp:getProperty name='userInfo' property='tel'/>">
                    <font color="#FF0000">*</font> </td>
                  <td width="45%" >&nbsp;</td>
                </tr>
                <tr>
                  <td width="19%" class="black-m-text">Address: </td>
                  <td width="36%">
                    <input type="text" name="addr" maxlength="200" size="25" value="<jsp:getProperty name='userInfo' property='addr'/>">
                    <font color="#FF0000">*</font> </td>
                  <td width="45%">&nbsp;</td>
                </tr>
                <tr>
                  <td width="19%" class="black-m-text">City:</td>
                  <td width="36%">
                    <select
            name=city_ID1 onChange="citychange()">
                    </select>
                    <font color="#FF0000">*</font> </td>
                  <td width="45%">
                    <input type="text" name="city_name" value="<jsp:getProperty name='userInfo' property='city_ID'/>">
                    <input type="hidden" name="city_ID" value="">
                  </td>
                </tr>
                <tr>
                  <td width="19%" class="black-m-text">State or Province: </td>
                  <td width="36%">
                    <select
            name=state_ID onChange="statechange(document.all.country_ID.selectedIndex,this.selectedIndex)">
                    </select>
                    <font color="#FF0000">*</font> </td>
                  <td width="45%">&nbsp;</td>
                </tr>
                <tr>
                  <td width="19%" class="black-m-text"><span class="black-m-text">Country:</span></td>
                  <td width="36%">
                    <select
      name=country_ID onChange="countrychange(this.selectedIndex)">
                    </select>
                    <font color="#FF0000">*</font>
                    <input type="hidden" name="userInfo" value="<%=(String)session.getAttribute("userid")%>">
                  </td>
                  <td width="45%">&nbsp;</td>
                  <script language="JavaScript">
				showCountry()
				setSelected("<jsp:getProperty name='userInfo' property='country_ID'/>",document.all.country_ID)
				countrychange(document.all.country_ID.selectedIndex)
				setSelected("<jsp:getProperty name='userInfo' property='state_ID'/>",document.all.state_ID)
				statechange(document.all.country_ID.selectedIndex,document.all.state_ID.selectedIndex)
				setSelected("<jsp:getProperty name='userInfo' property='city_ID'/>",document.all.city_ID)
			</script>
                </tr>
                <tr>
                  <td width="19%" class="black-m-text" height="30">Zip Code:</td>
                  <td width="36%" height="30">
                    <input
      maxlength=10 name=postCode size=10 value="<jsp:getProperty name='userInfo' property='postCode'/>">
                    <font color="#FF0000">*</font> </td>
                  <td width="45%" height="30">&nbsp;</td>
                </tr>
                <tr>
                  <td width="19%" class="black-m-text">Mobile:</td>
                  <td width="36%">
                    <input type="text" name="mobile" maxlength="50" size="30" value="<jsp:getProperty name='userInfo' property='mobile'/>">
                  </td>
                  <td width="45%">&nbsp; </td>
                </tr>
                <tr>
                  <td width="19%" class="black-m-text">&nbsp;</td>
                  <td width="36%">
                    <div align="right"><input type="image" src="/images/continue.jpg" onClick="chkAll()" width="68" height="25" border="0" style="cursor: hand;"></div>
                  </td>
                  <td width="45%">
                    <input type="button" style = "visibility = 'hidden'" value="" name="button">
                  </td>
                </tr>
              </table>
            </form>
            <p class="contact">&nbsp;</p>

<br>
    </td>
  </tr>
</table>
</body>
</html>

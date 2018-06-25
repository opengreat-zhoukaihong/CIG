<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="error.jsp"%>
<% if(session.getAttribute("userid")==null) {%>
<jsp:forward page="../ResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="login" scope="request" class="com.forbrand.member.LoginBean"/>
<jsp:setProperty name="login" property="*"/>


<% login.getUserInfo((String)session.getAttribute("userid"));%>

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
        <p><span class="orange-title1">MY ACCOUNT</span>:<span class="dalei"><!-- #BeginEditable "subtitle" -->Modify my password information:<!-- #EndEditable --></span></p>
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
      <script src="/js/formcheck.js"></script>
      <script language="JavaScript">
	function chkregform()
	{
		<!-- check the formvalue -->
		if(document.regform.passwd.value=="")
		{
			alert("Passwd should not be empty!")
			return false
		}
		if(!isValidChar(document.regform.passwd.value))
		{
			alert("Passwd should not have invalid characters!")
			return false
		}
		if(document.regform.passwd.value.length<6)
		{
			alert("Passwd should not less than 6 characters!")
			return false
		}
		if(!checkPasswd(document.regform.passwd,document.regform.passwdChk))
		{
			alert("The two Passwd are not same!")
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

		return true
	}
	</script>
      <form name="regform" method="post" action="modpwdresult.jsp" onSubmit="return chkregform()">
        <table width="100%" border="0" cellspacing="4" class="black-m-text">
          <tr> 
            <td class="black-m-text" width="19%"><b>Old Password:</b></td>
            <td width="36%"> 
              <input type="password" name="oldpwd" size="20" maxlength="20">
              <font color="#FF0000">*</font> </td>
            <td rowspan="3" width="45%">(Must be at least eight (6) characters 
              long, may contain numbers (0-9) and upper and lowercase letters 
              (A-Z, a-z), but no spaces. Make sure it is difficult for others 
              to guess!)</td>
          </tr>
          <tr> 
            <td class="black-m-text" width="19%"><b>New Password:</b></td>
            <td width="36%"> 
              <input type="password" name="passwd" size="20" maxlength="20" value="">
              <font color="#FF0000">*</font> </td>
          </tr>
          <tr> 
            <td class="black-m-text" width="19%"><b>Verify password:</b></td>
            <td width="36%"> 
              <input type="password" name="passwdChk" size="20" maxlength="20" value="">
              <font color="#FF0000">*</font> </td>
          </tr>
          <tr> 
            <td width="19%" height="56"><b> Secret Question:</b></td>
            <td width="36%" height="56"> 
              <input type="text" name="question" size="25" maxlength="30" value="<jsp:getProperty name='login' property='question'/>">
              <font color="#FF0000">*</font> </td>
            <td rowspan="2" width="45%">(Choose a question only you know the answer 
              to and that has nothing to do with your password. If you forget 
              your password, we'll verify your identity by asking you this question.)</td>
          </tr>
          <tr> 
            <td width="19%"><b> Answer to Secret Question:</b></td>
            <td width="36%"> 
              <input type="text" name="answer" size="25" maxlength="30" value="<jsp:getProperty name='login' property='answer'/>">
              <font color="#FF0000">*</font> </td>
          </tr>
          <tr> 
            <td width="19%" class="black-m-text"> <b> 
              <input type="hidden" name="login" value="<%=(String)session.getAttribute("userid")%>">
              </b></td>
            <td width="36%"> 
              <div align="right"><input type="image" src="../../images/update-buttom.jpg" border="0">
							</div>
            </td>
            <td width="45%"> 
            </td>
          </tr>
        </table>
      </form>
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

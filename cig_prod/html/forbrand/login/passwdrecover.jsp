<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="error.jsp"%>
<jsp:useBean id="login" scope="request" class="com.forbrand.member.LoginBean"/>


<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" -->
<title>ForBrand.com -- Recover Passwd</title>
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
    <td colspan=6> <img src="/images/img-sea/search_02.gif" width=704 height=32 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="381,13,459,26" href="../show/portinfo.jsp"><area shape="rect" coords="482,13,555,26" href="myaccount.jsp"><area shape="rect" coords="583,12,692,26" href="../show/cart.jsp" onClick="return js_callpage2(this.href)"></map></td>
  </tr>
  <tr> 
    <td> <img src="/images/img-sea/search_03.gif" width=73 height=18></td>
    <td colspan=5> <img src="/images/img-sea/search_04.gif" width=631 height=18 usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="116,3,204,15" href="../show/showroom.jsp"><area shape="rect" coords="302,3,407,12" href="../show/giftoccasion.jsp?langCode=EN"><area shape="rect" coords="429,3,535,14" href="specialorder.jsp"><area shape="rect" coords="550,3,617,14" href="../show/showinside.jsp?act=4&langCode=EN"><area shape="rect" coords="222,4,284,14" href="../show/showinside.jsp?act=3&langCode=EN"></map></td>
  </tr>
  <tr> <!-- #BeginEditable "replace" -->
    <td colspan=3 rowspan=3 background="../../images/background1_05.gif">
      <blockquote class="orange-title1"> 
        <p><!-- #BeginEditable "subtitle" -->Recover my Password <!-- #EndEditable -->:
        </p>
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
<div align="center">
  <script src="/js/formcheck.js"></script>
  <script language="JavaScript">
	function chkpwd()
	{
		if(document.pwdform.passwd.value=="")
		{
			alert("Passwd should not be empty!")
			return false
		}
		if(!isValidChar(document.pwdform.passwd.value))
		{
			alert("Passwd should not have invalid characters!")
			return false
		}
		if(document.pwdform.passwd.value.length<6)
		{
			alert("Passwd should not less than 6 characters!")
			return false
		}
		if(!checkPasswd(document.pwdform.passwd,document.pwdform.passwdChk))
		{
			alert("The two Passwd are not same!")
			return false
		}
		document.pwdform.submit()
	}

	function chkname()
	{
		if(document.pwdform.login.value=="")
		{
			alert("Please enter your login name!")
			return false
		}
		if(!isValidChar(document.pwdform.login.value))
		{
			alert("Login Name should not have invalid characters!")
			return false
		}
		return true
	}

	function chkanswer()
	{
		if(document.pwdform.usranswer.value=="")
		{
			alert("Please enter your answer to the hint question!")
			return false
		}
		return true
	}
	
	function chkAll()
	{
		if(document.pwdform.passwd!=null)
			return chkpwd()
		if(document.pwdform.usranswer!=null)
			return chkanswer()
		if(document.pwdform.login!=null)
			return chkname()
	}
	</script>
</div>
<div align="center" style="height:200">
  <table border="0" width="747" align="center">
    <tr>
      <td width="200" valign="top">
        <div align="center"><img src="../../images/girl-head.jpg" width="90" height="121"></div>
      </td>
      <td width="581" valign="top">
        <form action="passwdrecover.jsp" name="pwdform" method="post" onSubmit="return chkAll()">
          <div align="center"><b><% 	if(request.getParameter("passwd")!=null)
	{ %> <% login.passwdReset(request.getParameter("login"),request.getParameter("passwd")); %>
            </b></div>
          <p align="center"><b><span class="contact">Congradulations! You have 
            reset your password. <br>
            Now you can use your new password to login.<br>
            <a href="../index.jsp">Login</a> <% 	}
	else
	{%> <%	 	if(request.getParameter("usranswer")==null)
		{ %> <% 			if(request.getParameter("login")==null||request.getParameter("login")=="")
			{ %> </span></b></p>
          <p align="center"><span class="contact"><b>Enter your Login name:</b></span></p>
          <p align="center"><span class="contact"><b><br>
            <input type="text" name="login" size="20" maxlength="20">
            </b></span></p>
          <p align="center"><span class="contact"><b><br>
						<input type="image" src="../../images/next-buttom.jpg" border="0">
            <% 			}
			else
			{ %> <% 				if(login.forgetPasswd(request.getParameter("login"))==0)
				{ %> </b></span></p>
          <p align="center"><span class="contact"><b>Answer the Question:</b></span></p>
          <p align="center"><span class="contact"><b><br>
            </b></span></p>
          <p align="center"><span class="contact"><b><%=login.getQuestion()%></b></span></p>
          <p align="center"> <span class="contact"><b> 
            <input type="text" name="usranswer" size="30" maxlength="30">
            </b></span></p>
          <p align="center"><span class="contact"><b><br>
            <input type="hidden" name="login" value="<%=request.getParameter("login")%>">
            <input type="image" src="../../images/next-buttom.jpg" border="0">
            <%	 			}
				else
				{	%> </b></span></p>
          <p align="center"><span class="contact"><b>Sorry, there is no such a 
            user in our system.<br>
            <%				}
			}
		}
		else
		{ 	login.forgetPasswd(request.getParameter("login"));
			if(!login.answerQuestion(request.getParameter("usranswer")))
			{ %> </b></span></p>
          <p align="center"><span class="contact"><b>Sorry, the answer is wrong. 
            please retry. <br>
            <%			}
			else
			{ %></b></span></p>
          <p align="center"><span class="contact"><b> Please enter ur new passwd:<br>
            <input type="Password" name="passwd" size="20" maxlength="30">
            </b></span></p>
          <p align="center"><span class="contact"><b><br>
            ReEnter the passwd to confirm:<br>
            <input type="Password" name="passwdChk" size="20" maxlength="30">
            </b></span></p>
          <p align="center"><span class="contact"><b><br>
            <input type="hidden" name="login" value="<%=request.getParameter("login")%>">
            
						<input type="image" src="../../images/done-buttom.jpg" border="0" onDblClick=".">
            <%			}
		}
	} %> </b></span></p>
        </form>
      </td>
    </tr>
  </table>
  <b> </b> </div>
<div align="center"><br>
</div>
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

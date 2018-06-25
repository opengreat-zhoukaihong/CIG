<%
session.removeAttribute("payment");
%>
<jsp:useBean id="payment" scope="session" class="com.forbrand.show.LCBean" />
<jsp:useBean id="userInfo" scope="session" class="com.forbrand.member.LoginBean" />
<%
if ( userInfo == null ) {
%>
<jsp:forward page="login.jsp" />
<%
}
String userID = userInfo.getLogin();
String gender = userInfo.getSex();
if ( gender.equals("F") ) {
  gender = "Mrs.";
}
else {
  gender = "Mr.";
}
%>
<html>
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
    <td colspan=3 background="/images/background1_05.gif" class="orange-title1" width="730">&nbsp;</td>
  </tr>
  <tr>
    <td colspan=3 rowspan=4 background="/images/background1_05.gif" class="orange-title1" width="730">
      <blockquote>
        <p>MY ACCOUNT: CHECK OUT</p>
      </blockquote>
    </td>
  </tr>
</table>

<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td WIDTH="180" valign="top" align="center"><img src="/images/step2.jpg" width="152" height="76">
    </td>
    <form name="form2" >
      <td valign="top">
        <p class="black-m-text"><b>DEAR <%=gender%> <%=userID%>:<br>
          </b> You have choosen the following payment method. <br>
        </p>
        <p class="xiaolei">Letter of Credit</p>
        <p class="xiaolei"><br>
          <a href="<%=response.encodeURL("checkout2.jsp")%>"><img src="/images/prev-buttom.jpg" width="68" height="25" border="0"></a>
          <a href="<%=response.encodeURL("orderconfirm.jsp")%>"> <img src="/images/next-buttom.jpg" width="68" height="25" border="0"></a>
      </td>
    </form>
  </tr>
</table>
<br>

</body>
</html>


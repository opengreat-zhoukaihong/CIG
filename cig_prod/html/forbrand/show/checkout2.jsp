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
    <td colspan=3 background="/images/background1_05.gif" class="orange-title1">&nbsp;</td>
  </tr>
  <tr>
    <td colspan=3 rowspan=3 background="/images/background1_05.gif" class="orange-title1">
      <blockquote>
        <p>MY ACCOUNT: CHECK OUT</p>
      </blockquote>
    </td>
  </tr>
  <tr>
    <td rowspan=2 colspan="4">&nbsp; </td>
    <form name="form1" method="post"  action="<%=response.encodeURL("showinside.jsp")%>">
    </form>
  </tr>
  <tr> </tr>
</table>
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td WIDTH="180" valign="top" align="center"><img src="/images/step2.jpg" width="152" height="76">
    </td>
      <td valign="top">
        <p class="black-m-text"><b>DEAR <%=gender%> <%=userID%>:<br>
          </b> Please choose payment method. <br>
        </p>
         <p class="xiaolei"><a href="https://<%=request.getServerName()%>/forbrand/show/checkout21.jsp">Credit Card <br>
          <br>
          </a> <a href="<%=response.encodeURL("checkout22.jsp")%>">Letter of Credit</a><br>
          <br>
          <a href="<%=response.encodeURL("checkout23.jsp")%>">TT</a><br>
          <br>
          <a href="<%=response.encodeURL("checkout24.jsp")%>">DP</a> </p>
        <p class="black-m-text" align="right"><br>
          <br>
          <a href="<%=response.encodeURL("https://192.168.0.8/forbrand/show/checkout1.jsp?langCode=EN")%>"><img src="/images/prev-buttom.jpg" width="68" height="25" border="0"></a>
      </td>
  </tr>
</table>
<br>

</body>
</html>

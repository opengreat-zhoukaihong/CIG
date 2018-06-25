<%
session.removeAttribute("payment");
%>
<jsp:useBean id="payment" scope="session" class="com.forbrand.show.DPBean" />
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
<title>ForBrand.com</title>
<script language="javascript">
function check(){
  for (i = 0; i < document.dp.elements.length ; i++) {
    if (document.dp.elements[i].value == "") {
      alert("All the fields can not be empty!");
      return false
    }
  }
  return true;
}
</script>

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
</table>
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td WIDTH="180" valign="top" align="center"><img src="/images/step2.jpg" width="152" height="76">
    </td>
    <form name="dp" action="<%=response.encodeURL("orderconfirm.jsp")%>" method="POST">
       <td valign="top">
        <p class="black-m-text"><b>DEAR <%=gender%> <%=userID%>:<br>
          </b> Please enter your back information. <br>
          <br>
          DP <br>
          Banking Details:
        <table width="60%" border="0" cellspacing="4">
          <tr>
            <td class="xiaolei">Bank Name: </td>
            <td>
              <input type="text" name="bankName">
            </td>
          </tr>
          <tr>
            <td class="xiaolei">Code: </td>
            <td>
              <input type="text" name="code">
            </td>
          </tr>
          <tr>
            <td class="xiaolei">Address: </td>
            <td>
              <input type="text" name="address">
            </td>
          </tr>
          <tr>
            <td class="xiaolei">Account No: </td>
            <td>
              <input type="text" name="accountNo">
            </td>
          </tr>
          <tr>
            <td class="xiaolei">Account Holder: </td>
            <td>
              <input type="text" name="accountHolder">
            </td>
          </tr>
        </table>

        <p ><br>
          <a href="<%=response.encodeURL("checkout2.jsp")%>"><img src="/images/prev-buttom.jpg" width="68" height="25" border="0"></a>
          <input onClick="return check()" type="image" src="/images/next-buttom.jpg" width="68" height="25" border="0">
      </td>
    </form>
  </tr>
</table>
<br>

</body>
</html>


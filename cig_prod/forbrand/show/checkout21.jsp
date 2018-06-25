<%
session.removeAttribute("payment");
%>
<jsp:useBean id="payment" scope="session" class="com.forbrand.show.CreditCardBean" />
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
  for (i = 0; i < document.cc.elements.length ; i++) {
    if (document.cc.elements[i].value == "") {
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
<table width=758 border=0 cellpadding=0 cellspacing=0 height="27">
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
    <td rowspan=2 colspan="2">&nbsp; </td>
  </tr>
</table>
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td WIDTH="180" valign="top" align="center"><img src="/images/step2.jpg" width="152" height="76">
    </td>
    <form name="cc" action="<%=response.encodeURL("orderconfirm.jsp")%>" method="post">
    <td valign="top">
        <p class="black-m-text"><b>DEAR <%=gender%> <%=userID%>:<br>
          </b> Please enter your credit card information. <br>
        </p>
        <p>
          <span class="xiaolei">Card Number:</span><br>
          <input type="text" name="cardNo">
          <br>
          <span class="xiaolei">Expiration Date: </span><br>
          <select name="month">
            <option value="1">Jan</option>
            <option value="2">Feb</option>
            <option value="3">Mar</option>
            <option value="4">Apr</option>
            <option value="5">May</option>
            <option value="6">Jun</option>
            <option value="7">July</option>
            <option value="8">Aug</option>
            <option value="9">Sep</option>
            <option value="10">Oct</option>
            <option value="11">NOV</option>
            <option value="12">Dec</option>
          </select>
          <select name="year">
            <option value="2000">2000</option>
            <option value="2001">2001</option>
            <option value="2002">2002</option>
            <option value="2003">2003</option>
            <option value="2004">2004</option>
            <option value="2005">2005</option>
          </select>
        </p>
        <p class="black-m-text" align="right"><br>
          <br>
          <br>
          <a href="checkout2.jsp"><img src="/images/prev-buttom.jpg" width="68" height="25" border="0"></a>
          <input onClick="return check()" type="image" src="/images/next-buttom.jpg" width="68" height="25" border="0">
        </p>
        </td>
    </form>
  </tr>
</table>
<br>

</body>
</html>

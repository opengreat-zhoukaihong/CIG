<jsp:useBean id="order" scope="session" class="com.forbrand.show.OrderBean" />
<jsp:useBean id="myCart" scope="session" class="com.forbrand.show.ShoppingCartBean" />
<jsp:useBean id="userInfo" scope="session" class="com.forbrand.member.LoginBean" />
<jsp:useBean id="payment" scope="session" class="com.forbrand.show.PayMethod" />
<%
if ( userInfo == null ) {
%>
<jsp:forward page="login.jsp" />
<%
}
myCart.calAll(userInfo.getLogin());

order.setUserID(userInfo.getLogin());
order.setCity(userInfo.getCity_ID());
order.setDestAddress(userInfo.getAddr());
order.setTotalDue(myCart.getTotalPrice() * (100 - order.getDiscount()) / 100);
if ( myCart.getSubTotalPrice() > 1000 ) order.setOrderStyle('W'); //Wholesale
else order.setOrderStyle('R'); //retail
order.setRemark( request.getParameter("req") );

order.makeOrder(myCart);
%>
<html>
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
    <td colspan=3 background="/images/background1_05.gif">&nbsp;</td>
  </tr>
  <tr>
    <td colspan=3 rowspan=3 background="/images/background1_05.gif">
      <blockquote>
        <p><span class="orange-title1">MY ACCOUNT:</span> <span class="orange-title1">CHECK
          OUT </span></p>
      </blockquote>
    </td>
  </tr>
</table>
<table width="666" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" valign="top" align="center"> <img src="/images/two.jpg" width="94" height="141"></td>


    <td valign="top">
      <p>&nbsp;</p>
      <span class="xiaolei"><b>Please Remember Your Order Number: <%=order.getOrderID()%></b></span>
      <p class="xiaolei">Thank you.</p>
      <p class="xiaolei">Click <a href="javascript:window.close()">here</a> to go to close the window.
      </p>
      </td>
  </tr>
</table>
<p>&nbsp;</p>
<p><br>
</p>

</body>
</html>
<%
session.removeAttribute("order");
session.removeAttribute("myCart");
session.removeAttribute("payment");
%>

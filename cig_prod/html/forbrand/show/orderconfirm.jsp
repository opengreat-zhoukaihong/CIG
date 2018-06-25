<%@ page import="java.util.*, com.forbrand.show.*" %>
<jsp:useBean id="myCart" scope="session" class="com.forbrand.show.ShoppingCartBean" />
<jsp:useBean id="userInfo" scope="session" class="com.forbrand.member.LoginBean" />
<jsp:useBean id="order" scope="session" class="com.forbrand.show.OrderBean" />
<jsp:useBean id="payment" scope="session" class="com.forbrand.show.PayMethod" />
<%
if ( userInfo == null ) {
%>
<jsp:forward page="login.jsp" />
<%
}
String payMethod = payment.getPayMethod();
if ( payMethod.equals("CC")) {
  payment = (CreditCardBean) payment;
}
else if ( payMethod.equals("DP") ) {
  payment = (DPBean) payment;
}
else if ( payMethod.equals("LC" )) {
  payment = (LCBean) payment;
}
else if ( payMethod.equals("TT") ) {
  payment = (TTBean) payment;
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
<jsp:setProperty name="payment" property="*" />
<% order.setPayment(payment); %>
<%
myCart.calAll(userInfo.getLogin());
order.setUserID(userInfo.getLogin());
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
    <td colspan=3 background="/images/background1_05.gif" class="orange-title1">&nbsp;</td>
  </tr>
  <td colspan=3 rowspan=3 background="/images/background1_05.gif" class="orange-title1">
    <blockquote>
      <p>MY ACCOUNT: CHECK OUT</p>
    </blockquote>
  </td>
  </tr>
</table>
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td WIDTH="180" valign="top" align="center"><img src="/images/step3.jpg" width="152" height="76">
    </td>
      <td valign="top">
        <p class="black-m-text"><b>DEAR <%=gender%> <%=userID%>:<br>
          </b> Thank you for your order, your order summary is listed below.
          Press the confirm buttom to confirm. We will send you an email confirmation on your order.
          Your order will be processed promptly.<br>
          <br>
          <br>
        </p>
        <span class="xiaolei"></span>
      <form name="form2" action="purchaseaccess.jsp" method="POST">
        <table width="100%" border="0" cellspacing="4">
          <tr>
            <td class="xiaolei" width="24%"><b>Product</b></td>
            <td class="xiaolei" width="12%"><b>Code</b></td>
            <td class="xiaolei" width="12%"><b>QTY</b></td>
            <td class="xiaolei" width="13%"><b>Price</b></td>
            <td class="xiaolei" width="21%"><b>Special Price ( If )</b></td>
            <td class="xiaolei" width="18%"><b>Total</b></td>
          </tr>
          <tr>
            <td colspan="6">
              <hr noshade>
            </td>
          </tr>
          <%
            HashMap itemList = myCart.getCartItemList();
            if ( itemList != null ) {
              Iterator iter = itemList.keySet().iterator();
              while (iter.hasNext()) {
                Integer giftID = (Integer) iter.next();
                String[] item = (String[]) itemList.get(giftID);
            %>
            <tr>
              <td class="xiaolei" width="24%"><%=item[0]%></td>
              <td class="xiaolei" width="12%">#<%=giftID%></td>
              <td class="xiaolei" width="12%"><%=item[1]%></td>
              <td class="xiaolei" width="13%">$<%=item[4]%></td>
              <td class="xiaolei" width="21%">$<%=item[2]%></td>
              <td class="xiaolei" width="18%"><b>$<%=item[3]%></b></td>
            </tr>
            <%
              }//while iter.next
            }//if itemList != null
            %>
          <tr>
            <td colspan="6">
              <hr noshade size="1">
            </td>
          </tr>
          <tr>
            <td class="xiaolei" width="24%">Sub Total</td>
            <td width="12%">&nbsp;</td>
            <td width="12%">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td class="xiaolei" width="18%">$<%=myCart.getSubTotalPrice()%></td>
          </tr>
          <tr>
            <td class="xiaolei" width="24%">Sample Surchange Rate</td>
            <td width="12%">&nbsp;</td>
            <td width="12%">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td class="xiaolei" width="18%"><%=myCart.getSurchargeRate() %>%</td>
          </tr>
          <tr>
            <td class="xiaolei" width="24%">Total</td>
            <td width="12%">&nbsp;</td>
            <td width="12%">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td class="xiaolei" width="18%">$<%=myCart.getTotalPrice()%></td>
          </tr>
          <tr>
            <td class="xiaolei" width="24%">Discount</td>
            <td width="12%">&nbsp;</td>
            <td width="12%">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td class="xiaolei" width="18%">
            <%
            order.calDiscount();
            %>
            <%=order.getDiscount() %>%</td>
          </tr>
          <tr>
            <td class="xiaolei" width="24%">Order Total</td>
            <td width="12%">&nbsp;</td>
            <td width="12%">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td class="xiaolei" width="18%">$<%=(100 - order.getDiscount()) / 100 * myCart.getTotalPrice()%></td>
          </tr>
          <tr>
            <td class="xiaolei" width="24%">Payment Mythod:</td>
            <td width="12%">&nbsp;</td>
            <td width="12%">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td class="xiaolei" width="18%"><%=order.getPayMethodName()%></td>
          </tr>
          <tr>
            <td class="xiaolei" width="24%" valign="top">Ship to:</td>
            <td colspan="5" class="xiaolei">
            <%
            String sex = userInfo.getSex();
            if ( sex.equalsIgnoreCase("m")) {
              out.print("Ms.");
            }
            else { out.print("Mr."); }
            %>
            <%=userInfo.getLastname()%><br>
              <%=userInfo.getAddr()%><br>
              <%=userInfo.getCity_ID()%><br>
              <%=userInfo.getStateName()%>, <br>
              <%=userInfo.getCountryName()%>.<br>
              <%=userInfo.getPostCode()%><br>
              email: <%=userInfo.getEmail()%><br>
              Tel: <%=userInfo.getTel()%><br>
              Mobil: <%=userInfo.getMobile()%> </td>
          </tr>
          <tr>
            <td class="xiaolei" width="24%" valign="top">Special request.</td>
            <td colspan="5" class="xiaolei">
              <textarea name="req" rows="3" cols="30" wrap="VIRTUAL"></textarea>
              <span class="white-title"> </span> </td>
          </tr>
        </table>
        <div align="right"><a href="javascript:history.back()"><img src="/images/prev-buttom.jpg" width="68" height="25" border="0"></a>
          <input type="image" src="/images/confirm.jpg" width="68" height="25" border="0">
          <br>
        </div>
        </form>
      </td>
  </tr>
</table>
<br>

</body>
</html>

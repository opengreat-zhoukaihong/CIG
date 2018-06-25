<%@ page import="java.util.*" %>
<jsp:useBean id="myCart" scope="session" class="com.forbrand.show.ShoppingCartBean" />
<%
myCart.calAll();
%>
<HTML>
<HEAD>
<title>ForBrand.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
<SCRIPT language=JavaScript>
function js_callpage(htmlurl) {
  var cart=window.open(htmlurl,"cart","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=350");
  return false;
}
function js_call() {
  pick_tai=document.tv_form.tai_select.options[document.tv_form.tai_select.selectedIndex].value;
  pick_week=document.tv_form.week_select.options[document.tv_form.week_select.selectedIndex].value;
  parent.window.location.href=pick_tai+"-"+pick_week+"\.html";
}
</SCRIPT>
</head>

<body bgcolor="#FFFFFF" >
<table width=754 border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td colspan=7 background="/images/background1_05.gif" >
      <span class="dalei">&nbsp;  My SHOPPING CART</span></td>
</table>
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="13" valign="top" align="center">&nbsp; </td>
      <td valign="top" width="742">
        <p><span class="black-m-text"><br>
          You can change the number in the form. <br>
          After change, you <b>MUST</b> click the update buttom to make your change
          effective.</span></p>
        <div align="right"> </div>
        <div align="right">
        <FORM NAME="itemlist" METHOD=GET ACTION="cartprocess.jsp">
          <table width="100%" border="0" cellspacing="4">
            <tr>
              <td class="xiaolei" width="10%"><b>Remove</b></td>
              <td class="xiaolei" width="22%"><b>Product Name</b></td>
              <td class="xiaolei" width="20%"><b>Code</b></td>
              <td class="xiaolei" width="13%"><b>QTY</b></td>
              <td class="xiaolei" width="13%"><b>Price</b></td>
              <td class="xiaolei" width="22%"><b>Total</b></td>
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
              <td class="xiaolei" width="10%"><a href="cartprocess.jsp?act=0&giftID=<%=giftID%>">Remove</a></td>
              <td class="xiaolei" width="22%"><%=item[0]%></td>
              <td class="xiaolei" width="20%">#<%=giftID%></td>
              <td class="xiaolei" width="13%">
                <input type="text" name="item<%=giftID%>" size="7" maxlength="7" value="<%=item[1]%>">
              </td>
              <td class="xiaolei" width="13%">$<%=item[2]%></td>
              <td class="xiaolei" width="22%">$<%=item[3]%></td>
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
              <td class="xiaolei" colspan="2"><b>Sub Total</b></td>
              <td width="20%">&nbsp;</td>
              <td width="13%">&nbsp;</td>
              <td width="13%">&nbsp;</td>
              <td class="xiaolei" width="22%">$<%=myCart.getSubTotalPrice()%></td>
            </tr>
            <tr>
              <td class="xiaolei" colspan="2"><b>Sample Surchange Rate</b></td>
              <td width="20%">&nbsp;</td>
              <td width="13%">&nbsp;</td>
              <td width="13%">&nbsp;</td>
              <td class="xiaolei" width="22%"><%=myCart.getSurchargeRate() %>%</td>
            </tr>
            <tr>
              <td class="xiaolei" colspan="2"><b>Total</b></td>
              <td width="20%">&nbsp;</td>
              <td width="13%">&nbsp;</td>
              <td width="13%">&nbsp;</td>
              <td class="xiaolei" width="22%">$<%=myCart.getTotalPrice()%></td>
            </tr>
            <tr>
              <td class="xiaolei" colspan="6">&nbsp; </td>
            </tr>
            <tr>
              <td class="xiaolei" colspan="6"><b>NOTE: </b>Since the sub total
                price is lower than $<%=myCart.getLimit()%>, So the price is calculated as Sample
                Purchasing Price, which should be <%=myCart.getSurchargeRate()/100%> times of Whosale Purchasing
                Price, so the FOB China price of these products is : $<%=myCart.getSubTotalPrice()%>*<%=myCart.getSurchargeRate() %>%=$<%=myCart.getTotalPrice()%>
              </td>
            </tr>
          </table>
            <INPUT TYPE="hidden" NAME="act" VALUE="2">
            </FORM>
          <br>
          <table width="100%" border="0" cellspacing="4">
            <tr>
              <td class="xiaolei" width="25%" ><b><span class="xiaolei"><a onClick="document.itemlist.submit()" onMouseOver="style.cursor='hand'">Update</a>
                <a href="#"></a></span></b></td>
              <td class="xiaolei" width="25%"  ><b><span class="xiaolei"><a href="cartprocess.jsp?act=1&langCode=EN">Remove
                all</a> </span></b></td>
              <td class="xiaolei" width="25%"  ><b><span class="xiaolei"><a href="#" onClick="window.close()">Continue
                shopping</a> </span></b></td>
              <td class="xiaolei" width="25%" ><b><span class="xiaolei"><a href="checkout1.jsp?langCode=EN">Check
                out</a></span></b></td>
            </tr>
          </table>
          <b></b></div>
      </td>
  </tr>
</table>
<br>

</body>
</html>

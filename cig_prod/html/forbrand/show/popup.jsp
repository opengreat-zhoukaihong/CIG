<%@ page language="java" import="com.forbrand.show.*, java.util.*" %>
<jsp:useBean id="detailInfo" scope="request" class="com.forbrand.show.ShowDetailBean" />
<jsp:setProperty name="detailInfo" property="*"/>
<%
  detailInfo.fetchInfo();
%>
<HTML>
<HEAD>
<TITLE>Product Detail</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
<SCRIPT language=JavaScript>
function addToCart() {
  window.open("about:blank","cart","scrollbars=yes,resizable=yes");
  document.add.submit();
  window.close();
}
</SCRIPT>
</HEAD>
<BODY BGCOLOR=#FFFFFF leftmargin="000" topmargin="0" marginwidth="0" marginheight="0">
<TABLE WIDTH=566 BORDER=0 CELLPADDING=0 CELLSPACING=0>
  <TR>
    <TD> <IMG src="/images/img-pop/spacer.gif" WIDTH=250 HEIGHT=1></TD>
    <TD> <IMG src="/images/img-pop/spacer.gif" WIDTH=36 HEIGHT=1></TD>
    <TD> <IMG src="/images/img-pop/spacer.gif" WIDTH=42 HEIGHT=1></TD>
    <TD> <IMG src="/images/img-pop/spacer.gif" WIDTH=238 HEIGHT=1></TD>
  </TR>
  <TR>
    <TD COLSPAN=4> <IMG src="/images/img-pop/popout_01.gif" WIDTH=566 HEIGHT=19></TD>
  </TR>
  <TR>
    <TD COLSPAN=2>
      <table width="100%" border="0" cellspacing="5" cellpadding="2">
        <tr>
          <td  colspan="7">
            <p><span class="product-name"><%= detailInfo.getGiftName() %></span><span class="xiaolei">
              <br>
              #<%= detailInfo.getGiftNO() %></span></p>
          </td>
        </tr>
        <tr>
          <td  colspan="7" class="bottom-menu"><%= detailInfo.getDescription() %></td>
        </tr>
        <tr>
          <td  colspan="7" class="bottom-menu">occasion(s): <%= detailInfo.getOccasionNames() %>
          </td>
        </tr>
        <tr>
          <td  colspan="7" class="bottom-menu">Option Material(s): <%= detailInfo.getMaterial() %> </td>
        </tr>
        <tr>
          <td class="bottom-menu" width="50%" > Option Colors: <%= detailInfo.getColorDesc() %></td>
          <td class="contact" width="50%" ></td>
        </tr>
        <tr>
          <td colspan="7">
            <table  border="1" cellspacing="1" cellpadding="1" width="100%">
              <tr>
                <td class="bottom-menu" ><font color="#000000">Quantity</font></td>
                <%
                List priceList = detailInfo.getDiscountPrice();
                Iterator iter = priceList.iterator();
                while (iter.hasNext()) {
                  String[] priceArray = (String[]) iter.next();
                %>
                <td class="bottom-menu" ><%= priceArray[1] %></td>
                <%
                }// while iter.next
                %>
              </tr>
              <tr>
                <td class="bottom-menu"><font color="#000000">Price(USD)</font></td>
                <%
                iter = priceList.iterator();
                while (iter.hasNext()) {
                  String[] priceArray = (String[]) iter.next();
                %>
                <td class="bottom-menu" ><%= priceArray[0] %></td>
                <%
                }// while iter.next
                %>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan="7" class="bottom-menu">Lead Time: 30 days, <a href="packagedetail.jsp?giftID=<%= detailInfo.getGiftID()%>&langCode=<%=detailInfo.getLangCode()%>">Click
            Here To See Package Details.</a></td>
        </tr>
        <tr>
          <td class="contact" colspan="7">Any questions, Please feel free to <a href="contact.jsp?giftID=<%= detailInfo.getGiftID()%>&name=<%=detailInfo.getGiftName()%>">contact
            us!</a></td>
        </tr>
      </table>
    </TD>
    <TD COLSPAN=2 height="280" bgcolor="ffffff" valign="middle">
      <div align="center"><img src="<%=detailInfo.getPicFileName()%>" ></div>
    </TD>
  </TR>
  <TR>
  <form name="add" action="cartprocess.jsp" method="POST" target="cart">
    <TD> <IMG src="/images/img-pop/popout_04.gif" WIDTH=250 HEIGHT=27></TD>
      <TD COLSPAN=2 bgcolor="#0037AA" align="center">
        <input type="text" name="quantity" size="5" maxlength="7" value="1">
        <INPUT TYPE="hidden" NAME="langCode" VALUE="<%=detailInfo.getLangCode()%>">
        <INPUT TYPE="hidden" NAME="giftID" VALUE="<%= detailInfo.getGiftID()%>">
    </TD>
    <TD> <input type="image" onClick="addToCart()" src="/images/img-pop/popout_06.gif" WIDTH=238 HEIGHT=27 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="185,5,222,22" ></map></TD>
  </form>
  </TR>
</TABLE>
</BODY>
</HTML>
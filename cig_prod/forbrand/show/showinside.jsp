<%@ page language="java" import="com.forbrand.show.*, java.util.*" %> <jsp:useBean id="productList" scope ="page" class="com.forbrand.show.ListBean" /> 
<jsp:setProperty name="productList" property="*" /> <%
    final int PAGE_LENGTH = 8;                      //No. of product in one page
    productList.setPageLength( PAGE_LENGTH );
    productList.fetchResult();
    productList.check();
    int totalPages = productList.getTotalPages();
    int pageNo = productList.getPageNo();
    String langCode = productList.getLangCode();

    List list = productList.getResultList();
%> 
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
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
    <td colspan=6> <img src="/images/img-sea/search_02.gif" width=704 height=32 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="381,13,459,26" href="portinfo.jsp"><area shape="rect" coords="482,13,555,26" href="../login/myaccount.jsp"><area shape="rect" coords="583,12,692,26" href="cart.jsp" onClick="return js_callpage2(this.href)"></map></td>
  </tr>
  <tr> 
    <td> <img src="/images/img-sea/search_03.gif" width=73 height=18></td>
    <td colspan=5> <img src="/images/img-sea/search_04.gif" width=631 height=18 usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="116,3,204,15" href="showroom.jsp"><area shape="rect" coords="302,3,407,12" href="giftoccasion.jsp?langCode=EN"><area shape="rect" coords="429,3,535,14" href="../login/specialorder.jsp"><area shape="rect" coords="550,3,617,14" href="showinside.jsp?act=4&langCode=EN"><area shape="rect" coords="222,4,284,14" href="showinside.jsp?act=3&langCode=EN"></map></td>
  </tr>
  <tr> <!-- #BeginEditable "replace" --> 
    <td colspan=3 rowspan=3 background="images/background1_05.gif" valign="middle"> 
      <blockquote> 
        <p><span class="orange-title1">HOT SALES</span><span class="dalei"><font color="#FFFFFF"> 
          --</font>hot gifts for hot customers.</span></p>
      </blockquote>
      <%
      if ( list != null && list.size() != 0 ) {
      %> 
      <p align="center" class="black-m-text"> 
      <FORM METHOD=GET ACTION="showinside.jsp">
        Total Pages: <b><%= totalPages %></b>&nbsp;&nbsp;&nbsp;&nbsp; Current 
        Page: <b><%=pageNo%></b>&nbsp;&nbsp;&nbsp;&nbsp;Goto Page <%=productList.getHiddenField()%> 
        <INPUT TYPE="text" NAME="pageNo" size=3>
        &nbsp;&nbsp;&nbsp;&nbsp; <%if ( (pageNo != 1) ) { %> <a href="showinside.jsp<%=productList.getQueryStr()%>&pageNo=<%=pageNo - 1 %>">&lt;&lt;Previous</a>&nbsp;&nbsp; 
        <%} %> <%if ( (pageNo != totalPages) ) { %> <a href="showinside.jsp<%=productList.getQueryStr()%>&pageNo=<%=pageNo + 1 %>">Next&gt;&gt;</a> 
        <%} %> 
      </FORM></p>
      <%
      }// if list!=null && list.size != 0
      %> </td>
    <!-- #EndEditable --> 
    <td colspan=4> <img src="/images/img-sea/search_06.gif" width=188 height=42 usemap="#Map3" border="0"><map name="Map3"><area shape="rect" coords="13,9,121,22" href="search.jsp"></map></td>
  </tr>
   <tr> 
    <td rowspan=2> <img src="../../images/img-sea/search_07.gif" width=40 height=37></td>
    <form name="form1" action="showinside.jsp">
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
<table width="755" border="0" cellspacing="3" cellpadding="0">
  <tr> 
    <td width="570" valign="top"> <%
    if ( list != null && list.size() != 0 ) {

    %> 
      <table  cellspacing="2" cellpadding="2" bordercolor="#CCCCCC" bordercolorlight="#CCCCCC" bordercolordark="#CCCCCC" border="1" align="center">
        <%
      int i = 0;
      String image = "";
      float price;
      String giftNO;
      String giftName = null;
      while ( i < list.size() ) {
        ShowBean show1 = new ShowBean();
        ShowBean show2 = new ShowBean();
        ShowBean show3 = new ShowBean();
        ShowBean show4 = new ShowBean();
        if ( i < list.size() ) show1 = (ShowBean) list.get(i++);
        if ( i < list.size() ) show2 = (ShowBean) list.get(i++);
        if ( i < list.size() ) show3 = (ShowBean) list.get(i++);
        if ( i < list.size() ) show4 = (ShowBean) list.get(i++);

      %> 
        <tr> 
          <td width="99" height="99"> 
            <div align="center"><a href="popup.jsp?giftID=<%= show1.getGiftID() %>&langCode=<%=langCode%>" onClick="return js_callpage(this.href);" target="_blank"> 
              <%= show1.getGiftName() != null ? "<img src=\"" + show1.getPicDir() + show1.getPicFilename() + "\" width=\"88\" height=\"88\" border=\"0\">" : "" %> 
              </a></div>
          </td>
          <td width="99"> 
            <div align="center"><a href="popup.jsp?giftID=<%= show2.getGiftID() %>&langCode=<%=langCode%>" onClick="return js_callpage(this.href);" target="_blank"> 
              <%= show2.getGiftName() != null ? "<img src=\"" + show2.getPicDir() + show2.getPicFilename() + "\" width=\"88\" height=\"88\" border=\"0\">" : "" %> 
              </a></div>
          </td>
          <td width="99"> 
            <div align="center"><a href="popup.jsp?giftID=<%= show3.getGiftID() %>&langCode=<%=langCode%>" onClick="return js_callpage(this.href);" target="_blank"> 
              <%= show3.getGiftName() != null ? "<img src=\"" + show3.getPicDir() + show3.getPicFilename() + "\" width=\"88\" height=\"88\" border=\"0\">" : "" %> 
              </a></div>
          </td>
          <td width="99"> 
            <div align="center"><a href="popup.jsp?giftID=<%= show4.getGiftID() %>&langCode=<%=langCode%>" onClick="return js_callpage(this.href);" target="_blank"> 
              <%= show4.getGiftName() != null ? "<img src=\"" + show4.getPicDir() + show4.getPicFilename() + "\" width=\"88\" height=\"88\" border=\"0\">" : "" %> 
              </a></div>
          </td>
        </tr>
        <tr > 
          <td width="99"> <span class="bottom-menu"> <%= (giftNO = show1.getGiftNO()) == null ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">#" + giftNO + "<br>"  %> 
            <%= (giftName = show1.getGiftName()) == null ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">" + giftName + "<br>" %> 
            <%= (price = show1.getListPrice()) == 0 ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">$" + price%> 
            </span> </td>
          <td width="99"> <span class="bottom-menu"> <%= (giftNO = show2.getGiftNO()) == null ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">#" + giftNO + "<br>"  %> 
            <%= (giftName = show2.getGiftName()) == null ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">" + giftName + "<br>" %> 
            <%= (price = show2.getListPrice()) == 0 ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">$" + price%> 
            </span> </td>
          <td width="99"> <span class="bottom-menu"> <%= (giftNO = show3.getGiftNO()) == null ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">#" + giftNO + "<br>"  %> 
            <%= (giftName = show3.getGiftName()) == null ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">" + giftName + "<br>" %> 
            <%= (price = show3.getListPrice()) == 0 ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">$" + price%> 
            </span> </td>
          <td width="99"> <span class="bottom-menu"> <%= (giftNO = show4.getGiftNO()) == null ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">#" + giftNO + "<br>"%> 
            <%= (giftName = show4.getGiftName()) == null ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">" + giftName + "<br>" %> 
            <%= (price = show4.getListPrice()) == 0 ? "" : "<img src=\"images/showinside/dot.gif\" width=\"13\" height=\"9\">$" + price%> 
            </span> </td>
        </tr>
        <%
      } //while i < list.size
      %> 
      </table>
      <%
    }// if list != null
    else {
      out.println("<CENTER><font color=red><H2>Data not found!</H2></font><h4>Please try again</h4></CENTER>");
    }
    %> <br>
    </td>
    <td width="182" valign="top"> 
      <p> <img src="/images/choose.jpg" width="182" height="32"> <jsp:useBean id="tList" scope="page" class="com.forbrand.show.TypeListBean" /> 
        <%
      tList.setLangCode(langCode);
      tList.fetchTypeList();
      List typeList = tList.getTypeList();
      TypeBean showType;
      HashMap categories;
      for ( int i = 0 ; i < typeList.size() ; i++ ) {
        showType = (TypeBean) typeList.get(i);
        categories = showType.getCategories();
      %> <span class="dalei"><%= showType.getTypeName() %></span> <span class="xiaolei"><br>
        <%
        Iterator iter = categories.keySet().iterator();
        while (iter.hasNext()) {
          String cateName2 = (String) iter.next();
          String cateID2 = (String) categories.get(cateName2);
        %> <a href="showinside.jsp?act=0&cateID=<%= cateID2 %>&langCode=<%= showType.getLangCode() %>"><%= cateName2 %></a> 
        <%
        }//while
        %> </span><br>
        <%
      }//for
      %> 
    </td>
  </tr>
</table>
<div align="right" class="black-m-text"> </div>
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

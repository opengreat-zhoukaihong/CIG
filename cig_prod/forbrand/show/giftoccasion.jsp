<%@ page import="java.util.*" %>
<jsp:useBean id="condition" scope="page" class="com.forbrand.show.SearchConditionBean" />
<jsp:setProperty name="condition" property="*"/>
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
    <td colspan=3 rowspan=3 background="images/background1_05.gif" class="orange-title1">
      <blockquote> WELCOME TO OUR OCCASTION SEARCH!<br>
        <span class="dalei"><font color="#FFFFFF">--------</font><font color="#FFFFFF">--------</font><font color="#FFFFFF">--------</font>To
        find gifts that better fit your needs, please choose: </span> </blockquote>
    </td>
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
<table width="755" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <blockquote>
        <div align="left"> </div>
      </blockquote>
      <table width="666" border="0" cellspacing="8" align="left">
        <tr>
          <td valign="top">
            <div align="right"></div>
            <div align="right"></div>
            <div align="right"><img src="/images/bath.jpg" width="127" height="309"></div>
          </td>
          <td width="466" valign="top" >
            <table border="0" cellspacing="5" cellpadding="5">
              <tr> <%
              condition.fetchoccasions();
              List occasionList = condition.getOccasions();
              int i, j;
              for ( i = 0, j = 4; i < occasionList.size() ; i++, j++ ) {
                String[] occasionInfo = (String[]) occasionList.get(i);
              %>
                <td width="25%"><span class="dalei"><a href="showinside.jsp?act=1&langCode=<%=condition.getLangCode()%>&occasion=<%=occasionInfo[0]%>"><%=occasionInfo[1]%></a></span></td>
                <%
                if ( j%3 == 0 ) {
                  out.println("</tr><tr>");
                  System.out.println("turn, j=" + j);
                  System.out.println("i=" + i);
                }
              }
              %> </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
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

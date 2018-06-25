<%@ page import="java.util.*, com.forbrand.show.TypeBean" %> <jsp:useBean id="conditions" scope="page" class="com.forbrand.show.SearchConditionBean" />
<jsp:useBean id="productList" scope="page" class="com.forbrand.show.TypeListBean" />
<%
conditions.fetchOccasions();
conditions.fetchMaterials();
String langCode = null;
if ( (langCode = request.getParameter("langCode")) != null ) {
  productList.setLangCode(langCode);
}
productList.fetchTypeList();
List typeList = productList.getTypeList();
TypeBean typeInfo;
HashMap categories;
%>
<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" -->
<title>ForBrand.com</title>
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
<%
int i = 0;
int j = 0;
for ( i = 0 ; i < typeList.size() ; i++ ) {
  typeInfo = (TypeBean) typeList.get(i);
  categories = typeInfo.getCategories();
  Iterator iter = categories.keySet().iterator();
  out.println("c" + i + "=new Array();");
  while (iter.hasNext()) {
    String cateName = (String) iter.next();
    String cateID = (String) categories.get(cateName);
    StringBuffer tmp = new StringBuffer("c").append(i).append("[").append(cateID).append("]=\"").append(cateName).append("\";");
    out.println(tmp);
  }//while iter
}// for
%>
var empty = new Array();
var types = new Array();
types[0] = empty;

<%
for (j = 0;j < i ; j++) {
  StringBuffer tmp = new StringBuffer("types[").append(j + 1).append("]=c").append(j);
  out.println(tmp);
}
%>
function changeProp() {
  var selection = document.fullsearch.type.selectedIndex;
  var category = types[selection];
  var length = 0;
  var i, j;
  for ( i = 0; i < category.length; i++ ) {
    if (category[i] != null ) length++;
  }
  document.fullsearch.cateID.options.length= length;
  for ( i = 0, j = 0; i < category.length; i++) {
    if ( category[i] != null) {
      document.fullsearch.cateID.options[j] = new Option(category[i], i);
      j++;
    }
  }
}
</SCRIPT>
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
    <td colspan=3 rowspan=3 background="/images/background1_05.gif">
      <blockquote class="orange-title1">Advanced Search...</blockquote>
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
<table width="755" border="0" cellspacing="9" cellpadding="0">
  <form name="fullsearch" action="showinside.jsp" method="get">
    <tr>
      <td width = "130" rowspan="9" valign="top"><img src="/images/handling.jpg" width="126" height="116"></td>
      <td width="160"> <span class="legal-notice">the name is: </span></td>
      <td>
        <input type="text" name="name" size="15" maxlength="20" class="bottom-menu">
      </td>
    </tr>
    <tr>
      <td  class="legal-notice" rowspan="2" width="160">the category is: </td>
      <td>
        <select name="type" onChange="changeProp()" class="bottom-menu">
          <option value="" selected>---Please select---</option>
          <%
        for ( i = 0 ; i < typeList.size() ; i++ ) {
          typeInfo = (TypeBean) typeList.get(i);
        %>
          <option value="<%=typeInfo.getTypeID()%>"><%=typeInfo.getTypeName()%></option>
          <%
        }
        %>
        </select>
        <select name="cateID" class="bottom-menu">
        </select>
      </td>
    </tr>
    <tr> </tr>
    <tr>
      <td class="legal-notice" width="160">and material is: </td>
      <td >
        <select name="material" class="bottom-menu">
          <option value="" selected>---Please select---</option>
          <%
        List materialList = conditions.getMaterials();
        for (i = 0 ; i < materialList.size() ; i++ ) {
          String[] materialInfo = (String[]) materialList.get(i);
        %>
          <option value="<%=materialInfo[0]%>"><%=materialInfo[1]%></option>
          <%
        }
        %>
        </select>
      </td>
    </tr>
    <tr>
      <td  class="legal-notice" width="160">the occasion is for: </td>
      <td >
        <select name="occasion" class="bottom-menu">
          <option value="" selected>---Please select---</option>
          <%
        List occasionList = conditions.getOccasions();
        for (i = 0 ; i < occasionList.size() ; i++ ) {
          String[] occasionInfo = (String[]) occasionList.get(i);
        %>
          <option value="<%=occasionInfo[0]%>"><%=occasionInfo[1]%></option>
          <%
        }
        %>
        </select>
      </td>
    </tr>
    <tr>
      <td width="160" >t<span class="legal-notice">he price is between: </span>
      </td>
      <td >
        <input type="hidden" name="act" value="1">
        <input type="hidden" name="langCode" value="EN">
        <input type="text" name="priceFrom" value="0" size="10">
        <span class="legal-notice">&nbsp;&nbsp;and&nbsp;&nbsp;</span>
        <input type="text" name="priceTo" value="1000000" size="10">
      </td>
    </tr>
    <tr>
      <td width="160" >&nbsp;</td>
      <td >
        <input type="image" src="/images/find-buttom.jpg" width="68" height="25" border="0">
      </td>
    </tr>
  </form>
  <form name="serialsearch" action="showinside.jsp" method="get">
    <input type="hidden" name="act" value="1">
    <input type="hidden" name="langCode" value="EN">
    <tr>
      <td  class="legal-notice" width="160">I know the serial number:</td>
      <td  >
        <input type="text" name="serialNo" size="8" maxlength="8" class="bottom-menu">
      </td>
    </tr>
    <tr>
      <td width="160">&nbsp;</td>
      <td >
        <input type="image" src="/images/find-buttom.jpg" width="68" height="25" border="0">
      </td>
    </tr>
  </form>
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="../login/error.jsp"%>
<% if(session.getAttribute("operator")==null) {%>
<jsp:forward page="../bst/BackResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnGiftMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../ResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>

<%@ page import="java.util.*, com.forbrand.show.TypeBean" %> 
<jsp:useBean id="conditions" scope="page" class="com.forbrand.show.SearchConditionBean" /> 
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

<html>
<head>
<title>Search Gift</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../public.css">
<script src="/js/formcheck.js"></script>
</head>
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
<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr valign="top"> 
    <td> <br>
      <table width="80%" align="center">
        <tr> 
            <td class="bottom-menu" colspan="3" > 
            <table border="0" cellspacing="2" cellpadding="0" align="center">
              <form name="fullsearch" action="showinside.jsp" method="post">
                <tr> 
                  <td  class="dalei" rowspan="2" width="160">the category is: 
                  </td>
                  <td> 
                    <select name="type" onChange="changeProp()">
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
                    <select name="cateID">
                    </select>
                  </td>
                </tr>
                <tr> </tr>
                <tr> 
                  <td class="dalei" width="160">and material is: </td>
                  <td > 
                    <select name="material">
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
                  <td  class="dalei" width="160">the occation is for: </td>
                  <td > 
                    <select name="occation">
                      <option value="" selected>---Please select---</option>
                      <%
        List occationList = conditions.getOccasions();
        for (i = 0 ; i < occationList.size() ; i++ ) {
          String[] occationInfo = (String[]) occationList.get(i);
        %> 
                      <option value="<%=occationInfo[0]%>"><%=occationInfo[1]%></option>
                      <%
        }
        %> 
                    </select>
                    <input type="hidden" name="name" size="15" value="">
                    <input type="hidden" name="act" value="1">
                    <input type="hidden" name="langCode" value="EN">
                    <input type="hidden" name="priceFrom" value="0">
                    <input type="hidden" name="priceTo" value="1000000">
                  </td>
                </tr>
                <tr> 
                  <td width="160" class="dalei" >&nbsp;</td>
                  <td > 
                    <input type="image" src="/images/find-buttom.jpg" width="68" height="25" border="0">
                  </td>
                </tr>
              </form>
            </table>

            </td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
</table>
</body>
</html>

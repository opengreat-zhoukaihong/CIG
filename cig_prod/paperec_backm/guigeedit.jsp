<html><!-- #BeginTemplate "/Templates/backm_paperec.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中国纸网后台管理系统</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "宋体"; font-size: 9pt}
.title12 {  font-family: "宋体"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "宋体"; text-decoration: underline}
a:visited {  font-family: "宋体"; text-decoration: underline}
a:active {  font-family: "宋体"; text-decoration: underline}
a:hover {  font-family: "宋体"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>

<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="login.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  boolean isPermitted;
  String userID;
  String funcId;

  funcId = "fnCateMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>


<%@ page import="java.util.*" %>
<%@ page import="product.*" %>

<jsp:useBean id="SpecBase" scope="page" class="product.SpecBase" /> 

<jsp:useBean id="SpecBaseHelper" scope="page" class="product.SpecBaseHelper" />
<jsp:setProperty name="SpecBaseHelper" property="action"/>
<jsp:setProperty name="SpecBaseHelper" property="specId"/>
<jsp:setProperty name="SpecBaseHelper" property="editSpecName"/>
<jsp:setProperty name="SpecBaseHelper" property="editSpecDesc"/>
<jsp:setProperty name="SpecBaseHelper" property="langCode"/>

<%
    String spec_id = request.getParameter("specId");
    String lang_code = request.getParameter("langCode");
    SpecBase spec_base;
            
    spec_base = SpecBaseHelper.getSpecBase();
    
    
%>
 
<SCRIPT LANGUAGE="Javascript">
        
    function updateSubmit(){  
        var mf=document.specEditForm;
	mf.action.value = "update";
        
      	mf.submit();


     }
     

</SCRIPT>
 
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>
    
    <td height="257" valign="top"><!-- #BeginEditable "body" -->
      <form name="specEditForm" method="post" action="guigelb.jsp">
      <input type="HIDDEN" name="action" value="">
      <input type="HIDDEN" name="specId" value=<%=spec_id%>>
      <input type="HIDDEN" name="langCode" value=<%=lang_code%>>
 
        <br>
        <br>
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="title12">规格定义编辑：</td>
          </tr>
          <tr align="center"> 
            <td colspan="2">规格名称： 
              <input type="text" name="editSpecName" value="<%=spec_base.specName%>">
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="2">规格描述： 
              <input type="text" name="editSpecDesc" value="<%=spec_base.specDesc%>">
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <a href="#" onClick="javascript:updateSubmit()"><input type="image" border="0" name="imageField" src="../images/submit.gif" width="68" height="26">
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

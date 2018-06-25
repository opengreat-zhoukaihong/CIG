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

<jsp:useBean id="Category" scope="page" class="product.Category" /> 
<jsp:setProperty name="Category" property="langCode" value="GB"/>
<jsp:setProperty name="Category" property="cateId"/>

<jsp:useBean id="SpecBase" scope="page" class="product.SpecBase" /> 

<jsp:useBean id="SpecBaseHelper" scope="page" class="product.SpecBaseHelper" /> 
<jsp:setProperty name="SpecBaseHelper" property="specId"/>
<jsp:setProperty name="SpecBaseHelper" property="langCode" value="GB"/>

<jsp:useBean id="SpecPara" scope="page" class="product.SpecPara" /> 
<jsp:setProperty name="SpecPara" property="editStrI"/>
<jsp:setProperty name="SpecPara" property="editStrM"/>
<jsp:setProperty name="SpecPara" property="langCode"/>
<jsp:setProperty name="SpecPara" property="paraId"/>

<%
   String cate_id = request.getParameter("cateId");
   String spec_id = request.getParameter("specId");
   String para_id = request.getParameter("paraId");
   String lang_code = request.getParameter("langCode");
   String cate_name = Category.getCategoryName();
   String spec_name = SpecBaseHelper.getSpecBase().specName;
   
   String[] str = SpecPara.getStr();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function updateSubmit(){  
        var mf=document.paraEditForm;
	mf.action.value = "update";
        
      	mf.submit();


     }
     

</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --> 
      <form name="paraEditForm" method="post" action="chanpingg_canslb.jsp">
      <input type="HIDDEN" name="action" value="">
      <input type="HIDDEN" name="cateId" value=<%=cate_id%>>
      <input type="HIDDEN" name="specId" value=<%=spec_id%>>
      <input type="HIDDEN" name="paraId" value=<%=para_id%>>
      <input type="HIDDEN" name="langCode" value=<%=lang_code%>>

        <br>
        <br>
        <br>
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td class="title12" colspan="2">产品规格参数编辑：<%=cate_id%>: <%=cate_name%>  <%=spec_id%>: <%=spec_name%></td>
          </tr>
          <tr> 
            <td align="center" width="186">公制选项：</td>
            <td width="208"> 
              <input type="text" name="editStrM" value="<%=str[0]%>">
            </td>
          </tr>
          <tr> 
            <td align="center" width="186">英制选项：</td>
            <td width="208"> 
              <input type="text" name="editStrI" value="<%=str[1]%>">
            </td>
          </tr>
          <tr> 
            <td colspan="2" align="center"> 
              <a href="#" onClick="javascript:updateSubmit()"><input type="image" border="0" name="imageField" src="../images/submit.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

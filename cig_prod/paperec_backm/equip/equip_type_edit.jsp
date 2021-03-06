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

  funcId = "fnEquipMgr";
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
<%@ page import="equipment.*" %>

<jsp:useBean id="EquipType" scope="page" class="equipment.EquipType" /> 
<jsp:setProperty name="EquipType" property="langCode"/>
<jsp:setProperty name="EquipType" property="typeId"/>


<%
    String type_id = request.getParameter("typeId");
    String cate_id = request.getParameter("cateId");
    String lang_code = request.getParameter("langCode");
    String type_name="";
    String paper_flag="";
    
    type_name = EquipType.getTypeName();
    paper_flag = EquipType.getPaperFlag();


       
     
    
%>


<SCRIPT LANGUAGE="Javascript">
        
    function updateSubmit(){  
        var mf=document.nameEditForm;
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
      <form name="nameEditForm" method="post" action="equip_type_list.jsp">
      <input type="HIDDEN" name="action" value="">
      <input type="HIDDEN" name="cateId" value=<%=cate_id%>>
      <input type="HIDDEN" name="typeId" value=<%=type_id%>>
      <input type="HIDDEN" name="langCode" value=<%=lang_code%>>
        <br>
        <br>
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="title12">
            设备类别编辑：<%=type_id%>:<%=type_name%>
            </td>
          </tr>
          <tr> 
            <td colspan="2">名称： 
              <input type="text" name="editTypeName" value="<%=type_name%>">
            </td>
          </tr>
          <tr>
            <td colspan="2">是否纸机： 
              <select name="editPaperFlag">
              <% if (paper_flag.equals("Y")){%>
              <option value=Y selected> 是纸机 </option>
              <option value=N> 不是纸机 </option>
              <% }else{%>
              <option value=Y> 是纸机 </option>
              <option value=N selected> 不是纸机 </option>
              <% }%>
              </select>            
            </td>
          </tr>
          <tr>
            <td colspan="2">
              <a href="#" onClick="javascript:updateSubmit()"><input type="image" border="0" name="imageField" src="/images/submit.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

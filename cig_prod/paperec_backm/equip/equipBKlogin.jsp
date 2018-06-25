 
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中国纸网后台管理系统</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.white {  font-family: "宋体"; font-size: 10pt; color: #FFFFFF}
a:link {  font-family: "宋体"; text-decoration: none}
a:visited {  font-family: "宋体"; text-decoration: none}
a:active {  font-family: "宋体"; text-decoration: none}
a:hover {  font-family: "宋体"; text-decoration: underline}
td {  font-family: "宋体"; font-size: 10pt}
.black {  font-family: "宋体"; color: #000000}
.algin {  font-family: "宋体"; font-size: 10pt; text-align: justify; line-height: 18pt}
-->
</style>
</head>

<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/paperec_backm/login.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  String funcId = "fnConBbsMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

<jsp:useBean id="Equip_Type" scope="page" class="com.paperec.equip.Equip_Type" /> 
<%
    Hashtable pHash =new Hashtable();
    pHash.put("langCode",new String("GB"));
    pHash.put("pageFlag",new String("N"));
    Equip_Type.setParameteres(pHash);
    String[][] lists;
    int count=0;
    lists = Equip_Type.getList();
    count = Equip_Type.getCount();
%>
<SCRIPT LANGUAGE="Javascript">
    function submitThis(){  
        var mf=document.selectForm;     
      	mf.submit();
   }
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" -->
      <form name="selectForm" method="post" action="equipBKList.jsp">     
        <br>
        <table width="450" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr>
            <td class="title12" colspan="2" >Please Select EquipMent(s)： </td>
          </tr>
          <tr align="center"> 
            <td> 
              <select name="type_ID">
              <option value=""> 全部设备 </option>
              <% for (int i=0;i<count;i++){
              %>
              <option value="<%=lists[i][1]%>"> <%=lists[i][2]%> </option>
              <% 
               }
              %>
              </select>
            </td>
            <td> 
              <select name="art_Type">
              <option value=""> 全部信息 </option>
              <option value="B"> 需求信息 </option>
              <option value="S"> 供应信息 </option>
              </select>
              <a href="" onClick="javascript:submitThis()"><input type="image" border="0" name="imageField" src="/images/jixu.gif" width="68" height="26">
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

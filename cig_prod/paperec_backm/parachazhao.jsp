
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

  funcId = "fnSysMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>
 
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
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

<SCRIPT LANGUAGE="Javascript">
        
    function submitThis(){  
        var mf=document.lbSelectForm;     
 
      	mf.submit();

    }
     
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" -->
      <form name="lbSelectForm" method="post" action="xitongcslb.jsp?action=&">     
        <br>
        <table width="450" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr>
            <td class="title12">请选择系统参数类别：</td>
          </tr>
          <tr align="center"> 
            <td> 
              <select name="id">
              <option value="1" selected> 币种 </option>
              <option value="2"> 支付方式 </option>
              <option value="3"> 产品类别 </option>
              <option value="4"> 港口 </option>
              <option value="5"> 信息来源 </option>
              <option value="6"> 状态 </option>
              <option value="7"> 部门 </option>
              <option value="8"> 工作职能 </option>
              <option value="9"> 行业 </option>
              <option value="10"> ISO认证 </option>
              <option value="11"> 工作职称 </option>
              <option value="12"> 产品品牌 </option>
              <option value="13"> 付款方式 </option>
              <option value="14"> 价格条款 </option>
              <option value="15"> 信用度 </option>
              <option value="16"> 汇票的支付期限 </option>
              <option value="17"> 信用证种类 </option>
              <option value="18"> 企业规模 </option>
              <option value="19"> 年营业额 </option>
              <option value="20"> 帐号类型 </option>
              <option value="21"> 机器目前状态 </option>
              </select>
              <a href="" onClick="javascript:submitThis()"><input type="image" border="0" name="imageField" src="../images/jixu.gif" width="68" height="26">
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

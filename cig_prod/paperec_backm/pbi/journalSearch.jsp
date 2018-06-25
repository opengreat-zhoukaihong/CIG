
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

  funcId = "fnPbiMgr";
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
      <form name="lbSelectForm" method="post" action="journalList.jsp?pageNo=1">     
        <br>
        <table width="300" border="1" cellspacing="2" cellpadding="4" bordercolorlight="#4078e0" bordercolordark="#FFFFFF" align="center">        
         <tr align="center">
            <td class="title12" colspan="2">期刊检索</td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="80" height="15">期刊ID：</td>
           <td class="font9" width="220" height="15"><input type="text" name="condJournalId" size="20"></td>
         </tr>         
         <tr align="left"> 
           <td class="font9" width="80" height="15">期刊名称：</td>
           <td class="font9" width="220" height="15"><input type="text" name="condName" size="20"></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="80" height="15">期号：</td>
           <td class="font9" width="220" height="15"><input type="text" name="condIssue"  size="20" ></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="80" height="15">总期号：</td>
           <td class="font9" width="220" height="15"><input type="text" name="condSerialNo" size="20"></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="80" height="15">期刊注解：</td>
           <td class="font9" width="220" height="15"><input type="text" name="condComments" size="20"></td>
         </tr>
         <tr align="center" colspan="2"> 
           <td colspan="2">
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

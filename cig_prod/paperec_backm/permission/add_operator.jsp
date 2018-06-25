<%--  @# add_operator.jsp  Ver 1.0 --%>

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
  String funcId = "fnSecMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.fmOpeDetail;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
</SCRIPT>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name="fmOpeDetail" method="post" action="operator_process.jsp">
      <input type="HIDDEN" name="action" value="add">

	<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">操作员资料增加</td>
          </tr>
        </table>
        <table width="350" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
          <tr> 
            <td width="100" class="font9">操作员ID：</td>
            <td width="200" class="font9">
              <input type="text" name="opeId" value="">
            </td>
          </tr>
          <tr> 
            <td width="100" class="font9">Password：</td>
            <td width="200" class="font9">
              <input type="text" name="passwd" value="">
            </td>
          </tr>
          <tr> 
            <td width="100" class="font9">操作员姓名：</td>
            <td width="200"> 
              <input type="text" name="name" value="">
            </td>
          </tr>
          <tr> 
            <td width="100" class="font9">电话：</td>
            <td width="200" class="font9">
              <input type="text" name="tel" value="">
            </td>
          </tr>
          <tr> 
            <td width="100" class="font9">Email：</td>
            <td width="200" class="font9">
              <input type="text" name="email" value="">
            </td>
          </tr>
          <tr> 
            <td width="100" class="font9">描述：</td>
            <td width="200"> 
              <table width="200" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <textarea name="descr" ></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <table width="350" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30"> <input type="submit" value="增 加">&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="reset" value="Reset"></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

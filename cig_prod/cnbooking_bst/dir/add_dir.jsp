<%--  @# add_dir.jsp  Ver 1.0 --%>

<%@ page import="java.util.*" %>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/main_middle.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnDirMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>


<jsp:useBean id="DirDetail" scope="page" class="com.cnbooking.bst.dir.DirDetail" /> 
<jsp:setProperty name="DirDetail" property="dirId"/>

<%
  DirDetail.getResult();  
%>

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
        var mf=document.fmDirDetail;
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
      <form name="fmDirDetail" method="post" action="dir_process.jsp">
      <input type="HIDDEN" name="action" value="add">
      <input type="hidden" name="opeId" value="admin" >

	<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">目录资料增加</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
          <tr> 
            <td width="70" class="font9">ID：</td>
            <td width="282" class="font9">&nbsp;
            </td>
          </tr>
          <tr> 
            <td width="70" class="font9">路径：</td>
            <td width="282"> 
              <input type="text" name="dir" size="30" value="/path/">
            </td>
          </tr>
          <tr> 
            <td width="70" class="font9">描述：</td>
            <td width="282"> 
              <table width="250" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <textarea name="descr" width="300" cols="30">description</textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="70" class="font9">操作员ID：</td>
            <td width="282" class="font9">&nbsp;admin </td>
          </tr>
        </table>
        <table width="400" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30"> <A href="javascript:addSubmit()"><IMG border=0 height=26 src="/images/botton_add.gif" width=68></A><IMG height=8 src="/images/dot.gif" width=50> 
              <A href="javascript:window.history.go(-1)"><IMG border=0 height=27 src="/images/back.gif" width=67></A> 
              </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

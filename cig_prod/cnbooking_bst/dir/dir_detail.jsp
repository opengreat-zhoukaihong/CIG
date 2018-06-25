<%--  @# dir_detail.jsp  Ver 1.0 --%>

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
        
    function updateSubmit(){  
        var mf=document.frmDirDetail;
	mf.action.value = "update";
        
      	mf.submit();
     }
     
    
    function deleteSubmit(){  
        var mf=document.frmDirDetail;
	mf.action.value = "delete";
        
        if (confirm("你确认删除此记录吗?"))
            mf.submit();
     }     

    function reset(){  
        var mf=document.frmDirDetail;
        
      	mf.reset();
     }     
</SCRIPT>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name="frmDirDetail" method="post" action="dir_process.jsp">
      <input type="HIDDEN" name="action" value="">
      <input type="hidden" name="dirId" value="<%=DirDetail.getDirId()%>" >
      <input type="hidden" name="opeId" value="<%=DirDetail.getOpeId()%>" >

	<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">会员资料</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
          <tr> 
            <td width="70" class="font9">ID：</td>
            <td width="282" class="font9">&nbsp;<%=DirDetail.getDirId()%>
            </td>
          </tr>
          <tr> 
            <td width="70" class="font9">路径：</td>
            <td width="282"> 
              <input type="text" name="dir" size="30" value="<%=DirDetail.getDir()%>">
            </td>
          </tr>
          <tr> 
            <td width="70" class="font9">描述：</td>
            <td width="282"> 
              <table width="250" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <textarea name="descr" width="300" cols="30"><%=DirDetail.getDescr()%></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="70" class="font9">操作员ID：</td>
            <td width="282" class="font9">&nbsp;<%=DirDetail.getOpeId()%> </td>
          </tr>
          <tr> 
            <td width="70" class="font9">创建日期：</td>
            <td width="282" class="font9">&nbsp;<%=DirDetail.getCrDate()%> </td>
          </tr>
          <tr> 
            <td width="70" class="font9">修改日期：</td>
            <td width="282" class="font9">&nbsp;<%=DirDetail.getMdDate()%> </td>
          </tr>
        </table>
        <table width="400" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30"> <A href="javascript:updateSubmit()"><IMG border=0 height=26 src="/images/botton_update.gif" width=68></A><IMG height=8 src="/images/dot.gif" width=50> 
              <A href="javascript:reset()"><IMG border=0 height=27 src="/images/botton_restore.gif" width=67></A> 
              <img height=8 src="/images/dot.gif" width=50> <a href="javascript:deleteSubmit()"><img border=0 height=26 src="/images/deltree.gif" width=68></a></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

<%--Err: <%=DirDetail.errMsg--%>
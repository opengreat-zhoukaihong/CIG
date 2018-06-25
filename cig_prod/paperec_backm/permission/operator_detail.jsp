<%--  @# operator_detail.jsp  Ver 1.0 --%>

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

<%@ page import="java.util.*" %>
<jsp:useBean id="operator" scope="page" class="com.paperec.bst.permission.Operator" /> 
<jsp:setProperty name="operator" property="DEBUG" value="true" />
<jsp:setProperty name="operator" property="dbpoolName" value="paperec" />
<jsp:setProperty name="operator" property="opeId"/>

<%
  operator.searchById();  
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



<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name="fmOperatorDetail" method="post" action="operator_detail.jsp">

	<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">会员资料</td>
          </tr>
        </table>
        <table width="547" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td class="font9" height="30" width="100">Login：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=operator.getOpeId()%> </td>
            <td class="font9" height="30" width="100">Passwd：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=operator.getPasswd()%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">电话：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=operator.getTel()%></td>
            <td class="font9" height="30" width="100">电子邮件：</td>
            <td class="font9" height="30" width="150">&nbsp;<a href="mailto:<%=operator.getEmail()%>" class="font9"><%=operator.getEmail()%></a></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">创建日期：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=operator.getCrDate()%>
            </td>
            <td class="font9" height="30" width="100">修改日期：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=operator.getMdDate()%> </td>
          <tr> 
            <td class="font9" height="30" width="100">描述：</td>
            <td class="font9" height="30" colspan="3">&nbsp;<%=operator.getDescr()%> </td>
          </tr>
        </table>
        <table width="506" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30">&nbsp; </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

<%--Err: <%=operator.errMsg--%>
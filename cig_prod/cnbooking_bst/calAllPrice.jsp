<html>
<head>
<title>CNHotelBooking.com��̨������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>

<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% } %>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnHtPriceMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<SCRIPT LANGUAGE="Javascript">
        
    function confirmDelete(){

          return confirm("��ִ�иù��ܣ�ϵͳ��ɾ�����оƵ����еĶ��ⷢ���۸��ٸ������оƵ���ڲ��۸������ⷢ���ۣ���ȷ��ִ�д˲�����?")

    }
</SCRIPT>



<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="80">&nbsp; </td>
    <td>
      <form name=fmCalPrice method="post" action="calAllPriceResult.jsp">
        <table width="450" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">�Ƶ�۸�����</td>
          </tr>
        </table>
        <table width="450" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td colspan="2" class="font9">ʹ�øù��ܣ������ݾƵ���ڲ��۸��Զ��������оƵ���Ӧ���ⲿ�۸�</td>
          </tr>
          <tr align="middle"> 
            <td colspan="2"> 
              <div align="center"><a href="JavaScript:document.fmCalPrice.submit();" onClick="return confirmDelete()"><img border=0 height=26 src="/images/auto_price1.gif"></a></div>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

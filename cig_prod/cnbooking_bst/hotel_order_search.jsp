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
   String yesterday="";
   String tomorrow="";
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% }else{
   	yesterday = UserInfo.getYesterday();
   	tomorrow  = UserInfo.getTomorrow();
   }
%>


<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnHtBookMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="80">&nbsp; </td>
    <td>
      <form name=fmOrderSearch method="post" action="hotel_order_list.jsp?pageNo=1">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">��������</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td width="90" class="font9">Ԥ��ʱ�䣺</td>
            <td class="font9"> �� 
              <input type="text" name="dateFrom" size="10" maxlength="13" value="<%=yesterday%>">
              �� 
              <input type="text" name="dateTo" size="10" maxlength="13" value="<%=tomorrow%>">
            </td>
          </tr>
          <tr> 
            <td width="90" class="font9">�Ƶ����ƣ�</td>
            <td class="font9"> 
              <input name="hotelName" size="20" >
            </td>
          </tr>
          <tr> 
            <td width="90" class="font9">����ID�ţ�</td>
            <td class="font9"> 
              <input name="bookId" size="20" >
            </td>
          </tr>          
          <tr> 
            <td width="90" class="font9">��ס��������</td>
            <td> 
              <input name="liveName" size="20" 
           >
            </td>
          </tr>
          <tr> 
            <td width="90" class="font9">��ϵ��������</td>
            <td> 
              <input name="contactName" size="20" 
           >
            </td>
          </tr>
          <tr> 
            <td width="90" class="font9">״����̬��</td>
            <td>
              <select name="status">
                <option value="">ȫ��</option>
                <option value="N">δ����</option>
                <option value="Y">���</option>
                <option value="C">ȡ��</option>
                <option value="D">ɾ��</option>
              </select>
            </td>
          </tr>
          <tr align="middle"> 
            <td colspan="2"> 
              <div align="center"><a href="JavaScript:document.fmOrderSearch.submit();"><img border=0 height=26 src="/images/botton_search.gif" width=68></a></div>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

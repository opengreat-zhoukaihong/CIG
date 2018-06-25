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

<%@ page import="java.util.*" %>

<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   String yesterday="";
   String tomorrow="";
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="../main_middle.jsp" />
	</jsp:forward>
<% }else{
   	yesterday = UserInfo.getYesterday();
   	tomorrow  = UserInfo.getTomorrow();
   }
   String ope_ID=UserInfo.getUsername();
%>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnFlOthMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=Sorry! You have no permission!" />
<%}%>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="80">&nbsp; </td>
    <td>
      <form name=fmOrderSearch method="post" action="FlightBK_List.jsp?pageNo=1">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">订单搜索</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
           <tr> 
            <td width="90" class="font9">创建时间：</td>
            <td class="font9"> 从 
              <input type="text" name="dateFrom" size="10" maxlength="13" value="<%=yesterday%>">
              至 
              <input type="text" name="dateTo" size="10" maxlength="13" value="<%=tomorrow%>">
            </td>
         </tr>
         <tr> 
            <td width="90" class="font9">定单ID：</td>
            <td class="font9"> 
              <input name="book_ID" size="20" >
            </td>
          </tr>
          <tr> 
            <td width="90" class="font9">乘客姓名：</td>
            <td> 
              <input name="passenger" size="20">
            </td>
          </tr>          
          <tr> 
            <td width="90" class="font9">联系人姓名：</td>
            <td> 
              <input name="contactName" size="20">
            </td>
          </tr>
          <tr> 
            <td width="90" class="font9">状　　态：</td>
            <td>
            <input type=hidden name="ope_ID"  value="<%=ope_ID%>">
              <select name="actions">
                <option value="">全部</option>
                <option value="C">未处理</option>
                <option value="S">完成</option>
                <option value="F">取消</option>
                <option value="D">删除</option>
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

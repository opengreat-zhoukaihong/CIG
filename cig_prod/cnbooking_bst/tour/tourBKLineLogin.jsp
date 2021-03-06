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

  funcID = "fnTuOthMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=Sorry! You have no permission!" />
<%}%>
<jsp:useBean id="BKCity" scope="page" class="com.cnbooking.bst.BKCity" /> 
<%
int cityCount=0;
String[][] cityList;
cityList=BKCity.getCityList();
cityCount=BKCity.getCityCount();
%>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="80">&nbsp; </td>
    <td>
      <form name=fmSearch method="post" action="tourBKLineList.jsp?pageNo=1">
      <input type=hidden name="ope_ID" value="<%=ope_ID%>" >
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">城市旅游线路管理</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
         <tr> 
            <td width="90" class="font9">时间：</td>
            <td class="font9"> 从 
              <input type="text" name="dateFrom" size="10" maxlength="13" value="<%=yesterday%>">
              至 
              <input type="text" name="dateTo" size="10" maxlength="13" value="<%=tomorrow%>">
            </td>
         </tr>
         <tr> 
            <td width="90" class="font9">旅游主题：</td>
            <td class="font9"> 
              <input name="title" size="20" >
            </td>
          </tr>
          <tr> 
            <td width="90" class="font9">城市：</td>
            <td class="font9"> 
             <select size="1" name="city_ID" >
            <option value="">全部</option>
            <%for(int i=0;i<cityCount;i++){%>
            <option value="<%=cityList[i][0]%>"><%=cityList[i][1]%></option>
            <%}%>
            </select> 
            </td>
          </tr>          
          <tr align="middle"> 
            <td colspan="2"> 
              <div align="center"><a href="JavaScript:document.fmSearch.submit();"><img border=0 height=26 src="/images/botton_search.gif" width=68></a></div>
              <div align="center"><a href="tourBKLineNewIndex.jsp?ope_ID=<%=ope_ID%>">新添加</a></div>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

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

  funcID = "fnCityMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<jsp:useBean id="StateList" scope="page" class="com.cnbooking.bst.StateList" /> 

<%
   String[][] state_list;
   int state_count = 0;
   
   state_list = StateList.getAllState();
   state_count = StateList.getStateCount();
%>


<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="80">&nbsp; </td>
    <td>
      <form name=fmOrderSearch method="post" action="cityList.jsp?pageNo=1&action=">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">城市检索</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td width="90" class="font9">所属省份</td>
            <td class="font9">
            <select name="stateId">
              <option value="">-请选择省份-</option>
              <% for (int i=0;i<state_count;i++){ 
              %>
              <option value="<%=state_list[i][0]%>"><%=state_list[i][1]%></option>
              <% }%>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="90" class="font9">起飞城市标志</td>
            <td class="font9"> 
              <select name="flightFlag">
                <option value="All" selected>全部</option>
                <option value="A">到达</option>
                <option value="S">起飞</option>
                <option value="N">不到达</option>
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

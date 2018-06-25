<html>
<head>


<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "宋体"}
        A:visited {text-decoration: none; font-family: "宋体"}
        A:active {text-decoration: none; font-family: "宋体"}
        A:hover {text-decoration: underline; color: #FFCC33}
-->
</style>
</head>


<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.hotel.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% }%>

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
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<jsp:useBean id="priceTable" scope="page" class="com.cnbooking.bst.PriceTable" />
<%
	String sDate = request.getParameter("startDate");
	String eDate = request.getParameter("endDate");
	String cityID = request.getParameter("cityID");

	priceTable.setStartDate(sDate);
	priceTable.setEndDate(eDate);
	priceTable.setCityID(cityID);

    boolean ret = false;
    ret = priceTable.process();
    String content=priceTable.getContent();
    String mailTo =priceTable.getMailTo();
    if (!ret)
    {
%>
    <jsp:forward page="/inform.jsp?info=34345345" />
<%}%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">



<span class="font9"></span> <span class="font9"></span>
<table width="500" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr>
    <td width="397">
      <table border="0" cellpadding="0" cellspacing="0" width="500">
        <tr>
          <td width="102">&nbsp; </td>
          <td width="398">
            <form name=fmOrderResult  action="">
              <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr>
                  <td class="font12">
                    <p>酒店来价列表已经成功发送给：</p>
                    <p><%=mailTo %></p>
                    <p>请查收。</p>
                    </td>
                </tr>
              </table>
              </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<pre>
<%=content %>
</pre>
</body>
</html>

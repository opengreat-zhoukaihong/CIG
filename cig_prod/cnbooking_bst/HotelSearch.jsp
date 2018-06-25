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
  String userID;
  String funcID;

  funcID = "fnHtPriceMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);

  if (!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=Sorry! You have no permission!" />
<%}%>
<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="dbLookup" scope="page" class="com.cnbooking.hotel.DBLookUp" />
<%
dbLookup.setConnection(db.getConnection());
sqlProvide.setLangCode("GB");
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
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<SCRIPT LANGUAGE=javascript>
<!--

function PostForm()
{
 fmHotelSearch.submit();
}
//-->
</SCRIPT>
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="50">&nbsp; </td>
    <td width="360"> 
      <form name=fmHotelSearch method="post" action="HotelSearchResult.jsp">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">酒店查询</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td class="font9" width="100">按城市名称查询：</td>
            <td> 
              <select name="City" size="1">
                <option value="0" selected >--请选择--</option>
                <%
                dbLookup.setSqlLookup(sqlProvide.getSql("Bst.city"));
       		dbLookup.setDisplayField("name");
       		dbLookup.setValueField("City_Id");
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr> 
            <td class="font9">按城市区域查询：</td>
            <td> 
              <select name="Loca" size="1">
                <option value="0" selected >--请选择--</option>
                <%
                dbLookup.setSqlLookup(sqlProvide.getSql("Bst.Loca"));
       		dbLookup.setDisplayField("Loca_name");
       		dbLookup.setValueField("Loca_Id");
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr> 
            <td class="font9">按酒店名称查询：</td>
            <td> 
              <input type="text" name="HotelName">
            </td>
          </tr>
          <tr> 
            <td class="font9">按酒店星级查询：</td>
            <td> 
              <select name="Star" size="1">
                <option value="0" selected >--请选择--</option>
                <%
       		dbLookup.setSqlLookup(sqlProvide.getSql("Lookup.star"));
       		dbLookup.setDisplayField("name");
       		dbLookup.setValueField("Id");
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr> 
            <td class="font9" width="100">按酒店 ID 查询：</td>
            <td>
              <input type="text" name="HotelId">
            </td>
          </tr>
          <tr> 
            <td class="font9" width="100">按建立预订查询：</td>
            <td> 
              <select name="Status" size="1">
                <option value="0" selected>--请选择--</option>
                <option value="Y">是</option>
                <option value="N">否</option>
              </select>
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> <a href="JavaScript:PostForm()"><img src="../images/botton_search.gif" width="68" height="26" border="0"></a></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
<%db.closeConection();%>

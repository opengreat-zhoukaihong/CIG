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
  
  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=Sorry! You have no permission!" />
<%}%>
<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="quHotel" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="quPriceI" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="dbLookup" scope="page" class="com.cnbooking.hotel.DBLookUp" />
<%
quHotel.setConnection(db.getConnection());
dbLookup.setConnection(db.getConnection());
sqlProvide.setLangCode("GB");
quPriceI.setConnection(db.getConnection());
int rowCount = 0;
sqlProvide.setCityId(request.getParameter("City"));
sqlProvide.setLocaId(request.getParameter("Loca"));
sqlProvide.setStarRating(request.getParameter("Star"));
sqlProvide.setHotelName(request.getParameter("HotelName"));
sqlProvide.setHotelId(request.getParameter("HotelId"));
sqlProvide.setStatus(request.getParameter("Status"));
quHotel.executeQuery(sqlProvide.getSearchSql("Search.Hotel"));
rowCount = quHotel.rowCount();
%>
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
<SCRIPT LANGUAGE="JavaScript">
<!--
var wStr
function PostForm(I)
{
  if ( I ==3)
  {
	wStr = "";
	for (j=0;j<fmHotelResult.elements.length;++j)
	{ 
	  if (fmHotelResult.elements[j].type == "checkbox")
	  {
        if (fmHotelResult.elements[j].checked == true)
        {
          wStr = wStr + "'" + fmHotelResult.elements[j].value + "',"; 
        }
      }
    }
    //alert(wStr + "'0'");
    if (wStr == "")
    {
      alert ("请选择删除的记录!");
      return;
    }
    wStr = wStr + "'0'";
    fmHotelResult.method="post";
    fmHotelResult.action = "/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelRow?TableName=Hotel_gb&ID=" + wStr;
    fmHotelResult.submit();
  }
  else if ( I == 1)
  {
    fmHotelResult.action = "/cnhotel/bst/hotel_search_result.jsp?PageFlag=PREV";
    fmHotelResult.submit();
  }
  else if ( I == 2)
  {
    fmHotelResult.action = "/cnhotel/bst/hotel_search_result.jsp?PageFlag=NEXT";
    fmHotelResult.submit();
  }
  
}

//-->
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span>
<%//=quHotel.getSql()%>
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="54">&nbsp; </td>
    <td width="638"> 
      <form name=fmHotelResult method="post" action="">
        <table width="635" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr>
            <td class="font12">酒店查询结果</td>
          </tr>
        </table>
        <table width="636" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td width="6%" class="font9" align="center" height="40">城市</td>
            <td width="6%" class="font9" height="40"> 
              <div align="center">区域</div>
            </td>
            <td width="10%" class="font9" height="40"> 
              <div align="center">酒店名称</div>
            </td>
            <td width="6%" class="font9" height="40"> 
              <div align="center">星级</div>
            </td>
            <td width="4%" class="font9" height="40"> 价格类型</td>
            <td width="6%" class="font9" height="40"> 
              <div align="center">外部价格</div>
            </td>
            <td width="6%" class="font9" height="40"> 
              <div align="center">内部价格</div>
            </td>
            <td width="7%" class="font9" height="40" align="center">电话</td>
            <td width="10%" class="font9" height="40" align="center">截止日期</td>
            <td width="10%" class="font9" height="40" align="center">外部来源</td>
          </tr>
          <%
          //out.print(sqlProvide.getSql());
          for (int i =1; i <= rowCount && i<=100000; i++)
          {
            quHotel.setRow(i);
            
            %> 
          <tr> 
            <td width="6%" class="font9" align="center"><%=quHotel.getFieldValue("city_name")%></td>
            <td width="6%" class="font9"> 
              <div align="center"><%=quHotel.getFieldValue("Loca_Name").equals("null")?"&nbsp;":quHotel.getFieldValue("Loca_Name")%></div>
            </td>
            <td width="10%" class="font9"> 
              <div align="center"><a href="HotelModify.jsp?HotelId=<%=quHotel.getFieldValue("Hotel_id")%>" class="font9"> 
                <%=quHotel.getFieldValue("name")%></a></div>
            </td>
            <td width="6%" class="font9"> 
              <div align="center"><%=quHotel.getFieldValue("star_name")%></div>
            </td>
            <td width="4%" class="font9"> 
              <div align="center"><%=quHotel.getFieldValue("price_type")%></div>
            </td>
            <td width="6%" class="font9"> 
              <div align="center"><a href="HotelBKPriceList.jsp?hotel_ID=<%=quHotel.getFieldValue("Hotel_id")%>"> 
                <%
               if (!quHotel.getFieldValue("weekday_price").equals("null"))
                 out.print(quHotel.getFieldValue("weekday_price")+ " " 
                  + quHotel.getFieldValue("currency"));
               else
                 out.print("&nbsp;");
               if (!quHotel.getFieldValue("en_weekday_price").equals("null"))
                 out.print("<br>" + quHotel.getFieldValue("en_weekday_price")+ " " 
                  + quHotel.getFieldValue("en_currency"));
               else
                 out.print("&nbsp;");
              %></a></div>
            </td>
            <td width="6%" class="font9"> 
              <div align="center"> <%
                sqlProvide.setPriceTypeId(quHotel.getFieldValue("Price_type_id"));
                sqlProvide.setHotelId(quHotel.getFieldValue("Hotel_id"));
                quPriceI.executeQuery(sqlProvide.getSearchSql("Search.Price_i"));
                //out.print(sqlProvide.getSearchSql("Search.Price_i"));
                quPriceI.setRow(1);
                if (quPriceI.getFieldValue("weekday_price_i").equals("null"))
                  out.print("&nbsp;");
                else
                  out.print(quPriceI.getFieldValue("weekday_price_i") + " RMB");
               
              %> </div>
            </td>
            <td width="7%" class="font9" align="center"><%=quHotel.getFieldValue("tel").equals("null")?"&nbsp;":quHotel.getFieldValue("tel")%> 
            </td>
            <td width="10%" class="font9" align="center"><%=quHotel.getFieldValue("End_date").equals("null")?"&nbsp;":quHotel.getFieldValue("end_date")%></td>
            <td width="10%" class="font9" align="center"><%=quHotel.getFieldValue("Short_name").equals("null")?"&nbsp;":quHotel.getFieldValue("Short_name")%></td>
          </tr>
          <%
          }
          %> 
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
<%db.closeConection();%>

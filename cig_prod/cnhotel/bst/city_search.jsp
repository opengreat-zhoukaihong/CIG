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

<SCRIPT LANGUAGE=javascript>
<!--

function PostForm(I)
{
 if (I==1)
 { 
   fmCitySearch.txtCity.value = "";
   //fmAreaSearch.action = "city_search_result.jsp";
 }
 else
 {
   if (fmCitySearch.txtCity.value == "")
   {
	 alert("请输入城市名称!");
	 return;
   }
   fmCitySearch.sltState.value = "";
   //fmAreaSearch.action = "city_search_result.jsp"; 
 }
 fmCitySearch.submit();
}
//-->
</SCRIPT>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="93">&nbsp; </td>
    <td width="413"> 
      <form name=fmCitySearch method="Post" action="city_search_result.jsp">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">城市查询</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td class="font9" width="100">按省份名称查询：</td>
            <td> 
              <select name="sltState">


<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="state_gb" />
        <jsp:param name="Display" value="name" />
        <jsp:param name="Value" value="stateID" />
</jsp:include>
              </select>
            </td>
          </tr>
          <tr align="middle"> 
            <td colspan="2"> <a href="JavaScript:PostForm(1)"><img border=0 height=26 src="images/botton_search.gif" width=68></a></td>
          </tr>
          <tr> 
            <td class="font9" width="100">按城市名称查询：</td>
            <td> 
              <input name="txtCity" size="30" 
           >
            </td>
          </tr>
          <tr align="middle"> 
            <td colspan="2"><A href="JavaScript:PostForm(2)"><IMG border=0 height=26 src="images/botton_search.gif" width=68></a></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

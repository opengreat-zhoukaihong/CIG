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
function PostForm()
{
  wStr = "";
  for (j=0;j<fmCityResult.elements.length;++j)
  { 
    if (fmCityResult.elements[j].type == "checkbox")
    {
     if (fmCityResult.elements[j].checked == true)
      {
        wStr = wStr + "'" + fmCityResult.elements[j].value + "',"; 
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
  fmCityResult.action = "/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelCity?TableName=City_gb&ID=" + wStr;
  fmCityResult.submit();
  
}

//-->
</SCRIPT>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="62">&nbsp; </td>
    <td width="377"> 
      <form name=fmCityResult method="post" action="">
        <table width="400" border="0" cellspacing="2" cellpadding="5">
          <tr> 
            <td class="font12" height="40">城市查询结果(修改请按ID号)</td>
          </tr>
        </table>
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstSearchCity" flush="true">
</jsp:include>        


      </form>
    </td>
  </tr>
</table>
</body>
</html>

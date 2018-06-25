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
<script language="JavaScript">
function PostForm()
{
  if ((fmAddArea.txtName.value == "")||(fmAddArea.txtMapFile.value == ""))
  {	
	alert("请输入区域名称和地图目录名!");
	return;
  }
  fmAddArea.submit();
}
</script>
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="55">&nbsp; </td>
    <td width="331"> 
      <form name=fmAddArea method="post" action="/servlet/com.dreamerland.cnhotelbooking.bst.CbstAddArea">
        <table width="395" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">更新订房内容</td>
          </tr>
        </table>
        <table width="396" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstAddHotel" flush="true" />          <tr> 
            <td width="62" class="font9">酒店名称：</td>
            <td colspan="2" class="font9"> 4588 
              <input type="hidden" name="txtID" value="2">
            </td>
          </tr>
          <tr> 
            <td width="62" class="font9">客房类型：</td>
            <td class="font9" colspan="2"> dfdfhgfd
              <input type="hidden" name="txtRoomtypeID">
            </td>
          </tr>
          <tr> 
            <td width="62" class="font9" height="32">订房数量：</td>
            <td height="32" class="font9" colspan="2"> 
              <input type="text" name="txtUnit">
            </td>
          </tr>
          <tr> 
            <td width="62" class="font9">入住日期：</td>
            <td class="font9" colspan="2"> 
              <input type="text" name="txtArrivalDate">
            </td>
          </tr>
          <tr> 
            <td width="62" class="font9">离开日期：</td>
            <td class="font9" colspan="2"> 
              <input type="text" name="txtDepartureDate">
            </td>
          </tr>
          <tr> 
            <td width="62" class="font9">单价：</td>
            <td colspan="2"> 
              <input type="text" name="txtPrice">
            </td>
          </tr>
          <tr> 
            <td width="62" class="font9">小计：</td>
            <td colspan="2"> 
              <input type="text" name="txtTotalPrice">
            </td>
          </tr>
          <tr> 
            <td width="62" class="font9">币种：</td>
            <td colspan="2"> 
              <input type="text" name="txtCurrency" maxlength="3">
            </td>
          </tr>
          <tr> 
            <td width="62" class="font9">要求吸烟：</td>
            <td class="font9" width="235"> 
              <input type="radio" name="rdSmoke" value="Y" checked>
              是 
              <input type="radio" name="rdSmoke" value="N">
              否 </td>
          </tr>
        </table>
        <table width="400" border="0" cellspacing="0" cellpadding="0">
          <tr align="center"> 
            <td height="50"> <a href="JavaScript:PostForm()"><img src="images/botton_update.gif" width="68" height="26" border="0"></a><img src="images/dot.gif" width="50" height="1"> 
              <a href="http://bst.cnbooking.com/newarea_add.htm"><img src="images/botton_restore.gif" width="68" height="25" border="0"></a> 
              <img src="images/dot.gif" width="50" height="1"><img src="images/deltree.gif" width="68" height="26" border="0"> 
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

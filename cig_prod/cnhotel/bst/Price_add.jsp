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
    <td width="355"> 
      <form name=fmAddArea method="post" action="/servlet/com.dreamerland.cnhotelbooking.bst.CbstAddArea">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
		  
          <tr> 
            <td class="font12">添加客房<font size="2">[添加酒店成功]</font></td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstAddHotel" flush="true" />          <tr> 
            <td width="66" class="font9">酒店编号：</td>
            <td colspan="2" class="font9" width="302"> 4588 
              <input type="hidden" name="txtID" value="2">
            </td>
          </tr>
          <tr> 
            <td colspan="3" class="font9">
               
              <table width="100%" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
                <tr> 
                  <td class="font9">客房类别</td>
                  <td class="font9">客房单价</td>
                  <td class="font9">币种</td>
                  <td class="font9">图片目录</td>
                  <td class="font9">图片文件</td>
                </tr>
                <tr> 
                  <td class="font9">客房类别</td>
                  <td class="font9">客房单价</td>
                  <td class="font9">币种</td>
                  <td class="font9">图片目录</td>
                  <td class="font9">图片文件</td>
                </tr>
                
              </table>
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">酒店名称：</td>
            <td colspan="2" class="font9" width="302"> 45435435</td>
          </tr>
          <tr> 
            <td width="66" class="font9" height="32">客房类别：</td>
            <td height="32" class="font9" colspan="2" width="302"> 
              <select name="sltRoomType" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true" />              </select>
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">客房单价：</td>
            <td class="font9" colspan="2" width="302"> 
              <input type="text" name="txtPrice">
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">币种：</td>
            <td class="font9" colspan="2" width="302"> 
              <input type="text" name="txtCurrency">
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">图片目录：</td>
            <td colspan="2" width="302"> 
              <select name="sltMapDir" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true" />              </select>
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">图片文件：</td>
            <td colspan="2" width="302"> 
              <input type="text" name="txtMapFile" size="30">
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">房间描述：</td>
            <td colspan="2" width="302"> 
              <textarea name="txtDesc" cols="40"></textarea>
            </td>
          </tr>
        </table>
        <table width="400" border="0" cellspacing="0" cellpadding="0">
          <tr align="center"> 
            <td height="50"> <a href="JavaScript:PostForm()"><img src="images/botton_add.gif" width="68" height="26" border="0"></a><img src="images/dot.gif" width="50" height="1"> 
              <a href="http://bst.cnbooking.com/newarea_add.htm"><img src="images/botton_restore.gif" width="68" height="26" border="0"></a> 
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

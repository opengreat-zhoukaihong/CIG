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


function PostForm()
{
  if ((fmMember.txtName.value == "")||(fmMember.txtCity.value == ""))
  {	
	alert("请输入名称和城市!");
	return;
  }
  fmMember.submit();
}
//-->
</SCRIPT>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="30" height="418">&nbsp; </td>
    <td width="503" height="418"> 
      <form name= fmMember method="post" action="/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstUpdateMember">
        <table width="515" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">更新会员资料</td>
          </tr>
        </table>
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstGetMember" flush="true" />        
        <table width="515" border="0" cellspacing="0" cellpadding="0" height="50">
          <tr align="center"> 
            <td height="50"><a href="javascript:PostForm()"><img src="images/botton_update.gif" width="68" height="26" border="0"></a><img src="images/dot.gif" width="50" height="1"> 
              <a href="javascript:fmMember.reset()"><img src="images/botton_restore.gif" width="68" height="26" border="0"></a> 
            </td>
          </tr>
        </table>
        <br>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

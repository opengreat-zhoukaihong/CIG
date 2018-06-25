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
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="JavaScript">
function PostForm()
{
  if (fmAddCity.txtName.value == "")
  {	
	alert("请输入城市名称!");
	return;
  }
  fmAddCity.submit();
}
</script>
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="52">&nbsp;&nbsp; </td>
    <td width="358"> 
      <form name=fmAddCity method="post" action="/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstUpdateCity">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">更新新城市</td>
          </tr>
        </table>

<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstGetCity" flush="true">
</jsp:include>
    
        <table width="400" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="50"> <A href="JavaScript:PostForm()"><IMG border=0 height=26 src="images/botton_update.gif" width=68></A><IMG height=1 src="images/dot.gif" width=50> 
              <A href="javascript:fmAddCity.reset()"><IMG border=0 height=26 src="images/botton_restore.gif" width=68></A> 
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

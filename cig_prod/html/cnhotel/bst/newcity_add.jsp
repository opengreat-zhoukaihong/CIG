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
    <td width="60">&nbsp; </td>
    <td width="389"> 
      <form name=fmAddCity method="post" action="/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstAddCity">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">添加新城市</td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
          <tr> 
            <td width="70" class="font9">省份：</td>
            <td width="282"> 
              <select name="sltState">
                <servlet code="com.dreamerland.cnhotelbooking.bst.CbstLookUp" table=state_gb display=name value=stateID></servlet> 

<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="state_gb" />
        <jsp:param name="Display" value="name" />
        <jsp:param name="Value" value="stateID" />
</jsp:include>

              </select>
            </td>
          </tr>
          <tr> 
            <td width="70" class="font9" height="28">城市：</td>
            <td width="282" height="28"> 
              <p> 
                <input type="text" name="txtName" size="30">
              </p>
            </td>
          </tr>
          <tr> 
            <td width="70" class="font9">描述：</td>
            <td width="282"> 
              <table width="250" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <textarea name="txtDesc" width="300" cols="30"></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <table width="400" border="0" cellspacing="0" cellpadding="0">
          <tr align="center"> 
            <td height="50"> <a href="JavaScript:PostForm()"><img src="images/botton_add.gif" width="68" height="26" border="0"></a><img src="images/dot.gif" width="50" height="1"> 
              <a href="javascript:fmAddCity.reset()"><img src="images/botton_restore.gif" width="68" height="25" border="0"></a> 
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

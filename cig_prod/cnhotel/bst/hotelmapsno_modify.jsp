<html>
<head>
<title>CNHotelBooking.com��̨������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<SCRIPT LANGUAGE=javascript>
<!--


function PostForm()
{      
    fmAddHotel.submit();  
 }    

//-->
</SCRIPT>

<span class="font9"></span> <span class="font9"></span> 
     <form name= fmAddHotel method="post" action="/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstUpdateHotelMap">
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="26">&nbsp; </td>
    <td width="547"> 
        <table width="550" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td height="30" class="font12"> ά���Ƶ��ͼ����</td>
          </tr>
        </table>
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstGetHotelMap" flush="true" />
        <table width="550" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="40"> <A href="JavaScript:PostForm()"><IMG border=0 height=26 src="images/botton_update.gif" width=68></A><IMG height=1 src="images/dot.gif" width=50> 
              <A href="javascript:fmAddHotel.reset()"><IMG border=0 height=26 src="images/botton_restore.gif" width=68></a></td>
          </tr>
        </table>
    </td>
  </tr>
</table>
     </form>
</body>
</html>

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
    fmOrderResult.method="post"
    fmOrderResult.action = "/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstUpdateOrder";
    
    fmOrderResult.submit();
  }
  else if (I==2)
  {
    //fmOrderResult.method="get"
	//fmOrderResult.action = "cnhotel/bst/order_update.jsp?ID=" + fmOrderResult.txtID.value ;
    
    //fmOrderResult.submit();
    fmOrderResult.reset();
  }
  else if (I==3)
  {
    fmOrderResult.method="post"
    fmOrderResult.action = "/servlet/com.dreamerland.cnhotelbooking.bst.CbstConfirm";
    
    fmOrderResult.submit();
  } 
    
}
//-->
</SCRIPT>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name=fmOrderResult method="" action="">

<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstGetOrder" flush="true" />        <table width="506" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30"> <A href="javascript:PostForm(1)"><IMG border=0 height=26 src="images/botton_update.gif" width=68></A><IMG height=8 src="images/dot.gif" width=50> 
              <A href="javascript:PostForm(2)"><IMG border=0 height=27 src="images/botton_restore.gif" width=67></A> 
              <img height=8 src="images/dot.gif" width=50> <a href="javascript:PostForm(3)"><img border=0 height=26 src="images/enter.gif" width=68></a></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

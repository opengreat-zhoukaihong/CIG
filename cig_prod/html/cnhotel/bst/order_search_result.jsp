<html>
<head>
<title>CNHotelBooking.com��̨��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "����"}
        A:visited {text-decoration: none; font-family: "����"}
        A:active {text-decoration: none; font-family: "����"}
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
	for (j=0;j<fmOrderResult.elements.length;++j)
	{ 
	  if (fmOrderResult.elements[j].type == "checkbox")
	  {
        if (fmOrderResult.elements[j].checked == true)
        {
          wStr = wStr + "'" + fmOrderResult.elements[j].value + "',"; 
        }
      }
    }
    //alert(wStr + "'0'");
    if (wStr == "")
    {
      alert ("��ѡ��ɾ���ļ�¼!");
      return;
    }
    wStr = wStr + "'0'";
    fmOrderResult.action = "/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelRow?TableName=Booking_gb&ID=" + wStr;
    fmOrderResult.submit();
  }
  else if ( I == 1)
  {
    fmOrderResult.action = "/cnhotel/bst/order_search_result.jsp?PageFlag=PREV";
    fmOrderResult.submit();
  }
  else if ( I == 2)
  {
    fmOrderResult.action = "/cnhotel/bst/order_search_result.jsp?PageFlag=NEXT";
    fmOrderResult.submit();
  }
  
}

//-->
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table width="478" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr>
    <td width="80">&nbsp;</td>
    <td width="397"> 
      <table border="0" cellpadding="0" cellspacing="0" width="50">
        <tr> 
          <td width="10">&nbsp; </td>
          <td> 
            <form name=fmOrderResult method="post" action="">
              <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">������ѯ���(�޸��밴ID��)</td>
                </tr>
              </table>
              <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstSearchOrder" flush="true" />              </table> 
            </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
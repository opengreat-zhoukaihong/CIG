<html>
<head>
<title>CNHotelBooking.com��̨������</title>
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
	for (j=0;j<fmHotelResult.elements.length;++j)
	{ 
	  if (fmHotelResult.elements[j].type == "checkbox")
	  {
        if (fmHotelResult.elements[j].checked == true)
        {
          wStr = wStr + "'" + fmHotelResult.elements[j].value + "',"; 
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
    fmHotelResult.method="post";
    fmHotelResult.action = "/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelRow?TableName=Hotel_gb&ID=" + wStr;
    fmHotelResult.submit();
  }
  else if ( I == 1)
  {
    fmHotelResult.action = "/cnhotel/bst/hotel_search_result.jsp?PageFlag=PREV";
    fmHotelResult.submit();
  }
  else if ( I == 2)
  {
    fmHotelResult.action = "/cnhotel/bst/hotel_search_result.jsp?PageFlag=NEXT";
    fmHotelResult.submit();
  }
  
}

//-->
</SCRIPT>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span>
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="54">&nbsp; </td>
    <td width="407">
      <form name=fmHotelResult method="post" action="">
        <table width="460" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr>
            <td class="font12">�Ƶ��ѯ���</td>
          </tr>
        </table>
        <table width="460" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstSearchHotel" flush="true" />
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

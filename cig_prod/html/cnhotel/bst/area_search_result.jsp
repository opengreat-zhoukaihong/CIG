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
function PostForm()
{
  wStr = "";
  for (j=0;j<fmAreaResult.elements.length;++j)
  { 
    if (fmAreaResult.elements[j].type == "checkbox")
    {
     if (fmAreaResult.elements[j].checked == true)
      {
        wStr = wStr + "'" + fmAreaResult.elements[j].value + "',"; 
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
  fmAreaResult.action = "/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelRow?TableName=Area_gb&ID=" + wStr;
  fmAreaResult.submit();
  
}

//-->
</SCRIPT>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="62">&nbsp; </td>
    <td width="377"> 
      <form name=fmAreaResult method="post" action="">
        <table width="400" border="0" cellspacing="2" cellpadding="5">
          <tr> 
            <td class="font12" height="40">�����ѯ���(�޸��밴ID��)</td>
          </tr>
        </table>
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstSearchArea" flush="true" />        
      </form>
    </td>
  </tr>
</table>
</body>
</html>

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
	for (j=0;j<fmOpen.elements.length;++j)
	{ 
	  if (fmOpen.elements[j].type == "checkbox")
	  {
        if (fmOpen.elements[j].checked == true)
        {
          wStr = wStr + "'" + fmOpen.elements[j].value + "',"; 
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
    fmOpen.method="post";
    fmOpen.action = "/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelRow?TableName=Operator_gb&ID=" + wStr;
    fmOpen.submit();
  }
  else if ( I == 1)
  {
    fmOpen.action = "cnhotel/bst/open_Dir.jsp?PageFlag=PREV";
    fmOpent.submit();
  }
  else if ( I == 2)
  {
    fmOpen.action = "cnhotel/bst/open_Dir.jsp?PageFlag=NEXT";
    fmOpen.submit();
  }
  
}

//-->
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table width="592" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr>
    <td width="58">&nbsp;</td>
    <td width="534"> 
      <table border="0" cellpadding="0" cellspacing="0" width="525">
        <tr> 
          <td width="1">&nbsp; </td>
          <td width="524"> 
            <form name=fmOpen  action="">
              <table width="518" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">��ѯ���(�޸��밴ID��)</td>
                </tr>
              </table>
              <table width="519" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstOpenOperator" flush="true" />              </table>
            </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

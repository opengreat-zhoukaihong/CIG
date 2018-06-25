<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "宋体"}
        A:visited {text-decoration: none; font-family: "宋体"}
        A:active {text-decoration: none; font-family: "宋体"}
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
      alert ("请选择删除的记录!");
      return;
    }
    wStr = wStr + "'0'";
    fmOpen.method="post";
    fmOpen.action = "/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelRow?TableName=Dir_setting&ID=" + wStr;
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
<table width="478" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr>
    <td width="80">&nbsp;</td>
    <td width="397"> 
      <table border="0" cellpadding="0" cellspacing="0" width="50">
        <tr> 
          <td width="10">&nbsp; </td>
          <td> 
            <form name=fmOpen  action="">
              <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">查询结果(修改请按ID号)</td>
                </tr>
              </table>
              <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr align="center"> 
                  <td class="font9" width="40">代号</td>
                  <td class="font9" width="59">路经</td>
                  <td class="font9" colspan="3">说明</td>
                </tr>
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstOpenDir" flush="true" />              </table>
            </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</body>
</html>

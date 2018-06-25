<html><head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">

<title>CNHotelBooking.com后台管理工具</title>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
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
  if (I==3)
  {
  	wStr = "";
  	for (j=0;j<fmMemberResult.elements.length;++j)
  	{ 
      if (fmMemberResult.elements[j].type == "checkbox")
      {
        if (fmMemberResult.elements[j].checked == true)
        {
         wStr = wStr + "'" + fmMemberResult.elements[j].value + "',"; 
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
    fmMemberResult.action = "/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelRow?TableName=Customer_gb&ID=" + wStr;
   }
   else if (I==1)
   {
     fmMemberResult.action = "/cnhotel/bst/membersearch_result.jsp?PageFlag=PREV";
   }
   else if (I==2)
   {
     fmMemberResult.action = "/cnhotel/bst/membersearch_result.jsp?PageFlag=NEXT";
   }  
 fmMemberResult.submit();
  
}
/*function PostForm() {
  if ( fmMemberResult.ckID.checked == true ) {
   fmMemberResult.action = "/servlet/com.dreamerland.cnhotelbooking.bst.CbstDelRow?TableName=Customer_gb&ID=" + 
     fmMemberResult.ckID.value;
     fmMemberResult.submit();
  }
  else {
    alert ("请选择删除的记录!");
    return;
   
  }
}*/



//-->
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> 
<form name=fmMemberResult  method="post" action="">
  <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="30">&nbsp;</td>
      <td width="438"> 
        <table width="432" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">会员搜索结果(修改请按ID号)</td>
          </tr>
        </table>
        <table width="435" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
         
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstSearchMember" flush="true" />            
          
          
        </table>
      </td>
    </tr>
  </table>
</form>
<span class="font9"></span> 
</body>
</html>

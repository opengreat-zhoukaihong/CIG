<html>
<head>
<title>CNHotelBooking.com��̨��������</title>
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
  if ((fmAddArea.txtName.value == "")||(fmAddArea.txtMapFile.value == ""))
  {	
	alert("�������������ƺ͵�ͼĿ¼��!");
	return;
  }
  fmAddArea.submit();
}
</script>
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="55">&nbsp; </td>
    <td width="355"> 
      <form name=fmAddArea method="post" action="/servlet/com.dreamerland.cnhotelbooking.bst.CbstAddArea">
        <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
		  
          <tr> 
            <td class="font12">���ӿͷ�<font size="2">[���ӾƵ�ɹ�]</font></td>
          </tr>
        </table>
        <table width="400" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstAddHotel" flush="true" />          <tr> 
            <td width="66" class="font9">�Ƶ��ţ�</td>
            <td colspan="2" class="font9" width="302"> 4588 
              <input type="hidden" name="txtID" value="2">
            </td>
          </tr>
          <tr> 
            <td colspan="3" class="font9">
               
              <table width="100%" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
                <tr> 
                  <td class="font9">�ͷ����</td>
                  <td class="font9">�ͷ�����</td>
                  <td class="font9">����</td>
                  <td class="font9">ͼƬĿ¼</td>
                  <td class="font9">ͼƬ�ļ�</td>
                </tr>
                <tr> 
                  <td class="font9">�ͷ����</td>
                  <td class="font9">�ͷ�����</td>
                  <td class="font9">����</td>
                  <td class="font9">ͼƬĿ¼</td>
                  <td class="font9">ͼƬ�ļ�</td>
                </tr>
                
              </table>
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">�Ƶ����ƣ�</td>
            <td colspan="2" class="font9" width="302"> 45435435</td>
          </tr>
          <tr> 
            <td width="66" class="font9" height="32">�ͷ����</td>
            <td height="32" class="font9" colspan="2" width="302"> 
              <select name="sltRoomType" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true" />              </select>
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">�ͷ����ۣ�</td>
            <td class="font9" colspan="2" width="302"> 
              <input type="text" name="txtPrice">
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">���֣�</td>
            <td class="font9" colspan="2" width="302"> 
              <input type="text" name="txtCurrency">
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">ͼƬĿ¼��</td>
            <td colspan="2" width="302"> 
              <select name="sltMapDir" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true" />              </select>
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">ͼƬ�ļ���</td>
            <td colspan="2" width="302"> 
              <input type="text" name="txtMapFile" size="30">
            </td>
          </tr>
          <tr> 
            <td width="66" class="font9">����������</td>
            <td colspan="2" width="302"> 
              <textarea name="txtDesc" cols="40"></textarea>
            </td>
          </tr>
        </table>
        <table width="400" border="0" cellspacing="0" cellpadding="0">
          <tr align="center"> 
            <td height="50"> <a href="JavaScript:PostForm()"><img src="images/botton_add.gif" width="68" height="26" border="0"></a><img src="images/dot.gif" width="50" height="1"> 
              <a href="http://bst.cnbooking.com/newarea_add.htm"><img src="images/botton_restore.gif" width="68" height="26" border="0"></a> 
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
<html>
<head>
<title>PBI</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-family: "����"; font-size: 12px}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
a:link {  font-family: "����"; text-decoration: none; font-size: 12px; color: #000000}
a:visited {  font-family: "����"; color: #000000; font-size: 12px; text-decoration: none}
a:active {  font-family: "����"; color: #000000; font-size: 12px}
a:hover {  font-family: "����"; color: #6666FF; text-decoration: underline; font-size: 12px}
-->
</style>
</head>

<body bgcolor="#FFFFFF" onload="Javascript:Load()">
<SCRIPT LANGUAGE=JavaScript>
<!--
function Load()
{
  now = new Date();
  wMonth = now.getMonth() + 1;
  if (wMonth < 10)
    wMonth = "0" + wMonth;
  wDate = now.getDate();
  if (wDate < 10)
    wDate="0"+ wDate;
  wStartDate = now.getDate() - 1;
  wEndDate = now.getDate() + 1;
  if (wStartDate < 10)
    wStartDate="0"+ wStartDate;
  fmSearchArticle.condDateFrom.value = now.getYear() + "-" + wMonth + "-" + wStartDate;
  fmSearchArticle.condDateTo.value = now.getYear() + "-" + wMonth + "-" + wEndDate;
}
//-->
</SCRIPT>
<BR><BR>
<table width="600" border="0" cellspacing="2" cellpadding="5" height="40">
  <tr> 
    <td class="font12">��ѯ�ĸ�</td>
  </tr>
</table>
<form name="fmSearchArticle" method="post" action="/paperec_backm/pbi/article_list.jsp">
  <table width="450" border="1" cellspacing="0" cellpadding="6" align="center" bordercolorlight="#94000" bordercolordark="#FFFFFF">
    <tr> 
      <td> 
        <table width="450" border="0" cellspacing="0" cellpadding="4">
          <tr bgcolor="#fff3ee"> 
            <td width="137" class="font9" align="center">���Դ��룺</td>
            <td width="281"> 
              <select name="condLangCode">
<option value=''>ȫ��</option>
<option value='EN'>English</option>
<option value='GB'>GB</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="137" class="font9" align="center">�ĸ��������⣺</td>
            <td width="281"> 
              <input type="text" name="condHeader">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td width="137" class="font9" align="center">��ʼ�������ڣ�</td>
            <td width="281"> 
              <input type="text" name="condDateFrom">
            </td>
          </tr>
          <tr> 
            <td width="137" class="font9" align="center">��ֹ�������ڣ�</td>
            <td width="281"> 
              <input type="text" name="condDateTo">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td width="137" class="font9" align="center">�����ؼ��֣�</td>
            <td width="281"> 
              <input type="text" name="condMetaKey">
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input type="submit" name="Submit" value="ȷ����">
              ����
              <input type="reset" name="Submit2" value="ȡ ��">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

<html>
<head>
<title>PBI</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-family: "宋体"; font-size: 12px}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
a:link {  font-family: "宋体"; text-decoration: none; font-size: 12px; color: #000000}
a:visited {  font-family: "宋体"; color: #000000; font-size: 12px; text-decoration: none}
a:active {  font-family: "宋体"; color: #000000; font-size: 12px}
a:hover {  font-family: "宋体"; color: #6666FF; text-decoration: underline; font-size: 12px}
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
    <td class="font12">查询文稿</td>
  </tr>
</table>
<form name="fmSearchArticle" method="post" action="/paperec_backm/pbi/article_list.jsp">
  <table width="450" border="1" cellspacing="0" cellpadding="6" align="center" bordercolorlight="#94000" bordercolordark="#FFFFFF">
    <tr> 
      <td> 
        <table width="450" border="0" cellspacing="0" cellpadding="4">
          <tr bgcolor="#fff3ee"> 
            <td width="137" class="font9" align="center">语言代码：</td>
            <td width="281"> 
              <select name="condLangCode">
<option value=''>全部</option>
<option value='EN'>English</option>
<option value='GB'>GB</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="137" class="font9" align="center">文稿索引标题：</td>
            <td width="281"> 
              <input type="text" name="condHeader">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td width="137" class="font9" align="center">起始创建日期：</td>
            <td width="281"> 
              <input type="text" name="condDateFrom">
            </td>
          </tr>
          <tr> 
            <td width="137" class="font9" align="center">截止创建日期：</td>
            <td width="281"> 
              <input type="text" name="condDateTo">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td width="137" class="font9" align="center">搜索关键字：</td>
            <td width="281"> 
              <input type="text" name="condMetaKey">
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input type="submit" name="Submit" value="确　定">
              　　
              <input type="reset" name="Submit2" value="取 消">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

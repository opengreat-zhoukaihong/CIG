<html>
<head>
<title>�� ��</title>
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
  fmArticleAdd.pbDate.value = now.getYear() + "-" + wMonth + "-" + wDate;
}
function PostForm(I)
{
   if (fmArticleAdd.pbDate.value == "")
   {
	 alert("�����뷢������!");
	 return;
   }
   if (fmArticleAdd.header.value == "")
   {
	 alert("�������ĸ��������!");
	 return;
   }
   if (fmArticleAdd.content.value == "")
   {
	 alert("�������ĸ���������!");
	 return;
   }
   fmArticleAdd.submit();
}
//-->
</SCRIPT>
<BR><BR>
<table width="600" border="0" cellspacing="2" cellpadding="5" height="40">
  <tr> 
    <td class="font12">����ĸ�</td>
  </tr>
</table>
<form name="fmArticleAdd" method="post" action="/paperec_backm/pbi/article_process.jsp">
  <input type="HIDDEN" name="action" value="add">
  <table width="600" border="1" cellspacing="0" cellpadding="6" align="center" bordercolorlight="#94000" bordercolordark="#FFFFFF">
    <tr> 
      <td height="469"> 
        <table width="600" border="0" cellspacing="0" cellpadding="4">
          <tr bgcolor="#fff3ee"> 
            <td width="117" class="font9">���Դ��룺</td>
            <td width="164"> 
              <select name="langCode">
<option value='EN'>English</option>
<option value='GB'>GB</option>
              </select>
            </td>
            <td width="99" class="font9">�ĸ���Դ��</td>
            <td width="188"> 
              <input type="text" name="source" size="18">
            </td>
          </tr>
          <tr> 
            <td class="font9" width="117">ģ�����ͣ�</td>
            <td width="164"> 
              <select name="templateId">
                <option value="0">��̬ҳ��</option>
                <option value="1">ͼƬ����</option>
                <option value="2">ͼƬ����</option>
                <option value="3">ͼƬ����</option>
                <option value="4" selected>��ͼƬ</option>
              </select>
            </td>
            <td class="font9" width="99">���ߣ�</td>
            <td width="188"> 
              <input type="text" name="Author" size="18">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td class="font9" width="117">��̬�ĸ�URL��</td>
            <td width="164"> 
              <input type="text" name="htmlURL" size="18">
            </td>
            <td class="font9" width="99"> &nbsp;</td>
            <td width="188"> &nbsp;
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td class="font9" width="117">�ĸ��������⣺</td>
            <td colspan="3"> 
              <input type="text" name="header" size="50">
              <font color="#FF6666">*</font> </td>
          </tr>
          <tr> 
            <td class="font9" width="117">�������ڣ�</td>
            <td width="164"> 
              <input type="text" name="pbDate" size="18">
              <font color="#FF6666">*</font> </td>
            <td class="font9" width="99">�ĸ�ؼ��֣�</td>
            <td width="188"> 
              <input type="text" name="metaKey" size="18">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td class="font9" width="117">�ĸ�������ݣ�</td>
            <td colspan="3"> 
              <input type="text" name="title" size="50">
              <font color="#FF6666">*</font> </td>
          </tr>
          <tr> 
            <td class="font9" width="117">�ĸ��ӱ������ݣ�</td>
            <td colspan="3"> 
              <input type="text" name="subTitle" size="50">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td class="font9" width="117">�ĸ��������ݣ�</td>
            <td colspan="3"> 
              <textarea name="content" cols="50" rows="10"></textarea>
              <font color="#FF6666">*</font> </td>
          </tr>
          <tr align="center"> 
            <td colspan="4"> 
              <input type="button" name="Submit3" value="���" onClick="javaScript:PostForm(1)">
              <input type="reset" name="Submit4" value="ȡ��">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

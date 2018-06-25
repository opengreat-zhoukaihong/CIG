 
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中国纸网后台管理系统</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "宋体"; font-size: 9pt}
.title12 {  font-family: "宋体"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "宋体"; text-decoration: underline}
a:visited {  font-family: "宋体"; text-decoration: underline}
a:active {  font-family: "宋体"; text-decoration: underline}
a:hover {  font-family: "宋体"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>
<% 
    String info=request.getParameter("info");
%>

<script language="javascript">
    function reload(){
      window.history.back()
         }
</script>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr> 
    
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <form method="post" action="">
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" height="300" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr align="center"> 
            <td class="title12" height="249"><%=info%></td>
          </tr>
          <tr align="center"> 
            <td class="title12">
              <a href="#" onclick="javascript:window.history.go(-1)"><input type="image" border="0" name="imageField" src="../images/back.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
        <br>
        <br>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

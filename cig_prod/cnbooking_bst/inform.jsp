 
<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
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

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr > 
    <td width="80">&nbsp; </td>
        <table width="250" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff" align="center">
          <tr> 
            <td colspan="2" class="font9" align="center"><%=info%></td>
          </tr>
        </table>
    </td>
  </tr>
</table>
</body>
</html>

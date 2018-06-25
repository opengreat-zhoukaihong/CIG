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
String title=request.getParameter("title").trim();
String info=request.getParameter("info").trim();
%>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" -->
      <table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr align="center"> 
          <td height="60"> 
            <p><font color="#666666" class="bigtxt"></font></p>
            <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
              <tr align="center" bgcolor="#CFC8CF"> 
                <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
              </tr>
              <tr align="center"> 
                <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b><%=title%></b></font></span></td>
              </tr>
              <tr align="center"> 
                <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr align="center"> 
          <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp; 
            <table width="440" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04">
              <tr> 
                <td> &nbsp;&nbsp; 
                  <div align="center"><%=info%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
                  </div>
                </td>
              </tr>
            </table>
            <font color="#666666"> </font> </td>
        </tr>
      </table>
      <!-- #EndEditable --></td>
  </tr>
  <tr align="center"> 
          <td class="txt"><br><a href="javascript:window.history.go(-1)">返回</a></td>
  </tr>
<tr>  
<td>
&nbsp;
</td>
</tr>
</table>
</body>
<!-- #EndTemplate --></html>

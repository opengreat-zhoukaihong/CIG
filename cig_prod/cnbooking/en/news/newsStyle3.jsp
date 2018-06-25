<html>
<!-- #BeginTemplate "/Templates/main_gb.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" -->
<title>Specialist of hotelbooking in Mainland China, Hong Kong and Macao</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
 input {font-family: "Verdana"; font-size: 12px ;color:#666666}
 select {font-family: "Verdana"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: Verdana}
 A:visited {text-decoration: none; color: #715922; font-family: Verdana}
 A:active {text-decoration: none; font-family: Verdana}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "Verdana", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "Verdana"; font-size: 12px}
-->
</style>
</head>

<jsp:useBean id="News" scope="page" class="com.cnbooking.news.News" />
<jsp:setProperty name="News" property="news_id" />
<jsp:setProperty name="News" property="lang_code" value="EN"/>

<% News.fetchNews(); %>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<table width="663" border="0" cellspacing="0" cellpadding="0" height="60" align="center">
  <tr> 
    <td colspan="2" height="60">
      <script language="JavaScript" src="/javascript/en/title.js">
      </script>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/gb/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;Relative News Report</font><!-- #EndEditable --></td>
          <td width="415" background="/images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="/images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" -->
      <table cellspacing=0 cellpadding=0 width=480 border=0 align="center">
        <tbody> 
        <tr align=middle> 
          <td>&nbsp; </td>
        </tr>
        <tr align=middle> 
          <td> 
            <table cellspacing=0 cellpadding=0 width=400 align=center bgcolor=#ffbc04 border=0>
              <tbody> 
              <tr align=middle bgcolor=#cfc8cf> 
                <td height=3><img height=3 src="/images/space.gif" width=1></td>
              </tr>
              <tr align=middle> 
                <td> 
                  <div align="center">
                  <font class=bigtxt color=#666666>
                  <b><%=News.getNewsTitle()%></b>
                  </font>
                  </div>
                </td>
              </tr>
              <tr align=middle> 
                <td bgcolor=#cfc8cf height=3><img height=3 src="/images/space.gif" width=1></td>
              </tr>
              </tbody> 
            </table>
            <br>
          </td>
        </tr>
        <tr valign=top align=middle> 
          <td class=txt>&nbsp;&nbsp;&nbsp;&nbsp; 
            <table bordercolor=#ffbc04 cellspacing=0 cellpadding=10 width=480 
            border=1>
              <tbody> 
              <tr> 
                <td><font color="#666666"><%=News.getNewsDetail()%></font><br>
                  <br>
                  <table width="142" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr> 
                      <td><img src="<%=News.getNewsPicPath()%>" width="300" height="320" align="middle"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              </tbody> 
            </table>
            <div align=right><font color=#666666><a 
            href="javascript:window.history.go(-1)">Back</a> </font></div>
          </td>
        </tr>
        </tbody> 
      </table>
      <!-- #EndEditable --></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <%@ include file="../foot_tel.jsp"%> 
    <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="/javascript/en/foot.js">
  </script>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>
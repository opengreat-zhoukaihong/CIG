<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>中港澳酒店訂房專家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "細明體"; font-size: 12px ;color:#666666}
 select {font-family: "細明體"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 細明體}
 A:visited {text-decoration: none; color: #715922; font-family: 細明體}
 A:active {text-decoration: none; font-family: 細明體}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "細明體", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "細明體"; font-size: 12px}
-->
</style>
</head>

<jsp:useBean id="News" scope="page" class="com.cnbooking.news.News" />
<jsp:setProperty name="News" property="news_id" />
<jsp:setProperty name="News" property="lang_code" value="GB"/>

<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" /> 

<% News.fetchNews(); %>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<table width="663" border="0" cellspacing="0" cellpadding="0" height="60" align="center">
  <tr> 
    <td colspan="2" height="60">
      <script language="JavaScript" src="/javascript/big/title.js">
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
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;商旅新聞</font><!-- #EndEditable --></td>
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
      <table width="550" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr align="center"> 
          <td><br>
            <table width=250 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
              <tr align="center" bgcolor="#CFC8CF"> 
                <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
              </tr>
              <tr align="center"> 
                <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b><%=Convert.g2b(News.getNewsTitle())%></b></font></span></td>
              </tr>
              <tr align="center"> 
                <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
              </tr>
            </table> 
          </td>
        </tr>
        <tr align="center"> 
          <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp; 
            <table width="550" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04">
              <tr> 
                <td><img src="<%=News.getNewsPicPath()%>" width="300" height="257" align="left">
                  <p><%=Convert.g2b(News.getNewsDetail())%></p>
                </td>
              </tr>
            </table>
            <p align="right"><a href="javascript:window.history.go(-1)">返回</a></p>
          </td>
        </tr>
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
  <script language="JavaScript" src="/javascript/big/foot.js">
  </script>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

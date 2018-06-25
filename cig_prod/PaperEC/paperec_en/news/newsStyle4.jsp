<jsp:useBean id="News" scope="page" class="news.News" />
<jsp:setProperty name="News" property="news_id" />
<jsp:setProperty name="News" property="lang_code" value="EN"/>

<% News.fetchNews(); %>

<html>
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--

var onTop = false
function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}

// -->
</script>
<style type="text/css">
<!--
.white {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none}
a:visited {  text-decoration: none}
a:active {  text-decoration: none}
a:hover {  text-decoration: underline}
td {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 10pt}
.black {  font-family: "Arial", "Helvetica", "sans-serif"; color: #000000}
.algin {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 11pt; text-align: justify; line-height: 15pt}
.b9 {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 10pt}
.textfield {  border-color: #4078E0 #FFFFFF; border: 1px solid; font-family: "Arial", "Helvetica", "sans-serif"}
.yellow {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 10pt; color: #FF9900}
.title {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14pt; font-weight: bold}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="159" height="394"> 
      <script language="JavaScript" src="../../../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:94px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="53"> 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr bgcolor="#4078E0" align="center"> 
                  <td width="139" height="22"><a href="new_index.jsp" class="white">Classified News</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="22" width="139"><a href="aboutus_gongsyaow.jsp" class="white">Press Room</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="22" width="139"><a href="#" class="white">Forum</a></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../../../images/images_en/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div>
    </td>
    <td colspan="2" valign="top" height="394">
      <table width="600" border="0" cellspacing="0" cellpadding="4">
        <tr align="left"> 
          <td class="title">
            <%= News.getNewsTitle() %>
          </td>
        </tr>
        <tr align="left"> 
          <td><%= News.getNewsPublishDate() %><br></td>
        </tr>
        <tr> 
          <td class="algin">
            <%= News.getNewsDetail() %>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../../../images/images_en/dline.gif" width="776" height="6"></td>
  </tr>
  <tr align="center"> 
    <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
      2000 PaperEC.com Inc. All Rights Reserved</font></td>
  </tr>
  <tr align="center"> 
    <td><a href="mailto:info@paperec.com"><img src="../../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
  </tr>
</table>
</body>
</html>

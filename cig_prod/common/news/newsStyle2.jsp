<html>
<head>
<title>NEWS</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="cig.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#" link="#" vlink="#" alink="#" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<jsp:useBean id="News" scope="page" class="com.cig.news.News" />
<jsp:setProperty name="News" property="dbpoolName" value="paperec"/>
<jsp:setProperty name="News" property="news_id" />
<jsp:setProperty name="News" property="lang_code" value="GB"/>

<% News.fetchNews(); %>

<table width="80%" border="0" cellspacing="6" cellpadding="0" name="newstitle" align="center">
  <tr align="center"> 
    <td><a href="#"><img src="../../images/space.gif" width="100" height="70" border="1" name="logo" alt="LOGO" vspace="10"></a></td>
    <td><a href="#"><img src="../../images/space.gif" width="486" height="60" border="1" name="adbanner" alt="adBANNER"></a></td>
  </tr>
  <tr align="center" bgcolor="#6699CC"> 
    <td colspan="2" height="2"><img src="../../images/space.gif" width="1" height="1"></td>
  </tr>
</table>


<table width="80%" border="0" cellspacing="0" cellpadding="6" align="center">
  <tr> 
    <td class="font5b" align="center" height="36">
      <%= News.getNewsTitle() %><br>
      <span class="font2"><%= News.getNewsSubTitle() %></span></td>
  </tr>
  <tr> 
    <td class="font2">
      <p align="center">
      <table width="30%" border="0" cellspacing="6" cellpadding="0" align="center">
        <tr align="center"> 
          <td><a href="#"><img src="<%= News.getNewsPicPath() %>" width="559" height="118" border="1" name="logo" alt="LOGO" vspace="10"></a></td>
        </tr>
        <tr align="center"> 
          <td><%= News.getNewsPicTitle() %></td>
        </tr>
      </table>
      <p> <img src="../../images/space.gif" width="24" height="1"><%= News.getNewsDetail() %>
      </p>
    </td>
  </tr>
</table>

<table width="80%" border="0" cellspacing="6" cellpadding="0" name="newsfoot" align="center">
  <tr align="center"><td  height="2" bgcolor="#6699CC"><img src="../../images/space.gif" width="1" height="1"></td>
    </tr>
  <tr align="center" >
    <td><a href="#"><img src="../../images/space.gif" width="50" height="30" border="1" name="smalllogo" alt="smallLOGO"><br>
      Copyright</a> 2000 CIG, Inc. All rights reserved.<br>
      <a href="#">Privacy Policy</a> <a href="#">Legal Disclosures</a> <a href="#">Security</a> 
    </td>
  </tr>
</table>
</body>
</html>

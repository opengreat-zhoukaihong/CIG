<html>
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
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" /> 
<%  if (UserInfo.getUsername().equals("")){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%}
String question=request.getParameter("question").trim();
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language="JavaScript" src="/javascript/en/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr> 
    <td width="664" height="34"> 
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr> 
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/en/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;Get Password</font><!-- #EndEditable --></td>
          <td width="415" background="/images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="/images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<script language="JavaScript">
<!--
function PostForm()
{ 
 if(document.get_pw.question.value.length ==0 ){
	  alert(" Please enter your answer !\n");
          document.get_pw.question.focus();
          return;
 }
	document.get_pw.submit();
}
//-->
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> 
      <form method="post" name="get_pw" action="get_passwd_ok.jsp">
        <table width="440" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr align="center"> 
            <td height="60"> 
              <p><font color="#666666" class="bigtxt"></font></p>
              <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b>Get Passeword</b></font></span></td>
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
                    <table width="333" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr> 
                        <td height="28" width="55">UserName: </td>
                        <td height="28"><%=UserInfo.getUsername()%></td>
                      </tr>
                      <tr> 
                        <td height="28" width="55">Question: </td>
                        <td height="28"><%=question%></td>
                      </tr>
                      <tr> 
                        <td height="28" width="55">Answer: </td>
                        <td height="28"> 
                          <input type="text" name="question" size="30" maxlength="200">
                        </td>
                      </tr>
                      <tr> 
                        <td height="28" colspan="2"> 
                          <div align="center"><a href="javascript:PostForm()">Answer</a></div>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <font color="#666666"> </font> </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
<%@ include file="foot_tel.jsp"%>  
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="/javascript/en/foot.js">
</script>
</table>
</body>
<!-- #EndTemplate --></html>
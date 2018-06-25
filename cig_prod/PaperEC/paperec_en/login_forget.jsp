<html>
<head>
<title>厘議崕利--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<style type="text/css">
<!--
.font10 {  font-size: 11px; line-height: 14pt; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.font9 {  font-size: 13px; font-family: "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 12px; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  text-decoration: none}
a:visited {  text-decoration: none}
a:active {  text-decoration: none}
a:hover {  color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; font-family: "Arial", "Helvetica", "sans-serif"}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 13px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
.balck14 {  font-size: 12px; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
-->
</style>
</style>
</head>
<%@ page import="java.util.*" %>
<%@ page import="mypaperec.*" %>
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<jsp:setProperty name="UserInfo" property="username" />
<jsp:setProperty name="UserInfo" property="answerInput"/>

<%
   String question = UserInfo.getQuestion();
   if (question.equals("")){
%>
	<jsp:forward page="notRegister.jsp" />
	</jsp:forward>
<% }
%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="159" height="365"> 
      <script language="JavaScript" src="../../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:141px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="141" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="142" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000" align="center">
                <tr align="center"> 
                  <td width="139" height="22" bgcolor="#503CC0"><b><font color="#FFFFFF" size="2" face="Verdana, Arial, Helvetica, sans-serif">Registration</font></b></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25"><a href="bbs/BBSListlogin.jsp?area_ID=3" class="dan10">Equipment</a></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25" ><a href="bbs/BBS_Manlogin.jsp?area_ID=4" class="dan10">Jobs</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0" ><a href="memberagreetment.htm" class="white10">Membership 
                    Agreement</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../../html/html_en/aboutus/aboutus_bomianq.htm" class="white10">Privacy 
                    Policy</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../../html/html_en/aboutus/aboutus_banquan.htm" class="white10">Copyright</a></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../../images/images_en/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div>
    </td>
    <td valign="top" height="365"> 
      <form name="inputForm" method="post" action="mypaperec.jsp">
        <table width="494" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF" align="center"> 
            <td height="259"> 
              <table width="500" border="0" cellspacing="0" cellpadding="0">
                <tr bgcolor="#4078E0"> 
                  <td height="25">&nbsp;</td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td height="237"> 
                    <table width="450" border="0" cellspacing="2" cellpadding="2" align="center">
                      <tr> 
                        <td class="dan10" colspan="2" height="22" align="center">Please answer the question:</td>
                      </tr>
                      <tr> 
                        <td class="dan10" width="167" align="right" height="22">Question</td>
                        <td width="219" class="dan10" height="22" align="left"> 
                          <font color="#CC3300"><%=question%>?</font></td>
                      </tr>
                      <tr> 
                        <td width="167" class="dan10" align="right" height="22">Answer</td>
                        <td width="219" class="dan10" height="22" align="left"> 
                          <input type="text" name="answerInput">
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="2" align="center" class="dan10" height="22"> 
                          <input type="submit" name="Submit" value="Submit">
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="2" height="134" class="dan10"> <span class="font10"> 
                          After submitting the answer correctly, you may enter 
                          "My PaperEC" to change your password in the "My PersonalProfile" 
                          section. If you forgot the correct answer, please <a href="mailto:info@paperec.com">contact 
                          us</a>, or call +86-755-369-1610��or fax +86-755-320-1877 
                          . <br>
                          For more information about PaperEC.com,please see　<a href="../../html/html_en/aboutus/aboutus.htm">About 
                          Us</a>。 　　　　　　 </span></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../images/images_en/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

<%@ page import="java.util.*, java.net.*" %> 
<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>ƨ�A�D�s�z�q�s�M�a</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "��@�y"; font-size: 12px ;color:#666666}
 select {font-family: "��@�y"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: ��@�y}
 A:visited {text-decoration: none; color: #715922; font-family: ��@�y}
 A:active {text-decoration: none; font-family: ��@�y}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "��@�y", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "��@�y"; font-size: 12px}
-->
</style>
</head>
<%
String question=request.getParameter("question").trim();
%>
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" />
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" /> 
<% 
 UserInfo.setAnswerInput(Convert.b2g(question));
 if (!UserInfo.login_question()){
%>
	<jsp:forward page="failed.jsp?info=�藍�_�A�Τ�^��������!&title=���^�K�X" />
	</jsp:forward>
<%
}
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language="JavaScript" src="/javascript/big/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr> 
    <td width="664" height="34"> 
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr> 
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/big/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;���^�K�X</font><!-- #EndEditable --></td>
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
 if(document.changForm.passwd.value.length ==0 ){
	  alert("�п�J�K�X !\n");
          document.changForm.passwd.focus();
          return;
 }
 if(document.changForm.passwd1.value.length ==0 ){
	  alert("�п�J�K�X !\n");
          document.changForm.passwd1.focus();
          return;
 }
 if(document.changForm.passwd.value!= document.changForm.passwd1.value){
	  alert("�K�X���P,���̻{�K�X !\n");
          document.changForm.passwd.focus();
          return;
 }
	document.changForm.submit();
}
//-->
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> 
      <form method="post" name="changForm" action="changPWD.jsp">
        <table width="440" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr align="center"> 
            <td height="60"> 
              <p><font color="#666666" class="bigtxt"></font></p>
              <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b>�ק�K�X</b></font></span></td>
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
                        <td height="28" colspan="2">�п�J�s�K�X�A�}���`�@���̻{�C</td>
                      </tr>
                      <tr> 
                        <td height="28" width="55">�K�X�G</td>
                        <td height="28">
                          <input type="password" name="passwd" size="12" maxlength="24">
                        </td>
                      </tr>
                      <tr> 
                        <td height="28" width="55">�K�X�G</td>
                        <td height="28">
                          <input type="password" name="passwd1" size="12" maxlength="24">
                        </td>
                      </tr>
                      <tr> 
                        <td height="28" colspan="2"> 
                          <div align="center"> 
                            <p><a href="javascript:PostForm()"><img src="/images/big/modify_data.gif" width="138" height="18" border="0"></a></p>
                          </div>
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
  <script language="JavaScript" src="/javascript/big/foot.js">
</script>
</table>
</body>
<!-- #EndTemplate --></html>

<html>
<head>
<title>�ҵ�ֽ��--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px; font-family: "����"}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; font-family: "����"; color: #000000}
.big {  font-family: "����"; font-size: 14px}
-->
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
      <script language="JavaScript" src="../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:141px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="141" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="142" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000" align="center">
                <tr align="center"> 
                  <td width="139" height="22" bgcolor="#503CC0"><font color="#FFFFFF" class="big">��¼ע��</font></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25"><a href="equip/EquipLogin.jsp" class="dan10">רҵ�豸</a></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25" ><a href="bbs/BBS_Manlogin.jsp?area_ID=2" class="dan10">��������</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0" ><a href="memberagreetment.htm" class="white10">��ԱЭ��</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../html/aboutus/aboutus_bomianq.htm" class="white10">��ȫ����</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../html/aboutus/aboutus_banquan.htm" class="white10">�桡��Ȩ</a></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../images/leftback.gif" width="141" height="27" border="0"></a></td>
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
                        <td class="dan10" colspan="2" height="22" align="center">��ش����⣺</td>
                      </tr>
                      <tr> 
                        <td class="dan10" width="167" align="right" height="22">���⣺</td>
                        <td width="219" class="dan10" height="22" align="left"> 
                          <font color="#CC3300"><%=question%>?</font></td>
                      </tr>
                      <tr> 
                        <td width="167" class="dan10" align="right" height="22">�𰸣�</td>
                        <td width="219" class="dan10" height="22" align="left"> 
                          <input type="text" name="answerInput">
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="2" align="center" class="dan10" height="22"> 
                          <input type="submit" name="Submit" value="ȷ��">
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="2" height="134"> <span class="font10"> ��ȷ�ش�������֮�󣬵��ȷ������������"�ҵ�ֽ��"��Ŀ�е�"�������Ϲ���"�����޸��������룻���������������Ĵ𰸣��뼰ʱ<a href="mailto:info@paperec.com">��ϵ����</a> 
                          �����µ磨Tel.��:0086-755-3691610������(Fax)��0086-755-3201877 
                          <br>
                          ���һ���˽��й�ֽ��������<a href="aboutus/aboutus.htm">���ڱ�վ</a>�� 
                          ������������ </span></td>
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
          <td><img src="../images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
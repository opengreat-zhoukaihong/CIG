<%@page language="java" %>
<jsp:useBean id="hp" scope="page" class="mypaperec.HandPick" />
<%
    hp.setLang_code("GB");
    String[][] pick=hp.getPick();
%>

<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px; font-family: "宋体"}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; font-family: "宋体"; color: #000000}
.big {  font-family: "宋体"; font-size: 14px}
-->
</style>
</head>

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
            <td height="166"> 
              <table width="142" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000" align="center">
                <tr align="center"> 
                  <td width="139" height="22" bgcolor="#503CC0"><font color="#FFFFFF" class="big">每周精选</font></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="25"><a href="#a" class="white10">公司背景</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="25" ><a href="#b" class="white10">公司规模</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="25" ><a href="#c" class="white10">产品技术</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="25"><a href="#tt" class="white10">客户服务</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="#bb" class="white10">公司荣誉</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="#qq" class="white10">远景目标</a></td>
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
      <table width="550" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCFF" bordercolorlight="#FFFFFF">
        <tr bordercolor="#FFFFFF"> 
          <td> 
            <table width="550" border="0" cellspacing="2" cellpadding="4">
              <tr bgcolor="#4078E0" align="center" class="white10"> 
                <td><b>公司名</b></td>
                <td><b>刊登时间</b></td>
              </tr>
           <% for(int i=0;i<pick.length;i++){  %>   
              <tr bgcolor="#B3C8F1" align="center"> 
                <td>&nbsp; <a href="meiyuejx.jsp?pick_id=<%=pick[i][2]%>"><%=pick[i][0]%> </a></td>
                <td>&nbsp; <%=pick[i][1]%> </td>
              </tr>
          <%    }   %>   
            </table>
          </td>
        </tr>
      </table>
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
<%  hp.getDestroy();  %>
</jsp:useBean>
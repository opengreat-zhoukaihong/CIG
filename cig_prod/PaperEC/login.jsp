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

<SCRIPT LANGUAGE="Javascript">
        
    function makeHref(e){  
        var mf=document.inputForm;
        var userName = mf.username.value;
        
        if (userName == ''){
        	alert("请输入您的用户名!");
        	mf.username.focus();
        	return false;
        }else{
      		e.href = "login_forget.jsp?username=" + userName;
	        return true;             
	}
     }
     

</SCRIPT>

<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<jsp:setProperty name="UserInfo" property="username" />
<jsp:setProperty name="UserInfo" property="password" />
<jsp:setProperty name="UserInfo" property="answerInput"/>

<%
    String answer = request.getParameter("answerInput");
    
    if (answer.equals("")){
         UserInfo.login();
    }else{
         UserInfo.login_forget();
    }


    if (UserInfo.getAuthorized()){
%>
	<jsp:forward page="mypaperec.jsp" />
	</jsp:forward>
<%    }
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
                  <td width="139" height="22" bgcolor="#503CC0"><font color="#FFFFFF" class="big">登录注册</font></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25"><a href="equip/EquipLogin.jsp" class="dan10">专业设备</a></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25" ><a href="bbs/BBS_Manlogin.jsp?area_ID=2" class="dan10">工作机会</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0" ><a href="memberagreetment.htm" class="white10">会员协议</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../html/aboutus/aboutus_bomianq.htm" class="white10">安全保密</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../html/aboutus/aboutus_banquan.htm" class="white10">版　　权</a></td>
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
      <form name="inputForm" method="post" action="mypaperec.jsp?answerInput=">
        <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF" align="center"> 
            <td height="172"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr bgcolor="#4078E0"> 
                  <td height="25">&nbsp;
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td> 
                    <table border="0" cellpadding="0" cellspacing="2" width="550" align="center">
                      <tr> 
                        <td> 
                          <table  align="center" border="0"  cellpadding="0" cellspacing="0" width="550">
                            <tr  > 
                              <th class="dan10" width="180" align="center">我是会员</th>
                              <th class="dan10"align="center" width="400">我不是会员</th>
                            </tr>
                            <tr> 
                              <td height="180" valign="center" width="180"> 
                                <table border="0" align="center" width="180" cellpadding="0" cellspacing="0">
                                  <input type="HIDDEN" name="pageName" value="/members/mypex/">
                                  <tr> 
                                    <td height="36" valign="top" align="center" colspan="2" class="dan10"> 
                                      用户名： 
                                      <input type="text" name="username" accesskey="p" size="15" >
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td height="36" valign="top" align="center" colspan="2" class="dan10"> 
                                      密　码： 
                                      <input type="password" name="password" accesskey="a" size="15" >
                                    </td>
                                  </tr>
                                  <tr class="dan10"> 
                                    <td height="36"   align="right"> 
                                      <input type="submit" value="登录"   style="width:65px" name="submit">
                                    </td>
                                    <td> 
                                      <input type="button" value="取消"   style="width:65px" onClick="javascript:document.inputForm.reset()" name="button">
                                    </td>
                                  </tr>
                                  <tr > 
                                    <td  height="40" align="center"  valign="bottom" width="250" colspan="2"><a href="#" onClick="return makeHref(this)" class="dan10">忘记密码？</a></td>
                                  </tr>
                                  <tr  > 
                                    <td  height="20"  align="center"  valign="bottom" width="250" colspan="2">&nbsp;</td>
                                  </tr>
                                </table>
                              </td>
                              <td height="180" > 
                                <table align="center" border="0" width="200" >
                                  <tr > 
                                    <td align="center" valign="center" height="60"><a href="../html/aboutus/aboutus.htm" class="dan10">进一步了解中国纸网</a></td>
                                  </tr>
                                  <tr > 
                                    <td align="center" valign="center" height="60"><a href="registerInfo.htm" class="dan10">马上注册</a></td>
                                  </tr>
                                  <tr > 
                                    <td align="center" height="60">&nbsp;</td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <table  align="center" border="0"  cellpadding="0" cellspacing="0" width="550" height="100">
                      <tr > 
                        <td align="center" colspan="2" class="dan10" >如果您有什么任何不明之处，请及时<a href="mailto:info@paperec.com">联系我们</a>。
                        
                        </td>
                      </tr>
                      <tr> 
                        <td align ="center" colspan ="2" valign ="center" class="dan10">或致电(Tel.)：<b>0086-755-3691610</b>，传真(Fax)：0086-755-3201877</td>
                      </tr>
                      <tr> 
                        <td align ="center" colspan ="2" valign ="center" class="dan10">想进一步了解本站，请点击<a href="aboutus/aboutus.htm">关于本站 
                          </a> </td>
                      </tr>
                    </table>
                 
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

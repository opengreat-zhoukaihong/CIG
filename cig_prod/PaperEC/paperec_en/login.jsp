<html>
<head>
<title>�ҵ�ֽ��--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
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
</head>

<SCRIPT LANGUAGE="Javascript">
        
    function makeHref(e){  
        var mf=document.inputForm;
        var userName = mf.username.value;
        
        if (userName == ''){
        	alert("Please input your user name!");
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
                              <th class="dan10" width="238" align="center">I am 
                                already a member</th>
                              <th class="dan10"align="center" width="312">I am 
                                not a member</th>
                            </tr>
                            <tr> 
                              <td height="180" valign="center" width="238"> 
                                <table border="0" align="center" width="231" cellpadding="0" cellspacing="0">
                                  <input type="HIDDEN" name="pageName" value="/members/mypex/">
                                  <tr> 
                                    <td height="36" valign="top" align="right" class="dan10"> 
                                      User Name </td>
                                    <td height="36" valign="top" class="dan10" align="center"> 
                                      <input type="text" name="username" accesskey="p" size="15" >
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td height="36" valign="top" align="right" class="dan10"> 
                                      Password </td>
                                    <td height="36" valign="top" class="dan10" align="center"> 
                                      <input type="password" name="password" accesskey="a" size="15" >
                                    </td>
                                  </tr>
                                  <tr class="dan10"> 
                                    <td height="36"   align="right" width="75"> 
                                      <input type="submit" value="Login"   style="width:65px" name="submit">
                                    </td>
                                    <td width="156"> 
                                      <input type="button" value="Cancel"   style="width:65px" onClick="javascript:document.inputForm.reset()" name="button">
                                    </td>
                                  </tr>
                                  <tr > 
                                    <td  height="40" align="center"  valign="bottom" colspan="2"><a href="#" onClick="return makeHref(this)" class="dan10">Forgot 
                                      your password?</a></td>
                                  </tr>
                                  <tr  > 
                                    <td  height="20"  align="center"  valign="bottom" colspan="2">&nbsp;</td>
                                  </tr>
                                </table>
                              </td>
                              <td height="180" width="312" > 
                                <table align="center" border="0" width="236" >
                                  <tr > 
                                    <td align="center" valign="center" height="60"><a href="../../html/html_en/aboutus/aboutus.htm" class="dan10">Learn 
                                      more about PaperEC.com</a></td>
                                  </tr>
                                  <tr > 
                                    <td align="center" valign="center" height="60"><a href="registerInfo.htm" class="dan10">Register now!</a></td>
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
                        <td align="center" colspan="2" class="dan10" >If you have any questions,please do not hesitate to <a href="mailto:info@paperec.com">contact us</a>,
                        </td>
                      </tr>
                      <tr> 
                        <td align ="center" colspan ="2" valign ="center" class="dan10">or 
                          call <b>+86-755-369-1610</b>��or fax <b>+86-755-320-1877</b></td>
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

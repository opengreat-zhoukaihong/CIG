<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>い翠澳酒┌訂┬專家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "燦　砰"; font-size: 12px ;color:#666666}
 select {font-family: "燦　砰"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 燦　砰}
 A:visited {text-decoration: none; color: #715922; font-family: 燦　砰}
 A:active {text-decoration: none; font-family: 燦　砰}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "燦　砰", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "燦　砰"; font-size: 12px}
-->
</style>
</head>
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" />
<script languange="javascript">
<!-- Hide from old browsers

function validEmail(email)
{
	invalidChars = " /:,;"
	
	if(email == "")		// can't be empty
	{
		return false
	}

	for(i=0; i<invalidChars.length; i++)	// does not have invalid chars
	{
		badChar = invalidChars.charAt(i)
		if(email.indexOf(badChar, 0) > -1)
		{
			return false
		}
	}

	atPos = email.indexOf("@", 1)	// there must be a "@"
	if(atPos == -1)
	{
		return false
	}

	if(email.indexOf("@", atPos+1) != -1)	// should have only 1 @
	{
		return false
	}

	periodPos = email.indexOf(".", atPos)	// at least 1 "." after @
	if(periodPos == -1)
	{
		return false
	}

	if((periodPos + 3) > email.length)	// must be at least 2 ch after "."
	{
		return false
	}

	// more checks go here

	return true
}


function submitIt(form)
{
	if(form.login_name.value == "")
	{
		alert("您必須填入用戶名！")
		return false
	}

	if(form.password.value == "")
	{
		alert("您必須填入密碼！")
		return false
	}

	if(form.password.value != form.verifypassword.value)
	{
		alert("您填入的兩個密碼不一致！")
		return false
	}

	if(!validEmail(form.email.value))
	{
		alert("無效Email地址！")
		form.email.focus();
		form.email.select();
		return false
	}

	if(form.phone.value == "")
	{
		alert("您必須填入電話號碼！")
		return false
	}
 
//	if(form.address.value == "")
//	{
//		alert("您必須填入地址！")
//		return false
//	}
        
	if(form.name.value == "")
	{
		alert("您必須填入姓名！")
		return false
    }

	if(form.city.value == "")
	{
		alert("您必須填入城市！")
		return false
	}
	///form.state_id.value=form.state.options[form.city.selectedIndex].value;

	return true
}

// end hiding script -->
</script>
<jsp:useBean id="RegistInfo" scope="page" class="com.cnbooking.RegistInfo" /> 
<%
RegistInfo.setLangCode("GB");
if(RegistInfo.getRegistInfo()){;}
int cityCount=0;
int countryCount=0;
String[][] cityList;
String[][] countryList;
cityCount=RegistInfo.getCityCount();
cityList=RegistInfo.getCityList();
countryCount=RegistInfo.getCountryCount();
countryList=RegistInfo.getCountryList();
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
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;注冊會員</font><!-- #EndEditable --></td>
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
<script language="JavaScript">
function PostForm()
{
 if(submitIt(RegForm) == true)
	RegForm.submit();
}
</script>
      <form name="RegForm" onSubmit="return submitIt(this)" action="/cnbooking/big/CRegistration.jsp" method="POST">
        <br>
        <table width=300 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
          <tr align="center" bgcolor="#CFC8CF"> 
            <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
          </tr>
          <tr align="center" valign="middle"> 
            <td><b><font color="#666666" class="bigtxt">中港澳酒店訂房專家會員注冊</font></b></td>
          </tr>
          <tr align="center"> 
            <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
          </tr>
        </table>
        <p align="center"><font color="#6C6D6D">標有&quot;</font><font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font><font color="#6C6D6D">&quot;號的欄目是必填項 
          </font></p>
        <table width="510" border="1" bordercolor="#FFBC04" cellpadding="0" cellspacing="0" align="center">
          <tr align="center"> 
            <td> <br>
              <table width="484" border="0" cellspacing="4" cellpadding="4">
                <tr> 
                  <td valign="top" rowspan="5" align="center" width="1">&nbsp; </td>
                  <td valign="top" width="75" align="center"> 
                    <table width="75" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF">
                      <tr align="center"> 
                        <td><font color="#000000">用 戶 名</font></td>
                      </tr>
                    </table>
                  </td>
                  <input type=hidden name="state_id" <%if(cityList[0][2]!=null){%> value="<%=Convert.g2b(cityList[0][2])%>" <%}%> >
                  <td width="363" class="txt"> 
                    <p> 
                      <input type="text" name="login_name" size=16>
                      <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font>請輸入一個用戶名，用于登錄CNhotelbooking的各种服務,用戶名由英文字母和數字組成<br>
                      (至少4個字符, 首位必須是字符)。</p>
                  </td>
                  <td rowspan="5" class="txt" width="6">&nbsp;</td>
                </tr>
                <tr> 
                  <td valign="top" rowspan="2" width="75" align="center"> 
                    <table width="75" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF">
                      <tr align="center"> 
                        <td><font color="#000000">密&nbsp;&nbsp;&nbsp;&nbsp;碼</font> 
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td height="32" width="363">請輸入一個密碼(由數字和英文字母組成，至少6位，注意大小寫)<br>
                    <input type="password" name="password" value="" size="16" maxlength="16">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font>密碼 
                    <br>
                    <input type="password" name="verifypassword" value="" size="16" maxlength="16">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font> 
                    再次輸入密碼确認<br>
                  </td>
                </tr>
                <tr> 
                  <td height="32" width="363"> 
                    <input type="text" name="rem_question" value="" size="20" maxlength="20">
                    ： 提 示 問 題 <br>
                    <input type="text" name="rem_answer" value="" size="20" maxlength="20">
                    ： 提示問題答案<br>
                    &nbsp;&nbsp;&nbsp;* 万一忘記密碼的補救措施(可選) </td>
                </tr>
                <tr> 
                  <td valign="top" width="75" align="center"> 
                    <table width="75" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF">
                      <tr align="center"> 
                        <td><font color="#000000">個人信息</font></td>
                      </tr>
                    </table>
                  </td>
                  <td align=left height="18" width="363"> 姓&nbsp;&nbsp;&nbsp;&nbsp;名 
                    <input name="name" size="10" maxlength="20" value="">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font> 
                    &nbsp;&nbsp;&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;別 
                    <select name="gender" >
                      <option value="M" selected>先生</option>
                      <option value="F">女士</option>
                    </select>
                    <br>
                    城&nbsp;&nbsp;&nbsp;&nbsp;市 
                    <select name="city" onchange="document.RegForm.state_id.value=document.RegForm.state.options[document.RegForm.city.selectedIndex].value;">
                    <%for(int i=0;i<cityCount;i++){%>
                      <option value="<%=Convert.g2b(cityList[i][1])%>"><%=Convert.g2b(cityList[i][1])%></option>
                      <%}%>
                      <option value="其他">其他</option>
                    </select>
                    <div id="stateid" style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
                    <select name="state">
                    <%for(int i=0;i<cityCount;i++){%>
                      <option value="<%=Convert.g2b(cityList[i][2])%>"><%=Convert.g2b(cityList[i][2])%></option>
                      <%}%>
                      <option value="0">其他</option>
                    </select>
                    </div>
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font> 
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"> 
                    &nbsp;</font>&nbsp;郵&nbsp;&nbsp;&nbsp;&nbsp;編 
                    <input name="postcode" value="" size="6" maxlength="10">
                    <br>
                    通訊地址 
                    <input name="address" value="" size="30" maxlength="100">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"> 
                    </font><br>
                    電子郵件 
                    <input name="email" value="" size="30" maxlength="100">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font><br>
                    *請注意要填寫正确地址，否則确認號碼無法發送！<br>
                    <br>
                    <table width="330" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td colspan="2" valign="top">電&nbsp;&nbsp;&nbsp;&nbsp;話 
                          <input type="text" name="phone0" size="5">
                          （國家代碼） 
                          <input type="text" name="phone1" size="5">
                          （地區代碼）<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          <input type="text" name="phone" size="15">
                          <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font>(格式：0086-755-2208051)</td>
                      </tr>
                      <tr> 
                        <td colspan="2" valign="top">傳&nbsp;&nbsp;&nbsp;&nbsp;真 
                          <input type="text" name="fax0" size="5">
                          （國家代碼） 
                          <input type="text" name="fax1" size="5">
                          （地區代碼）<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          <input type="text" name="fax" size="15">
                          (格式：0086-755-2208051)</td>
                      </tr>
                    </table>
                    <br>
                    手&nbsp;&nbsp;&nbsp;&nbsp;机
                    <input name="mobile" value="" size="15" maxlength="100">
                    <br>
                    國家地區 
                    <select name="country">
                    <%for(int i=0;i<countryCount;i++){%>
                    <option value="<%=Convert.g2b(countryList[i][0])%>" ><%=Convert.g2b(countryList[i][1])%></option>
                    <%}%>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td align="center" valign="bottom" width="75"> 
                    <table width="75" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF">
                      <tr align="center"> 
                        <td><font color="#000000">會員雜志</font></td>
                      </tr>
                    </table>
                  </td>
                  <td width="363">是否愿意訂閱我們的會員雜志： 
                    <input type="radio" value="Y" name="newsletter" checked>
                    是 
                    <input type="radio" value="N" name="newsletter">
                    否 </td>
                </tr>
              </table>
              <br>
              <br>
            </td>
          </tr>
        </table>
        <br>
        <table width="300" align="center">
          <tr align="center"> 
            <td>
              <input align=middle border=0 name=enter src="/images/big/sent.gif" type=image width="138" height="18">
            </td>
            <td><a href="/cnbooking/big/index.jsp"><img src="/images/big/cancel.gif" width="138" height="18" border="0"></a></td>
          </tr>
        </table>
        <p>&nbsp;</p>
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

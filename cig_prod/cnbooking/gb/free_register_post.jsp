<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>�и۰ľƵ궩��ר��</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
 input {font-family: "����"; font-size: 12px ;color:#666666}
 select {font-family: "����"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: ����}
 A:visited {text-decoration: none; color: #715922; font-family: ����}
 A:active {text-decoration: none; font-family: ����}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "����", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "����"; font-size: 12px}
-->
</style>
</head>
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
		alert("�����������û�����")
		return false
	}

	if(form.password.value == "")
	{
		alert("�������������룡")
		return false
	}

	if(form.password.value != form.verifypassword.value)
	{
		alert("��������������벻һ�£�")
		return false
	}

	if(!validEmail(form.email.value))
	{
		alert("��ЧEmail��ַ��")
		form.email.focus();
		form.email.select();
		return false
	}

	if(form.phone.value == "")
	{
		alert("����������绰���룡")
		return false
	}
 
//	if(form.address.value == "")
//	{
//		alert("�����������ַ��")
//		return false
//	}
        
	if(form.name.value == "")
	{
		alert("����������������")
		return false
    }

	if(form.city.value == "")
	{
		alert("������������У�")
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
<script language="JavaScript" src="/javascript/gb/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/gb/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;ע���Ա</font><!-- #EndEditable --></td>
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
      <form name="RegForm" onSubmit="return submitIt(this)" action="/cnbooking/gb/CRegistration.jsp" method="POST">
        <br>
        <table width=300 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
          <tr align="center" bgcolor="#CFC8CF"> 
            <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
          </tr>
          <tr align="center" valign="middle"> 
            <td><b><font color="#666666" class="bigtxt">�и۰ľƵ궩��ר�һ�Աע��</font></b></td>
          </tr>
          <tr align="center"> 
            <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
          </tr>
        </table>
        <p align="center"><font color="#6C6D6D">����&quot;</font><font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font><font color="#6C6D6D">&quot;�ŵ���Ŀ�Ǳ����� 
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
                        <td><font color="#000000">�� �� ��</font></td>
                      </tr>
                    </table>
                  </td>
                  <input type=hidden name="state_id" <%if(cityList[0][2]!=null){%> value="<%=cityList[0][2]%>" <%}%> >
                  <td width="363" class="txt"> 
                    <p> 
                      <input type="text" name="login_name" size=16>
                      <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font>������һ���û��������ڵ�¼CNhotelbooking�ĸ��ַ���,�û�����Ӣ����ĸ���������<br>
                      (����4���ַ�, ��λ�������ַ�)��</p>
                  </td>
                  <td rowspan="5" class="txt" width="6">&nbsp;</td>
                </tr>
                <tr> 
                  <td valign="top" rowspan="2" width="75" align="center"> 
                    <table width="75" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF">
                      <tr align="center"> 
                        <td><font color="#000000">��&nbsp;&nbsp;&nbsp;&nbsp;��</font> 
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td height="32" width="363">������һ������(�����ֺ�Ӣ����ĸ��ɣ�����6λ��ע���Сд)<br>
                    <input type="password" name="password" value="" size="16" maxlength="16">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font>���� 
                    <br>
                    <input type="password" name="verifypassword" value="" size="16" maxlength="16">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font> 
                    �ٴ���������ȷ��<br>
                  </td>
                </tr>
                <tr> 
                  <td height="32" width="363"> 
                    <input type="text" name="rem_question" value="" size="20" maxlength="20">
                    �� �� ʾ �� �� <br>
                    <input type="text" name="rem_answer" value="" size="20" maxlength="20">
                    �� ��ʾ�����<br>
                    &nbsp;&nbsp;&nbsp;* ��һ��������Ĳ��ȴ�ʩ(��ѡ) </td>
                </tr>
                <tr> 
                  <td valign="top" width="75" align="center"> 
                    <table width="75" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF">
                      <tr align="center"> 
                        <td><font color="#000000">������Ϣ</font></td>
                      </tr>
                    </table>
                  </td>
                  <td align=left height="18" width="363"> ��&nbsp;&nbsp;&nbsp;&nbsp;�� 
                    <input name="name" size="10" maxlength="20" value="">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font> 
                    &nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;�� 
                    <select name="gender" >
                      <option value="M" selected>����</option>
                      <option value="F">Ůʿ</option>
                    </select>
                    <br>
                    ��&nbsp;&nbsp;&nbsp;&nbsp;�� 
                    <select name="city" onchange="document.RegForm.state_id.value=document.RegForm.state.options[document.RegForm.city.selectedIndex].value;">
                    <%for(int i=0;i<cityCount;i++){%>
                      <option value="<%=cityList[i][1]%>"><%=cityList[i][1]%></option>
                      <%}%>
                      <option value="����">����</option>
                    </select>
                    <div id="stateid" style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
                    <select name="state">
                    <%for(int i=0;i<cityCount;i++){%>
                      <option value="<%=cityList[i][2]%>"><%=cityList[i][2]%></option>
                      <%}%>
                      <option value="0">����</option>
                    </select>
                    </div>
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font> 
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"> 
                    &nbsp;</font>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;�� 
                    <input name="postcode" value="" size="6" maxlength="10">
                    <br>
                    ͨѶ��ַ 
                    <input name="address" value="" size="30" maxlength="100">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"> 
                    </font><br>
                    �����ʼ� 
                    <input name="email" value="" size="30" maxlength="100">
                    <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font><br>
                    *��ע��Ҫ��д��ȷ��ַ������ȷ�Ϻ����޷����ͣ�<br>
                    <br>
                    <table width="330" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td colspan="2" valign="top">��&nbsp;&nbsp;&nbsp;&nbsp;�� 
                          <input type="text" name="phone0" size="5">
                          �����Ҵ��룩 
                          <input type="text" name="phone1" size="5">
                          ���������룩<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          <input type="text" name="phone" size="15">
                          <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"><font color="#FF0000">*</font></font>(��ʽ��0086-755-2208051)</td>
                      </tr>
                      <tr> 
                        <td colspan="2" valign="top">��&nbsp;&nbsp;&nbsp;&nbsp;�� 
                          <input type="text" name="fax0" size="5">
                          �����Ҵ��룩 
                          <input type="text" name="fax1" size="5">
                          ���������룩<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          <input type="text" name="fax" size="15">
                          (��ʽ��0086-755-2208051)</td>
                      </tr>
                    </table>
                    <br>
                    ��&nbsp;&nbsp;&nbsp;&nbsp;��
                    <input name="mobile" value="" size="15" maxlength="100">
                    <br>
                    ���ҵ��� 
                    <select name="country">
                    <%for(int i=0;i<countryCount;i++){%>
                    <option value="<%=countryList[i][0]%>" ><%=countryList[i][1]%></option>
                    <%}%>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td align="center" valign="bottom" width="75"> 
                    <table width="75" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF">
                      <tr align="center"> 
                        <td><font color="#000000">��Ա��־</font></td>
                      </tr>
                    </table>
                  </td>
                  <td width="363">�Ƿ�Ը�ⶩ�����ǵĻ�Ա��־�� 
                    <input type="radio" value="Y" name="newsletter" checked>
                    �� 
                    <input type="radio" value="N" name="newsletter">
                    �� </td>
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
              <input align=middle border=0 name=enter src="/images/gb/sent.gif" type=image width="138" height="18">
            </td>
            <td><a href="/cnbooking/gb/index.jsp"><img src="/images/gb/cancel.gif" width="138" height="18" border="0"></a></td>
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
  <script language="JavaScript" src="/javascript/gb/foot.js">
</script>
</table>
</body>
<!-- #EndTemplate --></html>

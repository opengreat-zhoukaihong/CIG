<%@ page language="java"%>

<jsp:useBean id="bs" scope="page" class="mypaperec.BecomeS" /> 
<%
   //String user_id=UserInfo.getUserId();
   String user_id=request.getParameter("user_id");
   bs.setUser_id(user_id);
   bs.setLang_code("GB");
   String[] data=bs.getAllData();
   String[][] empl=bs.getEmployees();
   String[][] reve=bs.getRevenue();
   String[][] iso=bs.getIso();
   String[][] sell=bs.getSellprodid();
   
   if (data[10].equals("S")){
        bs.getDestroy();  
%>
	<jsp:forward page="inform.jsp?info=�Բ���, ���Ѿ���������Ա!" />" />
	</jsp:forward>
<% 
   }
%>

<SCRIPT LANGUAGE="JavaScript"><!--
function validateForm(e){
    if(e.full_name.value==''){
	alert('��������ҵȫ�ƣ�Ȼ���ύ!')
	e.full_name.focus()
	return false;
    }
    if(e.employees.value=='0'){
	alert('��ѡ����ҵ��ģ��Ȼ���ύ!')
	e.employees.focus()
	return false;
    }  
    if(e.revenue.value=='0'){
	alert('��ѡ����ҵ��Ӫҵ�Ȼ���ύ!')
	e.revenue.focus()
	return false;
    }
    if(e.corp_f_name.value==''){
	alert('��������ҵ���˴���Ȼ���ύ!')
	e.corp_f_name.focus()
	return false;
    }  
    if(e.money_reg.value==''){
	alert('������ע���ʽ�Ȼ���ύ!')
	e.money_reg.focus()
	return false;
    } 
    if(e.business_id.value==''){
	alert('�����빤�̵ǼǺţ�Ȼ���ύ!')
	e.business_id.focus()
	return false;
    }
    if(e.tax_id.value==''){
	alert('������˰��ǼǺţ�Ȼ���ύ!')
	e.tax_id.focus()
	return false;
    }				
   if(e.bank.value==''){
	alert('�����뿪�����У�Ȼ���ύ!')
	e.bank.focus()
	return false;
	}
   if(e.account.value==''){					
	alert('�����������ʺţ�Ȼ���ύ!')
	e.account.focus()
	return false;
	} 
   if(e.iso.value=='0'){
	alert('��ѡ�� ISO 900X ��֤��Ȼ���ύ!')
	e.iso.focus()
	return false;
	}
   if(e.country.value==''){
	alert('��������ҵ���ڹ��ң�Ȼ���ύ!')
	e.country.focus()
	return false;
	}
   if(e.state.value==''){
	alert('��������ҵ����ʡ�ݣ�Ȼ���ύ!')
	e.state.focus()
	return false;
	}
   if(e.city.value==''){
	alert('��������ҵ���ڳ��У�Ȼ���ύ!')
	e.city.focus()
	return false;
	}
   if(e.address1.value==''){
	alert('��������ҵ��ַ��Ȼ���ύ!')
	e.address1.focus()
	return false;
	}  
   if(e.postcode.value==''){
	alert('��������ҵ�ʱ࣬Ȼ���ύ!')
	e.postcode.focus()
	return false;
	}            
   if(e.fax.value=='0'){
	alert('��������ҵ���棬Ȼ���ύ!')
	e.fax.focus()
	return false;
	}
  if(e.tel.value=='0'){
	alert('��������ҵ�绰��Ȼ���ύ!')
	e.tel.focus()
	return false;
	}
  if(e.sell_prod_id.value=='0'){
	alert('��ѡ��ϣ�����۵Ĳ�Ʒ��Ȼ���ύ!')
	e.sell_prod_id.focus()
	return false;
	}	
	
}
 // --></SCRIPT>   
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
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="25"><a href="../html/aboutus/aboutus_bomianq.htm" class="white10">��ȫ����</a></td>
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
      <form method="post" action="chengrevert.jsp" name="putin" onSubmit="return validateForm(putin);">
        <table width="550" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF" align="center"> 
            <td height="315"> 
              <table width="550" border="0" cellspacing="0" cellpadding="4">
                <tr bgcolor="#E6EDFB"> 
                  <td height="25" class="font10"> ����PaperEC.com�ȳ���ӭ�г��ŵĳ��̵�PaperEC�����۲�Ʒ������ϸ��д�����񣬴� 
                    <font color="#FF3300">*</font> �ŵ�Ϊ�����PaperEC.com��Ҫ֪����Щ��Ϣ������֤����͸¶�κ���Ϣ������������<a href="../html/aboutus/aboutus_bomianq.htm">���ܰ�ȫ</a>�����</td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td height="200" class="font10">
                    <table width="550" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td colspan="2" class="font10" align="center"> 
                          <hr>
                        </td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ��ҵȫ�ƣ�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="full_name" value="<%=data[0]%>">
                          <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ��ҵ��ģ��</td>
                        <td width="340" class="font10"> 
                         <select name="employees">
                          <option value="0" selected>--��ѡ��--</option>
                     <%  for(int i=0;i<empl.length;i++){  %>   
                           <option value="<%=empl[i][0]%>" ><%=empl[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ��Ӫҵ��(Ԫ����</td>
                        <td width="340" class="font10"> 
                          <select name="revenue">
                          <option value="0" selected>--��ѡ��--</option>
                     <%  for(int i=0;i<reve.length;i++){  %>   
                           <option value="<%=reve[i][0]%>" ><%=reve[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ��ҵ���˴���</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="corp_f_name">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ע���ʽ�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="money_reg">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right">���̵ǼǺţ�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="business_id">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ˰��ǼǺţ�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="tax_id">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> �������У�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="bank">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> �����ʺţ�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="account">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ISO 900X 
                          ��֤��</td>
                        <td width="340" class="font10"> 
                          <select name="iso">
                           <option value="0" selected>--��ѡ��--</option>
                     <%  for(int i=0;i<iso.length;i++){  %>   
                           <option value="<%=iso[i][0]%>" ><%=iso[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ��ҵ��ַ��</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="url">
                        </td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ���ң�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="country" value="<%=data[1]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ʡ�ݣ�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="state" value="<%=data[2]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ���У�</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="city" value="<%=data[3]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ��ϵ��ַ��</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="address1" value="<%=data[4]%>" size="40">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right">&nbsp;</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="address2" value="<%=data[5]%>" size="40">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> �������룺</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="postcode" value="<%=data[6]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> �绰��</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="tel" value="<%=data[8]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right">���棺</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="fax" value="<%=data[7]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> �������䣺</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="email" value="<%=data[9]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right" valign="top">ϣ����paperEC.com�����۵Ĳ�Ʒ��</td>
                        <td width="340" class="font10"> 
                          <select name="sell_prod_id">
                           <option value="0" selected>--��ѡ��--</option>
                     <%  for(int i=0;i<sell.length;i++){  %>   
                           <option value="<%=sell[i][0]%>" ><%=sell[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr align="center"> 
                  <td  class="dan10" height="62" bgcolor="#E6EDFB">
                    <input type="hidden" name="user_id" value="<%=user_id%>">
                    <input type="submit" name="Submit" value="�� ��">
                    <input type="reset" name="Submit2" value="�� ��">
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
<% bs.getDestroy();  %> 
</jsp:useBean>

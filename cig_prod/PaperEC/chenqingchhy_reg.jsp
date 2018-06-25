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
	<jsp:forward page="inform.jsp?info=对不起, 您已经是卖方会员!" />" />
	</jsp:forward>
<% 
   }
%>

<SCRIPT LANGUAGE="JavaScript"><!--
function validateForm(e){
    if(e.full_name.value==''){
	alert('请输入企业全称，然后提交!')
	e.full_name.focus()
	return false;
    }
    if(e.employees.value=='0'){
	alert('请选择企业规模，然后提交!')
	e.employees.focus()
	return false;
    }  
    if(e.revenue.value=='0'){
	alert('请选择企业年营业额，然后提交!')
	e.revenue.focus()
	return false;
    }
    if(e.corp_f_name.value==''){
	alert('请输入企业法人代表，然后提交!')
	e.corp_f_name.focus()
	return false;
    }  
    if(e.money_reg.value==''){
	alert('请输入注册资金，然后提交!')
	e.money_reg.focus()
	return false;
    } 
    if(e.business_id.value==''){
	alert('请输入工商登记号，然后提交!')
	e.business_id.focus()
	return false;
    }
    if(e.tax_id.value==''){
	alert('请输入税务登记号，然后提交!')
	e.tax_id.focus()
	return false;
    }				
   if(e.bank.value==''){
	alert('请输入开户银行，然后提交!')
	e.bank.focus()
	return false;
	}
   if(e.account.value==''){					
	alert('请输入银行帐号，然后提交!')
	e.account.focus()
	return false;
	} 
   if(e.iso.value=='0'){
	alert('请选择 ISO 900X 认证，然后提交!')
	e.iso.focus()
	return false;
	}
   if(e.country.value==''){
	alert('请输入企业所在国家，然后提交!')
	e.country.focus()
	return false;
	}
   if(e.state.value==''){
	alert('请输入企业所在省份，然后提交!')
	e.state.focus()
	return false;
	}
   if(e.city.value==''){
	alert('请输入企业所在城市，然后提交!')
	e.city.focus()
	return false;
	}
   if(e.address1.value==''){
	alert('请输入企业地址，然后提交!')
	e.address1.focus()
	return false;
	}  
   if(e.postcode.value==''){
	alert('请输入企业邮编，然后提交!')
	e.postcode.focus()
	return false;
	}            
   if(e.fax.value=='0'){
	alert('请输入企业传真，然后提交!')
	e.fax.focus()
	return false;
	}
  if(e.tel.value=='0'){
	alert('请输入企业电话，然后提交!')
	e.tel.focus()
	return false;
	}
  if(e.sell_prod_id.value=='0'){
	alert('请选择希望销售的产品，然后提交!')
	e.sell_prod_id.focus()
	return false;
	}	
	
}
 // --></SCRIPT>   
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
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="25"><a href="../html/aboutus/aboutus_bomianq.htm" class="white10">安全保密</a></td>
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
      <form method="post" action="chengrevert.jsp" name="putin" onSubmit="return validateForm(putin);">
        <table width="550" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF" align="center"> 
            <td height="315"> 
              <table width="550" border="0" cellspacing="0" cellpadding="4">
                <tr bgcolor="#E6EDFB"> 
                  <td height="25" class="font10"> 　　PaperEC.com热忱欢迎有诚信的厂商到PaperEC上销售产品。请仔细填写下面表格，带 
                    <font color="#FF3300">*</font> 号的为必填项。PaperEC.com需要知道这些信息，并保证不会透露任何信息予第三方（详见<a href="../html/aboutus/aboutus_bomianq.htm">保密安全</a>条款）。</td>
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
                        <td width="198" class="font10" align="right"> 企业全称：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="full_name" value="<%=data[0]%>">
                          <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 企业规模：</td>
                        <td width="340" class="font10"> 
                         <select name="employees">
                          <option value="0" selected>--请选择--</option>
                     <%  for(int i=0;i<empl.length;i++){  %>   
                           <option value="<%=empl[i][0]%>" ><%=empl[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 年营业额(元）：</td>
                        <td width="340" class="font10"> 
                          <select name="revenue">
                          <option value="0" selected>--请选择--</option>
                     <%  for(int i=0;i<reve.length;i++){  %>   
                           <option value="<%=reve[i][0]%>" ><%=reve[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 企业法人代表：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="corp_f_name">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 注册资金：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="money_reg">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right">工商登记号：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="business_id">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 税务登记号：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="tax_id">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 开户银行：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="bank">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 银行帐号：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="account">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> ISO 900X 
                          认证：</td>
                        <td width="340" class="font10"> 
                          <select name="iso">
                           <option value="0" selected>--请选择--</option>
                     <%  for(int i=0;i<iso.length;i++){  %>   
                           <option value="<%=iso[i][0]%>" ><%=iso[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 企业网址：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="url">
                        </td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 国家：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="country" value="<%=data[1]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 省份：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="state" value="<%=data[2]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 城市：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="city" value="<%=data[3]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 联系地址：</td>
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
                        <td width="198" class="font10" align="right"> 邮政编码：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="postcode" value="<%=data[6]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 电话：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="tel" value="<%=data[8]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right">传真：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="fax" value="<%=data[7]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> 电子信箱：</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="email" value="<%=data[9]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right" valign="top">希望在paperEC.com上销售的产品：</td>
                        <td width="340" class="font10"> 
                          <select name="sell_prod_id">
                           <option value="0" selected>--请选择--</option>
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
                    <input type="submit" name="Submit" value="提 交">
                    <input type="reset" name="Submit2" value="重 填">
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

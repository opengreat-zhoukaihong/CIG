<%@ page language="java"%>

<jsp:useBean id="bs" scope="page" class="mypaperec.BecomeS" /> 
<%
   //String user_id=UserInfo.getUserId();
   String user_id=request.getParameter("user_id");
   bs.setUser_id(user_id);
   bs.setLang_code("EN");
   String[] data=bs.getAllData();
   String[][] empl=bs.getEmployees();
   String[][] reve=bs.getRevenue();
   String[][] iso=bs.getIso();
   String[][] sell=bs.getSellprodid();
   String[][] acco=bs.getAccount();
 //  String addr1=data[1]+"  "+data[2]+"  "+data[3]+"  "+data[4];
 //  String addr2=data[5]; 
 
   if (data[10].equals("S")){
        bs.getDestroy();  
%>
	<jsp:forward page="inform.jsp?info=Sorry, you were a seller already!" />" />
	</jsp:forward>
<% 
   }
%>

<SCRIPT LANGUAGE="JavaScript"><!--
function validateForm(e){
    if(e.full_name.value==''){
	alert('Please input company name, afterwards submit!')
	e.full_name.focus()
	return false;
    }
    if(e.employees.value=='0'){
	alert('Please select the employees of your company, afterwards submit!')
	e.employees.focus()
	return false;
    }  
    if(e.revenue.value=='0'){
	alert('Please input the revenue, afterwards submit!')
	e.revenue.focus()
	return false;
    }
    if(e.regi_addr.value==''){
	alert('Please input your register address, afterwards submit!')
	e.regi_addr.focus()
	return false;
    }  
    if(e.year_founded.value==''){
	alert('Please input the year founded of your company, afterwards submit!')
	e.year_founded.focus()
	return false;
    } 
    if(e.iso.value=='0'){
	alert('Please input the ISO information, afterwards submit!')
	e.iso.focus()
	return false;
    }
    if(e.address1.value==''){
	alert('Please input your address, afterwards submit!')
	e.address1.focus()
	return false;
    }				
   if(e.postcode.value==''){
	alert('Please input postcode, afterwards submit!')
	e.postcode.focus()
	return false;
	}
   if(e.tel.value==''){					
	alert('Please input the telephone number, afterwards submit!')
	e.tel.focus()
	return false;
	} 
   if(e.fax.value==''){
	alert('Please input the fax number, afterwards submit!')
	e.fax.focus()
	return false;
	}
   if(e.email.value==''){
	alert('Please input your email, afterwards submit!')
	e.email.focus()
	return false;
	}
   if(e.account_title.value==''){
	alert('Please input your account title, afterwards submit!')
	e.account_title.focus()
	return false;
	}	
   if(e.local_bank.value==''){
	alert('Please input your local bank, afterwards submit!')
	e.local_bank.focus()
	return false;
	}            
   if(e.bank_address1.value==''){
	alert('Please input the address of the bank, afterwards submit!')
	e.bank_address1.focus()
	return false;
	}
   if(e.bank_postcode.value==''){
	alert('Please input the postcode of the bank, afterwards submit!')
	e.bank_postcode.focus()
	return false;
	}
   if(e.account_type.value=='0'){
	alert('Please select your account type, afterwards submit!')
	e.account_type.focus()
	return false;
	}		
   if(e.rel_length.value==''){
	alert('Please input the relation, afterwards submit!')
	e.rel_length.focus()
	return false;
	}
   if(e.bank_f_officer.value==''){
	alert('Please input your bank officer, afterwards submit!')
	e.bank_f_officer.focus()
	return false;
	}
   if(e.bank_tel.value==''){
	alert('Please input telephone number of your bank, afterwards submit!')
	e.bank_tel.focus()
	return false;
	}
   if(e.sell_prod_id.value=='0'){
	alert('Please select the product that you want to sell, afterwards submit!')
	e.sell_prod_id.focus()
	return false;
	}	
}
 // --></SCRIPT>   
 
 <script language="JavaScript"> 
function CheckInteger(object_value) { 
	var GoodChars = "0123456789"; 
	var i = 0; 
	for (i=0; i<= object_value.length -1; i++) { 
	    if (GoodChars.indexOf(object_value.charAt(i)) == -1) { 
		return false; 
	    } 
	} 
	return true; 
} 

function CheckNumber(object_value) { 
	var GoodChars = "0123456789"; 
	var firstChar = object_value.charAt(0);
	var numberStr = object_value;
 	var array = new Array();
	var i = 0; 

	if (firstChar=='+'|| firstChar=='-')
	    numberStr = object_value.substring(1, object_value.length);
	
	array = numberStr.split(".");
	if (array.length ==1){
	    if (array[0].length ==0)
		return false;
	}
	else if (array.length >2){
	    return false;
	}
	for (i=0; i< array.length; i++) {
	    for (var j=0; j< array[i].length; j++) { 
		if (GoodChars.indexOf(array[i].charAt(j)) == -1) { 
		    return false; 
		}
	    } 
	} 
	return true; 
} 

function CheckDate(object_value) { 
 	var array = new Array();
	
	array = object_value.split("-");
	if (array.length !=3){
	    return false;
	}
	if (!CheckInteger(array[0]))
	    return false;
	if (!CheckInteger(array[1]))
	    return false;
	if (!CheckInteger(array[2]))
	    return false;
	if ( eval(array[2])<2000 ||eval(array[0])>9999)
	    return false;
	if ( eval(array[0])<1 ||eval(array[1])>12)
	    return false;
	if ( eval(array[1])<1 ||eval(array[2])>31)
	    return false;
	    
	return true; 
} 

function validField(object){
	var value = ptrim(object.value);
	if (value !="")
	{
	    if ( !CheckNumber(value))
	    {
	    	alert("输入值非法,请核实!");
	        object.focus();
	    }
	}
}

function validDateField(object){
	var value = ptrim(object.value);

	if ( !CheckDate(value))
	{
	    alert("输入值非法,请核实!");
	    object.focus();
	}
}
</script>
 
<html>
<head>
<title>My Paperec--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "Verdana", "Arial", "Helvetica", "sans-serif"}
.font9 {  font-size: 14px; font-family: "Verdana", "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 12px; color: #FFFFFF; font-family: "Verdana", "Arial", "Helvetica", "sans-serif"}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color: #000000}
.big {  font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; font-size: 14px}
-->
</style>
</head>

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
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="25"><a href="../../html/html_en/aboutus/aboutus_bomianq.htm" class="white10">Privacy 
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
      <form method="post" action="chengrevert.jsp" name="putin" onSubmit="return validateForm(putin);">
        <table width="554" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF" align="center"> 
            <td height="252"> 
              <table width="550" border="0" cellspacing="0" cellpadding="4">
                <tr bgcolor="#E6EDFB"> 
                  <td height="25" class="font10">PaperEC.com welcomes all enterprises 
                    and traders to buy and sell pulp and paper products on PaperEC.com. 
                    Please complete all fields marked with an asterisk (<font color="#FF3300">*</font>) on 
                    the following form. PaperEC.com does not share this information 
                    with any third party. (See details in <a href="../../html/html_en/aboutus/aboutus_bomianq.htm">Privacy 
                    and Safety Statement</a>)</td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td height="906" class="font10"> 
                    <table width="550" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td colspan="2"> 
                          <hr>
                        </td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Company 
                          Name:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="full_name" value="<%=data[0]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Employees:</td>
                        <td width="309" class="font10"> 
                          <select name="employees">
                           <option value="0" selected>--select--</option>
                     <%  for(int i=0;i<empl.length;i++){  %>   
                           <option value="<%=empl[i][0]%>" ><%=empl[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Revenue(USD):</td>
                        <td width="309" class="font10"> 
                          <select name="revenue">
                           <option value="0" selected>--select--</option>
                     <%  for(int i=0;i<reve.length;i++){  %>   
                           <option value="<%=reve[i][0]%>" ><%=reve[i][1]%></option>
                     <%  }%>      
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Designated 
                          Contact Person:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="cont_f_name">
                        </td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">Title:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="cont_title">
                        </td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">Country In 
                          Which Incorporated, Organized or Established:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="regi_addr">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Year Founded:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="year_founded">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> ISO 900X 
                          Certified:</td>
                        <td width="309" class="font10"> 
                          <select name="iso">
                           <option value="0" selected>--select--</option>
                     <%  for(int i=0;i<iso.length;i++){  %>   
                           <option value="<%=iso[i][0]%>" ><%=iso[i][1]%></option>
                     <%  }%>    
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> Country:</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="country" value="<%=data[1]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> State:</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="state" value="<%=data[2]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> City:</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="city" value="<%=data[3]%>">
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Address:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="address1" value="<%=data[4]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">&nbsp;</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="address2" value="<%=data[5]%>">
                          </td>
                      </tr>                    
                      <tr> 
                        <td width="229" class="font10" align="right"> Postal Code:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="postcode" value="<%=data[6]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Phone:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="tel" value="<%=data[7]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">Fax:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="fax" value="<%=data[8]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">Email:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="email" value="<%=data[9]%>">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Company 
                          Web Address:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="url">
                        </td>
                      </tr>
                      <tr> 
                        <td class="big" width="229"> <b >Bank Information </b></td>
                        <td width="309">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="2" class="font10">
                          <hr>
                        </td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Full Bank 
                          Account Title:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="account_title">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Local Bank 
                          Name:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="local_bank">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> Country:</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="bankcountry" >
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> State:</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="bankstate" >
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="198" class="font10" align="right"> City:</td>
                        <td width="340" class="font10"> 
                          <input type="text" name="bankcity" >
                         <font color="#FF3300">*</font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">Address:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="bank_address1" size="40">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">&nbsp;</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="bank_address2" size="40">
                        </td>
                      </tr>                      
                      <tr> 
                        <td width="229" class="font10" align="right"> Postal Code:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="bank_postcode">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">Type of Account:</td>
                        <td width="309" class="font10"> 
                          <select name="account_type">
                           <option value="0" selected>--select--</option>
                     <%  for(int i=0;i<acco.length;i++){  %>   
                           <option value="<%=acco[i][0]%>" ><%=acco[i][1]%></option>
                     <%  }%>     
                          </select>
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Length of 
                          Relations(Years):</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="rel_length">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right"> Bank Officer:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="bank_f_officer">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" align="right">Bank Telephone:</td>
                        <td width="309" class="font10"> 
                          <input type="text" name="bank_tel">
                          <font color="#FF3300">* </font></td>
                      </tr>
                      <tr> 
                        <td colspan="2" class="font10"> 
                          <hr>
                        </td>
                      </tr>
                      <tr> 
                        <td width="229" class="font10" valign="top" align="right">Which 
                          type of products do you wish to sell on PaperEC.com: 
                        </td>
                        <td width="309" class="font10"> 
                          <select name="sell_prod_id">
                           <option value="0" selected>--select--</option>
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
                  <td  class="dan10" height="25" bgcolor="#E6EDFB">
                    <input type="hidden" name="user_id" value="<%=user_id%>">
                    <input type="submit" name="Submit" value="Submit">
                    <input type="reset" name="Submit2" value=" Reset  ">
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
<% bs.getDestroy();  %> 
</jsp:useBean>
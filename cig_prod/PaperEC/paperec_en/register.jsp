<%@ page import="java.util.*, java.sql.*" session="true" language="java"%> 
   <%!   Vector v=new Vector();Vector v_id=new Vector();
         String arr[]=new String[30]; 
         String lar[]=new String[30];
         String gjarr[]=new String[10];  
         ResultSet allData,stateData,cityData;  
         String st,st1; int i; %>
   <jsp:useBean id="myFind" scope="page" class="postcenter.newRegister" />
   <jsp:useBean id="myFind1" scope="page" class="postcenter.newRegister" />
   <jsp:useBean id="myFind2" scope="page" class="postcenter.newRegister" />
   <jsp:setProperty name="myFind" property="sqlStc" value="select name,country_id from country where lang_code='EN' order by name" />
   <%   try{  if(!v.isEmpty())v.removeAllElements();
              if(!v_id.isEmpty())v_id.removeAllElements();
              Vector v1=new Vector();
              Vector v2=new Vector();
             i=0; int j; 
             allData=myFind.getAllData();
             
             while(allData.next()){                
               i++;
               v.addElement(allData.getString("name"));
               st=allData.getString("country_id");
               v_id.addElement(st);
               st="select name,state_id from state where lang_code='EN' and country_id="+st+" order by name";
               myFind1.setSqlStc(st);
               stateData=myFind1.getAllData();
               
               j=0;
               while(stateData.next()){
                  j++;
                  st=stateData.getString("state_id");
                  v1.addElement(""+i+"%"+stateData.getString("name")+"%"+st);                 
                  st="select name,city_id from city where lang_code='EN' and state_id="+st+" order by name";
                  myFind2.setSqlStc(st);
                  cityData=myFind2.getAllData();
                    while(cityData.next()){
                       v2.addElement(""+i+"%"+j+"%"+cityData.getString("name")+"%"+cityData.getString("city_id"));
                               }         
                      myFind2.disconn();       
                             }
                      myFind1.disconn();          
                       } 
             
              
             myFind2.destroy();
             myFind1.destroy();       
             myFind.disconn();
             st1="\""+v2.elementAt(0)+"\""+",";
             st="\""+v1.elementAt(0)+"\""+","; 
             j=v1.size();
           for(i=1;i<j-1;i++){
             st+="\""+v1.elementAt(i)+"\""+",";  
                  }
             st+="\""+v1.elementAt(j-1)+"\"";
             j=v2.size();     
           for(i=1;i<j-1;i++){
              st1+="\""+v2.elementAt(i)+"\""+",";
                  }
              st1+="\""+v2.elementAt(j-1)+"\"";    
                }catch(Exception e){
                e.printStackTrace();}     
                      
             %>
             
<script language="JavaScript"><!--
   arstate=new Array(<%=st%>);
   arcity=new Array(<%=st1%>);
    menuname=new String();
        
    function creatnext(mf,nf,ef,jf){
     var i=mf.selectedIndex
     var le
     if(i>0&&jf==1){
            nf.length=1
            ef.length=1
            nf.options[0].text='--select--'
            nf.options[0].value='0'
            ef.options[0].text='--select--'
            ef.options[0].value='0'
           
           for(var j=0;j<arstate.length;j++){
                menuname=arstate[j].split("%");
                if(menuname[0]==i){
                    le=nf.length
                    nf.length+=1
                    nf.options[le].text=menuname[1];
                    nf.options[le].value=menuname[2];
                    
                    
                }else{
                     if(menuname[0]>i){ break }  
                }                    
          }  
     }
        if(jf==2){
          k=nf.selectedIndex           
          putin.back_state_text_c.value=nf.options[k].text;
          putin.back_state_value_c.value=nf.options[k].value;
         if(k>0){ 
         
            ef.length=1
           for(var j=0;j<arcity.length;j++){
               menuname=arcity[j].split("%");
               
                if(menuname[0]==i&&menuname[1]==k){
                    le=ef.length
                    ef.length+=1;
                    ef.options[le].text=menuname[2]
                    ef.options[le].value=menuname[3]
                    
               }else{
                     if(menuname[1]>k&&menuname[0]==i){ break}  
               }                      
          }
        }
           
      }  
     if(jf==3){
        k=ef.selectedIndex
        putin.back_city_text_c.value=ef.options[k].text;
        putin.back_city_value_c.value=ef.options[k].value;
      
     } 
      
  }   
  //--></script> 
  
  <SCRIPT LANGUAGE="JavaScript"><!--

function validateIntValue(numv){
       var invalue=numv.value;
       var len=invalue.length;
       if(len<6||len>16){
          alert("The length of your password is not correct, please check and re-select.");
          numv.value='';
          return false;
       }
       for(var i=0;i<len;i++){
              if((invalue.charAt(i)=='_')||((invalue.charAt(i)>='a')&&(invalue.charAt(i)<='z'))||((invalue.charAt(i)>='A')&&(invalue.charAt(i)<='Z'))||((invalue.charAt(i)<='9')&&(invalue.charAt(i)>='0'))){
              }else{                     
                     alert("This is invalid, please reinput using alphanumeric characters!");
                     numv.value='';                    
		     return false;
	       }
       }
		return true;      
      
} 

function  passsame(){
   if(putin.p_passwd.value!=putin.p_passwd1.value){
       alert("Confirm Password is error, please validated!");
       putin.p_passwd1.value='';                     
       return false;
   }
   return true;     
}

function validateForm(e){
    if(e.p_login.value==''){
	alert('Please input your username, afterwards submit!')
	e.p_login.focus()
	return false;
    }
    if (e.p_login.value!=''){
       invalue=e.p_login.value;
       len=invalue.length;

       if(len<4||len>16){
          alert("The length of your username is not correct, please check and re-input.");
          e.p_login.focus()
          return false;
       }
       for(var i=0;i<len;i++){
              if((invalue.charAt(i)=='_')||((invalue.charAt(i)>='a')&&(invalue.charAt(i)<='z'))||((invalue.charAt(i)>='A')&&(invalue.charAt(i)<='Z'))||((invalue.charAt(i)<='9')&&(invalue.charAt(i)>='0'))){
              }else{                     
                     alert("This is invalid, please reinput using alphanumeric characters!");
                     e.p_login.focus()                    
		     return false;
	       }
       }    	
    }    
    if(e.p_passwd.value==''){
	alert('Please input your password, afterwards submit!')
	e.p_passwd.focus()
	return false;
    }
    if (e.p_passwd.value!=''){
       invalue=e.p_passwd.value;
       len=invalue.length;

       if(len<4||len>16){
          alert("The length of your password is not correct, please check and re-input.");
          e.p_passwd.focus()
          return false;
       }
       for(var i=0;i<len;i++){
              if((invalue.charAt(i)=='_')||((invalue.charAt(i)>='a')&&(invalue.charAt(i)<='z'))||((invalue.charAt(i)>='A')&&(invalue.charAt(i)<='Z'))||((invalue.charAt(i)<='9')&&(invalue.charAt(i)>='0'))){
              }else{                     
                     alert("This is invalid, please reinput using alphanumeric characters!");
                     e.p_passwd.focus()                    
		     return false;
	       }
       }    	    
    }		    				
   if(e.p_passwd1.value==''){
	alert('Please input your affirm password, afterwards submit!')
	e.p_passwd1.focus()
	return false;
	}
    if(e.p_passwd.value!=e.p_passwd1.value){
       alert("Confirm Password is error, please validated!");
       e.p_passwd1.value='';
       e.p_passwd1.focus()                     
       return false;
   }		
    if(e.p_first_name.value==''){
	alert('Please input your first name, afterwards submit!')
	e.p_first_name.focus()
	return false;
    }
    if(e.p_last_name.value==''){
	alert('Please input your last name, afterwards submit!')
	e.p_last_name.focus()
	return false;
    }  
   if(e.p_question.value!=''&&e.p_answer.value==''){					
	alert('Please input your answer, afterwards submit!')
	e.p_answer.focus()
	return false;
	} 
   if(e.p_name.value==''){
	alert('Please input your company name, afterwards submit!')
	e.p_name.focus()
	return false;
	}
   if(e.p_country_id_c.value=='0'){
	alert('Please select company country, afterwards submit!')
	e.p_country_id_c.focus()
	return false;
	}
   if(e.title.value==''){
	alert('Please input your title, afterwards submit!')
	e.p_job_title.focus()
	return false;
    } 	
   if(e.p_prod_focu_id.value=='0'){
	alert('Please select company operation, afterwards submit!')
	e.p_prod_focu_id.focus()
	return false;
	}	
   if(e.p_tel_c.value==''){
	alert('Please input company phone, afterwards submit!')
	e.p_tel_c.focus()
	return false;
	}            
   if(e.p_email_c.value=='0'){
	alert('Please input company E-mail, afterwards submit!')
	e.p_email_c.focus()
	return false;
	}
	
   if(e.p_email_c.value==''&&e.email_info.value=='Y'){
	alert('Please input company E-mail, afterwards submit!')
	e.p_email_c.focus()
	return false;
	}
   if (e.p_email_c.value!=''&&e.email_info.value=='Y'){
      if( e.p_email_c.value.indexOf("@")<1 ){
         e.p_email_c.value=""
         e.p_email_c.focus()
         alert("Mail address error, please validate and input again!")
         return false;
      }
   }     	
}

 // --></SCRIPT>   
  
<html>
<head>
<title>&Icirc;&Ograve;&micro;&Auml;&Ouml;&frac12;&Iacute;&oslash;--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.font9 {  font-size: 14px; font-family: "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 10pt; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; font-family: "Arial", "Helvetica", "sans-serif"; color: #000000}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px}
td {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 12px}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr>
    <td width="159" height="879"> 
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
    <td valign="top" height="879"> 
      <form method="post" action="revert.jsp" name="putin" onSubmit="return validateForm(putin);">
        <table width="604" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
          <tr> 
            <td height="26">Welcome to PaperEC.com's Registration. Please complete 
              all fields marked with an asterisk (*). </td>
          </tr>
          <tr bgcolor="#7EA2EB"> 
            <td class="font9"><b><font color="#FFFFFF">Your Username and Password</font></b></td>
          </tr>
          <tr> 
            <td> 
              <table width="604" border="0" cellspacing="0" cellpadding="4">
                <tr> 
                  <td width="119">Username:</td>
                  <td width="123"> 
                    <input type="text" name="p_login">
                  </td>
                  <td width="342"><font color="#FF3300">* &nbsp</font>(Usernames must 
                    be between 4 and 16 <br>&nbsp&nbsp&nbsp&nbsp alphanumeric characters, and are case 
                    sensitive.) </td>
                </tr>
                <tr> 
                  <td width="119">Password:</td>
                  <td width="123"> 
                    <input type="password" name="p_passwd">
                  </td>
                  <td width="342"><font color="#FF3300">* &nbsp</font>(Passwords must 
                    be between 6 and 16 <br>&nbsp&nbsp&nbsp&nbsp alphanumeric characters, and are case 
                    sensitive.) </td>
                </tr>
                <tr> 
                  <td width="119" height="35">Confirm Password:</td>
                  <td width="123" height="35"> 
                    <input type="password" name="p_passwd1" onBlur="passsame()">
                  </td>
                  <td width="342" height="35"> <font color="#FF3300">* </font></td>
                </tr>
                <tr> 
                  <td colspan="3" height="14"> Identity Hint 
                    <hr>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3" height="27">In case you forget your password, 
                    enter a question that only you can answer. (Note: if you fill 
                    in the question, you must also fill in the answer.)</td>
                </tr>
                <tr> 
                  <td width="119"> Question:</td>
                  <td width="123"> 
                    <input type="text" name="p_question">
                  </td>
                  <td width="342">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="119">Answer: </td>
                  <td width="123"> 
                    <input type="text" name="p_answer">
                  </td>
                  <td width="342">&nbsp; </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr bgcolor="#7EA2EB"> 
            <td class="font9"><b><font color="#FFFFFF">Personal Information</font></b></td>
          </tr>
          <tr> 
            <td height="213"> 
              <table width="604" border="0" cellspacing="0" cellpadding="4">
                <tr> 
                  <td width="117">Salutation:</td>
                  <td colspan="2"> 
                    <input type="radio" name="title" value="M" checked>
                    Mr. 
                    <input type="radio" name="title" value="S">
                    Ms. 
                    <input type="radio" name="title" value="G">
                    Dr. 
                    <font color="#FF3300">&nbsp;*</font>
                 </td>
                </tr>
                <tr> 
                  <td width="117">First Name:</td>
                  <td width="153"> 
                    <input type="text" name="p_first_name" >
                  </td>
                  <td width="322"><font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117">Last Name:</td>
                  <td width="153"> 
                    <input type="text" name="p_last_name" >
                  </td>
                  <td width="322"><font color="#FF3300">*</font></td>
                </tr>
                 <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=11 and lang_code='EN' order by str_value" /> 
          <%     
             allData=myFind.getAllData();
             for(i=0;i<30;i++)
             if(allData.next()){                
               arr[i]=allData.getString("str_value");
               lar[i]=allData.getString("code");
              }else{arr[i]=null;lar[i]=null;}  
                 
             myFind.disconn();      
          %>  
                <tr> 
                  <td width="117">Your Job Title:</td>
                  <td colspan="2"> 
                    <select name="p_job_title">
                      <option value="0" selected>--select--</option>
                      <%   i=0;
                           while(arr[i]!=null){
                      %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>                    
                </tr>
                <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=8 and lang_code='EN' order by str_value" /> 
                  <%     
             allData=myFind.getAllData();
             for(i=0;i<30;i++)
             if(allData.next()){                
               arr[i]=allData.getString("str_value");
               lar[i]=allData.getString("code");
              }else{arr[i]=null;lar[i]=null;}  
                 
             myFind.disconn();      
            %> 
                <tr> 
                  <td width="117">Your Job Function:</td>
                  <td colspan="2"> 
                    <select name="p_job_func_id">
                      <option value="0" selected>--select--</option>
                      <%           i=0;
              while(arr[i]!=null){
                  %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                    <font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117">Phone:</td>
                  <td colspan="2"> <font color="#FF3300"> 
                    <input type="text" name="p_tel_c" >
                    *</font></td>
                </tr>
                <tr> 
                  <td width="117">Fax:</td>
                  <td colspan="2"> <font color="#FF3300"> 
                    <input type="text" name="p_fax_c" >
                    </font></td>
                </tr>
          	<tr > 
            		<td colspan="3"> 
              		<hr>
            		</td>
          	</tr>                
          	<tr> 
                  <td colspan="3">PaperEC.com can provide instant email Auto Notifications for your activities on PaperEC.<br>
                  Do you like it? Please select:  
                  <input type="radio" name="email_info" value="Y">Yes
                  <input type="radio" name="email_info" value="N" checked>No <font color="#FF3300">  * </font>
                  </td>
          	</tr>                
          	<tr> 
                  <td colspan="3">If you would like to use this function, please fill in your email address: 
                    <input type="text" name="p_email_c" size="30">
                  </td>
          	</tr>
          	<tr> 
                  <td colspan="3">If you don't have email address yet, please keep the email address input box blank, and you will get a free one: <br>
          		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;your_username@mail.paperec.com <br>
          		The username and password of your email account are the same as you have selected above. 
          	  </td>
          	</tr>
                          
              </table>
            </td>
          </tr>
          <tr bgcolor="#7EA2EB"> 
            <td class="font9"><b><font color="#FFFFFF">Company Information</font></b></td>
          </tr>
          <tr> 
            <td> 
              <table width="604" border="0" cellspacing="0" cellpadding="4">
                <tr> 
                  <td width="117">Company's Name:</td>
                  <td width="471"><font color="#FF3300"> 
                    <input type="text" name="p_name" size="40">
                    *</font></td>
                </tr>
                <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=9 and lang_code='EN' order by str_value" /> 
          <%     
             allData=myFind.getAllData();
             for(i=0;i<30;i++)
             if(allData.next()){                
               arr[i]=allData.getString("str_value");
               lar[i]=allData.getString("code");
              }else{arr[i]=null;lar[i]=null;}  
                 
             myFind.disconn();      
            %> 
                <tr> 
                  <td width="117">Primary Industry:</td>
                  <td width="471"> 
                    <select name="p_industry_id">
                      <option value="0" selected>--select--</option>
                      <%           i=0;
              while(arr[i]!=null){
                  %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                    <font color="#FF3300">*</font> </td>
                </tr>
                 <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=3 and lang_code='EN' order by str_value" /> 
         <%     
             allData=myFind.getAllData();
             for(i=0;i<30;i++)
             if(allData.next()){                
               arr[i]=allData.getString("str_value");
              }else{arr[i]=null;lar[i]=null;}  
                 
             myFind.disconn();      
          %> 
                <tr> 
                  <td width="117">Primary Product Focus: </td>
                  <td width="471"> 
                    <select name="p_prod_focu_id">
                      <option value="0" selected>--select--</option>
                 <%       i=0;
                          while(arr[i]!=null){
                  %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                    <font color="#FF3300">*</font> </td>
                </tr>
                <tr> 
                  <td width="117">Country: </td>
                  <td width="471"> 
                    <select name="p_country_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,1)">
                      <option value="0" selected>--select--</option>
                      <%           
              for(i=0;i<v.size();i++){
                  %> 
                      <option value="<%=v_id.elementAt(i)%>"><%=v.elementAt(i)%></option>
                      <%    } %>      
              
                    </select>
                    <font color="#FF3300">*</font> </td>
                </tr>
                <tr> 
                  <td width="117">State: </td>
                  <td width="471">                    
                   <select name="p_state_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,2)">
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="117">City: </td>
                  <td width="471"> 
                    <select name="p_city_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,3)">
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="117">Address:</td>
                  <td width="471"> 
                    <input type="text" name="p_address1_c" size="40">
                    <font color="#FF3300">*</font> </td>
                </tr>
                <tr> 
                  <td width="117">&nbsp;</td>
                  <td width="471"> 
                    <input type="text" name="p_address2_c" size="40">
                  </td>
                </tr>
                <tr> 
                  <td width="117">Postal Code:</td>
                  <td width="471"><font color="#FF3300"> 
                    <input type="text" name="p_postcode_c">
                    *</font> </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> 
              <hr>
            </td>
          </tr>
          <tr> 
            <td>Does you company currently sell products in China: 
              <input type="radio" name="impo" value="Y">
              yes 
              <input type="radio" name="impo" value="N">
              no 
              <input type="radio" name="impo" value="I" checked>
              don't know <font color="#FF3300"> *</font> </td>
          </tr>
           <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=3 and lang_code='EN' order by str_value" /> 
          <%     
             allData=myFind.getAllData();
             for(i=0;i<30;i++)
             if(allData.next()){                
               arr[i]=allData.getString("str_value");
               lar[i]=allData.getString("code");
              }else{arr[i]=null;lar[i]=null;}  
                 
             myFind.disconn();      
            %> 
          <tr> 
            <td>If so, what types of products do you sell in China: 
              <select name="impo_prod_id">
                      <option value="0" selected>--select--</option>
                      <%           i=0;
              while(arr[i]!=null){
                  %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
            </td>
          </tr>
          <tr> 
            <td> 
              <hr>
            </td>
          </tr>
          <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=5 and lang_code='EN' order by str_value" /> 
          <%    
             allData=myFind.getAllData();
             for(i=0;i<30;i++)
             if(allData.next()){                
               arr[i]=allData.getString("str_value");
               lar[i]=allData.getString("code");
              }else{arr[i]=null;lar[i]=null;}  
                 
             myFind.disconn();      
          %> 
          <tr>
            <td>Where did you learn about PaperEC.com: 
              <select name="p_know_id" >
                      <option value="0" selected>--select--</option>
                      <%   i=0;
                           while(arr[i]!=null){
                       %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
            </td>
          </tr>
          <tr> 
            <td>
              <hr>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="580" border="0" cellspacing="2" cellpadding="2" align="center">
                <tr align="center"> 
                  <td class="dan10"> 
                    <input type="button" name="Submit3" value="Before Submitting, Read the Membership Agreement" onClick="javascript:show('memberagreetment_s.htm')" >
                    <br>
                    <br>
                    <b>By submiting this registration form you acknowledge you 
                    have read and agree to all aspects of the Membership Agreement. 
                    </b><br>
                    <br>
                    If you have any questions, please <a href="mailto:info@paperec.com">Contact 
                    Us</a>.<br>
                    or Phone: <b>+86-755-3691610</b> Fax: <b>+86-755-3201877</b></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td>
              <input type="hidden" name="back_state_text_c" value="--select--">
              <input type="hidden" name="back_city_text_c" value="--select--">
              <input type="hidden" name="back_state_value_c" value="0">
              <input type="hidden" name="back_city_value_c" value="0"> 
              <input type="submit" name="Submit" value="Submit">
              <input type="reset" name="reset" value="Cancel">
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
<% myFind.destroy();%>
</jsp:useBean> 

<script language="javascript">
   function initback(){
      
      putin.p_state_id_c.length=1;
      putin.p_city_id_c.length=1;
      putin.p_state_id_c.options[0].text=putin.back_state_text_c.value;
      putin.p_city_id_c.options[0].text=putin.back_city_text_c.value;
      putin.p_state_id_c.options[0].value=putin.back_state_value_c.value;
      putin.p_city_id_c.options[0].value=putin.back_city_value_c.value;
   
   }
 
   function show(url){
      window.open(url,'quote','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=630,height=210')
   }
   
   initback();
</script>      
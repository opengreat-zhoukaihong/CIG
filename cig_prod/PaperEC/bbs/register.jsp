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
   <jsp:setProperty name="myFind" property="sqlStc" value="select name,country_id from country where lang_code='GB' order by name" />
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
               st="select name,state_id from state where lang_code='GB' and country_id="+st+" order by name";
               myFind1.setSqlStc(st);
               stateData=myFind1.getAllData();
               
               j=0;
               while(stateData.next()){
                  j++;
                  st=stateData.getString("state_id");
                  v1.addElement(""+i+"."+stateData.getString("name")+"."+st);                 
                  st="select name,city_id from city where lang_code='GB' and state_id="+st+" order by name";
                  myFind2.setSqlStc(st);
                  cityData=myFind2.getAllData();
                    while(cityData.next()){
                       v2.addElement(""+i+"."+j+"."+cityData.getString("name")+"."+cityData.getString("city_id"));
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
            nf.options[0].text='--��ѡ��--'
            nf.options[0].value='0'
            ef.options[0].text='--��ѡ��--'
            ef.options[0].value='0'
           
           for(var j=0;j<arstate.length;j++){
                menuname=arstate[j].split(".");
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
               menuname=arcity[j].split(".");
               
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
          alert("�����ַ��ĳ��ȷǷ�������֤��");
          numv.value='';
          return false;
       }
       for(var i=0;i<len;i++){
              if(((invalue.charAt(i)>='a')&&(invalue.charAt(i)<='z'))||((invalue.charAt(i)>='A')&&(invalue.charAt(i)<='Z'))||((invalue.charAt(i)<='9')&&(invalue.charAt(i)>='0'))){
              }else{                     
                     alert("�����зǷ��ַ�������֤��");
                     numv.value='';                    
		     return false;
	       }
       }
		return true;      
      
} 

function  passsame(){
   if(putin.p_passwd.value!=putin.p_passwd1.value){
       alert("����������������֤��");
       putin.p_passwd1.value='';                     
       return false;
   }
   return true;     
}

function validateForm(e){
    if(e.p_first_name.value==''){
	alert('�����������գ�Ȼ���ύ!')
	e.p_first_name.focus()
	return false;
    }
    if(e.p_last_name.value==''){
	alert('��������������Ȼ���ύ!')
	e.p_last_name.focus()
	return false;
    }  
    if(e.p_dept.value==''){
	alert('���������Ĳ��ţ�Ȼ���ύ!')
	e.p_dept.focus()
	return false;
    }
    if(e.p_job_title.value==''){
	alert('���������Ĺ���ְ��Ȼ���ύ!')
	e.p_job_title.focus()
	return false;
    }  
    if(e.p_login.value==''){
	alert('���������ĵ�¼����Ȼ���ύ!')
	e.p_login.focus()
	return false;
    }
    if(e.p_passwd.value==''){
	alert('�������������룬Ȼ���ύ!')
	e.p_passwd.focus()
	return false;
    }				
   if(e.p_passwd1.value==''){
	alert('��������������ȷ�ϣ�Ȼ���ύ!')
	e.p_passwd1.focus()
	return false;
	}
   if(e.p_question.value!=''&&e.p_answer.value==''){					
	alert('���������Ĵ𰸣�Ȼ���ύ!')
	e.p_answer.focus()
	return false;
	} 
   if(e.p_name.value==''){
	alert('�����빫˾���ƣ�Ȼ���ύ!')
	e.p_name.focus()
	return false;
	}
   if(e.p_country_id_c.value=='0'){
	alert('��ѡ��˾���ڵĹ��ң�Ȼ���ύ!')
	e.p_country_id_c.focus()
	return false;
	}
   if(e.p_prod_focu_id.value=='0'){
	alert('��ѡ��˾�ľ�Ӫҵ��Ȼ���ύ!')
	e.p_prod_focu_id.focus()
	return false;
	}	
   if(e.p_tel_c.value==''){
	alert('�����빫˾�绰��Ȼ���ύ!')
	e.p_tel_c.focus()
	return false;
	}            
   if(e.p_email_c.value=='0'){
	alert('�����빫˾�ʼ���ַ��Ȼ���ύ!')
	e.p_email_c.focus()
	return false;
	}
	
}

function validateall(ex) {
   switch(ex){     
      case 12:
      if( putin.p_mobile.value.length<11 ){
         putin.p_mobile.value=""
         alert("�绰������������֤����������!")
            return false;
      }
      break;    
   
   case 31:
      if( putin.p_email_c.value.indexOf("@")<1 ){
         putin.p_email_c.value=""
         alert("�ʼ���ַ��������֤����������!")
            return false;
      }
      break;    
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
td {  font-family: "����"; font-size: 12px}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr>
    <td width="159" height="879"> 
      <script> NS = (document.layers) ? 1 : 0;	IE = (document.all) ? 1: 0;	self.onError=null; ls_Y = 0; function goto_url(e) {var url = e.options[e.selectedIndex].value; if (url != "") location.href=url;} function smoothscrollMenu() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y) {move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); if(IE) document.all.scrollMenu.style.pixelTop += move; if(NS) document.scrollMenu.top += move; ls_Y = ls_Y + move;} else {move = Math.floor(move); if(IE) d = document.all.scrollMenu.style.pixelTop; else d =document.scrollMenu.top; var dd = d + move;	if (dd >2) { if(IE) document.all.scrollMenu.style.pixelTop += move; else document.scrollMenu.top += move; } ls_Y = ls_Y + move;	}}} function scrollpop() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y){move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}else {move = Math.floor(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}}} if(NS || IE) action = window.setInterval("smoothscrollMenu()",1); function showInfo(){ var newWind=window.open('/dsp_site_pilot_info.html','sitepilotinfo','toolbar=no,titlebar=no,scrollbars=no,status=no,menubar=no,width=375,height=120');
 if (newWind.opener == null) { newWind.opener = window; }} </script>
      <div style="position:absolute; width:141px; height:141px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="141" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="142" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000" align="center">
                <tr align="center"> 
                  <td width="139" height="22" bgcolor="#503CC0"><font color="#FFFFFF" class="big">��¼ע��</font></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25"><a href="bbs/BBSListlogin.jsp?area_ID=1" class="dan10">רҵ�豸</a></td>
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
    <td valign="top" height="879"> 
      <form method="post" action="revert.jsp" name="putin" onSubmit="return validateForm(putin);">
        <table width="604" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
          <tr> 
            <td height="26">��ӭ����ע��ҳ�档��������д���������и����*�ŵ�Ϊ�����</td>
          </tr>
          <tr bgcolor="#7EA2EB"> 
            <td class="font9"><b><font color="#FFFFFF">��Ա�û���������</font></b></td>
          </tr>
          <tr> 
            <td> 
              <table width="604" border="0" cellspacing="0" cellpadding="4">
                <tr> 
                  <td width="119" align="center">�û�����</td>
                  <td width="143"> 
                    <input type="text" name="p_login" onBlur="validateIntValue(this)">
                  </td>
                  <td width="322"><font color="#FF3300">*</font>��ֻ����a-z,A-Z,0-9���»���_����ϣ�6-16���ַ������ִ�Сд�� 
                  </td>
                </tr>
                <tr> 
                  <td width="119" align="center">�ܡ��룺</td>
                  <td width="143"> 
                    <input type="password" name="p_passwd" onBlur="validateIntValue(this)">
                  </td>
                  <td width="322"><font color="#FF3300">*</font>��ֻ����a-z,A-Z,0-9���»���_����ϣ�6-16���ַ������ִ�Сд�� 
                  </td>
                </tr>
                <tr> 
                  <td width="119" align="center" height="35">������һ�����룺</td>
                  <td width="143" height="35"> 
                    <input type="password" name="p_passwd1" onBlur="passsame()">
                  </td>
                  <td width="322" height="35"> <font color="#FF3300">*</font>��Ϊ��ֹ�����������룬�ٴ�����������룩 
                  </td>
                </tr>
                <tr>
                  <td colspan="3" height="14">
                    <hr>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3" height="27">��ʱ�����ܻ��������룬Ϊ���ٵõ����룬�����ø�ֻ������֪��������ʹ� 
                    ��ע�������д����������Ŀ��������д��</td>
                </tr>
                <tr> 
                  <td width="119" align="center"> ������ʾ���⣺</td>
                  <td width="143"> 
                    <input type="text" name="p_question">
                  </td>
                  <td width="322">�����磺�Ҷ�ߣ���</td>
                </tr>
                <tr> 
                  <td width="119" align="center">�𡡰���</td>
                  <td width="143"> 
                    <input type="text" name="p_answer">
                  </td>
                  <td width="322"> �����磺178��</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr bgcolor="#7EA2EB"> 
            <td class="font9"><b><font color="#FFFFFF">���˼���˾��Ϣ</font></b></td>
          </tr>
          <tr> 
            <td> 
              <table width="604" border="0" cellspacing="0" cellpadding="4">
                <tr> 
                  <td width="117" align="center">�ơ�������</td>
                  <td colspan="2"> 
                    <input type="radio" name="title" value="M">
                    ���� 
                    <input type="radio" name="title" value="S">
                    Ůʿ 
                    <input type="radio" name="title" value="G" checked>
                    ���� </td>
                </tr>
                <tr> 
                  <td width="117" align="center">�������գ�</td>
                  <td width="153"> 
                    <input type="text" name="p_last_name" >
                  </td>
                  <td width="322"><font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">����������</td>
                  <td width="153"> 
                    <input type="text" name="p_first_name" >
                  </td>
                  <td width="322"><font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">���ڹ�˾��</td>
                  <td colspan="2"> 
                    <input type="text" name="p_name" size="40">
                    <font color="#FF3300">*</font></td>
                </tr>
                <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=9 and lang_code='GB'" /> 
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
                  <td width="117" align="center">�С���ҵ��</td>
                  <td colspan="2"> 
                    <select name="p_industry_id">
                      <option value="0" selected>--��ѡ��--</option>
                      <%           i=0;
              while(arr[i]!=null){
                  %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                </tr>
                <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=10 and lang_code='GB'" /> 
         <%     
             allData=myFind.getAllData();
             for(i=0;i<30;i++)
             if(allData.next()){                
               arr[i]=allData.getString("str_value");
              }else{arr[i]=null;lar[i]=null;}  
                 
             myFind.disconn();      
          %> 
                <tr> 
                  <td width="117" align="center">��Ӫ��Ʒ��</td>
                  <td colspan="2"> 
                    <select name="p_prod_focu_id">
                      <option value="0" selected>--��ѡ��--</option>
                 <%       i=0;
                          while(arr[i]!=null){
                  %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                    <font color="#FF3300">*</font></td>
                </tr>
                <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=7 and lang_code='GB'" /> 
      <%     allData=myFind.getAllData();
             for(i=0;i<30;i++)
             if(allData.next()){                
               arr[i]=allData.getString("str_value");
               lar[i]=allData.getString("code");
              }else{arr[i]=null;lar[i]=null;}  
                 
             myFind.disconn();      
        %> 
                <tr> 
                  <td width="117" align="center">�������ţ�</td>
                  <td colspan="2"> 
                     <select name="p_dept">
                      <option value="0" selected>--��ѡ��--</option>
                      <%   i=0;
                           while(arr[i]!=null){
                       %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                    <font color="#FF3300">*</font></td>
                </tr>
               <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=11 and lang_code='GB'" /> 
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
                  <td width="117" align="center">ְ������</td>
                  <td colspan="2"> 
                    <select name="p_job_title">
                      <option value="0" selected>--��ѡ��--</option>
                      <%   i=0;
                           while(arr[i]!=null){
                      %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                    <font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">���һ������</td>
                  <td colspan="2"> 
                    <select name="p_country_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,1)">
                      <option value="0" selected>--��ѡ��--</option>
                      <%           
              for(i=0;i<v.size();i++){
                  %> 
                      <option value="<%=v_id.elementAt(i)%>"><%=v.elementAt(i)%></option>
                      <%    } %>      
              
                    </select>
                    <font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">ʡ�����ݣ�</td>
                  <td colspan="2"> 
                   <select name="p_state_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,2)">
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="117" align="center">�ǡ����У�</td>
                  <td colspan="2"> 
                   <select name="p_city_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,3)">
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="117" align="center">��˾��ַ��</td>
                  <td colspan="2"> 
                    <input type="text" name="p_address1_c" size="40">
                    ���ֵ������ƺ��롢���䣩 </td>
                </tr>
                <tr> 
                  <td width="117" align="center">&nbsp;</td>
                  <td colspan="2"> 
                    <input type="text" name="p_address2_c" size="40">
                  </td>
                </tr>
                <tr> 
                  <td width="117" align="center">�������룺</td>
                  <td width="153"> 
                    <input type="text" name="p_postcode_c">
                  </td>
                  <td width="322">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="117" align="center">�硡������</td>
                  <td width="153"> 
                    <input type="text" name="p_tel_c" >
                  </td>
                  <td width="322"> <font color="#FF3300">*</font>���밴������ʽ��д������-�绰���� 
                    �� 755-3691610�� </td>
                </tr>
                <tr> 
                  <td width="117" align="center">�������䣺</td>
                  <td width="153"> 
                    <input type="text" name="p_email_c" onBlur="validateall(31)">
                  </td>
                  <td width="322"><font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">�������棺</td>
                  <td width="153"> 
                    <input type="text" name="p_fax_c" >
                  </td>
                  <td width="322">���밴������ʽ��д������-�绰���� �� 755-3201877��</td>
                </tr>
                <tr> 
                  <td width="117" align="center">�ƶ��绰��</td>
                  <td width="153"> 
                    <input type="text" name="p_mobile" onBlur="validateall(12)">
                  <td width="322">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="3"> 
                    <hr>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3">���Ĺ�˾Ŀǰ�ӹ�����ڽ�ֽ��Ʒ����ز�Ʒ���н��� 
                    <input type="radio" name="impo" value="Y">
                    û�� 
                    <input type="radio" name="impo" value="N">
                    ��֪�� 
                    <input type="radio" name="impo" value="I" checked>
                    <font color="#FF3300">*</font></td>
                </tr>
                 <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=3 and lang_code='GB'" /> 
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
                  <td colspan="3">����У�����һ�ࣺ 
                    <select name="impo_prod_id">
                      <option value="0" selected>--��ѡ��--</option>
                      <%   i=0;
                           while(arr[i]!=null){
                      %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3"> 
                    <hr>
                  </td>
                </tr>
                <jsp:setProperty name="myFind" property="sqlStc" value="select code,str_value from parameter where id=5 and lang_code='GB'" /> 
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
                  <td colspan="3">��ʱ������֪������վ�ģ� 
                    <select name="p_know_id" >
                      <option value="0" selected>--��ѡ��--</option>
                      <%   i=0;
                           while(arr[i]!=null){
                       %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3">
                    <hr>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="580" border="0" cellspacing="2" cellpadding="2" align="center">
                <tr align="center"> 
                  <td class="dan10"> 
                    <input type="button" name="Submit3" value="�����˴��Ķ���ԱЭ��" onClick="javascript:show('memberagreetment_s.htm')" >
                    <br>
                    <br>
                    <b>������վ�ύע�����ʾ���Ѿ��Ķ�����ͬ���ԱЭ�� </b><br>
                    <br>
                    �������Ϊ���������κβ�������֮�����뼰ʱ<a href="mailto:info@paperec.com">��ϵ����</a>��<br>
                    ���µ磺<b>755-3691610</b> ����(Fax)��<b>755-3201877</b></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td>
              
              <input type="hidden" name="back_state_text_c" value="--��ѡ��--">
              <input type="hidden" name="back_city_text_c" value="--��ѡ��--">
              <input type="hidden" name="back_state_value_c" value="0">
              <input type="hidden" name="back_city_value_c" value="0"> 
              <input type="submit" name="Submit" value="ע ��">
              <input type="submit" name="Submit2" value="�� ��">
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
   
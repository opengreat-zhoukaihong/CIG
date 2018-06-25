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
            nf.options[0].text='--请选择--'
            nf.options[0].value='0'
            ef.options[0].text='--请选择--'
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
          alert("输入字符的长度非法，请验证！");
          numv.value='';
          return false;
       }
       for(var i=0;i<len;i++){
              if(((invalue.charAt(i)>='a')&&(invalue.charAt(i)<='z'))||((invalue.charAt(i)>='A')&&(invalue.charAt(i)<='Z'))||((invalue.charAt(i)<='9')&&(invalue.charAt(i)>='0'))){
              }else{                     
                     alert("输入有非法字符，请验证！");
                     numv.value='';                    
		     return false;
	       }
       }
		return true;      
      
} 

function  passsame(){
   if(putin.p_passwd.value!=putin.p_passwd1.value){
       alert("重输密码有误，请验证！");
       putin.p_passwd1.value='';                     
       return false;
   }
   return true;     
}

function validateForm(e){
    if(e.p_first_name.value==''){
	alert('请输入您的姓，然后提交!')
	e.p_first_name.focus()
	return false;
    }
    if(e.p_last_name.value==''){
	alert('请输入您的名，然后提交!')
	e.p_last_name.focus()
	return false;
    }  
    if(e.p_dept.value==''){
	alert('请输入您的部门，然后提交!')
	e.p_dept.focus()
	return false;
    }
    if(e.p_job_title.value==''){
	alert('请输入您的工作职务，然后提交!')
	e.p_job_title.focus()
	return false;
    }  
    if(e.p_login.value==''){
	alert('请输入您的登录名，然后提交!')
	e.p_login.focus()
	return false;
    }
    if(e.p_passwd.value==''){
	alert('请输入您的密码，然后提交!')
	e.p_passwd.focus()
	return false;
    }				
   if(e.p_passwd1.value==''){
	alert('请输入您的密码确认，然后提交!')
	e.p_passwd1.focus()
	return false;
	}
   if(e.p_question.value!=''&&e.p_answer.value==''){					
	alert('请输入您的答案，然后提交!')
	e.p_answer.focus()
	return false;
	} 
   if(e.p_name.value==''){
	alert('请输入公司名称，然后提交!')
	e.p_name.focus()
	return false;
	}
   if(e.p_country_id_c.value=='0'){
	alert('请选择公司所在的国家，然后提交!')
	e.p_country_id_c.focus()
	return false;
	}
   if(e.p_prod_focu_id.value=='0'){
	alert('请选择公司的经营业务，然后提交!')
	e.p_prod_focu_id.focus()
	return false;
	}	
   if(e.p_tel_c.value==''){
	alert('请输入公司电话，然后提交!')
	e.p_tel_c.focus()
	return false;
	}            
   if(e.p_email_c.value=='0'){
	alert('请输入公司邮件地址，然后提交!')
	e.p_email_c.focus()
	return false;
	}
	
}

function validateall(ex) {
   switch(ex){     
      case 12:
      if( putin.p_mobile.value.length<11 ){
         putin.p_mobile.value=""
         alert("电话号码有误，请验证后重新输入!")
            return false;
      }
      break;    
   
   case 31:
      if( putin.p_email_c.value.indexOf("@")<1 ){
         putin.p_email_c.value=""
         alert("邮件地址有误，请验证后重新输入!")
            return false;
      }
      break;    
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
td {  font-family: "宋体"; font-size: 12px}
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
                  <td width="139" height="22" bgcolor="#503CC0"><font color="#FFFFFF" class="big">登录注册</font></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25"><a href="bbs/BBSListlogin.jsp?area_ID=1" class="dan10">专业设备</a></td>
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
    <td valign="top" height="879"> 
      <form method="post" action="revert.jsp" name="putin" onSubmit="return validateForm(putin);">
        <table width="604" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
          <tr> 
            <td height="26">欢迎来到注册页面。请认真填写下面表格所列各项，带*号的为必填项。</td>
          </tr>
          <tr bgcolor="#7EA2EB"> 
            <td class="font9"><b><font color="#FFFFFF">会员用户名和密码</font></b></td>
          </tr>
          <tr> 
            <td> 
              <table width="604" border="0" cellspacing="0" cellpadding="4">
                <tr> 
                  <td width="119" align="center">用户名：</td>
                  <td width="143"> 
                    <input type="text" name="p_login" onBlur="validateIntValue(this)">
                  </td>
                  <td width="322"><font color="#FF3300">*</font>（只能用a-z,A-Z,0-9和下划线_的组合，6-16个字符，区分大小写） 
                  </td>
                </tr>
                <tr> 
                  <td width="119" align="center">密　码：</td>
                  <td width="143"> 
                    <input type="password" name="p_passwd" onBlur="validateIntValue(this)">
                  </td>
                  <td width="322"><font color="#FF3300">*</font>（只能用a-z,A-Z,0-9和下划线_的组合，6-16个字符，区分大小写） 
                  </td>
                </tr>
                <tr> 
                  <td width="119" align="center" height="35">请再输一次密码：</td>
                  <td width="143" height="35"> 
                    <input type="password" name="p_passwd1" onBlur="passsame()">
                  </td>
                  <td width="322" height="35"> <font color="#FF3300">*</font>（为防止填错上面的密码，再次输入这个密码） 
                  </td>
                </tr>
                <tr>
                  <td colspan="3" height="14">
                    <hr>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3" height="27">有时您可能会忘记密码，为快速得到密码，请设置个只有您才知道的问题和答案 
                    （注：如果填写，这两个项目都必须填写）</td>
                </tr>
                <tr> 
                  <td width="119" align="center"> 密码提示问题：</td>
                  <td width="143"> 
                    <input type="text" name="p_question">
                  </td>
                  <td width="322">（比如：我多高？）</td>
                </tr>
                <tr> 
                  <td width="119" align="center">答　案：</td>
                  <td width="143"> 
                    <input type="text" name="p_answer">
                  </td>
                  <td width="322"> （比如：178）</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr bgcolor="#7EA2EB"> 
            <td class="font9"><b><font color="#FFFFFF">个人及公司信息</font></b></td>
          </tr>
          <tr> 
            <td> 
              <table width="604" border="0" cellspacing="0" cellpadding="4">
                <tr> 
                  <td width="117" align="center">称　　呼：</td>
                  <td colspan="2"> 
                    <input type="radio" name="title" value="M">
                    先生 
                    <input type="radio" name="title" value="S">
                    女士 
                    <input type="radio" name="title" value="G" checked>
                    经理 </td>
                </tr>
                <tr> 
                  <td width="117" align="center">　　　姓：</td>
                  <td width="153"> 
                    <input type="text" name="p_last_name" >
                  </td>
                  <td width="322"><font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">　　　名：</td>
                  <td width="153"> 
                    <input type="text" name="p_first_name" >
                  </td>
                  <td width="322"><font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">所在公司：</td>
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
                  <td width="117" align="center">行　　业：</td>
                  <td colspan="2"> 
                    <select name="p_industry_id">
                      <option value="0" selected>--请选择--</option>
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
                  <td width="117" align="center">主营产品：</td>
                  <td colspan="2"> 
                    <select name="p_prod_focu_id">
                      <option value="0" selected>--请选择--</option>
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
                  <td width="117" align="center">部　　门：</td>
                  <td colspan="2"> 
                     <select name="p_dept">
                      <option value="0" selected>--请选择--</option>
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
                  <td width="117" align="center">职　　务：</td>
                  <td colspan="2"> 
                    <select name="p_job_title">
                      <option value="0" selected>--请选择--</option>
                      <%   i=0;
                           while(arr[i]!=null){
                      %> 
                      <option value="<%=lar[i]%>"><%=arr[i]%></option>
                      <%  i++;  } %> 
                    </select>
                    <font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">国家或地区：</td>
                  <td colspan="2"> 
                    <select name="p_country_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,1)">
                      <option value="0" selected>--请选择--</option>
                      <%           
              for(i=0;i<v.size();i++){
                  %> 
                      <option value="<%=v_id.elementAt(i)%>"><%=v.elementAt(i)%></option>
                      <%    } %>      
              
                    </select>
                    <font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">省　　份：</td>
                  <td colspan="2"> 
                   <select name="p_state_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,2)">
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="117" align="center">城　　市：</td>
                  <td colspan="2"> 
                   <select name="p_city_id_c" onclick="creatnext(p_country_id_c,p_state_id_c,p_city_id_c,3)">
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="117" align="center">公司地址：</td>
                  <td colspan="2"> 
                    <input type="text" name="p_address1_c" size="40">
                    （街道、门牌号码、信箱） </td>
                </tr>
                <tr> 
                  <td width="117" align="center">&nbsp;</td>
                  <td colspan="2"> 
                    <input type="text" name="p_address2_c" size="40">
                  </td>
                </tr>
                <tr> 
                  <td width="117" align="center">邮政编码：</td>
                  <td width="153"> 
                    <input type="text" name="p_postcode_c">
                  </td>
                  <td width="322">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="117" align="center">电　　话：</td>
                  <td width="153"> 
                    <input type="text" name="p_tel_c" >
                  </td>
                  <td width="322"> <font color="#FF3300">*</font>（请按这样方式填写：区号-电话号码 
                    如 755-3691610） </td>
                </tr>
                <tr> 
                  <td width="117" align="center">电子邮箱：</td>
                  <td width="153"> 
                    <input type="text" name="p_email_c" onBlur="validateall(31)">
                  </td>
                  <td width="322"><font color="#FF3300">*</font></td>
                </tr>
                <tr> 
                  <td width="117" align="center">传　　真：</td>
                  <td width="153"> 
                    <input type="text" name="p_fax_c" >
                  </td>
                  <td width="322">（请按这样方式填写：区号-电话号码 如 755-3201877）</td>
                </tr>
                <tr> 
                  <td width="117" align="center">移动电话：</td>
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
                  <td colspan="3">您的公司目前从国外进口浆纸产品及相关产品吗：有进口 
                    <input type="radio" name="impo" value="Y">
                    没有 
                    <input type="radio" name="impo" value="N">
                    不知道 
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
                  <td colspan="3">如果有，是哪一类： 
                    <select name="impo_prod_id">
                      <option value="0" selected>--请选择--</option>
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
                  <td colspan="3">您时从哪里知道本网站的： 
                    <select name="p_know_id" >
                      <option value="0" selected>--请选择--</option>
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
                    <input type="button" name="Submit3" value="请点击此处阅读会员协议" onClick="javascript:show('memberagreetment_s.htm')" >
                    <br>
                    <br>
                    <b>您向本网站提交注册表格表示您已经阅读并已同意会员协议 </b><br>
                    <br>
                    如果您认为上面表格有任何不明或不妥之处，请及时<a href="mailto:info@paperec.com">联系我们</a>。<br>
                    或致电：<b>755-3691610</b> 传真(Fax)：<b>755-3201877</b></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td>
              
              <input type="hidden" name="back_state_text_c" value="--请选择--">
              <input type="hidden" name="back_city_text_c" value="--请选择--">
              <input type="hidden" name="back_state_value_c" value="0">
              <input type="hidden" name="back_city_value_c" value="0"> 
              <input type="submit" name="Submit" value="注 册">
              <input type="submit" name="Submit2" value="重 设">
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
   
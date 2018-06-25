<html>
<head>
<title>我的纸网--PaperEC.com</title>
<SCRIPT LANGUAGE="JavaScript"><!--
 function reload(){
  window.history.back()
            }
// --></SCRIPT>
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

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr>
    <td width="159"> <script> NS = (document.layers) ? 1 : 0;	IE = (document.all) ? 1: 0;	self.onError=null; ls_Y = 0; function goto_url(e) {var url = e.options[e.selectedIndex].value; if (url != "") location.href=url;} function smoothscrollMenu() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y) {move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); if(IE) document.all.scrollMenu.style.pixelTop += move; if(NS) document.scrollMenu.top += move; ls_Y = ls_Y + move;} else {move = Math.floor(move); if(IE) d = document.all.scrollMenu.style.pixelTop; else d =document.scrollMenu.top; var dd = d + move;	if (dd >2) { if(IE) document.all.scrollMenu.style.pixelTop += move; else document.scrollMenu.top += move; } ls_Y = ls_Y + move;	}}} function scrollpop() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y){move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}else {move = Math.floor(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}}} if(NS || IE) action = window.setInterval("smoothscrollMenu()",1); function showInfo(){ var newWind=window.open('/dsp_site_pilot_info.html','sitepilotinfo','toolbar=no,titlebar=no,scrollbars=no,status=no,menubar=no,width=375,height=120');
 if (newWind.opener == null) { newWind.opener = window; }} </script>
      <div style="position:absolute; width:141px; height:263px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
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
                  <td height="25" ><a href="bbs/BBSListlogin.jsp?area_ID=4" class="dan10">Jobs</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0" ><a href="registerInfo.htm" class="white10">Membership 
                    Agreement</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../../html/html_en/aboutus/policy.htm" class="white10">Privacy 
                    Policy</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../../html/html_en/aboutus/copyright.htm" class="white10">Copyright</a></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../../images/images_en/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div></td>

<td valign="top"> 
      
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">

<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java"%> 
   <%!   String arr[]=new String[42];
         ResultSet allData=null; 
         String st1,st2;%>
   <jsp:useBean id="myFind" scope="page" class="postcenter.newRegister" />   
   <jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
   <% 
      try{ 
           String st3="";
           boolean bool=false;
           arr[11]=request.getParameter("p_name");
           st1="select name from company_l where name='"+arr[11]+"' and lang_code='EN'";
           myFind.setSqlStc(st1);
           allData=myFind.getAllData();
           if(allData.next()){
              bool=true;
           }
           myFind.disconn();  
           arr[18]= request.getParameter("p_login"); 
           st1="select passwd from users where login='"+arr[18]+"'";  
           myFind.setSqlStc(st1);
           allData=myFind.getAllData();
           if(allData.next()){
               myFind.disconn();
  %>

<tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="center">
                  <td height="200" class="font9">I am sorry! Your username has been used,please change other username!</td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="Back" ONCLICK="reload()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          
        <%   }else if(bool){
                     myFind.disconn();
         %>            
          <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="center">
                  <td height="200" class="font9">I am sorry!  Your company has been，login is defeated!</td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="Back" ONCLICK="reload()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
                     
        <%     }else{  
                     myFind.disconn();
                     arr[1]="EN";arr[19]=request.getParameter("p_passwd");
                     arr[29]=request.getParameter("p_question");arr[28]=request.getParameter("p_answer");
                     arr[39]=request.getParameter("title");  
                     arr[31]=request.getParameter("p_first_name");arr[32]=request.getParameter("p_last_name");
                     arr[10]=request.getParameter("p_industry_id");arr[9]=request.getParameter("p_prod_focu_id");
                     arr[37]="p_job_func_id";arr[36]=request.getParameter("p_job_title");
                     arr[2]=request.getParameter("p_country_id_c");arr[3]=request.getParameter("P_state_id_c");
                     arr[14]=request.getParameter("p_city_c");
                     arr[12]=request.getParameter("p_address1_c");arr[13]=request.getParameter("p_address2_c"); 
                     arr[4]=request.getParameter("p_postcode_c");arr[7]=request.getParameter("p_email_c");
                     arr[5]=request.getParameter("p_tel_c");arr[6]=request.getParameter("p_fax_c");
                     arr[25]=request.getParameter("p_mobile");
                     arr[40]=request.getParameter("impo");arr[41]=request.getParameter("impo_prod_id");
                     arr[30]=request.getParameter("p_know_id");  
                    
                     arr[38]="B";
                     arr[20]=arr[2];
                     arr[21]=arr[3];arr[33]=arr[14];
                     arr[34]=arr[12];arr[35]=arr[13];
                     arr[24]=arr[6];arr[26]=arr[7];
                     arr[17]="";
                     arr[22]=arr[4];arr[23]=arr[5];     
                     arr[0]="Y";
                     arr[15]=""; arr[8]="";
     
                         arr[16]="";
                         arr[27]="";
                         st3=myFind.getPreCall(arr);
                         myFind.disconn();
                         String user_id="";
                         String detial="";
                         String title="";
                         st2="select user_id from users where login='"+arr[18]+"'";
                         myFind.setSqlStc(st2);
                         ResultSet rs=myFind.getAllData();
                         if(rs.next())user_id=rs.getString("user_id");
                         myFind.disconn(); 
                         inqu.setUser_id(user_id);
                         
                         if(inqu.getUserLang().equals("GB")){
                             title="欢迎您访问中国纸网";
                      detial="尊敬的用户："+
                             "\n\n    欢迎您注册为中国纸网会员。"+
                             "\n\n    您的用户名是"+arr[18]+
                             "\n\n    在您成功注册后，系统已自动为您开通了帐号。您已经可以浏览会员专用区域，但尚不能作交易。"+
                             "\n\n    因为中国纸网是一家严肃的网上B2B商业交易平台，为保证交易内"+
                             "容的真实性与安全性，必须对注册用户进行严格的交易资格审查。我"+
                             "们将在两个工作日内完成这项工作，并会以Email方式通知您。您也可"+
                             "以登录我们网站，打开您的个人信息中心看到这条消息。另外，我们"+
                             "还会定期地将本网一些最新内容通过Email发给您。"+
                             "\n\n    假如您希望即刻开通交易功能或有何建议，您可以打电话给我们："+
                             "86-755-3691613  或写信给我们：members@paperec.com"+  
                             "\n\n    祝您愉快。"+            
                             "\n\n\n    中国纸网"+
                             "\n    会员资格审核小组 "+          
                             "\n\n    http://www.paperec.com";
                       
                        }else{
                             title="Welcome to PaperEC.com";
                      detial="Dear Member："+
                             "\n\n  Thank you for signing up as a Member of PaperEC.com!"+
                             "\n\n  As a Member you will get access to PaperEC.com's Member only services."+
                             "\n\n  Your UserName is:"+arr[18]+
                             "\n\n  Your account has been automatically activated. You can "+
                             "access the PaperEC.com's Member-only services using your "+
                             "UserName and password right now. But, you must become a "+
                             "PaperEC.com  Verified Membership before you can engage in "+
                             "online transacting on PaperEC.com. "+
                             "\n  We verify the identity of all our Members as we believe it "+
                             "is in the interest of all market participants to ensure the "+
                             "privacy and safety of all transactions. We will finish your "+
                             "Membership verification within two business days, and will "+
                             "inform you via email. Then you will have full access to all "+
                             "PaperEC services and our e-Marketplace--'My PaperEC'. "+
                             "\n  In addition we will send you regular updates by email to"+
                             "keep you informed about our progress and new initiatives."+
                             "\n\n  If you have any questions about your registration or you "+
                             "need immediate activation of your trade qualification, you "+
                             "can email us at members@paperec.com, or call us Monday through "+
                             "Friday between the hours of 8:30 am. and 6:00 pm. Beijing "+
                             "Standard Time at +86-755-369-1613. Please make sure to include "+
                             "your UserName in all correspondences. "+                             
                             "\n\n\nBest Regards, "+            
                             "\n\nPaperEC.com."+       
                             "\n\nhttp://www.paperec.com";
                              } 
                               
                           inqu.setTitle(title);
                           inqu.setDetail (detial);
                           inqu.getSingleMess();    
       %>
                    


                                     
           <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="center">
     <% if(st3.equals("ok")){   %>           
                  <td height="200" class="font9">  Congratulations!  You have succeeded in registering with PaperEC.com.  
                      Your Username is <%=arr[18]%>.  You can access the PaperEC.com's Member-only services
                      usering your Username and password now.  But, you must become a PaperEC.com Verified
                      Member befor you can engage in online transaction on PaperEC.com.
                      <p>&nbsp;</p>  We verify the identity of all our Members as we belive it is in the interest of
                      all market participants to ensure the privacy and safety of all transactions.  We will finish
                      your Membership verification within tow business days, and will inform you via email.  Then you
                      will have full access to all PaperEC services and our e-Marketplace--"My PaperEC".
                      <p>&nbsp;</p>  In addition we will send you regular updates by email to
                      keep you informed about our progress and new initiatives. 
                      <p>&nbsp;</p>  If you have any questions about your registration or you need immediate activation
                      of your trade quanlification, you can email us at members@paperec.com, or call us Monday through
                      Friday between the hours of 8:30 am. and  6:00 pm.  Beijing Time at +86-755-369-1613.  Please make
                      sure to include your  Username in all correspondeces.
                  
                  </td>
     <%  }else{    %>
                  <td height="200" class="font9"><%=st3%></td>
     <%   }   %>                      
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <a href="login.htm">Back</a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
                   
   <%       
          }       
      }catch(Exception e){  
   %>
             <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="center">
                  <td height="200" class="font9"><p>Internal Server Error.  Please retry in a moment!</p></td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="back" ONCLICK="reload()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>          
  <% }  %>
                   


   
    
<% myFind.destroy();  %>     
<% inqu.getDestroy(); %>
</jsp:useBean>


 
        </table>
        <div align="center"></div>
      
      
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/dline.gif" width="776" height="6"></td>
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

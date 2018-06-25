<html>
<head>
<title>ÎÒµÄÖ½Íø--PaperEC.com</title>
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
    <td width="159"> 
    <script language="JavaScript" src="../../javascript/caidan.js">
</script>
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

<%@ page import="java.util.*, java.sql.*,java.io.*,postcenter.*" session="true" language="java"%> 
   <%!   String arr[]=new String[43];
         ResultSet allData=null; 
         String st1,st2;%>
   <jsp:useBean id="myFind" scope="page" class="postcenter.newRegister" />   
   <jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
   <jsp:useBean id="exect" scope="page" class="postcenter.ExecThread"/>
   <% 
      try{ 
           String st3="";
           boolean bool=false; 
           boolean create_mail=false;        
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
                  <td height="200" class="font9">I am sorry!  Your company has been£¬login is defeated!</td>
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
                     arr[37]=request.getParameter("p_job_func_id");arr[36]=request.getParameter("p_job_title");
                     arr[2]=request.getParameter("p_country_id_c");arr[3]=request.getParameter("p_state_id_c");
                     arr[14]=request.getParameter("p_city_id_c");
                     arr[12]=request.getParameter("p_address1_c");arr[13]=request.getParameter("p_address2_c"); 
                     arr[4]=request.getParameter("p_postcode_c");arr[7]=request.getParameter("p_email_c");
                     arr[5]=request.getParameter("p_tel_c");arr[6]=request.getParameter("p_fax_c");
                     arr[25]=request.getParameter("p_mobile");
                     arr[40]=request.getParameter("impo");arr[41]=request.getParameter("impo_prod_id");
                     arr[30]=request.getParameter("p_know_id");
                     arr[42]=request.getParameter("email_info");  
                    
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
                     if ((arr[42].equals("Y"))&&(arr[7].equals(""))){
                     	 arr[7] = arr[18] + "@mail.paperec.com";
                     	 arr[26] = arr[7];
                     	 create_email=true;
                     }
                     	 
                     st3=myFind.getPreCall(arr);
                     //myFind.disconn();
                         
                     String user_id="";
                     String detial="";
                     String title="";
                     String time="";
                     st2="select user_id,to_char(sysdate,'yyyy-mm-dd hh:mi:ss') time from users where login='"+arr[18]+"'";
                     myFind.setSqlStc(st2);
                     ResultSet rs=myFind.getAllData();
                     if(rs.next()){
                        user_id=rs.getString("user_id");
                        time = rs.getString("time");
                     }       
                     myFind.disconn(); 
                    if(st3.equals("ok")){     
                         inqu.setUser_id(user_id);
                         
                         if (arr[39].equals("G")) arr[39] = "Dr. ";
                         else if (arr[39].equals("S")) arr[39] = "Ms. ";
                         else arr[39] = "Mr. ";
                         
                         
                             title="Welcome to PaperEC.com";
                      detial="Dear "+arr[39]+arr[32]+","+
                             "\n\n  Congratulations! You are now a Verified Member of PaperEC.com. Your "+
                             "Username and password can now be used at any time."+
                             "\n\n  After entering your Username and password at www.paperec.com, you can "+
                             "log in the member areas to browse and make deals. You can can do any of "+
                             "the following:"+
                             "\n1) Login to the members only area to view PaperEC resources, "+
                             "\n2) Post a 'Request to Buy',  and,"+
                             "\n3) Browse supply and demand information, engage in negotiations with "+
                             "the sellers, and conclude online transactions."+
                             "\n\n  If you want to sell your products on PaperEC.com, you need to complete "+
                             "the Membership Application for Sellers. Please login to 'My PaperEC',"+
                             "and click 'My Preferences' to become a Seller."+
                             "\n\n  A 'Transaction Demo' is available on the homepage of PaperEC.com. If you "+
                             "have any questions, please click on \"Help\". You may also call us at "+
                             "+86-755-369-1610 during the working hours of Monday through Friday. "+
                             "\n\n  If you are the primary contact of your organization, and you would like "+
                             "to manage the PaperEC.com activities of others in your organization, "+
                             "please click 'My Preferences' to change the relevent settings."+
                             "\n\n  In addition, we will send you regular updates by email to keep you "+
                             "informed about our progress and new initiatives."+
                             
                             
                             
                             "\n\n\nBest Regards, "+            
                             "\n\nPaperEC.com."+ 
                             "\nTel:+86 755-369-1610, 3691613"+      
                             "\nFax:+86 755-320-1877"+
                             "\nEmail:members@paperec.com"+
                             "\n\nhttp://www.paperec.com";
                              
                               
                           inqu.setTitle(title);
                           inqu.setDetail(detial);
                           inqu.getSingleMess();  
                           
                           if (create_mail){
                              ExecThread exect1=exect.getInstance(arr[18],arr[19],time,2);  
              		      exect1.start(); 
              		   }
                             
                       }    
       %>
                    


                                     
           <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="left">
     <% if(st3.equals("ok")){   %>           
                  <td height="200" class="font9" >  Congratulations! You are now a Verified Member of PaperEC.com. 
    <br>Your Username and password can now be used at any time.
    <br>After entering your Username and password at www.paperec.com, you can log in 
    the member areas to browse and make deals. 
    <br>You can can do any of the following:
    <br>1) Login to the members only area to view PaperEC resources;
    <br>2) Post a "Request to Buy"; and,
    <br>3) Browse supply and demand information, engage in negotiations with 
       suppliers, and conclude online transactions.
    <br>
    <br>If you want to sell your products on PaperEC.com, you need to complete the
    Membership Application for Sellers. Please click on <a href="chenqingchhy_reg.jsp?user_id=<%=user_id%>">Apply to be a Seller</a> to continue.
     If you don't wish to apply to the Seller's Membership right now, you can log into My 
    PaperEC anytime and apply from the My Preference management panel.
    <br>An email of the information mentioned above will be sent to you by system 
    automatically, you will also be notified in "My Messages" of "My 
    PaperEC".
    <br>
    <br>If you have any questions or suggestions about the applying process, 
    please contact us at members@paperec.com, or fax at +86 755-320-1877.
                  
                  </td>
     <%  }else{    %>
                  <td height="200" class="font9"><%=st3%></td>
     <%   }   %>                      
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <a href="login.htm">Back to Home Page </a>
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

<html>
<head>
<title>我的纸网--PaperEC.com</title>
<SCRIPT LANGUAGE="JavaScript"><!--
 function reload(){
  window.history.back()
            }
// --></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "宋体"}
.font9 {  font-size: 14px; font-family: "宋体"; color: #000000}
.white10 {  font-size: 10pt; color: #FFFFFF; font-family: "宋体"}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; color: #000000; font-family: "宋体"}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr>
    <td width="159"> 
      <script language="JavaScript" src="../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:263px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
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
      </div></td>

<td valign="top"> 
 
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">


  <%@ page import="java.util.*, java.sql.*,java.io.*,postcenter.*" session="true" language="java"%> 
   <%    String arr[]=new String[43];
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
           int return_code=3;
           String user_id="";
           String time="";
           String detial="";
           String title="";
           arr[11]=request.getParameter("p_name");
           st1="select name from company_l where name='"+arr[11]+"' and lang_code='GB'";
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
                  <td height="200" class="font9">很抱歉!您的登录名已被使用,请改用其它名称!</td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="返回" ONCLICK="reload()">
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
                  <td height="200" class="font9">很抱歉!您所在公司已存在，不予注册!</td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="返回" ONCLICK="reload()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
                     
        <%     }else{  
                     myFind.disconn();
                     arr[1]="GB";arr[19]=request.getParameter("p_passwd");
                     arr[29]=request.getParameter("p_question");arr[28]=request.getParameter("p_answer");
                     arr[39]=request.getParameter("title");  
                     arr[31]=request.getParameter("p_first_name");arr[32]=request.getParameter("p_last_name");
                     arr[10]=request.getParameter("p_industry_id");arr[9]=request.getParameter("p_prod_focu_id");
                     arr[17]=request.getParameter("p_dept");arr[36]=request.getParameter("p_job_title");
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
                     arr[37]="";
                     arr[22]=arr[4];arr[23]=arr[5];     
                     arr[0]="Y";
                     arr[15]=""; arr[8]="";
     
                         arr[16]="";
                         arr[27]="";
                     if ((arr[42].equals("Y"))&&(arr[7].equals(""))){
                     	 arr[7] = arr[18] + "@mail.paperec.com";
                     	 arr[26] = arr[7];
                     	 create_mail=true;
                     }
                    	 
                     st3=myFind.getPreCall(arr);
                     //myFind.disconn();
                         
		
                     if(st3.equals("ok")){


                         st2="select user_id,to_char(sysdate,'yyyy-mm-dd hh:mi:ss') time from users where login='"+arr[18]+"'";
                         myFind.setSqlStc(st2);
                         ResultSet rs=myFind.getAllData();
                         if(rs.next()) 
                             user_id=rs.getString("user_id");
                             time = rs.getString("time");
                         myFind.disconn();         

                         if (arr[39].equals("G")) 
                             arr[39] = "博士";
                         else if (arr[39].equals("S")) 
                             arr[39] = "女士";
                         else 
                             arr[39] = "先生";
                         
                         title="欢迎您访问PaperEC.com";
                         
                         detial="尊敬的"+arr[32]+arr[39]+"："+
                             "\n\n    恭喜您成为PaperEC.com会员。"+
                             "\n\n    您的用户名是 " +arr[18]+ "。 您的用户名和密码现在已经生效。"+
                             "\n\n    请在PaperEC.com的主页，输入您的用户名及密码, 就可登录进入"+
                             "会员区域，进行浏览和交易。您现在拥有以下权利："+
                             "\n1）可以访问PaperEC.com上的会员区域，浏览会员才享有的资源。"+
                             "\n2）可以发布需求信息。"+
                             "\n3）可以浏览供应与需求信息。对检索到的供应信息，可与供应商进行"+
                             "报价、议价、接受、签约，进而完成整个交易活动。"+
                             "\n4）以上三项是完全免费的。"+
                             "\n\n    如果您需要在PaperEC.com上出售产品，须进一步申请为PaperEC"+
                             "的卖方会员。请登录进入“我的纸网”页面，点击个人资料管理上的设置"+
                             "按钮进入卖方会员资格申请页面。"+
                             "\n\n    我们的主页上提供了一部动态交易演示电影，能够使您快速掌握"+
                             "交易方法，请您花点时间观看。在交易过程中，如果您有不清楚的地"+
                             "方，可随时点击“获取帮助”进入帮助页面获得指导。当然在周一至"+
                             "周五的工作时间，您也可打电话给我们获取帮助。 Tel:755-3691610"+
                             "\n\n    若您是您所在公司相关部门的负责人，您的组织内还需要有其他"+
                             "成员也能在本网做交易，并且您希望能够管理他们在本网所作的交易，"+
                             "请访问“我的纸网”页面，点击浮动导航块上个人资料管理进行相关"+
                             "设置。"+
                             "\n\n    另外，我们还会定期地将本网一些最新内容通过Email发给您。"+                           
                             "\n\n\n    祝您愉快。"+            
                             "\n\n\n    PaperEC.com"+
                             "\n    Tel:755-3691610 3691613 "+          
                             "\n    Fax:755-3201877"+
                             "\n    Email:members@paperec.com"+
                             "\n\n    http://www.paperec.com";

                           inqu.setUser_id(user_id);    
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
                  <td height="200" class="font9">恭喜您注册成功，成为PaperEC.com 会员。
    <br>
    <br>您的用户名是 <%=arr[18]%> 。 您的用户名和密码现在已经生效。
    <br>
    <br>您现在拥有以下权利：
    <br>1）可以访问PaperEC.com上的会员区域，浏览会员才享有的资源。
    <br>2）可以发布需求信息。
    <br>3）可以浏览供应与需求信息。对检索到的供应信息，可与供应商进行报价、议价、接
       受、签约，进而完成整个交易活动。
    <br>4）以上三项是完全免费的。
    <br>
    <br><a href="login.htm">请点击这里</a>，输入您的用户名及密码, 就可登录进入会员区域，
    进行浏览和交易。
    <br>    
    <br>如果您需要在PaperEC.com上出售产品，须进一步申请为PaperEC的卖方会员。        
    手续同样的简单，请点击<a href="chenqingchhy_reg.jsp?user_id=<%=user_id%>">“申请成为卖方会员”</a>继续。若您不想即刻注册成为卖方会员，
    而是希望在以后需要的时候再进行注册，您可以随时登陆PaperEC.com进入“我的纸网”，
    从个人资料管理里进行卖方会员资格注册。
    <br>
    <br>对本页信息，系统会自动向您发出成功注册的Email确认信息, 您也可以从“我的纸网”
    页面上您的个人信息中心里看到。
    <br>
    <br>如果您对申请有任何疑问或建议，可以联系我们：members@paperec.com
    或发传真给我们：755-3201877
</td>
     <%   
          }else{    %>
                  <td height="200" class="font9"><%=st3%></td>
     <%   }   %>                      
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <a href="login.htm">返回主页</a>
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
                  <td height="200" class="font9"><p>服务器错误,稍候再试!<%=e.getMessage()%></p></td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="返回" ONCLICK="reload()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>          
             <%    }  %>
                   


   
    
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
          <td><img src="/images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="/images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
     
  </tr>
</table>
</body>
</html>

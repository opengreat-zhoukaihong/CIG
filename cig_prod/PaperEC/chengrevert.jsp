<%@ page language="java"%>  
<%@ page import="java.util.*, java.sql.*,java.io.*"%> 

<jsp:useBean id="beco" scope="page" class="postcenter.newRegister" />   
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
<%  String[] arr=new String[33];
    //String user_id=UserInfo.getUserId();
    String country=request.getParameter("country");    
    String state=request.getParameter("state");
    String city=request.getParameter("city");
    String user_id=request.getParameter("user_id");    
    arr[0]=user_id;arr[1]=request.getParameter("full_name");
    arr[2]=request.getParameter("employees");arr[3]=request.getParameter("revenue");
    arr[4]=request.getParameter("corp_f_name");arr[5]=request.getParameter("money_reg");  
    arr[6]=request.getParameter("business_id");arr[7]=request.getParameter("tax_id");
    arr[8]=request.getParameter("bank");arr[9]=request.getParameter("account");
    arr[10]=request.getParameter("iso");arr[11]=request.getParameter("url");
    arr[12]=request.getParameter("address1");
    arr[13]=country+"  "+state+"  "+city+" "+request.getParameter("address2");
    arr[14]=request.getParameter("postcode"); arr[15]=request.getParameter("fax");
    arr[16]=request.getParameter("tel");arr[17]=request.getParameter("email");
    arr[18]=request.getParameter("sell_prod_id");arr[32]="GB";
    for(int i=0;i<33;i++)if(arr[i]==null)arr[i]="";    
    String st3=beco.getBecomeS(arr);
    String title="";
    String detial="";  
                      
                     if(st3.equals("ok")){   
                         String m_title ="";
                         String last_name ="";
                         String st2="select title,last_name from users a,users_l b where a.user_id='"+user_id+"' and a.user_id=b.user_id and b.lang_code='GB'";
                         beco.setSqlStc(st2);
                         ResultSet rs=beco.getAllData();
                         if(rs.next()){ 
                             m_title = rs.getString("title");
                             last_name = rs.getString("last_name"); 
                         }
                         beco.disconn();         

                         if (m_title.equals("G")) 
                             m_title = "博士";
                         else if (m_title.equals("S")) 
                             m_title = "女士";
                         else 
                             m_title = "先生";
                                                 
                         title="恭喜您获得PaperEC.com卖方会员资格";
                         detial="尊敬的"+last_name+m_title+":"+
                                    "\n\n    恭喜您注册成为PaperEC.com的卖方会员。"+
                                    "\n\n    PaperEC.com已经为您进行了相关设置，作为卖方会员，您已经可以在"+
				    "PaperEC.com上出售您的产品。"+
				    "\n\n    作为卖方会员，您除了享有原有的会员权利外，还享有以下专有权利："+
				    "\n1）对准备在PaperEC.com上供应的产品建立资料库"+
				    "\n2）发布产品供应信息"+
				    "\n3）可对PaperEC.com上的需求信息发布相关产品供应信息。"+
				    "\n4）同有回应的买家进行议价、接受报价、成交签约等交易活动。"+
				    "\n5）只有在您跟买家成功达成交易后，您才须向PaperEC.com支付费用（详见会员协议）"+
				    "\n\n    为了您能方便的发布产品供应信息，PaperEC.com提供了一个方便的工具，"+
				    "--“我的产品”。在这里，您可建立您的产品资料库，包括产品中英文品牌名"+
				    "称、产地信息、产品类型、产品规格资料，等等。这样，以后您在发布产品供"+
				    "应信息的时候就可轻松发布。"+
				    "\n\n    在PaperEC.com上有两种出售浆纸产品的途径可供选择。一是发布新的产品"+
				    "供应信息供会员浏览。二是针对买家发布的相关需求信息专门发布您的供应信"+
				    "息。一旦有买家回应，PaperEC的消息通知系统能让您迅速得到通知。"+
				    "\n\n    如果您对交易过程有不清楚的地方，可观看PaperEC.com主页上的Flash交"+
				    "易演示电影来学习。也可随时点击“获取帮助”进入帮助页面获得指导。当然"+
				    "在周一至周五的工作时间，您也可打电话给我们获取帮助。"+
                                    "\n\n\n\n    祝您愉快。"+
                                    "\n\n\n    PaperEC.com"+
                                    "\n    PaperEC.com"+
                                    "\n    Tel:755-3691610 3691613"+
                                    "\n    Email:members@paperec.com"+   
                                    "\n\n    http://www.paperec.com"; 
                                    
                         inqu.setUser_id(user_id);                                    
                         inqu.setTitle(title);
                         inqu.setDetail(detial);
                         inqu.getSingleMess(); 
                     }     
%>

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


  
                                     
           <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="left">
     <% if(st3.equals("ok")){   %>           
                  <td height="200" class="font9"> 
                  恭喜您注册成为PaperEC.com的卖方会员。现在您已经可以登录PaperEC.com<br>
                  交易您的产品。PaperEC.com热忱欢迎有诚信的厂商到PaperEC上销售产品。<br>
                  PaperEC.com会不断地提供更加个性化服务，来满足您日益增长的商务需求。
                  </td>
     <%  }else{    %>
                  <td height="200" class="font9"><%=st3%></td>
     <%   }   %>                      
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <a href="login.htm">返 回</a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
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
<% beco.destroy();  %>        
<% inqu.getDestroy(); %>
</jsp:useBean>


<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="login.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  boolean isPermitted;
  String userID;
  String funcId;

  funcId = "fnMemberMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<%@ page  language="java" %>
<jsp:useBean id="membus" scope="page" class="member.MemberUsers" /> 
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
<jsp:setProperty name="membus" property="*" />
<%  
   String content="";int ret=5; 
   String user_id=request.getParameter("user_id");
   String lang_code=request.getParameter("lang_code");
   String[] submit=new String[6];
   String login="";String title="";String detial="";   
  if(!lang_code.equals("mimasz")){ 
        
        
        submit[0]=request.getParameter("firstname");
        submit[1]=request.getParameter("lastname");
        submit[2]=request.getParameter("address1");
        submit[3]=request.getParameter("address2");
        submit[4]=request.getParameter("priviledge");
        submit[5]=request.getParameter("credit");
        ret=membus.getPriviledge(submit[4]);  
        login=membus.getLogin();
        content=membus.getSubmit(submit);
        if(content.equals("1")){
          
             if(ret!=0){
               inqu.setUser_id(user_id);
               
               if(inqu.getUserLang().equals("GB")){
                
                  if(ret==1){
                  
                     title="您已获核准成为中国纸网正式会员";
                    detial="尊敬的用户："+
                           "\n\n    用户名："+login+
                           "\n\n    恭喜您成为中国纸网正式会员。我们已为您开通了交易功能。请点"+
                           "击http://www.paperec.com访问我们的主页，输入您的用户名及密码登"+
                           "录进入会员区域，进行您的交易活动。"+
                           "\n\n    您是作为您组织内的主用户注册的，若你们组织内还需要有其他成"+
                           "员也能在本网做交易，您必须告诉他们您的主用户名，以便他们在本网"+
                           "注册的时候填入，本网验证无误后才会赋予他们交易权。"+
                           "周五的工作时间，您也可打电话给我们获取帮助。 Tel:755-3691610"+
                           "\n\n    作为主用户，您可以享有我们赠送的一个免费电子邮箱。帐号为:"+
                           login+"@mail.paperec.com    密码与您的"+
                           "会员帐号密码相同。这个帐号现已开通。登录我们网站进入会员区域"+
                           "'我的纸网'页面，从右方电子邮箱访问入口进入。"+
                           "\n\n    我们的主页上提供了一部动态交易演示电影，能够使您快速掌握"+
                           "交易方法，请您花点时间观看。在交易过程中，如果您有不清楚的地"+
                           "方，可随时点击'获取帮助'进入帮助页面获得指导。当然在周一至"+
                           "周五的工作时间，您也可打电话给我们获取帮助。 Tel:755-3691610"+                           
                           "\n\n    祝您愉快。"+            
                           "\n\n\n    中国纸网"+
                           "\n    会员资格审核小组 "+          
                           "\n\n    http://www.paperec.com";
                  }else if(ret==2){
                  
                    title="您已获核准具有中国纸网交易资格";
                   detial="尊敬的用户："+           
                          "\n\n    用户名："+login+
                          "\n\n    经过验证，您已获核准具有中国纸网交易资格。我们已为您开通了"+
                          "交易功能。请点击http://www.paperec.com访问我们的主页，输入您的"+
                          "用户名及密码登录进入会员区域，进行您的交易活动。"+
                          "\n\n    我们的主页上提供了一部动态交易演示电影，能够使您快速掌握"+
                          "交易方法，请您花点时间观看。在交易过程中，如果您有不清楚的地"+
                          "方，可随时点击“获取帮助”进入帮助页面获得指导。当然在周一至"+
                          "周五的工作时间，您也可打电话给我们获取帮助。 Tel:755-3691610"+                              
                          "\n\n    祝您愉快。"+            
                          "\n\n\n    中国纸网"+
                          "\n    会员资格审核小组 "+          
                          "\n\n    http://www.paperec.com";
                  }
                  
             }else{
                  if(ret==1){
                         title="Congratulations! You are now a Verified Member of PaperEC.com";
                    detial="Dear Member："+
                           "\n\n  User Name："+login+
                           "\n\n  Congratulations! You are now a Verified Member of "+
                           "PaperEC.com. You are now qualified to engage in transactions on "+
                           "PaperEC.com.  Using your user name and password, you can log "+
                           "into the members area of PaperEC.com to begin your online transactions."+
                           "\n\n  You are registered as the primary contact within your "+
                           "organization, other persons in your organization who wish to "+
                           "register on PaperEC.com can provide your user name to be "+
                           "qualified to engage in transactions."+
                           "\n\n  As the primary contact, you are provided a free email box. Your email address is "+
                           login+"@paperec.com. The password for your "+
                           "email is the same used to your membership account. "+
                           "\n\n  A 'Transaction Demo' is available on the homepage of "+
                           "PaperEC.com. If you have any questions, Please click on 'Help'."+
                           "You may also call us at +86-755-369-1610 during the working "+
                           "hours of Monday through Friday."+                           
                           "\n\n\nBest Regards, "+            
                           "\n\nPaperEC.com."+       
                           "\n\nhttp://www.paperec.com";
                  }else if(ret==2){
                    title="Congratulations! You are now qualified to engage in transactions on PaperEC.com";
                   detial="Dear Member："+           
                          "\n\n  User Name:"+login+
                          "\n\n  Through the system verification, you are qualified to engage "+
                          "in transactions on PaperEC.com. Your account has already been "+
                          "activated. Using your user name and password, you can log into "+
                          "the members area of PaperEC.com to begin your online transactions."+
                          "\n\n  A 'Transaction Demo' is available on the homepage of "+
                          "PaperEC.com. If you have any questions, Please click on 'Help'."+
                          "You may also call us at +86-755-369-1610 during the working "+
                          " hours of Monday through Friday. "+                              
                          "\n\n\nBest Regards, "+            
                          "\n\n\nPaperEC.com."+                                
                          "\n\nhttp://www.paperec.com";
                  }
             }                          
                            
           inqu.setTitle(title);
           inqu.setDetail (detial);
           inqu.getSingleMess();          
          }
           content="数据修改成功！";  
        }else{
           content="数据库有误，请稍候再试！";
        }   
    }else{
       login=request.getParameter("login");
     }  
%>

<script language="javascript">
   function back(){
    window.history.back()
    }
</script>   
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中国纸网后台管理系统</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "宋体"; font-size: 9pt}
.title12 {  font-family: "宋体"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "宋体"; text-decoration: underline}
a:visited {  font-family: "宋体"; text-decoration: underline}
a:active {  font-family: "宋体"; text-decoration: underline}
a:hover {  font-family: "宋体"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675"> 
  <tr>    
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <form method="post" action="">
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" height="300" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr align="center"> 
        <%  if(lang_code.equals("mimasz")){ %>
            <td class="title12" height="249"><%=membus.getMimaModi(login)%></td>
        <%  }else{ %>  
            <td class="title12" height="249"><%=content%></td>
        <%   }  %>  
          </tr>
          <tr align="center"> 
            <td class="title12">
            <a href="" onclick="javascript:back()">  <input type="image" border="0" name="imageField" src="../images/back.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
        <br>
        <br>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>
</jsp:useBean>
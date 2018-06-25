
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

<%@ page import="java.net.*,java.io.*" language="java" %>
<jsp:useBean id="memb" scope="page" class="member.MemberBG" /> 
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
<jsp:setProperty name="memb" property="company_id" />
<%  String lang_code=request.getParameter("lang_code");
    String lop="";String user_id="";String login="";
    String title="";String detial="";
    memb.setLang_code("GB");
    String status=request.getParameter("trans");  
    if(status.equals("hez")){
       int in=memb.getModiStatus("Y");
       user_id=memb.getPri_user_id();
       login=memb.getLogin();
       
       if(in>0){
         inqu.setUser_id(user_id);        
         if(inqu.getUserLang().equals("GB")){
         
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
           }else{
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
          }                               
           inqu.setTitle(title);
           inqu.setDetail (detial);
           inqu.getSingleMess();                  
                           
       }
       lop=memb.getExec();      
    }   
    if(status.equals("juj"))memb.getModiStatus("N");        
    String[] temp=memb.getMoCompany();
    String[] company_cn=memb.getCompany_l();
    String[] company_en;
    String[][] users;      
    if(lang_code.equals("GB")){
       company_en=company_cn;       
       users=memb.getAllUser();
     }else{
       memb.setLang_code(lang_code);
       company_en=memb.getCompany_l();
       users=memb.getAllUser();
      }  
    
    if(temp[12].equals("S")){ temp[12]="卖方";
     }else{temp[12]="买方";}
%>

<SCRIPT language=JavaScript>
function changeValue(e){
  var fo = document.fo2;  
  fo.lang_code.value = e;
  document.fo1.lang_code.value = e;
  fo.submit();
  }
 function changeTrans(e){
   var fo = document.fo1;
   fo.trans.value = e;
   fo.submit(); 
 } 
</SCRIPT>
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

<body name="bo" bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr> 
    
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      
        <table name="tab" width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
          
            <td colspan="4" class="title12">
            <form name="fo2" method="post" action="membercompany_dedail.jsp" >会员公司详细信息：            
             <img src="../images/space.gif" width="150" height="1">
             <input type="hidden" name="company_id" value=<%=company_cn[0]%>>
             <input type="hidden" name="lang_code" >
             <input type="hidden" name="trans">
             <a href="#" onclick="javascipt:changeValue('GB')"><input type="image" border="0" src="../images/chinese.gif" width="68" height="26"></a>
             <a href="#" onclick="javascipt:changeValue('EN')"><input type="image" border="0" src="../images/english.gif" width="68" height="26"></a>            
            </form>
            </td>
          </tr>
          <tr> 
            <td width="124">公司ID：<%=company_cn[0]%></td>
            <td width="114">语言代码：<%=company_cn[1]%></td>
            <td width="140">卖方/买方：<%=temp[12]%></td>
            <td width="130">公司名称：<%=company_cn[2]%></td>
          </tr>
          <tr> 
            <td width="124">国家：<%=temp[1]%></td>
            <td width="114">省份：<%=temp[2]%></td>
            <td width="140">城市：<%=temp[3]%></td>
            <td width="130">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2">地址1：<%=company_cn[3]%></td>
            <td colspan="2">地址2：<%=company_cn[4]%></td>
          </tr>
          <tr> 
            <td width="124">邮编：<%=temp[4]%></td>
            <td width="114">电话：<%=temp[5]%></td>
            <td width="140">传真：<%=temp[6]%></td>
            <td width="130">email：<%=temp[7]%></td>
          </tr>
          <tr> 
            <td width="124">行业：<%=temp[11]%></td>
            <td width="114">主营产品：<%=temp[10]%></td>
            <td width="140">开户银行：<%=company_cn[5]%></td>
            <td width="130">帐号：<%=temp[9]%></td>
          </tr>
          <tr> 
            <td width="124">主要联系人ID：<%=temp[8]%></td>
            <td colspan="2">主要联系人用户名：<%=temp[0]%></td>
            <td width="130">状态：<%=temp[13]%></td>
          </tr>
       <form  name="fo1" method="post" action="transfer.jsp"> 
          <tr> 
            <td colspan="4"> 
      <% 
          if(temp[12].equals("买方")){ 
       %>   
              <input type="radio" name="buy_sale_flag" value="B" checked>
              买方 
              <input type="radio" name="buy_sale_flag" value="S">
              卖方
       <%
          }else{
       %>   
              <input type="radio" name="buy_sale_flag" value="B">
              买方 
              <input type="radio" name="buy_sale_flag" value="S" checked>
              卖方
       <%
           }
        %>       
              　公司名称： 
              <input type="text" name="name" value="<%=company_en[2]%>">
            </td>
          </tr>
          <tr> 
            <td colspan="4">地址1： 
              <input type="text" name="address1" value="<%=company_en[3]%>">
              地址2： 
              <input type="text" name="address2" value="<%=company_en[4]%>">
            </td>
          </tr>
          <tr> 
            <td colspan="4">开户银行： 
              <input type="text" name="bank" value="<%=company_en[5]%>">
              主要联系人： 
              <select name="pri_user_id">
    <% for(int i=0; i<users.length; i++){
	   if(users[i][0].equals(temp[8])){%>
		 <option value=<%=users[i][0]%> selected><%=users[i][1]%></option>
	 <%  }else{   %> 
                 <option value=<%=users[i][0]%>><%=users[i][1]%></option>
	<%      }  }%>            
              </select>
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="4"> 
              <input type="hidden" name="old_user_id" value=<%=temp[8]%>>
              <input type="hidden" name="trans" >
              <input type="hidden" name="lang_code" value=<%=lang_code%>>
              <input type="hidden" name="company_id" value=<%=company_cn[0]%>>
              <a href="" onclick="javascript:changeTrans('subm')"><input type="image" border="0" name="imageField" src="../images/submit.gif" width="68" height="26"></a>
              <a href="" onclick="javascript:changeTrans('reset')"><input type="image" border="0" name="imageField2" src="../images/cancle.gif" width="68" height="26"></a>
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="4"> 
              <a href="" onclick="javascript:changeTrans('hez')"><input type="image" border="0" name="imageField3" src="../images/hezhunchwhy.gif" width="90" height="23"></a>
              <a href="" onclick="javascript:changeTrans('juj')"><input type="image" border="0" name="imageField4" src="../images/jujuechy.gif" width="90" height="23"></a>
              <a href="" onclick="javascript:changeTrans('cak')"><input type="image" border="0" name="imageField5" src="../images/check.gif" width="90" height="23"></a>
              <a href="" onclick="javascript:changeTrans('cap')"><input type="image" border="0" name="imageField6" src="../images/check2.gif" width="90" height="23"></a>
              <a href="" onclick="javascript:changeTrans('gog')"><input type="image" border="0" name="imageField7" src="../images/check3.gif" width="90" height="23"></a>
            </td>
          </tr>
         </form> 
        </table>  <br>
        <br>
     
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>
<% memb.getDestroy();%>
</jsp:useBean>
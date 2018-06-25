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


<%@ page language="java" %>
<jsp:useBean id="membus" scope="page" class="member.MemberUsers" />
<jsp:setProperty name="membus" property="user_id" />
<jsp:setProperty name="membus" property="lang_code" />
<% 
  try{
    int id=0;
    String[] user_l=membus.getUsers_l();
    String[] compuser=null;
    String[] user_en;
    String[][] credit;
    String lang_code=request.getParameter("lang_code"); 
    String st=request.getParameter("act");
    
    compuser=membus.getDetial();
     
    
    if(lang_code.equals("GB")){            
       user_en=user_l;
       credit=membus.getAllCredit();
     }else {
       membus.setLang_code(lang_code);
       user_en=membus.getUsers_l();
       credit=membus.getAllCredit();
      }  
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
<html><!-- #BeginTemplate "/Templates/backm_paperec.dwt" -->
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
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>
      
        <table width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr>            
          <form name="fo2" method="post" action="memberusers_detail.jsp" >会员用户详细信息：            
             <img src="../images/space.gif" width="150" height="1">
             <input type="hidden" name="act" value=<%=st%>> 
             <input type="hidden" name="id" value="<%=id%>" >
             <input type="hidden" name="user_id" value=<%=compuser[0]%>>
             <input type="hidden" name="lang_code" >
             <a href="#" onclick="javascipt:changeValue('GB')"><input type="image" border="0" src="../images/chinese.gif" width="68" height="26"></a>
             <a href="#" onclick="javascipt:changeValue('EN')"><input type="image" border="0" src="../images/english.gif" width="68" height="26"></a>            
            </form>
          </tr>
          <tr> 
            <td width="124">用户ID：<%=compuser[0]%></td>
            <td width="114">用户名：<%=compuser[18]%></td>
            <td width="140">姓：<%=user_l[2]%></td>
            <td width="130">名：<%=user_l[3]%></td>
          </tr>
          <tr> 
            <td width="124">国家：<%=compuser[2]%></td>
            <td width="114">省份：<%=compuser[3]%></td>
            <td width="140">城市：<%=compuser[4]%></td>
            <td width="130">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2">地址1：<%=user_l[4]%></td>
            <td colspan="2">地址2：<%=user_l[5]%></td>
          </tr>
          <tr> 
            <td width="124">邮编：<%=compuser[5]%></td>
            <td width="114">电话：<%=compuser[6]%></td>
            <td width="140">传真：<%=compuser[7]%></td>
            <td width="130">email：<%=compuser[9]%></td>
          </tr>
          <tr> 
            <td width="124">部门：<%=compuser[14]%></td>
            <td width="114">职务：<%=compuser[15]%></td>
            <td width="140">工作职能：<%=compuser[13]%></td>
            <td width="130">是否有报价权：<%=compuser[10]%></td>
          </tr>
          <tr> 
            <td width="124">是否是主要联系人：<%=compuser[11]%></td>
            <td colspan="2">注册时间：<%=compuser[16]%></td>
            <td width="130">信用度：<%=compuser[17]%></td>
          </tr>
          <form name="fo1" method="post" action="usertrans.jsp">     
          <tr> 
            <td colspan="4"> 姓： 
              <input type="text" name="lastname" size="8" value="<%=user_en[3]%>">
              名： 
              <input type="text" name="firstname" size="8" value="<%=user_en[2]%>">
            </td>
          </tr>
          <tr> 
            <td colspan="4">地址1： 
              <input type="text" name="address1" value="<%=user_en[4]%>">
              地址2： 
              <input type="text" name="address2" value="<%=user_en[5]%>">
            </td>
          </tr>
     
          <tr> 
           <td colspan="4">
    <% if(compuser[10].equals("Y")){ %>
            是否有报价权： 是 
              <input type="radio" name="priviledge" value="Y" checked>
              否 
              <input type="radio" name="priviledge" value="N" >
    <%  }else{  %>      
            是否有报价权： 是 
              <input type="radio" name="priviledge" value="Y">
              否 
              <input type="radio" name="priviledge" value="N" checked>
    <%  }    %>          　　
              信用度 
              <select name="credit">
   <% for(int i=0; i<credit.length; i++){
	   if(credit[i][0].equals(compuser[17])){%>
		 <option value=<%=credit[i][0]%> selected><%=credit[i][1]%></option>
	 <%  }else{   %> 
                 <option value=<%=credit[i][0]%>><%=credit[i][1]%></option>
	<%      }  }%>                          
              </select>
            </td>
          </tr>
          <tr align="center"> 
          <td colspan="4">               
              <input type="hidden" name="trans" >
              <input type="hidden" name="login" value=<%=compuser[18]%> >
              <input type="hidden" name="id" value=<%=id%>>
              <input type="hidden" name="act" value=<%=st%>> 
              <input type="hidden" name="user_id" value=<%=compuser[0]%>>              
              <input type="hidden" name="lang_code" value=<%=lang_code%>>              
              <a href="" onclick="javascript:changeTrans('subm')"><input type="image" border="0" name="imageField" src="../images/submit.gif" width="68" height="26"></a>
              <a href="" onclick="javascript:changeTrans('reset')"><input type="image" border="0" name="imageField2" src="../images/cancle.gif" width="68" height="26"></a>
              <a href="" onclick="javascript:changeTrans('mimasz')"><input type="image" border="0" name="imageField3" src="../images/mimacz.gif" width="68" height="26"></a>
            </td>            
          </tr>
         </form> 
        </table>
        <br>
        <br>
      
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>
<% }catch(Exception e){} %>
</jsp:useBean>

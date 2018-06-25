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

  funcId = "fnBookMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<jsp:useBean id="pro" scope="page" class="postcenter.BidList" />
<jsp:setProperty name="pro" property="bid_id" />
<%       
     pro.setLangcode("GB"); 
     pro.setUser_id("1");   
     String back=pro.getProced();
                      %>  
 <script language="javascript">  
      function winclose(){
         window.close()            
            }  
</script>             
<html><!-- #BeginTemplate "/Templates/paperec_templares.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none; color: #000000; font-family: "宋体"}
a:visited {  text-decoration: none; color: #000000; font-family: "宋体"}
a:active {  text-decoration: none; color: #000000; font-family: "宋体"}
a:hover {  color: #330099; text-decoration: underline; font-family: "宋体"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "宋体"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a>      
          <tr bgcolor="#E6EDFB"> 
                  <td colspan="3" height="26"> </td>
                </tr>
                <tr valign="top"> 
                  <td colspan="3" bgcolor="#E6EDFB"> 
                    <table width="600" border="0" cellspacing="0" cellpadding="0">
                    
                      <tr>                    
                        <td>
                          <table width="600" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left">
                        
                            <tr bgcolor="#E6EDFB"> 
                         
                              <td class="dan10" height="22">  <%=back%> </td>
             
                              <td class="dan10" height="22"> </td>
                            </tr>
                          
                            
                            <tr bgcolor="#E6EDFB" align="center"> 
                  <td colspan="3" class="big" height="25"> <font color="#FFFFFF"><b> 
                              
                    <input type="button" name="Submit2" value="关 闭" onClick="winclose();">
                  
                    </b></font></td>
                </tr>
                          </table>
                        </td>
                      </tr>
               
                   
                    
                    </table>
                  </td>
                </tr>
               </body>
<!-- #EndTemplate --></html> 
   
<%    pro.getDestroy(); %>
</jsp:useBean>
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

  funcId = "fnContractMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<%@ page  %>
<jsp:useBean id="pro" scope="page" class="postcenter.BidList" />
<jsp:setProperty name="pro" property="bid_id" />
<%  
     String bid_id=request.getParameter("bid_id");
     String numb="";String dw=""; String resu="";   
     pro.setLangcode("GB");    
     String[] str=new String[19];
     str=pro.getAllResult(); 
     String[] title=pro.getTitle();
     if(title[1].equals("")||title[3]==null)str[13]="";
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
                     <form action="backbid.jsp" method="post"> 
                      <tr>                    
                        <td>
                          <table width="600" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left">
                            <tr bgcolor="#E6EDFB"> 
                         
                              <td class="dan10" height="22">  数 量：<%=str[6]%>  &nbsp;&nbsp;单 位： <%=str[7]%> </td>
             
                              <td class="dan10" height="22">  报 价：<%=str[8]%><%=str[9]%>/<%=str[7]%>  </td>
                            </tr>
                            
                              <td class="dan10" height="22" >价格条款：<%=str[10]%>  </td>    
                               <td class="dan10" height="22"><%=title[0]%><%=str[11]%>  </td>                              
                            </tr>
                            <tr bgcolor="#E6EDFB">     
                  
                              <td class="dan10" height="22">支付方式：<%=str[12]%>   </td>
                              <td class="dan10" height="22"><%=title[1]%><%=str[13]%> &nbsp;&nbsp;<%=title[2] %><%=str[14] %>  </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22" width="291">报价开始时间：<%=str[15]%> </td>
                              
                              <td class="dan10" height="22" width="301" bgcolor="#E6EDFB">报价到期时间：<%=str[16]%>  </td>
                    
                            </tr>
                            <tr>
                             <td class="dan10" height="22" width="291"><%=title[3]%><%=str[18]%></td>
                              <td class="dan10" height="22" width="291"> </td>
                            </tr>
                            <tr bgcolor="#E6EDFB" align="center"> 
                  <td colspan="3" class="big" height="25"> <font color="#FFFFFF"><b> 
                    <input type="hidden" name="bid_id" value="<%=bid_id%>" >
                 <% if(str[5].equals("6")){ %>   
                    <input type="submit" name="Submit1" value="核 准" >                  
                 <%    }    %>   
                    <input type="button" name="Submit2" value="关 闭" onClick="winclose();">
                  
                    </b></font></td>
                   </tr>
                          </table>
                        </td>
                      </tr>
               
                   
                     </form>
                    </table>
                  </td>
                </tr>
               </body>
<!-- #EndTemplate --></html> 
   
<%    pro.getDestroy(); %>
</jsp:useBean>
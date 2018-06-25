<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "宋体"}
        A:visited {text-decoration: none; font-family: "宋体"}
        A:active {text-decoration: none; font-family: "宋体"}
        A:hover {text-decoration: underline; color: #FFCC33}
-->
</style>
</head>



<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnSysMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<jsp:useBean id="Comp" scope="page" class="com.cnbooking.bst.Comp" /> 
<jsp:setProperty name="Comp" property="compId"/>
<jsp:setProperty name="Comp" property="langCode"/>

<%
    String comp_id = request.getParameter("compId");
    String lang_code = request.getParameter("langCode");
    
    String operator_id = UserInfo.getUsername();
    String tel="";
    String fax="";
    String email="";
    String name="";
    String address="";

    Comp.selectComp();
    
    tel = Comp.getTel();
    fax = Comp.getFax();
    email = Comp.getEmail();
    name = Comp.getName(); 
    address =  Comp.getAddress();
     
        
%>


<SCRIPT LANGUAGE="Javascript">
        
    function updateSubmit(){  
        var mf=document.nameEditForm;
	mf.action.value = "update";
        
      	mf.submit();


     }
     

</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" -->
      <form name="nameEditForm" method="post" action="compList.jsp">
      <input type="HIDDEN" name="action" value="">
      <input type="HIDDEN" name="compId" value=<%=comp_id%>>
      <input type="HIDDEN" name="langCode" value=<%=lang_code%>>
      <input type="HIDDEN" name="operatorId" value=<%=operator_id%>>
        <br>
        <br>
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="font12">
            分公司编辑：<%=comp_id%>:<%=lang_code%>
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">名称： 
              <input type="text" name="name" value="<%=name%>" size="40">
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">电话： 
              <input type="text" name="tel" value="<%=tel%>" size="40">
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">传真： 
              <input type="text" name="fax" value="<%=fax%>" size="40">
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">Email： 
              <input type="text" name="email" value="<%=email%>" size="40">
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">地址： 
              <input type="text" name="address" value="<%=address%>" size="40">
            </td>
          </tr>                    
          <tr align="center" class="font9"> 
            <td>
              <a href="#" onClick="javascript:updateSubmit()"><input type="image" border="0" name="imageField" src="/images/botton_update.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

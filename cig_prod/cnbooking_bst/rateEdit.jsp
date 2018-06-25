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

<jsp:useBean id="Rate" scope="page" class="com.cnbooking.bst.Rate" /> 
<jsp:setProperty name="Rate" property="fromCurr"/>
<jsp:setProperty name="Rate" property="toCurr"/>

<%
    String from_curr = request.getParameter("fromCurr");
    String to_curr = request.getParameter("toCurr");
    
    String operator_id = UserInfo.getUsername();
    String rate="";
    String descr="";

    Rate.selectRate();
    
    rate = Rate.getRate(); 
    descr =  Rate.getDescr();
     
        
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
      <form name="nameEditForm" method="post" action="rateList.jsp">
      <input type="HIDDEN" name="action" value="">
      <input type="HIDDEN" name="fromCurr" value=<%=from_curr%>>
      <input type="HIDDEN" name="toCurr" value=<%=to_curr%>>
      <input type="HIDDEN" name="operatorId" value=<%=operator_id%>>
        <br>
        <br>
        <table width="300" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="font12">
            汇率编辑：<%=from_curr%>:<%=to_curr%>
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">汇率： 
              <input type="text" name="rate" value="<%=rate%>">
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">描述： 
              <input type="text" name="descr" value="<%=descr%>">
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

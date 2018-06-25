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

<jsp:useBean id="StarList" scope="page" class="com.cnbooking.bst.StarList" /> 

<jsp:useBean id="Star" scope="page" class="com.cnbooking.bst.Star" />
<jsp:setProperty name="Star" property="action"/> 
<jsp:setProperty name="Star" property="id"/>
<jsp:setProperty name="Star" property="langCode"/>
<jsp:setProperty name="Star" property="rate"/>
<jsp:setProperty name="Star" property="name"/>
<jsp:setProperty name="Star" property="descr"/>
<jsp:setProperty name="Star" property="operatorId"/>

<%
   int star_count;
   String[][] star_list;
   String act= request.getParameter("action");
   
   String operator_id = UserInfo.getUsername();
   Star.setOperatorId(operator_id);
   
   
   Star.initRate();
   
   StarList.retriveStarList();
   star_count = StarList.getStarCount();
   star_list = StarList.getStarList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.starForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
</SCRIPT>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="starForm" method="post" action="starList.jsp">
      
        <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="6" class="font12" height="33">星级列表：
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><b>星级ID</b></td>
            <td width="60" class="font9"><b>语言代码</b></td>
            <td width="120" class="font9"><b>星级名</b></td>
            <td width="100" class="font9"><b>描述</b></td>
            <td width="54" class="font9">星级因子</td>
            <td width="54" class="font9">&nbsp;</td>
          </tr>
          <%
            if (star_count>0){
              for (int i=0;i<star_count;i++){
          %>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><%=star_list[i][0]%></td>
            <td width="60" class="font9"><%=star_list[i][1]%></td>
            <td width="120" class="font9"><%=star_list[i][3]%></td>
            <td width="100" class="font9"><%=star_list[i][4]%></td>
            <td width="54" class="font9"><%=star_list[i][2]%></td>
            <td width="54" class="font9"><a href="starEdit.jsp?action=update&id=<%=star_list[i][0]%>&langCode=<%=star_list[i][1]%>" class="font9">编辑</a></td>
          </tr>
          <%  }
            }
          %>
        </table>
        <br>
        <br>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

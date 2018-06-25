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

<jsp:useBean id="CompList" scope="page" class="com.cnbooking.bst.CompList" /> 

<jsp:useBean id="Comp" scope="page" class="com.cnbooking.bst.Comp" />
<jsp:setProperty name="Comp" property="action"/> 
<jsp:setProperty name="Comp" property="compId"/>
<jsp:setProperty name="Comp" property="langCode"/>
<jsp:setProperty name="Comp" property="tel"/>
<jsp:setProperty name="Comp" property="fax"/>
<jsp:setProperty name="Comp" property="email"/>
<jsp:setProperty name="Comp" property="name"/>
<jsp:setProperty name="Comp" property="address"/>
<jsp:setProperty name="Comp" property="operatorId"/>

<%
   int comp_count;
   String[][] comp_list;
   String act= request.getParameter("action");
   
   String operator_id = UserInfo.getUsername();
   Comp.setOperatorId(operator_id);
   
   
   Comp.initComp();
   
   CompList.retriveCompList();
   comp_count = CompList.getCompCount();
   comp_list = CompList.getCompList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.compForm;
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
      <form name="compForm" method="post" action="compList.jsp">
            
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="8" class="font12" height="33">各地公司列表：
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr align="center" class="font9"> 
            <td width="50" class="font9"><b>ID</b></td>
            <td width="100" class="font9"><b>语言代码</b></td>
            <td width="100" class="font9"><b>公司名</b></td>
            <td width="50" class="font9"><b>电话</b></td>
            <td width="50" class="font9">传真</td>
            <td width="50" class="font9">Email</td>
            <td width="150" class="font9">地址</td>
            <td width="50" class="font9">&nbsp;</td>
          </tr>
          <%
            if (comp_count>0){
              for (int i=0;i<comp_count;i++){
          %>
          <tr align="center" class="font9"> 
            <td width="50" class="font9"><%=comp_list[i][0]%></td>
            <td width="100" class="font9"><%=comp_list[i][1]%></td>
            <td width="100" class="font9"><%=comp_list[i][2]%></td>
            <td width="50" class="font9"><%=comp_list[i][3]%></td>
            <td width="50" class="font9"><%=comp_list[i][4]%></td>
            <td width="50" class="font9"><%=comp_list[i][5]%></td>
            <td width="150" class="font9"><%=comp_list[i][6]%></td>
            <td width="50" class="font9"><a href="compEdit.jsp?action=update&compId=<%=comp_list[i][0]%>&langCode=<%=comp_list[i][1]%>" class="font9">编辑</a></td>
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

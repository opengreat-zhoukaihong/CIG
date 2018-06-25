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

  funcID = "fnCityMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<jsp:useBean id="SystemParaList" scope="page" class="com.cnbooking.bst.SystemParaList" /> 
<jsp:setProperty name="SystemParaList" property="id"/>

<jsp:useBean id="SystemPara" scope="page" class="com.cnbooking.bst.SystemPara" /> 
<jsp:setProperty name="SystemPara" property="id"/>
<jsp:setProperty name="SystemPara" property="action"/>
<jsp:setProperty name="SystemPara" property="code"/>
<jsp:setProperty name="SystemPara" property="langCode"/>
<jsp:setProperty name="SystemPara" property="strValue"/>
<jsp:setProperty name="SystemPara" property="descr"/>
<jsp:setProperty name="SystemPara" property="operatorId"/>

<%
   int para_count;
   String[][] para_list;
   String id = request.getParameter("id");
   String para_name="币种";
   String act= request.getParameter("action");
   
   String operator_id = UserInfo.getUsername();
   SystemPara.setOperatorId(operator_id);
   
   if (act.equals("add")){
      if (!SystemPara.checkAddCond()){
%>
	<jsp:forward page="inform.jsp?info=有重复的参数，请检查后再录入！" />
	</jsp:forward>  
<%    }
   }
   
   SystemPara.initPara();
   
   SystemParaList.retriveParaList();
   para_count = SystemParaList.getParaCount();
   para_list = SystemParaList.getParaList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.paraForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("若删除该参数，将会造成已经使用该参数的信息无法显示。你确定删除此参数吗?")

    }
</SCRIPT>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="paraForm" method="post" action="xitongcslb.jsp">
      
      <input type="HIDDEN" name="id" value=<%=id%>>
      <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="5" class="font12" height="33">参数列表：
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><b>参数代码</b></td>
            <td width="60" class="font9"><b>语言代码</b></td>
            <td width="120" class="font9"><b>参数内容</b></td>
            <td width="200" class="font9"><b>参数描述</b></td>
            <td width="54" class="font9">&nbsp;</td>
          </tr>
          <%
            if (para_count>0){
              for (int i=0;i<para_count;i++){
          %>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><a href="paraedit.jsp?action=update&id=<%=id%>&code=<%=para_list[i][0]%>&langCode=<%=para_list[i][1]%>" class="font9"><%=para_list[i][0]%></a></td>
            <td width="60" class="font9"><%=para_list[i][1]%></td>
            <td width="120" class="font9"><%=para_list[i][2]%></td>
            <td width="200" class="font9"><%=para_list[i][3]%></td>
            <td width="54" class="font9"><a href="xitongcslb.jsp?action=delete&id=<%=id%>&code=<%=para_list[i][0]%>&langCode=<%=para_list[i][1]%>" onClick="return confirmDelete()" class="font9">删除</a></td>
          </tr>
          <%  }
            }
          %>
          <tr align="center" class="font9"> 
            <td colspan="8"> 
               参数代码
               <input type="text" name="code" size="8">
               语言代码
              <select name="langCode">
              <option value=GB selected> 中文 </option>
              <option value=EN> 英文 </option>
              </select>
              参数内容 
              <input type="text" name="strValue" size="10">
	      参数描述 
              <input type="text" name="descr" size="10">              
              <a href="#" onClick="javascript:addSubmit()"><input type="image" border="0" name="imageField" src="/images/botton_add.gif" width="68" height="26"></a>
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
<!-- #EndTemplate --></html>

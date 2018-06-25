
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
<jsp:setProperty name="membus" property="lang_code" value="GB" />
<%
  String[][] credit=membus.getAllCredit();
  String[] time=membus.getTime();
%>

 <script language="javascript">  
 
function validDateField(object){
	var value = ptrim(object.value);

	if ( !CheckDate(value))
	{
	    alert("输入值非法,请核实!");
	    object.focus();
	}
}

  function ptrim(not_trim){
	var x; var x1;
	for (x=0;not_trim.charAt(x)==' ';x++){}
	for (x1=not_trim.length-1; not_trim.charAt(x1)==' '; x1--){}
	if (x>x1) 
		return "";
	else
		return not_trim.substring(x,x1+1);
} 
function CheckDate(object_value) { 
 	var array = new Array();
	
	array = object_value.split("-");
	if (array.length !=3){
	    return false;
	}
	if (!CheckInteger(array[0]))
	    return false;
	if (!CheckInteger(array[1]))
	    return false;
	if (!CheckInteger(array[2]))
	    return false;
	if ( eval(array[0])<2000 ||eval(array[0])>9999)
	    return false;
	if ( eval(array[1])<1 ||eval(array[1])>12)
	    return false;
	if ( eval(array[2])<1 ||eval(array[2])>31)
	    return false;
	    
	return true; 
}   
function CheckInteger(object_value) { 
	var GoodChars = "0123456789"; 
	var i = 0; 
	for (i=0; i<= object_value.length -1; i++) { 
	    if (GoodChars.indexOf(object_value.charAt(i)) == -1) { 
		return false; 
	    } 
	} 
	return true; 
} 
</script>             
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
    <td><!-- #BeginEditable "body" --> 
      <form method="post" action="memberusers_lb.jsp">
        <br>
        <br>
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="title12">会员用户查询：</td>
          </tr>
          <tr align="center"> 
            <td colspan="2">注册时间从 
              <input type="text" name="begintime" size="10" value=<%=time[1]%> onBlur="validDateField(this)" >
              到 
              <input type="text" name="endtime" size="10" value=<%=time[0]%> onBlur="validDateField(this)" >
            </td>
          </tr>
          <tr> 
            <td align="center" width="187">公司ID：</td>
            <td width="191"> 
              <input type="text" name="company_id">
            </td>
          </tr>
          <tr> 
            <td width="187" align="center">用户ID：</td>
            <td width="191">
              <input type="text" name="user_id">
            </td>
          </tr>
          <tr> 
            <td width="187" align="center">用户名称：</td>
            <td width="191">
              <input type="text" name="login">
            </td>
          </tr>
          <tr> 
            <td width="187" align="center">信用度 ：</td>
            <td width="191"> 
              <select name="credit">
                 <option value=""></option>
                <% for(int i=0; i<credit.length; i++){	  %>
                 <option value=<%=credit[i][0]%>><%=credit[i][1]%></option>
	        <%    }   %>                          
              </select>
            </td>
          </tr>
          <tr> 
            <td width="187" align="center">有无报价权：</td>
            <td width="191">
              <input type="radio" name="priviledge" value="Y">
              有
              <input type="radio" name="priviledge" value="N" checked>
              否 </td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input type="hidden" name="lang_code" value="GB" >
              <input type="hidden" name="act" value="query" >
              <input type="image" border="0" name="imageField" src="../images/search.gif" width="68" height="26">
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>
</jsp:useBean>

<%--  @# hetong_search.jsp Ver.1.2 --%>

<jsp:useBean id="HetongSearchPage" scope="page" class="backpage.HetongSearchPage" /> 

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

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form method="post" action="hetonglieb.jsp">
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="title12">合同查询：</td>
          </tr>
          <tr> 
            <td width="183" align="center">发布号：</td>
            <td width="201"> 
              <input type="text" name="postingId">
            </td>
          </tr>
          <tr> 
            <td width="183" align="center">议价号：</td>
            <td width="201"> 
              <input type="text" name="bidId">
            </td>
          </tr>
          <tr> 
            <td width="183" align="center">公司ID：</td>
            <td width="201"> 
              <input type="text" name="companyId">
            </td>
          </tr>
          <tr> 
            <td width="183" align="center">用户ID：</td>
            <td width="201"> 
              <input type="text" name="userId">
            </td>
          </tr>
          <tr> 
            <td width="183" align="center">合同号：</td>
            <td width="201"> 
              <input type="text" name="contId">
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="2">合同生成时间从 
              <input type="text" name="crDateFrom" size="12" value="<%=HetongSearchPage.getSysDate(-1)%>" onBlur="validDateField(this)">
              到 
              <input type="text" name="crDateTo" size="12" value="<%=HetongSearchPage.getSysDate()%>" onBlur="validDateField(this)">
            </td>
          </tr>
          <tr> 
            <td width="183" align="center">合同状态：</td>
            <td width="201"> 
              <select name="status">
                <option value="Y"> 已经核可 </option>
                <option value="N"> 尚未核可 </option>
                <option value="C"> 取消 </option>
                <option value="F"> 已经结束 </option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="183" align="center">创建者ID：</td>
            <td width="201"> 
              <input type="text" name="crUserId">
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input type="image" border="0" name="imageField" src="../images/search.gif" width="68" height="26">
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

<script language=javascript > 
ie=document.all?1:0; netscape=document.layers?1:0;

function ptrim(not_trim){
	var x; var x1;
	for (x=0;not_trim.charAt(x)==' ';x++){}
	for (x1=not_trim.length-1; not_trim.charAt(x1)==' '; x1--){}
	if (x>x1) 
		return "";
	else
		return not_trim.substring(x,x1+1);
}

</script> 
<script language="JavaScript"> 
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

function CheckNumber(object_value) { 
	var GoodChars = "0123456789"; 
	var firstChar = object_value.charAt(0);
	var numberStr = object_value;
 	var array = new Array();
	var i = 0; 

	if (firstChar=='+'|| firstChar=='-')
	    numberStr = object_value.substring(1, object_value.length);
	
	array = numberStr.split(".");
	if (array.length ==1){
	    if (array[0].length ==0)
		return false;
	}
	else if (array.length >2){
	    return false;
	}
	for (i=0; i< array.length; i++) {
	    for (var j=0; j< array[i].length; j++) { 
		if (GoodChars.indexOf(array[i].charAt(j)) == -1) { 
		    return false; 
		}
	    } 
	} 
	return true; 
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

function validField(object){
	var value = ptrim(object.value);
	if (value !="")
	{
	    if ( !CheckNumber(value))
	    {
	    	alert("输入值非法,请核实!");
	        object.focus();
	    }
	}
}

function validDateField(object){
	var value = ptrim(object.value);

	if ( !CheckDate(value))
	{
	    alert("输入值非法,请核实!");
	    object.focus();
	}
}
</script>

<html>
<head>
<title>CNHotelBooking.com��̨������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "����"}
        A:visited {text-decoration: none; font-family: "����"}
        A:active {text-decoration: none; font-family: "����"}
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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<jsp:useBean id="State" scope="page" class="com.cnbooking.bst.State" /> 
<jsp:setProperty name="State" property="stateId"/>
<jsp:setProperty name="State" property="langCode"/>

<%
    String state_id = request.getParameter("stateId");
    String lang_code = request.getParameter("langCode");
    String operator_id = UserInfo.getUsername();
    String pageno= request.getParameter("pageNo");
    String name="";

    String re_name;
    String value;
    String str="";
    Enumeration e = request.getParameterNames();
    String country_id="";
    
    while ( e.hasMoreElements()){
    	re_name = (String)e.nextElement();
	value = request.getParameter(re_name);

	if ( re_name.equals("countryId") && !value.equals("")) {
	    str += "&countryId=" + value;
	}

    }
    
    State.selectState();
    
    name = State.getName(); 
     
        
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
      <form name="nameEditForm" method="post" action="<%="stateList.jsp?"+str%>">
      <input type="HIDDEN" name="action" value="">
      <input type="HIDDEN" name="stateId" value=<%=state_id%>>
      <input type="HIDDEN" name="langCode" value=<%=lang_code%>>
      <input type="HIDDEN" name="operatorId" value=<%=operator_id%>>
      <input type="HIDDEN" name="pageNo" value=<%=pageno%>>
        <br>
        <br>
        <table width="300" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="font12">
            ʡ�ݱ༭��<%=country_id%>:<%=lang_code%>
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">ʡ�����ƣ� 
              <input type="text" name="name" value="<%=name%>">
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

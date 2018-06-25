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

<jsp:useBean id="City" scope="page" class="com.cnbooking.bst.City" /> 
<jsp:setProperty name="City" property="cityId"/>
<jsp:setProperty name="City" property="langCode"/>

<%
    String city_id = request.getParameter("cityId");
    String lang_code = request.getParameter("langCode");
    String operator_id = UserInfo.getUsername();
    String pageno= request.getParameter("pageNo");
    String name="";
    String descr="";
    String flight_flag="";

    String re_name;
    String value;
    String str="";
    Enumeration e = request.getParameterNames();
    
    while ( e.hasMoreElements()){
    	re_name = (String)e.nextElement();
	value = request.getParameter(re_name);

	if ( re_name.equals("stateId") && !value.equals("")) {
	    str += "&stateId=" + value;
	}	

    }
    
    City.selectCity();
    
    name = City.getName();
    descr =  City.getDescr();
    flight_flag = City.getFlightFlag();
     
        
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
      <form name="nameEditForm" method="post" action="<%="cityList.jsp?"+str%>">
      <input type="HIDDEN" name="action" value="">
      <input type="HIDDEN" name="cityId" value=<%=city_id%>>
      <input type="HIDDEN" name="langCode" value=<%=lang_code%>>
      <input type="HIDDEN" name="operatorId" value=<%=operator_id%>>
      <input type="HIDDEN" name="pageNo" value=<%=pageno%>>
        <br>
        <br>
        <table width="300" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="font12">
            城市编辑：<%=city_id%>:<%=lang_code%>
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">城市名称： 
              <input type="text" name="name" value="<%=name%>">
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">城市描述： 
              <input type="text" name="descr" value="<%=descr%>">
            </td>
          </tr>
          <tr class="font9"> 
            <td colspan="2">起飞标志： 
              <select name="flightFlag">
              <% if (flight_flag.equals("A")){%>
              <option value="A" selected>到达</option>
              <option value="S">起飞</option>
              <option value="N">不到达</option>
              <% }else if (flight_flag.equals("S")){%>
              <option value="A">到达</option>
              <option value="S" selected>起飞</option>
              <option value="N">不到达</option>
              <% }else{%>   
              <option value="A">到达</option>
              <option value="S">起飞</option>
              <option value="N" selected>不到达</option>
              <% }%>                                       
              </select>   
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

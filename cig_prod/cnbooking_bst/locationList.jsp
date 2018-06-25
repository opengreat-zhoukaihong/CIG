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

<jsp:useBean id="LocationList" scope="page" class="com.cnbooking.bst.LocationList" /> 
<jsp:setProperty name="LocationList" property="cityId"/>

<jsp:useBean id="Location" scope="page" class="com.cnbooking.bst.Location" /> 
<jsp:setProperty name="Location" property="locaId"/>
<jsp:setProperty name="Location" property="action"/>
<jsp:setProperty name="Location" property="langCode"/>
<jsp:setProperty name="Location" property="descr"/>
<jsp:setProperty name="Location" property="cityId"/>
<jsp:setProperty name="Location" property="operatorId"/>


<%
   int location_count;
   String[][] location_list;
   
   String act= request.getParameter("action");
   String city_id = request.getParameter("cityId");
   
   String operator_id = UserInfo.getUsername();
   
   Location.setOperatorId(operator_id);
   
    
   Location.initLocation();
   
   location_list = LocationList.getLocationList();   
   location_count = LocationList.getLocationCount();
      
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.paraForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("��ɾ���ó������򣬽�������Ѿ�ʹ�øó����������Ϣ�޷���ʾ����ȷ��ɾ���˳���������?")

    }
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="paraForm" method="post" action="locationList.jsp">
      
      <input type="HIDDEN" name="action">
      <input type="HIDDEN" name="cityId" value="<%=city_id%>">
        <table width="500" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="5" class="font12" height="33">���������б�
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr>
              <td class="font9" colspan="5" align="left">����<%=location_count%>����������</td>  
          </tr>          
          <tr align="center" class="font9"> 
            <td width="80" class="font9"><b>��������ID</b></td>
            <td width="60" class="font9"><b>���Դ���</b></td>
            <td width="80" class="font9"><b>��������</b></td>          
            <td width="160" class="font9"><b>����</b></td>
            <td width="60" class="font9">&nbsp;</td>
          </tr>
                <% 

              	  if (location_count >0){                   
                   for (int i=0;i<location_count;i++){
                 %>
          <tr align="center" class="font9"> 
            <td width="80" class="font9"><a href="locationEdit.jsp?action=update&locaId=<%=location_list[i][0]%>&langCode=<%=location_list[i][1]%>" class="font9"><%=location_list[i][0]%></a></td>
            <td width="60" class="font9"><%=location_list[i][1]%></td>
            <td width="80" class="font9"><%=location_list[i][2]%></td>
            <td width="160" class="font9"><%=location_list[i][3]%></td>
            <td width="60" class="font9"><a href="locationList.jsp?action=delete&locaId=<%=location_list[i][0]%>&langCode=<%=location_list[i][1]%>" onClick="return confirmDelete()" class="font9">ɾ��</a></td>
          </tr>
          <%  }
            }
          %>
          <tr align="center" class="font9"> 
            <td colspan="8"> 
               ���Դ���
              <select name="langCode">
              <option value=GB selected> ���� </option>
              <option value=EN> Ӣ�� </option>
              </select>
              ������������ 
              <input type="text" name="descr" size="20">    
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

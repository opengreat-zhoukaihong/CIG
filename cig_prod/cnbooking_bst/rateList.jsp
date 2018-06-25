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

  funcID = "fnSysMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<jsp:useBean id="RateList" scope="page" class="com.cnbooking.bst.RateList" /> 

<jsp:useBean id="Rate" scope="page" class="com.cnbooking.bst.Rate" />
<jsp:setProperty name="Rate" property="action"/> 
<jsp:setProperty name="Rate" property="fromCurr"/>
<jsp:setProperty name="Rate" property="toCurr"/>
<jsp:setProperty name="Rate" property="rate"/>
<jsp:setProperty name="Rate" property="descr"/>
<jsp:setProperty name="Rate" property="operatorId"/>

<%
   int rate_count;
   String[][] rate_list;
   String act= request.getParameter("action");
   
   String operator_id = UserInfo.getUsername();
   Rate.setOperatorId(operator_id);
   
   if (act.equals("add")){
      if (!Rate.checkAddCond()){
%>
	<jsp:forward page="inform.jsp?info=���ظ��Ļ��ʣ��������¼�룡" />
	</jsp:forward>  
<%    }
   }
   
   Rate.initRate();
   
   RateList.retriveRateList();
   rate_count = RateList.getRateCount();
   rate_list = RateList.getRateList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.rateForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("��ɾ���û��ʣ��������ʹ�øñ���֮����л���ת���޷����С���ȷ��ɾ���˻�����?")

    }
</SCRIPT>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="rateForm" method="post" action="rateList.jsp">
      
        <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="6" class="font12" height="33">�����б�
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><b>Դ����</b></td>
            <td width="60" class="font9"><b>Ŀ�����</b></td>
            <td width="120" class="font9"><b>����</b></td>
            <td width="100" class="font9"><b>����</b></td>
            <td width="54" class="font9">&nbsp;</td>
            <td width="54" class="font9">&nbsp;</td>
          </tr>
          <%
            if (rate_count>0){
              for (int i=0;i<rate_count;i++){
          %>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><%=rate_list[i][0]%></td>
            <td width="60" class="font9"><%=rate_list[i][1]%></td>
            <td width="120" class="font9"><%=rate_list[i][2]%></td>
            <td width="100" class="font9"><%=rate_list[i][3]%></td>
            <td width="54" class="font9"><a href="rateEdit.jsp?action=update&fromCurr=<%=rate_list[i][0]%>&toCurr=<%=rate_list[i][1]%>" class="font9">�༭</a></td>
            <td width="54" class="font9"><a href="rateList.jsp?action=delete&fromCurr=<%=rate_list[i][0]%>&toCurr=<%=rate_list[i][1]%>"  onClick="return confirmDelete()" class="font9">ɾ��</a></td>
          </tr>
          <%  }
            }
          %>
          <tr align="center" class="font9"> 
            <td colspan="8"> 
               Դ����
               <input type="text" name="fromCurr" size="8">
               Ŀ�����
               <input type="text" name="toCurr" size="8">
               ���� 
              <input type="text" name="rate" size="10">
	       ���� 
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

<html><!-- #BeginTemplate "/Templates/backm_paperec.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>�й�ֽ����̨����ϵͳ</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "����"; font-size: 9pt}
.title12 {  font-family: "����"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "����"; text-decoration: underline}
a:visited {  font-family: "����"; text-decoration: underline}
a:active {  font-family: "����"; text-decoration: underline}
a:hover {  font-family: "����"; color: #FFCC66; text-decoration: none}
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

  funcId = "fnSysMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>


<%@ page import="java.util.*" %>
<%@ page import="system.*" %>

<jsp:useBean id="SystemParaList" scope="page" class="system.SystemParaList" /> 
<jsp:setProperty name="SystemParaList" property="id"/>

<jsp:useBean id="SystemPara" scope="page" class="system.SystemPara" /> 
<jsp:setProperty name="SystemPara" property="id"/>
<jsp:setProperty name="SystemPara" property="action"/>
<jsp:setProperty name="SystemPara" property="code"/>
<jsp:setProperty name="SystemPara" property="langCode"/>
<jsp:setProperty name="SystemPara" property="strValue"/>

<%
   int para_count;
   String[][] para_list;
   String id = request.getParameter("id");
   String para_name="����";
   String act= request.getParameter("action");
   
   if (act.equals("add")){
      if (!SystemPara.checkAddCond()){
%>
	<jsp:forward page="inform.jsp?info=���ظ��Ĳ������������¼�룡" />
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

          return confirm("��ɾ���ò�������������Ѿ�ʹ�øò�������Ϣ�޷���ʾ����ȷ��ɾ���˲�����?")

    }
</SCRIPT>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="paraForm" method="post" action="xitongcslb.jsp">
      
      <input type="HIDDEN" name="id" value=<%=id%>>
      <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="4" class="title12" height="33">�����б���
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr align="center"> 
            <td width="80"><b>��������</b></td>
            <td width="80"><b>���Դ���</b></td>
            <td width="160"><b>��������</b></td>
            <td width="54">&nbsp;</td>
          </tr>
          <%
            if (para_count>0){
              for (int i=0;i<para_count;i++){
          %>
          <tr align="center"> 
            <td width="80"><a href="paraedit.jsp?action=update&id=<%=id%>&code=<%=para_list[i][0]%>&langCode=<%=para_list[i][1]%>"><%=para_list[i][0]%></a></td>
            <td width="80"><%=para_list[i][1]%></td>
            <td width="160"><%=para_list[i][2]%></td>
            <td width="54"><a href="xitongcslb.jsp?action=delete&id=<%=id%>&code=<%=para_list[i][0]%>&langCode=<%=para_list[i][1]%>" onClick="return confirmDelete()">ɾ��</a></td>
          </tr>
          <%  }
            }
          %>
          <tr align="center"> 
            <td colspan="8"> 
               ��������
               <input type="text" name="code" size="8">
               ���Դ���
              <select name="langCode">
              <option value=GB selected> ���� </option>
              <option value=EN> Ӣ�� </option>
              </select>
              �������� 
              <input type="text" name="strValue" size="10">
              <a href="#" onClick="javascript:addSubmit()"><input type="image" border="0" name="imageField" src="../images/add.gif" width="68" height="26"></a>
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
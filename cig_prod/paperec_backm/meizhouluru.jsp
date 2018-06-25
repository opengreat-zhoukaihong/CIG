
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

  funcId = "fnConPickMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

 <jsp:useBean id="pw" scope="page" class="system.PickWeek" />  
 <%
   String act=request.getParameter("act");
   String pick_id="";String lang_code="";
   String[] cert=new String[8];
   for(int i=0;i<8;i++)cert[i]="";
   if(act.equals("modi")){
      pick_id=request.getParameter("pick_id");
      pw.setPick_id(pick_id);
      lang_code=request.getParameter("lang_code");
      pw.setLang_code(lang_code);
      cert=pw.getCertain();
   }  
%>
 
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
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
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" -->
      <form method="post" action="meizhoujingxuan_list.jsp">
        <br>
        <br>
        <table width="500" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="title12">ÿ�ܾ�ѡ¼�룺</td>
          </tr>
          <tr> 
            <td width="165" align="center">��˾���ƣ�</td>
            <td width="313"> 
              <input type="text" name="name" value="<%=cert[0]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">��˾������</td>
            <td width="313"> 
              <input type="text" name="background" value="<%=cert[1]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">��˾��ģ��</td>
            <td width="313"> 
              <input type="text" name="comp_size" value="<%=cert[2]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">��Ʒ������</td>
            <td width="313"> 
              <input type="text" name="prod_tech" value="<%=cert[3]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">�ͻ�����</td>
            <td width="313"> 
              <input type="text" name="service" value="<%=cert[4]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">��˾������</td>
            <td width="313"> 
              <input type="text" name="comp_honor" value="<%=cert[5]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">Զ��Ŀ�꣺</td>
            <td width="313"> 
              <input type="text" name="comp_object" value="<%=cert[6]%>">
            </td>
          </tr>
   <%   if(act.equals("inse")){ %>       
          <tr align="center"> 
            <td colspan="2"> 
              <input type="radio" name="lang_code" value="GB">�� ��
              ����&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="radio" name="lang_code" value="EN">Ӣ ��
            </td>
          </tr>
   <%   }   %>       
          <tr align="center"> 
            <td colspan="2">
              <input type="hidden" name="lang_code" value="<%=lang_code%>"> 
              <input type="hidden" name="pick_id" value="<%=pick_id%>"> 
              <input type="hidden" name="act" value="<%=act%>">
              <input type="submit" name="Submit" value="��  ��">              ����
              <input type="reset" name="Reset" value="ȡ  ��">
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>
<% pw.getDestroy();%>
</jsp:useBean>
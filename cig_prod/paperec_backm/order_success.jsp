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

  funcId = "fnBookMgr";
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
<%@ page import="transaction.*" %>

<jsp:useBean id="OrderSuccList" scope="page" class="transaction.OrderSuccList" /> 

<%
    String[][] order_list;
    int order_count;
    
    order_list = OrderSuccList.getOrderSuccList();
    order_count = OrderSuccList.getOrderSuccCount();
%>

<script language="javascript">
   function show(url){
      window.open(url,'quote','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=630,height=210')
             }
</script>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>
      <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
        <tr> 
          <td colspan="10" class="title12">�ѳɽ������б�</td>
        </tr>
        <tr align="center"> 
          <td><b> ������</b></td>
          <td><b>���ۺ�</b></td>
          <td><b>�����û�</b></td>
          <td><b>��ر��ۺ�</b></td>
          <td><b>����û�</b></td>
          <td><b>����ʱ��</b></td>
          <td><b>����</b></td>
          <td><b>��ͬ�ܶ�</b></td>
          <td><b>�۸�����</b></td>
          <td><b>״̬</b></td>
        </tr>
        <% for (int i=0;i<order_count;i++){
        %>
        <tr align="center"> 
          <td><a href="htofferposting_yj.jsp?posting_id=<%=order_list[i][0]%>"><%=order_list[i][0]%></a></td>
          <td><a href="javascript:show('htbidcontent.jsp?bid_id=<%=order_list[i][1]%>')"><%=order_list[i][1]%></a></td>
          <td><%=order_list[i][2]%></td>
          <td><%=order_list[i][3]%></td>
          <td><%=order_list[i][4]%></td>
          <td><%=order_list[i][5]%></td>
          <td><%=order_list[i][6]%></td>
          <td><%=order_list[i][7]%></td>
          <td><%=order_list[i][8]%></td>
          <td><%=order_list[i][9]%></td>
        </tr>
        <% }%>
      </table>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

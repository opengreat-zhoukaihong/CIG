

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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<%@ page language="java" %>
<jsp:useBean id="membus" scope="page" class="member.MemberUsers" />
<jsp:setProperty name="membus" property="*" />
<%
 
   String str[]=new String[7];
      String compuser[][]=null;   
   String st=request.getParameter("act");
   if(st.equals("comp")){
      compuser=membus.getCompUser();     
     }else{       
       str[0]=request.getParameter("begintime");
       str[1]=request.getParameter("endtime");
       str[2]=request.getParameter("company_id");
       str[3]=request.getParameter("user_id");
       str[4]=request.getParameter("login");      
       str[5]=request.getParameter("credit");
       str[6]=request.getParameter("priviledge");
       for(int i=0;i<6;i++)if(str[i]==null)str[i]="";
       compuser=membus.getQueryUser(str);
      } 
%>

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


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>
      <form method="post" action="">
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="9" class="title12">��Ա�û��б�ҳ�棺</td>
          </tr>   
          <tr align="center"> 
            <td width="55"><b>��˾ID</b></td>
            <td width="55"><b>��˾����</b></td>
            <td width="55"><b>�û�ID</b></td>
            <td width="55"><b>�û���</b></td>
            <td width="60"><b>ע��ʱ��</b></td>
            <td width="64"><b>���ޱ���Ȩ</b></td>
            <td width="66"><b>�Ƿ�Ϊ��Ҫ��ϵ��</b></td>
            <td width="46"><b>���ö�</b></td>
            <td width="52">&nbsp;</td>
          </tr>
    <% for(int i=0;i<compuser.length;i++){   %>     
          <tr align="center"> 
            <td width="55"><%=compuser[i][2]%></td>
            <td width="55"><%=compuser[i][7]%></td>
            <td width="55"><%=compuser[i][0]%></td>
            <td width="55"><%=compuser[i][1]%></td>
            <td width="60"><%=compuser[i][3]%></td>
            <td width="64"><%=compuser[i][4]%></td>
            <td width="66"><%=compuser[i][5]%></td>
            <td width="46"><%=compuser[i][6]%></td>
            <td width="52"><a href="memberusers_detail.jsp?act=<%=st%>&lang_code=GB&id=<%=i%>&user_id=<%=compuser[i][0]%>">�༭</a></td>
          </tr>
     <%   }   %>     
          
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>
</jsp:useBean>

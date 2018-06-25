<%--  @# updateContStatus.jsp Ver.1.0 --%>

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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<%@ page import="postcenter.*, java.util.*, java.net.*" %>
<jsp:useBean id="UpdateContStatusPage" scope="page" class="backpage.UpdateContStatusPage" /> 

<jsp:setProperty name="UpdateContStatusPage" property="contId" />
<jsp:setProperty name="UpdateContStatusPage" property="action" />

<% 
    UpdateContStatusPage.process();
%>

<%
  String info = "";
  if(UpdateContStatusPage.process()) 
  { 
    info = "��ϲ,���Ѹ��ĳɹ�!<br> ";
  }else
  {
    info = "�ܱ�Ǹ,��δ�ܸ��ĳɹ�����������!";
  }
  
  response.sendRedirect("inform.jsp?info=" + URLEncoder.encode(info));
%>

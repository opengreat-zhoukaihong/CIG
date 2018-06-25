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
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
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
    info = "恭喜,您已更改成功!<br> ";
  }else
  {
    info = "很抱歉,您未能更改成功，请检查数据!";
  }
  
  response.sendRedirect("inform.jsp?info=" + URLEncoder.encode(info));
%>

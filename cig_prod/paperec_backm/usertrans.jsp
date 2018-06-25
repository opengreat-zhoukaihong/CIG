
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
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<%@ page  language="java" %>
<%
   String trans=request.getParameter("trans");
   String lang_code=request.getParameter("lang_code");   
   String id=request.getParameter("id");
   String user_id=request.getParameter("user_id");
   String act=request.getParameter("act");
   String firstname=request.getParameter("firstname");
   String lastname=request.getParameter("lastname");
   String priviledge=request.getParameter("priviledge");
   String credit=request.getParameter("credit");   
   String address1=request.getParameter("address1");
   String address2=request.getParameter("address2");
   String login=request.getParameter("login");
          %>
   
<%   if(trans.equals("subm")){  %>
<jsp:forward page="newxi.jsp" > 
<jsp:param name="lang_code" value="<%=lang_code%>" />
<jsp:param name="user_id" value="<%=user_id%>" />
<jsp:param name="firstname" value="<%=firstname%>" />
<jsp:param name="lastname" value="<%=lastname%>" />
<jsp:param name="priviledge" value="<%=priviledge%>" />
<jsp:param name="credit" value="<%=credit%>" />
<jsp:param name="address1" value="<%=address1%>" />
<jsp:param name="address2" value="<%=address2%>" />

</jsp:forward>  
<%  }   %>

<%  if(trans.equals("reset")){   %>
<jsp:forward page="memberusers_detail.jsp" > 
<jsp:param name="lang_code" value="<%=lang_code%>" />
<jsp:param name="act" value="<%=act%>" />
<jsp:param name="id" value="<%=id%>" />
<jsp:param name="user_id" value="<%=user_id%>" />
</jsp:forward>  
<%  }   %>

<%   if(trans.equals("mimasz")){  %>
<jsp:forward page="newxi.jsp" > 
<jsp:param name="lang_code" value="mimasz" />
<jsp:param name="user_id" value="<%=user_id%>" />
<jsp:param name="login" value="<%=login%>"  />
</jsp:forward>  
<%  }   %>

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
   String company_id=request.getParameter("company_id");
   String buy_sale_flag=request.getParameter("buy_sale_flag");
   String pri_user_id=request.getParameter("pri_user_id");
   String old_user_id=request.getParameter("old_user_id");
   String name=request.getParameter("name");
   String address1=request.getParameter("address1");
   String address2=request.getParameter("address2");
   String bank=request.getParameter("bank");             %>
   
<%   if(trans.equals("subm")){  %>
<jsp:forward page="xinxi.jsp" > 
<jsp:param name="trans" value="<%=trans%>" />
<jsp:param name="lang_code" value="<%=lang_code%>" />
<jsp:param name="company_id" value="<%=company_id%>" />
<jsp:param name="buy_sale_flag" value="<%=buy_sale_flag%>" />
<jsp:param name="pri_user_id" value="<%=pri_user_id%>" />
<jsp:param name="old_user_id" value="<%=old_user_id%>" />
<jsp:param name="name" value="<%=name%>" />
<jsp:param name="address1" value="<%=address1%>" />
<jsp:param name="address2" value="<%=address2%>" />
<jsp:param name="bank" value="<%=bank%>" />
</jsp:forward>  
<%  }   %>

<%  if(trans.equals("reset")){   %>
<jsp:forward page="membercompany_dedail.jsp" > 
<jsp:param name="trans" value="<%=trans%>" />
<jsp:param name="lang_code" value="<%=lang_code%>" />
<jsp:param name="company_id" value="<%=company_id%>" />
</jsp:forward>  
<%  }   %>

<%  if(trans.equals("hez")){   %>
<jsp:forward page="membercompany_dedail.jsp" > 
<jsp:param name="trans" value="hez" />
<jsp:param name="lang_code" value="<%=lang_code%>" />
<jsp:param name="company_id" value="<%=company_id%>" />
</jsp:forward>  
<%  }   %>

<%  if(trans.equals("juj")){   %>
<jsp:forward page="membercompany_dedail.jsp" > 
<jsp:param name="trans" value="juj" />
<jsp:param name="lang_code" value="<%=lang_code%>" />
<jsp:param name="company_id" value="<%=company_id%>" />
</jsp:forward>  
<%  }   %>

<%  if(trans.equals("cak")){   %>
<jsp:forward page="memberusers_lb.jsp" >
<jsp:param name="act" value="comp" />
<jsp:param name="lang_code" value="<%=lang_code%>" />
<jsp:param name="company_id" value="<%=company_id%>" />
</jsp:forward>  
<%  }   %>

<%  if(trans.equals("cap")){   %>
<jsp:forward page="memberuser_cpzllb.jsp" > 
<jsp:param name="companyId" value="<%=company_id%>" />
</jsp:forward>  
<%  }   %>

<%  if(trans.equals("gog")){   %>
<jsp:forward page="shuru_shanchu.jsp" > 
<jsp:param name="company_id" value="<%=company_id%>" />
<jsp:param name="act" value="begin" />
</jsp:forward>  
<%  }   %>
<jsp:useBean id="userInfo" scope="session" class="com.forbrand.member.LoginBean" />
<jsp:setProperty name="userInfo" property="*" />
<%
/** @todo check whether there is null info */
userInfo.modifyUserInfo();
%>
<jsp:forward page="checkout2.jsp"/>
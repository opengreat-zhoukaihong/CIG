<%--  @# member_user_list.jsp  Ver 1.0 --%>

<%@ page import="java.util.*" %>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/main_middle.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnCusMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>


<jsp:useBean id="MemberDetail" scope="page" class="com.cnbooking.bst.member.MemberDetail" /> 
<jsp:setProperty name="MemberDetail" property="custId"/>

<%
  MemberDetail.getResult();
  
  String[][] memberLangList = MemberDetail.getMemberLangList();
%>

<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>



<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name="frmMemberDetail" method="post" action="member_user_detail.jsp">
      <input type="HIDDEN" name="bookId" value=<%--=book_id--%>>
      <input type="HIDDEN" name="action" value=<%--=act--%>>
      <input type="HIDDEN" name="operatorId" value=<%--=operator_id--%>>


	<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">会员资料</td>
          </tr>
        </table>
        <table width="547" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td class="font9" height="30" width="100">Login：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getLogin()%> </td>
            <td class="font9" height="30" width="100">Passwd：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getPasswd()%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">会员ID：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getCustId()%></td>
            <td class="font9" height="30" width="100">性别：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getGender()%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">国家：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getCountryName()%> <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;代码： <%=MemberDetail.getCountryId()%> --%></td>
            <td class="font9" height="30" width="100">省份：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getStateName()%> <%--&nbsp;&nbsp;&nbsp;&nbsp;代码： <%=MemberDetail.getStateId()%>--%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">邮政编码：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getPostcode()%></td>
            <td class="font9" height="30" width="100">&nbsp;</td>
            <td class="font9" height="30" width="150">&nbsp;</td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">移动电话：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getMobile()%></td>
            <td class="font9" height="30" width="100">电话：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getTel()%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">传真：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getFax()%></td>
            <td class="font9" height="30" width="100">电子邮件：</td>
            <td class="font9" height="30" width="150">&nbsp;<a href="mailto:<%=MemberDetail.getEmail()%>" class="font9"><%=MemberDetail.getEmail()%></a></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">积分：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getPoints()%> </td>
            <td class="font9" height="30" width="100">送报标记：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getNewsletterFlag()%> </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">提示问题：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getRemQuestion()%>
            </td>
            <td class="font9" height="30" width="100">提示答案：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getRemAnswer()%>  </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">申请日期：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getCrDate()%>
            </td>
            <td class="font9" height="30" width="100">修改日期：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getMdDate()%> </td>
          <tr> 
            <td class="font9" height="30" width="100">操作员ID：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getOpeId()%></td>
            <td class="font9" height="30" width="100">&nbsp;</td>
            <td class="font9" height="30" width="150">&nbsp;</td>
          </tr>
        </table>
        <% if (memberLangList != null) {
             for (int i=0; i<memberLangList.length; i++) {%>
        <table width="547" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td class="font9" height="30" width="100">语言代码：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=memberLangList[i][0]%></td>
            <td class="font9" height="30" width="100">&nbsp;</td>
            <td class="font9" height="30" width="150">&nbsp;</td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">会员姓名：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=memberLangList[i][1]%></td>
            <td class="font9" height="30" width="100">城市：</td>
            <td class="font9" height="30" width="150">&nbsp;<%=memberLangList[i][2]%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">地址1：</td>
            <td class="font9" height="30" colspan="3">&nbsp;<%=memberLangList[i][3]%>
            </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">地址2：</td>
            <td class="font9" height="30" colspan="3">&nbsp;<%=memberLangList[i][4]%>
            </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">描述：</td>
            <td class="font9" height="30" colspan="3">&nbsp;<%=memberLangList[i][5]%>
            </td>
          </tr>
        </table>
        <%   }
           }%>
        <table width="506" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30">&nbsp; </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

<%--Err: <%=MemberDetail.errMsg--%>
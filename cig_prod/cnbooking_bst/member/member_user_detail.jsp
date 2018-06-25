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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
<%}%>


<jsp:useBean id="MemberDetail" scope="page" class="com.cnbooking.bst.member.MemberDetail" /> 
<jsp:setProperty name="MemberDetail" property="custId"/>

<%
  MemberDetail.getResult();
  
  String[][] memberLangList = MemberDetail.getMemberLangList();
%>

<html>
<head>
<title>CNHotelBooking.com��̨������</title>
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
            <td class="font12">��Ա����</td>
          </tr>
        </table>
        <table width="547" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td class="font9" height="30" width="100">Login��</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getLogin()%> </td>
            <td class="font9" height="30" width="100">Passwd��</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getPasswd()%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��ԱID��</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getCustId()%></td>
            <td class="font9" height="30" width="100">�Ա�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getGender()%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">���ң�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getCountryName()%> <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���룺 <%=MemberDetail.getCountryId()%> --%></td>
            <td class="font9" height="30" width="100">ʡ�ݣ�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getStateName()%> <%--&nbsp;&nbsp;&nbsp;&nbsp;���룺 <%=MemberDetail.getStateId()%>--%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">�������룺</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getPostcode()%></td>
            <td class="font9" height="30" width="100">&nbsp;</td>
            <td class="font9" height="30" width="150">&nbsp;</td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">�ƶ��绰��</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getMobile()%></td>
            <td class="font9" height="30" width="100">�绰��</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getTel()%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">���棺</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getFax()%></td>
            <td class="font9" height="30" width="100">�����ʼ���</td>
            <td class="font9" height="30" width="150">&nbsp;<a href="mailto:<%=MemberDetail.getEmail()%>" class="font9"><%=MemberDetail.getEmail()%></a></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">���֣�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getPoints()%> </td>
            <td class="font9" height="30" width="100">�ͱ���ǣ�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getNewsletterFlag()%> </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��ʾ���⣺</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getRemQuestion()%>
            </td>
            <td class="font9" height="30" width="100">��ʾ�𰸣�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getRemAnswer()%>  </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">�������ڣ�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getCrDate()%>
            </td>
            <td class="font9" height="30" width="100">�޸����ڣ�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getMdDate()%> </td>
          <tr> 
            <td class="font9" height="30" width="100">����ԱID��</td>
            <td class="font9" height="30" width="150">&nbsp;<%=MemberDetail.getOpeId()%></td>
            <td class="font9" height="30" width="100">&nbsp;</td>
            <td class="font9" height="30" width="150">&nbsp;</td>
          </tr>
        </table>
        <% if (memberLangList != null) {
             for (int i=0; i<memberLangList.length; i++) {%>
        <table width="547" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td class="font9" height="30" width="100">���Դ��룺</td>
            <td class="font9" height="30" width="150">&nbsp;<%=memberLangList[i][0]%></td>
            <td class="font9" height="30" width="100">&nbsp;</td>
            <td class="font9" height="30" width="150">&nbsp;</td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��Ա������</td>
            <td class="font9" height="30" width="150">&nbsp;<%=memberLangList[i][1]%></td>
            <td class="font9" height="30" width="100">���У�</td>
            <td class="font9" height="30" width="150">&nbsp;<%=memberLangList[i][2]%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��ַ1��</td>
            <td class="font9" height="30" colspan="3">&nbsp;<%=memberLangList[i][3]%>
            </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��ַ2��</td>
            <td class="font9" height="30" colspan="3">&nbsp;<%=memberLangList[i][4]%>
            </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">������</td>
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
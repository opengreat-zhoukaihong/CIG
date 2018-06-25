<%@ page import="java.sql.*"  %>
<html>
<head>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >

<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<jsp:useBean id="login" scope="session" class="com.cig.chinaeoa.LoginBean" />
<%
   String wSql = "";
   String UserId = request.getParameter("User");
   String Passwd = request.getParameter("Passwd");
   String MemberId = "";
   String CompName = "";
   String MemberType = "";
   String UserLevel = "";
   //String UserId = "";
   String LangCode = request.getParameter("LangCode");
   if (LangCode == null)
     LangCode = "GB";
   wSql = "select U.USERID, U.Passwd, U.UserLevel, M.*, l.CompName from USERS U, MEMBER M, Member_l l WHERE " +
          " U.MemberId = M.MemberID and L.lang_code = '" + LangCode + "' and M.MemberID = l.MemberID and U.userid = '" + UserId + "' " +
          " and u.Passwd = '" + Passwd + "' and M.MemberType = '1'";
   ResultSet rs = Result.getRS(wSql);
   if (rs==null)
   {
     out.println("rs=null");
   }
   else
   {
     //out.println("con = true");
     if (rs.next())
     {
       MemberId = rs.getString("MemberId");
       CompName = rs.getString("CompName");
       MemberType = rs.getString("MemberType");
       UserLevel = rs.getString("UserLevel");
       //UserId = rs.getString("UserId");

       session.removeValue("cneoa.MemberId");
       session.removeValue("cneoa.UserId");
       session.removeValue("cneoa.CompName");
       session.removeValue("cneoa.MemberType");
       session.removeValue("cneoa.UserLevel");
            if (MemberId != null)
          session.putValue("cneoa.MemberId", MemberId);
            if (UserId != null)
         session.putValue("cneoa.UserId", UserId);
            if (CompName != null)
         session.putValue("cneoa.CompName", CompName);
            if (MemberType != null)
         session.putValue("cneoa.MemberType", MemberType);
            if (UserLevel != null)
         session.putValue("cneoa.UserLevel", UserLevel);
       //response.sendRedirect(request.getScheme() + "://" + request.getServerName() +
       // ":" + request.getServerPort() + "/chinaeoa/MyEoa.jsp");

       login.setUserId(UserId);
       login.setMemberId(MemberId);
       login.setMemberType(MemberType);
       login.setUserLevel(UserLevel);
       login.setCompName(CompName);
%>
    <table border="0" cellspacing="0" cellpadding="10" width="460">
  <tr align="center"> 
    <td rowspan="2" height="67" width="98"> <img src="/images/spacer.gif" width="80" height="1"> 
    </td>
    <td width="428" height="52">&nbsp;</td>
  </tr>
  <tr align="center"> 
    <td width="428"> 
      <TABLE border=0 
      cellPadding=0 cellSpacing=0 width=317>
        <form name="fmLogin" method="post" action="/chinaeoa/eoa-bst/BstLogin.jsp">
          <tr> 
            <td align="center" width="137" height="51">&nbsp;</td>
            <td colspan="3" width="180" height="51">&nbsp;</td>
          </tr>
          <tr> 
            <td align="center" colspan="4" height="50"><font size="5" color="#FF3333">欢迎使用后台管理系统!</font></td>
          </tr>
          <tr> 
            <td colspan="4" align="center" height="50"> 
              </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
<%
     }
     else {

       login.setUserId(UserId);
       login.setMemberId(MemberId);
       login.setMemberType(MemberType);
       login.setUserLevel(UserLevel);
       login.setCompName(CompName);
            
       response.sendRedirect("bstLoginErr.htm");
     }
   }

      if (Result.CloseStm())
        out.println("");%>

</body>
</html>

<%@ page import="java.sql.*" %>
<html>
<head>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
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
          " and u.Passwd = '" + Passwd + "' ";
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

       response.sendRedirect("MyEoa.jsp");
     }
     else {
       response.sendRedirect("/LoginError.htm");
     }
   }

%>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >
<%if (Result.CloseStm())
        out.println("");%>

</body>
</html>

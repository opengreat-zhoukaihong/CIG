<%

    String MemberId = (String)session.getValue("cneoa.MemberId");
    String MemberType = (String)session.getValue("cneoa.MemberType");
      String UserLevel = (String)session.getValue("cneoa.UserLevel");
    if ((MemberId == null) || (MemberType == null) || (!MemberType.equals("1")))
      {     
       //response.sendRedirect("bstLoginErr.htm");
   
%>
         <jsp:forward page="bstLoginErr.htm" />
<%
      }
%>
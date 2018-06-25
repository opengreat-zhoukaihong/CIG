<%@ page import="java.sql.*" %>
<HTML>
<HEAD>

<jsp:useBean id="ResultId" scope="session" class="com.cig.chinaeoa.ResultBean" />

<TITLE>
Result
</TITLE>
</HEAD>
<BODY>
<H1>
JBuilder Generated JSP
</H1>
<FORM method="post">
<BR>Enter new value   :  <INPUT NAME="sample"><BR>
<BR><BR>
<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Submit">
<INPUT TYPE="RESET" VALUE="Reset">
<BR>
  Value of Bean property is :<jsp:getProperty name="ResultId" property="sample" /> 
  <table width="79%" border="0">
  <%
   String wSql = request.getParameter("SQL");
   ResultSet rs = ResultId.getRS(wSql);
   if (rs==null)
   {
     out.println("rs=null");
   }
   else
   {
     //out.println("con = true");
     while (rs.next())
     {
        out.println("<tr>");
        out.println("<td>" + rs.getString(1) + "</td>");
        out.println("<td>" + rs.getString(2) + "</td>");
        out.println("<td>&nbsp;</td>");
        out.println("<td>&nbsp;</td>");
        out.println("</tr>");
     }
   }
   %>
  </table>
  <p>&nbsp;</p>
</FORM>
</BODY>
</HTML>

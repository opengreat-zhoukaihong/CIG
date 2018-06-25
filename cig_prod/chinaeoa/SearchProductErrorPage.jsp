<HTML>
<BODY>
<%@ page isErrorPage="true" %>
<BR> 
<H1>Error page SearchProduct</H1>

<BR>An error occured in the bean. Error Message is: <%= exception.getMessage() %><BR>
Stack Trace is : <PRE><FONT COLOR="RED"><% 
 java.io.CharArrayWriter cw = new java.io.CharArrayWriter(); 
 java.io.PrintWriter pw = new java.io.PrintWriter(cw,true); 
 exception.printStackTrace(pw); 
  out.println(cw.toString());  
 %></FONT></PRE>
<BR></BODY>
</HTML>

<%-- @# paperec_index.jsp Ver.1.2 --%>

<%
    String mainFrameSrc = request.getParameter("mainFrameSrc");
    String mainFrame = request.getParameter("mainFrame");
    
    if (mainFrame==null) mainFrame = "";
    if (mainFrameSrc==null) mainFrameSrc = "";
    
    if (mainFrame.equals("login"))
    {
        mainFrameSrc = "login.jsp?answerInput=&" + 
        		"username=" + request.getParameter("username") +
        		"&password=" + request.getParameter("password");
    }
    else if (mainFrame.equals("relogin"))
        mainFrameSrc = "login.jsp?answerInput=";
    else if (mainFrame.equals("aboutus"))
        mainFrameSrc = "../html/aboutus/aboutus.htm"; 
    else if (mainFrame.equals("contactus"))
        mainFrameSrc = "../html/contactus.htm"; 
    else if (mainFrame.equals("registerInfo"))
        mainFrameSrc = "registerInfo.htm";
    else if (mainFrame.equals("forget"))
        mainFrameSrc = "login_forget.jsp?username=" + request.getParameter("username");
    else if (mainFrameSrc.equals(""))
        mainFrameSrc = "login.jsp?answerInput=&" + 
        		"username=" + request.getParameter("username") +
        		"&password=" + request.getParameter("password");
%>

<html>
<head>
<title>ÎÒµÄÖ½Íø--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<frameset rows="86,376*" frameborder="NO" border="0" framespacing="0" cols="*"> 
  <frame name="topFrame" scrolling="NO" noresize src="toptitle.htm" >
  <frame name="mainFrame" src="<%=mainFrameSrc%>">
</frameset>
<noframes><body bgcolor="#FFFFFF">
aa
</body></noframes>
</html>

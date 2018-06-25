<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<% if(session.getAttribute("userid")==null) {%>
<jsp:forward page="../ResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="consult" scope="page" class="com.forbrand.member.consultation"/>

<html>
<head>
<title>Ask Question</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../public.css">
</head>
<%! String question,userid,giftID,langCode,backurl; %>
<%! int i; %>
<% question = request.getParameter("question");
	giftID = request.getParameter("giftID");
	langCode = request.getParameter("langCode");
	backurl = "popup.jsp?giftID="+giftID+"&langCode="+langCode+"";
%>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr> 
    <td valign="middle"> 
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="white-title"  > 
            <p>Please input your question to No.<%=giftID%> gift:</p>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr> 
            <td class="bottom-menu" colspan="3" > 
<% if(giftID==null || giftID == "" )
	{	%>
     <p><span class="black-m-text"><b>You haven't select a product! 
       </b></span>
<%	}	%>	
<% if(question==null || question == "")
	{ %>
<script language="JavaScript">
	function askquestion()
	{
		document.form1.submit()
	}
</script>

          <form name="form1"  method="post">
              <div align="center"> 
                <p> 
                  <textarea name="question" cols="50" rows="4" class="black-m-text" ></textarea>
                </p>
                <p align="right"> 
                  <input type="image" border="0" name="imageField" src="../../images/submit-buttom.jpg" width="68" height="25" onclick="askquestion()">
                </p>
              </div>
          </form>
<%	}
	else
	{
		userid = (String)session.getAttribute("userid");
		i=consult.inputQuestion(userid,giftID,question);
		if(i==1)
		{	%>
		      <p><span class="black-m-text"><b>You have asked a question about this product. 
                </b></span>
<%		}
		else
		{%> 
              <p><b><span class="black-m-text">Sorry You fail to ask question.
                </span></b>
              <p><b><span class="black-m-text">Please contact the webmaster. </span></b>
<%		}
	}	%> 
            </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="bottom-menu"  > 
            <p class="white-title" align="right"> &gt;&gt;<a href="<%=backurl%>"><font color="#FFFFFF">Go 
              Back</font></a>&lt;&lt;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<jsp:useBean id="consult" scope="page" class="com.forbrand.member.consultation"/>

<html>
<head>
<title>Special Order</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../public.css">
</head>
<%! String question,userid; %>
<%! int i; %>
<% question = request.getParameter("question");
%>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr> 
    <td valign="middle"> 
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="white-title"  > 
            <p>Special Order</p>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr> 
            <td class="bottom-menu" colspan="3" > 
<%	userid = (String)session.getAttribute("userid");
	if(userid==null)
	{	%>
	<script language="JavaScript">
	function loginhere()
	{
		opener.location = " myaccount.jsp"
		window.close()
	}
	</script>
	  <p><span class="black-m-text"><b>You haven't log in here.
         </b></span>
	  <p><span class="black-m-text"><b>Click <a href="javascript:loginhere()">here</a> to log in.
         </b></span>
<%	}
	else
	{
		if(question==null || question == "")
		{ %>
		<script language="JavaScript">
			function askquestion()
			{
				document.form1.submit()
			}
		</script>
	     <p><span class="black-m-text"><b>Please describe your order elaborately,<br>
		 so that we can fulfil your needs.
	       </b></span>

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
<%		}
		else
		{
			i=consult.inputQuestion(userid,"",question);
			if(i==1)
			{	%>
		      <p><span class="black-m-text"><b>Thank you to tell us your requirements. 
                </b></span>
<%			}
			else
			{%> 
              <p><b><span class="black-m-text">Sorry You fail to ask question.
                </span></b>
              <p><b><span class="black-m-text">Please contact the webmaster. </span></b>
<%			}
		}
	}	%> 
            </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="bottom-menu"  > 
            <p class="white-title" align="right"> &gt;&gt;<a href="javascript: history.back()"><font color="#FFFFFF">Go back</font></a>&lt;&lt;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

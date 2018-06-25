<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="../login/error.jsp"%>
<% if(session.getAttribute("operator")==null) {%>
<jsp:forward page="../bst/BackResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="consult" scope="page" class="com.forbrand.member.consultation"/>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnConsultMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../bst/BackResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>

<html>
<head>
<title>Answer Question</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../public.css">
<script src="/js/formcheck.js"></script>
</head>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr> 
    <td valign="middle"> 
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="white-title"  > 
            <p>Answer Question:</p>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr> 
            <td class="bottom-menu" colspan="3" > 
<%! String answer,qid,opeid; %>
<%! int i; %>
<% answer = request.getParameter("answer");
	qid = request.getParameter("consultation");

%>
<% if(answer==null || answer =="")
	{ %>
<script language="JavaScript">
	function answerquestion()
	{
		document.form1.submit()
	}
</script>

          <form name="form1"  method="post">
              <div align="center"> 
                <p> 
                  <textarea name="answer" cols="50" rows="4" class="black-m-text" ></textarea>
                </p>
                <p align="right"> 
                  <input type="hidden" name="consultation" value="<%=qid%>">
                  <input type="image" border="0" name="imageField" src="../../images/submit-buttom.jpg" width="68" height="25" onclick="answerquestion()">
                </p>
              </div>
          </form>
<%	}
	else
	{
		opeid = (String)session.getAttribute("operator");
		i=consult.inputAnswer(qid,opeid,answer);
		if(i==1)
		{	%>
		      <p><span class="black-m-text"><b>You have answered this question. 
                <script language="JavaScript">
			self.opener.document.form2.submit()
		</script>
                </b></span>
              <p><b><span class="black-m-text"><a href="javascript:window.close()">close 
                Window</a> <%		}
		else
		{%> </span></b>
              <p><b><span class="black-m-text">Sorry You fail to answer this question. 
                </span></b>
              <p><b><span class="black-m-text">Please contact the webmaster. </span></b>
              <p><b><span class="black-m-text"><a href="javascript:window.close()">close 
                Window</a> <%		}
	}	%> </span></b> 
            </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="bottom-menu"  > 
            <p class="white-title" align="right"> &gt;&gt;<a href="javascript:window.close()"><font color="#FFFFFF">Go 
              Back</font></a>&lt;&lt;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

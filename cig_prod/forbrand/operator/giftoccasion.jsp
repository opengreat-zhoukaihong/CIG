<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<% if(session.getAttribute("operator")==null) {%>
<jsp:forward page="../bst/BackResultsError.jsp?message=You haven't logged in."/>
<% } %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnOccasionMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../ResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>
<% if(request.getParameter("gift_ID")==null)
  { %>
  <jsp:forward page="../bst/BackResultsError.jsp?message=You haven't selected a gift."/>
<%  } %>
<jsp:useBean id="occasion" scope="page" class="com.forbrand.member.occasionBean" />
<jsp:setProperty name="occasion" property="*" />
<jsp:useBean id="giftocn" scope="page" class="com.forbrand.member.giftOccasionBean" />
<jsp:setProperty name="giftocn" property="*" />

<html>
<head>
<title>Assign Occasion</title>
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
            <p>Assign Occasion:</p>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr> 
            <td class="bottom-menu" colspan="3" > 
<%! int i; %>
<% if(request.getParameter("ocnids")!=null)
  {	%>
    <jsp:useBean id="strconvert" scope="page" class="com.forbrand.member.StringConvert" />

<%! String[] ocnids;
    String ocnstr;
    int ocnno;	%>
<%  ocnstr = request.getParameter("ocnids");
    ocnno = Integer.parseInt(request.getParameter("ocnno"));
    ocnids = strconvert.convertToArray(ocnstr,ocnno);
    if(!giftocn.delAllGiftOcn(request.getParameter("gift_ID")))
    { %>
    <jsp:forward page="../bst/BackResultsError.jsp?message=Database Operation Wrong.Please contact the webmaster."/>
<%  }
    for(i=0;i<ocnno;i++)
    {
      giftocn.setGift_ID(request.getParameter("gift_ID"));
      giftocn.setOccasion_ID(ocnids[i]);
      if(!giftocn.addGiftOccasion())
      { %>
      <jsp:forward page="../bst/BackResultsError.jsp?message=Database Operation Wrong.Please contact the webmaster."/>
<%    }
    } %>
            <p class="contact" align="center">You have assigned occasions to this 
              gift.</p>
<% }
  else
  { %>
<%! String oarray[][]; %>
<% oarray = occasion.getAllOccasion("EN"); %>

<form name="ocnform">
              <table width="323" align="center">
                <tr class="dalei"> 
                  <td bgcolor="#E1E0EF" height="20" width="24"> </td>
                  <td bgcolor="#E1E0EF" height="20" width="86">Occasion_ID</td>
                  <td bgcolor="#E1E0EF" height="20" width="287">Occasion_Name</td>
                </tr>
                <% for(i=0;i<oarray.length;i++)
      { %> 
                <tr class="black-m-text"> 
                  <td width="24"> <b><%  if(giftocn.isOcnAssigned(request.getParameter("gift_ID"),oarray[i][0]))
              { %> 
                    <input type="checkbox" value="<%=oarray[i][0]%>" checked>
                    <%  }
          else
              { %> 
                    <input type="checkbox" value="<%=oarray[i][0]%>" >
                    <%	}	%> </b></td>
                  <td width="86"><b><%=oarray[i][0]%></b></td>
                  <td width="287"><b><%=oarray[i][1]%></b></td>
                </tr>
                <% } %> 
              </table>
              <table align="center" width="329">
                <tr> 
                  <td colspan="2"> 
                    <div align="center">
                      <input type="image" border="0" name="imageField" src="../../images/submit-buttom.jpg" width="68" height="25" onClick="grant()">
                      <input type="hidden" name="ocnids" value="">
                      <input type="hidden" name="ocnno" value="">
                      <input type="hidden" name="gift_ID" value="<%=request.getParameter("gift_ID")%>">
                    </div>
                  </td>
                </tr>
              </table>
</form>
<script type="text/javascript" language="JavaScript">
<!--

function grant()
{
	var irow=0
	for(i=0;i<<%=oarray.length%>;i++)
	{
		if(document.ocnform.elements[i].checked)
		{
			document.all.ocnids.value += document.ocnform.elements[i].value
			document.all.ocnids.value += ","
			irow++
		}
	}
	document.all.ocnno.value = irow
	ocnform.submit()
}

-->
</script>
<%  } %>            
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

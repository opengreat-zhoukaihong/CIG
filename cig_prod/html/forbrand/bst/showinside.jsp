<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" import="com.forbrand.show.*, java.util.*"  errorPage="../login/error.jsp"%>
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
  funcID = "fnGiftMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../ResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>

<jsp:useBean id="productList" scope ="page" class="com.forbrand.show.ListBean" />
<jsp:setProperty name="productList" property="*" />
<%	if(request.getParameter("gift_ID")!=null)
		{		%>
		<jsp:useBean id="gift" scope="page" class="com.forbrand.member.gift"/>
<%		gift.deleGift(request.getParameter("gift_ID"));	
		}	%>
<%
    final int PAGE_LENGTH = 8;                      //No. of product in one page
    productList.setPageLength( PAGE_LENGTH );
    productList.fetchResult();
    productList.check();
    int totalPages = productList.getTotalPages();
    int pageNo = productList.getPageNo();
    String langCode = productList.getLangCode();

    List list = productList.getResultList();
%>


<html>
<head>
<title>Gift search result</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../public.css">
<script src="/js/formcheck.js"></script>
<script language="JavaScript">
	function delgift(gid)
	{
		if(confirm("Are you sure to delete this gift?"))
		{
			document.all.gift_ID.value = gid
			document.pageform.submit()
		}
	}

	function giftocn(gid)
	{
		urlstr = "giftoccasion.jsp?gift_ID="+gid
		js_callpage(urlstr)
	}

	function hotbuy(gid)
	{
		urlstr = "hotbuy.jsp?gift_ID="+gid
		js_callpage(urlstr)
	}

	function js_callpage(htmlurl)
	{
  	var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=566,height=327");
  	return false;
	}
	
</script>

</head>

<body bgcolor="#FFFFFF">
      <%
      if ( list != null && list.size() != 0 ) {
      %>
        
        <FORM METHOD=GET ACTION="showinside.jsp" name="pageform">
		      <p align="center" class="black-m-text"> <span class="dalei">Total 
                Pages:</span> <b><%= totalPages %></b>&nbsp;&nbsp;&nbsp;&nbsp; 
                <b><span class="black-m-text">Current Page:</span></b> <b><%=pageNo%></b>&nbsp;&nbsp;&nbsp;&nbsp;<span class="black-m-text"><b>Goto 
                Page</b></span> <%=productList.getHiddenField()%> 
                <INPUT TYPE="text" NAME="pageNo" size=3>&nbsp;&nbsp;&nbsp;&nbsp;
        <%if ( (pageNo != 1) ) { %>
          <a href="showinside.jsp<%=productList.getQueryStr()%>&pageNo=<%=pageNo - 1 %>">&lt;&lt;Previous</a>&nbsp;&nbsp;
        <%} %>
        <%if ( (pageNo != totalPages) ) { %>
          <a href="showinside.jsp<%=productList.getQueryStr()%>&pageNo=<%=pageNo + 1 %>">Next&gt;&gt;</a>
        <%} %>
        </p>
		</FORM>
        
      <%
      }// if list!=null && list.size != 0
      %>

    <%
    if ( list != null && list.size() != 0 ) {

    %>
	<form name="giftform" method="post">
              
  <table border="0" align="center" width="482">
    <tr bgcolor="#E1E0EF" class="dalei" valign="top" align="center"> 
      <td height="15">&nbsp; 
        GiftNo
                  </td>
                  
      <td height="15">&nbsp; 
        Name
                  </td>
                  
      <td colspan="4" height="15"> 
        &nbsp;Function
                  </td>
                </tr>
                <%
      int i = 0;
      String image = "";
      float price;
      String giftNO;
      String giftName = null;
      while ( i < list.size() ) {
        ShowBean show1 = new ShowBean();
        if ( i < list.size() ) show1 = (ShowBean) list.get(i++);

      %> 
                <tr class="black-m-text" > 
                  <td width="80" class="black-m-text">&nbsp; 
                    <div align="center"> <%= (giftNO = show1.getGiftNO()) == null ? "" : giftNO%> 
                    </div>
                  </td>
                  <td width="176" class="black-m-text">&nbsp; 
                    <div align="center"> <%= (giftName = show1.getGiftName()) == null ? "" : giftName%> 
                    </div>
                  </td>
                  <td width="40">&nbsp; 
                    <div align="center">[<span onClick="delgift(<%=show1.getGiftID()%>)" style="cursor: hand;">delete</span>]</div>
                  </td>
                  <td width="42">&nbsp; 
                    <div align="center">[<span style="cursor: hand;">modify</span>]</div>
                  </td>
                  <td width="49">&nbsp; 
                    <div align="center">[<span onClick="giftocn(<%=show1.getGiftID()%>)" style="cursor: hand;">occaion</span>]</div>
                  </td>
                  <td width="43">&nbsp; 
                    <div align="center">[<span onClick="hotbuy(<%=show1.getGiftID()%>)" style="cursor: hand;">hotbuy</span>]</div>
                  </td>
                </tr>
                <%
      } //while i < list.size
      %> 
              </table>
              <input type="hidden" name="gift_ID" value="">
            </form>
    <%
    }// if list != null
    else {
      out.println("<CENTER><font color=red><H2>Data not found!</H2></font><h4>Please try again</h4></CENTER>");
    }
    %>
</body>
</html>

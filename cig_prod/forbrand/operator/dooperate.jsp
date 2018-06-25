<%@ page language="java" errorPage="../login/error.jsp"%>
<% if(session.getAttribute("operator")==null) {%>
<jsp:forward page="../ResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnUserMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../ResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>
<jsp:useBean id="search" scope="request" class="com.forbrand.member.usrmanage"/>
<jsp:useBean id="login" scope="page" class="com.forbrand.member.LoginBean"/>
<jsp:setProperty name="search" property="*"/>
<html><!-- #BeginTemplate "/Templates/operatormenu.dwt" -->
<head>
<title>ForBrand.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
<SCRIPT language=JavaScript>
function js_callpage(htmlurl) {
  var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=566,height=327");
  return false;
}
function js_call() {
  pick_tai=document.tv_form.tai_select.options[document.tv_form.tai_select.selectedIndex].value;
  pick_week=document.tv_form.week_select.options[document.tv_form.week_select.selectedIndex].value;
  parent.window.location.href=pick_tai+"-"+pick_week+"\.html";
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width=758 border=0 cellpadding=0 cellspacing=0>
  <tr> 
    <td> <img src="/images/img-sea/spacer-blu.gif" width=54 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=73 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=443 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=40 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=93 height=1></td>
    <td> <img src="/images/img-sea/spacer-blu.gif" width=35 height=1></td>
    <td> <img src="/images/img-sea/spacer-right.gif" width=20 height=1></td>
  </tr>
  <tr> 
    <td rowspan=2> <a href="../../index.html"><img src="../../images/img-sea/search_01.gif" width=54 height=50 border="0"></a></td>
    <td colspan=6> <img src="../../images/img-sea/search_02.gif" width=704 height=32 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="380,13,458,26" href="../show/portinfo.jsp"><area shape="rect" coords="482,13,555,26" href="../login/myaccount.jsp"><area shape="rect" coords="583,12,692,26" href="../show/cart.jsp"></map></td>
  </tr>
  <tr> 
    <td> <img src="../../images/img-sea/search_03.gif" width=73 height=18></td>
    <td colspan=5> <img src="../../images/img-sea/search_04.gif" width=631 height=18 usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="116,3,204,15" href="../show/showroom.jsp"><area shape="rect" coords="301,4,405,13" href="../show/giftoccasion.jsp?langCode=EN"><area shape="rect" coords="429,3,535,14" href="../login/specialorder.jsp"><area shape="rect" coords="550,3,617,14" href="../show/showinside.jsp?act=4&langCode=EN"><area shape="rect" coords="222,4,284,14" href="../show/showinside.jsp?act=3&langCode=EN"></map></td>
  </tr>
  <tr> 
    <td colspan=3 rowspan=3 background="/images/background1_05.gif"> 
      <blockquote> 
        <p><span class="orange-title1">OPERATOR ACCOUNT:</span><span class="dalei"> 
          <!-- #BeginEditable "subtitle" -->The Result of UserManager Operate<!-- #EndEditable --></span></p>
      </blockquote>
    </td>
    <td colspan=4> <img src="../../images/img-sea/search_06.gif" width=188 height=42 usemap="#Map3" border="0"><map name="Map3"><area shape="rect" coords="13,9,121,22" href="../show/search.jsp"></map></td>
  </tr>
  <tr> 
    <td rowspan=2> <img src="../../images/img-sea/search_07.gif" width=40 height=37></td>
    <form name="form1" action="../show/showinside.jsp" method="post">
      <td bgcolor="#D7D8C0"> 
        <input type="text" name="keyWord" maxlength="20" size="7">
		<input type="hidden" name="langCode" value="EN">
		<input type="hidden" name="act" value="2">
      </td>
    
    <td><input type="image" src="../../images/img-sea/search_09.gif" width=35 height=26 border="0"></td>
	</form>

    <td rowspan=2> <img src="/images/img-sea/search_10.gif" width=20 height=37></td>
  </tr>
  <tr> 
    <td colspan=2> <img src="../../images/img-sea/search_11.gif" width=128 height=11></td>
  </tr>
</table>
<table width="753">
  <tr> 
    <td width="171" height="235" valign="top" align="center"> 
      <p>&nbsp;</p>
      <span class="dalei"><!-- #BeginEditable "imgchange" --><span class="dalei"><img src="../../images/hanging.jpg" width="144" height="101"></span><!-- #EndEditable --><br>
      <br>
      <br>
      <a href="operlog.html" class="xiaolei">Back to My Account 
      Main</a></span> </td>
    <td width="566" height="235" valign="top"><!-- #BeginEditable "mainbody" --> 
      <% if(request.getParameter("checkid")==null||request.getParameter("checkid")=="")
	{ %> 
      <p> </p>
      <p> </p>
      <p align="center"><span class="contact">Sorry!</span></p>
      <p align="center"><span class="contact"> You haven't select a user!</span></p>
      <span class="contact"><%	}
	else
	{	%> <%! String functionid,checkid;
		int updaterow; %> <%	updaterow = 0;
		functionid = request.getParameter("functionid");
		checkid = request.getParameter("checkid");
		if(functionid.compareTo("2")==0)
		{
			updaterow = search.delUsr(checkid);
	%> </span>
      <p align="center"><span class="contact"><b> You have deleted <%=updaterow%> 
        user.</b></span></p>
      <span class="contact"><%
		}
		if(functionid.compareTo("3")==0)
		{
			updaterow = search.verifyUsr(checkid);
		%> </span>
      <p align="center"><span class="contact"><b> You have verified <%=updaterow%> 
        user.</b></span></p>
      <span class="contact"><%	}
		if(functionid.compareTo("4")==0)
		{
			updaterow = search.forbidUsr(checkid); %> </span>
      <p align="center"><span class="contact"><b> You have forbid <%=updaterow%> 
        user.</b></span></p>
     <%	}
		if(functionid.compareTo("1")==0)
		{
                  if(login.getUserInfo(checkid,""))
                    { %>
        	      <div align="center">
                        
        <table width="513" border="1" class="black-m-text">
          <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Login Name:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getLogin()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Title:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getSex()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Firstname:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getFirstname()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Lastname:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getLastname()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>CountryID:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getCountry_ID()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>StateID:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getState_ID()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>City Name:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getCity_ID()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Address:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getAddr()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Zip Code:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getPostCode()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Phone:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getTel()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Fax:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getFax()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Email:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getEmail()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Mobile:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getMobile()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Status:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getStatus()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Discount:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getDiscount()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Amount Buy:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getAmountBuy()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Create day:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getCr_Date()%></td>
                          </tr>
                              <tr>
                            <td width="134" bgcolor="#E1E0EF"><b>Last Modified day:</b></td>
                                <td width="280" bgcolor="#f0f0f0">&nbsp; <%=login.getMd_Date()%></td>
                          </tr>
                            </table>
                      <% }
                      else
                      { %>
            	      
        <p align="center"><b> <span class="contact">Sorry the user had been deleted 
          just now.</span></b></p>
        <span class="contact"><%	}
        }  %> <%	}%> </span></div>
      <p align="center"><span class="contact"><b>Click <a href="#" onclick="window.history.back()">here</a> 
        to back to the Usr Manage.</b></span></p>

<!-- #EndEditable --></td>
  </tr>
</table>
<br>
<table width=758 border=0 cellpadding=0 cellspacing=0>
  <tr> 
    <td> <img src="../../images/img-foot/footer_01.gif" width=376 height=23></td>
    <td> <a href="../../html/aboutus.html"><img src="../../images/img-foot/footer_02.gif" width=65 height=23 border="0"></a></td>
    <td> <a href="../../html/contactus.html"><img src="../../images/img-foot/footer_03.gif" width=76 height=23 border="0"></a></td>
    <td> <a href="../../html/sitemap.html"><img src="../../images/img-foot/footer_04.gif" width=65 height=23 border="0"></a></td>
    <td> <a href="../../html/help.html"><img src="../../images/img-foot/footer_05.gif" width=39 height=23 border="0"></a></td>
    <td> <a href="../../html/privacy.html"><img src="../../images/img-foot/footer_06.gif" width=55 height=23 border="0"></a></td>
    <td> <img src="../../images/img-foot/footer_07.gif" width=82 height=23></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

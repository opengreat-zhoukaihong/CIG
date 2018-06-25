<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
<jsp:useBean id="search" scope="page" class="com.forbrand.member.usrmanage"/> 
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
          <!-- #BeginEditable "subtitle" -->The result of &quot;Search 
          User&quot; <!-- #EndEditable --></span></p>
      </blockquote>
    </td>
    <td colspan=4> <img src="../../images/img-sea/search_06.gif" width=188 height=42 usemap="#Map3" border="0"><map name="Map3"><area shape="rect" coords="13,9,121,22" href="../show/search.jsp"></map></td>
  </tr>
  <tr> 
    <td rowspan=2> <img src="../../images/img-sea/search_07.gif" width=40 height=37></td>
    <form name="form1" action="../show/showinside.jsp">
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
      <p>&nbsp;</p>
	  <form action="dooperate.jsp" name="form3" method="post">
        <table align="center" width="515" border="1">
    <%! String from,to,tel,email,status,type; %> 
		<%! String usrs[]; %> 
		<%! int i,row,pageno,totalpage,pagelist,beginno,endno; %> 
    <%	from = request.getParameter("from");
			to = request.getParameter("to");
			tel = request.getParameter("tel");
			email = request.getParameter("email");
			status = request.getParameter("status");
			type = request.getParameter("type");
			pageno = (Integer.valueOf(request.getParameter("page"))).intValue();
		%> 
          <tr class="white-title"> 
            <td bgcolor="#003399"><b><font color="#CCCCCC">Check</font></b></td>
          <td bgcolor="#003399"><b><font color="#CCCCCC">Login</font></b></td>
          <td bgcolor="#003399"><b><font color="#CCCCCC">Name</font></b></td>
          <td bgcolor="#003399"><b><font color="#CCCCCC">Tel</font></b></td>
          <td bgcolor="#003399"><b><font color="#CCCCCC">Email</font></b></td>
        </tr>
	<% if(type!=null)
		{%>		
		<% if(type.compareTo("2")==0)
			{ 
				search.searchUsr(from,to,tel,email,status); 
		%> 
			<% row = search.getRow(); %> 
    	    <% usrs = search.getUsrs(); %> 
			<% pagelist = 10; %>
			<% totalpage = row/pagelist+(row%pagelist==0?0:1); %>
			<% beginno = (pageno-1)*pagelist; %>
			<% endno = ((beginno+pagelist)<row?(beginno+pagelist):row); %>
			<% session.setAttribute("usrs",usrs); %> 
<%			}
			else
			{	beginno=0;
				if(login.getUserInfo(request.getParameter("login"),""))
				{	endno = 1; }
				else
				{	endno = 0; } 
			}%>
		<% for(i=beginno;i<endno;i++) 
			{	%> 
			<% 	if(type.compareTo("2")==0)
				{
					login.getUserInfo(usrs[i],""); 
				}	%> 
    	    <tr bgcolor="#E1E0EF" id="listtable"> 
   		       
            <td bgcolor="#E1E0EF"><b>
<input type="radio" name="checkid" value="<jsp:getProperty name='login' property='login'/>">
              </b></td>
   		       <td><b><jsp:getProperty name='login' property='login'/></b></td>
   		       <td><b><jsp:getProperty name='login' property='firstname'/> <jsp:getProperty name='login' property='lastname'/></b></td>
   		       <td><b><jsp:getProperty name='login' property='tel'/></b></td>
   		       <td><b><jsp:getProperty name='login' property='email'/></b></td>
  		      </tr>
  	   <%	}	%> 
<%		 } 
		else
		{ %>
	    <% usrs = (String[])session.getAttribute("usrs"); %> 
		<% row = usrs.length; %> 
		<% pagelist = 10; %>
		<% totalpage = row/pagelist+(row%pagelist==0?0:1); %>
		<% beginno = (pageno-1)*pagelist; %>
		<% endno = ((beginno+pagelist)<row?(beginno+pagelist):row); %>
		<% for(i=beginno;i<endno;i++) 
			{	
				login.getUserInfo(usrs[i],""); %> 
    		    <tr bgcolor="#E1E0EF" id="listtable"> 
		          <td><b><input type="radio" name="checkid" value="<jsp:getProperty name='login' property='login'/>"></b></td>
        		  <td><b><jsp:getProperty name='login' property='login'/></b></td>
		          <td><b><jsp:getProperty name='login' property='firstname'/> <jsp:getProperty name='login' property='lastname'/></b></td>
        		  <td><b><jsp:getProperty name='login' property='tel'/></b></td>
		          <td><b><jsp:getProperty name='login' property='email'/></b></td>
        		</tr>
	     <%	}	%> 
<%		 } %>	
      </table>
	  <div align="center">
	  <script language="JavaScript">
	  	function first()
		{
			document.all.page.value=1
			document.form2.submit()
		}
		function last()
		{
			document.all.page.value=<%=totalpage%>
			document.form2.submit()
		}
		function prevp()
		{
			document.all.page.value=((<%=pageno%>-1)<1?1:(<%=pageno%>-1))
			document.form2.submit()
		}
		function nextp()
		{
			document.all.page.value=((<%=pageno%>+1)><%=totalpage%>?<%=totalpage%>:(<%=pageno%>+1))
			document.form2.submit()
		}
	  
	  </script>
	  </div>


	  <div align="center">
        <p>&nbsp;</p>
          <p><b> <span class="orange-title">
            <input type="radio" name="functionid" value="1" checked>
            View Detail 
            <input type="radio" name="functionid" value="2">
            Delete User 
            <input type="radio" name="functionid" value="3">
            Verify User 
            <input type="radio" name="functionid" value="4">
            Forbid User</span></b><span class="orange-title"><br>
            </span> </p>
		  <p>
            <input type="image" border="0" name="imageField" src="../../images/submit-buttom.jpg" width="68" height="25">
          </p>
      </div>
      </form>
<% 	if(type==null||type.compareTo("2")==0)
	{	%>
	  <form action="searchresult.jsp" name="form2" method="post">
	  <input type="hidden" name="page" value="1">
	  <input type="hidden" name="totalpage" value="<%=totalpage%>">
	  
	    <p align="center"><b class="contact"> <%=pageno%>/<%=(totalpage<=1?1:totalpage)%> 
          <font onClick="first()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">first 
          page</font> | <font onClick="prevp()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">previous 
          page</font> | <font onClick="nextp()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">next 
          page</font> | <font onClick="last()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">last 
          page</font> </b></p>
      </form>	
<%	}	%>
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

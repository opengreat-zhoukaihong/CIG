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
  funcID = "fnConsultMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../ResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>
<jsp:useBean id="consult" scope="page" class="com.forbrand.member.consultation"/>
<jsp:useBean id="usrconsult" scope="request" class="com.forbrand.member.userConsultation"/>

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
          <!-- #BeginEditable "subtitle" -->Question List<!-- #EndEditable --></span></p>
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

    <%! String from,to,status,userid; %>
	<%! String consultid[]; %>
	<%! int i,row,pageno,totalpage,pagelist,beginno,endno; %>
    <%	from = request.getParameter("from");
		pageno = (Integer.valueOf(request.getParameter("page"))).intValue();
	%>
      <form name="form3" method="post">
        <table width="523" align="center" border="1" class="black-m-text">
          <tr class="white-title" bgcolor="#003399"> 
            <td><font color="#f0f0f0">&nbsp;Answer</font></td>
            <td><font color="#f0f0f0">&nbsp;userid</font></td>
            <td><font color="#f0f0f0">&nbsp;giftno</font></td>
            <td><font color="#f0f0f0">&nbsp;content</font></td>
            <td><font color="#f0f0f0">&nbsp;answer</font></td>
            <td><font color="#f0f0f0">&nbsp;consultDate</font></td>
            <td><font color="#f0f0f0">&nbsp;replyDate</font></td>
          </tr>
          <% if(from!=null)
	{	
		to = request.getParameter("to");
		userid = request.getParameter("userid");
		status = request.getParameter("status");
%> <% row = consult.searchQuestion(userid,status,from,to); %> <% consultid = consult.getConsultid(); %> 
          <% pagelist = 10; %> <% totalpage = row/pagelist+(row%pagelist==0?0:1); %> <% beginno = (pageno-1)*pagelist; %> 
          <% endno = ((beginno+pagelist)<row?(beginno+pagelist):row); %> <% session.setAttribute("consultid",consultid); %> 
          <%	}
	else
	{	%> <% consultid = (String[])session.getAttribute("consultid"); %> <% row = consultid.length; %> 
          <% pagelist = 10; %> <% totalpage = row/pagelist+(row%pagelist==0?0:1); %> <% beginno = (pageno-1)*pagelist; %> 
          <% endno = ((beginno+pagelist)<row?(beginno+pagelist):row); %> <%	}	%> 
          <% for(i=beginno;i<endno;i++)
		{ usrconsult.getConsult(consultid[i]);%> 
          <tr class="black-m-text" bgcolor="#E1E0EF"><b> 
            <td> 
              <input type="Checkbox" value="<%=consultid[i]%>" onClick="answer(this.value,this)">
            </td>
            <td>&nbsp;<%=usrconsult.getUser_ID()%></td>
            <td>&nbsp;<%=usrconsult.getGift_NO()%></td>
            <td>&nbsp;<%=usrconsult.getContent()%></td>
            <td>&nbsp;<%=usrconsult.getAnswer()%></td>
            <td>&nbsp;<%=usrconsult.getConsulDate()%></td>
            <td>&nbsp;<%=usrconsult.getReplyDate()%></td>
            </b> </tr>
          <%	}	%> 
        </table>
      </form>
	<script language="JavaScript1.1">
		function answer(vstr,ostr)
		{
            var urlstr = "answer.jsp?consultation="+vstr+""
            js_callpage(urlstr)
			ostr.checked = true
		}
	  	function first()
		{
			document.form2.page.value=1
			document.form2.submit()
		}
		function last()
		{
			document.form2.page.value=<%=totalpage%>
			document.form2.submit()
		}
		function prevp()
		{
			document.form2.page.value=((<%=pageno%>-1)<1?1:(<%=pageno%>-1))
			document.form2.submit()
		}
		function nextp()
		{
			document.form2.page.value=((<%=pageno%>+1)><%=totalpage%>?<%=totalpage%>:(<%=pageno%>+1))
			document.form2.submit()
		}
	</script>
	  <form action="consultlist.jsp" name="form2" method="post">
	  <input type="hidden" name="page" value="<%=pageno%>">

	    <p align="center" class="contact"><b> <%=pageno%>/<%=(totalpage<=1?1:totalpage)%> 
          <font onClick="first()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">first 
          page</font> | <font onClick="prevp()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">previous 
          page</font> | <font onClick="nextp()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">next 
          page</font> | <font onClick="last()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">last 
          page</font> </b></p>
      </form>
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

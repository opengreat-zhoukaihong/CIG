<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<% if(session.getAttribute("userid")==null) {%>
<jsp:forward page="../ResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="consult" scope="page" class="com.forbrand.member.consultation"/>
<jsp:useBean id="usrconsult" scope="page" class="com.forbrand.member.userConsultation"/>
<% if(request.getParameter("consultation")!=null)
	{
		consult.deleteQuestion(request.getParameter("consultation"));
	}	%>
<html><!-- #BeginTemplate "/Templates/usermenu.dwt" -->
<head>
<!-- #BeginEditable "doctitle" -->
<title>ForBrand.com</title>
<!-- #EndEditable --> 
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
    <td colspan=6> <img src="../../images/img-sea/search_02.gif" width=704 height=32 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="380,13,458,26" href="../show/portinfo.jsp"><area shape="rect" coords="482,13,555,26" href="myaccount.jsp"><area shape="rect" coords="583,12,692,26" href="../show/cart.jsp"></map></td>
  </tr>
  <tr> 
    <td> <img src="../../images/img-sea/search_03.gif" width=73 height=18></td>
    <td colspan=5> <img src="../../images/img-sea/search_04.gif" width=631 height=18 usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="116,3,204,15" href="../show/showroom.jsp"><area shape="rect" coords="301,4,405,13" href="../show/giftoccasion.jsp?langCode=EN"><area shape="rect" coords="429,3,535,14" href="specialorder.jsp"><area shape="rect" coords="550,3,617,14" href="../show/showinside.jsp?act=4&langCode=EN"><area shape="rect" coords="222,4,284,14" href="../show/showinside.jsp?act=3&langCode=EN"></map></td>
  </tr>
  <tr> 
    <td colspan=3 rowspan=3 background="/images/background1_05.gif"> 
      <blockquote> 
        <p><span class="orange-title1">MY ACCOUNT</span>:<span class="dalei"><!-- #BeginEditable "subtitle" --> MANAGE MY ACCOUNT<!-- #EndEditable --></span></p>
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
    <td rowspan=2> <img src="../../images/img-sea/search_10.gif" width=20 height=37></td>
  </tr>
  <tr> 
    <td colspan=2> <img src="/images/img-sea/search_11.gif" width=128 height=11></td>
  </tr>
</table>
<table width="753" border="0">
  <tr> 
    <td width="180" height="235" valign="top" align="center"> 
      <p><span class="dalei"><!-- #BeginEditable "imgchange" --><span class="dalei"><img src="../../images/hanging.jpg" width="144" height="101"></span><!-- #EndEditable --><br>
        <br>
        <br>
        <a href="afterlog.html" class="xiaolei">Back to My Account 
        Main</a></span></p>
    </td>
    <td width="566" height="235" valign="top"><!-- #BeginEditable "mainbody" -->
	<%! String[] consultid; %>
	<%! int row,i; %>
	<% row = consult.searchAnswer((String)session.getAttribute("userid")); %>
	<% consultid = consult.getConsultid(); %>
	<form name="listform" method="post">
        <table border="1" width="499" align="center" class="black-m-text">
          <tr bgcolor="#003399" class="white-title"> 
            <td><font color="#E1E0EF">&nbsp;Delete</font></td>
            <td><font color="#E1E0EF">&nbsp;Gift_NO</font></td>
            <td><font color="#E1E0EF">&nbsp;Question</font></td>
            <td><font color="#E1E0EF">&nbsp;Answer</font></td>
            <td><font color="#E1E0EF">&nbsp;Consult_Date</font></td>
          </tr>
          <% for(i=0;i<row;i++)
		{ usrconsult.getConsult(consultid[i]); %> 
          <tr class="black-m-text" bgcolor="#E1E0EF"> <b> 
            <td> 
              <input type="radio" name="consultation" value="<%=consultid[i]%>" onClick="deletequestion()">
            </td>
            <td>&nbsp;<%=usrconsult.getGift_NO()%></td>
            <td>&nbsp;<%=usrconsult.getContent()%> </td>
            <td>&nbsp;<%=usrconsult.getAnswer()%></td>
            <td>&nbsp;<%=usrconsult.getConsulDate()%></td>
            </b>
          </tr>
          <%	}	%> 
        </table>
	  </form>
	<script language="JavaScript">
		function deletequestion()
		{
			var ifdel = confirm("Are you sure to delete this question?")
			if(ifdel)
			{
				document.listform.submit()
			}

		}
	</script>

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

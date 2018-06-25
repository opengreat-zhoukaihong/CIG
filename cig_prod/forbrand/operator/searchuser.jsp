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
          <!-- #BeginEditable "subtitle" -->Search User.<!-- #EndEditable --></span></p>
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
      <script src="/js/formcheck.js"></script>
      <script language="JavaScript">
	function chkAll3()
	{
		if(!isValidChar(document.form3.login.value))
		{
			alert("Login name should not have invalid characters!")
			return false
		}
		return true
	}
	
	function chkAll2()
	{
		if(!isNumber(document.form2.from.value))
		{
			alert("'From' should be a number!")
			return false
		}
		if(!isNumber(document.form2.to.value))
		{
			alert("'To' should be a number!")
			return false
		}
  		<!-- then transmit the datas -->
		return true
	}
	</script>
        <table width="508" border="0" align="center" class="black-m-text">
          <tr>
            <td colspan="3">
              <div align="center"><b><font size="+1">Search User</font></b></div>
              <div align="left"></div>
              <div align="left"> </div>
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <table width="494" border="0" align="center">
      <form name="form3" method="post" action="searchresult.jsp" onSubmit="return chkAll3()">
                <tr>
                  <td colspan="2" class="orange-title"><b> 
                    <font color="#000066">Search by single-condition:</font></b></td>
                </tr>
                <tr>
                  <td>
                    <div align="left"><b>Login Name:</b> </div>
                  </td>
                  <td>
                    <input type="text" name="login" size="20" maxlength="20">
                  </td>
                </tr>
                <tr>
                  <td colspan="2">
                    <div align="center">
										<input type="image" src="../../images/find-buttom.jpg" border="0">
										</div>
										<input type="Hidden" name="type" value="1">
										<input type="hidden" name="page" value="1">
                  </td>
                </tr>
								
                <tr>
                  <td colspan="2" class="orange-title"> <b> 
                    <font color="#000066"> Search by multi-condition:</font></b></td>
                </tr>
			</form>
      <form name="form2" method="post" action="searchresult.jsp" onSubmit="return chkAll2()">
                
								<tr>
                  <td>
                    <div align="center"></div>
                    <b>Amount Buy: </b></td>
                  <td> <b>from
                    <input type="text" name="from" size="10" value="">
                    to
                    <input type="text" name="to" size="10" value="">
                    </b></td>
                </tr>
                <tr>
                  <td><b>Telphone:</b></td>
                  <td> <b>
                    <input type="text" name="tel" value="">
                    </b></td>
                </tr>
                <tr>
                  <td>
                    <div align="left"><b>Email:</b></div>
                  </td>
                  <td><b>
                    <input type="text" name="email" value="">
                    </b></td>
                </tr>
                <tr>
                  <td><b>Account Status:</b></td>
                  <td><div id="stext"><b>
                    <input type="radio" name="status" value="V" checked>
                    Valid
                    <input type="radio" name="status" value="F">
                    Forbidden </b>
					<input type="hidden" name="page" value="1"></div>
					</td>
                </tr>
                <tr>
                  <td colspan="2">
                    <div align="center"><input type="image" src="../../images/find-buttom.jpg" border="0">
										</div>
                  </td>
                </tr>
					<input type="Hidden" name="type" value="2">

      </form>

              </table>

            </td>
          </tr>
        </table>
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

<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>

<html><!-- #BeginTemplate "/Templates/ceoa.dwt" -->
<head>
<!-- #BeginEditable "doctitle" -->
<title>ChinaEOA.com</title>
<!-- #EndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
<script
language="JavaScript">
<!--
img1on = new Image();
img1on.src = "/images/temp/menu_1_0.gif";
img2on = new Image();
img2on.src = "/images/temp/menu_2_0.gif";
img3on = new Image();
img3on.src = "/images/temp/menu_3_0.gif";
img4on = new Image();
img4on.src = "/images/temp/menu_4_0.gif";
img5on = new Image();
img5on.src = "/images/temp/menu_5_0.gif";
img6on = new Image();
img6on.src = "/images/temp/menu_6_0.gif";
img7on = new Image();
img7on.src = "/images/temp/menu_r07_c1_f2.gif";
img8on = new Image();
img8on.src = "/images/temp/menu_r08_c1_f2.gif";
img9on = new Image();
img9on.src = "/images/temp/menu_r09_c1_f2.gif";
img0on = new Image();
img0on.src = "/images/temp/menu_r10_c1_f2.gif";
img1off = new Image();
img1off .src = "/images/temp/menu_1.gif";
img2off = new Image();
img2off .src = "/images/temp/menu_2.gif";
img3off = new Image();
img3off .src = "/images/temp/menu_3.gif";
img4off = new Image();
img4off .src = "/images/temp/menu_4.gif";
img5off = new Image();
img5off .src = "/images/temp/menu_5.gif";
img6off = new Image();
img6off .src = "/images/temp/menu_6.gif";
img7off = new Image();
img7off .src = "/images/temp/menu_7.gif";
img8off = new Image();
img8off .src = "/images/temp/menu_r08_c1.gif";
img9off = new Image();
img9off .src = "/images/temp/menu_r09_c1.gif";
img0off = new Image();
img0off .src = "/images/temp/menu_r10_c1.gif";
function imgOn (imgName) {
if (document.images) {
document[imgName].src = eval (imgName + "on.src");
}
}
function imgOff (imgName) {
if (document.images) {
document[imgName].src = eval(imgName + "off.src");
}
}
function MM_preloadImages() { //v3.0
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

  function nextStep()
  {
    if(document.member.memberTypeCheck.checked)
    {
      document.member.memberType.value = "4";
    }
    else
    {
      document.member.memberType.value = "3";
    }
  }
//-->
</script>

<%!
    String country,province,city,compName,compAddr,zipCode,telephone,fax;
    String compSize,lawRep,compType,bankAccount,bank,taxAccount;
    String contName,contSex,contDept,contTitle,contEmail;
    String userID,passwd,question,answer,memberType;
%>
<%
    memberType = request.getParameter("memberType").trim();
    country = request.getParameter("country").trim();
    province = request.getParameter("province").trim();
    city = request.getParameter("city").trim();
    compName = request.getParameter("compName").trim();
    compAddr = request.getParameter("compAddr").trim();
    zipCode = request.getParameter("zipCode").trim();
    telephone = request.getParameter("telephone").trim();
    fax = request.getParameter("fax").trim();
    if(fax==null)
      fax = "";
    compSize = request.getParameter("compSize").trim();
    lawRep = request.getParameter("lawRep").trim();
    compType = request.getParameter("compType").trim();
    bankAccount = request.getParameter("bankAccount").trim();
    bank = request.getParameter("bank").trim();
    taxAccount = request.getParameter("taxAccount").trim();
    contName = request.getParameter("contName").trim();
    contSex = request.getParameter("contSex").trim();
    contDept = request.getParameter("contDept").trim();
    if(contDept==null)
      contDept = "";
    contTitle = request.getParameter("contTitle").trim();
    if(contTitle==null)
      contTitle = "";
    contEmail = request.getParameter("contEmail").trim();
    userID = request.getParameter("userID").trim();
    passwd = request.getParameter("passwd1").trim();
    question = request.getParameter("question").trim();
    answer = request.getParameter("answer").trim();

    session.putValue("tempUserID",userID);
    session.putValue("tempPasswd",passwd);
    session.putValue("tempQuestion",question);
    session.putValue("tempAnswer",answer);

%>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr> 
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/title.js">
</script>
<table width="640" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" colspan="2"><!-- #BeginEditable "body" --> 
      <table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td width="40"><img src="/images/spacer.gif" width="40" height="1"></td>
          <td>
             <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr> 
                <td height="30"><img src="/images/temp/path.gif" width="49" height="13"> 
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">首页</a> 
                  <img src="/images/arrow.gif" width="7" height="11"> <font title="里边有什么好东西呢"> 
                  选择用户类别</font></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF">
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center">选择用户类别</td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
              </tr>
              <tr bgcolor="#000066"> 
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">

              <form name="member" method="post" action="addNewMember.jsp" onSubmit="nextStep()">
                <tr bgcolor="#F4FCFF">
                  <td height="30" colspan="2" align="center">
                    <font color="#CC0000" bgcolor="#DFEEFF">如果您想申请成为我们的经销商,请选中下面的选项.
                    </font>
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF">
                  <td align="center" bgcolor="#DFEEFF">
                    <input type="checkbox" name="memberTypeCheck">我想成为ChinaEOA的经销商

                      <input type="hidden" name="memberType" value="<%=memberType%>">
                      <input type="hidden" name="country" value="<%=country%>">
                      <input type="hidden" name="province" value="<%=province%>">
                      <input type="hidden" name="city" value="<%=city%>">
                      <input type="hidden" name="compName" value="<%=compName%>">
                      <input type="hidden" name="compAddr" value="<%=compAddr%>">
                      <input type="hidden" name="zipCode" value="<%=zipCode%>">
                      <input type="hidden" name="telephone" value="<%=telephone%>">
                      <input type="hidden" name="fax" value="<%=fax%>">
                      <input type="hidden" name="compSize" value="<%=compSize%>">
                      <input type="hidden" name="lawRep" value="<%=lawRep%>">
                      <input type="hidden" name="compType" value="<%=compType%>">
                      <input type="hidden" name="bankAccount" value="<%=bankAccount%>">
                      <input type="hidden" name="bank" value="<%=bank%>">
                      <input type="hidden" name="taxAccount" value="<%=taxAccount%>">
                      <input type="hidden" name="contName" value="<%=contName%>">
                      <input type="hidden" name="contSex" value="<%=contSex%>">
                      <input type="hidden" name="contDept" value="<%=contDept%>">
                      <input type="hidden" name="contTitle" value="<%=contTitle%>">
                      <input type="hidden" name="contEmail" value="<%=contEmail%>">
                   </td>
                  <td bgcolor="#DFEEFF">
                  </td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#F4FCFF">&nbsp;&nbsp; </td>
                  <td bgcolor="#F4FCFF">&nbsp;&nbsp;
                     </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF">&nbsp;&nbsp;</td>
                  <td bgcolor="#DFEEFF"> 
                    &nbsp;&nbsp;</td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#F4FCFF">&nbsp;&nbsp;</td>
                  <td bgcolor="#F4FCFF"> &nbsp;&nbsp;
                  </td>
                </tr>
                <tr>
                  <td colspan="2" align="center" bgcolor="#DFEEFF">
                    <input type="image" img src="/images/temp/b_next.gif" name="cancel2"  class="font1" width="80" height="17" >
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  </td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td colspan="2">&nbsp;</td>
                </tr>
                <tr bgcolor="#000066"> 
                  <td colspan="2" height="1"><img src="/images/spacer.gif" width="1" height="1"></td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>

</body>
<!-- #EndTemplate --></html>


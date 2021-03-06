<%@ page import="java.util.*, java.sql.*,java.io.*,java.net.URLDecoder" session="true" language="java" errorPage="error.jsp"%>
<%!
    String highLevel = "5";
    String userType,userLevel,eoaLoginID;
    // userType 1:EOA; 2:individual; 3:company; 4:dealer; 5:supplier; 6:supplier&dealer;
    // userLevel 1: normal user; 5: powerUser;
%>
<%

    eoaLoginID = (String)session.getValue("cneoa.UserId");
    userLevel = (String)session.getValue("cneoa.UserLevel");
    userType = (String)session.getValue("cneoa.MemberType");

    if(eoaLoginID == null)    // can not get the loginID from session
    {
%>
      <jsp:forward page="loginIdError.jsp" />
<%
    }
    else
    {
      if(!(highLevel.equals(userLevel)))      // the user is not a power user
      {
%>
      <jsp:forward page="permError.jsp" />
<%        
      }
      else
      {
        if(!("1".equals(userType)))
        {
%>
      <jsp:forward page="permError.jsp" />
<%        
        }
      }
    }

%>


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

  function validateForm(formName)
  {
    if(confirm("确实要修改吗?"))
      return true;
    else
      return false;
  }

//-->
</script>

<jsp:useBean id="creditManager" scope="page" class="com.cig.chinaeoa.member.CreditManager" />
<%!
    ResultSet paymentInfo,supplierInfo;
    String memberID,memberName,supplierID,supplierName,memberClass;
    String lang_code = "GB";
    String tempSqlStr;
%>
<%
        memberID = request.getParameter("memberID");
        supplierID = request.getParameter("supplierID");
        supplierName = URLDecoder.decode(request.getParameter("supplierName"));

        tempSqlStr = "select ml.compName,p.class " +
          " from payment p,member_l ml " +
          " where p.memberID='" + memberID + "' and p.supplierID='" + supplierID +
          "' and ml.memberID=p.memberID and ml.lang_code='" + lang_code +"'";

        creditManager.setSqlStr(tempSqlStr);
        paymentInfo = creditManager.checkDatas();
        if(paymentInfo != null)
        {
          if(paymentInfo.next())
          {
            memberName = paymentInfo.getString("compName");
            memberClass = paymentInfo.getString("class");
          }
          creditManager.disconn();

          if(memberClass == null)
            memberClass = "1";
        }
%>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif" >
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
                  <a href="MyEoa.jsp">MyEoa</a> <img src="/images/arrow.gif" width="7" height="11"> 
                  <font title="里边有什么好东西呢"> 修改用户级别</font></font></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF"> 
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center" bgcolor="#99CCFF">修改用户<font title="里边有什么好东西呢">级别</font></td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
              </tr>
              <tr bgcolor="#000066"> 
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">

              <form name="modifyCredit" method="post" action="modifyClassResult.jsp" onSubmit="return validateForm(modifyCredit)">

                <tr> 
                  <td height="30" colspan="2" align="center" bgcolor="#F4FCFF">公司名称：<%=memberName%></td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#DFEEFF">供 应 商：</td>
                  <td bgcolor="#DFEEFF"><%=supplierName%></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#F4FCFF">&nbsp;</td>
                  <td bgcolor="#F4FCFF">&nbsp; 
                  </td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#DFEEFF">用户级别：</td>
                  <td bgcolor="#DFEEFF">
                    <select name="memberClass">
                <%
                    for(int i=1;i<6;i++)
                    {
                      if(memberClass.equals(String.valueOf(i))) {
                %>
                        <option value="<%=i%>" selected><%=i%>级用户</option>
                <%
                      } else {
                %>
                        <option value="<%=i%>" ><%=i%>级用户</option>
                <%    }
                    }

                %>

                    </select>


                    <input type="hidden" name="memberID" value="<%=memberID%>">
                    <input type="hidden" name="supplierID" value="<%=supplierID%>">
                    <input type="hidden" name="compName" value="<%=memberName%>" >

                  </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF" colspan="2">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2" align="center" bgcolor="#DFEEFF"> 
                    <input type="image" src="/images/temp/b_modify.gif" name="cancel2" value="取   消" class="font1" width="80" height="17">

                  </td>
                </tr>
                <tr> 
                  <td colspan="2" align="center">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2" bgcolor="#F4FCFF"> 
                  </td>
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

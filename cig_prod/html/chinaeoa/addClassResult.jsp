<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
<%!
    String highLevel = "5";
    String userType,userLevel,eoaLoginID;
    // userType 1:EOA; 2:individual; 3:company; 4:dealer; 5:supplier; 6:supplier&dealer;
    // userLevel 0: normal user; 1: powerUser;    
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


<html>
<!-- #BeginTemplate "/Templates/ceoa.dwt" --> 
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
//-->
</script>

<script><!--
  function goBack()
  {
    document.browseList.submit();
  }
//-->
</script>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<jsp:useBean id="creditManager" scope="page" class="com.cig.chinaeoa.member.CreditManager" />
<%!
    ResultSet paymentInfo;
    String memberID,supplierID,memberClass,compName;
    String tempSqlStr;
    int errorCode;
%>


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
      <table width="667" border="0" cellpadding="0" cellspacing="0" height="300">
        <tr align="center"> 
          <td class="font4b">

<%
        compName = request.getParameter("compName");

        memberID = request.getParameter("memberID");
        supplierID = request.getParameter("supplierID");
        memberClass = request.getParameter("memberClass");

        tempSqlStr = "select memberID from payment where memberID='" + memberID +
          "' and supplierID = '" + supplierID + "'";

        creditManager.setSqlStr(tempSqlStr);
        paymentInfo = creditManager.checkDatas();
        if(paymentInfo.next())
        {
          creditManager.disconn();
%>

            <p>很抱歉!该供应商和经销商的用户已设置过了！</p>
            <p>如果要更改用户级别,请选择更改用户级别菜单!</p>
            <p><a href="javascript:history.go(-1);">返回</a></p>
<%
        }
        else
        {
          creditManager.disconn();

          tempSqlStr = "insert into payment (memberID,supplierID,class, " +
            " creditAmount,amountUsed,pay_term,cr_date,md_date) values ('" +
            memberID + "','" + supplierID +
            "','" + memberClass + "','0','0','0',sysdate,sysdate )";

          creditManager.setSqlStr(tempSqlStr);
          creditManager.updatePayment();
          errorCode = creditManager.getErrorCode();

          if(errorCode == 0)
          {
%>
            <p>增加操作成功！</p>
            <p><a href="javascript:goBack();">返回</a></p>
<%
          }
          else
          {
%>
            <p>增加操作失败！</p>
            <p><a href="javascript:history.go(-1);">返回</a></p>
<%
          }
        }
%>

          </td>
        </tr>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>

<form name="browseList" method="post" action="addClass.jsp">
  <input type="hidden" name="memberID" value="<%=memberID%>">
  <input type="hidden" name="compName" value="<%=compName%>" >
</form>

</body>
<!-- #EndTemplate -->
</html>

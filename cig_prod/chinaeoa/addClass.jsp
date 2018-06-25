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
  }

//-->
</script>


</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<jsp:useBean id="creditManager" scope="page" class="com.cig.chinaeoa.member.CreditManager" />
<%!
    ResultSet paymentInfo,supplierInfo;
    String memberID,compName,supplierName;
    Vector v_supplierID = new Vector();
    Vector v_supplierName = new Vector();
    String tempSqlStr;
%>
<%

        if(!v_supplierID.isEmpty())
          v_supplierID.removeAllElements();
        if(!v_supplierName.isEmpty())
          v_supplierName.removeAllElements();

        supplierInfo = creditManager.getSupplierInfo();
        while(supplierInfo.next())
        {
          v_supplierID.addElement(supplierInfo.getString("supplierID"));
          v_supplierName.addElement(supplierInfo.getString("compName"));
        }
        creditManager.disconn();

        memberID = request.getParameter("memberID");
        compName = URLDecoder.decode(request.getParameter("compName"));
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
      <table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td width="40"><img src="/images/spacer.gif" width="40" height="1"></td>
          <td>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr> 
                <td height="30"><img src="/images/temp/path.gif" width="49" height="13"> 
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">首页</a> 
                  <img src="/images/arrow.gif" width="8" height="11"> <font title="里边有什么好东西呢"> 
                  <a href="MyEoa.jsp">MyEoa</a><img src="/images/arrow.gif" width="8" height="11"> 
                  <font title="里边有什么好东西呢"> 分配用户级别</font></font></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF"> 
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center" bgcolor="#99CCFF">分配用户<font title="里边有什么好东西呢">级别</font></td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
              </tr>
              <tr bgcolor="#000066"> 
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">

              <form name="addPayment" method="post" action="addClassResult.jsp" onSubmit="return validateForm(addPayment)">
                <tr> 
                  <td height="30" colspan="2" align="center" bgcolor="#F4FCFF">公司名称：<%=compName%></td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#DFEEFF">供 应 商：</td>
                  <td bgcolor="#DFEEFF"> 
                    <select name="supplierID">

<% for(int i=0;i<v_supplierID.size();i++) { %>

  <option value="<%=v_supplierID.elementAt(i)%>"><%=v_supplierName.elementAt(i)%>

<%  }   %>
                    </select>

                  </td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#F4FCFF">用户级别：</td>
                  <td bgcolor="#F4FCFF">
                    <select name="memberClass">
                      <option value="1">一级用户</option>
                      <option value="2">二级用户</option>
                      <option value="3">三级用户</option>
                      <option value="4">四级用户</option>
                      <option value="5">五级用户</option>
                    </select>
                    <input type="hidden" name="memberID" value="<%=memberID%>">
                    <input type="hidden" name="compName" value="<%=compName%>">
                  </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#DFEEFF">&nbsp;</td>
                  <td bgcolor="#DFEEFF">&nbsp; 
                  </td>
                </tr>

                <tr>
                  <td colspan="2" align="center" bgcolor="#F4FCFF"> 
                    <input type="image" src="/images/temp/b_add.gif" name="cancel2" value="取   消" class="font1" width="80" height="17">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                  </td>
                </tr>
                <tr> 
                  <td colspan="2" align="center">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2" bgcolor="#F4FCFF"> 
                    <table width="500" border="0" cellspacing="0" cellpadding="0">
                      <tr align="center"> 
                        <td bgcolor="#99CCFF" height="20">供 应 商</td>
                        <td bgcolor="#99CCFF" height="20">用户级别</td>
                      </tr>
<%

        creditManager.setMemberID(memberID);
        paymentInfo = creditManager.getPaymentInfo();

        if(paymentInfo != null)
        {
          while(paymentInfo.next())
          {
%>

                      <tr align="center">
                        <td><%= paymentInfo.getString("compName") %></td>
                        <td><%= paymentInfo.getString("class") %></td>
                      </tr>
<%
          }
          creditManager.disconn();
        }

%>                      
                      <tr align="center">
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>
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

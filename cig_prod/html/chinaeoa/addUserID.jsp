<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
<%!
    String highLevel = "5";
    String userLevel,eoaLoginID;
    // userLevel 1: normal user; 5: power user;
%>
<%
    eoaLoginID = (String)session.getValue("cneoa.UserId");
    userLevel = (String)session.getValue("cneoa.UserLevel");

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
    if(formName.userID.value.length<4||formName.userID.value.length>20)
    {
      alert("输入的用户名无效,请重新输入!");
      formName.userID.focus();
      return false;
    }
    if(formName.passwd1.value.length<6||formName.passwd1.value.length>20)
    {
      alert("输入的密码无效,请重新输入!");
      formName.passwd1.value="";
      formName.passwd1.focus();
      return false;
    }
    if(formName.passwd1.value!=formName.passwd2.value)
    {
      alert("您的密码与确认密码不符!");
      formName.passwd1.value="";
      formName.passwd2.value="";
      formName.passwd1.focus();
      return false;
    }
 }

//-->
</script>


</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">


<jsp:useBean id="userManager" scope="page" class="com.cig.chinaeoa.member.UserManager" />
<%!
    ResultSet userInfo;
    String loginID,userID,memberID;
    String tempSqlStr;
%>
<%
        loginID = (String)session.getValue("cneoa.UserId");
        tempSqlStr = "select memberID from users where userID = '" +
          loginID + "'";
        userManager.setSqlStr(tempSqlStr);
        userInfo = userManager.getDatas();
        if(userInfo != null)
        {
          if(userInfo.next())
          {
            memberID = userInfo.getString("memberID");
          }
          userManager.disconn();
        }
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
      <table width="550" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td width="40"><img src="/images/spacer.gif" width="40" height="8"></td>
          <td>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr>
                <td height="30"><img src="/images/temp/path.gif" width="49" height="13"> 
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">首页</a> 
                  <img src="/images/arrow.gif" width="7" height="11"> <font title="里边有什么好东西呢"> 
                  <a href="MyEoa.jsp">MyEoa</a> </font><img src="/images/arrow.gif" width="7" height="11"> 
                  <font title="里边有什么好东西呢"> 增加用户表格</font></td>
              </tr>
            </table>
            <table width="550" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF">
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center" width="536">增加新用户</td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top">&nbsp;</td>
              </tr>
              <tr bgcolor="#000066">
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="550" border="0" cellspacing="0" cellpadding="3" align="center">
              <form name="newUser" method="post" action="addUserResult.jsp" onSubmit="return validateForm(newUser)">
                <tr bgcolor="#F4FCFF">
                  <td height="30" colspan="2" align="center">有“<font color="#CC0000">*</font>”
                    号的栏目为必添项 </td>
                </tr>
                <tr bgcolor="#DFEEFF">
                  <td align="right" bgcolor="#DFEEFF">用 户 名：</td>
                  <td bgcolor="#DFEEFF">
                    <p>
                      <input type="text" name="userID" size="15" class="font1">
                      <font color="#CC0000">*&nbsp;</font><font color="#CC0000">(有效用户名由字母,数字和下划线组成,长度为4~20位)</font></p>
                  </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
                  <td bgcolor="#F4FCFF"> 
                    <p> 
                      <input type="password" name="passwd1" size="15" class="font1">
                      <font color="#CC0000">*</font><font color="#CC0000">(有效密码由字母,数字和下划线组成,长度为6~20位)</font> 
                    </p>
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF">确认密码：</td>
                  <td bgcolor="#DFEEFF"> 
                    <input type="password" name="passwd2" size="15" class="font1">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF" height="32">用户级别：</td>
                  <td bgcolor="#F4FCFF" height="32"> 
                    <select name="userLevel">
                      <option value="1">普通用户</option>
                      <option value="2">操作用户</option>
                      <option value="3">初审用户</option>
                      <option value="4">高审用户</option>
                      <option value="5">超级用户</option>
                    </select>
                    <input type="hidden" name="memberID" value="<%=memberID%>">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr> 
                  <td colspan="2" align="center" bgcolor="#DFEEFF" height="33"> 
                    <p> 
                      <input type="image" src="/images/temp/b_add.gif" name="cancel2" value="取   消" class="font1" width="80" height="17">
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="addUserID.jsp" target="_self"><img src="/images/temp/reset.gif" name="cancel" value="取   消" class="font1" border="0" ></a> 
                      &nbsp; </p>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td colspan="2" align="center">&nbsp;</td>
                </tr>
                <tr bgcolor="#F4FCFF">
                  <td bgcolor="#FFFFFF" height="116"><b>用户级别说明:</b> 
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                  </td>
                  <td bgcolor="#FFFFFF" rowspan="2"> 
                    <p>会员公司的内部用户共分5个级别:普通用户,操作用户,初审用户�,高审用户,超级用户.</p>
                    <p>普通用户:可查看订单(不含价格),修改自己的密码;</p>
                    <p>操作用户:有普通用户的所有权限,并可以订购物品.操作用户的订单需经初审用户和</p>
                    <p> 高审用户审批后,才成为有效订单;</p>
                    <p>初审用户:有操作用户的所有权限.初审用户的订单需经高审用户审批后才成为有效订单.</p>
                    <p>高审用户:有初审用户的所有权限.高审用户的订单直接成为有效订单.</p>
                    <p>超级用户:有高审用户的所有权限.并可进行内部用户管理等其它操作.</p>
                  </td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td bgcolor="#FFFFFF" height="49">&nbsp;</td>
                </tr>
                <tr bgcolor="#000066"> 
                  <td colspan="2" height="1"><img src="/images/spacer.gif" width="1" height="1"></td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
      </table>
      <img src="/images/temp/corner_r.gif" width="7" height="7">
      <p>&nbsp;</p>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>
</body>
<!-- #EndTemplate --></html>


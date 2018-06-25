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
      alert("������û�����Ч,����������!");
      formName.userID.focus();
      return false;
    }
    if(formName.passwd1.value.length<6||formName.passwd1.value.length>20)
    {
      alert("�����������Ч,����������!");
      formName.passwd1.value="";
      formName.passwd1.focus();
      return false;
    }
    if(formName.passwd1.value!=formName.passwd2.value)
    {
      alert("����������ȷ�����벻��!");
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
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">��ҳ</a> 
                  <img src="/images/arrow.gif" width="7" height="11"> <font title="�����ʲô�ö�����"> 
                  <a href="MyEoa.jsp">MyEoa</a> </font><img src="/images/arrow.gif" width="7" height="11"> 
                  <font title="�����ʲô�ö�����"> �����û����</font></td>
              </tr>
            </table>
            <table width="550" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF">
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center" width="536">�������û�</td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top">&nbsp;</td>
              </tr>
              <tr bgcolor="#000066">
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="550" border="0" cellspacing="0" cellpadding="3" align="center">
              <form name="newUser" method="post" action="addUserResult.jsp" onSubmit="return validateForm(newUser)">
                <tr bgcolor="#F4FCFF">
                  <td height="30" colspan="2" align="center">�С�<font color="#CC0000">*</font>��
                    �ŵ���ĿΪ������ </td>
                </tr>
                <tr bgcolor="#DFEEFF">
                  <td align="right" bgcolor="#DFEEFF">�� �� ����</td>
                  <td bgcolor="#DFEEFF">
                    <p>
                      <input type="text" name="userID" size="15" class="font1">
                      <font color="#CC0000">*&nbsp;</font><font color="#CC0000">(��Ч�û�������ĸ,���ֺ��»������,����Ϊ4~20λ)</font></p>
                  </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF">��&nbsp;&nbsp;&nbsp;&nbsp;�룺</td>
                  <td bgcolor="#F4FCFF"> 
                    <p> 
                      <input type="password" name="passwd1" size="15" class="font1">
                      <font color="#CC0000">*</font><font color="#CC0000">(��Ч��������ĸ,���ֺ��»������,����Ϊ6~20λ)</font> 
                    </p>
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF">ȷ�����룺</td>
                  <td bgcolor="#DFEEFF"> 
                    <input type="password" name="passwd2" size="15" class="font1">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF" height="32">�û�����</td>
                  <td bgcolor="#F4FCFF" height="32"> 
                    <select name="userLevel">
                      <option value="1">��ͨ�û�</option>
                      <option value="2">�����û�</option>
                      <option value="3">�����û�</option>
                      <option value="4">�����û�</option>
                      <option value="5">�����û�</option>
                    </select>
                    <input type="hidden" name="memberID" value="<%=memberID%>">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr> 
                  <td colspan="2" align="center" bgcolor="#DFEEFF" height="33"> 
                    <p> 
                      <input type="image" src="/images/temp/b_add.gif" name="cancel2" value="ȡ   ��" class="font1" width="80" height="17">
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="addUserID.jsp" target="_self"><img src="/images/temp/reset.gif" name="cancel" value="ȡ   ��" class="font1" border="0" ></a> 
                      &nbsp; </p>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td colspan="2" align="center">&nbsp;</td>
                </tr>
                <tr bgcolor="#F4FCFF">
                  <td bgcolor="#FFFFFF" height="116"><b>�û�����˵��:</b> 
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                  </td>
                  <td bgcolor="#FFFFFF" rowspan="2"> 
                    <p>��Ա��˾���ڲ��û�����5������:��ͨ�û�,�����û�,�����û��,�����û�,�����û�.</p>
                    <p>��ͨ�û�:�ɲ鿴����(�����۸�),�޸��Լ�������;</p>
                    <p>�����û�:����ͨ�û�������Ȩ��,�����Զ�����Ʒ.�����û��Ķ����辭�����û���</p>
                    <p> �����û�������,�ų�Ϊ��Ч����;</p>
                    <p>�����û�:�в����û�������Ȩ��.�����û��Ķ����辭�����û�������ų�Ϊ��Ч����.</p>
                    <p>�����û�:�г����û�������Ȩ��.�����û��Ķ���ֱ�ӳ�Ϊ��Ч����.</p>
                    <p>�����û�:�и����û�������Ȩ��.���ɽ����ڲ��û��������������.</p>
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


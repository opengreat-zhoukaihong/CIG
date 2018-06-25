<%@ page import="java.util.*,java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
<%-- control the access to the page --%>
<%!
    String highLevel = "5";
    String userType,userLevel,eoaLoginID;
    // userType 1:EOA; 2:individual; 3:company; 4:dealer; 5:supplier; 6:supplier&dealer;
    // userLevel 0: normal user; 1: powerUser;
    String action;   // used to denote the operate type on the db. include:"add";"modify";"delete";

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
        if(!("4".equals(userType)))             // only accessible for supplier
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

  function checkDate(checkedDate)
  {
    var tempDate = checkedDate;
    if(tempDate != "")
    {
      if((tempDate.charAt(4)!="-")||(tempDate.charAt(7)!="-"))
      {
        alert("��������ڵĸ�ʽ����,�밴��ȷ��ʽ����!");
        return false;
      }
      if(tempDate.length != 10)
      {
        alert("��������ڵĸ�ʽ����,�밴��ȷ��ʽ����!");
        return false;
      }
      tempDate = checkedDate.substring(0,4);
      if(tempDate<'1980'||tempDate>'2099')
      {
        alert("������������!")
        return false;
      }
      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
          alert("����������.");
          return false;
        }
      }
      tempDate = checkedDate.substring(5,7);
      if(tempDate<'01'||tempDate>'12')
      {
        alert("������·�����!")
        return false;
      }
      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
          alert("����������.");
          return false;
        }
      }
      tempDate = checkedDate.substring(8,10);
      if(tempDate<'01'||tempDate>'31')
      {
        alert("�������������!")
        return false;
      }

      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
          alert("����������.");
          return false;
        }
      }
    }
    return true;
  }

  function validateForm(formName)
  {
    if(!checkDate(document.orderCond.orderDateBgn.value))
    {
      document.orderCond.orderDateBgn.focus();
      return false;
    }
    if(!checkDate(document.orderCond.orderDateEnd.value))
    {
      document.orderCond.orderDateEnd.focus();
      return false;
    }
  }

//-->
</script>

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
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">��ҳ</a>
                  <img src="/images/arrow.gif" width="7" height="11"> <font title="�����ʲô�ö�����"> 
                  <a href="MyEoa.jsp">MyEoa</a> </font><img src="/images/arrow.gif" width="7" height="11"> 
                  <font title="�����ʲô�ö�����"> ��ѯ������Ϣ</font></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF">
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center">��ѯ����</td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
              </tr>
              <tr bgcolor="#000066">
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">
              <form name="orderCond" method="post" action="searchOrdersRes_dealer.jsp" onSubmit="return validateForm(orderCond)">
                <tr bgcolor="#DFEEFF"> 
                  <td height="30" colspan="2" align="center">�������ѯ���� </td>
                </tr>
                <tr bgcolor="#DFEEFF">
                  <td align="right" bgcolor="#F4FCFF" height="29" width="129">����״̬��</td>
                  <td bgcolor="#F4FCFF" height="29" width="359"> 
                    <select name="status" >
                      <option value="1">�¶���</option>
                      <option value="2">���ն���</option>
                      <option value="3">��ȷ�϶���</option>
                      <option value="4">���ַ�������</option>
                      <option value="5">ȫ����������</option>
                      <option value="6">����ɶ���</option>
                      <option value="7">ȡ���Ķ���</option>
                      <option value="8">���ڵĶ���</option>
                      <option value="0">ΥԼ����</option>                    
                    </select>
                </tr>
                <tr>
                  <td align="right" bgcolor="#DFEEFF" width="129">��Ӧ�����ƣ�</td>
                  <td bgcolor="#DFEEFF" width="359">
                    <input type="text" name="name" size="15" class="font1">
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#F4FCFF" height="30" width="129">��ʼ�������ڣ�</td>
                  <td bgcolor="#F4FCFF" height="30" width="359"> 
                    <p> 
                      <input type="text" name="orderDateBgn" size="15" class="font1">
                      <font color="#CC0000">(�����ʽ:YYYY-MM-DD)</font> </p>
                  </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#DFEEFF" height="29" width="129"> 
                    <div align="right">��ֹ�������ڣ�</div>
                  </td>
                  <td bgcolor="#DFEEFF" height="29" width="359"> 
                    <input type="text" name="orderDateEnd" size="15" class="font1">
                    <font color="#CC0000">(�����ʽ:YYYY-MM-DD)</font> </td>
                </tr>
                <tr> 
                  <td height="30" align="center" bgcolor="#F4FCFF" width="129"> 
                    <div align="right">������ˮ�ţ�</div>
                  </td>
                  <td height="30" align="center" bgcolor="#F4FCFF" width="359"> 
                    <div align="left"> 
                      <input type="text" name="searchOrderID" size="15" class="font1">
                    </div>
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td colspan="2" align="center" height="24">&nbsp;</td>
                </tr>
                <tr bgcolor="#F4FCFF" valign="top"> 
                  <td colspan="2" align="center">
                    <div align="left"> 
                      <blockquote> 
                        <div align="left"> 
                          <p><font color="#CC0000">˵��</font>:��ʼ�����������ڲ�ѯ�ڸ������Ժ�����Ķ���;</p>
                        </div>
                        <blockquote>
                          <div align="left">��ֹ�����������ڲ�ѯ�ڸ�����֮ǰ�����Ķ���;</div>
                        </blockquote>
                      </blockquote>
                    </div>
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td colspan="2" align="center"> 
                    <input type="image" src="/images/temp/b_searchit.gif" name="cancel2" value="ȡ   ��" class="font1" width="80" height="17">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="searchOrders_dealer.jsp"><img src="/images/temp/reset.gif" name="cancel" value="ȡ   ��" class="font1" border="0"></a> 
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

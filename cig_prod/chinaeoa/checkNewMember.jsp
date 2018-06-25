<%@ page import="java.util.*,java.sql.*" session="true" language="java" errorPage="error.jsp"%>
<%-- control the access to the page --%>
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
        if(!("1".equals(userType)))             // only accessible for eoa;
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
//-->
</script>

<SCRIPT LANGUAGE="JavaScript"><!--
  function approval(formName)
  {
    formName.operType.value="approval";
  }
  function deny(formName)
  {
    formName.operType.value="deny";
  }

  function validateForm(formName)
  {
    if(formName.operType.value == "deny")
    {
      if(confirm("确实要取消资格吗?"))
        return true;
      else
        return false;
    }

    if(formName.operType.value == "approval")
    {
      if(confirm("确实同意了吗?"))
        return true;
      else
        return false;
    }
  }
//-->
</SCRIPT>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif" >

<jsp:useBean id="memberDetail" scope="page" class="com.cig.chinaeoa.member.MemberDetail" />
<jsp:useBean id="areaInfo" scope="page" class="com.cig.chinaeoa.member.AreaInfo" />

<%!
  String lang_code = "GB";
  ResultSet detailInfo,compTypeInfo;
  String memberID,memberType,country,province,city,zipCode,telephone,fax;
  String bankAccount,taxAccount,bank;
  String contName,contSex,contDept,contTitle,contEmail;
  String userID,passwd,question,answer;
  String compName,address,lawRep,compSize,compTypeID,compType;
  String tempSqlStr;
%>

<%-- 从数据库中取出国家,省份,城市和会员类别的信息 --%>

<% memberID = request.getParameter("memberID"); %>
<%

  try
  {
    memberDetail.setMemberID(memberID);
    detailInfo = memberDetail.getDatas();

    if (detailInfo!=null)
    {
      if(detailInfo.next())
      {
        memberType = detailInfo.getString("memberType");
        country = detailInfo.getString("country");
        province = detailInfo.getString("province");
        city = detailInfo.getString("city");
        zipCode = detailInfo.getString("zipCode");
        if(zipCode == null)
          zipCode = "";
        telephone = detailInfo.getString("tel");
        if(telephone == null)
          telephone = "";
        fax = detailInfo.getString("fax");
        if(fax == null)
          fax="";
        bankAccount = detailInfo.getString("account");
        if(bankAccount == null)
          bankAccount = "";
        taxAccount = detailInfo.getString("taxAccount");
        if(taxAccount == null)
          taxAccount = "";
        bank = detailInfo.getString("bank");
        if(bank == null)
          bank = "";
        contName = detailInfo.getString("contName_F");
        if(contName == null)
          contName = "";
        contDept = detailInfo.getString("contDept");
        if(contDept == null)
          contDept = "";
        contTitle = detailInfo.getString("contTitle");
        if(contTitle == null)
          contTitle = "";
        contEmail = detailInfo.getString("contEmail");
        if(contEmail == null)
          contEmail = "";
        userID = detailInfo.getString("userID");
        if(userID == null)
          userID = "";
        passwd = detailInfo.getString("passwd");
        if(passwd == null)
          passwd = "";
        else
          passwd = "************";
        question = detailInfo.getString("question");
        if(question == null)
          question = "";
        answer = detailInfo.getString("answer");
        if(answer == null)
          answer = "";
        contSex = detailInfo.getString("contSex");
        if(contSex.equals("M"))
          contSex = "先生";
        else if(contSex.equals("F"))
          contSex = "小姐";
        compName = detailInfo.getString("compName");
        address = detailInfo.getString("address1");
        if(address == null)
          address = "";
        lawRep = detailInfo.getString("lawRep_F");
        if(lawRep == null)
          lawRep = "";
        compSize = detailInfo.getString("compSize");
        if(compSize.equals("1"))
          compSize = "1-20人";
        else if(compSize.equals("2"))
          compSize = "21-40人";
        else if(compSize.equals("3"))
          compSize = "41-60人";
        else if(compSize.equals("4"))
          compSize = "61-100人";
        else if(compSize.equals("5"))
          compSize = "100人以上";
        else
          compSize = "";

        compTypeID = detailInfo.getString("compType");


        tempSqlStr = "select str_value from parameter " +
          " where ID='1' and lang_code = '" + lang_code +
          "' and code = '" + compTypeID + "'";

        areaInfo.setSqlStr(tempSqlStr);
        compTypeInfo = areaInfo.getDatas();
        if(compTypeInfo.next())
        {
          compType = compTypeInfo.getString("str_value");
        }
        else
          compType = "";

      }
      memberDetail.disconn();
    }


  }
  catch(Exception e)
  {
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
      <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td height="30"><img src="/images/temp/path.gif" width="49" height="13"> 
            <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">首页</a> 
            <img src="/images/arrow.gif" width="7" height="11"> <font title="里边有什么好东西呢"> 
            <a href="MyEoa.jsp">MyEoa</a> <img src="/images/arrow.gif" width="7" height="11"> 
            <font title="里边有什么好东西呢"> 用户审批</font></font></td>
        </tr>
      </table>
      <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr bgcolor="#99CCFF">
          <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
          <td height="25" class="font4b" align="center">新用户审批</td>
          <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
        </tr>
        <tr bgcolor="#000066">
          <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
      <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">
        <form name="newMemberInfo" method="post" action="apprMember.jsp" onSubmit="return validateForm(newMemberInfo)">
          <tr bgcolor="#F4FCFF">

          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right">用户类别：</td>
            <td bgcolor="#DFEEFF"><%=memberType%>

               </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">国&nbsp;&nbsp;&nbsp;&nbsp;家：</td>
            <td bgcolor="#F4FCFF"><%=country%>
               </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">省&nbsp;&nbsp;&nbsp;&nbsp;份：</td>
            <td bgcolor="#DFEEFF"><%=province%>

              </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">所在城市：</td>
            <td bgcolor="#F4FCFF"><%=city%>

             </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">公司名称：</td>
            <td bgcolor="#DFEEFF"><%=compName%>
               </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">联系地址：</td>
            <td bgcolor="#F4FCFF"><%=address%>
              </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">邮政编码：</td>
            <td bgcolor="#DFEEFF"><%=zipCode%>
               </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">联系电话：</td>
            <td bgcolor="#F4FCFF"><%=telephone%>
               </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">传&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
            <td>
              <%=fax%>
            </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">公司规模：</td>
            <td bgcolor="#F4FCFF"><%=compSize%>
              </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">法人代表：</td>
            <td><%=lawRep%> </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">公司类型：</td>
            <td bgcolor="#F4FCFF"><%=compType%>

            </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">公司帐号：</td>
            <td><%=bankAccount%> </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">开户银行：</td>
            <td bgcolor="#F4FCFF"><%=bank%> </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">公司税号：</td>
            <td><%=taxAccount%> </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">&nbsp;</td>
            <td bgcolor="#F4FCFF">&nbsp;</td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">联 系 人：</td>
            <td bgcolor="#DFEEFF"><%=contName%>
               </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">称&nbsp;&nbsp;&nbsp;&nbsp;谓：</td>
            <td bgcolor="#F4FCFF"><%=contSex%>

          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">工作部门：</td>
            <td><%=contDept%>

            </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">职&nbsp;&nbsp;&nbsp;&nbsp;务：</td>
            <td bgcolor="#F4FCFF">
              <%=contTitle%>
            </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right"><b bgcolor="#DFEEFF">E-mail : </b ></td>
            <td bgcolor="#DFEEFF"><%=contEmail%>
              </td>
          </tr>
          <tr>
            <td colspan="2" bgcolor="#F4FCFF"><b bgcolor="#F4FCFF"><font color="#990033"> &nbsp;&nbsp;&nbsp;&nbsp;</font></b></td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">用 户 名：</td>
            <td bgcolor="#DFEEFF"><%=userID%>
              </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
            <td bgcolor="#F4FCFF"><%=passwd%>
               </td>
          </tr>

          <tr>
            <td align="right" bgcolor="#DFEEFF">密码提示：</td>
            <td bgcolor="#DFEEFF"><%=question%>
               </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#F4FCFF">答&nbsp;&nbsp;&nbsp;&nbsp;案： </td>
            <td bgcolor="#F4FCFF"><%=answer%>
                 <input type="hidden" name="memberID" value="<%=memberID%>">
                 <input type="hidden" name="operType" >
            </td>
          </tr>
          <tr>
            <td colspan="2" bgcolor="#DFEEFF"><b bgcolor="#DFEEFF"><font color="#990033">&nbsp;</font></b></td>
          </tr>

           <tr>
            <td colspan="2" align="center" bgcolor="#F4FCFF">
              <input type="image" src="/images/temp/b_approval.gif" name="submit" value="同   意" class="font1" width="80" height="17" onClick="approval(newMemberInfo)">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="image" src="/images/temp/b_deny.gif" name="cancel" value="不 同 意 " class="font1" onClick="deny(newMemberInfo)">
            </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr bgcolor="#000066">
            <td colspan="2" height="1"><img src="/images/spacer.gif" width="1" height="1"></td>
          </tr>
        </form>
      </table>
      <p>&nbsp;</p>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>
</body>
<!-- #EndTemplate --></html>

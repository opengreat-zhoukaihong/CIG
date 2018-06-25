<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>

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

<%-- This jsp is used to insert new application to member table and member_L table  --%>


<%!
    String dealerType = "4";
    String individualType = "2";
    String companyType = "3";
    String pendingStatus = "P";
    String approvalStatus = "A";
    ResultSet oldUserIDs;
    String country,province,city,compName,compAddr,zipCode,telephone,fax;
    String compSize,lawRep,compType,bankAccount,bank,taxAccount;
    String contName,contSex,contDept,contTitle,contEmail;
    String userID,passwd,question,answer,memberType,status;
    String tempSqlStr;
    String welcomeString;
    int insertInfo;  // 0: insert success; 1:insert error; 2:exception;

%>
<%
    memberType = request.getParameter("memberType").trim();
    if(memberType.equals(individualType))
    {
      userID = request.getParameter("userID").trim();
      passwd = request.getParameter("passwd1").trim();
      question = request.getParameter("question").trim();
      answer = request.getParameter("answer").trim();
    }
    else
    {
      userID = (String)session.getValue("tempUserID");
      passwd = (String)session.getValue("tempPasswd");
      question = (String)session.getValue("tempQuestion");
      answer = (String)session.getValue("tempAnswer");
      session.removeValue("tempUserID");
      session.removeValue("tempPasswd");
      session.removeValue("tempQuestion");
      session.removeValue("tempAnswer");
    }
    tempSqlStr = "select memberID from member where status='P' and userID= '" +
      userID + "' union select memberID from users where userID='" + userID +"'";
%>

<jsp:useBean id="userIDInfo" scope="page" class="com.cig.chinaeoa.member.AreaInfo" />

<%
    try
    {
      userIDInfo.setSqlStr(tempSqlStr);
      oldUserIDs = userIDInfo.getDatas();
      if(oldUserIDs.next())   // the inputed userID already exists.
      {
        userIDInfo.disconn();
%>

      <table width="667" border="0" cellpadding="0" cellspacing="0" height="300">
        <tr align="center">
          <td class="font4b">
            <p>很抱歉!您的用户名已被使用,请修改您的用户名!</p>
      <% if(memberType.equals(individualType))
          {
      %>
          <p><a href="javascript:history.go(-1);">返回</a></p>

       <%  } else { %>

            <p><a href="javascript:history.go(-2);">返回</a></p>

       <%  }  %>
            
          </td>
        </tr>
      </table>

<%
      }
      else  // the inputed userID is new, then get all inputed data from the form
      {
        userIDInfo.disconn();

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

        if(memberType.equals(dealerType))
          status = pendingStatus;
        else if((memberType.equals(individualType))||(memberType.equals(companyType)))
          status = approvalStatus;
        else
          status = pendingStatus;

        tempSqlStr = "insert into member (MemberID,MemberType,CountryID,ProvinceID,CityID,ZipCode,"+
            "Tel,Fax,CompSize,CompType,Account,TaxAccount,ContSex,ContEmail,UserID,Passwd,Question,"+
            "Answer,Status,Cr_Date,MD_Date) " +
            "values ( Seq_MemberID.NextVal,'" + memberType + "','" + country + "','" + province +
              "','" + city + "','" + zipCode + "','" + telephone + "','" + fax + "','" + compSize +
              "','" + compType + "','" + bankAccount + "','" + taxAccount + "','" + contSex +
              "','" + contEmail + "','" + userID + "','" + passwd + "','" + question + "','" + answer +
              "','" + status + "',SYSDATE, SYSDATE)";

         userIDInfo.setSqlStr(tempSqlStr);

         tempSqlStr = "insert into member_L (MemberID,Lang_Code,CompName,Address1," +
            "LawRep_F,Bank,ContName_F,ContDept,ContTitle) " +
            "values ( Seq_MemberID.CurrVal,'GB','"  + compName + "','" +
            compAddr + "','" + lawRep + "','" + bank + "','" + contName +"','" +
            contDept + "','" + contTitle +"')";

         userIDInfo.setSqlStr2(tempSqlStr);

         if((memberType.equals(individualType))||(memberType.equals(companyType)))
         {
            tempSqlStr = "insert into users (userID,memberID,passwd,userLevel,cr_date,md_date) " +
              " values('" + userID + "',Seq_MemberID.CurrVal,'" + passwd + "','5',sysdate,sysdate)";

            welcomeString = "欢迎您成为我们的新用户!";
         }
         else
         {
            tempSqlStr = "";
            welcomeString = "我们已收到您的申请,我们会尽快通过Email给您答复.";
         }

         userIDInfo.setSqlStr3(tempSqlStr);

         userIDInfo.setMemberType(memberType);
         userIDInfo.addNewMember();
         insertInfo = userIDInfo.getInsertInfo();

         if(insertInfo==0)
         {
%>
      <table width="667" border="0" cellpadding="0" cellspacing="0" height="300">
        <tr align="center">
          <td class="font4b">
            <p><%=welcomeString%></p>
            <p><a href="/chinaeoa/index.jsp">返回</a></p>
          </td>
        </tr>
      </table>

<%
         }
         else
         {
%>
      <table width="667" border="0" cellpadding="0" cellspacing="0" height="300">
        <tr align="center">
          <td class="font4b">
            <p>服务器错误!</p>
            <p><a href="javascript:history.go(-1);">返回</a></p>
          </td>
        </tr>
      </table>

<%
         }

      }
    }
    catch(Exception e)
    {
       e.printStackTrace();
    }
%>

      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>

</body>
<!-- #EndTemplate -->
</html>

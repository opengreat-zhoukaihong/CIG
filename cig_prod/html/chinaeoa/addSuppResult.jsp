<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
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

<%-- This jsp is used to insert new supplier to member , member_L and supplier  --%>


<%!
    String supplierTypeID = "5";
    String supplierAndDealer = "6";
    ResultSet oldUserIDs;
    String country,province,city,compName,compAddr,zipCode,telephone,fax;
    String compSize,lawRep,compType,bankAccount,bank,taxAccount;
    String contName,contSex,contDept,contTitle,contEmail;
    String userID,passwd,question,answer,memberType;
    String tempSqlStr;
    int errorCode;  // 0: success; 1:error; 2:exception;
%>
<%
    userID = request.getParameter("userID").trim();
    tempSqlStr = "select memberID from member where status='P' and userID= '" +
      userID + "' union select memberID from users where userID='" + userID +"'";
%>

<jsp:useBean id="userIDInfo" scope="page" class="com.cig.chinaeoa.member.MemberManager" />

<%
    try
    {
      userIDInfo.setSqlStr(tempSqlStr);
      oldUserIDs = userIDInfo.getTempDatas();
      if(oldUserIDs.next())   // the inputed userID already exists.
      {
        userIDInfo.disconn();
%>

      <table width="667" border="0" cellpadding="0" cellspacing="0" height="300">
        <tr align="center">
          <td class="font4b">
            <p>�ܱ�Ǹ!�����û����ѱ�ʹ��,���޸������û���!</p>
            <p><a href="javascript:history.go(-1);">����</a></p>
          </td>
        </tr>
      </table>

<%
      }
      else  // the inputed userID is new, then get all inputed data from the form
      {
        userIDInfo.disconn();

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
        passwd = request.getParameter("passwd1").trim();
        question = request.getParameter("question").trim();
        answer = request.getParameter("answer").trim();

        tempSqlStr = "insert into member (MemberID,MemberType,CountryID,ProvinceID,CityID,ZipCode,"+
            "Tel,Fax,CompSize,CompType,Account,TaxAccount,ContSex,ContEmail,UserID,Passwd,Question,"+
            "Answer,Status,Cr_Date,MD_Date) " +
            "values ( Seq_MemberID.NextVal,'" + memberType + "','" + country + "','" + province +
              "','" + city + "','" + zipCode + "','" + telephone + "','" + fax + "','" + compSize +
              "','" + compType + "','" + bankAccount + "','" + taxAccount + "','" + contSex +
              "','" + contEmail + "','" + userID + "','" + passwd + "','" + question + "','" + answer +
              "','A',SYSDATE, SYSDATE)";

         userIDInfo.setSqlStr(tempSqlStr);

         tempSqlStr = "insert into member_L (MemberID,Lang_Code,CompName,Address1," +
            "LawRep_F,Bank,ContName_F,ContDept,ContTitle) " +
            "values ( Seq_MemberID.CurrVal,'GB','"  + compName + "','" +
            compAddr + "','" + lawRep + "','" + bank + "','" + contName +"','" +
            contDept + "','" + contTitle +"')";

         userIDInfo.setSqlStr2(tempSqlStr);

         tempSqlStr = "insert into users (userID,memberID,passwd," +
              "userLevel,cr_date,md_date) values ('" + userID + "',Seq_MemberID.CurrVal,'" +
              passwd + "','5',sysdate,sysdate)";

         userIDInfo.setSqlStr3(tempSqlStr);

         if(memberType.equals(supplierTypeID)||memberType.equals(supplierAndDealer))
         {
           tempSqlStr = "insert into supplier (SupplierID,MemberID,cr_date,md_date) " +
            " values (Seq_supplierID.NextVal,Seq_MemberID.CurrVal,sysdate,sysdate )";

           userIDInfo.setSqlStr4(tempSqlStr);
         }

         userIDInfo.setMemberType(memberType);  //  used by bean to decide the memberType
                                                //  which is EOA or Supplier
         userIDInfo.addSupplier();
         errorCode = userIDInfo.getErrorCode();

         if(errorCode==0)
         {
%>
      <table width="667" border="0" cellpadding="0" cellspacing="0" height="300">
        <tr align="center">
          <td class="font4b">
            <p>���ӳɹ�!</p>
            <p><a href="javascript:history.go(-2);">����</a></p>
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
            <p>����������!</p>
            <p><a href="javascript:history.go(-1);">����</a></p>
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
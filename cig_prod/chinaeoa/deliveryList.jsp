<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
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
      //response.sendRedirect("loginIdError.jsp");
%>
      <jsp:forward page="loginIdError.jsp" />
<%
    }
    else
    {
      if(!(highLevel.equals(userLevel)))      // the user is not a power user
      {
        //response.sendRedirect("permError.jsp");
%>
       <jsp:forward page="permError.jsp" />
<%
      }
      else
      {
        if((!"5".equals(userType))&&(!"1".equals(userType)))             // only accessible for supplier
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

  function getNewPage(pageno)
  {
    document.browseList.pageNo.value = pageno;
    document.browseList.submit();
  }

  function confirmModify(deliveryID)
  {
    document.modifyDelivery.deliveryID.value = deliveryID;
    document.modifyDelivery.submit();
  }

  function confirmDel(deliveryID)
  {
    if(confirm("确实要删除该送货公司吗?"))
    {
      document.delDelivery.deliveryID.value = deliveryID;
      document.delDelivery.submit();
    }
  }

//-->
</script>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<jsp:useBean id="deliveryManager" scope="page" class="com.cig.chinaeoa.member.DeliveryManager" />
<%!
    public String getPageNo(HttpServletRequest request,String pageNo)
    {
      if(request.getParameter(pageNo) == null)
        return "1";
      else
        return request.getParameter(pageNo);
    }
    ResultSet deliveryInfo;
    String memberID;
    String supplierID;
    String tempSqlStr;
    String action;   // used to denote the operate type . include:"add";"modify";"delete";
    String actionUrl;
    String actionType;  // "查看详情","修改" 或 "删除"
    String deliveryID,contName,deliveryName,address,telephone,fax,contEmail;
    int pageNo,prePageNo,nextPageNo;
    int pageCount,rowCount;
%>
<%
        action = request.getParameter("action");

        memberID = (String)session.getValue("cneoa.MemberId");
        deliveryManager.setMemberID(memberID);
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
      <table width="600" border="0" cellspacing="0" cellpadding="0" height="300" align="center">
        <tr valign="top"> 
          <td> 
            <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr> 
                <td class="font4b">&nbsp;</td>
                <td class="font4b">运送公司清单</td>
                <td class="font4b">&nbsp;</td>
              </tr>
              <tr>
                <td width="10">&nbsp;</td>

<FORM NAME="browseList" action="deliveryList.jsp" METHOD="post" >
  <input type="hidden" name="deliveryID">
  <input type="hidden" name="pageNo">
</FORM>

<FORM NAME="modifyDelivery" action="modifyDelivery.jsp" METHOD="post" >
  <input type="hidden" name="deliveryID">
</FORM>

<form name="delDelivery" method="post" action="deleteDeliveryResult.jsp">
  <input type="hidden" name="deliveryID">
</form>


<%
        pageCount = deliveryManager.getPageCount();
        if(pageCount == 0)
        {
%>

              <td width="580" align="center">

<%
          out.println("没有查询结果!");
        }
        else
        {
%>
              <td width="580" align="right">
<%
          pageNo = (Integer.valueOf(getPageNo(request,"pageNo"))).intValue();

          prePageNo = pageNo - 1;
          nextPageNo = pageNo + 1;

          if(prePageNo > 0)
          {
%>
<a href="javascript:getNewPage(<%=prePageNo%>)">上一页</a>
<%
          }
          else
          {
%>
<a>上一页</a>
<%
          }
          if(nextPageNo <= pageCount)
          {
%>
<a href="javascript:getNewPage(<%=nextPageNo%>)">下一页</a>
<%
          }
          else
          {
%>
<a>下一页</a>
<%
          }
%>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3">
                  <table width="600" border="0" cellspacing="2" cellpadding="0">
                    <tr align="center" bgcolor="#0C7AC9">
                      <td height="20"><font color="#FFFFFF">送货公司名称</font></td>
                      <td height="20"><font color="#FFFFFF">地址</font></td>
                      <td height="20"><font color="#FFFFFF">联系人</font></td>
                      <td height="20"><font color="#FFFFFF">联系电话</font></td>
                      <td height="20"><font color="#FFFFFF">E-mail</font></td>
                      <td height="20"><font color="#FFFFFF">操作方式</font></td>
                    </tr>

<%
          deliveryManager.setPageNo(pageNo);

          deliveryInfo = deliveryManager.getDatas();

          if(deliveryInfo != null)
          {
            while (deliveryInfo.next())
            {
              deliveryID = deliveryInfo.getString("deliveryID");
              deliveryName = deliveryInfo.getString("name");
              contName = deliveryInfo.getString("contact_F");
              contEmail = deliveryInfo.getString("email");
              fax = deliveryInfo.getString("fax");
              telephone = deliveryInfo.getString("tel");
              address = deliveryInfo.getString("address1");
              rowCount = Integer.valueOf(deliveryInfo.getString("rid")).intValue();

              if(action.equals("browse"))
              {
                actionUrl = "browseDelivery.jsp?deliveryID=" + deliveryID;
                actionType = "查看详细";
              }
              if(action.equals("modify"))
              {
                actionUrl = "javascript:confirmModify(" + deliveryID + ")";
                actionType = "修改";
              }
              if(action.equals("delete"))
              {
                actionUrl = "javascript:confirmDel(" +deliveryID+ ")";
                actionType = "删除";
              }

            if((rowCount%2) == 0)
            {
%>
                    <tr align="center" bgcolor="#E7F4FE">
                      <td><%=deliveryName%></td>
                      <td><%=address%></td>
                      <td><%=contName%></td>
                      <td><%=telephone%></td>
                      <td><%=contEmail%></td>
                      <td><a href="<%=actionUrl%>"><%=actionType%></a></td>
                    </tr>
<%           }
             else
             {
%>
                    <tr align="center" bgcolor="#F4FCFF">
                      <td><%=deliveryName%></td>
                      <td><%=address%></td>
                      <td><%=contName%></td>
                      <td><%=telephone%></td>
                      <td><%=contEmail%></td>
                      <td><a href="<%=actionUrl%>"><%=actionType%></a></td>
                    </tr>
<%            }
            }
            deliveryManager.disconn();
          }

        }
%>

                  </table>
                </td>
              </tr>
              <tr> 
                <td colspan="3">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>

</body>
<!-- #EndTemplate -->
</html>

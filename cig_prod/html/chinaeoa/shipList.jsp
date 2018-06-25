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

  function confirmModify(shipID)
  {
    document.modifyShip.shipID.value = shipID;
    document.modifyShip.submit();
  }

  function confirmDel(shipID)
  {
    if(confirm("确实要删除该收货方吗?"))
    {
      document.delShip.shipID.value = shipID;
      document.delShip.submit();
    }
  }

//-->
</script>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<jsp:useBean id="shipManager" scope="page" class="com.cig.chinaeoa.member.ShipManager" />
<%!
    public String getPageNo(HttpServletRequest request,String pageNo)
    {
      if(request.getParameter(pageNo) == null)
        return "1";
      else
        return request.getParameter(pageNo);
    }
    ResultSet shipInfo;
    String memberID;
    String tempSqlStr;
    String action;   // used to denote the operate type . include:"add";"modify";"delete";
    String actionUrl;
    String actionType;  // "查看详情","修改" 或 "删除"
    String shipID,contName,shipName,address,telephone,fax,contEmail;
    int pageNo,prePageNo,nextPageNo;
    int pageCount,rowCount;
%>
<%
        action = request.getParameter("action");

        memberID = (String)session.getValue("cneoa.MemberId");
        shipManager.setMemberID(memberID);
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
                <td class="font4b">运送地清单</td>
                <td class="font4b">&nbsp;</td>
              </tr>
              <tr>
                <td width="10">&nbsp;</td>

<FORM NAME="browseList" action="shipList.jsp" METHOD="post" >
  <input type="hidden" name="shipID">
  <input type="hidden" name="pageNo">
</FORM>

<FORM NAME="modifyShip" action="modifyShip.jsp" METHOD="post" >
  <input type="hidden" name="shipID">
</FORM>

<form name="delShip" method="post" action="deleteShipResult.jsp">
  <input type="hidden" name="shipID">
</form>


<%
        pageCount = shipManager.getPageCount();
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
                      <td height="20"><font color="#FFFFFF">收货方名称</font></td>
                      <td height="20"><font color="#FFFFFF">收货方地址</font></td>
                      <td height="20"><font color="#FFFFFF">联系人</font></td>
                      <td height="20"><font color="#FFFFFF">联系电话</font></td>
                      <td height="20"><font color="#FFFFFF">E-mail</font></td>
                      <td height="20"><font color="#FFFFFF">操作方式</font></td>
                    </tr>

<%
          shipManager.setPageNo(pageNo);

          shipInfo = shipManager.getDatas();

          if(shipInfo != null)
          {
            while (shipInfo.next())
            {
              shipID = shipInfo.getString("shipID");
              shipName = shipInfo.getString("shipName");
              contName = shipInfo.getString("contName_F");
              contEmail = shipInfo.getString("email");
              fax = shipInfo.getString("fax");
              telephone = shipInfo.getString("tel");
              address = shipInfo.getString("address1");
              rowCount = Integer.valueOf(shipInfo.getString("rid")).intValue();

              if(action.equals("browse"))
              {
                actionUrl = "browseShip.jsp?shipID=" + shipID;
                actionType = "查看详细";
              }
              if(action.equals("modify"))
              {
                actionUrl = "javascript:confirmModify(" + shipID + ")";
                actionType = "修改";
              }
              if(action.equals("delete"))
              {
                actionUrl = "javascript:confirmDel(" +shipID+ ")";
                actionType = "删除";
              }

            if((rowCount%2) == 0)
            {
%>
                    <tr align="center" bgcolor="#E7F4FE">
                      <td><%=shipName%></td>
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
                      <td><%=shipName%></td>
                      <td><%=address%></td>
                      <td><%=contName%></td>
                      <td><%=telephone%></td>
                      <td><%=contEmail%></td>
                      <td><a href="<%=actionUrl%>"><%=actionType%></a></td>
                    </tr>
<%            }
            }
            shipManager.disconn();
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

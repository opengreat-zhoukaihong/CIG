<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font10 {  font-size: 11px; line-height: 14pt; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.font9 {  font-size: 13px; font-family: "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 12px; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  text-decoration: none}
a:visited {  text-decoration: none}
a:active {  text-decoration: none}
a:hover {  color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; font-family: "Arial", "Helvetica", "sans-serif"}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 13px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
.balck14 {  font-size: 12px; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
-->
</style>
</head>
<%@ page info="我的纸网--PaperEC.com"%> <%@ page import="java.util.*" %> <%@ page import="mypaperec.*" %> 
<jsp:useBean id="Activity" scope="page" class="mypaperec.Activity" /> <jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<jsp:setProperty name="Activity" property="userId"/> <jsp:setProperty name="Activity" property="langCode" value="EN"/> 
<jsp:setProperty name="Activity" property="getFlag"/> <jsp:setProperty name="Activity" property="fromDate"/> 
<jsp:setProperty name="Activity" property="toDate"/> <%  if (!UserInfo.getAuthorized()){
%> <jsp:forward page="notAuthorized.jsp" /> </jsp:forward> <%    }
%> <%
    int actCount;
    String[][] actList;
    int returnCode;
    
    Activity.setUserId(UserInfo.getUserId());
    
    if (Activity.getFlag==0){
        Activity.setGetFlag("1");
    }
    
    actCount = Activity.getActCount();
    actList = Activity.getActList(); 
    returnCode = Activity.getReturnCode();
    
%> 
<script language="JavaScript">
function openForeignX(url){   
        OpenWindow=window.open(url, "foreignXwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,resizable=no,menubar=no,width=142,height=230");
}

function openMeasConv(url){   
        OpenWindow=window.open(url, "measConvwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no,width=300,height=300");
}
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr> 
    <td width="159"> 
      <script language="JavaScript" src="../../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="postcenter/demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../images/images_en/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="postcenter/product_list.jsp" class="font9"><font color="#000000">Offer 
                      to Sell</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="postcenter/request2buy.jsp"><font color="#000000">Request 
                      to Buy</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="postcenter/order_search.jsp"><font color="#000000">Browse 
                      Trading Floor</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="mycustomer.jsp"><font color="#000000">My 
                      Customers</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="postcenter/product_list.jsp"><font color="#000000">My 
                      ProductProfile</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">Search 
                      by ID#</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="Go">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('foreignX.htm')"><font color="#FFFFFF">Currency 
                      Converter</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="jiaoyifu.htm"><font color="#FFFFFF">Services</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('huansuanresult.jsp')"><font color="#FFFFFF">Metric 
                      Converter</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../../images/images_en/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </td>
    <td valign="top"> 
      <form method="post" name ="ActList" action="ActList.jsp">
        <input type="HIDDEN" name="fromDate" value=<%=Activity.getFromDate()%>>
        <input type="HIDDEN" name="toDate" value=<%=Activity.getToDate()%>>
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="159"> 
              <table width="500" border="0" cellspacing="2" cellpadding="4">
                <tr> 
                  <td colspan="7" bgcolor="#4078E0"><font color="#FFFFFF" class="big"><b>My 
                    Activity</b></font></td>
                </tr>
                <tr align="center" bgcolor="#E6EDFB"> 
                  <td colspan="7" class="dan10"> 
                    <select name="getFlag" SIZE="1">
                      <option value="1" selected>My Offers to Sell</option>
                      <option value="2">My Bids</option>
                      <option value="3">My Requests to Buy</option>
                      <option value="4">Total Completed</option>
                      <option value="5">Accepted Bids</option>
                      <option value="6">Active Bids to Sell</option>
                      <option value="7">Active Bids to Buy</option>
                      <option value="8">Inactive offers to Sell</option>
                      <option value="9">Inactive Bids</option>
                      <option value="10">Inactive Requests to Buy</option>
                    </select>
                    <input type="submit" name="Submit" value="Go">
                  </td>
                </tr>
                <tr align="center"> 
                  <td width="83" class="dan10" bgcolor="#7EA2EB">Posting ID</td>
                  <td width="80" class="dan10" bgcolor="#7EA2EB">Bid ID</td>
                  <td width="88" class="dan10" bgcolor="#7EA2EB">Bid Date</td>
                  <td width="72" class="dan10" bgcolor="#7EA2EB">Price</td>
                  <td width="72" class="dan10" bgcolor="#7EA2EB">Quantity</td>
                  <td width="59" class="dan10" bgcolor="#7EA2EB">Status</td>
                  <td width="56" class="dan10" bgcolor="#7EA2EB">User Name</td>
                </tr>
                <%
                   if ( actCount==0){
                %> 
                <tr align="center"> 
                  <td colspan="7" class="dan10" bgcolor="#E6EDFB">No records found!</td>
                </tr>
                <% }else if (returnCode == 0){
                      for (int i =0;i<actCount;i++){
                        if (i%2==0){
                %> 
                <tr align="center"> 
                  <td width="83" class="dan10"><a href="postcenter/demand_info.jsp?posting_id=<%=actList[i][0]%>"><%=actList[i][0]%></a></td>
                  <td width="80" class="dan10"><%=actList[i][1]%></td>
                  <td width="88" class="dan10"><%=actList[i][2]%></td>
                  <td width="72" class="dan10"><%=actList[i][3]%></td>
                  <td width="72" class="dan10"><%=actList[i][4]%></td>
                  <td width="59" class="dan10"><%=actList[i][5]%></td>
                  <td width="56" class="dan10"><%=actList[i][6]%></td>
                </tr>
                <%     
                	}else{
                %> 
                <tr align="center"> 
                  <td width="83" bgcolor="#E6EDFB" class="dan10"><a href="postcenter/demand_info.jsp?posting_id=<%=actList[i][0]%>"><%=actList[i][0]%></a></td>
                  <td width="80" bgcolor="#E6EDFB" class="dan10"><%=actList[i][1]%></td>
                  <td width="88" bgcolor="#E6EDFB" class="dan10"><%=actList[i][2]%></td>
                  <td width="72" bgcolor="#E6EDFB" class="dan10"><%=actList[i][3]%></td>
                  <td width="72" bgcolor="#E6EDFB" class="dan10"><%=actList[i][4]%></td>
                  <td width="59" bgcolor="#E6EDFB" class="dan10"><%=actList[i][5]%></td>
                  <td width="56" bgcolor="#E6EDFB" class="dan10"><%=actList[i][6]%></td>
                </tr>
                <%	}
                     }
                   }
                %> 
                <tr align="center"> <% switch(Activity.getFlag){
                   case 1: 
                %> 
                  <td colspan="7" class="dan10">My Offers to Sell: <%=actCount%> 
                    items</td>
                  <%     	break;
                   case 2:
		%> 
                  <td colspan="7" class="dan10">My Bids: <%=actCount%> items</td>
                  <%     	break;                     
                   case 3:
                %> 
                  <td colspan="7" class="dan10">My Requests to Buy: <%=actCount%> 
                    items</td>
                  <%     	break;                     
                   case 4:
                %> 
                  <td colspan="7" class="dan10">Total Completed: <%=actCount%> 
                    items</td>
                  <%     	break;                     
                   case 5:
                %> 
                  <td colspan="7" class="dan10">Accepted Bids: <%=actCount%> items</td>
                  <%     	break;                     
                   case 6:
                %> 
                  <td colspan="7" class="dan10">Active Bids to Sell: <%=actCount%> 
                    items</td>
                  <%     	break;                     
                   case 7:
                %> 
                  <td colspan="7" class="dan10">Active Bids to Buy: <%=actCount%> 
                    items</td>
                  <%     	break;                     
                   case 8:
                %> 
                  <td colspan="7" class="dan10">Inactive offers to Sell: <%=actCount%> 
                    items</td>
                  <%     	break;                     
                   case 9:
                %> 
                  <td colspan="7" class="dan10">Inactive Bids: <%=actCount%> items</td>
                  <%     	break;                     
                   case 10:
                %> 
                  <td colspan="7" class="dan10">Inactive Requests to Buy: <%=actCount%> 
                    items</td>
                  <%     	break;                     
                   default:                                                          
                %> 
                  <td colspan="7" class="dan10">My Offers to Sell: <%=actCount%> 
                    items</td>
                  <%     	break;                     
                   }
                %> </tr>
              </table>
            </td>
          </tr>
        </table>
      </form> </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../images/images_en/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>


<SCRIPT language=JavaScript>  
<!--//  
  var version = "other"  
  browserName = navigator.appName;     
  browserVer = parseInt(navigator.appVersion);  
  if (browserName == "Netscape" && browserVer >= 3) 
    version = "n3";  
  else if (browserName == "Netscape" && browserVer < 3) 
    version = "n2";  
  else if (browserName == "Microsoft Internet Explorer" && browserVer >= 4) 
    version = "e4";  
  else if (browserName == "Microsoft Internet Explorer" && browserVer < 4) 
    version = "e3";  
    
  function marquee1()  
  {  	
    if (version == "e4")  
    {  
      document.write("<marquee behavior=scroll  direction=up  width=180 height=150 scrollamount=1 scrolldelay=60 onmouseover='this.stop()' onmouseout='this.start()'>")		 
    }  
  }  
  
  function marquee2()  
  {  	
    if (version == "e4")  
    {  	
      document.write("</marquee>")  
    }  
  }
//-->  
</SCRIPT>

<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none}
a:visited {  text-decoration: none}
a:active {  text-decoration: none}
a:hover {  color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px}
.balck14 {  font-size: 14px; color: #000000}
-->
</style>
<script language="JavaScript">
<!--

var onTop = false
function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=355')
}

// -->
</script></head>

<%@ page info="我的纸网--PaperEC.com"%>
<%@ page import="java.util.*" %>
<%@ page import="mypaperec.*" %>

<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<jsp:setProperty name="UserInfo" property="username" />
<jsp:setProperty name="UserInfo" property="password" />
<jsp:setProperty name="UserInfo" property="answerInput"/>

<jsp:useBean id="NewsList" scope="page" class="news.NewsList" /> 

<jsp:setProperty name="NewsList" property="langCode" value="GB"/>
<jsp:setProperty name="NewsList" property="pageFlag" value="N"/>
<jsp:setProperty name="NewsList" property="restriction" value="10"/>

<jsp:useBean id="MessageList" scope="page" class="mypaperec.MessageList" /> 
<jsp:setProperty name="MessageList" property="userId"/>
<jsp:setProperty name="MessageList" property="langCode" value="GB"/>
<jsp:setProperty name="MessageList" property="getFlag" value="2"/>

<jsp:useBean id="Activity" scope="page" class="mypaperec.Activity" /> 
<jsp:setProperty name="Activity" property="userId"/>
<jsp:setProperty name="Activity" property="langCode" value="GB"/>
<jsp:setProperty name="Activity" property="getFlag"/>
<jsp:setProperty name="Activity" property="fromDate" value="2000-01-01"/>
<jsp:setProperty name="Activity" property="toDate" />

<jsp:useBean id="WatchList" scope="page" class="mypaperec.WatchList" /> 
<jsp:setProperty name="WatchList" property="userId"/>
<jsp:setProperty name="WatchList" property="langCode" value="GB"/>
<jsp:setProperty name="WatchList" property="measureFlag"/>

<jsp:useBean id="hp" scope="page" class="mypaperec.HandPick" />
<jsp:setProperty name="hp" property="lang_code" value="GB"/>

<%
    String[] pickName=hp.getCurrName();
    hp.getDestroy();
%>

<% 
    int messageCount=0;
    String[][] message;
    int watchListCount=0;
    String[][] watchList;
    String answer = request.getParameter("answerInput");
    
    if (answer.equals("")){
         UserInfo.login();
    }else{
         UserInfo.login_forget();
    }


    if (UserInfo.getAuthorized()){

      	MessageList.setUserId(UserInfo.getUserId());
    
    	MessageList.retriveMessageList();     
    	messageCount = MessageList.getMessageCount();
    	message = MessageList.getMessage(); 
    

	Activity.setUserId(UserInfo.getUserId());
	Activity.setToDate(UserInfo.getSysdate());
	
	WatchList.setUserId(UserInfo.getUserId());
	WatchList.setMeasureFlag(UserInfo.getMeasureFlag());
	watchList = WatchList.getWatchList();
	watchListCount = WatchList.getWatchListCount();
    }else{
%>
	<jsp:forward page="wrongPwd.jsp" />
	</jsp:forward>
<%    }
%>

<%
    String[][] newslist;
    int newsCount=0;
    
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    
%>
   
<SCRIPT LANGUAGE="Javascript">
        
    function makeHref(e,flag){  
        var mf=document.activityForm;
        var from = mf.fromDate.value;
        var to   = mf.toDate.value;
        
      	e.href = "ActList.jsp?getFlag=" + flag + "&fromDate=" + from + "&toDate=" + to;

        return true;             
     }
     

</SCRIPT>
<SCRIPT LANUGAGE="JavaScript">

function xl_callpage(htmlurl) {
  var newwin=window.open(htmlurl,"XLWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=605,height=500");
  newwin.focus();
  return false;
}

function xl_callpage2(htmlurl,theform) {
  var newhtmlurl
  newhtmlurl = htmlurl + "?STYLE=SSQX&STKNO=" + theform.STKNO.value + "&MT=GET"
  var newwin=window.open(newhtmlurl,"XLWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=605,height=500");
  newwin.focus();
  return false;
}
</SCRIPT>

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
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="834" width="159" valign="top"> 
      <script language="JavaScript" src="../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="postcenter/demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../images/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="postcenter/product_list.jsp" class="font9"><font color="#000000">供应发布</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="postcenter/request2buy.jsp"><font color="#000000">需求发布</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="postcenter/order_search.jsp"><font color="#000000">浏览供需</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="mycustomer.jsp"><font color="#000000">我的客户</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="postcenter/product_list.jsp"><font color="#000000">我的产品</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">ID直通车</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="进入">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('foreignX.htm')"><font color="#FFFFFF">外汇汇率换算</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="jiaoyifu.htm"><font color="#FFFFFF">交易服务</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('huansuanresult.jsp')"><font color="#FFFFFF">计量单位转换</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../images/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </form>
      </div>
      <img src="../images/space.gif" width="159" height="1"></td>
    <td height="834" width="426" valign="top"> 
      
            <table width="414" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="102"><img src="../images/gerenxix.gif" width="102" height="25"></td>
                <td bgcolor="#4078E0"><img src="../images/space.gif" width="229" height="1"></td>
                
          <td><a href=javascript:onClick=launchRemote('../html/help/help_1.htm')><img src="../images/bz1.gif" width="83" height="25" alt="点击弹出帮助信息窗口 " border="0"></a></td>
              </tr>
            </table>
            <table width="414" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="68" height="40" bgcolor="#D8E4F8" rowspan="2"><img src="../images/pic1.gif" width="65" height="35"></td>
                <td width="205" height="39" bgcolor="#D8E4F8" class="font9">您有<%=messageCount%>条新信息！</td>
                
          <td width="132" height="40" bgcolor="#D8E4F8" rowspan="2" valign="top"><a href="MessageList_all.jsp?pageNo=1"><img src="../images/entergrxx.gif" width="101" height="17" border="0"></a></td>
                <td rowspan="7" width="9" background="../images/blackline.gif"><img src="../images/space.gif" width="9" height="1"></td>
              </tr>
              <tr> 
                <td width="205" height="1" bgcolor="#D8E4F8" class="font9"><img src="../images/space.gif" width="205" height="1"></td>
              </tr>
          <%
           if (messageCount!=0){
             for (int i=0;i<4;i++){
          	if (i%2==0) {
          %>
              <tr> 
                 <td colspan="3" bgcolor="#B0C8F0" height="20"><a href="MessageDetail.jsp?messId=<%=message[i][0]%>" class="font10"><%=message[i][0]%>、<%=message[i][1]%></a></td>
              </tr>
          <%    }else{ %>      
              <tr> 
          	 <td colspan="3" bgcolor="#D8E4F8" height="20"><a href="MessageDetail.jsp?messId=<%=message[i][0]%>" class="font10"><%=message[i][0]%>、<%=message[i][1]%></a></td>
              </tr>
          <%    }
              }
           }
          %>    
              <tr> 
                <td colspan="3"><img src="../images/space.gif" width="405" height="1"></td>
              </tr>
              <tr> 
                <td colspan="4" height="5"><img src="../images/blackline2.gif" width="414" height="19"></td>
        </tr>
            </table>
       <form name="watchListForm" method="post" action="postcenter/order_search.jsp">
                  <table width="414" border="0" cellspacing="0" cellpadding="0">
       <tr> 
                      
            <td width="90"><img src="../images/kehulibiao.gif" width="90" height="25"></td>
                      
            <td width="186" bgcolor="#4078E0"><img src="../images/space.gif" width="186" height="1"></td>
                
            <td width="82"><a href=javascript:onClick=launchRemote('../html/help/help_2.htm')><img src="../images/bz2.gif" width="82" height="25" alt="点击弹出帮助信息窗口 " border="0"></a></td>
            <td width="40"><a href="mywatchlist.jsp"><img src="../images/shezi2.gif" width="56" height="25" border="0" alt="自定义个人设置 "></a></td>
                    </tr>
                  </table>
<table width="414" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="39" width="65" bgcolor="#D8E4F8" rowspan="2"><img src="../images/pic2.gif" width="65" height="35"></td>
            <td height="10" width="344" bgcolor="#D8E4F8" class="10font">&nbsp; </td>
            <td rowspan="2" width="9" background="../images/blackline.gif">&nbsp;</td>
          </tr>
          <tr> 
            <td height="10" width="344" bgcolor="#D8E4F8" class="dan10"> <span class="font9">通过产品查询</span><img src="../images/space.gif" width="60" height="1">
              <span class="font9">供应</span> 
              <input type="radio" name="buyFlag" value="S" checked>
              <span class="font9">需求</span> 
              <input type="radio" name="buyFlag" value="B">
              <input type="submit" name="Submit5" value="检 索">
            </td>
          </tr>
        </table>
        <table width="414" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td colspan="9" height="1" bgcolor="#D8E4F8"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="9" background="../images/blackline.gif"><img src="../images/space.gif" width="9" height="1"> 
            </td>
          </tr>
          <tr> 
            <td width="60" align="center" bgcolor="#3F78DD" height="22"><font color="#FFFFFF" class="white10">发布号</font></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="149" align="center" bgcolor="#3F78DD"><font color="#FFFFFF" class="white10">摘要</font></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="77" align="center" bgcolor="#3F78DD"><font color="#FFFFFF" class="white10">到期时间</font></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="70" align="center" bgcolor="#3F78DD"><font color="#FFFFFF" class="white10">数量</font></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="45" align="center" bgcolor="#3F78DD"><font color="#FFFFFF" class="white10">状态</font></td>
            <td rowspan="2" background="../images/blackline.gif"><img src="../images/space.gif" width="9" height="1"> 
              <img src="../images/space.gif" width="9" height="1"> </td>
          </tr>
          <tr> 
            <td width="60" align="center" bgcolor="#3F78DD" height="1"><img src="../images/space.gif" width="60" height="1"></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="149" align="center" bgcolor="#3F78DD" height="1"><img src="../images/space.gif" width="149" height="1"></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="77" align="center" bgcolor="#3F78DD" height="1"><img src="../images/space.gif" width="77" height="1"></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="70" align="center" bgcolor="#3F78DD" height="1"><img src="../images/space.gif" width="70" height="1"></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="45" align="center" bgcolor="#3F78DD" height="1"><img src="../images/space.gif" width="45" height="1"></td>
          </tr>
          <% if (watchListCount==0){%> 
          <tr> 
            <td colspan="9" align="center" bgcolor="#B3C8F1" height="22" class="font9">个人收藏夹中暂时没有信息！</td>
            <td width="9" background="../images/blackline.gif"><img src="../images/space.gif" width="9" height="1"> 
            </td>
          </tr>
          <% }else{
            	int maxNum = (watchListCount<9) ? watchListCount: 9;
                for (int i=0;i<maxNum;i++){
                   if (i%2==0){%> 
          <tr> 
            <td width="60" bgcolor="#B3C8F1" height="17" align="center"><a href="postcenter/demand_info.jsp?posting_id=<%=watchList[i][0]%>" class="font10"><%=watchList[i][0]%></a></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td bgcolor="#B3C8F1" class="font10" align="center" width="149"><%=watchList[i][1]%></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="77" bgcolor="#B3C8F1" align="center" class="font10"><%=watchList[i][2]%></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="70" bgcolor="#B3C8F1" align="center" class="font10"><%=watchList[i][3]%></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="45" bgcolor="#B3C8F1" align="center" class="font10"><%=watchList[i][4]%></td>
            <td width="9" background="../images/blackline.gif"><img src="../images/space.gif" width="9" height="1"> 
            </td>
          </tr>
          <%       }else{%> 
          <tr> 
            <td width="60" bgcolor="#D8E4F8" height="17" align="center"><a href="postcenter/demand_info.jsp?posting_id=<%=watchList[i][0]%>" class="font10"><%=watchList[i][0]%></a></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="149" bgcolor="#D8E4F8" class="font10" align="center"><%=watchList[i][1]%></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="77" bgcolor="#D8E4F8" align="center" class="font10"><%=watchList[i][2]%></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="70" bgcolor="#D8E4F8" align="center" class="font10"><%=watchList[i][3]%></td>
            <td width="1"><img src="../images/space.gif" width="1" height="1"></td>
            <td width="45" bgcolor="#D8E4F8" align="center" class="font10"><%=watchList[i][4]%></td>
            <td width="9" background="../images/blackline.gif"><img src="../images/space.gif" width="9" height="1"> 
            </td>
          </tr>
          <%       }
                 }
               }%> 
          <tr> 
            <td bgcolor="#D8E4F8" colspan="9" align="right"><span class="font10"><a href="mywatchlist.jsp">更多..</a></span>.</td>
            <td background="../images/blackline.gif">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="10" height="5"> <img src="../images/blackline2.gif" width="414" height="19"></td>
          </tr>
        </table>
      </form><form name="activityForm" method="post" action="ActList.jsp"> 
        <table width="414" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="118"><img src="../images/jiaoyihd.gif" width="118" height="25"></td>
          <td width="158" bgcolor="#4078E0"><img src="../images/space.gif" width="158" height="1"></td>
            <td width="82"><a href="javascript:onClick=launchRemote('../html/help/help_3.htm')"><img src="../images/bz2.gif" width="82" height="25" alt="点击弹出帮助信息窗口 " border="0"></a></td>
            <td width="56"><a href="SetAct.jsp"><img src="../images/shezi2.gif" width="56" height="25" border="0" alt="自定义个人设置 "></a></td>
        </tr>
      </table>
      <table width="414" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="65" height="45" bgcolor="#D8E4F8"><img src="../images/pic3.gif" width="65" height="35"></td>
          <td width="342" height="45" bgcolor="#D8E4F8"> 
              <span class="font9">从：</span> 
              <input type="text" name="fromDate" size="10" value="2000-01-01" onBlur="validDateField(this)">
              <span class="font9">到：</span> 
              <input type="text" name="toDate" size="10" value="<%=UserInfo.getSysdate()%>" onBlur="validDateField(this)">
              <input type="submit" name="Submit" value="查询">
          </td>
          <td width="9" height="45" background="../images/blackline.gif">&nbsp;</td>
        </tr>
      </table>
        <table width="414" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="97" bgcolor="#B0C8F0" height="21" align="center"><a href="#" onClick="javascript:makeHref(this,2)" class="balck14">报价行为</a>：</td>
            <% Activity.setGetFlag("2");%>
            <td width="97" bgcolor="#B0C8F0" height="21" class="font9" align="center"><%=Activity.getActCount()%></td>
            <td width="120" bgcolor="#B0C8F0" height="21" align="center"><a href="#" onClick="javascript:makeHref(this,3)" class="balck14">求　　购：</a></td>
            <% Activity.setGetFlag("3");%>
            <td width="91" bgcolor="#B0C8F0" height="21" class="font9" align="center"><%=Activity.getActCount()%></td>
          <td rowspan="3" width="9" background="../images/blackline.gif"><img src="../images/space.gif" width="9" height="8"></td>
        </tr>
        <tr> 
            <td width="97" bgcolor="#D8E4F8" height="17" align="center"><a href=#" onClick="javascript:makeHref(this,1)" class="balck14">供　　应</a>：</td>
            <% Activity.setGetFlag("1");%>
            <td width="97" bgcolor="#D8E4F8" height="17" class="font9" align="center"><%=Activity.getActCount()%></td>
            <td width="120" bgcolor="#D8E4F8" height="17" align="center"><a href="#" onClick="javascript:makeHref(this,4)" class="balck14">成交次数：</a></td>
            <% Activity.setGetFlag("4");%>
            <td width="91" bgcolor="#D8E4F8" height="17" class="font9" align="center"><%=Activity.getActCount()%></td>
        </tr>
        <tr> 
          <td colspan="4" height="1" class="font9"><img src="../images/space.gif" width="405" height="1"></td>
        </tr>
        <tr> 
           <td colspan="5" height="5"><img src="../images/blackline2.gif" width="414" height="19"></td>
        </tr>
</table></form><table width="414" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="102"><img src="../images/genrenzlgli.gif" width="102" height="25"></td>
          <td bgcolor="#4078D8"><img src="../images/space.gif" width="174" height="1"></td>
          <td width="82"><a href="javascript:onClick=launchRemote('../html/help/help_4.htm')"><img src="../images/bz2.gif" width="82" height="25" alt="点击弹出帮助信息窗口 " border="0"></a></td>
          <td width="56"><a href="profile2.jsp?status="><img src="../images/shezi2.gif" width="56" height="25" border="0" alt="自定义个人设置 "></a></td>
        </tr>
</table>
      <table width="414" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="66" height="40" bgcolor="#D8E4F8"><img src="../images/pic4.gif" width="65" height="35"></td>
          <td width="339" height="40" bgcolor="#D8E4F8" class="dan10">点击设置进入，可以管理个人资料，更改密码，申请为卖方会员和主用户管理设置 
          </td>
          <td rowspan="3" height="60" width="9" background="../images/blackline.gif">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2" height="20" align="right" bgcolor="#B8C8F0" class="font9">安全和保密策略</td>
        </tr>
        <tr> 
          <td colspan="2" height="1" align="right" class="font9"><img src="../images/space.gif" width="405" height="1"></td>
        </tr>
        <tr> 
          <td colspan="3"><img src="../images/blackline3.gif" width="414" height="19"></td>
        </tr>
      </table>
    </td>
    <td height="834" width="191" valign="top"> 
      <form name="emailForm" method="post" action="http://202.105.49.61/cgi-bin/sqwebmail?do.login=Login">
        <input type="hidden" name="username" value="<%=UserInfo.getUsername()%>@mail.paperec.com">
        <input type="hidden" name="password" value="<%=UserInfo.getPassword()%>">
      <table width="188" border="0" cellspacing="0" cellpadding="0" height="40">
        <tr> 
          <td height="39"><a href="tt">
              <input type="image" src="../images/mail_button.gif" width="188" height="40" alt="免费电子邮箱登录口">
              </a></td>
        </tr>
      </table>
      </form>
      <br>
      <table width="188" border="0" cellspacing="0" cellpadding="0" height="134">
        <tr bgcolor="#666666" align="center"> 
          <td height="134"> 
            <table width="186" border="0" cellspacing="0" cellpadding="0" height="132" bgcolor="#3F78DD" >
              <tr bgcolor="#301090"> 
                <td colspan="2"><img src="../images/rightzx.gif" width="186" height="24"></td>
              </tr>
              <tr> 
                <td width="70" align="center" height="18"><a href="#" class="white10">市场行情</a></td>
                <td width="70" align="center" height="18"><a href="../html/zyzx/zcfg.htm" class="white10">政策法规</a></td>
              </tr>
              <tr> 
                <td width="70" align="center" height="18"><a href="../html/zyzx/hyjs_index.htm" class="white10">行业介绍</a></td>
                <td width="70" align="center" height="18"><a href="#" class="white10">大事年表</a></td>
              </tr>
              <tr> 
                <td width="70" align="center" height="18"><a href="#" class="white10">纸业书刊</a></td>
                <td width="70" align="center" height="18"><a href="#" class="white10">业内论坛</a></td>
              </tr>
              <tr> 
                <td width="70" align="center" height="18"><a href="#" class="white10">专业字典</a></td>
                <td width="70" align="center" height="18">&nbsp;</td>
              </tr>
              <tr> 
                <td width="70" align="center" height="18">&nbsp;</td>
                <td width="70" align="center" height="18">&nbsp;</td>
              </tr>
              <tr> 
                <td width="70" align="center" height="18">&nbsp;</td>
                <td width="70" align="center" height="18">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
      <table width="186" border="0" cellspacing="0" cellpadding="0">
        <tr align="center" bgcolor="#666666"> 
          <td height="130"> 
            <table width="184" border="0" cellspacing="0" cellpadding="0" height="128">
              <tr bgcolor="#2044B0"> 
                <td><a href="news/new_index.jsp"><img src="../images/rightxw.gif" width="180" height="19" border="0"></a></td>
              </tr>
              <tr bgcolor="#B0C8F0"> 
                <td height="109" class="font10">
              <SCRIPT language=JavaScript > marquee1();</SCRIPT>
                <% for (int i=0;i<newsCount;i++){
                     if (newslist[i][3].equals("0")){                 
                %>
                  　<img src="../images/biaozhi.gif" width="10" height="10"><a href="news/<%=newslist[i][4]%>"><%=newslist[i][1]%> (<%=newslist[i][2]%>)</a><br><br>
                <%   }else{%>
                    <img src="../images/biaozhi.gif" width="10" height="10"><a href="news/newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> (<%=newslist[i][2]%>)</a><br><br>
                <%   }
                   }
                %>
              <SCRIPT language=JavaScript > marquee2();</SCRIPT>
		</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
<form name="newsForm" method="post" action="news/newsList.jsp?pageNo=1&categoryId">
        <table width="186" border="0" cellspacing="0" cellpadding="0" height="111">
          <tr bgcolor="#666666" align="center"> 
            <td height="111" width="186"> 
              <table width="184" border="0" cellspacing="0" cellpadding="0" height="109">
                <tr bgcolor="#2044B0"> 
                  <td colspan="3"><img src="../images/rightxwjs.gif" width="180" height="19"></td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td width="67" class="font10" height="30" align="center">从：</td>
                  <td colspan="2" height="30" class="font10"> 
                    <input type="text" name="dateFrom" size="10" value="2000-01-01" onBlur="validDateField(this)">
                  </td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td width="67" class="font10" height="30" align="center">到：</td>
                  <td colspan="2" height="30" class="font10"> 
                    <input type="text" name="dateTo" size="10" value="<%=UserInfo.getSysdate()%>" onBlur="validDateField(this)">
                  </td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td class="font10" width="67" height="30" align="center">关键字：</td>
                  <td width="60" height="30"> 
                    <input type="text" name="keyWord" size="6">
                  </td>
                  <td width="59" height="30"> 
                    <input type="submit" name="Submit2" value="检索">
                  </td>
                </tr>
              </table>
          
            </td>
        </tr>
      </table></form>
      <form name="stock" method="post" action="http://chart.yestock.com/stksrv_curve/chart.asp?" id=form2 target=_blank name="form2" >
        <table width="186" border="0" cellspacing="0" cellpadding="0" height="81">
          <tr bgcolor="#666666" align="center"> 
            <td height="81"> 
              <table width="184" border="0" cellspacing="0" cellpadding="0" height="79">
                <tr bgcolor="#2044B0"> 
                  <td colspan="3"><img src="../images/righthygj.gif" width="180" height="19"></td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td class="font10" width="68" align="center" height="30">股票代码</td>
                  <td width="60" height="30"> 
                    <input type="text" name="STKNO" size="6">
                    <input name="STYLE" value="SSQX" type=hidden  >
                  </td>
                  <td width="58" height="30"> 
                    <input type="submit" name="Submit3" value="检索">
                  </td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td width="68" class="font10" align="center" height="30">股票名称</td>
                  <td width="60" height="30"> 
                    <input type="text" name="textfield34" size="6">
                  </td>
                  <td width="58" height="30"> 
                    <input type="submit" name="Submit4" value="检索">
                  </td>
                </tr>
              </table>
            
            </td>
        </tr>
      </table>
      </form><form method="post" action="">
        <table width="186" border="0" cellspacing="0" cellpadding="0" height="119">
          <tr bgcolor="#666666" align="center"> 
            <td height="50" width="186"> 
              <table width="184" border="0" cellspacing="0" cellpadding="0" height="119">
                <tr bgcolor="#2044B0"> 
                  <td ><img src="../images/myjs.gif" width="180" height="19"></td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td width="184" class="font10" height="50" align="center"><a href="meiyuejx.jsp?pick_id=<%=pickName[1]%>"><%=(pickName[0]==null?" ":pickName[0])%></a></td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td width="184" class="font10" height="50"><div align="right"><a href="meiyuejx_list.jsp"> 更多精选>></a></div></td>
                </tr>
              </table>
          
            </td>
        </tr>
      </table></form>
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

<script language="JavaScript">

function ptrim(not_trim){
	var x; var x1;
	for (x=0;not_trim.charAt(x)==' ';x++){}
	for (x1=not_trim.length-1; not_trim.charAt(x1)==' '; x1--){}
	if (x>x1) 
		return "";
	else
		return not_trim.substring(x,x1+1);
}
function CheckInteger(object_value) { 
	var GoodChars = "0123456789"; 
	var i = 0; 
	for (i=0; i<= object_value.length -1; i++) { 
	    if (GoodChars.indexOf(object_value.charAt(i)) == -1) { 
		return false; 
	    } 
	} 
	return true; 
} 

function CheckNumber(object_value) { 
	var GoodChars = "0123456789"; 
	var firstChar = object_value.charAt(0);
	var numberStr = object_value;
 	var array = new Array();
	var i = 0; 

	if (firstChar=='+'|| firstChar=='-')
	    numberStr = object_value.substring(1, object_value.length);
	
	array = numberStr.split(".");
	if (array.length ==1){
	    if (array[0].length ==0)
		return false;
	}
	else if (array.length >2){
	    return false;
	}
	for (i=0; i< array.length; i++) {
	    for (var j=0; j< array[i].length; j++) { 
		if (GoodChars.indexOf(array[i].charAt(j)) == -1) { 
		    return false; 
		}
	    } 
	} 
	return true; 
} 

function CheckDate(object_value) { 
 	var array = new Array();
	
	array = object_value.split("-");
	if (array.length !=3){
	    return false;
	}
	if (!CheckInteger(array[0]))
	    return false;
	if (!CheckInteger(array[1]))
	    return false;
	if (!CheckInteger(array[2]))
	    return false;
	if ( eval(array[0])<2000 ||eval(array[0])>9999)
	    return false;
	if ( eval(array[1])<1 ||eval(array[1])>12)
	    return false;
	if ( eval(array[2])<1 ||eval(array[2])>31)
	    return false;
	    
	return true; 
} 

function validDateField(object){
	var value = ptrim(object.value);

	if ( !CheckDate(value))
	{
	    alert("输入值非法,请核实!");
	    object.focus();
	}
}
</script>
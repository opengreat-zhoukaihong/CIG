<%-- @# index.jsp Ver.1.41 --%>

<jsp:useBean id="NewsList" scope="page" class="news.NewsList" /> 

<jsp:setProperty name="NewsList" property="langCode" value="GB"/>
<jsp:setProperty name="NewsList" property="pageFlag" value="N"/>
<jsp:setProperty name="NewsList" property="restriction" value="10"/>

<%
    String[][] newslist;
    int newsCount=0;
    
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    
%>
   <script language="JavaScript">
<!--


function launchRemote(url) {
	remote=open(url, "pic", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=718,height=400')
}

// -->
</script>
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
   // if (version == "e4")  
    {  
      document.write("<marquee behavior=scroll  direction=up  width=180 height=180 scrollamount=1 scrolldelay=60 onmouseover='this.stop()' onmouseout='this.start()'>")		 
    }  
  }  
  
  function marquee2()  
  {  	
   // if (version == "e4")  
    {  	
      document.write("</marquee>")  
    }  
  }
//-->  
</SCRIPT>

<SCRIPT LANUGAGE="JavaScript">

function xl_callpage(htmlurl) {
  var newwin=window.open(htmlurl,"XLWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=605,height=500");
  newwin.focus();
  return false;
}

function xl_callpage2(htmlurl,theform) {
  var newhtmlurl
  newhtmlurl = htmlurl + "?STYLE=SSQX&STKNO=" + theform.STKNO.value + "&MT=POST"
  var newwin=window.open(newhtmlurl,"XLWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=605,height=500");
  newwin.focus();
  return false;
}
</SCRIPT>

<html>
<head>
<title>PaperEC.com·中国纸网</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font12 {  font-family: "宋体"; font-size: 12px}
.font14 {  font-family: "宋体"; font-size: 14px}
.font12d {  font-family: "宋体"; font-size: 12px; line-height: 20px}
.scroll {  COLOR: #006633; TEXT-DECORATION: none}
.scroll:hover {	COLOR: #000000}
-->
</style>

<script language="JavaScript">
<!--

var onTop = false
function launchRemote2(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=660,height=490')
}

// -->
</script>
</head>

<body bgcolor="#000000" leftmargin="1" topmargin="1" marginwidth="1" marginheight="1">
<table width="776" border="0" cellspacing="0" cellpadding="0" height="117">
  <tr> 
    <td height="27" width="203"><img src="../images/i_01.gif" width="308" height="27"></td>
    <td height="27" width="346"><img src="../images/i_02.gif" width="241" height="27"></td>
    <td height="27" width="227" bgcolor="#003078"><img src="../images/space.gif" width="227" height="27"></td>
  </tr>
  <tr> 
    <td width="203" height="90"><img src="../images/i_03.gif" width="308" height="90" alt="中国纸网的标志"></td>
    <td width="346" height="90"><a href="javascript:onClick=launchRemote2('../html/wi-cn/0.htm')"><img src="../images/i_04.gif" width="241" height="90" alt="快速了解中国纸网的内部结构和资源" border="0"></a></td>
    <td width="227" height="90" bgcolor="#003078" valign="bottom"> 
      <table width="200" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td colspan="3"><img src="../images/stock_title.gif" width="200" height="22"></td>
        </tr>
        <tr bgcolor="#E8E8FF"> 
          <form name="stock" method="post" action="http://chart.yestock.com/stksrv_curve/chart.asp?" id=form2 target=_blank name="form2" >
            <td colspan="3" class="font12" bgcolor="#E8E8FF" align="center">股票代码： 
              <input type="text" name="STKNO" size="8">
              <input name="STYLE" value="SSQX" type=hidden  >
              <input type="submit" name="Submit" value="查询">
            </td>
          </form>
        </tr>
        <tr> 
          <td colspan="3"><img src="../images/o_down_200.gif" width="200" height="10"></td>
        </tr>
      </table>
     
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0" height="19">
  <tr>
    <td height="19" width="195"><img src="../images/i_05.gif" width="195" height="19"></td>
    <td height="19" width="581" bgcolor="#023074">&nbsp; </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0" height="55">
  <tr>
    <td><img src="../images/i_link.gif" width="776" height="55" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="641,17,714,48" href="paperec_index.jsp?mainFrame=contactus" alt="获取中国纸网的联系地址和方式" title="获取中国纸网的联系地址和方式"><area shape="rect" coords="540,17,613,48" href="#" alt="点击这里，获取帮助" title="点击这里，获取帮助"><area shape="rect" coords="336,17,409,48" href="paperec_index.jsp?mainFrame=registerInfo" alt="在线注册和申请会员资格" title="在线注册和申请会员资格"><area shape="rect" coords="237,18,310,49" href="paperec_index.jsp?mainFrame=aboutus" alt="全面获取中国纸网的介绍信息" title="全面获取中国纸网的介绍信息"><area shape="rect" coords="441,21,504,47" href="javascript:onClick=launchRemote('../html/flash/pp.html')"></map></td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0" height="239">
  <tr> 
    <td width="236"><img src="../images/i_06.gif" width="236" height="78" alt="会员区域，畅游纸业资讯，进行电子交易" usemap="#Map4" border="0"><map name="Map4"><area shape="rect" coords="168,13,238,73" href="paperec_index.jsp?mainFrame=relogin&answerInput="></map></td>
    <td height="78" width="159"><a href="paperec_index.jsp?mainFrame=relogin&answerInput="><img src="../images/i_07.gif" width="159" height="78" alt="会员区域，畅游纸业资讯，进行电子交易" border="0"></a></td>
    <td height="78" width="161"><img src="../images/i_08.gif" width="161" height="78" usemap="#Map3" border="0"></td>
    <td height="239" rowspan="3" bgcolor="#003078" align="center" width="220"> 
      <table width="199" border="0" cellspacing="0" cellpadding="0" align="center">
        <form method="post" action="" >
          <tr> 
            <td><img src="../images/news_title.gif" width="199" height="22"></td>
          </tr>
          <tr bgcolor="#E8E8FF"> 
            <td class="font12d"> 
              <table width="190" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="6" height="129">&nbsp;</td>
                  <td width="180" class="font12" height="129"> 
                    <div style="position:relative;width:180;height:180;clip:rect(0 180 180 0);"> 
                      <SCRIPT language=JavaScript > marquee1();</SCRIPT>
                      <table width="174" border="0" cellspacing="0" cellpadding="1">
                        <% for (int i=0; i<newslist.length && newslist[i]!=null; i++){
     if (newslist[i][3].equals("0")){                 
%> 
                        <tr> 
                          <td width="10" valign="top"><img src="../images/biaozhi.gif" width="10" height="10"></td>
                          <td width="164" class="font12"><a class=scroll href="paperec_index.jsp?mainFrameSrc=<%=newslist[i][4]%>"><%=newslist[i][1]%> 
                            <%=newslist[i][2]%></a></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <%   }else{%> 
                        <tr> 
                          <td width="10" valign="top"><img src="../images/biaozhi.gif" width="10" height="10"></td>
                          <td width="164" class="font12"><a class=scroll href="paperec_index.jsp?mainFrameSrc=news/newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> 
                            (<%=newslist[i][2]%>)</a></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <%   }
   }
%> <%--              .美国环保局加大执行清洁空气法案<br>
              .马来西亚计划在两年内新添三部纸<br>
              .超韧厕纸险累英国塞厕所<br>
              .中兴纸业预定6月30日完成民营<br>
              .台湾向长纤维纸浆发展<br>
              .复印纸有害人体健康<br>
              .晨鸣签约对日出口五万吨低定<br>
              .中兴纸业预定6月30日完成民营<br>
              .台湾向长纤维纸浆发展<br>
--%> 
                      </table>
                      <SCRIPT language=JavaScript > marquee2();</SCRIPT>
                    </div>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td height="10"><img src="../images/o_down.gif" width="199" height="10"></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="236"><img src="../images/i_09.gif" width="236" height="91" align="top" usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="5,2,73,22" href="#"><area shape="rect" coords="82,2,150,22" href="paperec_en/index.jsp"></map></td>
    <td height="91" width="159" bgcolor="#003078"> 
      <table width="159" border="0" cellspacing="0" cellpadding="0">
        <form method="post" name="inputForm" action="paperec_index.jsp?mainFrame=login&answerInput=">
          <tr> 
            <td class="font14" width="60"><font color="#FFFFFF">用户名：</font></td>
            <td width="99"> 
              <input type="text" name="username" accesskey="p" size="10">
            </td>
          </tr>
          <tr> 
            <td class="font14" width="60"><font color="#FFFFFF">密　码：</font></td>
            <td width="99"> 
              <input type="password" name="password" accesskey="a" size="10">
            </td>
          </tr>
          <tr> 
            <td colspan="2" class="font12"><font color="#FFCC33"><a href="#" onClick="return makeHref(this)"><font color="#FFCC33">忘记密码了？</font></a><img src="../images/space.gif" width="26" height="22"> 
              <input type="submit" name="Submit2" value="进入">
              </font></td>
          </tr>
        </form>
      </table>
    </td>
    <td height="91" width="161"><a href="javascript:onClick=launchRemote('../html/flash/pp.html')"><img src="../images/i_12.gif" width="161" height="91" border="0"></a></td>
  </tr>
  <tr> 
    <td width="236"><img src="../images/i_10.gif" width="236" height="70"></td>
    <td height="70" width="159"><img src="../images/i_11.gif" width="159" height="70"></td>
    <td height="70" width="161"><img src="../images/i_13.gif" width="161" height="70"></td>
  </tr>
</table>
<div id="Layer1" style="position:absolute; width:55px; height:40px; z-index:1; left: 6px; top: 360px"><a href="http://www.hd315.gov.cn/beian/view.asp?bianhao=0272000121100006" target="_blank"><img src="../images/biaoshi.gif" width="40" height="48" border="0"></a></div>
<map name="Map3">
  <area shape="rect" coords="34,15,132,66" href="#">
</map>
</body>
</html>

<SCRIPT LANGUAGE="Javascript">
        
    function makeHref(e){  
        var mf=document.inputForm;
        var userName = mf.username.value;
        
        if (userName == ''){
        	alert("请输入您的用户名!");
        	mf.username.focus();
        	return false;
        }else{
      		e.href = "paperec_index.jsp?mainFrame=forget&username=" + userName;
	        return true;             
	}
     }
     
</SCRIPT>


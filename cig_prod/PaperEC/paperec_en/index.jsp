<%-- @# index.jsp Ver.1.2 --%>

<jsp:useBean id="NewsList" scope="page" class="news.NewsList" /> 

<jsp:setProperty name="NewsList" property="langCode" value="EN"/>
<jsp:setProperty name="NewsList" property="pageFlag" value="N"/>
<jsp:setProperty name="NewsList" property="restriction" value="5"/>

<%
    String[][] newslist;
    int newsCount=0;
    
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    
%>
     <script language="JavaScript">
<!--


function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=610,height=402')
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
    if (version == "e4")  
    {  
      document.write("<marquee behavior=scroll  direction=up  width=180 height=180 scrollamount=1 scrolldelay=60 onmouseover='this.stop()' onmouseout='this.start()'>")		 
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

<html>
<head>
<title>PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font12 {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 11px}
.font14 {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 13px}
.font12d {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 11px; line-height: 20px}
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
    <td height="27" width="203"><img src="../../images/images_en/i_01.gif" width="308" height="27"></td>
    <td height="27" width="346"><img src="../../images/images_en/i_02.gif" width="241" height="27"></td>
    <td height="27" width="227" bgcolor="#003078"><img src="../../images/images_en/space.gif" width="227" height="27"></td>
  </tr>
  <tr> 
    <td width="203" height="90"><img src="../../images/images_en/i_03.gif" width="308" height="90" alt="Logo of PaperEC.com"></td>
    <td width="346" height="90"><a href="javascript:onClick=launchRemote2('../../html/html_en/wi-en/0.htm')"><img src="../../images/images_en/i_04.gif" width="241" height="90" alt="A quick tour to PaperEC.com" border="0"></a></td>
    <td width="227" height="90" bgcolor="#003078" valign="bottom"> 
      <table width="200" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td colspan="3"><img src="../../images/images_en/stock_title.gif" width="200" height="22"></td>
        </tr>
        <tr bgcolor="#E8E8FF"> 
          <form name="stock" method="post" action="http://chart.yestock.com/stksrv_curve/chart.asp?" id=form2 target=_blank name="form2" >
            <td colspan="3" class="font12" bgcolor="#E8E8FF" align="center">Enter Code: 
              <input type="text" name="STKNO" size="8">
              <input name="STYLE" value="SSQX" type=hidden  >
              <input type="submit" name="Submit" value="Get Quotes">
            </td>
          </form>
        </tr>
        <tr> 
          <td colspan="3"><img src="../../images/images_en/o_down_200.gif" width="200" height="10"></td>
        </tr>
      </table>
     
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0" height="19">
  <tr>
    <td height="19" width="195"><img src="../../images/images_en/i_05.gif" width="195" height="19"></td>
    <td height="19" width="581" bgcolor="#023074">&nbsp; </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0" height="55">
  <tr>
    <td><img src="../../images/images_en/i_link.gif" width="776" height="55" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="641,17,727,48" href="paperec_index.jsp?mainFrame=contactus" alt="How to contact PaperEC.com" title="How to contact PaperEC.com"><area shape="rect" coords="540,17,627,47" href="#" alt="Click here if you have any question" title="Click here if you have any question"><area shape="rect" coords="336,17,420,46" href="paperec_index.jsp?mainFrame=registerInfo" alt="Online membership registration" title="Online membership registration"><area shape="rect" coords="237,15,322,49" href="paperec_index.jsp?mainFrame=aboutus" alt="Information about PaperEC.com" title="Information about PaperEC.com"></map></td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0" height="239">
  <tr> 
    <td width="236"><img src="../../images/images_en/i_06.gif" width="236" height="78" alt="Industrial information and online E-business, for members only" usemap="#Map4" border="0"><map name="Map4"><area shape="rect" coords="164,11,235,76" href="paperec_index.jsp?mainFrame=relogin&answerInput="></map></td>
    <td height="78" width="159"><a href="paperec_index.jsp?mainFrame=relogin&answerInput="><img src="../../images/images_en/i_07.gif" width="159" height="78" alt="Industrial information and online E-business, for members only" border="0"></a></td>
    <td height="78" width="161"><img src="../../images/images_en/i_08.gif" width="161" height="78"></td>
    <td height="239" rowspan="3" bgcolor="#003078" align="center" width="220"> 
      <table width="199" border="0" cellspacing="0" cellpadding="0" align="center">
           <form method="post" action="" ><tr> 
            <td><img src="../../images/images_en/news_title.gif" width="199" height="22"></td>
          </tr>
          <tr bgcolor="#E8E8FF"> 
            <td class="font12d">
              <table width="190" border="0" cellspacing="0" cellpadding="2">
                <tr>
                  <td width="6" height="129">&nbsp;</td>
                  <td width="180" class="font12" height="129">
              <SCRIPT language=JavaScript > marquee1();</SCRIPT>
<% for (int i=0; i<newslist.length && newslist[i]!=null; i++){
     if (newslist[i][3].equals("0")){                 
%>
<img src="../../images/biaozhi.gif" width="10" height="10"><a class=scroll href="paperec_index.jsp?mainFrameSrc=news/<%=newslist[i][4]%>"><%=newslist[i][1]%> (<%=newslist[i][2]%>)</a><br><br>
<%   }else{%>
<img src="../../images/biaozhi.gif" width="10" height="10"><a class=scroll href="paperec_index.jsp?mainFrameSrc=news/newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> (<%=newslist[i][2]%>)</a><br><br>
<%   }
   }
%>
<%--              .美国环保局加大执行清洁空气法案<br>
              .马来西亚计划在两年内新添三部纸<br>
              .超韧厕纸险累英国塞厕所<br>
              .中兴纸业预定6月30日完成民营<br>
              .台湾向长纤维纸浆发展<br>
              .复印纸有害人体健康<br>
              .晨鸣签约对日出口五万吨低定<br>
              .中兴纸业预定6月30日完成民营<br>
              .台湾向长纤维纸浆发展<br> 
--%>
              <SCRIPT language=JavaScript > marquee2();</SCRIPT>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td height="10"><img src="../../images/images_en/o_down.gif" width="199" height="10"></td>
          </tr></form>
        </table>
     
    </td>
  </tr>
  <tr> 
    <td width="236"><img src="../../images/images_en/i_09.gif" width="236" height="91" align="top" usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="5,2,73,22" href="../index.jsp"><area shape="rect" coords="82,2,150,22" href="#"></map></td>
    <td height="91" width="159" bgcolor="#003078">
      <table width="159" border="0" cellspacing="0" cellpadding="0">
        <form method="post" name="inputForm" action="paperec_index.jsp?mainFrame=login&answerInput=">
          <tr> 
            <td class="font14" width="60"><font color="#FFFFFF">Username</font></td>
            <td width="99"> 
              <input type="text" name="username" accesskey="p" size="10">
            </td>
          </tr>
          <tr> 
            <td class="font14" width="60"><font color="#FFFFFF">Password</font></td>
            <td width="99"> 
              <input type="password" name="password" accesskey="a" size="10">
            </td>
          </tr>
          <tr> 
            <td class="font12"><font color="#FFCC33"><a href="#" onClick="return makeHref(this)"><font color="#FFCC33">Forgot 
              password?</font></a> </font></td>
            <td class="font12"><font color="#FFCC33">
              <input type="submit" name="Submit2" value="Sign In">
              </font></td>
          </tr>
        </form>
      </table>
    </td>
    <td height="91" width="161"><img src="../../images/images_en/i_12.gif" width="161" height="91" border="0"></td>
  </tr>
  <tr> 
    <td width="236"><img src="../../images/images_en/i_10.gif" width="236" height="70"></td>
    <td height="70" width="159"><img src="../../images/images_en/i_11.gif" width="159" height="70"></td>
    <td height="70" width="161"><img src="../../images/images_en/i_13.gif" width="161" height="70"></td>
  </tr>
</table>
<div id="Layer1" style="position:absolute; width:55px; height:40px; z-index:1; left: 6px; top: 360px"><a href="http://www.hd315.gov.cn/beian/view.asp?bianhao=0272000121100006" target="_blank"><img src="../../images/images_en/biaoshi.gif" width="40" height="48" border="0" alt="Electronic Sign Approved By PRC Government"></a></div>
<span class="font12d"></span> 
</body>
</html>

<SCRIPT LANGUAGE="Javascript">
        
    function makeHref(e){  
        var mf=document.inputForm;
        var userName = mf.username.value;
        
        if (userName == ''){
        	alert("Please input your user name!");
        	mf.username.focus();
        	return false;
        }else{
      		e.href = "paperec_index.jsp?mainFrame=forget&username=" + userName;
	        return true;             
	}
     }
     
</SCRIPT>


<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
<!--

var onTop = false
function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}

// -->

<%@ page info="我的纸网--PaperEC.com"%>
<%@ page import="java.util.*" %>

<jsp:useBean id="NewsList" scope="page" class="com.cig.news.NewsList" /> 
<jsp:setProperty name="News" property="dbpoolName" value="paperec"/>
<jsp:setProperty name="NewsList" property="langCode" value="GB"/>
<jsp:setProperty name="NewsList" property="pageFlag" value="N"/>
<jsp:setProperty name="NewsList" property="restriction" value="7"/>


<%
    String[][] newslist;
    int newsCount=0;
    String cate_name="";
%>
  
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<style type="text/css">
<!--
.white {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none}
a:visited {  text-decoration: none}
a:active {  text-decoration: none}
a:hover {  text-decoration: underline}
td {  font-size: 10pt}
.black {  color: #000000}
.algin {  font-size: 11pt; text-align: justify; line-height: 15pt}
.b9 {  font-size: 10pt}
.textfield {  border-color: #4078E0 #FFFFFF; border: 1px solid}
.yellow {  font-size: 10pt; color: #FF9900}
.title {  font-size: 12pt; font-weight: bold}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../../images/more_news_cn1.gif')">
<table width="778" border="0" cellspacing="3" cellpadding="3">
  <tr> 
    <td width="160"> 
      <script language="JavaScript" src="../../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:94px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="53"> 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr bgcolor="#4078E0" align="center"> 
                  <td width="139" height="22"><a href="#" class="white">分类新闻</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="22" width="139"><a href="aboutus_gongsyaow.jsp" class="white">公司要闻</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="22" width="139"><a href="#" class="white">业内论坛</a></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../../images/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div>
    </td>
    <td valign="top"> 
      <table border="0" cellpadding="0" cellspacing="0">
        <%    
    NewsList.setCategoryId("4");
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    cate_name = NewsList.getCateName();
    
%> 
        <tr> 
          <td width="10"><img src="../../images/news_06.gif" width="10" height="29"></td>
          <td background="../../images/news_007.gif" width="220" valign="bottom" ><%=cate_name%></td>
          <td width="24"><img src="../../images/news_08.gif" width="24" height="29"></td>
        </tr>
        <tr> 
          <td align="left" rowspan="2" valign="bottom" width="10"><img src="../../images/line_news.gif" width="1" height="190"></td>
          <td width="220" height="160"> <% for (int i=0;i<newsCount;i++){
            if (newslist[i][3].equals("0")){
        %> <img src="../../images/aico.gif" width="16" height="18"><a href="<%=newslist[i][4]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  }else{%> <img src="../../images/aico.gif" width="16" height="18"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  } 
           }%> </td>
          <td align="right" rowspan="2" valign="bottom" width="24"><img src="../../images/line_news.gif" width="1" height="190"></td>
        </tr>
        <tr> 
          <td align="right" valign="bottom" ><a href="newsList.jsp?pageNo=1&categoryId=4" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/more_news_cn1.gif',1)"><img src="../../images/more_news_cn.gif" width="60" height="18" border="0" name="Image1"></a></td>
        </tr>
        <tr> 
          <td colspan="3" bgcolor="#0033CC" height="1"><img src="images/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
      <br>
      <table border="0" cellpadding="0" cellspacing="0">
        <%    
    NewsList.setCategoryId("7");
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    cate_name = NewsList.getCateName();
    
%> 
        <tr> 
          <td><img src="../../images/news_06.gif" width="10" height="29"></td>
          <td background="../../images/news_007.gif" width="220" valign="bottom"><%=cate_name%></td>
          <td><img src="../../images/news_26.gif" width="24" height="29"></td>
        </tr>
        <tr> 
          <td align="left" valign="bottom" rowspan="2"><img src="../../images/line_news.gif" width="1" height="180"></td>
          <td height="170" width="220"> <% for (int i=0;i<newsCount;i++){
            if (newslist[i][3].equals("0")){
        %> <img src="../../images/aico.gif" width="16" height="18"><a href="<%=newslist[i][4]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  }else{%> <img src="../../images/aico.gif" width="16" height="18"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  } 
           }%> </td>
          <td align="right" valign="bottom" rowspan="2"><img src="../../images/line_news.gif" width="1" height="180"></td>
        </tr>
        <tr> 
          <td align="right" valign="bottom"><a href="newsList.jsp?pageNo=1&categoryId=7" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/more_news_cn1.gif',1)"><img src="../../images/more_news_cn.gif" width="60" height="18" border="0" name="Image14"></a></td>
        </tr>
        <tr> 
          <td colspan="3" bgcolor="#0033CC"><img src="images/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
      <br>
      <table border="0" cellpadding="0" cellspacing="0">
        <%    
    NewsList.setCategoryId("8");
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    cate_name = NewsList.getCateName();
    
%> 
        <tr> 
          <td><img src="../../images/news_06.gif" width="10" height="29"></td>
          <td background="../../images/news_007.gif" width="220" valign="bottom"><%=cate_name%></td>
          <td><img src="../../images/news_30.gif" width="24" height="29"></td>
        </tr>
        <tr> 
          <td align="left" rowspan="2" valign="bottom"><img src="../../images/line_news.gif" width="1" height="180"></td>
          <td height="170" width="220"> <% for (int i=0;i<newsCount;i++){
            if (newslist[i][3].equals("0")){
        %> <img src="../../images/aico.gif" width="16" height="18"><a href="<%=newslist[i][4]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  }else{%> <img src="../../images/aico.gif" width="16" height="18"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  } 
           }%> </td>
          <td align="right" rowspan="2" valign="bottom"><img src="../../images/line_news.gif" width="1" height="180"></td>
        </tr>
        <tr> 
          <td align="right" valign="bottom"><a href="newsList.jsp?pageNo=1&categoryId=8" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/more_news_cn1.gif',1)"><img src="../../images/more_news_cn.gif" width="60" height="18" border="0" name="Image13"></a></td>
        </tr>
        <tr> 
          <td colspan="3" bgcolor="#0033CC"><img src="images/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
      <br>
    </td>
    <td valign="top"> 
      <table border="0" cellpadding="0" cellspacing="0">
        <%    
    NewsList.setCategoryId("5");
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    cate_name = NewsList.getCateName();
    
%> 
        <tr> 
          <td><img src="../../images/news_06.gif" width="10" height="29"></td>
          <td background="../../images/news_007.gif" width="220" valign="bottom"><%=cate_name%></td>
          <td><img src="../../images/news_15.gif" width="24" height="29"></td>
        </tr>
        <tr> 
          <td align="left" valign="bottom" rowspan="2"><img src="../../images/line_news.gif" width="1" height="180"></td>
          <td height="160" width="220"> <% for (int i=0;i<newsCount;i++){
            if (newslist[i][3].equals("0")){
        %> <img src="../../images/aico.gif" width="16" height="18"><a href="<%=newslist[i][4]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  }else{%> <img src="../../images/aico.gif" width="16" height="18"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  } 
           }%> </td>
          <td align="right" valign="bottom" rowspan="2"><img src="../../images/line_news.gif" width="1" height="180"></td>
        </tr>
        <tr> 
          <td valign="bottom" align="right"><a href="newsList.jsp?pageNo=1&categoryId=5" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','../../images/more_news_cn1.gif',1)"><img src="../../images/more_news_cn.gif" width="60" height="18" border="0" name="Image11"></a></td>
        </tr>
        <tr> 
          <td colspan="3" bgcolor="#0033CC"><img src="images/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
      <br>
      <table border="0" cellpadding="0" cellspacing="0">
        <%    
    NewsList.setCategoryId("6");
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    cate_name = NewsList.getCateName();
    
%> 
        <tr> 
          <td width="10"><img src="../../images/news_06.gif" width="10" height="29"></td>
          <td background="../../images/news_007.gif" width="220" valign="bottom"><%=cate_name%></td>
          <td width="24"><img src="../../images/news_21.gif" width="24" height="29"></td>
        </tr>
        <tr> 
          <td align="left" rowspan="2" valign="bottom"><img src="../../images/line_news.gif" width="1" height="180"></td>
          <td height="170" width="220"> <% for (int i=0;i<newsCount;i++){
            if (newslist[i][3].equals("0")){
        %> <img src="../../images/aico.gif" width="16" height="18"><a href="<%=newslist[i][4]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  }else{%> <img src="../../images/aico.gif" width="16" height="18"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  } 
           }%> </td>
          <td align="right" rowspan="2" valign="bottom"><img src="../../images/line_news.gif" width="1" height="180"></td>
        </tr>
        <tr> 
          <td align="right" valign="bottom"><a href="newsList.jsp?pageNo=1&categoryId=6" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','../../images/more_news_cn1.gif',1)"><img src="../../images/more_news_cn.gif" width="60" height="18" border="0" name="Image12"></a></td>
        </tr>
        <tr> 
          <td colspan="3" bgcolor="#0033CC"><img src="images/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
      <br>
      <table border="0" cellpadding="0" cellspacing="0">
        <%    
    NewsList.setCategoryId("9");
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    cate_name = NewsList.getCateName();
    
%> 
        <tr> 
          <td><img src="../../images/news_06.gif" width="10" height="29"></td>
          <td background="../../images/news_007.gif" width="220" valign="bottom"><%=cate_name%></td>
          <td><img src="../../images/news_34.gif" width="24" height="29"></td>
        </tr>
        <tr> 
          <td align="left" valign="bottom" rowspan="2"><img src="../../images/line_news.gif" width="1" height="180"></td>
          <td height="170" width="220"> <% for (int i=0;i<newsCount;i++){
            if (newslist[i][3].equals("0")){
        %> <img src="../../images/aico.gif" width="16" height="18"><a href="<%=newslist[i][4]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  }else{%> <img src="../../images/aico.gif" width="16" height="18"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%> 
            <%=newslist[i][2]%></a><br>
            <%  } 
           }%> </td>
          <td align="right" valign="bottom" rowspan="2"><img src="../../images/line_news.gif" width="1" height="180"></td>
        </tr>
        <tr> 
          <td align="right" valign="bottom"><a href="newsList.jsp?pageNo=1&categoryId=9" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','../../images/more_news_cn1.gif',1)"><img src="../../images/more_news_cn.gif" width="60" height="18" border="0" name="Image15"></a></td>
        </tr>
        <tr> 
          <td colspan="3" bgcolor="#0033CC"><img src="images/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
    </td>
    <td width="20">&nbsp;</td>
  </tr>
</table>
<br>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../../images/dline.gif" width="776" height="6"></td>
  </tr>
  <tr align="center"> 
    <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
      2000 PaperEC.com Inc. All Rights Reserved</font></td>
  </tr>
  <tr align="center"> 
    <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif" width="80" height="24" border="0"></a></td>
  </tr>
</table>
</body>
</html>

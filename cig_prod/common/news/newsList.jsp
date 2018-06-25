 
<html>
<!-- #BeginTemplate "/Templates/aboutus_template.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.white {  font-size: 10pt; color: #FFFFFF}
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "宋体"}
.d14 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px}
.big {  font-family: "宋体"; font-size: 14px}
.d14 {  font-family: "宋体"; font-size: 14px; line-height: 22px}
.d1 {  text-align: justify}
-->
</style>
</head>

<jsp:useBean id="NewsList" scope="page" class="com.cig.news.NewsList" /> 
<jsp:setProperty name="NewsList" property="dbpoolName" value="paperec"/>
<jsp:setProperty name="NewsList" property="langCode" value="GB"/>
<jsp:setProperty name="NewsList" property="pageFlag" value="Y"/>
<jsp:setProperty name="NewsList" property="restriction" value="30"/>
<jsp:setProperty name="NewsList" property="dateFrom" value="2000-01-01" />
<jsp:setProperty name="NewsList" property="dateTo" value="2001-01-01"/>
<jsp:setProperty name="NewsList" property="keyWord" />
<jsp:setProperty name="NewsList" property="pageNo" />
<jsp:setProperty name="NewsList" property="categoryId" value="7"/>

<%
    int newsCount=0;
    int totalPage=0;
    String[][] newslist;
    int pageno = 1;
//    int pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    String category_id = request.getParameter("categoryId");  
    String cate_name="";
    
    NewsList.search();
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    totalPage = NewsList.getTotalPage();
    cate_name = NewsList.getCateName();
%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr> 
    <td width="159"> 
      <script language="JavaScript" src="../../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:204px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="53"> 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr bgcolor="#4078E0" align="center"> 
                  <td width="139" height="22"><a href="new_index.jsp" class="white">分类新闻</a></td>
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
            <td height="20"><a href="#top"><img src="../../../images/images_en/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div>
    </td>
    <td valign="top"><!-- #BeginEditable "body" --> 
      <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
        <tr bordercolor="#FFFFFF"> 
          <td height="133"> 
            <table width="550" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="25" bgcolor="#4078E0"> <img src="../../../images/images_en/space.gif" width="8" height="8"><font color="#FFFFFF"><b><%=cate_name%></b></font></td>
              </tr>
              <tr> 
                <td height="25" bgcolor="#E6EDFB" class="font10">共 <%=newsCount%> 条, 共 <%=totalPage%> 页 <img src="../../../images/images_en/space.gif" width="300" height="1">第 <%=pageno%>  页 
                </td>
              </tr>
              <%
              	  int maxNum = NewsList.restriction;            
              	  if (pageno == totalPage){
              	      maxNum = newsCount-NewsList.restriction*(pageno-1);
              	  }  
              	  if (newsCount >0){
              	      for (int i=0;i<maxNum;i++){
              	          if (i%2 ==0){
              	              if (newslist[i][3].equals("0")){
              %>
              <tr> 
                <td height="25"><img src="../../../images/images_en/space.gif" width="8" height="1"><a href="<%=newslist[i][4]%>"><span class="font10"><%=newslist[i][1]%></span></a><span class="font10"><font color="#330099"> <%=newslist[i][2]%></font></span></td>
              </tr>
              <%              }else{%>
              <tr> 
                <td height="25"><img src="../../../images/images_en/space.gif" width="8" height="1"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><span class="font10"><%=newslist[i][1]%></span></a><span class="font10"><font color="#330099"> <%=newslist[i][2]%></font></span></td>
              </tr>
              <%	      }
              		  }else{
              		      if (newslist[i][3].equals("0")){
               %>
              <tr> 
                <td height="25" bgcolor="#E6EDFB"><img src="../../../images/images_en/space.gif" width="8" height="1"><a href="<%=newslist[i][4]%>"><span class="font10"><%=newslist[i][1]%></span></a><span class="font10"><font color="#330099"> <%=newslist[i][2]%></font></span></td>
              </tr>
              <%              }else{%>
              <tr> 
                <td height="25" bgcolor="#E6EDFB"><img src="../../../images/images_en/space.gif" width="8" height="1"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><span class="font10"><%=newslist[i][1]%></span></a><span class="font10"><font color="#330099"> <%=newslist[i][2]%></font></span></td>
              </tr>
              <%	      }               
                          }
              	      }
              	  }
              %>
              <tr bgcolor="#E6EDFB" align="right">
              <%
              	  if ((pageno == 1)&&(totalPage>1)){
              %>               
                <td height="25" class="font10"><a href="newsList.jsp?pageNo=2&categoryId=<%=category_id%>">下一页</a></td>
              <%  }else if ((pageno>1)&&(pageno<totalPage)){
              %>
                <td height="25" class="font10"><a href="newsList.jsp?pageNo=<%=pageno-1%>&categoryId=<%=category_id%>">上一页,</a><a href="newsList.jsp?pageNo=<%=pageno+1%>&categoryId=<%=category_id%>">下一页</a></td>
              <%  }else if ((pageno>1)&&(pageno==totalPage)){
              %>
                <td height="25" class="font10"><a href="newsList.jsp?pageNo=<%=pageno-1%>&categoryId=<%=category_id%>">上一页</a></td>
              <%  }%>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../../images/images_en/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

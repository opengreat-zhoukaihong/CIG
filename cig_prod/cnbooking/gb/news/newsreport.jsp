<html><!-- #BeginTemplate "/templates/main_gb.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中港澳酒店订房专家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
 input {font-family: "宋体"; font-size: 12px ;color:#666666}
 select {font-family: "宋体"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 宋体}
 A:visited {text-decoration: none; color: #715922; font-family: 宋体}
 A:active {text-decoration: none; font-family: 宋体}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "宋体", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "宋体"; font-size: 12px}
-->
</style>
</head>


<jsp:useBean id="NewsList" scope="page" class="com.cnbooking.news.NewsList" /> 

<jsp:setProperty name="NewsList" property="langCode" value="GB"/>
<jsp:setProperty name="NewsList" property="pageFlag" value="Y"/>
<jsp:setProperty name="NewsList" property="restriction" value="20"/>
<jsp:setProperty name="NewsList" property="pageNo" />
<jsp:setProperty name="NewsList" property="categoryId" value="1"/>

<%
    int newsCount=0;
    int totalPage=0;
    String[][] newslist;
    int pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    String category_id = request.getParameter("categoryId");  
    String cate_name="";
    
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    totalPage = NewsList.getTotalPage();
    cate_name = NewsList.getCateName();
%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<table width="663" border="0" cellspacing="0" cellpadding="0" height="60" align="center">
  <tr> 
    <td colspan="2" height="60">
      <script language="JavaScript" src="/javascript/gb/title.js">
</script>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/gb/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;相关新闻报道</font><!-- #EndEditable --></td>
          <td width="415" background="/images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="/images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> <br>
      <br>
      <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
        <tr align="center" bgcolor="#CFC8CF"> 
          <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
        </tr>
        <tr align="center"> 
          <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b>相关新闻报道</b></font></span></td>
        </tr>
        <tr align="center"> 
          <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
        </tr>
      </table>
      <br>
      <br>
      <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr align="center"> 
          <td width="400"> 
            <table width="500" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04">
              <tr> 
                <td> 
                  <div align="left"> 
                    <table width="540" cellpadding="0" cellspacing="0" bordercolorlight="#FFCC00" border="1" bordercolordark="#FFFFFF">
                      <tr> 
                        <td height="20" width="240"> 第<%=pageno%>页</td>
                        <td height="20" width="200"> 
                          <div align="center">共<%=newsCount%>条新闻 共<%=totalPage%>页</div>
                        </td>
                        <% if (pageno>1){%>
                        <td height="20" width="50"> 
                          <div align="center"><a href="newsreport.jsp?pageNo=<%=pageno-1%>">上一页</a></div>
                        </td>
                        <% }if ((pageno!=totalPage)&&(totalPage>1)){%> 
                        <td height="20" width="50"> 
                          <div align="center"><a href="newsreport.jsp?pageNo=<%=pageno+1%>">下一页</a></div>
                        </td>
                        <% }%>
                      </tr>
                    </table>
                    <table width="540" cellpadding="0" cellspacing="0">
                    <%
              	       int maxNum = NewsList.restriction;            
              	       if (pageno == totalPage){
              	          maxNum = newsCount-NewsList.restriction*(pageno-1);
              	       }  
              	       if (newsCount >0){
              	         for (int i=0;i<maxNum;i++){
              	              if (newslist[i][3].equals("0")){
                    %>
                      <tr> 
                        <td height="20" width="20" align="center" valign="middle"><img src="/images/news_title.gif" width="8" height="8"></td>
                        <td height="20" width="340"><span class="txt"><a href="<%=newslist[i][4]%>"><%=newslist[i][1]%></a></span></td>
                        <td height="20" width="11"> 
                          <div align="center"><span class="txt"><%=newslist[i][5]%></span></div>
                        </td>
                        <td height="20" width="70"> 
                          <div align="center"><span class="txt"><%=newslist[i][2]%></span></div>
                        </td>
                      </tr>
                      <%          }else{%>
                      <tr> 
                        <td height="20" width="20" align="center" valign="middle"><img src="/images/news_title.gif" width="8" height="8"></td>
                        <td height="20" width="340"><span class="txt"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%></a></span></td>
                        <td height="20" width="110"> 
                          <div align="center"><span class="txt"><%=newslist[i][5]%></span></div>
                        </td>
                        <td height="20" width="70"> 
                          <div align="center"><span class="txt"><%=newslist[i][2]%></span></div>
                        </td>
                      </tr>
                       <%        }
                             }
                          }
                       %>                      
                    </table>
                    <table width="540" cellpadding="0" cellspacing="0" bordercolorlight="#FFCC00" border="1" bordercolordark="#FFFFFF">
                      <tr> 
                        <td height="20" width="240"> 第<%=pageno%>页</td>
                        <td height="20" width="200"> 
                          <div align="center">共<%=newsCount%>条新闻 共<%=totalPage%>页</div>
                        </td>
                        <% if (pageno>1){%>
                        <td height="20" width="50"> 
                          <div align="center"><a href="newsreport.jsp?pageNo=<%=pageno-1%>">上一页</a></div>
                        </td>
                        <% }if ((pageno!=totalPage)&&(totalPage>1)){%> 
                        <td height="20" width="50"> 
                          <div align="center"><a href="newsreport.jsp?pageNo=<%=pageno+1%>">下一页</a></div>
                        </td>
                        <% }%>
                      </tr>
                    </table>
                    </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr align="center"> 
          <td height="12">&nbsp;</td>
        </tr>
        <tr align="center"> 
          <td><font color="#666666"><a href="/gb/abouts.htm">返回</a></font></td>
        </tr>
      </table>
      <!-- #EndEditable --></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <tr valign="middle" align="center"> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <td colspan="3" align="center"> <IFRAME width=560  height=350 MARGINWIDTH=0 MARGINHEIGHT=0 HSPACE=0 VSPACE=0 FRAMEBORDER=0 SCROLLING=no BORDERcolor=000000 SRC="/cnbooking/gb/foot_tel.jsp"> 
    </IFRAME> <!--Here is ad end.--></td>
  </tr>
  <tr> 
    <td colspan="3" height="3"> 
      <script language="JavaScript" src="/javascript/gb/foot.js">
</script>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

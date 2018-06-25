<html>
<!-- #BeginTemplate "/Templates/main_gb.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" -->
<title>Specialist of hotelbooking in Mainland China, Hong Kong and Macao</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
 input {font-family: "Verdana"; font-size: 12px ;color:#666666}
 select {font-family: "Verdana"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: Verdana}
 A:visited {text-decoration: none; color: #715922; font-family: Verdana}
 A:active {text-decoration: none; font-family: Verdana}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "Verdana", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "Verdana"; font-size: 12px}
-->
</style>
</head>

<jsp:useBean id="NewsList" scope="page" class="com.cnbooking.news.NewsList" /> 

<jsp:setProperty name="NewsList" property="langCode" value="EN"/>
<jsp:setProperty name="NewsList" property="pageFlag" value="Y"/>
<jsp:setProperty name="NewsList" property="restriction" value="30"/>
<jsp:setProperty name="NewsList" property="pageNo" />
<jsp:setProperty name="NewsList" property="categoryId" value="2"/>

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
      <script language="JavaScript" src="/javascript/en/title.js">
</script>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/en/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;Travel News</font><!-- #EndEditable --></td>
          <td width="415" background="/images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="/images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" -->
      <table width="440" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr align="center"> 
          <td><br>
            <table width=250 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
              <tr align="center" bgcolor="#CFC8CF"> 
                <td height="3"><img src="images/space.gif" width="1" height="3"></td>
              </tr>
              <tr align="center"> 
                <td><span class="bigtxt"><font class="bigtxt"><b><font color="#666666">Travel News</font></b></font></span></td>
              </tr>
              <tr align="center"> 
                <td bgcolor="#CFC8CF" height="3"><img src="images/space.gif" width="1" height="3"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr align="center"> 
          <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp; 
            <table width="540" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFCC00">
              <tr>
                <td>
                  <div align="center">
                    <table width="540" cellpadding="0" cellspacing="0" bordercolorlight="#FFCC00" border="1" bordercolordark="#FFFFFF">
                      <tr> 
                        <td height="20" width="140">Page <%=pageno%></td>
                        <td height="20" width="200"> 
                          <div align="center">Total News: <%=newsCount%>  Total Pages: <%=totalPage%></div>
                        </td>
                        <% if (pageno>1){%>
                        <td height="20" width="50"> 
                          <div align="center"><a href="newsreport.jsp?pageNo=<%=pageno-1%>">Last Page</a></div>
                        </td>
                        <% }if ((pageno!=totalPage)&&(totalPage>1)){%> 
                        <td height="20" width="50"> 
                          <div align="center"><a href="newsreport.jsp?pageNo=<%=pageno+1%>">Next Page</a></div>
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
                        <td height="20" width="440"><span class="txt"><a href="<%=newslist[i][4]%>"><%=newslist[i][1]%></a></span></td>
                        <td height="20" width="80"> 
                          <div align="center"><span class="txt"><%=newslist[i][2]%></span></div>
                        </td>
                      </tr>
                      <%          }else{%>
                      <tr> 
                        <td height="20" width="20" align="center" valign="middle"><img src="/images/news_title.gif" width="8" height="8"></td>
                        <td height="20" width="440"><span class="txt"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=newslist[i][1]%></a></span></td>
                        <td height="20" width="80"> 
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
                        <td height="20" width="140">Page <%=pageno%></td>
                        <td height="20" width="200"> 
                          <div align="center">Total News: <%=newsCount%>  Total Pages:<%=totalPage%></div>
                        </td>
                        <% if (pageno>1){%>
                        <td height="20" width="50"> 
                          <div align="center"><a href="newsreport.jsp?pageNo=<%=pageno-1%>">Last Page</a></div>
                        </td>
                        <% }if ((pageno!=totalPage)&&(totalPage>1)){%> 
                        <td height="20" width="50"> 
                          <div align="center"><a href="newsreport.jsp?pageNo=<%=pageno+1%>">Next Page</a></div>
                        </td>
                        <% }%>
                      </tr>
                    </table>
                </td>
              </tr>
            </table>
            <p align="right"><a href="javascript:window.history.go(-1)">Back</a></p>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <%@ include file="../foot_tel.jsp"%> 
    <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="/javascript/en/foot.js">
  </script>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

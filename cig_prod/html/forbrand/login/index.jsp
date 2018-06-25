<%@ page import="java.util.*,java.sql.*,com.forbrand.hotsale.IndexHot" language="java" %>
<jsp:useBean id="hotSalesInfo" scope="page" class="com.forbrand.hotsale.HotSale"/>
<jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" />
<jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" />

<%! Vector hotSales = new Vector();%>
<%! String gift_ID,gift_NO,giftName,picDir,fileName,giftPrice,descr; %>
<%! IndexHot myHot;
    boolean hasNews;
%>
<%
  hotSalesInfo.setLangCode("EN");
  hotSalesInfo.setFetchNumber(3);
  hotSales = hotSalesInfo.getHotGifts();
%>
<%!
  String dir = null;
	String sql = null;
	String subSql = null;
  String url = null;
  int i;
	Hashtable[] results = null;
%>
<%
  sql = "select a.news_id,to_char(a.publish_date,'YYYY-MM-DD') publish, " +
        " a.order_no,b.title,a.template_id,c.dir,b.htmlfile,b.lang_code " +
	      " from news a,news_l b,dir_setting c where a.news_id = b.news_id " +
        " and c.dir_id = b.html_dirid and b.lang_code = 'EN' order by order_no desc ";

	System.out.println(sql);
  try
	{
	  results = jdbc.executeQuery(sql);
    if(results[0] == null)
      hasNews = false;
    else
      hasNews = true;
	} catch (SQLException e)
	{
	   e.printStackTrace();
     //out.printin("No News&Events!");
	}
	res.setResult(results);
  System.out.println("news result"+res.size());
%>


<html>

<head>
<title>Welcome To Our Brand</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../public.css">
<script><!--
function js_callpage(htmlurl) {
  var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=566,height=327");
  return false;
}
function js_callpage2(htmlurl) {
  var newcart=window.open(htmlurl,"newcart","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=566,height=327");
  return false;
}

//-->
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="JavaScript">
	if(top!=self)
	{
		top.location = location
	}
</script>

<div id="Layer1" style="position:absolute; left:116px; top:183px; width:356px; height:61px; z-index:1" class="white-title">Forbrand.com,
  A leading professional online gift provider dedicated to providing the best-personalized
  gifts with dynamic designs to enhance your brand name. </div>
<table width=759 border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td> <img src="/images/img-indexup/spacerb.gif" width=120 height=1></td>
    <td> <img src="/images/img-indexup/spacerb.gif" width=172 height=1></td>
    <td> <img src="/images/img-indexup/spacerb.gif" width=142 height=1></td>
    <td> <img src="/images/img-indexup/spacerb.gif" width=52 height=1></td>
    <td> <img src="/images/img-indexup/spacerb173.gif" width=273 height=1></td>
    <td></td>
  </tr>
  <tr>
    <td rowspan=3> <img src="/images/img-indexup/indexup_01.gif" width=120 height=105></td>
    <td colspan=2 rowspan=2> <img src="/images/img-indexup/indexup_02.jpg" width=314 height=99></td>
    <td colspan=2> <img src="/images/img-indexup/indexup_03.gif" width=325 height=28 usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="3,13,80,23" href="show/portinfo.jsp"><area shape="rect" coords="104,14,178,23" href="login/myaccount.jsp"><area shape="rect" coords="208,13,311,24" href="show/cart.jsp" onClick="return js_callpage2(this.href)"></map></td>
    <td> <img src="/images/img-indexup/spacer.gif" width=1 height=28></td>
  </tr>
  <tr>
    <td colspan=2> <img src="/images/img-indexup/indexup_04.jpg" width=325 height=71></td>
    <td> <img src="/images/img-indexup/spacer.gif" width=1 height=71></td>
  </tr>
  <tr>
    <td rowspan=2> <img src="/images/img-indexup/indexup_05.jpg" width=172 height=34></td>
    <td colspan=2 rowspan=2> <img src="/images/img-indexup/indexup_06.gif" width=194 height=34></td>
    <td rowspan=5> <img src="/images/img-indexup/indexup_07.jpg" width=273 height=174></td>
    <td> <img src="/images/img-indexup/spacer.gif" width=1 height=6></td>
  </tr>
  <tr>
    <td> <img src="/images/img-indexup/indexup_08.jpg" width=120 height=28></td>
    <td> <img src="/images/img-indexup/spacer.gif" width=1 height=28></td>
  </tr>
  <tr> 
    <td colspan=4> <img src="/images/img-indexup/indexup_09.gif" width=486 height=20></td>
    <td> <img src="/images/img-indexup/spacer.gif" width=1 height=20></td>
  </tr>
  <tr> 
    <td colspan=3> <img src="/images/img-indexup/indexup_10.gif" width=434 height=32></td>
    <td rowspan=2> <img src="/images/img-indexup/indexup_11.jpg" width=52 height=120></td>
    <td> <img src="/images/img-indexup/spacer.gif" width=1 height=32></td>
  </tr>
  <tr> 
    <td colspan=3> <img src="/images/img-indexup/indexup_12.jpg" width=434 height=88></td>
    <td> <img src="/images/img-indexup/spacer.gif" width=1 height=88></td>
  </tr>
</table>
<table width="755">
  <tr> 
    <td width="223" height="179"> 
      <table width=223 border=0 cellpadding=0 cellspacing=0>
        <tr> 
          <td colspan=3> <img src="/images/img-index/d1_01.gif" width=223 height=24 usemap="#MapMap" border="0"><map name="MapMap"><area shape="rect" coords="152,9,213,21" href="/html/memberagreements.html"></map></td>
        </tr>
        <form name="form1" action="login/welcome.jsp" method="post">
		<tr> 
        
            <td width="85" align="center"> 
              <input type="text" name="login" size="5" maxlength="20" class="xiaolei">
            </td>
            <td width="80" align="center"> 
              <input type="password" name="passwd" size="5" maxlength="20" class="xiaolei">
            </td>
          
            <td width="58"> 
              <input type="image" border="0" name="imageField" src="/images/img-index/d1_03.gif" width="58" height="26">
            </td>
        </tr>
		</form>
        <tr align="center">
          <td colspan=3 height="13" align="right"><a href="login/passwdrecover.jsp"><img src="/images/img-index/indexdown_19.gif" width=217 height=13 border="0"></a> 
          </td>
        </tr>
        <tr align="center"> 
          <td colspan=3 height="108" align="right"> 
            <table width="200" cellspacing="0" cellpadding="0" border="1" bordercolor="#EAEAEA">
              <tr> 
              <% if(!hotSales.isEmpty()) {
                 myHot = (IndexHot)hotSales.elementAt(0);
                 if(myHot != null) {
              %>

                <td width="100" height="100"><a href="show/popup.jsp?langCode=EN&giftID=<%=myHot.getGift_ID()%>" onClick="return js_callpage(this.href);" target="_blank">
                  <img src="<%=myHot.getPicDir()%><%=myHot.getFileName()%>" width="100" height="100" border="0"></a></td>
                <td width="100" height="100" bgcolor="#EAEAEA" class="xiaolei" bordercolor="#EAEAEA" align="center">
                  <table width="93%" cellspacing="1" cellpadding="1">
                    <tr>
                      <td class="xiaolei"> <b>
                        <li><font color="#666666"><%=myHot.getGift_NO()%><br>
                          </font></li>
                        <li><font color="#666666"><%=myHot.getGiftName()%><br>
                          </font></li>
                        <li><font color="#666666"> $<%=myHot.getGiftPrice()%></font></li>
                        </b> </td>
                     </tr>
                  </table>
                </td>
              </tr>
             <% }
               }
            %>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="181" height="179">
      <table width=176 border=0 cellpadding=0 cellspacing=0>
        <tr>
          <td colspan=2> <img src="/images/img-index/d2_01.gif" width=176 height=32 usemap="#Map3" border="0"><map name="Map3"><area shape="rect" coords="5,10,79,30" href="show/showinside.jsp?langCode=EN&act=3"></map></td>
        </tr>
        <tr>
          <td width="6"> <img src="/images/img-index/d2_02.gif" width=6 height=138></td>
          <td width="170" valign="top">
            <table width="161" cellspacing="4" height="138">
                <%  if((!hotSales.isEmpty())&&hotSales.size()>1) {
                    for(int i=1;i<hotSales.size();i++) {
                    myHot = (IndexHot)hotSales.elementAt(i);
                %>
              <tr valign="top">
                <td class="xiaolei"><font color="#003333">
                  <a href="show/popup.jsp?langCode=EN&giftID=<%=myHot.getGift_ID()%>" onClick="return js_callpage(this.href);" target="_blank"><%=myHot.getGift_NO()%></a><br>
                  <%=myHot.getGiftName()%><br>
                  <%=myHot.getDescr()%></font><br>
              </tr>
                <%  }
                   }
                %>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="177" height="179">
      <table width=176 border=0 cellpadding=0 cellspacing=0>
        <tr> 
          <td colspan=2> <img src="/images/img-index/d2_04.gif" width=176 height=32 usemap="#Map4" border="0"><map name="Map4"><area shape="rect" coords="4,11,90,31" href="news/NewsList.jsp?first=1"></map></td>
        </tr>
        <tr> 
          <td width="6"> <img src="/images/img-index/d2_02.gif" width=6 height=138></td>
          <td width="170" valign="top"> 
            <table width="161" cellspacing="4" height="138">
    <%
      i = 0;
      while(hasNews && res.hasNext())
      {
        if(i>=2) break;
        if (res.getObject("template_id").toString().equals("0"))
	      {
          dir = res.getObject("dir").toString();
	        if (!dir.endsWith("/"))
            dir += "/";
          url = dir+res.getObject("htmlfile").toString();
        }
        else
	      {
	        url="news/NewsStyle"+res.getObject("template_id").toString()+".jsp?news_id="+
	          res.getObject("news_id").toString()+"&&lang_code="+res.getObject("lang_code").toString();
        }
      %>
              <tr valign="top">
                <td class="xiaolei"><font color="#003333"><a href="<%=url%>"><%=res.getObject("title").toString()%>
                  (<%=res.getObject("publish").toString()%>)</a></font><font color="#003366"><br>
                 </font></td>
              </tr>
   <%
           i++;
          res.next(); }
   %>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="169" height="179"> 
      <table width=168 border=0 cellpadding=0 cellspacing=0>
        <tr> 
          <td> <img src="/images/img-index/d3_01.gif" width=168 height=40></td>
        </tr>
        <tr> 
          <td> <img src="/images/img-index/d3_02.gif" width=168 height=130 border="0" usemap="#Map2"><map name="Map2"><area shape="rect" coords="8,2,160,17" href="show/showroom.jsp"><area shape="rect" coords="9,28,159,42" href="show/giftoccasion.jsp?langCode=EN"><area shape="rect" coords="10,54,161,70" href="login/specialorder.jsp" onClick="return js_callpage(this.href)"><area shape="rect" coords="9,81,160,97" href="show/showinside.jsp?act=4&langCode=EN"><area shape="rect" coords="11,107,162,123" href="show/search.jsp"></map></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width=758 border=0 cellpadding=0 cellspacing=0>
  <tr> 
    <td> <img src="/images/img-foot/footer_01.gif" width=376 height=23></td>
    <td> <a href="../html/aboutus.html"><img src="/images/img-foot/footer_02.gif" width=65 height=23 border="0"></a></td>
    <td> <a href="../html/contactus.html"><img src="/images/img-foot/footer_03.gif" width=76 height=23 border="0"></a></td>
    <td> <a href="../html/sitemap.html"><img src="/images/img-foot/footer_04.gif" width=65 height=23 border="0"></a></td>
    <td> <a href="../html/help.html"><img src="/images/img-foot/footer_05.gif" width=39 height=23 border="0"></a></td>
    <td> <a href="../html/privacy.html"><img src="/images/img-foot/footer_06.gif" width=55 height=23 border="0"></a></td>
    <td> <img src="/images/img-foot/footer_07.gif" width=82 height=23></td>
  </tr>
</table>
</body>
</html>

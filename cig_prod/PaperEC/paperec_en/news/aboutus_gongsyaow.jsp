<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.d14 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px; font-family: "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 10pt; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; font-family: "Arial", "Helvetica", "sans-serif"}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px}
.d14 {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px; line-height: 22px}
.d1 {  text-align: justify; font-family: "Arial", "Helvetica", "sans-serif"}
-->
</style>
</head>
<jsp:useBean id="NewsList" scope="page" class="news.NewsList" /> <jsp:setProperty name="NewsList" property="langCode" value="EN"/> 
<jsp:setProperty name="NewsList" property="pageFlag" value="N"/> <jsp:setProperty name="NewsList" property="restriction" value="5"/> 
<jsp:setProperty name="NewsList" property="categoryId" value="2"/> <%
    String[][] newslist;
    int newsCount=0;
    String today="";
    
    newslist = NewsList.getNewsList();
    newsCount = NewsList.getNewsCount();
    today = NewsList.getToday();
%> 
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr> 
    <td width="159"> 
      <script language="JavaScript" src="../../../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:183px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="137"> 
              <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr> 
                  <td><img src="../../../images/images_en/abouts.gif" width="139" height="22"></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="19"><a href="../../../html/html_en/aboutus/aboutus.htm" class="white10">Company 
                    Profile</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="19" ><a href="../../../html/html_en/aboutus/aboutus_parner.htm" class="white10" >Strategic 
                    Alliance</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="19" ><a href="aboutus_gongsyaow.jsp" class="white10">Press 
                    Room</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="19"><a href="../../../html/html_en/aboutus/aboutus_tuandui.htm" class="white10">Management 
                    Team</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="19"><a href="../../../html/html_en/aboutus/aboutus_bomianq.htm" class="white10">Privacy 
                    Policy</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0">
                  <td height="18"><a href="../../../html/html_en/aboutus/aboutus_banquan.htm" class="white10">Copyright</a></td>
                </tr>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="18"><a href="../../../html/html_en/aboutus/aboutus_touzhi.htm" class="white10">Founder</a></td>
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
    <td valign="top"> 
      <form method="post" action="newsList.jsp?pageNo=1&categoryId=2">
        <table width="550" border="0" cellspacing="0" cellpadding="2">
          <tr bgcolor="#4078E0"> 
            <td height="25" class="big"><font color="#FFFFFF">Press Room</font></td>
          </tr>
          <tr bgcolor="#E0E0E0"> 
            <td class="font10"> Internal News</td>
          </tr>
          <% for (int i=0;i<newsCount;i++){%> 
          <tr bgcolor="#E6EDFB"> <% if (newslist[i][3].equals("0")){%> 
            <td class="font10"><a href="<%=newslist[i][4]%>"><%=i+1%>.<%=newslist[i][1]%> 
              (<%=newslist[i][2]%>)</a></td>
            <% }else{%> 
            <td class="font10"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=i+1%>.<%=newslist[i][1]%> 
              (<%=newslist[i][2]%>)</a></td>
          </tr>
          <%  }
             }
          %> 
          <tr bgcolor="#E6EDFB"> 
            <td class="font10"> 
              <div align="right"><a href="newsList.jsp?pageNo=1&categoryId=2"> 
                More>></div>
            </td>
          </tr>
          <tr bgcolor="#E6EDFB"> 
            <td class="font10" height="50">Search<br>
              <input type="text" name="dateFrom" size="10" value="2000-01-01" onBlur="validDateField(this)">
              to 
              <input type="text" name="dateTo" size="10" value="<%=today%>" onBlur="validDateField(this)">
              <input type="submit" name="Submit" value="Search">
            </td>
          </tr>
          <%
          	NewsList.setCategoryId("3");
          	
                newslist = NewsList.getNewsList();
  		newsCount = NewsList.getNewsCount();
                today = NewsList.getToday();
	  %> 
        </table>
      </form>
      <form method="post" action="newsList.jsp?pageNo=1&categoryId=3">
        <table width="550" border="0" cellspacing="0" cellpadding="2">
          <tr bgcolor="#E0E0E0"> 
            <td class="font10"> Media Report</td>
          </tr>
          <% for (int i=0;i<newsCount;i++){%> 
          <tr bgcolor="#E6EDFB"> <% if (newslist[i][3].equals("0")){%> 
            <td class="font10"><a href="news/<%=newslist[i][4]%>"><%=i+1%>.<%=newslist[i][1]%> 
              (<%=newslist[i][2]%>)</a></td>
            <% }else{%> 
            <td class="font10"><a href="newsStyle<%=newslist[i][3]%>.jsp?news_id=<%=newslist[i][0]%>"><%=i+1%>.<%=newslist[i][1]%> 
              (<%=newslist[i][5]%> <%=newslist[i][2]%>)</a></td>
            <% }
             }
          %> 
          <tr bgcolor="#E6EDFB"> 
            <td class="font10"> 
              <div align="right"><a href="newsList.jsp?pageNo=1&categoryId=3"> 
                More>></a></div>
            </td>
          </tr>
          <tr bgcolor="#E6EDFB"> 
            <td class="font10" height="50">Search <br>
              <input type="text" name="dateFrom" size="10" value="2000-01-01" onBlur="validDateField(this)">
              to 
              <input type="text" name="dateTo" size="10" value="<%=today%>" onBlur="validDateField(this)">
              <input type="submit" name="Submit2" value="Search">
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

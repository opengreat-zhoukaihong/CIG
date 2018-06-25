 
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

<script language="JavaScript">


	function Search()
	{
		var page;
		page = document.myForm.pageNo.value;
		if(validateIntegerField(page))
		{
			document.myForm.submit();
		}
		else
		{
		 alert("Please input a number!");
		}
	}
	function Search2()
	{
		var page;
		page = document.myForm2.pageNo.value;
		if(validateIntegerField(page))
		{
			document.myForm2.submit();
		}
		else
		{
		 alert("Please input a number!");
		}
	}

   function validateIntegerField(field)
   {
      if(field.length!=0)
      {
        for(var i=0;i<field.length;i++)
        {
                if(field.charAt(i)>"9"||field.charAt(i)<"0")
                {
                        alert(field + "  Wrong Number");
                        return false;
                }
        }
        return true;
      }
      else
        return false;
   }

</script>

<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.hotel.*" %> 

<jsp:useBean id="HotelList" scope="page" class="com.cnbooking.hotel.HotelList" /> 
<jsp:setProperty name="HotelList" property="langCode" value="EN"/> 
<jsp:setProperty name="HotelList" property="pageFlag" value="Y"/> 
<jsp:setProperty name="HotelList" property="pageNo"/>
<jsp:setProperty name="HotelList" property="promotion"/>
<jsp:setProperty name="HotelList" property="stateId"/>
<jsp:setProperty name="HotelList" property="cityId"/> 
<jsp:setProperty name="HotelList" property="starId"/>
<jsp:setProperty name="HotelList" property="priceFrom"/> 
<jsp:setProperty name="HotelList" property="priceTo"/>
<jsp:setProperty name="HotelList" property="hotelName"/>

<%
    int hotel_count = 0;
    int total_page = 0;
    String[][] hotel_list;
    
    String name;
    String value;
    Enumeration e = request.getParameterNames();
    String stateId="";
    String cityId="";
    String starId="";
    String priceFrom="";
    String priceTo="";
    String hotelName="";
    String str="";
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);

	if ( name.equals("stateId") && !value.equals("")) {
	    str += "&stateId=" + value;
	}
	if ( name.equals("cityId") && !value.equals("")) {
	    str += "&cityId=" + value;
	}
	if ( name.equals("starId") && !value.equals("")) {
	    str += "&starId=" + value;
	}
	if ( name.equals("priceFrom") && !value.equals("")) {
	    str += "&priceFrom=" + value;
	}
	if ( name.equals("priceTo") && !value.equals("")) {
	    str += "&priceTo=" + value;
	}
	if ( name.equals("hotelName") && !value.equals("")) {
	    str += "&hotelName=" + value;
	}

    }
    
    int pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
      
    
    hotel_list = HotelList.getHotelList();
    hotel_count = HotelList.getHotelCount();
    total_page = HotelList.getTotalPage();
        
%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language="JavaScript" src="../../javascript/en/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr> 
    <td width="664" height="34"> 
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr> 
          <td width="30" background="../../images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/en/index.jsp"><img src="../../images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="../../images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;Search Result of Hotels</font><!-- #EndEditable --></td>
          <td width="415" background="../../images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="../../images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> 
      <table width="598" border="1" cellspacing="0" cellpadding="0" bordercolor="#FFBC04" align="center">
        <tr align="center"> 
          <td> 
            <table width="600" border="0">
              <form name="myForm" method="post" action="<%="hotel_list.jsp?"+str%>">
                <tr> 
                  <td>&nbsp;&nbsp;Total Hotels: <font color="#FF3333"><%=hotel_count%></font>&nbsp;&nbsp; 
 		    <% if (pageno !=1){%>                 
                    <a href="<%="hotel_list.jsp?pageNo=1"+str%>">First Page</a> <img src="../../images/first_page.gif" width="12" height="13" border="0"> 
                    <a href="<%="hotel_list.jsp?pageNo="+(pageno-1)+str%>">Last Page</a> <img src="../../images/up_page.gif" width="12" height="13" border="0"> 
                    <%}%>
                    <% if (pageno !=total_page){%>
                    <font color="#000000"><a href="<%="hotel_list.jsp?pageNo="+(pageno+1)+str%>">Next Page</a></font><img src="../../images/down_page.gif" width="12" height="13" border="0"> 
                    <font color="#000000"><a href="<%="hotel_list.jsp?pageNo="+total_page+str%>">End Page</a></font><img src="../../images/last_page.gif" width="12" height="13" border="0"> 
                    <%}%>
                  </td>
                  <td>Page  
                    <input type="text" name="pageNo" size="2">
                    <a href="javascript:Search();"><b><i><font face="Arial, Helvetica, sans-serif" color="#666666">GO</font></i></b></a></td>
                  <td width="50" align="center">Page <%=pageno%></td>
                  <td width="100" align="center">Total Pages:<font color="#FF0000"><%=total_page%></font></td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
      </table>
      <table align=center cellpadding=0 cellspacing=6 href="hotel_bj_5_xsj.htm" width="600">
        <tr valign="baseline"> 
          <td width=29 align=center>Recommend</td>
          <td width=51 align=center>Description </td>
          <td width=134 align=center>Hotel Name <img src="../../images/index.gif" width="12" height="13" border="0"></td>
          <td width=62 align=center>Star Rating <img src="../../images/index.gif" width="12" height="13" border="0"></td>
          <td width=64 align=center>Booking </td>
          <td width=54 align=center>Member Price <img src="../../images/index.gif" width="12" height="13" border="0"></td>
          <td width=85 align=center>Location <img src="../../images/index.gif" width="12" height="13" border="0"></td>
          <td width=65 align=center>Services </td>
        </tr>
        <tr> 
          <td colspan=8 bgcolor="#FFBC04"><img src=../chinese/images/space.gif height=1 width="1"></td>
        </tr>
        <%
            int maxNum = HotelList.restriction;            
            if (pageno == total_page){
                 maxNum = hotel_count - HotelList.restriction*(pageno-1);
            }  
            if (hotel_count >0){
              for (int i=0;i<maxNum;i++){                   
         %>
        <tr> 
        <% if (hotel_list[i][2].equals("Y")){      %>
          <td width="29" align="center"><img src="../../images/pick.gif" width="16" height="16"></td>
        <% }else{%>
          <td width="29" align="center">&nbsp;</td>
        <%}%>  
          <td width="51" align="center"><a href="hotel_detail.jsp?hotelId=<%=hotel_list[i][0]%>"><img src="../../images/icon.gif" width="12" height="13" border="0"></a></td>
          <td width="134"><a href="hotel_detail.jsp?hotelId=<%=hotel_list[i][0]%>"><%=hotel_list[i][1]%></a></td>
        <% if (hotel_list[i][3].equals("0")){%>
          <td width="62">&nbsp;</td>
        <% }else{%>
          <td width="62"><img src="<%=hotel_list[i][4]%>" height="11"></td>
        <%}%>
          <td align="center" width="64"><a href="HotelBooking.jsp?hotelId=<%=hotel_list[i][0]%>"><font color="#999900"><b>Booking!</b></font></a></td>
          <td width="54"><font color="#FF3300"><%=hotel_list[i][5]%></font></td>
          <td width="85"><a href="CShowHotelMap.jsp?HotelID=<%=hotel_list[i][0]%>"><font color="#666666"><%=hotel_list[i][7]%> <%=hotel_list[i][8]%></font></td>
        <% if (hotel_list[i][6].equals("1"))%>
          <td width="65" align="center"><img src="../../images/breakfast1.gif" width="19" height="16" border="0"></td>
        <% else if (hotel_list[i][6].equals("2"))%>
          <td width="65" align="center"><img src="../../images/breakfast2.gif" width="19" height="16" border="0"></td>
        <% else %>
          <td width="65" align="center">&nbsp;</td>
        </tr>
        <%    }
            }
         %>
        <tr> 
          <td colspan=8 bgcolor="#FFBC04"><img src=../chinese/images/space.gif height=1 width="1"></td>
        </tr>
        <tr> 
          <td colspan=8>&nbsp;</td>
        </tr>
        <tr> 
          <td colspan=8 height="1"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFBC04" height="3">
              <tr> 
                <td><img src="../chinese/images/space.gif" width="1" height="3"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td width="29">&nbsp;</td>
          <td colspan=7><img src="../../images/pick.gif" width="16" height="16">: Special Recommend  
            <img src="../../images/icon.gif" width="12" height="13" border="0"> : Picture & Description  
            <img src="../../images/breakfast.gif" width="16" height="16">: Detailed Services  
            <img src="../../images/breakfast1.gif" width="19" height="16">: Free 1BF  
            <img src="../../images/breakfast2.gif" width="19" height="16">: Free 1BF <img src="../chinese/images/space.gif" width="1" height="1"></td>
        </tr>
      </table>
      <table width="598" border="1" cellspacing="0" cellpadding="0" bordercolor="#FFBC04" align="center">
        <tr align="center"> 
          <td> 
            <table width="600" border="0">
              <form name="myForm2" method="post" action="<%="hotel_list.jsp?"+str%>">
                <tr> 
                  <td>&nbsp;&nbsp;Total Hotels: <font color="#FF3333"><%=hotel_count%></font>&nbsp;&nbsp; 
 		    <% if (pageno !=1){%>                 
                    <a href="<%="hotel_list.jsp?pageNo=1"+str%>">First Page</a> <img src="../../images/first_page.gif" width="12" height="13" border="0"> 
                    <a href="<%="hotel_list.jsp?pageNo="+(pageno-1)+str%>">Last Page</a> <img src="../../images/up_page.gif" width="12" height="13" border="0"> 
                    <%}%>
                    <% if (pageno !=total_page){%>
                    <font color="#000000"><a href="<%="hotel_list.jsp?pageNo="+(pageno+1)+str%>">Next Page</a></font><img src="../../images/down_page.gif" width="12" height="13" border="0"> 
                    <font color="#000000"><a href="<%="hotel_list.jsp?pageNo="+total_page+str%>">End Page</a></font><img src="../../images/last_page.gif" width="12" height="13" border="0"> 
                    <%}%>
                  </td>
                  <td>Page  
                    <input type="text" name="pageNo" size="2">
                     <a href="javascript:Search2();"><b><i><font face="Arial, Helvetica, sans-serif" color="#666666">GO</font></i></b></a></td>
                  <td width="50" align="center">Page <%=pageno%></td>
                  <td width="100" align="center">Total Pages:<font color="#FF0000"><%=total_page%></font></td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3" height="2" bgcolor="#FFCC00"><img src="../../images/space.gif" width="500" height="2" align="middle"></td>
  </tr>
  <tr valign="middle" align="center"> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <%@ include file="foot_tel.jsp"%> 
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="../../javascript/en/foot.js">
  </script>
</table>
</body>
<!-- #EndTemplate -->
</html>

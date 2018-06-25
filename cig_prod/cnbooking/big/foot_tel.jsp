<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>い翠澳酒┌訂┬專家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "燦　砰"; font-size: 12px ;color:#666666}
 select {font-family: "燦　砰"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 燦　砰}
 A:visited {text-decoration: none; color: #715922; font-family: 燦　砰}
 A:active {text-decoration: none; font-family: 燦　砰}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "燦　砰", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "燦　砰"; font-size: 12px}
-->
</style>
</head>

<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.hotel.*" %> 
<%@ page import="com.cig.*" %>


<jsp:useBean id="Company" scope="page" class="com.cnbooking.Company" /> 
<jsp:setProperty name="Company" property="langCode" value="GB"/> 

<jsp:useBean id="Convert1" scope="page" class="com.cig.Convert" /> 

<%
    int comp_count = 0;
    String[][] comp_list;
    
    comp_list = Company.getCompList();
    comp_count = Company.getCompCount();

%>

<body>
  <tr> 
    <td colspan="3" height="2" bgcolor="#FFCC00"><img src="/images/space.gif" width="500" height="2" align="middle"></td>
  </tr>
  <tr valign="middle" align="center"> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr valign="middle" align="center"> 
    <td colspan="3"> 
      <table width="560" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr align="center" valign="top"> 
          <td><%=Convert1.g2b(comp_list[0][1])%>：<br>
            電話：<%=comp_list[0][2]%><br>
            傳真：<%=comp_list[0][3]%><br>
            <font face="Arial, Helvetica, sans-serif">Email</font>:<a href="mailto:<%=comp_list[0][4]%>"><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%=comp_list[0][4]%></font></a><br>
            地址：<%=Convert1.g2b(comp_list[0][5])%></td>
        </tr>
        <% for (int i=1;i<comp_count;i=i+2){
        %>
        <tr> 
          <td bgcolor="#666666"><img src="/images/space.gif" width="560" height="1"></td>
        </tr>
        <tr> 
          <td> 
            <table width="560" border="0">
              <tr> 
                <td class="font2" valign="top" width="276"><%=Convert1.g2b(comp_list[i][1])%>：<br>
                  電話：<%=comp_list[i][2]%><br>
                  傳真：<%=comp_list[i][3]%><br>
                  <font face="Arial, Helvetica, sans-serif">E-Mail </font>：<a href="mailto:<%=comp_list[i][4]%>"><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%=comp_list[i][4]%></font></a><br>
                  地址： <%=Convert1.g2b(comp_list[i][5])%><br>
                </td>
                <td class="font2" valign="top" width="274"> 
                  <p><%=Convert1.g2b(comp_list[i+1][1])%>：<br>
                    電話：<%=comp_list[i+1][2]%><br>
                    傳真：<%=comp_list[i+1][3]%><br>
                    <font face="Arial, Helvetica, sans-serif">E-Mail</font>：<a href="mailto:<%=comp_list[i+1][4]%>"><font color="#000000" face="Verdana, Arial, Helvetica, sans-serif"><%=comp_list[i+1][4]%></font></a><br>
                    地址：<%=Convert1.g2b(comp_list[i+1][5])%></p>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <%}%>
        <tr bgcolor="#666666"> 
          <td><img src="/images/space.gif" width="560" height="1"></td>
        </tr>
      </table>        
     </td>
  </tr>
</body>
</html>  


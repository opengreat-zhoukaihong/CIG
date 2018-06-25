<%@ page  %>
<jsp:useBean id="pro" scope="page" class="postcenter.BidList" />
<jsp:setProperty name="pro" property="bid_id" />
<%  
     String numb="";String dw=""; String resu="";      
     pro.setLangcode("GB");     
     String[] str=new String[19];
     str=pro.getAllResult(); 
     String[] title=pro.getTitle();
     if(title[1].equals(""))str[13]="";
                      %>  
 <script language="javascript">  
      function winclose(){
         window.close()            
            }  
</script>             
<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none; color: #000000; font-family: "宋体"}
a:visited {  text-decoration: none; color: #000000; font-family: "宋体"}
a:active {  text-decoration: none; color: #000000; font-family: "宋体"}
a:hover {  color: #330099; text-decoration: underline; font-family: "宋体"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "宋体"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
</head>
<body bgcolor="#E6EDFB" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<tr bgcolor="#E6EDFB"> 
  <td colspan="3" height="26"> </td>
</tr>
<tr valign="top"> 
  <td colspan="3" bgcolor="#E6EDFB"> 
    <table width="443" border="0" cellspacing="0" cellpadding="0" height="246">
      <tr> 
        <td><img src="../../images/xiangqing.gif" width="127" height="26">&nbsp;&nbsp;<%=resu%></td>
      </tr>
      <form name="ok" method="post" action="bidmodi.jsp">
        <tr> 
          <td> 
            <table width="447" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left" height="218">
              <tr> 
                <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"> 数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： 
                  <%=str[6]%> &nbsp; <%=str[7]%> </td>
              </tr>
              <tr> 
                <td class="dan10" height="22" colspan="2" >报价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：<%=str[9]%><%=str[8]%>/<%=str[7]%> 
                </td>
              </tr>
              <tr> 
                <td class="dan10" height="26" colspan="2" >价格条款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： 
                  <%=str[10]%> <%=str[11]%> </td>
              </tr>
                <td class="dan10" height="22" colspan="2" >支付方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：<%=str[12]%> 
                  <%=str[13]%></td>
              </tr>
              <% if (str[9].equals("RMB")) {%>
              <tr> 
                <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"> <%=title[2] %><%=str[14] %> 
                </td>
              </tr>
              <% }%>
              <tr> 
                <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"><%=title[3]%><%=str[18]%></td>
              </tr>
              <tr bgcolor="#E6EDFB"> 
                <td class="dan10" height="22" colspan="2">报价有效期&nbsp;&nbsp;&nbsp;：<%=str[15]%> 至 <%=str[16]%> </td>
              </tr>
              <tr align="center"> 
                <td colspan="3" class="big" height="25" bgcolor="#E6EDFB"> <font color="#FFFFFF"><b> 
                  <input type="button" name="Submit2" value="关 闭" onClick="winclose();">
                  </b></font></td>
              </tr>
            </table>
          </td>
        </tr>
      </form>
    </table>
  </td>
</tr>
</body>
</html> 
   
<%    pro.getDestroy(); %>
</jsp:useBean>
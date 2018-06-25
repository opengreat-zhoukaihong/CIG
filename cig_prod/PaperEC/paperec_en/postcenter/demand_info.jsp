<%@ page import="java.util.Vector"  language="java"  %>
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />
<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>
<jsp:useBean id="bargain" scope="page"  class="postcenter.EnBargain" />
<jsp:useBean id="dsb" scope="page" class="postcenter.Distribute" />
<%   String posting_id=request.getParameter("posting_id").toUpperCase();
     bargain.setPostingid(posting_id);
     if(bargain.getExist().equals("no")){  
       bargain.getDestroy();
       dsb.getDestroy();     %>
<jsp:forward page="inform.jsp?info=Sorry, the posting ID does not exist.  Please check the ID# and try again." />
</jsp:forward>     
<%            }
     dsb.setPostingId(posting_id);
     if(!dsb.isBuyorSale()){  
       bargain.getDestroy();
       dsb.getDestroy();  %>
<jsp:forward page="offerposting_yj.jsp" > 
<jsp:param name="bidcatch" value="" />
<jsp:param name="posting_id" value="<%=posting_id%>" />
</jsp:forward>      
 <%  }   %>     


       
<%    String user_id=UserInfo.getUserId(); 
      String approve=UserInfo.getApproved();
      String buysale=UserInfo.getBuySaleFlag(); %>   
<jsp:setProperty name="bargain" property="langcode"   value="EN" />   
<jsp:setProperty name="bargain" property="userid"   value="<%=user_id%>" /> 

<%   
     String status=bargain.getPostingSt();
     String[] str=bargain.getAllResult();
     Vector ve=bargain.getVe();
     String[] title=bargain.getTitle();
     String[][] arr=bargain.getArr();   
     bargain.getDestroy();
     int ij=ve.size();    
     int i=ij/3;  int j=ij%3;
     if(str[6]==null||str[6].equals(""))str[6]="0";
     if(str[8]==null||str[8].equals(""))str[8]="0";   
     float fla=Float.valueOf(str[6]).floatValue()*Float.valueOf(str[8]).floatValue();
     for(int m=0;m<str.length;m++)if(str[m]==null)str[m]="";
     for(int m=0;m<title.length;m++)if(title[m]==null)title[m]="";
     for(int m=0;m<arr.length;m++)
        for(int n=0;n<3;n++)
           if(arr[m][n]==null)arr[m][n]="";
     if(str[11].equals("null null"))str[11]="";      
  %>
     
<script language="javascript">
   
   function pclerm(stri){
      alert(stri);
      return false;   
         }         
     
</script>             
     
    
<html>
<head>
<title>ÎÒµÄÖ½Íø--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.font9 {  font-size: 13px; font-family: "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 10pt; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  text-decoration: none; color: #000000}
a:visited {  text-decoration: none; color: #000000}
a:active {  text-decoration: none; color: #000000}
a:hover {  color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
</head>
<script language="JavaScript">
function openForeignX(url){   
        OpenWindow=window.open(url, "foreignXwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,resizable=no,menubar=no,width=142,height=230");
}

function openMeasConv(url){   
        OpenWindow=window.open(url, "measConvwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no,width=300,height=300");
}
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr> 
    <td width="159"> 
      <script language="JavaScript" src="../../../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../../images/images_en/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="product_list.jsp" class="font9"><font color="#000000">Offer 
                      to Sell</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="request2buy.jsp"><font color="#000000">Request 
                      to Buy</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="order_search.jsp"><font color="#000000">Browse 
                      Trading Floor</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">My 
                      Customers</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="product_list.jsp"><font color="#000000">My 
                      ProductProfile</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">Search 
                      by ID#</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="Go">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('foreignX.htm')"><font color="#FFFFFF">Currency 
                      Converter</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="../jiaoyifu.htm"><font color="#FFFFFF">Services</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('../huansuanresult.jsp')"><font color="#FFFFFF">Metric 
                      Converter</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../../../images/images_en/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </td>
    <td valign="top"> 
      <form method="post" action="">
        <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="254"> 
              <table width="600" border="0" cellspacing="0" cellpadding="0" bgcolor="#E6EDFB">
                <tr> 
                  <td colspan="3" height="25" bgcolor="#4078E0"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1">Request 
                    to Buy</b></font></td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td width="200" class="dan10">¡¡Posting ID:<%=posting_id %></td>
                  <td colspan="2" width="400" class="dan10"><%=str[0] %>&gt;<%=str[1] %>&gt;<%=str[2] %></td>
                  
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td width="258" class="dan10"> &nbsp;&nbsp;Product Specification:</td>
                  <td width="258" class="dan10">&nbsp;</td>
                  <td width="84" class="dan10">&nbsp;</td>
                </tr>
                <%    int mn=0; 
             
             for(int m=0;m<i;m++){       %> 
                <tr bgcolor="#E6EDFB"> <%  for(int n=0;n<3;n++){
                     mn=m*3+n;
                    if(arr[mn][1].equals("")){   
                              %> 
                  <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: 
                    <%=arr[mn][0]%> </td>
                  <%  }else{  %> 
                  <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: 
                    <%=arr[mn][0]%>--<%=arr[mn][1]%> <%=arr[mn][2]%></td>
                  <%  }     }    %> </tr>
                <%       }  
                if(i==0)mn=-1;  %> 
                <tr bgcolor="#E6EDFB"> <%  for(int n=0;n<j;n++){ 
                         mn+=1;
                         if(arr[mn][1].equals("")){   
                              %> 
                  <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: 
                    <%=arr[mn][0]%> </td>
                  <%  }else{  %> 
                  <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: 
                    <%=arr[mn][0]%>--<%=arr[mn][1]%> <%=arr[mn][2]%></td>
                  <%  }  }
                         int in=3-j;
                         for(int q=0;q<in;q++){ %> 
                  <td width="84" class="dan10">&nbsp;</td>
                  <%     }  %> </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td width="258" class="dan10">&nbsp;</td>
                  <td width="258" class="dan10">&nbsp;</td>
                  <td width="84" class="dan10">&nbsp;</td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td width="258" class="dan10"> Product Brand:<%=str[3] %></td>
                  <td width="258" class="dan10">Product Location:<%=str[4] %></td>
       <!--           <td width="258" class="dan10"> Sample ID:<%=str[5] %></td>  -->
                </tr>
              </table>
              <table width="600" border="0" cellspacing="0" cellpadding="2" bgcolor="#E6EDFB">
                <tr bgcolor="#E6EDFB"> 
                  <td  class="dan10" height="22" colspan="4"><img src="../../../images/images_en/requirements.gif" width="127" height="26"></td>
                </tr>
              <tr bgcolor="#4078E0"> 
                <td class="dan10" height="22" colspan="3"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="8" height="1"></b></font><b><font color="#FFFFFF">
                </font></b></td>
                <td class="dan10" height="22" colspan="3"><font color="#FFFFFF" class="big"></font><b><font color="#FFFFFF">Status: 
                  <%=status%></font></b></td>
              </tr>
                
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">Quantity&nbsp;&nbsp;&nbsp;:</td>
                  <td class="dan10" > <%=str[6] %><%=str[7] %> </td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">Terms of Price&nbsp;&nbsp;&nbsp;:</td>
                   <td colspan="3" class="dan10"> <%=str[10] %> &nbsp;&nbsp;&nbsp;&nbsp; <%=str[11] %>           </td>
        
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">Terms of Payment&nbsp;&nbsp;&nbsp;:</td>
                  <td colspan="3"   class="dan10"> <%=str[12] %> &nbsp;&nbsp;<%=str[13] %>          </td>
        
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right"> <%=title[3] %> </td>
                  <td colspan="3" class="dan10">  <%=str[18] %>&nbsp;&nbsp;<%=title[2] %>   <%=str[14] %>  </td>
           
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">Bid is Valid from&nbsp;&nbsp;&nbsp;:</td>
                  <td colspan="3" class="dan10"> <%=str[15] %>&nbsp;&nbsp;&nbsp;&nbsp; until&nbsp;&nbsp;&nbsp;:<%=str[16] %>    </td>
          
                </tr>
                <tr bgcolor="#4078E0"> <%   if(buysale.equals("B")){         %> 
                  <td class="font9" height="30" colspan="6" align="center"><a href="" onclick="return pclerm('Sorry,you are not allowed to sell!');"><font color="#FFFFFF">Post 
                    an Offer to Sell</a></td>
                  <%   }else if(approve.equals("N")){     %> 
                  <td class="font9" height="30" colspan="6" align="center"><a href="" onclick="return pclerm('Sorry,you are not allowed to sell!');"><font color="#FFFFFF">Post 
                    an Offer to Sell</a></td>
                  <%   }else if(status.equals("overdue")){   %>
                  <td class="font9" height="30" colspan="6" align="center"><font color="#FFFFFF"></td> 
                
                  <%   }else{   %> 
                  <td class="font9" height="30" colspan="6" align="center"><a href="product_list.jsp?postingId=<%=posting_id%>"><font color="#FFFFFF">Post 
                    an Offer to Sell</a></td>
                  <%    }%> </tr>
              </table>
            </td>
          </tr>
        </table>
        <div align="center"><br>
        </div>
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
            2000 PaperEC,Inc. All Right Reserved</font></td>
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
<% dsb.getDestroy();%>
</jsp:useBean>
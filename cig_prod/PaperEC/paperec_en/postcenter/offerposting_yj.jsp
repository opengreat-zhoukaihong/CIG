<%@ page import="java.util.*" language="java" %> 
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>
<jsp:useBean id="prov" scope="page" class="postcenter.EnBargain" />
<%   String posting_id=request.getParameter("posting_id");
     String bidcatch=request.getParameter("bidcatch");     
     String lang_code="EN";
     String user_id=UserInfo.getUserId();    
     prov.setPostingid(posting_id);     prov.setLangcode(lang_code);
     prov.setRole("");      prov.setUserid(user_id);  
     if(bidcatch.equals("bidcatch"))prov.getCatchBid();    
     String[] str=prov.getAllResult();
     Vector ve=prov.getVe();
     String[][] arr=prov.getArr();   
     String status=prov.getBidParaSt(str[17]);   
     int ij=ve.size(); 
     int kz=0;   
     int i=ij/3;  int j=ij%3;    
     String approve=UserInfo.getApproved(); 
     String htid="";
     boolean hz=false;
     String[] title=prov.getTitle();
     float fla=Float.valueOf(str[6]).floatValue()*Float.valueOf(str[8]).floatValue();
     for(int m=0;m<str.length;m++)if(str[m]==null)str[m]="";
     for(int m=0;m<title.length;m++)if(title[m]==null)title[m]="";
     for(int m=0;m<arr.length;m++)
        for(int n=0;n<3;n++)
           if(arr[m][n]==null)arr[m][n]="";
     if(str[11].equals("null null"))str[11]="";      
     %> 

<script language="javascript">
   function show(url){
      window.open(url,'quote','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=440,height=250')
             }
   function pclerm(stri){
      alert(stri);
      return false;   
         }         
   function oclerm(){
     return confirm("Affirm to cancel the quotation£¿")
      
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
.white10 {  font-size: 12px; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  text-decoration: none}
a:visited {  text-decoration: none}
a:active {  text-decoration: none}
a:hover {  text-decoration: underline}
.dan10 {  font-size: 11px; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
.qian {  font-family: "Arial", "Helvetica", "sans-serif"; color: #999999; font-size: 11px}
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
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('../foreignX.htm')"><font color="#FFFFFF">Currency 
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
    <td valign="top"><!-- #BeginEditable "body" --> 
      <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
        <tr bordercolor="#FFFFFF"> 
          <td height="254"> 
            <table width="600" border="0" cellspacing="0" cellpadding="0" bgcolor="#E6EDFB">
              <tr> 
                <td colspan="3" height="25" bgcolor="#4078E0"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1">Offer 
                  to Sell</b></font></td>
              </tr>
              <tr bgcolor="#E6EDFB"> 
                <td width="200" class="dan10">¡¡Posting ID:<%=posting_id %></td>
                <td colspan="2" width="400" class="dan10"><%=str[0] %>&gt;<%=str[1] %>&gt;<%=str[2] %></td>
                
              </tr>
              <tr bgcolor="#E6EDFB"> 
                <td width="258" class="dan10">¡¡Product Specification:</td>
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
                <td width="258" class="dan10">¡¡Product Brand:<%=str[3] %></td>
                <td width="258" class="dan10"> Origin:<%=str[4] %></td>
        <!--        <td width="258" class="dan10"> Sample ID:<%=str[5] %></td>  -->
              </tr>
            </table>
            <table width="600" border="0" cellspacing="0" cellpadding="2" bgcolor="#E6EDFB">
              <tr bgcolor="#E6EDFB"> 
                <td  class="dan10" height="22" colspan="4"><img src="../../../images/images_en/origin_offer.gif" width="127" height="26"></td>
              </tr>
              <tr bgcolor="#4078E0"> 
                <td class="dan10" height="22" colspan="4"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="8" height="1"></b></font><b><font color="#FFFFFF">
                </font></b></td>
                <td class="dan10" height="22" colspan="4"><font color="#FFFFFF" class="big"></font><b><font color="#FFFFFF">Status: 
                  <%=status%></font></b></td>
              </tr>
              <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">Quantity&nbsp;&nbsp;&nbsp;:</td>
                  <td class="dan10" > <%=str[6] %><%=str[7] %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Price&nbsp;&nbsp;&nbsp;:<%=str[8] %> <%=str[9] %>  </td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">Terms of Price&nbsp;&nbsp;&nbsp;:</td>
                   <td colspan="3" class="dan10"> <%=str[10] %> &nbsp;&nbsp;<%=str[11] %>           </td>
        
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">Terms of Payment&nbsp;&nbsp;&nbsp;:</td>
                  <td colspan="3"   class="dan10"> <%=str[12] %> &nbsp;&nbsp<%=str[13] %>          </td>
        
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right"> <%=title[3] %> </td>
                  <td colspan="3" class="dan10">  <%=str[18] %>&nbsp;&nbsp;&nbsp;&nbsp;<%=title[2] %>   <%=str[14] %>  </td>
           
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">Bid is Valid from&nbsp;&nbsp;&nbsp;:</td>
                  <td colspan="3" class="dan10"> <%=str[15] %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; until&nbsp;&nbsp;&nbsp;: <%=str[16] %>    </td>
          
                </tr>
              <%   String[] instr=new String[7];
         String tobiduser_id="";String bid_id="";String bid_own="";
         String buystatus="";String salestatus="";
         if(prov.isOwn()){  
             Vector  usve=prov.getAllUser();            
                      %> 
              <tr bgcolor="#E6EDFB" height="10"> 
                <td  class="dan10" align="center" height="10"> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
                </td>
                <td  class="dan10" align="center" height="10"> <a href="javascript:show('bidmodi.jsp?lang=&posting_id=<%=posting_id%>')"><font color="#3333FF"><b>Modify</b></font></a> 
                </td>
                <td  class="dan10" align="center" height="10"> <% if(status.equals("Cancelled")||status.equals("overdue")){  %> 
                  <a href="" onclick="return pclerm('Sorry,the posting was cancelled or Expired already!');"><font color="#3333FF"><b>Cancel</b></font></a> 
                  <%    }else if(!prov.isConcel()){     %>
                   <a href="" onclick="return pclerm('Sorry,you are not allowed to cancel this posting since there are some bids on accept or approved status!');"><font color="#3333FF"><b>Cancel</b></font></a> 
                  <%   }else{     %> <a href="offerposting_yj.jsp?posting_id=<%=posting_id%>&bidcatch=bidcatch" onclick="return oclerm();"><font color="#3333FF"><b>Cancel</b></font></a> 
                  <%      }%> </td>
                <td  class="dan10" align="center" height="10"> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <div align="center"><br>
      </div>
      <table width="600" border="0" cellspacing="0" cellpadding="2">
        <tr bgcolor="#174393"> 
          <td colspan="6" class="font9" height="20"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><font color="#FFFFFF"><b>
            </b></font></td>
        </tr>
        <%    kz=0; 
                if(usve.size()>0){
                 for(int m=0;m<usve.size();m++){
                     kz++;
                     bid_id="";
                     tobiduser_id=(String)usve.elementAt (m);
                     prov.setUserid(tobiduser_id);
                      
                               %> 
        <tr bgcolor="#4078E0"> 
          <td colspan="6" class="dan10" height="22"><b><font color="#FFCC33"> 
            room<%=kz%> </font></b> </td>
        </tr>
        <tr bgcolor="#4078E0"> 
          <td width="99" class="white10" align="center"><b>ID</b></td>
          <td width="109" class="white10" align="center"><b>Date</b></td>
          <td width="133" class="white10" align="center"><b>Offer</b></td>
          <td width="77" class="white10" align="center"><b>Quantity</b></td>
          <td width="83" class="white10" align="center"><b>Terms of Payment</b></td>
          <td width="75" class="white10" align="center"><b>Status</b></td>
        </tr>
        
        <tr bgcolor="#7EA2EB"> 
          <td colspan="6" class="dan10" height="20"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><b><font color="#000000">My 
            Bid</font></b></td>
        </tr>
        <%           prov.setRole("");
                     Vector bid=prov.getUserBid (); 
                      String bid_new="none";                     
                      for(i=0;i<bid.size();i++){
                          instr=(String[])bid.elementAt (i); 
                          bid_own=instr[0];
                          if(str[17].equals(bid_own)){
                               bid_new="none";
                           }else{  bid_new=bid_own; }
                           salestatus=instr[6];                              
                          if(instr[6].equals("Awaiting Contract")){
                              htid=bid_own;    
                              hz=true;
                               }   %> 
        <tr bgcolor="#E6EDFB"> <% if(i==(bid.size()-1)){   %> 
          <td width="99" class="dan10" align="center"><b><a href="javascript:show('bidcontent.jsp?bid_id=<%=instr[0]%>')"  ><%=instr[0] %></a></b></td>
          <td width="109" class="dan10" align="center"><b><%=instr[1] %></b></td>
          <td width="133" class="dan10" align="center" bgcolor="#E6EDFB"><b><%=instr[4] %> 
            <%=instr[2] %></b></td>
          <td width="77" class="dan10" align="center"><b><%=instr[3] %></b></td>
          <td width="83" class="dan10" align="center"><b><%=instr[5] %></b></td>
          <td width="75" class="dan10" align="center"><b><%=instr[6] %></b></td>
          <% }else{  %> 
          <td width="99"  align="center"><b><a href="javascript:show('bidcontent.jsp?bid_id=<%=instr[0]%>')" class="qian" ><%=instr[0] %></b></td>
          <td width="109" class="qian" align="center"><%=instr[1] %></td>
          <td width="133" class="qian" align="center" bgcolor="#E6EDFB"><b><%=instr[4] %> 
            <%=instr[2] %></td>
          <td width="77" class="qian" align="center"><%=instr[3] %></td>
          <td width="83" class="qian" align="center"><%=instr[5] %></td>
          <td width="75" class="qian" align="center"><%=instr[6] %></td>
          <% }      %> </tr>
        <%             }         %> 
        <tr bgcolor="#BCCEF3"> 
          <td colspan="6" class="dan10"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><b><font color="#000000">Bid 
            of Buyer <%=usve.elementAt(m) %></font></b></td>
        </tr>
        <%     prov.setRole("buy");
               bid=prov.getUserBid();   
               hz=false; 
               for(i=0;i<bid.size();i++){
                 bid_id="";
                 instr=(String[])bid.elementAt (i);
                   bid_id=instr[0]; 
                   buystatus=instr[6];   
                   if(instr[6].equals("Awaiting Contract")){
                       htid=bid_id;                
                       hz=true;
                   } 
      %> 
        <tr bgcolor="#E6EDFB"> <% if(i==(bid.size()-1)){   %> 
          <td width="99" class="dan10" align="center"><b><a href="javascript:show('bidcontent.jsp?bid_id=<%=instr[0]%>')" ><%=instr[0] %></a></b></td>
          <td width="109" class="dan10" align="center"><b><%=instr[1] %></b></td>
          <td width="133" class="dan10" align="center" bgcolor="#E6EDFB"><b><%=instr[4] %> 
            <%=instr[2] %></b></td>
          <td width="77" class="dan10" align="center"><b><%=instr[3] %></b></td>
          <td width="83" class="dan10" align="center"><b><%=instr[5] %></b></td>
          <td width="75" class="dan10" align="center"><b><%=instr[6] %></b></td>
          <% }else{  %> 
          <td width="99"  align="center"><a href="javascript:show('bidcontent.jsp?bid_id=<%=instr[0]%>')" class="qian" ><%=instr[0] %></a></td>
          <td width="109" class="qian" align="center"><%=instr[1] %></td>
          <td width="133" class="qian" align="center" bgcolor="#E6EDFB"><%=instr[4] %> 
            <%=instr[2] %></td>
          <td width="77" class="qian" align="center"><%=instr[3] %></td>
          <td width="83" class="qian" align="center"><%=instr[5] %></td>
          <td width="75" class="qian" align="center"><%=instr[6] %></td>
          <% }      %> </tr>
        <%                }            %> 
        <tr bgcolor="#BCCEF3"> 
          <td colspan="7" class="dan10" align="center" height="30"> <%    if(status.equals("Cancelled")||status.equals("overdue")){      %> 
            <!--                <a href="" onclick="return pclerm('Sorry,the posting was cancelled or expired already!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>       --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%     }else if(approve.equals("N")){      %> <!--                <a href="" onclick="return pclerm('Sorry,you are not allowed to bid!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>       --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%     }else if(buystatus.equals("Awaiting Confirmation")||buystatus.equals("Accepted by seller")||buystatus.equals("Awaiting Contract")||salestatus.equals("Accepted by buyer")||salestatus.equals("Accepted by seller")||salestatus.equals("Awaiting Contract")){     %> 
            <!--                <a href="" onclick="return pclerm('Soory,because the bid for this product is currently being processed,you cannot bid on this product now!');"><img src="../../../images/images_en/bid_button.gif" width="60" height="22" border="0"></a>      --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%        }else{     %> <a href="javascript:show('quote.jsp?user_id=<%=user_id%>&lang_code=<%=lang_code%>&bid_own=<%=bid_new%>&posting_id=<%=posting_id%>&tobiduser_id=<%=tobiduser_id%>&tobid_id=<%=bid_id%>&tobiduser_id=<%=tobiduser_id%>&bors=S')"><img src="../../../images/images_en/offer.gif" width="100" height="22" border="0"></a> 
            <%      }        %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%    if(status.equals("Cancelled")||status.equals("overdue")){      %> 
            <!--                  <a href="" onclick="return pclerm('Sorry,the posting was cancelled or expired already!');"><img src="acceptbid_button.gif" width="90" height="22" border="0"></a>       --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%     }else if(approve.equals("N")||buystatus.equals("Awaiting Confirmation")||buystatus.equals("Accepted by seller")||buystatus.equals("Awaiting Contract")||salestatus.equals("Awaiting Contract")||salestatus.equals("Accepted by seller")){      %> 
            <!--                <a href="" onclick="return pclerm('Sorry,you are not allowed to bid!');"><img src="acceptbid_button.gif" width="90" height="22" border="0"></a>       --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%        }else if(buystatus.equals("Active")||salestatus.equals("Accepted by buyer")){     %> 
            <a href="seccess3.jsp?posting_id=<%=posting_id%>&bid_own=<%=bid_own%>&bid_id=<%=bid_id%>&to_userid=<%=tobiduser_id%>&acc_userid=<%=user_id%>&phase=cfm"><img src="../../../images/images_en/accept.gif" width="100" height="22" border="0"></a> 
            <%      }        %> <% if(hz){  %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <a href="tongyi.jsp?act=&buy_sale=S&bid_id=<%=htid%>&lang_code=<%=lang_code%>&posting_id=<%=posting_id%>"><img src="../../../images/images_en/signcontract.gif" width="100" height="22" border="0"></font></a> 
            <%   }   %> </td>
        </tr>
<tr>
<td colspan="7" height="20">&nbsp;</td>
</tr> 
        <%  }
                }  }else{                   %> 
      </table>
    </td>
  </tr>
</table>
<div align="center"><br>
</div>
<table width="600" border="0" cellspacing="0" cellpadding="2">
  <tr bgcolor="#174393"> 
    <td colspan="6" class="font9" height="20"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><font color="#FFFFFF"><b>Bid 
      Activity</b></font></td>
  </tr>
  <tr bgcolor="#4078E0"> 
    <td width="99" class="white10" align="center"><b>Bid ID</b></td>
    <td width="109" class="white10" align="center"><b>Bid Date</b></td>
    <td width="133" class="white10" align="center"><b>Offer</b></td>
    <td width="77" class="white10" align="center"><b>Quantity</b></td>
    <td width="83" class="white10" align="center"><b>Terms of Payment</b></td>
    <td width="75" class="white10" align="center"><b>Status</b></td>
  </tr>
  <tr bgcolor="#BCCEF3"> 
    <td colspan="6" class="dan10"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><b><font color="#000000"> 
      My Bid</font></b></td>
  </tr>
  <%          prov.setRole("buy");
                 Vector bid=prov.getUserBid();
                 bid_own="none"; 
                 hz=false;                          
                 tobiduser_id=prov.getTobidUser_id();
                    for(i=0;i<bid.size();i++){
                       instr=(String[])bid.elementAt (i);
                       bid_own=instr[0];
                       buystatus=instr[6];  
                       if(instr[6].equals("Awaiting Contract")){
                          htid=bid_own;
                          hz=true;
                           }     %> 
  <tr bgcolor="#E6EDFB"> <% if(i==(bid.size()-1)){   %> 
    <td width="99" class="dan10" align="center"><b><a href="javascript:show('bidcontent.jsp?bid_id=<%=instr[0]%>')" ><%=instr[0] %></a></b></td>
    <td width="109" class="dan10" align="center"><b><%=instr[1] %></b></td>
    <td width="133" class="dan10" align="center" bgcolor="#E6EDFB"><b><%=instr[4] %> 
      <%=instr[2] %></b></td>
    <td width="77" class="dan10" align="center"><b><%=instr[3] %></b></td>
    <td width="83" class="dan10" align="center"><b><%=instr[5] %></b></td>
    <td width="75" class="dan10" align="center"><b><%=instr[6] %></b></td>
    <% }else{  %> 
    <td width="99"  align="center"><a href="javascript:show('bidcontent.jsp?bid_id=<%=instr[0]%>')" class="qian" ><%=instr[0] %></a></td>
    <td width="109" class="qian" align="center"><%=instr[1] %></td>
    <td width="133" class="qian" align="center" bgcolor="#E6EDFB"><%=instr[4] %> 
      <%=instr[2] %></td>
    <td width="77" class="qian" align="center"><%=instr[3] %></td>
    <td width="83" class="qian" align="center"><%=instr[5] %></td>
    <td width="75" class="qian" align="center"><%=instr[6] %></td>
    <% }      %> </tr>
  <%            }             %>
  <tr bgcolor="#E6EDFB"> 
    <td colspan="6" class="dan10" height="20"><font color="#E6EDFB" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><b><font color="#000000"> 
      &nbsp;</font></b></td>
  </tr>     
  <tr bgcolor="#BCCEF3"> 
    <td colspan="6" class="dan10" height="20"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><b><font color="#000000"> 
      Seller's Offer</font></b></td>
  </tr>
  <%       
                      prov.setRole("");
                      bid=prov.getUserBid ();                                            
                      for(i=0;i<bid.size();i++){                      
                        instr=(String[])bid.elementAt (i);
                        bid_id=instr[0]; 
                        salestatus=instr[6];    
                        if(instr[6].equals("Awaiting Contract")){
                            htid=bid_id;     
                            hz=true;
                              } 
              %> 
  <tr bgcolor="#E6EDFB"> <% if(i==(bid.size()-1)){   %> 
    <td width="99" class="dan10" align="center"><b><a href="javascript:show('bidcontent.jsp?bid_id=<%=instr[0]%>')" ><%=instr[0] %></a></b></td>
    <td width="109" class="dan10" align="center"><b><%=instr[1] %></b></td>
    <td width="133" class="dan10" align="center" bgcolor="#E6EDFB"><b><%=instr[4] %> 
      <%=instr[2] %></b></td>
    <td width="77" class="dan10" align="center"><b><%=instr[3] %></b></td>
    <td width="83" class="dan10" align="center"><b><%=instr[5] %></b></td>
    <td width="75" class="dan10" align="center"><b><%=instr[6] %></b></td>
    <% }else{  %> 
    <td width="99"  align="center"><a href="javascript:show('bidcontent.jsp?bid_id=<%=instr[0]%>')" class="qian" ><%=instr[0] %></a></td>
    <td width="109" class="qian" align="center"><%=instr[1] %></td>
    <td width="133" class="qian" align="center" bgcolor="#E6EDFB"><%=instr[4] %> 
      <%=instr[2] %></td>
    <td width="77" class="qian" align="center"><%=instr[3] %></td>
    <td width="83" class="qian" align="center"><%=instr[5] %></td>
    <td width="75" class="qian" align="center"><%=instr[6] %></td>
    <% }      %> </tr>
  <%             }         %> 
  <tr bgcolor="#BCCEF3"> 
    <td colspan="7" class="dan10" align="center" height="30"> <%    if(status.equals("Cancelled")||status.equals("overdue")){      %> 
      <!--                 <a href="" onclick="return pclerm('Sorry,the posting was cancelled or expired already!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>       --> 
      ¡¡¡¡¡¡ <img src="../../../images/images_en/space.gif" width="30" height="1"> 
      <%     }else if(approve.equals("N")){      %> <!--                 <a href="" onclick="return pclerm('Sorry,you are not allowed to bid!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>       --> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%     }else if(buystatus.equals("Awaiting Confirmation")||buystatus.equals("Accepted by seller")||buystatus.equals("Awaiting Contract")||salestatus.equals("Accepted by buyer")||salestatus.equals("Accepted by seller")||salestatus.equals("Awaiting Contract")){     %> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <!--                 <a href="" onclick="return pclerm('Soory,because the bid for this product is currently being processed,you cannot bid on this product now!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>   --> 
      <%        }else{     %> <a href="javascript:show('quote.jsp?user_id=<%=user_id%>&lang_code=<%=lang_code%>&bid_own=<%=bid_own%>&posting_id=<%=posting_id%>&tobiduser_id=<%=tobiduser_id%>&tobid_id=<%=bid_id%>&bors=B')"><img src="../../../images/images_en/bid.gif" width="100" height="22" border="0"></a> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%    }   %> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
      <%    if(status.equals("Cancelled")||status.equals("overdue")){      %> 
      <!--                 <a href="" onclick="return pclerm('Sorry,the posting was cancelled or expired already!');"><img src="acceptbid_button.gif" width="90" height="22" border="0"></a>       --> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> ¡¡ 
      <%     }else if(approve.equals("N")){      %> <!--                 <a href="" onclick="return pclerm('Sorry,you are not allowed to bid!');"><img src="acceptbid_button.gif" width="90" height="22" border="0"></a>       --> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%        }else if(salestatus.equals("Active")&&(!buystatus.equals("Awaiting Confirmation"))&&(!buystatus.equals("Accepted by seller"))&&(!buystatus.equals("Awaiting Contract"))){     %> 
      <a href="seccess3.jsp?posting_id=<%=posting_id%>&bid_own=<%=bid_own%>&bid_id=<%=bid_id%>&to_userid=<%=tobiduser_id%>&acc_userid=<%=user_id%>&phase=accept"><img src="../../../images/images_en/accept.gif" width="100" height="22" border="0"></a> 
      <%         }        %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%  if(buystatus.equals("Awaiting Confirmation")){  %> 
      <a href="seccess3.jsp?posting_id=<%=posting_id%>&bid_own=<%=bid_own%>&bid_id=<%=bid_id%>&to_userid=<%=tobiduser_id%>&acc_userid=<%=user_id%>&phase=Confirmation"><img src="../../../images/images_en/reconfirm.gif" width="100" height="22" border="0"></a> 
      <%  }                   %> <% if(hz){  %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <a href="tongyi.jsp?act=&buy_sale=B&bid_id=<%=htid%>&lang_code=<%=lang_code%>&posting_id=<%=posting_id%>"><img src="../../../images/images_en/signcontract.gif" width="100" height="22" border="0"></font></a> 
      <%   }     %> </td>
  </tr>
  <%          }                %> 
</table></td>
</tr> </table> 
<div align="center"><br>
  <img src="../../../images/images_en/space.gif" width="100" height="1"> </div><!-- #EndEditable --> </td> </tr> </table> 
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
<%    prov.getDestroy(); %>
</jsp:useBean>
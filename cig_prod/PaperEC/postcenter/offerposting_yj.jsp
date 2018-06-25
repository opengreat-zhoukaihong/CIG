<%@ page import="java.util.*" language="java" %> 
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />

<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>
 <jsp:useBean id="prov" scope="page" class="postcenter.Bargain" />

<%   String posting_id=request.getParameter("posting_id");
     String bidcatch=request.getParameter("bidcatch");     
     String lang_code="GB";
     String user_id=UserInfo.getUserId();    
     prov.setPostingid(posting_id);     prov.setLangcode(lang_code);
     prov.setRole("");      prov.setUserid(user_id);  
     if(bidcatch.equals("bidcatch"))prov.getCatchBid();    
     String[] str=prov.getAllResult();
     Vector ve=prov.getVe();
     String[][] arr=prov.getArr();   
     String status=prov.getBidParaSt(str[17]);   
     int ij=ve.size();    
     int i=ij/3;  int j=ij%3;   
     int kz=0; 
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
     return confirm("真的要取消此议价单吗？")
      
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
a:link {  text-decoration: none; font-family: "宋体"}
a:visited {  text-decoration: none; font-family: "宋体"}
a:active {  text-decoration: none; font-family: "宋体"}
a:hover {  text-decoration: underline; font-family: "宋体"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "宋体"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
.qian {  font-family: "宋体"; color: #999999; font-size: 12px}
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
      <script language="JavaScript" src="../../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../images/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="product_list.jsp" class="font9"><font color="#000000">供应发布</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="request2buy.jsp"><font color="#000000">需求发布</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="order_search.jsp"><font color="#000000">浏览供需</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">我的客户</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="product_list.jsp"><font color="#000000">我的产品</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">ID直通车</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="进入">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('../foreignX.htm')"><font color="#FFFFFF">外汇汇率换算</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="../jiaoyifu.htm"><font color="#FFFFFF">交易服务</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('../huansuanresult.jsp')"><font color="#FFFFFF">计量单位转换</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../../images/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
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
                <td colspan="3" height="25" bgcolor="#4078E0"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1">供应详情</b></font></td>
              </tr>
              <tr bgcolor="#E6EDFB"> 
                <td width="200" class="dan10">　订单号：<%=posting_id %></td>
                <td colspan="2" width="400" class="dan10"><%=str[0] %>&gt;<%=str[1] %>&gt;<%=str[2] %></td>
                
              </tr>
              <tr bgcolor="#E6EDFB"> 
                <td width="258" class="dan10">　产品规格：</td>
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
                if(i==0)mn=-1;   %> 
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
                <td width="258" class="dan10">　产品品牌：<%=str[3] %></td>
                <td width="258" class="dan10"> 产品产地：<%=str[4] %></td>
      <!--          <td width="258" class="dan10"> 样品库编号：<%=str[5] %></td>  -->
              </tr>
            </table>
            <table width="600" border="0" cellspacing="0" cellpadding="2" bgcolor="#E6EDFB">
              <tr bgcolor="#E6EDFB"> 
                <td  class="dan10" height="22" colspan="4"><img src="../../images/origin_offer.gif" width="127" height="26"></td>
              </tr>
              <tr bgcolor="#4078E0"> 
                <td class="dan10" height="22" colspan="4"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="8" height="1"></b></font><b><font color="#FFFFFF"></font></b></td>
                <td class="dan10" height="22" colspan="4"><font color="#FFFFFF" class="big"></font><b><font color="#FFFFFF">状 
                  态: <%=status%></font></b></td>
              </tr>
              <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</td>
                  <td class="dan10" >    <%=str[6] %><%=str[7] %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报价：<%=str[8] %> <%=str[9] %>    </td>       
                </tr>
               
                <tr bgcolor="#E6EDFB"> 
                  <td  class="dan10" align="right">价格条款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</td>
                  <td colspan="3" class="dan10"> <%=str[10] %> &nbsp;&nbsp; <%=str[11] %>           </td>
        
                  <td class="dan10">     </td>  
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">支付方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</td>
                  <td colspan="3"   class="dan10"> <%=str[12] %> &nbsp;&nbsp;<%=str[13] %>          </td>
        
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">  <%=title[3] %>    </td>
                  <td colspan="3" class="dan10">  <%=str[18] %>&nbsp;&nbsp;&nbsp;&nbsp;<%=title[2] %>   <%=str[14] %>  </td>
        
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">报价有效期&nbsp;&nbsp;&nbsp;：</td>
                  <td colspan="3" class="dan10"> <%=str[15] %>&nbsp;&nbsp;&nbsp;&nbsp;到  ： <%=str[16] %>    </td>
          
                </tr>
              <%   String[] instr=new String[7];
                   String tobiduser_id="";   //议价对方的用户ID
                   String bid_id="";         //对方议价单ID
                   String bid_own="";        //用户议价单ID
                   String buystatus="";      //买方BID状态
                   String salestatus="";     //卖方BID状态
                   if(prov.isOwn()){                         //判断议价单的发布者，为真即为发布者。
                      Vector  usve=prov.getAllUser();       //获得所有议价用户。     
               %> 
              <tr bgcolor="#E6EDFB" height="10"> 
                <td  class="dan10" align="center" height="10"> <img src="../../images/space.gif" width="30" height="1"> 
                </td>
                <td  class="dan10" align="center" height="10"> <a href="javascript:show('bidmodi.jsp?lang=&posting_id=<%=posting_id%>')"><font color="#3333FF"><b>修 
                  改</b></font></a> </td>
                <td  class="dan10" align="center" height="10"> <% if(status.equals("取消")||status.equals("过期")){  %> 
                  <a href="" onclick="return pclerm('议价单已经取消或已过期！');"><font color="#3333FF"><b>取 
                  消</b></font></a> <%    }else if(!prov.isConcel()){     %> <a href="" onclick="return pclerm('您有处于申请成交或完成状态的议价单,即不予取消!');"><font color="#3333FF"><b>取 
                  消</b></font></a> <%   }else{     %> <a href="offerposting_yj.jsp?posting_id=<%=posting_id%>&bidcatch=bidcatch" onclick="return oclerm();"><font color="#3333FF"><b>取 
                  消</b></font></a> <%      }%> </td>
                <td  class="dan10" align="center" height="10"> <img src="../../images/space.gif" width="30" height="1"> 
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
          <td colspan="6" class="font9" height="20" bgcolor="#174393"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1"></b></font><font color="#FFFFFF"><b>议价</b></font></td>
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
          <td colspan="6" class="dan10" height="22"><b><font color="#FFCC33">交易室<%=kz%> 
            </font></b> </td>
        </tr>
        <tr> 
          <td width="70" class="white10" align="center" bgcolor="#4078E0"><b>ID</b></td>
          <td width="77" class="white10" align="center" bgcolor="#4078E0"><b>时间</b></td>
          <td width="75" class="white10" align="center" bgcolor="#4078E0"><b>报价</b></td>
          <td width="56" class="white10" align="center" bgcolor="#4078E0"><b>数量</b></td>
          <td width="70" class="white10" align="center" bgcolor="#4078E0"><b>支付方式</b></td>
          <td width="49" class="white10" align="center" bgcolor="#4078E0"><b>状态</b></td>
        </tr>
        
        <tr bgcolor="#BCCEF3"> 
          <td colspan="6" class="dan10" height="20"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1"></b></font><b>我的报价</b></td>
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
                          if(instr[6].equals("核准成交")){
                              htid=bid_own;    
                              hz=true;
                               }   %> 
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
        <%             } //列出卖方的bid.        %> 
        <tr> 
          <td colspan="6" class="dan10" bgcolor="#BCCEF3"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1"></b></font><b>买方<%=usve.elementAt(m) %>的出价</b></td>
        </tr>
        <%     prov.setRole("buy");
               bid=prov.getUserBid();    
               hz=false; 
               for(i=0;i<bid.size();i++){
                 bid_id="";
                 instr=(String[])bid.elementAt (i);
                   bid_id=instr[0]; 
                   buystatus=instr[6];   
                   if(instr[6].equals("核准成交")){
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
        <%                }    //列出买方的bid.        %> 
        <tr bgcolor="#BCCEF3"> 
          <td colspan="7" class="dan10" align="center" height="30"> <%    if(status.equals("取消")||status.equals("过期")){      %> 
            <!--            <a href="" onclick="return pclerm('议价单已经取消或已过期,拒绝报价!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>       --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%     }else if(approve.equals("N")){      %> <!--            <a href="" onclick="return pclerm('您的报价权利未得到许可!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>       --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%     }else if(buystatus.equals("等待确认")||buystatus.equals("申请成交")||buystatus.equals("核准成交")||salestatus.equals("已接受")||salestatus.equals("申请成交")||salestatus.equals("核准成交")){     %> 
            <!--            <a href="" onclick="return pclerm('您与买方的议价单已经处于：已接受、申请成交或核准成交的状态，不能再次报价!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>      --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%        }else{     %> <a href="javascript:show('quote.jsp?user_id=<%=user_id%>&lang_code=<%=lang_code%>&bid_own=<%=bid_new%>&posting_id=<%=posting_id%>&tobiduser_id=<%=tobiduser_id%>&tobid_id=<%=bid_id%>&tobiduser_id=<%=tobiduser_id%>&bors=S')"><img src="../../images/bid.gif" width="100" height="22" border="0"></a> 
            <%      }        %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%    if(status.equals("取消")||status.equals("过期")){      %> <!--              <a href="" onclick="return pclerm('议价单已经取消或已过期,拒绝成交!');"><img src="acceptbid_button.gif" width="90" height="22" border="0"></a>       --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%     }else if(approve.equals("N")||buystatus.equals("等待确认")||buystatus.equals("申请成交")||buystatus.equals("核准成交")||salestatus.equals("核准成交")||salestatus.equals("申请成交")){      %> 
            <!--            <a href="" onclick="return pclerm('您的申请成交权利未得到许可!');"><img src="acceptbid_button.gif" width="90" height="22" border="0"></a>       --> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <%        }else if(buystatus.equals("交易中")||salestatus.equals("已接受")){     %> 
            <a href="seccess3.jsp?posting_id=<%=posting_id%>&bid_own=<%=bid_own%>&bid_id=<%=bid_id%>&to_userid=<%=tobiduser_id%>&acc_userid=<%=user_id%>&phase=cfm"><img src="../../images/accept.gif" width="100" height="22" border="0"></a> 
            <%      }        %> <% if(hz){  %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <img src="../../../images/images_en/space.gif" width="30" height="1"> 
            <a href="tongyi.jsp?act=&buy_sale=S&bid_id=<%=htid%>&lang_code=<%=lang_code%>&posting_id=<%=posting_id%>"><img src="../../images/signcontract.gif" width="100" height="22" border="0"></font></a> 
            <%   }   %> </td>
        </tr><tr>
<td colspan="7" height="20">&nbsp;</td>
</tr> 
        <%  }
                }  }else{     //此议价单非此用户所发布。              %> 
     
</table>
    </td>
  </tr>
</table>
<div align="center"><br>
</div>
<table width="600" border="0" cellspacing="0" cellpadding="2">
  <tr bgcolor="#174393"> 
    <td colspan="6" class="font9" height="20" bgcolor="#174393"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1"></b></font><font color="#FFFFFF"><b>议价</b></font></td>
  </tr>
  <tr> 
    <td colspan="6" class="dan10" height="20" bgcolor="#4078E0">&nbsp;</td>
  </tr>
  <tr> 
    <td width="70" class="white10" align="center" bgcolor="#4078E0"><b>ID</b></td>
    <td width="77" class="white10" align="center" bgcolor="#4078E0"><b>时间</b></td>
    <td width="75" class="white10" align="center" bgcolor="#4078E0"><b>报价</b></td>
    <td width="56" class="white10" align="center" bgcolor="#4078E0"><b>数量</b></td>
    <td width="70" class="white10" align="center" bgcolor="#4078E0"><b>支付方式</b></td>
    <td width="49" class="white10" align="center" bgcolor="#4078E0"><b>状态</b></td>
  </tr>
  <tr bgcolor="#BCCEF3"> 
    <td colspan="6" class="dan10"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><b><font color="#000000"> 
      我的出价</font></b></td>
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
                       if(instr[6].equals("核准成交")){
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
  <%            } //列出买方bid.            %> 
  <tr bgcolor="#E6EDFB"> 
    <td colspan="6" class="dan10" height="20"><font color="#E6EDFB" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><b><font color="#000000"> 
      &nbsp;</font></b></td>
  </tr>  
  <tr bgcolor="#BCCEF3"> 
    <td colspan="6" class="dan10" height="20"><font color="#FFFFFF" class="big"><b><img src="../../../images/images_en/space.gif" width="5" height="1"></b></font><b><font color="#000000"> 
      卖方的报价</font></b></td>
  </tr>
  <%       
                      prov.setRole("");
                      bid=prov.getUserBid ();                                            
                      for(i=0;i<bid.size();i++){                      
                        instr=(String[])bid.elementAt (i);
                        bid_id=instr[0]; 
                        salestatus=instr[6];    
                        if(instr[6].equals("核准成交")){
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
  <%             } //列出卖方bid.         %> 
  <tr bgcolor="#BCCEF3"> 
    <td colspan="7" class="dan10" align="center" height="30"> <%    if(status.equals("取消")||status.equals("过期")){      %> 
      <!--           <a href="" onclick="return pclerm('议价单已经取消或已过期,拒绝报价!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>       --> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> 　　　 
      <%     }else if(approve.equals("N")){      %> <!--              <a href="" onclick="return pclerm('您的报价权利未得到许可!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>       --> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%     }else if(buystatus.equals("等待确认")||buystatus.equals("申请成交")||buystatus.equals("核准成交")||salestatus.equals("已接受")||salestatus.equals("申请成交")||salestatus.equals("核准成交")){     %> 
      <!--              <a href="" onclick="return pclerm('您与卖方的议价单已经处于：已接受、申请成交或核准成交的状态，不能再次报价!');"><img src="bid_button.gif" width="60" height="22" border="0"></a>   --> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%        }else{     %> 
      <a href="javascript:show('quote.jsp?user_id=<%=user_id%>&lang_code=<%=lang_code%>&bid_own=<%=bid_own%>&posting_id=<%=posting_id%>&tobiduser_id=<%=tobiduser_id%>&tobid_id=<%=bid_id%>&bors=B')"><img src="../../images/offer.gif" width="100" height="22" border="0"></a> 
      <%    }   %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%    if(status.equals("取消")||status.equals("过期")){      %> 
      <!--              <a href="" onclick="return pclerm('议价单已经取消或已过期,拒绝接受!');"><img src="acceptbid_button.gif" width="90" height="22" border="0"></a>       --> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> 　 
      <%     }else if(approve.equals("N")){      %> <!--              <a href="" onclick="return pclerm('您的接受报价权利未得到许可!');"><img src="acceptbid_button.gif" width="90" height="22" border="0"></a>       --> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%        }else if(salestatus.equals("交易中")&&(!buystatus.equals("等待确认"))&&(!buystatus.equals("申请成交"))&&(!buystatus.equals("核准成交"))){     %> 
      <a href="seccess3.jsp?posting_id=<%=posting_id%>&bid_own=<%=bid_own%>&bid_id=<%=bid_id%>&to_userid=<%=tobiduser_id%>&acc_userid=<%=user_id%>&phase=accept"><img src="../../images/jieshou.gif" width="100" height="22" border="0"></a> 
      <%         }        %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <%  if(buystatus.equals("等待确认")){  %> 
      <a href="seccess3.jsp?posting_id=<%=posting_id%>&bid_own=<%=bid_own%>&bid_id=<%=bid_id%>&to_userid=<%=tobiduser_id%>&acc_userid=<%=user_id%>&phase=Confirmation"><img src="../../images/reconfirm.gif" width="100" height="22" border="0"></a> 
      <%  }      %> <% if(hz){  %> <img src="../../../images/images_en/space.gif" width="30" height="1"> 
      <img src="../../../images/images_en/space.gif" width="30" height="1"> <a href="tongyi.jsp?act=&buy_sale=B&bid_id=<%=htid%>&lang_code=<%=lang_code%>&posting_id=<%=posting_id%>"><img src="../../images/signcontract.gif" width="100" height="22" border="0"></font></a> 
      <%   }     %> </td>
  </tr>
  <%          }                %> 
</table></td>
</tr> </table> 
<div align="center"><br>
  <img src="file://///Aaa/bbb/images/space.gif" width="100" height="1"> </div><!-- #EndEditable --> </td> </tr> </table> 
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%    prov.getDestroy(); %>
</jsp:useBean>
<%@ page import="java.util.Vector"  language="java"  %>
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />
<%  if (!UserInfo.getAuthorized()){

%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>
<jsp:useBean id="bargain" scope="page"  class="postcenter.Bargain" />
<jsp:useBean id="dsb" scope="page" class="postcenter.Distribute" />
<%   String posting_id=request.getParameter("posting_id").toUpperCase ();
     bargain.setPostingid(posting_id);
     if(bargain.getExist().equals("no")){      
      bargain.getDestroy();
      dsb.getDestroy();%>
<jsp:forward page="inform.jsp?info=很抱歉！您想要查找的发布ID并不存在，请查证。" />
</jsp:forward>     
<%            }
     dsb.setPostingId(posting_id);
     if(!dsb.isBuyorSale()){   
      bargain.getDestroy();
      dsb.getDestroy();%>
<jsp:forward page="offerposting_yj.jsp" > 
<jsp:param name="bidcatch" value="" />
<jsp:param name="posting_id" value="<%=posting_id%>" />
</jsp:forward>      
 <%  }   %>     




       
<%    String user_id=UserInfo.getUserId(); 
      String approve=UserInfo.getApproved();
      String buysale=UserInfo.getBuySaleFlag(); %>   
<jsp:setProperty name="bargain" property="langcode"   value="GB" />   
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
     
    
<html><!-- #BeginTemplate "/Templates/paperec_templares.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
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
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">我的客户</font></td>
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
      <form method="post" action="">
        <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="254"> 
              <table width="600" border="0" cellspacing="0" cellpadding="0" bgcolor="#E6EDFB">
          
                <tr> 
                  <td colspan="3" height="25" bgcolor="#4078E0"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1">需求详情</b></font></td>
                </tr>
          
                <tr bgcolor="#E6EDFB"> 
                  <td width="200" class="dan10">　发布号：<%=posting_id %></td>
                  <td colspan="2" width="400" class="dan10"><%=str[0] %>&gt;<%=str[1] %>&gt;<%=str[2] %></td>
                  
                </tr>
        
                <tr bgcolor="#E6EDFB"> 
                  <td width="258" class="dan10">　产品规格：</td>
                  <td width="258" class="dan10">&nbsp;</td>
                  <td width="84" class="dan10">&nbsp;</td>
                </tr>
 
    <%    int mn=0; 
             
             for(int m=0;m<i;m++){       %>              
                <tr bgcolor="#E6EDFB"> 
                
               <%  for(int n=0;n<3;n++){
                     mn=m*3+n;
                    if(arr[mn][1].equals("")){   
                              %>
                         
                  <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: <%=arr[mn][0]%> </td>
                      <%  }else{  %>   
                  <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: <%=arr[mn][0]%>--<%=arr[mn][1]%> <%=arr[mn][2]%></td>
                        <%  }     }    %>
                     </tr>         
                      <%       }  
                if(i==0)mn=-1;  %>
                  <tr bgcolor="#E6EDFB">           
                 <%  for(int n=0;n<j;n++){ 
                         mn+=1;  
                        if(arr[mn][1].equals("")){   
                              %>
                         
                  <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: <%=arr[mn][0]%> </td>
                      <%  }else{  %>   
                  <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: <%=arr[mn][0]%>--<%=arr[mn][1]%> <%=arr[mn][2]%></td>
                        <%  }  }
                         int in=3-j;
                         for(int q=0;q<in;q++){ %>
                       <td width="84" class="dan10">&nbsp;</td>
                         <%     }  %>       
                        </tr>
                
                <tr bgcolor="#E6EDFB"> 
                  <td width="258" class="dan10">&nbsp;</td>
                  <td width="258" class="dan10">&nbsp;</td>
                  <td width="84" class="dan10">&nbsp;</td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td width="258" class="dan10"> 产品品牌：<%=str[3] %></td>
                  <td width="258" class="dan10">产品产地：<%=str[4] %></td>
       <!--           <td width="258" class="dan10">样品库编号：<%=str[5] %></td>  -->
                </tr>
              </table>
              <table width="600" border="0" cellspacing="0" cellpadding="2" bgcolor="#E6EDFB">
              <tr bgcolor="#E6EDFB"> 
                  <td  class="dan10" height="22" colspan="4"><img src="../../images/requirements.gif" width="127" height="26"></td>
                </tr>
              <tr bgcolor="#4078E0"> 
                <td class="dan10" height="22" colspan="3"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="8" height="1"></b></font><b><font color="#FFFFFF"></font></b></td>
                <td class="dan10" height="22" colspan="3"><font color="#FFFFFF" class="big"></font><b><font color="#FFFFFF">状 
                  态: <%=status%></font></b></td>
              </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</td>
                  <td class="dan10" >    <%=str[6] %><%=str[7] %>   </td>       
                </tr>
               
                <tr bgcolor="#E6EDFB"> 
                  <td  class="dan10" align="right">价格条款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</td>
                  <td colspan="3" class="dan10"><%=str[10] %> &nbsp;&nbsp;&nbsp;&nbsp; <%=str[11] %>           </td>
        
                  <td class="dan10">     </td>  
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">支付方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</td>
                  <td colspan="3"   class="dan10"> <%=str[12] %> &nbsp;&nbsp;<%=str[13] %>          </td>
        
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">  <%=title[3] %>    </td>
                  <td colspan="3" class="dan10">  <%=str[18] %>&nbsp;&nbsp;<%=title[2] %>   <%=str[14] %>  </td>
        
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td class="dan10" align="right">报价有效期&nbsp;&nbsp;&nbsp;：</td>
                  <td colspan="3" class="dan10"> <%=str[15] %>&nbsp;&nbsp;&nbsp;&nbsp;到  ： <%=str[16] %>    </td>
          
                </tr>
                <tr bgcolor="#4078E0"> 
              <%   if(buysale.equals("B")){         %>
                  <td class="font9" height="30" colspan="6" align="center"><a href="" onclick="return pclerm('您是买家，无权发布供应！');"><font color="#FFFFFF">对此需求发布供应</a></td> 
              <%   }else if(approve.equals("N")){     %>
                    <td class="font9" height="30" colspan="6" align="center"><a href="" onclick="return pclerm('您的发布供应权利未得到许可！');"><font color="#FFFFFF">对此需求发布供应</a></td> 
              <%   }else if(status.equals("过期")){   %>
                  <td class="font9" height="30" colspan="6" align="center"><font color="#FFFFFF"></td> 
              <%   }else{  %>
                  <td class="font9" height="30" colspan="6" align="center"><a href="product_list.jsp?postingId=<%=posting_id%>"><font color="#FFFFFF">对此需求发布供应</a></td> 
              <%    }%>  
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <div align="center"><br>
        </div>
      </form>
      <!-- #EndEditable --> 
    </td>
  </tr>
</table>
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
<!-- #EndTemplate --></html>
<% dsb.getDestroy();%>
</jsp:useBean>
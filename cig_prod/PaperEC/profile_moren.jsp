<%@ page import="java.sql.*" language="java" %>

 <jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
 
<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>
<%!String st,user_id,lang_code; ResultSet rs;int i; String str[]=new String[11];%>
<jsp:useBean id="myFind" scope="page" class="postcenter.newRegister" />
 
<%  user_id=UserInfo.getUserId();
    lang_code="GB";  %>
              
<script><!--
  function reload(){
    window.history.back()
        }
  function valid(i){
   switch(i){
     case 1:
       if(putin.ccemail.value!=''&&putin.ccemail.value.indexOf("@")<1){
           putin.ccemail.value=''
           alert("邮件地址有误，请验证后重新输入!")
            return false;
                }
         break;       
     case 2:
        if(putin.bj.value!=''&&putin.bj.value<1){
           putin.bj.value=''
           alert("报价有效期有误,请验证后重新输入!")
           return false;
              }
              break;
     case 3:
          if(putin.dd.value!=''&&putin.dd.value<1){
           putin.dd.value=''
           alert("定单有效期有误,请验证后重新输入!")
           return false;
              }     
           break;                         
           }
        }   
 //--></script>           
 
 <script language="JavaScript">
function openForeignX(url){   
        OpenWindow=window.open(url, "foreignXwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,resizable=no,menubar=no,width=142,height=230");
}

function openMeasConv(url){   
        OpenWindow=window.open(url, "measConvwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no,width=300,height=300");
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
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600"><tr>
  <td width="159"> 
   <script language="JavaScript" src="../javascript/caidan.js">
</script>
    <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1"> 
      <form name="moveBarForm" method="post" action="postcenter/demand_info.jsp">
        <table width="141" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="143"> 
              <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                <tr> 
                  <td><img src="../images/jyzhx.gif" width="139" height="22"></td>
                </tr>
                <tr valign="middle"> 
                  <td bgcolor="#F1AD0C" height="22" align="center"><a href="postcenter/product_list.jsp" class="font9"><font color="#000000">供应发布</font></a></td>
                </tr>
                <tr valign="middle"> 
                  <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="postcenter/request2buy.jsp"><font color="#000000">需求发布</font></a></td>
                </tr>
                <tr valign="middle"> 
                  <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="postcenter/order_search.jsp"><font color="#000000">浏览供需</font></a></td>
                </tr>
                <tr valign="middle"> 
                  <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="mycustomer.jsp"><font color="#000000">我的客户</font></a></td>
                </tr>
                <tr bgcolor="#F0AC10"> 
                  <td class="font9" height="22" align="center"><a href="postcenter/product_list.jsp"><font color="#000000">我的产品</font></a></td>
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
                  <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('foreignX.htm')"><font color="#FFFFFF">外汇汇率换算</font></a></td>
                </tr>
                <tr> 
                  <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="jiaoyifu.htm"><font color="#FFFFFF">交易服务</font></a></td>
                </tr>
                <tr valign="middle"> 
                  <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('huansuanresult.jsp')"><font color="#FFFFFF">计量单位转换</font></a></td>
                </tr>
              </table>
              <table width="139" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td><img src="../images/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </form>
    </div>
  </td><td valign="top">
  <form method="post" action="xiugaisucess.jsp" name="putin">
    <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF"><tr bordercolor="#FFFFFF"><td height="131">
      <%
      String str_value="";
      String lang="";
       String currency_id="";
       String ship="";
       
    try{  
      st="select market_info,now_info,day_info,email_info,cc_email,bid_vday,posting_vday,currency_id,measure,def_lang_code,ship_port_id from users where user_id="+user_id;
   myFind.setSqlStc(st);
   rs=myFind.getAllData();
     
   if(rs.next()){
        str[0]=rs.getString("market_info");
        str[0]= str[0]==null?"":str[0];
        str[1]=rs.getString("now_info");  
        str[1]= str[1]==null?"":str[1];
        str[2]=rs.getString("day_info");
        str[2]= str[2]==null?"":str[2];
        str[3]=rs.getString("email_info"); 
        str[3]= str[3]==null?"":str[3]; 
        str[4]=rs.getString("cc_email");
        str[4]= str[4]==null?"":str[4];
        str[5]=rs.getString("bid_vday");
        str[5]= str[5]==null?"":str[5];          
        str[6]=rs.getString("posting_vday");
        str[6]= str[6]==null?"":str[6];
        str[7]=rs.getString("currency_id");
        str[7]= str[7]==null?"":str[7]; 
        str[8]=rs.getString("def_lang_code");
        str[8]= str[8]==null?"":str[8];
        str[9]=rs.getString("measure");      
        str[9]= str[9]==null?"":str[9];      
        str[10]=rs.getString("ship_port_id"); 
        str[10]= str[10]==null?"":str[10];
                }
        
        myFind.disconn();
       
        st="select str_value from parameter where id=1 and lang_code='"+lang_code+"' and code='"+str[7]+"'";  
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next()) str_value=rs.getString("str_value");
        myFind.disconn();
        st="select descr from lang_desc where lang_code='"+str[8]+"'";  
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next())lang=rs.getString("descr");
        myFind.disconn();
        if(str[9].equals("M")){ currency_id=" 公  制 ";
         }else{ currency_id=" 英  制 ";  }
        
        st="select str_value from parameter where id=4 and lang_code='"+lang_code+"' and code='"+str[10]+"'";
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next())ship=rs.getString("str_value");
        myFind.disconn(); 
        
             %> 
      <table width="500" border="0" cellspacing="2" cellpadding="4">
        <tr> 
          <td colspan="2" height="19" bgcolor="#4078E0"><font color="#FFFFFF">默认值设定</font></td>
        </tr>
        <!--           
                <tr> 
                  <td width="137" class="dan10" bgcolor="#E6EDFB">是否接受市场通知</td>
                  <td width="363" class="dan10" bgcolor="#E6EDFB">
           <% if(str[0].equals("Y")){  %>
                    <input type="radio" name="market" value="Y" checked>
                    是 
                    <input type="radio" name="market" value="N" >
                    否 </td>
               <%   }else{     %>
                    <input type="radio" name="market" value="Y">
                    是 
                    <input type="radio" name="market" value="N" checked>
                    否 </td>
               <%        }     %>     
                </tr>
                <tr> 
                  <td width="137" class="dan10">是否接受即时通知</td>
                  <td width="363" class="dan10"> 
                <% if(str[1].equals("Y")){  %>
                    <input type="radio" name="now" value="Y" checked>
                    是 
                    <input type="radio" name="now" value="N" >
                    否 </td>
               <%   }else{     %>
                    <input type="radio" name="now" value="Y">
                    是 
                    <input type="radio" name="now" value="N" checked>
                    否 </td>
               <%        }     %>   
                </tr>
                <tr> 
                  <td width="137" class="dan10" bgcolor="#E6EDFB">是否接受每日摘要</td>
                  <td width="363" class="dan10" bgcolor="#E6EDFB"> 
                     <% if(str[2].equals("Y")){  %>
                    <input type="radio" name="day" value="Y" checked>
                    是 
                    <input type="radio" name="day" value="N" >
                    否 </td>
               <%   }else{     %>
                    <input type="radio" name="day" value="Y">
                    是 
                    <input type="radio" name="day" value="N" checked>
                    否 </td>
               <%        }     %>   
                </tr>
         --> 
        <tr> 
          <td width="137" class="dan10">是否接受email通知</td>
          <td width="363" class="dan10"> <% if(str[3].equals("Y")){  %> 
            <input type="radio" name="email" value="Y" checked>
            是 
            <input type="radio" name="email" value="N" >
            否 </td>
          <%   }else{     %> 
          <input type="radio" name="email" value="Y">
          是 
          <input type="radio" name="email" value="N" checked>
          否 </td>
        <%        }     %> </tr>
        <tr> 
          <td width="137" class="dan10" bgcolor="#E6EDFB">抄送的Email地址</td>
          <td width="363" class="dan10" bgcolor="#E6EDFB"> 
            <input type="text" name="ccemail" value="<%=str[4]%>" onBlur="valid(1)">
          </td>
        </tr>
        <tr> 
          <td width="137" class="dan10">默认的报价有效期</td>
          <td width="363" class="dan10"> 
            <input type="text" name="bj" value="<%=str[5]%>" size="6" onBlur="valid(2)">
            天 </td>
        </tr>
        <!--           
                <tr> 
                  <td width="137" class="dan10" bgcolor="#E6EDFB">默认的订单有效期</td>
                  <td width="363" class="dan10" bgcolor="#E6EDFB"> 
                    <input type="text" name="dd" value="<%=str[6]%>" size="6" onBlur="valid(3)">
                    天 </td>
    --> </tr>
        <tr> 
          <td width="137" class="dan10" >默认货币</td>
          <td width="363" class="dan10" > 
            <select name="money" >
              <option value="<%=str[7]%>" ><%=str_value%></option>
              <% 
                       st="select str_value from parameter where id=1 and lang_code='"+lang_code+"'";
                       myFind.setSqlStc(st);
                       rs=myFind.getAllData();
                      
                       while(rs.next()){ 
                          st=rs.getString("str_value");     %> 
              <option value="<%=st%>" ><%=st%></option>
              <% } 
                            myFind.disconn();
                         %> 
            </select>
          </td>
        </tr>
        <tr> 
          <td width="137" class="dan10" bgcolor="#E6EDFB">默认语言</td>
          <td width="363" class="dan10" bgcolor="#E6EDFB"> 
            <select name="langua">
              <option value="<%=str[8]%>"><%=lang%></option>
              <%
                       st="select * from lang_desc ";
                       myFind.setSqlStc(st);
                       rs=myFind.getAllData();    
                       while(rs.next()){
                     %> 
              <option value="<%=rs.getString("lang_code")%>"><%=rs.getString("descr")%></option>
              <%      }
                        myFind.disconn();
                           %> 
            </select>
          </td>
        </tr>
        <tr> 
          <td width="137" class="dan10" >默认制式</td>
          <td width="363" class="dan10" > 
            <select name="zs">
              <option value="<%=str[9]%>" ><%=currency_id%></option>
              <option value="M"> 公 制 </option>
              <option value="I"> 英 制 </option>
            </select>
          </td>
        </tr>
        <!--          
                <tr bgcolor="#E6EDFB"> 
                  <td width="137" class="dan10" bgcolor="#E6EDFB">默认的船运地点</td>
                  <td width="363" class="dan10" bgcolor="#E6EDFB"> 
                    <select name="ship">
                         <option value="<%=str[10]%>" ><%=ship%></option>
               <% 
                       st="select str_value,code from parameter where id=4 and lang_code='"+lang_code+"'";
                       myFind.setSqlStc(st);
                       rs=myFind.getAllData();
                      
                       while(rs.next()){ 
                        st=rs.getString("str_value");
                        String co=rs.getString("code");
                               %>  
                <option value="<%=co%>" ><%=st%></option>         
                            <% } 
                            myFind.disconn();
                            
                        }catch(Exception e){  e.printStackTrace();  }  %>           
                    </select>
                  </td>
                </tr>
        --> 
        <tr> 
          <td colspan="2" height="22"> 
            <div align="right"> 
              <input type="hidden" name="nextdo" value="modimer">
              <input type="submit" name="Submit" value="提 交">
              <img src="../images/space.gif" width="50" height="1" border="0"> 
              <input type="reset" name="Submit2" value="重 置">
              <img src="../images/space.gif" width="50" height="1" border="0"> 
              <input type="button" name="submit3" value="返 回" onClick="reload()">
              <img src="../images/space.gif" width="50" height="1" border="0"> 
            </div>
          </td>
        </tr>
      </table></td></tr>
    </table>
  </form> </td></tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<% myFind.destroy();%>
</jsp:useBean>
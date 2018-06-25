<%@ page import="java.sql.*" language="java" %>
 <jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
 
<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>

 
<%  String user_id=UserInfo.getUserId();  
    String duan=UserInfo.getForgetPwd();  %>

<script language="JavaScript"> <!--
    function mima(){
 <% if(!duan.equals("forget")){ %> 
       if(putin.mmold.value==''){
          alert('请输入您的旧密码后提交!')
            return false     
                 }
 <%   }      %>                
       if(putin.newm.value==''){
          alert('请输入您的新密码!')
              return false  
                 }          
       if(putin.newm.value!=putin.oldm.value){
          alert('新密码与确认密码不符,请重新输入!');
                 return false    
                     }
         return true
              }
    function reload(){
      window.history.back()
                }
                
      
 //--></script>
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
    </td>
    <td valign="top"> 
      <form method="get" action="xiugaisucess.jsp" name="putin" onSubmit="return mima();">
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="128"> 
              <table width="500" border="0" cellspacing="1" cellpadding="4">
                <tr> 
                  <td colspan="2" height="25" bgcolor="#4078E0"><font color="#FFFFFF">修改密码</font></td>
                </tr>
                <% if(!duan.equals("forget")){ %> 
                <tr> 
                  <td align="right" class="dan10" width="247" bgcolor="#E6EDFB" height="17">输入旧密码:</td>
                  <td width="231" bgcolor="#E6EDFB" height="17"> 
                    <input type="password" name="mmold">
                  </td>
                </tr>
                <% }  %> 
                <tr> 
                  <td align="right" class="dan10" width="247">新密码:</td>
                  <td width="231"> 
                    <input type="password" name="newm">
                  </td>
                </tr>
                <tr> 
                  <td align="right" class="dan10" width="247" bgcolor="#E6EDFB">确认密码:</td>
                  <td width="231" bgcolor="#E6EDFB"> 
                    <input type="password" name="oldm" >
                  </td>
                </tr>
                <tr align="center"> 
                  <td colspan="2"> <% if(!duan.equals("forget")){ %> 
                    <input type="hidden" name="nextdo" value="modimima">
                    <%  }else{  %> 
                    <input type="hidden" name="nextdo" value="forgetmima">
                    <% }   %> 
                    <input type="submit" name="Submit" value="提 交">
                    <img src="../images/space.gif" width="60" height="1"> 
                    <input type="reset" name="Submit2" value="重 设">
                    <img src="../images/space.gif" width="60" height="1"> 
                    <input type="button" name="Submit3" value="返 回" onClick="reload()">
                  </td>
                </tr>
              </table>
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

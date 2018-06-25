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
<%@ page import="java.sql.*" language="java" %> <%! String[] str=new String[14]; String ss1,ss2,ss3;   %> 
 <jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<%  if (!UserInfo.getAuthorized()){
%> <jsp:forward page="notAuthorized.jsp" /> </jsp:forward> <%    }
%> 
<jsp:useBean id="myFind" scope="page" class="postcenter.newRegister" />
<script language="JavaScript">

function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=355')
}

</script>
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
  <%   
       
       String st,user_id,lg,title,dept;
       title="";dept="";
       ResultSet rs;
       user_id=UserInfo.getUserId();
       lg="GB";
       String duan=UserInfo.getForgetPwd();
       String status=request.getParameter("status");
       if(status.equals("store")){
   %> <jsp:useBean id="newFind" scope="page" class="postcenter.newRegister" /> 
  <%    
         str[0]=request.getParameter("first_name");
         str[1]=request.getParameter("last_name");
         str[2]=request.getParameter("address1");
          str[3]=request.getParameter("address2");        
         str[4]=request.getParameter("dept");
          str[5]=request.getParameter("job_title");
         str[6]=request.getParameter("country");
          str[7]=request.getParameter("state");
         str[8]=request.getParameter("city");
         str[9]=request.getParameter("postcode");
         str[10]=request.getParameter("tel");
          str[11]=request.getParameter("fax");
          str[12]=request.getParameter("email");
         str[13]=request.getParameter("mobile");
         st="update users_l set first_name='"+str[0]+"',last_name='"+str[1]+"',address1='"+str[2]
             +"',address2='"+str[3]+"' where user_id="
             +user_id+" and lang_code='"+lg+"'";
        newFind.setUpdate(st);
        newFind.getAllUpdate();
        newFind.disconn();
        st="update users set country_id="+str[6]+",state_id="+str[7]+",city_id="+str[8]
            +",postcode='"+str[9]+"',tel='"+str[10]+"',fax='"+str[11]+"',email='"+str[12]
            +"',mobile='"+str[13]+"',job_titleid='"+str[5]+"',dept_id='"+str[4]+"' where user_id="+user_id;
         newFind.setUpdate(st);   
        newFind.getAllUpdate();
        newFind.disconn();   
        newFind.destroy();
          }  %> <%   st="select * from users_l where user_id="+user_id+" and lang_code='"+lg+"'";
       myFind.setSqlStc(st);
       rs=myFind.getAllData();
       
       if(rs.next()){ 
               str[0]=rs.getString("first_name");
               str[0]=str[0]==null?"":str[0];
               str[1]=rs.getString("last_name");
               str[1]=str[1]==null?"":str[1];
               str[2]=rs.getString("address1");
               str[2]=str[2]==null?"":str[2];
               str[3]=rs.getString("address2");
               str[3]=str[3]==null?"":str[3];

               
                         }
        myFind.disconn();
        st="select country_id,state_id,city_id,postcode,tel,fax,email,mobile,job_titleid,dept_id from users where user_id="+user_id;
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next()){
               str[4]=rs.getString("dept_id");
               str[4]=str[4]==null?"":str[4];
               str[5]=rs.getString("job_titleid");
               str[5]=str[5]==null?"":str[5];
               str[6]=rs.getString("country_id");
               str[6]=str[6]==null?"":str[6];
               str[7]=rs.getString("state_id");
               str[7]=str[7]==null?"":str[7];
               str[8]=rs.getString("city_id");
               str[8]=str[8]==null?"":str[8];
               str[9]=rs.getString("postcode");
               str[9]=str[9]==null?"":str[9];
               str[10]=rs.getString("tel");
               str[10]=str[10]==null?"":str[10];
               str[11]=rs.getString("fax");
               str[11]=str[11]==null?"":str[11];
               str[12]=rs.getString("email");
               str[12]=str[12]==null?"":str[12];
               str[13]=rs.getString("mobile");
               str[13]=str[13]==null?"":str[13];
               ss1=str[6];
               ss2=str[7];
               ss3=str[8];
               title=str[5];dept=str[4];
                         }
        myFind.disconn();
        st="select str_value from parameter where id=7 and lang_code='"+lg+"' and code='"+str[4]+"'";
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next()){
           str[4]=rs.getString("str_value");           
        }   
        str[4]=str[4]==null?"":str[4];
        myFind.disconn();
        st="select str_value from parameter where id=11 and lang_code='"+lg+"' and code='"+str[5]+"'";
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next()){
            str[5]=rs.getString("str_value");           
        }
        str[5]=str[5]==null?"":str[5];    
        myFind.disconn();        
        st="select name from country where country_id='"+str[6]+"' and lang_code='"+lg+"'";
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next())str[6]=rs.getString("name");
        myFind.disconn();
        st="select name from state where state_id='"+str[7]+"' and lang_code='"+lg+"'";
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next()){
           str[7]=rs.getString("name");           
        }   
        if(str[7]==null||str[7].equals("0")){
           str[7]="";
        }        
        myFind.disconn();
        st="select name from city where city_id='"+str[8]+"' and lang_code='"+lg+"'";
        myFind.setSqlStc(st);
        rs=myFind.getAllData();
        if(rs.next()){
           str[8]=rs.getString("name");                     
           
        }  
        str[8]=str[8]==null?"":str[8];
        str[8]=str[8].equals("0")?"":str[8]; 
        myFind.disconn();               
        myFind.destroy();        
                      %> <form method="post" action="profile.jsp"> 
  <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
    <tr bordercolor="#FFFFFF"> <td height="195">
      <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="3" height="25" bgcolor="#4078E0"><font color="#FFFFFF">个人资料</font></td>
        </tr>
        <tr> 
          <td rowspan="11" width="315"> 
            <table width="357" border="0" cellspacing="1" cellpadding="4">
              <tr> 
                <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">姓氏：</td>
                <td width="251" bgcolor="#E6EDFB" class="dan10"><%=str[1]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" class="dan10"><span class="font10"><span class="dan10">名称</span></span>：</td>
                <td width="251" class="dan10"><%=str[0]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">国家：</td>
                <td width="251" bgcolor="#E6EDFB" class="dan10"><%=str[6]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" class="dan10">省或州：</td>
                <td width="251" class="dan10"><%=str[7]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">城市：</td>
                <td width="251" bgcolor="#E6EDFB" class="dan10"><%=str[8]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" class="dan10">地址1：</td>
                <td width="251" class="dan10"><%=str[2]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" class="dan10">地址2：</td>
                <td width="251" class="dan10"><%=str[3]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">邮编：</td>
                <td width="251" bgcolor="#E6EDFB" class="dan10"><%=str[9]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" class="dan10">电话：</td>
                <td width="251" class="dan10"><%=str[10]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" class="dan10">移动电话：</td>
                <td width="251" class="dan10"><%=str[13]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">传真：</td>
                <td width="251" bgcolor="#E6EDFB" class="dan10"><%=str[11]%></td>
              </tr>
              <tr> 
                <td width="104" align="center"><span class="dan10"><span class="font10"><span class="dan10">Email</span>：</span></span></td>
                <td width="251" class="dan10"><%=str[12]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">工作部门：</td>
                <td width="251" bgcolor="#E6EDFB" class="dan10"><%=str[4]%></td>
              </tr>
              <tr> 
                <td width="104" align="center" height="25" class="dan10">工作职务：</td>
                <td width="251" class="dan10"><%=str[5]%></td>
              </tr>
              <tr bgcolor="#E6EDFB"> 
                <td colspan="2" align="center" height="25" class="dan10"> 
                  <input type="hidden" name="a0" value="<%=str[0]%>" >
                  <input type="hidden" name="a1" value="<%=str[1]%>" >
                  <input type="hidden" name="a2" value="<%=str[2]%>" >
                  <input type="hidden" name="a3" value="<%=str[3]%>" >
                  <input type="hidden" name="a4" value="<%=str[4]%>" >
                  <input type="hidden" name="a5" value="<%=str[5]%>" >
                  <input type="hidden" name="a6" value="<%=str[6]%>" >
                  <input type="hidden" name="a7" value="<%=str[7]%>" >
                  <input type="hidden" name="a8" value="<%=str[8]%>" >
                  <input type="hidden" name="a9" value="<%=str[9]%>" >
                  <input type="hidden" name="a10" value="<%=str[10]%>" >
                  <input type="hidden" name="a11" value="<%=str[11]%>" >
                  <input type="hidden" name="a12" value="<%=str[12]%>" >
                  <input type="hidden" name="a13" value="<%=str[13]%>" >
                  <input type="hidden" name="ss1" value="<%=ss1%>" >
                  <input type="hidden" name="ss2" value="<%=ss2%>" >
                  <input type="hidden" name="ss3" value="<%=ss3%>" >
                  <input type="hidden" name="title" value="<%=title%>" >
                  <input type="hidden" name="dept" value="<%=dept%>" >
                  <input type="submit" name="Submit2" value="编辑个人资料">
                </td>
              </tr>
            </table></form></td>
        <td rowspan="11" background="../images/dian.gif" width="1"><img src="../images/space.gif" width="1" height="1"></td>
        <form method="post" action="profile_moren.jsp">
          <td width="121" height="25"> <img src="../images/space.gif" width="20" height="1"> 
            <input type="image" border="0" name="imageField2" src="../images/mrzhshd.gif" width="86" height="22">
          </td>
        </form>
        </tr>
        <tr> 
          <form method="post" action="profile_xiugmima.jsp" >
            <td width="121" height="25"> 
              <input type="hidden" name="duan" value="<%=duan%>">
              <img src="../images/space.gif" width="20" height="8"> 
              <input type="image" border="0" name="imageField3" src="../images/xgmm.gif" width="86" height="22">
            </td>
          </form>
        </tr>
        <tr> 
          <form method="post" action="mywatchlist.jsp" >
            <td width="121" height="25"> 
              <input type="hidden" name="donext" value="ok">
              <img src="../images/space.gif" width="20" height="1"> 
              <input type="image" border="0" name="imageField4" src="../images/khlb.gif" width="86" height="22">
            </td>
          </form>
        </tr>
        <tr> 
          <td width="121" height="25"> <img src="../images/space.gif" width="20" height="1" border="0"> 
            <a href="chenqingchhy_reg.jsp?user_id=<%=user_id%>"><img src="../images/shenqingcwmf.gif" width="86" height="22" border="0"></a> 
          </td>
        </tr>
        <tr> 
          <td width="121" height="25"> <img src="../images/space.gif" width="20" height="1" border="0"> 
            <a href="#" onClick="return toaction('本页面正在加紧建设，不久即将开通。不便之处，敬请原谅。');"><img src="../images/setupyourgroup.gif" width="86" height="22" border="0"></a> 
          </td>
        </tr>
        <tr> 
          <td width="121" height="25">&nbsp;</td>
        </tr>
        <tr> 
          <td width="121" height="25">&nbsp;</td>
        </tr>
        <tr> 
          <td width="121" height="25">&nbsp;</td>
        </tr>
        <tr> 
          <td width="121" height="25">&nbsp;</td>
        </tr>
        <tr> 
          <td width="121">&nbsp;</td>
        </tr>
      </table></td></tr>
  </table>
  </jsp:useBean> </td></tr>
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
<script>
  function toaction(con){
     return confirm(con);
   
  }
</script>
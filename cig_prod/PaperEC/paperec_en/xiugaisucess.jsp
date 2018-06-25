<%@ page import="java.sql.*,postcenter.*" language="java" %>
<%! String outpr;int ot;  %>
<jsp:useBean id="myFind" scope="page" class="postcenter.newRegister"/>
<jsp:useBean id="exect" scope="page" class="postcenter.ExecThread"/>
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />

<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>
  

<html>
<head>
<title>ÎÒµÄÖ½Íø--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font10 {  font-size: 11px; line-height: 14pt; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.font9 {  font-size: 13px; font-family: "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 12px; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  text-decoration: none}
a:visited {  text-decoration: none}
a:active {  text-decoration: none}
a:hover {  color: #330099; text-decoration: underline}
.dan10 {  font-size: 10px; font-family: "Arial", "Helvetica", "sans-serif"}
.balck14 {  font-size: 12px; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
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
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1"> 
        <form name="moveBarForm" method="post" action="postcenter/demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../images/images_en/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="postcenter/product_list.jsp" class="font9"><font color="#000000">Offer 
                      to Sell</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="postcenter/request2buy.jsp"><font color="#000000">Request 
                      to Buy</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="postcenter/order_search.jsp"><font color="#000000">Browse 
                      Trading Floor</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="mycustomer.jsp"><font color="#000000">My 
                      Customers</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="postcenter/product_list.jsp"><font color="#000000">My 
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
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="jiaoyifu.htm"><font color="#FFFFFF">Services</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('huansuanresult.jsp')"><font color="#FFFFFF">Metric 
                      Converter</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../../images/images_en/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </td>
    <%   String user_id=UserInfo.getUserId();
     String nextdo=request.getParameter("nextdo");
     String st;int ii=0;
     String login="";String time="";
     try{     
         if(nextdo.equals("modimima")){
        
         String mmold=request.getParameter("mmold");
         st="select login,passwd,to_char(sysdate,'YYYY-MM-DD HH:MI:SS') da from users where user_id="+user_id;
         myFind.setSqlStc(st);
         ResultSet rs=myFind.getAllData();
         if(rs.next()){
            login=rs.getString("login");
            st=rs.getString("passwd");
            time=rs.getString("da");
         }   
         myFind.disconn();
         if(st.equals(mmold)) {
            String st1=request.getParameter("newm");
            st="update users set passwd='"+st1+"' where user_id="+user_id ;
            myFind.setUpdate(st);
            ii=myFind.getAllUpdate();
            myFind.disconn();
           if(ii>0){   
             ExecThread exect1=exect.getInstance(login,st,time,1);  
             exect1.start();           
             outpr="Your password has been modified rightly!";            
           }else{
             outpr="Sorry!System error,please try again for a moment.";
           }
            ot=2;               
            
         }else{  ot=1;
                     outpr="Your old password is incorrect!";
         }
         }
            
            
            if(nextdo.equals("forgetmima")){  
        
            String st1=request.getParameter("newm");
            st="update users set passwd='"+st1+"' where user_id="+user_id ;
            myFind.setUpdate(st);
            ii=myFind.getAllUpdate();
            myFind.disconn();
            
            st="select login,to_char(sysdate,'YYYY-MM-DD HH:MI:SS') da from users where user_id="+user_id;
            myFind.setSqlStc(st);
            ResultSet rs=myFind.getAllData();         
            if(rs.next()){              
              login=rs.getString("login");
              time=rs.getString("da");
             }
            myFind.disconn();
            if(ii>0){
               ExecThread exect2=exect.getInstance(login,st1,time,1);  
               exect2.start();
               outpr="Your password has been modified rightly!";
            }else{
               outpr="Sorry!System error,please try again for a moment.";
            }
            ot=2;               
            }
            
            
            
            if(nextdo.equals("modimer")){
               String str[]=new String[11];               
               str[3]=request.getParameter("email");
               str[4]=request.getParameter("ccemail");
               str[5]=request.getParameter("bj");              
               str[7]=request.getParameter("money");
               str[8]=request.getParameter("langua");
               str[9]=request.getParameter("zs");
               
               st="update users set email_info='"+str[3]+"',cc_email='"+str[4]+"',bid_vday="+str[5]
                  +",currency_id='"+str[7]+"',def_lang_code='"+str[8]+"',measure='"+str[9]+"' where user_id="+user_id;
               myFind.setUpdate(st);
               ii=myFind.getAllUpdate();   
               myFind.disconn();
               
               ot=2;
               outpr=ii>0?"Your default settings have been modified!":"Internal server error.  Please retry in a moment!";          
              
              
            }
                myFind.destroy();      
        }catch(Exception e){  %> <% e.printStackTrace();}  
  %> 
    <SCRIPT lANGUAGE="JavaScript"><!--
 function reload(e){
  window.history.back()
  if(e==2){
  window.history.back()
           }
        }
// --></SCRIPT>
    <td valign="top"> 
      <form method="post" action="" >
        <table width="484" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF" valign="top"> 
            <td height="172"> 
              <table width="500" border="0" cellspacing="0" cellpadding="0" align="left">
                <tr align="center" bgcolor="#E6EDFB"> 
                  <td class="font9" height="185"><%=outpr%></td>
                </tr>
                <tr bgcolor="#4078E0" align="center"> 
                  <td height="25"> 
                    <input type="submit" name="Submit2" value="Back" ONCLICK="reload(<%=ot%>)">
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
          <td><img src="../../images/images_en/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
</jsp:useBean>
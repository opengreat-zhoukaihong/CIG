<%@ page language="java"%>  
<%@ page import="java.util.*, java.sql.*,java.io.*"%> 

<jsp:useBean id="beco" scope="page" class="postcenter.newRegister" />   
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
<%  String[] arr=new String[33];
    //String user_id=UserInfo.getUserId();
    String country=request.getParameter("country");    
    String state=request.getParameter("state");
    String city=request.getParameter("city");
    String bankcountry=request.getParameter("bankcountry");    
    String bankstate=request.getParameter("bankstate");
    String bankcity=request.getParameter("bankcity");
    String user_id=request.getParameter("user_id");    
    arr[0]=user_id;arr[1]=request.getParameter("full_name");    
    arr[10]=request.getParameter("iso");arr[11]=request.getParameter("url");
    arr[12]=request.getParameter("address1");arr[13]=country+"  "+state+"  "+city+"  "+request.getParameter("address2");
    arr[14]=request.getParameter("postcode"); arr[15]=request.getParameter("fax");
    arr[16]=request.getParameter("tel");arr[17]=request.getParameter("email");
    arr[18]=request.getParameter("sell_prod_id");
    arr[19]=request.getParameter("cont_f_name");arr[20]=request.getParameter("cont_title");
    arr[21]=request.getParameter("regi_addr");arr[22]=request.getParameter("year_founded");  
    arr[23]=request.getParameter("account_title");arr[24]=request.getParameter("local_bank");
    arr[25]=request.getParameter("bank_address1");arr[26]=bankcountry+"  "+bankstate+"  "+bankcity+"  "+request.getParameter("bank_address2");
    arr[27]=request.getParameter("bank_postcode");arr[28]=request.getParameter("account_type");
    arr[29]=request.getParameter("rel_length");arr[30]=request.getParameter("bank_f_officer");
    arr[31]=request.getParameter("bank_tel");arr[32]="EN";
    for(int i=0;i<33;i++)if(arr[i]==null)arr[i]="";     
    String st3=beco.getBecomeS(arr);
    String title="";
    String detial="";  
                     
                     if(st3.equals("ok")){   
                         String m_title ="";
                         String last_name ="";
                         String st2="select title,last_name from users a,users_l b where a.user_id='"+user_id+"' and a.user_id=b.user_id and b.lang_code='EN'";
                         beco.setSqlStc(st2);
                         ResultSet rs=beco.getAllData();
                         if(rs.next()){ 
                             m_title = rs.getString("title");
                             last_name = rs.getString("last_name"); 
                         }
                         beco.disconn();         

                         if (m_title.equals("G")) 
                             m_title = "Dr. ";
                         else if (m_title.equals("S")) 
                             m_title = "Ms. ";
                         else 
                             m_title = "Mr. ";
                                                        
                    

                         title="Congratulations! You are now a Verified Seller of PaperEC.com.";
                         detial="Dear "+m_title+last_name+","+
                                    "\n\nCongratulations! You are now able to sell your products on PaperEC.com. "+
                                    "\n\nIn addition to the standard services of PaperEC.com, as a seller you can "+
				    "also:"+
				    "\n1) Establish a data bank for the products you wish to sell on PaperEC.com;"+
				    "\n2) Post an \"Offer to Sell\" your pulp and paper products;"+
				    "\n3) Post an offer on a \"Request to Buy\" posting on PaperEC.com;"+
				    "\n4) Engage in transactions when buyers reply to you offers; and,"+
				    "\n5) Only incur a small fee when you successfully conclude a transaction."+
				    "(See details in Membership Agreement)"+
				    "\n\nPaperEC.com has provided you with a shortcut---\"My ProductProfile\" to "+
				    "post your offer to sell conveniently. In \"My ProductProfile\", you can "+
				    "establish your own data bank of products, use Chinese and English "+
				    "brand names, product origin, product type, product specification etc."+
				    "In this way, you can post an offer easily."+
				    "\n\nPaperEC provides two ways to sell pulp and paper products: (1) post your "+
				    "offer for buyers to view, or (2) search \"Request to Buy\" postings and "+
				    "post offers to sell your products on the matched results. Either way is "+
				    "simple and easy. Upon receipt of the buyer's response, PaperEC will "+
				    "notify you automatically through email."+
				    "\n\nA \"Transaction Demo\" is available on the homepage of PaperEC.com. If you "+
				    "have any questions, please click on \"Help\". You may also call us during "+
				    "the working hours of Monday through Friday. "+
                                    "\n\n\n\n  Best Regards, "+
                                    "\n\n  PaperEC.com"+
                                    "\n  Tel:+86 755-369-1610, 3691613"+ 
                                    "\n  Fax:+86 755-320-1877"+
                                    "\n  Email:members@paperec.com"+
                                    "\n\n  http://www.paperec.com"; 
                                    
                                    
                         inqu.setUser_id(user_id);                                        
                         inqu.setTitle(title);
                         inqu.setDetail (detial);
                         inqu.getSingleMess(); 
                     }     
%>
<html>
<head>
<title>ÎÒµÄÖ½Íø--PaperEC.com</title>
<SCRIPT LANGUAGE="JavaScript"><!--
 function reload(){
  window.history.back()
            }
// --></SCRIPT>
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
.dan10 {  font-size: 12px; font-family: "Arial", "Helvetica", "sans-serif"}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 13px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
.balck14 {  font-size: 12px; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr>
    <td width="159"> 
    <script language="JavaScript" src="../../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:263px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="141" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td> 
              <table width="142" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000" align="center">
                <tr align="center"> 
                  <td width="139" height="22" bgcolor="#503CC0"><b><font color="#FFFFFF" size="2" face="Verdana, Arial, Helvetica, sans-serif">Registration</font></b></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25"><a href="bbs/BBSListlogin.jsp?area_ID=3" class="dan10">Equipment</a></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25" ><a href="bbs/BBSListlogin.jsp?area_ID=4" class="dan10">Jobs</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0" ><a href="registerInfo.htm" class="white10">Membership 
                    Agreement</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../../html/html_en/aboutus/policy.htm" class="white10">Privacy 
                    Policy</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../../html/html_en/aboutus/copyright.htm" class="white10">Copyright</a></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../../images/images_en/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div></td>
      <td valign="top"> 
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
                       
           <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="left">
     <% if(st3.equals("ok")){   %>           
                  <td height="200" class="font9" > 
                  Congratulations! You are now able to sell your products on PaperEC.com.
   PaperEC.com welcomes all enterprises and traders to buy and sell pulp and 
   paper products on PaperEC.com. PaperEC.com will provide more and more personalized
   online solutions to meet your increasingly business needs. 
                  </td>
     <%  }else{    %>
                  <td height="200" class="font9"><%=st3%></td>
     <%   }   %>                      
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <a href="login.htm">Back to Home Page </a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
         </table>
        <div align="center"></div>
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/dline.gif" width="776" height="6"></td>
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
  
<% beco.destroy();  %>     
<% inqu.getDestroy(); %>
</jsp:useBean>
<%--  @# product_list.jsp EN Ver.1.0 --%>

<%@ page import="java.sql.*" language="java"%>

<jsp:useBean id="oFind" scope="page" class="postcenter.newRegister" />
<jsp:useBean id="newFind" scope="page" class="postcenter.newRegister" />
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>


     <%  String user_id=UserInfo.getUserId();
         String lang_code="EN"; 
         String posting_id=request.getParameter("postingId");
      %>
<html>
<head>
<title>�ҵ�ֽ��--PaperEC.com</title>
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
      <div style="position:absolute; width:141px; height:263px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <form name="moveBarForm" method="post" action="demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../../images/images_en/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="product_list.jsp" class="font9"><font color="#000000">Offer to Sell</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="request2buy.jsp"><font color="#000000">Request to Buy</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="order_search.jsp"><font color="#000000">Browse Trading Floor</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">My Customers</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="product_list.jsp"><font color="#000000">My ProductProfiler</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">Search by ID#</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="Go">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('../foreignX.htm')"><font color="#FFFFFF">Currency Converter</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="../jiaoyifu.htm"><font color="#FFFFFF">Services</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('../huansuanresult.jsp')"><font color="#FFFFFF">Metric Converter</font></a></td>
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
      </div></td>
    <td valign="top"> 
      <form name="mainForm" method="post" action="prodInfo.jsp">
        <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="145"> 
              <table width="600" border="0" cellspacing="1" cellpadding="2">
                <tr bgcolor="#4078E0"> 
                  <td colspan="8" height="25"><font color="#FFFFFF" class="font9">My 
                    ProductProfiler</font></td>
                </tr>
                <tr align="center" bgcolor="#7EA2EB"> 
                  <td width="88" class="white10">Name</td>
                  <td width="90" class="white10">Product</td>
                  <td width="88" class="white10">Type</td>
                  <td width="63" class="white10">Grade</td>
                  <td width="75" class="white10">Brand</td>
                  <td width="68" class="white10">Origin</td>
                  <td width="67">&nbsp;</td>
                  <td width="61">&nbsp;</td>
                </tr>

     <% try{   
               String ss="select product_id,product_name,brand_id,prod_coun_id,prod_state_id,prod_city_id,grade_id,cate_id,type_id  from per_prod where company_id in (select company_id from users where user_id="+user_id +")";
               oFind.setSqlStc(ss);
               ResultSet rsn;
               String[] st=new String[9];
               ResultSet rs=oFind.getAllData(); 
               while(rs.next()){
                  st[0]=rs.getString("product_name");
                  st[1]=rs.getString("brand_id");                  
                  st[2]=rs.getString("cate_id");
                  st[3]=rs.getString("type_id");
                  st[4]=rs.getString("grade_id");
                  st[5]=rs.getString("prod_coun_id");
                  st[6]=rs.getString("prod_state_id");
                  st[7]=rs.getString("prod_city_id"); 
                  st[8]=rs.getString("product_id"); 
                                     %>
                                     
               <%    ss="select str_value from parameter where id=12 and lang_code='"+lang_code+"' and code='"+st[1]+"'";
                  newFind.setSqlStc(ss);
                  rsn=newFind.getAllData();
                  if(rsn.next())st[1]=rsn.getString("str_value");
                  newFind.disconn();
                  ss="select cate_name from prod_category where cate_id="+st[2]+" and lang_code='"+lang_code+"'";
                  newFind.setSqlStc(ss);
                  rsn=newFind.getAllData();
                  if(rsn.next())st[2]=rsn.getString("cate_name");
                  newFind.disconn();                         
                  ss="select type_name from prod_type where type_id="+st[3]+" and lang_code='"+lang_code+"'";
                  newFind.setSqlStc(ss);
                  rsn=newFind.getAllData();
                  if(rsn.next())st[3]=rsn.getString("type_name");
                  newFind.disconn();
                  ss="select grade_name from prod_grade where grade_id="+st[4]+" and lang_code='"+lang_code+"'";
                  newFind.setSqlStc(ss);
                  rsn=newFind.getAllData();
                  if(rsn.next())st[4]=rsn.getString("grade_name"); 
                  newFind.disconn();
                  String gd="";
                  ss="select name from country where country_id="+st[5]+" and lang_code='"+lang_code+"'";
                  newFind.setSqlStc(ss);
                  rsn=newFind.getAllData();
                  if(rsn.next())st[5]=rsn.getString("name"); 
                  newFind.disconn();           
                  ss="select name from state where state_id="+st[6]+" and lang_code='"+lang_code+"'";
                  newFind.setSqlStc(ss);
                  rsn=newFind.getAllData();
                  if(rsn.next())gd=rsn.getString("name");
                  if(gd!=null)st[5]=gd+" "+st[5];
                  newFind.disconn(); 
                  ss="select name from city where city_id="+st[7]+" and lang_code='"+lang_code+"'";
                  newFind.setSqlStc(ss);
                  rsn=newFind.getAllData();
                  if(rsn.next())gd=rsn.getString("name");
                  if(gd!=null)st[5]=gd+" "+st[5];                
                  newFind.disconn();
                  
                  if (st[0] == null) st[0] = " "; 
                  if (st[1] == null) st[1] = " ";
                  if (st[2] == null) st[2] = " ";
                  if (st[3] == null) st[3] = " ";
                  if (st[4] == null) st[4] = " ";
                  if (st[5] == null) st[5] = " ";
                  if (st[6] == null) st[6] = " ";
                  if (st[7] == null) st[7] = " ";
                  if (st[8] == null) st[8] = " ";
                                                        %>              
                                  
                <tr bgcolor="#E6EDFB"> 
                  <td width="88" align="center" class="dan10"><%=st[0]%></td>
                  <td width="90" align="center" class="dan10"><%=st[2]%></td>
                  <td width="88" align="center" class="dan10"><%=st[3]%></td>
                  <td width="63" align="center" class="dan10"><%=st[4]%></td>
                  <td width="75" align="center" class="dan10"><%=st[1]%></td>
                  <td width="68" align="center" class="dan10"><%=st[5]%></td>
                  <td width="67" align="center" class="dan10"><a href="prodInfo.jsp?editPage=true&productId=<%=st[8]%>"><font color="#4078E0">Edit</font></a></td> 
                  <td width="67" align="center" class="dan10"><a href="offer2sale.jsp?productId=<%=st[8]%>&requestPostingId=<%=posting_id%>"><font color="#4078E0">Post</font></a></td> 
                </tr>
                
           <%         }
                  newFind.destroy();
                  oFind.disconn();
                  oFind.destroy();               
                     }catch(Exception e){
                      e.printStackTrace();   }  %>                            
                <tr bgcolor="#E6EDFB"> 
                  <td colspan="8" align="center">
                    <input type="submit" name="Submit4" value="New Product">
                    <img src="../../../images/images_en/space.gif" width="100" height="1"> 
                    <input type="submit" name="Submit5" value="Back" onClick="javascript:window.history.go(-1)">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </form>
    </td>
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
</jsp:useBean>
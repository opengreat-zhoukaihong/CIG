                  
<%@ page import="java.sql.*" language="java" %>
<%! Vector v=new Vector();  Vector v_id=new Vector();
    Vector v4=new Vector(); Vector v44=new Vector();
    Vector v5=new Vector(); Vector v55=new Vector();
    int i; ResultSet allData,stateData,cityData;String st1,st,ss1,ss2,ss3;%>
<jsp:useBean id="myFind" scope="page" class="postcenter.newRegister" /> 
<jsp:useBean id="myFind1" scope="page" class="postcenter.newRegister" /> 
<jsp:useBean id="myFind2" scope="page" class="postcenter.newRegister" /> 
 <jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />   

<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>


<%  String str[]=new String[14];
    str[0]=request.getParameter("a0");
    str[1]=request.getParameter("a1");
    str[2]=request.getParameter("a2");
    str[3]=request.getParameter("a3");
    str[4]=request.getParameter("a4");
    str[5]=request.getParameter("a5");
    str[6]=request.getParameter("a6");
    str[7]=request.getParameter("a7");
    str[8]=request.getParameter("a8");
    str[9]=request.getParameter("a9");
    str[10]=request.getParameter("a10");
    str[11]=request.getParameter("a11");
    str[12]=request.getParameter("a12"); 
     str[13]=request.getParameter("a13");
     ss1=request.getParameter("ss1");
     ss2=request.getParameter("ss2");
     ss3=request.getParameter("ss3");
    String title=request.getParameter("title");
    String dept=request.getParameter("dept");
    String user_id=UserInfo.getUserId();
    String s="GB";   
               %> 
    
   <jsp:setProperty name="myFind" property="sqlStc" value="select name,country_id from country where lang_code='EN'" />
   <% try{    String sele="";String pub="";String pubc="";
              v5.removeAllElements();
              v55.removeAllElements();
              v4.removeAllElements();
              v44.removeAllElements();
              if(!v.isEmpty())v.removeAllElements();
              if(!v_id.isEmpty())v_id.removeAllElements();
              Vector v1=new Vector();
              Vector v2=new Vector();
              v1.removeAllElements();
              v2.removeAllElements();
             i=0; int j; 
             allData=myFind.getAllData();
             
              while(allData.next()){                
               i++;
               v.addElement(allData.getString("name"));
               st=allData.getString("country_id");
               v_id.addElement(st);
               st="select name,state_id from state where lang_code='EN' and country_id="+st;
               myFind1.setSqlStc(st);
               stateData=myFind1.getAllData();
               
               j=0;
               while(stateData.next()){
                  j++;
                  st=stateData.getString("state_id");
                  v1.addElement(""+i+"%"+stateData.getString("name")+"%"+st);                 
                  st="select name,city_id from city where lang_code='EN' and state_id="+st;
                  myFind2.setSqlStc(st);
                  cityData=myFind2.getAllData();
                    while(cityData.next()){
                       v2.addElement(""+i+"%"+j+"%"+cityData.getString("name")+"%"+cityData.getString("city_id"));
                               }         
                      myFind2.disconn();      
                             }
                      myFind1.disconn();          
                       } 
             
              
             myFind2.destroy();
             myFind1.destroy();       
             myFind.disconn();
             st1="\""+v2.elementAt(0)+"\""+",";
             st="\""+v1.elementAt(0)+"\""+","; 
             j=v1.size();
           for(i=1;i<j-1;i++){
             st+="\""+v1.elementAt(i)+"\""+",";  
                  }
             st+="\""+v1.elementAt(j-1)+"\"";
             j=v2.size();     
           for(i=1;i<j-1;i++){
              st1+="\""+v2.elementAt(i)+"\""+",";
                  }
              st1+="\""+v2.elementAt(j-1)+"\"";    
                  
           String stri="select code,str_value from parameter where id=7 and lang_code='EN'";
           myFind.setSqlStc(stri);
           allData=myFind.getAllData();
           while(allData.next()){
               v4.addElement(allData.getString("code"));
               v44.addElement(allData.getString("str_value"));
                    }
           myFind.disconn();
            stri="select code,str_value from parameter where id=11 and lang_code='EN'";
           myFind.setSqlStc(stri);
           allData=myFind.getAllData();
           while(allData.next()){
               v5.addElement(allData.getString("code"));
               v55.addElement(allData.getString("str_value"));
                    }
           myFind.disconn();  
                           
           }catch(Exception e){
                e.printStackTrace();} 
           myFind.destroy(); 
    %>
                
   <script language="JavaScript"><!--
   arstate=new Array(<%=st%>);
   arcity=new Array(<%=st1%>);
    menuname=new String();
        
    function creatnext(mf,nf,ef,jf){
     var i=mf.selectedIndex
     var le
     mf.options[0].text=""
     mf.options[0].value=0
     nf.options[0].text=""
     nf.options[0].value=0
     ef.options[0].text=""
     ef.options[0].value=0
     if(i>0&&jf==1){
            nf.length=1
            ef.length=1
           for(var j=0;j<arstate.length;j++){
                menuname=arstate[j].split("%");
                if(menuname[0]==i){
                    le=nf.length
                    nf.length+=1
                    nf.options[le].text=menuname[1];
                    nf.options[le].value=menuname[2];
                     }else{
                          if(menuname[0]>i){ break }  
                         }                    
                       }  
                    }
        if(jf==2){
          k=nf.selectedIndex
         
         if(k>0){
           ef.length=1
           for(var j=0;j<arcity.length;j++){
               menuname=arcity[j].split("%");
               
                if(menuname[0]==i&&menuname[1]==k){
                    le=ef.length
                    ef.length+=1;
                    ef.options[le].text=menuname[2]
                    ef.options[le].value=menuname[3]
                   }else{
                          if(menuname[1]>k&&menuname[0]==i){ break}  
                         }                      
                       }
                     }
                   }  
              }   
      function validateForm(ee){
      
         if(ee.country.value==0){
             alert('Please select your country!')
             return false;
      /*      }else{
                    if(ee.state.value==0){
                       alert('Please select your state!')
                        return false;
                       }else{ 
                               if(ee.city.value==0){
                                   alert('Please select your city!')
                                   return false;
                                       }
                             }
           */                             
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
    <td valign="top"> 
      <form method="post" action="profile2.jsp" name="tijiao" onSubmit="return validateForm(tijiao);">
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="195"> 
              <table width="500" border="0" cellspacing="0" cellpadding="0">
                <tr bgcolor="#4078E0"> 
                  <td height="25"><font color="#FFFFFF" class="font9"><b>Personal 
                    Preferences</b></font></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="500" border="0" cellspacing="1" cellpadding="4">
                      <tr> 
                        <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">First 
                          Name£º</td>
                        <td width="251" bgcolor="#E6EDFB" class="dan10"> 
                          <input type="text" name="first_name" value="<%=str[0]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" class="dan10"><span class="font10"><span class="dan10">Last 
                          Name</span></span>£º</td>
                        <td width="251" class="dan10"> 
                          <input type="text" name="last_name" value="<%=str[1]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">Country£º</td>
                        <td width="251" bgcolor="#E6EDFB" class="dan10"> 
                          <select name="country" onChange="creatnext(country,state,city,1)">
                            <option value="<%=ss1%>" selected><%=str[6]%></option>
                            <%           
                      for(i=0;i<v.size();i++){
                     %> 
                            <option value="<%=v_id.elementAt(i)%>"><%=v.elementAt(i)%></option>
                            <%    } %> 
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" class="dan10">State:</td>
                        <td width="251" class="dan10"> 
                          <select name="state" onChange="creatnext(country,state,city,2)">
                            <option value="<%=ss2%>" selected><%=str[7]%></option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">City£º</td>
                        <td width="251" bgcolor="#E6EDFB" class="dan10"> 
                          <select name="city">
                            <option value="<%=ss3%>" selected><%=str[8]%></option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" class="dan10">Address 1£º</td>
                        <td width="251" class="dan10"> 
                          <input type="text" name="address1" value="<%=str[2]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" class="dan10">Address 2£º</td>
                        <td width="251" class="dan10"> 
                          <input type="text" name="address2" value="<%=str[3]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">Postcode£º</td>
                        <td width="251" bgcolor="#E6EDFB" class="dan10"> 
                          <input type="text" name="postcode" value="<%=str[9]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" class="dan10">Phone£º</td>
                        <td width="251" class="dan10"> 
                          <input type="text" name="tel" value="<%=str[10]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" class="dan10">Mobile£º</td>
                        <td width="251" class="dan10"> 
                          <input type="text" name="mobile" value="<%=str[13]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">Fax£º</td>
                        <td width="251" bgcolor="#E6EDFB" class="dan10"> 
                          <input type="text" name="fax" value="<%=str[11]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center"><span class="dan10"><span class="font10"><span class="dan10">Email</span>£º</span></span></td>
                        <td width="251" class="dan10"> 
                          <input type="text" name="email" value="<%=str[12]%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" bgcolor="#E6EDFB" class="dan10">Department£º</td>
                        <td width="251" bgcolor="#E6EDFB" class="dan10"> 
                          <select name="dept" >
                            <option value="<%=dept%>" selected><%=str[4]%></option>
                            <%           
                      for(i=0;i<v4.size();i++){
                     %> 
                            <option value="<%=v4.elementAt(i)%>"><%=v44.elementAt(i)%></option>
                            <%    } %> 
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="104" align="center" height="25" class="dan10">Job 
                          Title£º</td>
                        <td width="251" bgcolor="#E6EDFB" class="dan10"> 
                          <select name="job_title" >
                            <option value="<%=title%>" selected><%=str[5]%></option>
                            <%           
                      for(i=0;i<v5.size();i++){
                     %> 
                            <option value="<%=v5.elementAt(i)%>"><%=v55.elementAt(i)%></option>
                            <%    } %> 
                          </select>
                        </td>
                      </tr>
                      <tr bgcolor="#E6EDFB"> 
                        <td colspan="2" align="center" height="25" class="dan10"> 
                          <input type="hidden" name="status" value="store" >
                          <input type="submit" name="Submit2" value="Save">
                        </td>
                      </tr>
                    </table>
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
</jsp:useBean>
<html>
<head>
<title>我的纸网--PaperEC.com</title>
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
<%@ page info="我的纸网--PaperEC.com"%> <%@ page import="java.util.*" %> <%@ page import="mypaperec.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> <jsp:useBean id="Activity" scope="page" class="mypaperec.Activity" /> 
<jsp:setProperty name="Activity" property="userId"/> <jsp:setProperty name="Activity" property="langCode" value="EN"/> 
<jsp:setProperty name="Activity" property="workGroup"/> <%  if (!UserInfo.getAuthorized()){
%> <jsp:forward page="notAuthorized.jsp" /> </jsp:forward> <%    }
%> <%
    int workGroupCount;
    String[][] workGroup;   

    Activity.setUserId(UserInfo.getUserId());
    workGroup = Activity.getWorkGroup();     
    workGroupCount = Activity.getWorkGroupCount();
%> 
<script language=javascript > 

ie=document.all?1:0; netscape=document.layers?1:0;

function selectOne(e){
    if (e.checked){
        e.value ="A";
    }else{
        e.value ="N";
    }
}

function selectAll(){
    mf = document.mainSelectForm;
	
    for (i=0;i<mf.elements.length;i++){
    	if (mf.elements[i].type == "checkbox"){
            mf.elements[i].value = 'A';
            mf.elements[i].checked =true;
        }
    }    

}

function deleteAll(){
    mf = document.mainSelectForm;
	
    for (i=0;i<mf.elements.length;i++){
    	if (mf.elements[i].type == "checkbox"){
            mf.elements[i].value = 'N';
            mf.elements[i].checked =false;
        }
    }    

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
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr> 
    <td width="159"> 
      <script language="JavaScript" src="../../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
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
      <form name="mainSelectForm" method="post" action="set_succ.jsp">
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="113"> 
              <table width="500" border="0" cellspacing="1" cellpadding="4">
                <tr bgcolor="#4078E0"> 
                  <td colspan="2" height="25"><font color="#FFFFFF" class="big"><b class="font9">Setup 
                    My Work Group</b></font></td>
                </tr>
                <%
                  for(int i=0;i<workGroupCount;i++){
                    if (i%2==0){
                %> 
                <tr bgcolor="#E6EDFB"> <%  }else{ %> 
                <tr> <%  }%> 
                  <td width="52" align="center"> <%  
		    if (workGroup[i][2].equals("N")){
		 %> 
                    <input type="checkbox" name="checkbox<%=workGroup[i][0]%>" value="N" onClick="javascript:selectOne(this)">
                    <% }else{%> 
                    <input type="checkbox" name="checkbox<%=workGroup[i][0]%>" value="A" CHECKED onClick="javascript:selectOne(this)">
                    <% }%> </td>
                  <td width="448" class="dan10"><%=workGroup[i][1]%></td>
                  <%                  
                  }
                %> 
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td colspan="2"> 
                    <input type="button" name="button1" value="Select All" onClick="javascript:selectAll()">
                    <img src="../../images/images_en/space.gif" width="30" height="1"> 
                    <input type="button" name="button2" value="Delete All" onClick="javascript:deleteAll()">
                    <img src="../../images/images_en/space.gif" width="30" height="1"> 
                    <input type="submit" name="save" value="Submit">
                    <img src="../../images/images_en/space.gif" width="30" height="1"> 
                    <input type="button" name="cancel" value="Cancel" onClick="javascript:document.mainSelectForm.reset();">
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

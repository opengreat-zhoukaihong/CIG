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
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:  rect(   )}
-->
</style>

</head>
<%@ page info="我的纸网--PaperEC.com"%>
<%@ page import="java.util.*" %>
<%@ page import="postcenter.*" %>
<%@ page import="mypaperec.*" %>

<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 

<jsp:useBean id="SearchCondition" scope="page" class="postcenter.SearchCondition" /> 
<jsp:useBean id="PostList" scope="page" class="postcenter.PostList" />

<jsp:setProperty name="SearchCondition" property="userId" />
<jsp:setProperty name="SearchCondition" property="langCode" value="GB"/>
<jsp:setProperty name="SearchCondition" property="classFlag" value="C"/>
<jsp:setProperty name="SearchCondition" property="cateId" />
<jsp:setProperty name="SearchCondition" property="typeId" />
<jsp:setProperty name="SearchCondition" property="gradeId" />
<jsp:setProperty name="SearchCondition" property="buyFlag" />
<jsp:setProperty name="SearchCondition" property="measureFlag" />
<jsp:setProperty name="SearchCondition" property="keyWord" />

<jsp:setProperty name="PostList" property="pageNo"/>
<jsp:setProperty name="PostList" property="sortFlag"/>
<jsp:setProperty name="PostList" property="directFlag"/>
<jsp:setProperty name="PostList" property="searchCondition" />

<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>

<%  
    String name;
    String value;
    boolean localCall = false;
    Enumeration e = request.getParameterNames();
    int i=0;
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);

	if ( name.equals("pageNo")) {
	    localCall = true;
	}
    }
    

  if (true)
  {
    String cateId = "";
    String searchFlag="L";
    
    Spec[] specItems;
    
    e = request.getParameterNames();

    SearchCondition.init();
    specItems = SearchCondition.specList.specItems;   

    while ( e.hasMoreElements()){
        i++; 
	name = (String)e.nextElement();
	value = request.getParameter(name);

	if ( name.equals("keyWord")) {
	    searchFlag = "K";
	}else if ( value!=null && !value.equals("")) { 
	    for (int j=0; j<specItems.length; j++){
		if( name.equals("input_min_Spec"+specItems[j].specId)) {
		    specItems[j].setSpecMinVal(value);
		}else if( name.equals("input_max_Spec"+specItems[j].specId)){
		    specItems[j].setSpecMaxVal(value);
		}else if( name.equals("input_option_Spec"+specItems[j].specId)){
		    specItems[j].setSpecParaId(value);
		}
	    }
        }
    }

    SearchCondition.searchFlag = searchFlag;
    SearchCondition.userId = UserInfo.getUserId();

    SearchCondition.getSpecSetCount();
  }  
        
  if (!localCall){
    PostList.setSearchCondition(SearchCondition);
    PostList.setPageNo("1");
    PostList.setSortFlag("1");
    PostList.setDirectFlag("1");
  }else{
    PostList.setSearchCondition(SearchCondition);
  }
  
%>
<script language="JavaScript">
function openMsgWin(url){   
        OpenWindow=window.open(url, "msgwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,resizable=no,menubar=no,width=300,height=210");
}
</script>

              <SCRIPT LANGUAGE="Javascript"> 
                  NS = (document.layers) ? 1 : 0; 
                  IE = (document.all) ? 1: 0; 
                  function changePage(p) {
                      document.PostList.pageNo.value = p; 
                      document.PostList.submit();
                  } 
                  function sort(e) { 
                      if (IE) {
                      	   document.PostList.sortFlag.value = e.value;
                           document.PostList.submit();
                      } 
                      if (NS) {
                      	   document.PostList.sortFlag.value = e.value;
                      	   document.PostList.submit();
                      } 
                  } 
                  function direct(e) { 
                      if (IE) {
                      	   document.PostList.directFlag.value = e.value;
                           document.PostList.submit();
                      } 
                      if (NS) {
                      	   document.PostList.directFlag.value = e.value;
                      	   document.PostList.submit();
                      } 
                  }                   
              </SCRIPT> 
              
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
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="834" width="159" valign="top">
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
      </div></td>
    <td valign="top"> 
      <form name="PostList" method="post" action="PostList.jsp">
            <input type="HIDDEN" name="pageNo" value=<%= PostList.pageNo%>>
   
            <input type="HIDDEN" name="userId" value=<%=SearchCondition.userId%>>
            <input type="HIDDEN" name="langCode" value="GB">
            <input type="HIDDEN" name="classFlag" value="C">
            <input type="HIDDEN" name="cateId" value=<%=SearchCondition.cateId%>>
            <input type="HIDDEN" name="typeId" value=<%=SearchCondition.typeId%>>
            <input type="HIDDEN" name="gradeId" value=<%=SearchCondition.gradeId%>>
            <input type="HIDDEN" name="buyFlag" value=<%=SearchCondition.buyFlag%>>
            <input type="HIDDEN" name="measureFlag" value=<%=SearchCondition.measureFlag%>>

<%
    e = request.getParameterNames();
    
    while ( e.hasMoreElements()){
	name = (String)e.nextElement();
	value = request.getParameter(name);

	if ( name.equals("keyWord")) {
%>
            <input type="HIDDEN" name="<%=name%>" value=<%=value%>>
<%	}
	if ( value!=null && !value.equals("")) { 
		if( name.startsWith("input_min_Spec")
		  || name.startsWith("input_max_Spec")
		  || name.startsWith("input_option_Spec")) {
%>
            <input type="HIDDEN" name="<%=name%>" value=<%=value%>>
<%		}
        }
    }
%>               
        
        <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="292"> 
              <table width="600" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="3" height="25" bgcolor="#4078E0"><font color="#FFFFFF">供需检索详细信息</font></td>
                </tr>
                <tr align="center"> 
                  <td bgcolor="#7EA2EB" height="22" class="dan10" width="154">类型名称:<%=SearchCondition.cateName%></td>
                  <td class="dan10" width="217" bgcolor="#7EA2EB">产品名称:<%=SearchCondition.typeName%></td>
                  <td class="dan10" width="295" bgcolor="#7EA2EB">型号名称:<%=SearchCondition.gradeName%></td>           
		</tr>
		<%    
    		  Spec[] sp;
        	  sp = SearchCondition.specList.specItems;   
		
		  int j=0;
		  for (i=0; i<sp.length; i++ ){ 
    		    if ( sp[i].valueIsSet){
    		        if (j%3==0){
    		%> 
    		  	  <tr align="left" bgcolor="#E6EDFB">
    		<%  	}
    			if (!sp[i].specValFlag.equals("N")) {
    			   if (sp[i].specMinVal.equals(sp[i].specMaxVal)){
    		%>
    				<td height="22" class="dan10" width="222"><%=sp[i].specName %>: <%=sp[i].specMinVal%> <%=sp[i].specUnit%></td>
    		<%	   }else{
    		%>
    			        <td height="22" class="dan10" width="222"><%=sp[i].specName %>: <%=sp[i].specMinVal%> - <%=sp[i].specMaxVal%> <%=sp[i].specUnit%></td>
    		<%	   }
    			}else{
    		%>
    			   	<td height="22" class="dan10" width="260"><%=sp[i].specName %>: <%=sp[i].getSpecParaStr()%></td>
    		<%	} 
    			j++;			   
			if (j%3==0){    
    		%>
    			  </tr>
    		<%      }
    		    }
    		  }    
    		  if ((j-2)%3==0) 
    		%>   
    		      <td height="22" class="dan10" width="222">&nbsp;</td>
    		<%  
    		  if ((j-1)%3==0){
    		%>
    		      <td height="22" class="dan10" width="222">&nbsp;</td>
    		      <td height="22" class="dan10" width="222">&nbsp;</td>
    		<%
    		  }
    		%>
    		    </tr>
			  
                <!--tr> 
                  <!--td class="dan10" colspan="3" height="160"--> 
                    <!--table width="600" border="0" cellspacing="0" cellpadding="0"-->
			                 
                      
                      <%= PostList.getPostList() %>
                      
                    </table>
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

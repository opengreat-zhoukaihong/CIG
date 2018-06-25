<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "宋体"}
        A:visited {text-decoration: none; font-family: "宋体"}
        A:active {text-decoration: none; font-family: "宋体"}
        A:hover {text-decoration: underline; color: #FFCC33}
-->
</style>
</head>



<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnCityMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<jsp:useBean id="CountryList" scope="page" class="com.cnbooking.bst.CountryList" /> 
<jsp:setProperty name="CountryList" property="pageNo"/>

<jsp:useBean id="Country" scope="page" class="com.cnbooking.bst.Country" /> 
<jsp:setProperty name="Country" property="countryId"/>
<jsp:setProperty name="Country" property="action"/>
<jsp:setProperty name="Country" property="langCode"/>
<jsp:setProperty name="Country" property="name"/>
<jsp:setProperty name="Country" property="descr"/>
<jsp:setProperty name="Country" property="operatorId"/>

<%
   int country_count;
   String[][] country_list;
   int total_page=0;
   
   int pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
 
   String act= request.getParameter("action");
   
   String operator_id = UserInfo.getUsername();
   
   Country.setOperatorId(operator_id);
   
   Country.initCountry();
   
   country_list = CountryList.getCountryList();   
   country_count = CountryList.getCountryCount();
   total_page = CountryList.getTotalPage();
   
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.paraForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("若删除该参数，将会造成已经使用该参数的信息无法显示。你确定删除此参数吗?")

    }
</SCRIPT>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="paraForm" method="post" action="countryList.jsp">
      
      <input type="HIDDEN" name="action">
      <input type="HIDDEN" name="pageNo" value="<%=pageno%>">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="6" class="font12" height="33">国家列表：
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr>
                  <td class="font9" colspan="3" align="left">共有<%=country_count%>个国家，共<%=total_page%>页</td>  
                  <td class="font9" colspan="3" align="right">第<%=pageno%>页&nbsp;&nbsp;
                    <% if (pageno!=1) {%>
                    <a href="countryList.jsp?pageNo=<%=pageno-1%>&action=" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageno!=total_page && total_page>0) {%>
                    <a href="countryList.jsp?pageNo=<%=pageno+1%>&action=" class="font9">下一页</a>&nbsp; 
                    <%}%>                    
                  </td>
          </tr>          
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><b>国家ID</b></td>
            <td width="60" class="font9"><b>语言代码</b></td>
            <td width="120" class="font9"><b>国家名称</b></td>
            <td width="120" class="font9"><b>描述</b></td>
            <td width="60" class="font9">&nbsp;</td>
            <td width="40" class="font9">&nbsp;</td>
          </tr>
                <% 
                   int list_count = country_count<20?country_count:20;
		   int maxNum = list_count;            
              	  if (pageno == total_page){
              	      maxNum = country_count-CountryList.restriction*(pageno-1);
              	  }  
              	  if (country_count >0){                   
                   for (int i=0;i<maxNum;i++){%>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><a href="countryEdit.jsp?pageNo=<%=pageno%>&action=update&countryId=<%=country_list[i][0]%>&langCode=<%=country_list[i][1]%>" class="font9"><%=country_list[i][0]%></a></td>
            <td width="60" class="font9"><%=country_list[i][1]%></td>
            <td width="120" class="font9"><%=country_list[i][2]%></td>
            <td width="120" class="font9"><%=country_list[i][3]%></td>
            <td width="60" class="font9"><a href="stateList.jsp?pageNo=1&action=&countryId=<%=country_list[i][0]%>&langCode=<%=country_list[i][1]%>" class="font9">查看省份</a></td>
            <td width="40" class="font9"><a href="countryList.jsp?pageNo=1&action=delete&countryId=<%=country_list[i][0]%>&langCode=<%=country_list[i][1]%>" onClick="return confirmDelete()" class="font9">删除</a></td>
          </tr>
          <%  }
            }
          %>
          <tr align="center" class="font9"> 
            <td colspan="8"> 
               语言代码
              <select name="langCode">
              <option value=GB selected> 中文 </option>
              <option value=EN> 英文 </option>
              </select>
              国家名称 
              <input type="text" name="name" size="10">
	      描述 
              <input type="text" name="descr" size="20">              
              <a href="#" onClick="javascript:addSubmit()"><input type="image" border="0" name="imageField" src="/images/botton_add.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
        <br>
        <br>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

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

<jsp:useBean id="StateList" scope="page" class="com.cnbooking.bst.StateList" /> 
<jsp:setProperty name="StateList" property="pageNo"/>
<jsp:setProperty name="StateList" property="countryId"/>

<jsp:useBean id="State" scope="page" class="com.cnbooking.bst.State" /> 
<jsp:setProperty name="State" property="countryId"/>
<jsp:setProperty name="State" property="action"/>
<jsp:setProperty name="State" property="langCode"/>
<jsp:setProperty name="State" property="name"/>
<jsp:setProperty name="State" property="stateId"/>
<jsp:setProperty name="State" property="operatorId"/>

<jsp:useBean id="CountryList" scope="page" class="com.cnbooking.bst.CountryList" /> 

<%
   int state_count;
   String[][] state_list;
   int total_page=0;
   String[][] country_list;
   
   int pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
 
   String act= request.getParameter("action");
   
   String operator_id = UserInfo.getUsername();
   
   State.setOperatorId(operator_id);
   
    String re_name;
    String value;
    String str="";
    Enumeration e = request.getParameterNames();
    String country_id="";
    
    while ( e.hasMoreElements()){
    	re_name = (String)e.nextElement();
	value = request.getParameter(re_name);

	if ( re_name.equals("countryId") && !value.equals("")) {
	    str += "&countryId=" + value;
	}

    }
    
    
   State.initState();
   
   state_list = StateList.getStateList();   
   state_count = StateList.getStateCount();
   total_page = StateList.getTotalPage();
   
   country_list = CountryList.getAllCountry();   
   
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.paraForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("若删除该省份，将会造成已经使用该省份的信息无法显示。你确定删除此省份吗?")

    }
</SCRIPT>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="paraForm" method="post" action="stateList.jsp?pageNo=1">
      
      <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="6" class="font12" height="33">省份列表：
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr>
                  <td class="font9" colspan="3" align="left">共有<%=state_count%>个省份，共<%=total_page%>页</td>  
                  <td class="font9" colspan="3" align="right">第<%=pageno%>页&nbsp;&nbsp;
                    <% if (pageno!=1) {%>
                    <a href="stateList.jsp?pageNo=<%=pageno-1%>&action=" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageno!=total_page && total_page>0) {%>
                    <a href="stateList.jsp?pageNo=<%=pageno+1%>&action=" class="font9">下一页</a>&nbsp; 
                    <%}%>                    
                  </td>
          </tr>          
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><b>省份ID</b></td>
            <td width="60" class="font9"><b>语言代码</b></td>
            <td width="100" class="font9"><b>所属国家</b></td>          
            <td width="100" class="font9"><b>省份名称</b></td>
            <td width="60" class="font9">&nbsp;</td>
            <td width="40" class="font9">&nbsp;</td>
          </tr>
                <% 
                   int list_count = state_count<20?state_count:20;
		   int maxNum = list_count;            
              	  if (pageno == total_page){
              	      maxNum = state_count-StateList.restriction*(pageno-1);
              	  }  
              	  if (state_count >0){                   
                   for (int i=0;i<maxNum;i++){%>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><a href="<%="stateEdit.jsp?pageNo="+pageno+"&action=update&stateId="+state_list[i][0]+"&langCode="+state_list[i][1]+str%>" class="font9"><%=state_list[i][0]%></a></td>
            <td width="60" class="font9"><%=state_list[i][1]%></td>
            <td width="100" class="font9"><%=state_list[i][3]%></td>
            <td width="100" class="font9"><%=state_list[i][2]%></td>
            <td width="60" class="font9"><a href="cityList.jsp?pageNo=1&action=&stateId=<%=state_list[i][0]%>" class="font9">查看城市</a></td>
            <td width="40" class="font9"><a href="<%="stateList.jsp?pageNo="+pageno+"&action=delete&stateId="+state_list[i][0]+"&langCode="+state_list[i][1]+str%>" onClick="return confirmDelete()" class="font9">删除</a></td>
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
	      所属国家 
              <select name="countryId">
              <option value="none">-请选择国家-</option>
              <% for (int i=0;i<country_list.length;i++){ 
              %>
              <option value="<%=country_list[i][0]%>"><%=country_list[i][1]%></option>
              <% }%>
              </select>
              省份名称 
              <input type="text" name="name" size="10">                            
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

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

<jsp:useBean id="CityList" scope="page" class="com.cnbooking.bst.CityList" /> 
<jsp:setProperty name="CityList" property="pageNo"/>
<jsp:setProperty name="CityList" property="stateId"/>
<jsp:setProperty name="CityList" property="flightFlag"/>

<jsp:useBean id="City" scope="page" class="com.cnbooking.bst.City" /> 
<jsp:setProperty name="City" property="cityId"/>
<jsp:setProperty name="City" property="action"/>
<jsp:setProperty name="City" property="langCode"/>
<jsp:setProperty name="City" property="name"/>
<jsp:setProperty name="City" property="descr"/>
<jsp:setProperty name="City" property="flightFlag"/>
<jsp:setProperty name="City" property="stateId"/>
<jsp:setProperty name="City" property="operatorId"/>

<jsp:useBean id="StateList" scope="page" class="com.cnbooking.bst.StateList" /> 

<%
   int city_count;
   String[][] city_list;
   int total_page=0;
   String[][] state_list;
   
   int pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
 
   String act= request.getParameter("action");
   
   String operator_id = UserInfo.getUsername();
   
   City.setOperatorId(operator_id);
   
    String re_name;
    String value;
    String str="";
    Enumeration e = request.getParameterNames();
    
    while ( e.hasMoreElements()){
    	re_name = (String)e.nextElement();
	value = request.getParameter(re_name);

	if ( re_name.equals("stateId") && !value.equals("")) {
	    str += "&stateId=" + value;
	}
	if ( re_name.equals("flightFlag") && !value.equals("")) {
	    str += "&flightFlag=" + value;
	}	

    }
    
    
   City.initCity();
   
   city_list = CityList.getCityList();   
   city_count = CityList.getCityCount();
   total_page = CityList.getTotalPage();
   
   state_list = StateList.getAllState();   
   
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.paraForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("若删除该城市，将会造成已经使用该城市的信息无法显示。你确定删除此城市吗?")

    }
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="paraForm" method="post" action="cityList.jsp?pageNo=1">
      
      <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="8" class="font12" height="33">城市列表：
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr>
                  <td class="font9" colspan="4" align="left">共有<%=city_count%>个城市，共<%=total_page%>页</td>  
                  <td class="font9" colspan="4" align="right">第<%=pageno%>页&nbsp;&nbsp;
                    <% if (pageno!=1) {%>
                    <a href="<%="cityList.jsp?pageNo="+(pageno-1)+"&action="+str%>" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageno!=total_page && total_page>0) {%>
                    <a href="<%="cityList.jsp?pageNo="+(pageno+1)+"&action="+str%>" class="font9">下一页</a>&nbsp; 
                    <%}%>                    
                  </td>
          </tr>          
          <tr align="center" class="font9"> 
            <td width="50" class="font9"><b>城市ID</b></td>
            <td width="60" class="font9"><b>语言代码</b></td>
            <td width="60" class="font9"><b>所属省份</b></td>          
            <td width="60" class="font9"><b>城市名称</b></td>
            <td width="60" class="font9"><b>描述</b></td>
            <td width="60" class="font9"><b>起飞标志</b></td>
            <td width="60" class="font9">&nbsp;</td>
            <td width="40" class="font9">&nbsp;</td>
          </tr>
                <% 
                   int list_count = city_count<20?city_count:20;
		   int maxNum = list_count;            
              	  if (pageno == total_page){
              	      maxNum = city_count-CityList.restriction*(pageno-1);
              	  }  
              	  if (city_count >0){                   
                   for (int i=0;i<maxNum;i++){
                     if (city_list[i][5].equals("S")) 
                     	city_list[i][5] = "起飞";
                     else if (city_list[i][5].equals("A")) 
                     	city_list[i][5] = "到达";
                     else 
                        city_list[i][5] = "不到达";
                     	
                     if (city_list[i][4].equals(""))
                        city_list[i][4] = "&nbsp;";
                 %>
          <tr align="center" class="font9"> 
            <td width="50" class="font9"><a href="<%="cityEdit.jsp?pageNo="+pageno+"&action=update&cityId="+city_list[i][0]+"&langCode="+city_list[i][1]+str%>" class="font9"><%=city_list[i][0]%></a></td>
            <td width="60" class="font9"><%=city_list[i][1]%></td>
            <td width="60" class="font9"><%=city_list[i][3]%></td>
            <td width="60" class="font9"><%=city_list[i][2]%></td>
            <td width="60" class="font9"><%=city_list[i][4]%></td>
            <td width="60" class="font9"><%=city_list[i][5]%></td>
            <td width="60" class="font9"><a href="locationList.jsp?action=&cityId=<%=city_list[i][0]%>" class="font9">查看区域</a></td>
            <td width="40" class="font9"><a href="<%="cityList.jsp?pageNo="+pageno+"&action=delete&cityId="+city_list[i][0]+"&langCode="+city_list[i][1]+str%>" onClick="return confirmDelete()" class="font9">删除</a></td>
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
	      所属省份 
              <select name="stateId">
              <option value="">-请选择省份-</option>
              <% for (int i=0;i<state_list.length;i++){ 
              %>
              <option value="<%=state_list[i][0]%>"><%=state_list[i][1]%></option>
              <% }%>
              </select>
              城市名称 
              <input type="text" name="name" size="10"><br>
              描述 
              <input type="text" name="descr" size="10">
              起飞标志 
              <select name="flightFlag">
              <option value="A" selected>到达</option>
              <option value="S">起飞</option>
              <option value="N">不到达</option>
              </select>                       
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

<html>
<head>
<title>CNHotelBooking.com��̨������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "����"}
        A:visited {text-decoration: none; font-family: "����"}
        A:active {text-decoration: none; font-family: "����"}
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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
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

          return confirm("��ɾ���ó��У���������Ѿ�ʹ�øó��е���Ϣ�޷���ʾ����ȷ��ɾ���˳�����?")

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
            <td colspan="8" class="font12" height="33">�����б�
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>
          <tr>
                  <td class="font9" colspan="4" align="left">����<%=city_count%>�����У���<%=total_page%>ҳ</td>  
                  <td class="font9" colspan="4" align="right">��<%=pageno%>ҳ&nbsp;&nbsp;
                    <% if (pageno!=1) {%>
                    <a href="<%="cityList.jsp?pageNo="+(pageno-1)+"&action="+str%>" class="font9">��һҳ</a>&nbsp;
                    <%}%>
                    <% if (pageno!=total_page && total_page>0) {%>
                    <a href="<%="cityList.jsp?pageNo="+(pageno+1)+"&action="+str%>" class="font9">��һҳ</a>&nbsp; 
                    <%}%>                    
                  </td>
          </tr>          
          <tr align="center" class="font9"> 
            <td width="50" class="font9"><b>����ID</b></td>
            <td width="60" class="font9"><b>���Դ���</b></td>
            <td width="60" class="font9"><b>����ʡ��</b></td>          
            <td width="60" class="font9"><b>��������</b></td>
            <td width="60" class="font9"><b>����</b></td>
            <td width="60" class="font9"><b>��ɱ�־</b></td>
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
                     	city_list[i][5] = "���";
                     else if (city_list[i][5].equals("A")) 
                     	city_list[i][5] = "����";
                     else 
                        city_list[i][5] = "������";
                     	
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
            <td width="60" class="font9"><a href="locationList.jsp?action=&cityId=<%=city_list[i][0]%>" class="font9">�鿴����</a></td>
            <td width="40" class="font9"><a href="<%="cityList.jsp?pageNo="+pageno+"&action=delete&cityId="+city_list[i][0]+"&langCode="+city_list[i][1]+str%>" onClick="return confirmDelete()" class="font9">ɾ��</a></td>
          </tr>
          <%  }
            }
          %>
          <tr align="center" class="font9"> 
            <td colspan="8"> 
               ���Դ���
              <select name="langCode">
              <option value=GB selected> ���� </option>
              <option value=EN> Ӣ�� </option>
              </select>
	      ����ʡ�� 
              <select name="stateId">
              <option value="">-��ѡ��ʡ��-</option>
              <% for (int i=0;i<state_list.length;i++){ 
              %>
              <option value="<%=state_list[i][0]%>"><%=state_list[i][1]%></option>
              <% }%>
              </select>
              �������� 
              <input type="text" name="name" size="10"><br>
              ���� 
              <input type="text" name="descr" size="10">
              ��ɱ�־ 
              <select name="flightFlag">
              <option value="A" selected>����</option>
              <option value="S">���</option>
              <option value="N">������</option>
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

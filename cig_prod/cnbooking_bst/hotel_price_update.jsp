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

  funcID = "fnHtSerMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<jsp:useBean id="PriceUpdateList" scope="page" class="com.cnbooking.bst.hotel.PriceUpdateList" /> 
<jsp:setProperty name="PriceUpdateList" property="pageNo"/>
<jsp:setProperty name="PriceUpdateList" property="dateUpdate"/> 

<%
    int price_count = 0;
    int total_page = 0;
    String[][] price_list;
    
    String today = UserInfo.getToday();
    
    String name;
    String value;
    Enumeration e = request.getParameterNames();
    String dateUpdate="";
    String str="";
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);

	if ( name.equals("dateUpdate") && !value.equals("")) {
	    str += "&dateUpdate=" + value;
	    dateUpdate = value;
	}


    }
    if (dateUpdate.equals("")){
	    PriceUpdateList.setDateUpdate(today);
	    dateUpdate = today;
    }
    
    int pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
      
    
    PriceUpdateList.getPriceUpdate();
    price_list = PriceUpdateList.getPrice();
    price_count = PriceUpdateList.getPriceCount();
    total_page = PriceUpdateList.getTotalPage();
        
%> 

<SCRIPT LANGUAGE="Javascript">
        
    function submitThis(){  
        var mf=document.fmPriceUpdate;     
 
      	mf.submit();

    }
     
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table width="640" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr> 
    <td width="397"> 
      <table border="0" cellpadding="0" cellspacing="0" width="500">
        <tr> 
          <td width="10">&nbsp; </td>
          <td> 
            <form name=fmPriceUpdate  method="post" action="hotel_price_update.jsp?pageNo=1">
              <table width="700" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">�۸���¹����</td>
                </tr>
                <tr> 
                  <td class="font9" align="center">��������(��ʽ: YYYY-MM-DD)
                  <input type="text" name="dateUpdate" size="10" value=<%=dateUpdate%>>
                  <a href="" onClick="javascript:submitThis()"><input type="image" border="0" name="imageField" src="/images/botton_search.gif" width="68" height="26">
                  </td>
                </tr>
              </table>
              <table width="700" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="6" align="left">����<%=price_count%>�����µļ�¼����<%=total_page%>ҳ</td>  
                  <td class="font9" colspan="7" align="right">��<%=pageno%>ҳ&nbsp;&nbsp;
                    <% if (pageno!=total_page && total_page>0) {%>
                    <a href="hotel_price_update.jsp?pageNo=<%=pageno+1%><%=str%>" class="font9">��һҳ</a>&nbsp; 
                    <%}%>
                    <% if (pageno!=1) {%>
                    <a href="hotel_price_update.jsp?pageNo=<%=pageno-1%><%=str%>" class="font9">��һҳ</a>&nbsp;
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="font9" width="40" height="15">����</td>
                  <td class="font9" width="100" height="15">�Ƶ�����</td>
                  <td class="font9" width="60" height="15">��������</td>
                  <td class="font9" width="60" height="15">�۸�����</td>
                  <td class="font9" width="40" height="15">ͬ�м��</td>
                  <td class="font9" width="50" height="15">ƽ�ռ�</td>
                  <td class="font9" width="50" height="15">�����</td>
                  <td class="font9" width="50" height="15">������</td>
                  <td class="font9" width="50" height="15">���ռ�</td>
                  <td class="font9" width="50" height="15">��ע</td>
                  <td class="font9" width="50" height="15">��Ч����</td>
                  <td class="font9" width="50" height="15">ʧЧ����</td>
                  <td class="font9" width="50" height="15">�鿴</td>
                </tr>
                <% 
                   int list_count = price_count<30?price_count:30;
		   int maxNum = list_count;;            
              	  if (pageno == total_page){
              	      maxNum = price_count-PriceUpdateList.restriction*(pageno-1);
              	  }  
              	  if (price_count >0){                   
                   for (int i=0;i<maxNum;i++){%>
                <tr align="center"> 
                  <td class="font9" width="40" height="15"><%=price_list[i][11]%></td>
                  <td class="font9" width="100" height="15"><a href="HotelModify.jsp?HotelId=<%=price_list[i][0]%>" class="font9"><%=price_list[i][1]%></a></td>
                  <td class="font9" width="60" height="15"><%=price_list[i][2]%></td>
                  <td class="font9" width="60" height="15"><%=price_list[i][3]%></td>
                  <td class="font9" width="40" height="15"><%=price_list[i][4]%></td>
                  <td class="font9" width="50" height="15"><%=price_list[i][5]%></td>
                  <td class="font9" width="50" height="15"><%=price_list[i][6]%></td>
                  <td class="font9" width="50" height="15"><%=price_list[i][7]%></td>
                  <td class="font9" width="50" height="15"><%=price_list[i][8]%></td>
                  <td class="font9" width="50" height="15"><%=price_list[i][12]%></td>
                  <td class="font9" width="50" height="15"><%=price_list[i][13]%></td>
                  <td class="font9" width="50" height="15"><%=price_list[i][14]%></td>
                  <td class="font9" width="50" height="15"><a href="HotelBKPriceList.jsp?hotel_ID=<%=price_list[i][0]%>" class="font9">��ϸ�۸�</a></td>
                </tr>
                <% }
                  }
                %>
              </table>
            </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

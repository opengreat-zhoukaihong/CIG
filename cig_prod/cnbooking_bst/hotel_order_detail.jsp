<html>
<head>
<title>CNHotelBooking.com��̨������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>

</SCRIPT>


<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.hotel.*" %> 
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

  funcID = "fnHtBookMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<jsp:useBean id="OrderHelper" scope="page" class="com.cnbooking.bst.hotel.OrderHelper" /> 
<jsp:setProperty name="OrderHelper" property="action"/>
<jsp:setProperty name="OrderHelper" property="bookId"/>
<jsp:setProperty name="OrderHelper" property="operatorId"/>
<jsp:setProperty name="OrderHelper" property="operatorNotes"/>


<jsp:useBean id="OrderDetail" scope="page" class="com.cnbooking.bst.hotel.OrderDetail" /> 
<jsp:setProperty name="OrderDetail" property="bookId"/>

<%
  int book_count = 0;
  String[][] book;
  String book_id = request.getParameter("bookId");
  String act= request.getParameter("action");
  String operator_id = UserInfo.getUsername();

  OrderHelper.initOrder();
  
  OrderDetail.getOrderDetail();
   
  String hotel_name = OrderDetail.getHotelName();
  String hotel_id = OrderDetail.getHotelId();
  String cust_name = OrderDetail.getCustName();
  String cust_id = OrderDetail.getCustId();
  String city = OrderDetail.getCity();
  String payment = OrderDetail.getPayment();
  String live_name = OrderDetail.getLiveName();
  String live_name_py = OrderDetail.getLiveNamePy();
  String contact_name = OrderDetail.getContactName();
  String tel = OrderDetail.getTel();
  String fax = OrderDetail.getFax();
  String email = OrderDetail.getEmail();
  String arrival_date = OrderDetail.getArrivalDate();
  String leave_date = OrderDetail.getLeaveDate();
  String request_date = OrderDetail.getRequestDate();
  String cr_date = OrderDetail.getCrDate();
  String status = OrderDetail.getStatus();
  String operator_name = OrderDetail.getOperatorName();
  String process_date = OrderDetail.getProcessDate();
  String last_md_date = OrderDetail.getLastMdDate();
  String cust_notes = OrderDetail.getCustNotes();
  String operator_notes = OrderDetail.getOperatorNotes();   
  
  book_count = OrderDetail.getBookCount();
  book = OrderDetail.getBook();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function finishSubmit(){  
        var mf=document.frmOrderDetail;
	mf.action.value = "finish";
        
      	mf.submit();


     }
     
    function cancelSubmit(){  
        var mf=document.frmOrderDetail;
	mf.action.value = "cancel";
        
      	mf.submit();


     }     
    
    function deleteSubmit(){  
        var mf=document.frmOrderDetail;
	mf.action.value = "delete";
        
        confirm("��ȷ��ɾ���˶�����?");
        
      	mf.submit();


     }     

</SCRIPT>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name="frmOrderDetail" method="post" action="hotel_order_detail.jsp">
      <input type="HIDDEN" name="bookId" value=<%=book_id%>>
      <input type="HIDDEN" name="action" value=<%=act%>>
      <input type="HIDDEN" name="operatorId" value=<%=operator_id%>>


<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">��������</td>
          </tr>
        </table>
        <table width="547" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr> 
            <td class="font9" height="30" width="100">������ţ�</td>
            <td class="font9" height="30" width="150"> <a href="#" class="font9"><%=book_id%></a> 
              <INPUT 
            type="hidden" name=txtID style="HEIGHT: 22px; WIDTH: 22px" value="983">
            </td>
            <td class="font9" height="30" width="100">�Ƶ����ƣ�</td>
            <td class="font9" height="30" width="150"><a href="HotelModify.jsp?HotelId=<%=hotel_id%>" class="font9"><%=hotel_name%></a></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��Ա������</td>
            <td class="font9" height="30" width="150"><a href="member/member_user_detail.jsp?custId=<%=cust_id%>" class="font9"><%=cust_name%></a></td>
            <td class="font9" height="30" width="100">��ԱID��</td>
            <td class="font9" height="30" width="150"><a href="member/member_user_detail.jsp?custId=<%=cust_id%>" class="font9"><%=cust_id%></a></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">���У�</td>
            <td class="font9" height="30" width="150"><%=city%></td>
            <td class="font9" height="30" width="100">���㷽ʽ��</td>
            <td class="font9" height="30" width="150"><%=payment%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��ס��������</td>
            <td class="font9" height="30" width="150"><%=live_name%></td>
            <td class="font9" height="30" width="100">����ƴ����</td>
            <td class="font9" height="30" width="150"><%=live_name_py%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��ϵ��������</td>
            <td class="font9" height="30" width="150"><%=contact_name%></td>
            <td class="font9" height="30" width="100">�绰��</td>
            <td class="font9" height="30" width="150"><%=tel%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">���棺</td>
            <td class="font9" height="30" width="150"><%=fax%></td>
            <td class="font9" height="30" width="100">�����ʼ���</td>
            <td class="font9" height="30" width="150"><a href="mailto:<%=email%>" class="font9"><%=email%></a></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">��ס���ڣ�</td>
            <td class="font9" height="30" width="150"><%=arrival_date%> </td>
            <td class="font9" height="30" width="100">�뿪���ڣ�</td>
            <td class="font9" height="30" width="150"><%=leave_date%> </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="100">�������ڣ�</td>
            <td class="font9" height="30" width="150"><%=request_date%>
            </td>
            <td class="font9" height="30" width="100">״̬��</td>
            <td class="font9" height="30" width="150"><%=status%>  </td>
          </tr>
	  <tr> 
            <td colspan="10" class="font9">
              <table width="530" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
                <tr> 
                  <td class="font9"> 
                    <div align="center">����</div>
                  </td>
                  <td class="font9"> 
                    <div align="center">�۸�����</div>
                  </td>
                  <td class="font9"> 
                    <div align="center">����</div>
                  </td>                  
                  <td class="font9"> 
                    <div align="center">����</div>
                  </td>
                  <td class="font9"> 
                    <div align="center">����</div>
                  </td>
                  <td class="font9"> 
                    <div align="center">����</div>
                  </td>
                  <td class="font9"> 
                    <div align="center">С��</div>
                  </td>
                  <td class="font9"> 
                    <div align="center">����</div>
                  </td>
                </tr>
                <% 
                  float total=0;
                  for (int i=0;i<book_count;i++){
                    if (!book[i][5].equals("&nbsp;"))
                     total = (Float.valueOf(book[i][3])).floatValue()*
                     		(Float.valueOf(book[i][5])).floatValue();
                %>
                <tr> 
                  <td class="font9"> 
                    <div align="center"> 
                      <%=book[i][0]%></a> </div>
                  </td>
                  <td class="font9"> 
                    <div align="center"><%=book[i][1]%></div>
                  </td>
                  <td class="font9"> 
                    <div align="center"><%=book[i][2]%></div>
                  </td>
                  <td class="font9"> 
                    <div align="center"><%=book[i][3]%></div>
                  </td>
                  <td class="font9"> 
                    <div align="center"><%=book[i][4]%></div>
                  </td>
                  <td class="font9"> 
                    <div align="center"><%=book[i][5]%></div>
                  </td>
                  <td class="font9"> 
                    <div align="center"><%=total%></div>
                  </td>
                  <td class="font9"> 
                    <div align="center"><%=book[i][6]%></div>
                  </td>
                </tr>
                <% }%>
              </table>
            </td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="75">����Ա��</td>
            <td class="font9" height="30" width="150"><%=operator_name%></td>
            <td class="font9" height="30" width="75">�������ڣ�</td>
            <td class="font9" height="30" width="150"><%=process_date%></td>
          </tr>
          <tr> 
            <td class="font9" height="30" width="75">�������ڣ�</td>
            <td class="font9" height="30" width="150"><%=cr_date%></td>
            <td class="font9" height="30" width="90">����޸����ڣ�</td>
            <td class="font9" height="30" width="150"><%=last_md_date%></td>
          </tr>          
          <tr> 
            <td class="font9" height="95" width="75">�˿����ԣ�</td>
            <td class="font9" height="95" colspan="3"><TEXTAREA cols=60 name=txtCusNotes rows=3><%=cust_notes%></TEXTAREA>
            </td>
          </tr>
          <tr> 
            <td width="83" class="font9">����Ա��¼��</td>
            <td colspan="3"> 
              <table width="164" border="0" cellspacing="0" cellpadding="0" height="90">
                <tr> 
                  <td><TEXTAREA cols=60 name=operatorNotes rows=3><%=operator_notes%></TEXTAREA>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <table width="506" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30"> <A href="javascript:finishSubmit()"><IMG border=0 height=26 src="/images/completes.gif" width=68></A><IMG height=8 src="/images/dot.gif" width=50> 
              <A href="javascript:cancelSubmit()"><IMG border=0 height=27 src="/images/cancel.gif" width=67></A> 
              <img height=8 src="/images/dot.gif" width=50> <a href="javascript:deleteSubmit()"><img border=0 height=26 src="/images/deltree.gif" width=68></a></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

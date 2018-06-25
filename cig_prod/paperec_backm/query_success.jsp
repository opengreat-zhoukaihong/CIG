
<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="login.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  boolean isPermitted;
  String userID;
  String funcId;

  funcId = "fnBookMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<%@ page  %>
<jsp:useBean id="bf" scope="session" class="transaction.BidFind" />
<% 
   int row=0;int number=0;int begin=0;int end=0;int resi=0;
   String cond[]=new String[7];
   int no=Integer.valueOf(request.getParameter("no")).intValue();
   if(no==0){       
      cond[0]=request.getParameter("begintime");
      cond[1]=request.getParameter("endtime");
      cond[2]=request.getParameter("status");
      cond[3]=request.getParameter("company_id");
      cond[4]=request.getParameter("user_id");
      cond[5]=request.getParameter("currency");
      cond[6]=request.getParameter("price_cond");
      for(int i=0;i<7;i++)if(cond[i]==null)cond[i]="";
      row=bf.getBidCount(cond);
      bf.setCond(cond);
      number=row/15;
      resi=row%15;  
   }else{
      number=Integer.valueOf(request.getParameter("number")).intValue();
      resi=Integer.valueOf(request.getParameter("resi")).intValue();      
   }
   
    if((no<number&&resi>0)||(no==number&&resi==0&&number>1)){
       begin=no*15+1;
       end=no*15+16;
    }else if((no==0&&resi>0)||(no>=number&&resi>0)){
       begin=no*15+1;
       end=no*15+resi+1;
    } 
  
    String[][] order_list=bf.getBidContent(begin,end);
    no++; 
%>
<script language="javascript">
function winclose(){
  window.close();
}
function reload(){
  window.history.back();
}
</script>

<html><!-- #BeginTemplate "/Templates/backm_paperec.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中国纸网后台管理系统</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "宋体"; font-size: 9pt}
.title12 {  font-family: "宋体"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "宋体"; text-decoration: underline}
a:visited {  font-family: "宋体"; text-decoration: underline}
a:active {  font-family: "宋体"; text-decoration: underline}
a:hover {  font-family: "宋体"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>

<script language="javascript">
   function show(url){
      window.open(url,'quote','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=630,height=210')
             }
</script>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>    
      <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
        <tr> 
          <td colspan="10" class="title12">订单列表：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      
      <%  if(no==1&&resi!=0&&number>0){    %> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="query_success.jsp?no=<%=no%>&number=<%=number%>&resi=<%=resi%>">下一页</a>
      <%  } 
          if(no>1&&no<=number&&resi!=0){    %>   
          <a href="javascript:reload()" >上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="query_success.jsp?no=<%=no%>&number=<%=number%>&resi=<%=resi%>">下一页</a>
      <%  }
          if((no>1&&no>number)||(no>1&&no==number&&resi==0)){                %>      
          <a href="javascript:reload()">上一页</a>
      <%  }              %>    
          </td>
        </tr>
        <tr align="center"> 
          <td><b> 发布号</b></td>
          <td><b>报价号</b></td>
          <td><b>报价用户</b></td>
          <td><b>相关报价号</b></td>
          <td><b>相关用户</b></td>
          <td><b>报价时间</b></td>
          <td><b>币种</b></td>
          <td><b>合同总额</b></td>
          <td><b>价格条款</b></td>
          <td><b>状态</b></td>
        </tr>
        <% for (int i=0;i<end-begin;i++){
        %>
        <tr align="center"> 
          <td><a href="htofferposting_yj.jsp?posting_id=<%=order_list[i][0]%>"><%=order_list[i][0]%></a></td>
          <td><a href="javascript:show('htbidcontent.jsp?bid_id=<%=order_list[i][1]%>')"><%=order_list[i][1]%></a></td>
          <td><%=order_list[i][2]%></td>
          <td><%=order_list[i][3]%></td>
          <td><%=order_list[i][4]%></td>
          <td><%=order_list[i][5]%></td>
          <td><%=order_list[i][6]%></td>
          <td><%=order_list[i][7]%></td>
          <td><%=order_list[i][8]%></td>
          <td><%=order_list[i][9]%></td>
        </tr>
        <% }%>
        
      </table>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

<%    bf.getDestroy(); %>
</jsp:useBean>
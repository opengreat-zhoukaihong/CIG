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


<%@ page import="java.util.*" language="java" %> 
<jsp:useBean id="prov" scope="page" class="member.HtBargain" />
<%   
     String posting_id=request.getParameter("posting_id");
     prov.setPostingid(posting_id);
     String lang_code="GB";     
     prov.setLangcode(lang_code);
     String[][] allbid=prov.getAllBid();        
     String[] str=prov.getAllResult();
     Vector ve=prov.getVe();
     String[][] arr=prov.getArr();   
     int ij=ve.size();    
     int i=ij/3; 
     int j=ij%3;   
  %> 

<script language="javascript">
   function show(url){
      window.open(url,'quote','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=630,height=180')
             }
</script>             

<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
.title12 {  font-family: "宋体"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  text-decoration: none; color: #000000; font-family: "宋体"}
a:visited {  text-decoration: none; color: #000000; font-family: "宋体"}
a:active {  text-decoration: none; color: #000000; font-family: "宋体"}
a:hover {  color: #330099; text-decoration: underline; font-family: "宋体"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "宋体"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr> 
    <td valign="top"><!-- #BeginEditable "body" --> 
      <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr bordercolor="#FFFFFF"> 
          <td height="295"> 
            <table width="600" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#4078E0" bordercolordark="#FFFFFF">
              <tr> 
                <td colspan="3" height="25" class="title12"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1"></b></font>供应议价信息</td>
              </tr>
              <tr> 
                <td width="200" class="dan10">　订单号：<%=posting_id %></td>
                <td colspan="2" class="dan10"><%=str[0] %>&gt;<%=str[1] %>&gt;<%=str[2] %></td>
              </tr>
              <tr> 
                <td width="258" class="dan10">　产品规格：</td>
                <td width="258" class="dan10">&nbsp;</td>
                <td width="84" class="dan10">&nbsp;</td>
              </tr>
              <%    int mn=0; 
             
             for(int m=0;m<i;m++){       %> 
              <tr> <%  for(int n=0;n<3;n++){
                     mn=m*3+n;
                    if(arr[mn][1].equals("")){   
                              %> 
                <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: 
                  <%=arr[mn][0]%> </td>
                <%  }else{  %> 
                <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: 
                  <%=arr[mn][0]%>--<%=arr[mn][1]%> <%=arr[mn][2]%></td>
                <%  }     }    %> 
                
              </tr>
              <%       }  %> 
              <tr> <%  for(int n=0;n<j;n++){ 
                         mn+=n;
                         if(arr[mn][1].equals("")){   
                              %> 
                <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: 
                  <%=arr[mn][0]%> </td>
                <%  }else{  %> 
                <td width="258" class="dan10" align="center"><%=ve.elementAt(mn)%>: 
                  <%=arr[mn][0]%>--<%=arr[mn][1]%> <%=arr[mn][2]%></td>
                <%  }  }
                         int in=3-j;
                         for(int q=0;q<in;q++){ %> 
                <td width="84" class="dan10">&nbsp;</td>
                <%     }  %> </tr>
              <tr> 
                <td width="258" class="dan10">&nbsp;</td>
                <td width="258" class="dan10">&nbsp;</td>
                <td width="84" class="dan10">&nbsp;</td>
              </tr>
              <tr> 
                <td width="258" class="dan10">　产品品牌：<%=str[3] %></td>
                <td width="258" class="dan10"> 产品产地：<%=str[4] %></td>
                <td width="258" class="dan10"> 样品库编号：<%=str[5] %></td>
              </tr>
            </table>
            <table width="600" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#4078E0" bordercolordark="#FFFFFF">
              <tr> 
                <td colspan="8" class="title12" height="20"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1"></b></font><b>报价活动</b></td>
              </tr>
              <tr> 
                <td colspan="8" class="dan10" height="20"><font color="#FFFFFF" class="big"><b><img src="../../images/space.gif" width="5" height="1"></b></font><b><font color="#FFCC33"></font></b></td>
              </tr>
              <tr> 
                <td width="70" class="dan10" align="center"><b>报价ID</b></td>
                <td width="65" class="dan10" align="center"><b>报价用户ID</b></td>
                <td width="65" class="dan10" align="center"><b>相关报价ID</b></td>
                <td width="70" class="dan10" align="center"><b>相关报价用户ID</b></td>
                <td width="78" class="dan10" align="center"><b>报价时间</b></td>
                <td width="60" class="dan10" align="center"><b>报价</b></td>
                <td width="60" class="dan10" align="center"><b>数量</b></td>
                <td width="30" class="dan10" align="center"><b>状态</b></td>
              </tr>
              <% for( in=0;in<allbid.length;in++){  %> 
              <tr> 
                <td width="70" class="dan10" align="center"><a href="javascript:show('htbidcontent.jsp?bid_id=<%=allbid[in][0]%>')"><%=allbid[in][0]%></a></td>
                <td width="65" class="dan10" align="center"><%=allbid[in][1]%></td>
                <td width="65" class="dan10" align="center"><%=allbid[in][2]%></td>
                <td width="70" class="dan10" align="center"><%=allbid[in][3]%></td>
                <td width="78" class="dan10" align="center"><%=allbid[in][4]%></td>
                <td width="60" class="dan10" align="center"><%=allbid[in][5]%><%=allbid[in][9]%>/<%=allbid[in][8]%></td>
                <td width="60" class="dan10" align="center"><%=allbid[in][6]%><%=allbid[in][8]%></td>
                <td width="30" class="dan10" align="center"><%=allbid[in][7]%></td>
              </tr>
              <%  }  %> 
            </table>
          </td>
        </tr>
      </table>
      <div align="center"><br>
      </div>
      
    </td>
  </tr>
</table><!-- #EndEditable -->
</td> </tr> 
</body>
</html>
<%    prov.getDestroy(); %>
</jsp:useBean>
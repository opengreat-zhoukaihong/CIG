
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

  funcId = "fnMemberMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<%@ page  language="java" %>
<jsp:useBean id="membus" scope="page" class="member.MemberUsers" /> 
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
<jsp:setProperty name="membus" property="*" />
<%  
   String content="";int ret=5; 
   String user_id=request.getParameter("user_id");
   String lang_code=request.getParameter("lang_code");
   String[] submit=new String[6];
   String login="";String title="";String detial="";   
  if(!lang_code.equals("mimasz")){ 
        
        
        submit[0]=request.getParameter("firstname");
        submit[1]=request.getParameter("lastname");
        submit[2]=request.getParameter("address1");
        submit[3]=request.getParameter("address2");
        submit[4]=request.getParameter("priviledge");
        submit[5]=request.getParameter("credit");
        ret=membus.getPriviledge(submit[4]);  
        login=membus.getLogin();
        content=membus.getSubmit(submit);
        if(content.equals("1")){
          
             if(ret!=0){
               inqu.setUser_id(user_id);
               
               if(inqu.getUserLang().equals("GB")){
                
                  if(ret==1){
                  
                     title="���ѻ��׼��Ϊ�й�ֽ����ʽ��Ա";
                    detial="�𾴵��û���"+
                           "\n\n    �û�����"+login+
                           "\n\n    ��ϲ����Ϊ�й�ֽ����ʽ��Ա��������Ϊ����ͨ�˽��׹��ܡ����"+
                           "��http://www.paperec.com�������ǵ���ҳ�����������û����������"+
                           "¼�����Ա���򣬽������Ľ��׻��"+
                           "\n\n    ������Ϊ����֯�ڵ����û�ע��ģ���������֯�ڻ���Ҫ��������"+
                           "ԱҲ���ڱ��������ף���������������������û������Ա������ڱ���"+
                           "ע���ʱ�����룬������֤�����Żḳ�����ǽ���Ȩ��"+
                           "����Ĺ���ʱ�䣬��Ҳ�ɴ�绰�����ǻ�ȡ������ Tel:755-3691610"+
                           "\n\n    ��Ϊ���û��������������������͵�һ����ѵ������䡣�ʺ�Ϊ:"+
                           login+"@mail.paperec.com    ����������"+
                           "��Ա�ʺ�������ͬ������ʺ����ѿ�ͨ����¼������վ�����Ա����"+
                           "'�ҵ�ֽ��'ҳ�棬���ҷ��������������ڽ��롣"+
                           "\n\n    ���ǵ���ҳ���ṩ��һ����̬������ʾ��Ӱ���ܹ�ʹ����������"+
                           "���׷�������������ʱ��ۿ����ڽ��׹����У�������в�����ĵ�"+
                           "��������ʱ���'��ȡ����'�������ҳ����ָ������Ȼ����һ��"+
                           "����Ĺ���ʱ�䣬��Ҳ�ɴ�绰�����ǻ�ȡ������ Tel:755-3691610"+                           
                           "\n\n    ף����졣"+            
                           "\n\n\n    �й�ֽ��"+
                           "\n    ��Ա�ʸ����С�� "+          
                           "\n\n    http://www.paperec.com";
                  }else if(ret==2){
                  
                    title="���ѻ��׼�����й�ֽ�������ʸ�";
                   detial="�𾴵��û���"+           
                          "\n\n    �û�����"+login+
                          "\n\n    ������֤�����ѻ��׼�����й�ֽ�������ʸ�������Ϊ����ͨ��"+
                          "���׹��ܡ�����http://www.paperec.com�������ǵ���ҳ����������"+
                          "�û����������¼�����Ա���򣬽������Ľ��׻��"+
                          "\n\n    ���ǵ���ҳ���ṩ��һ����̬������ʾ��Ӱ���ܹ�ʹ����������"+
                          "���׷�������������ʱ��ۿ����ڽ��׹����У�������в�����ĵ�"+
                          "��������ʱ�������ȡ�������������ҳ����ָ������Ȼ����һ��"+
                          "����Ĺ���ʱ�䣬��Ҳ�ɴ�绰�����ǻ�ȡ������ Tel:755-3691610"+                              
                          "\n\n    ף����졣"+            
                          "\n\n\n    �й�ֽ��"+
                          "\n    ��Ա�ʸ����С�� "+          
                          "\n\n    http://www.paperec.com";
                  }
                  
             }else{
                  if(ret==1){
                         title="Congratulations! You are now a Verified Member of PaperEC.com";
                    detial="Dear Member��"+
                           "\n\n  User Name��"+login+
                           "\n\n  Congratulations! You are now a Verified Member of "+
                           "PaperEC.com. You are now qualified to engage in transactions on "+
                           "PaperEC.com.  Using your user name and password, you can log "+
                           "into the members area of PaperEC.com to begin your online transactions."+
                           "\n\n  You are registered as the primary contact within your "+
                           "organization, other persons in your organization who wish to "+
                           "register on PaperEC.com can provide your user name to be "+
                           "qualified to engage in transactions."+
                           "\n\n  As the primary contact, you are provided a free email box. Your email address is "+
                           login+"@paperec.com. The password for your "+
                           "email is the same used to your membership account. "+
                           "\n\n  A 'Transaction Demo' is available on the homepage of "+
                           "PaperEC.com. If you have any questions, Please click on 'Help'."+
                           "You may also call us at +86-755-369-1610 during the working "+
                           "hours of Monday through Friday."+                           
                           "\n\n\nBest Regards, "+            
                           "\n\nPaperEC.com."+       
                           "\n\nhttp://www.paperec.com";
                  }else if(ret==2){
                    title="Congratulations! You are now qualified to engage in transactions on PaperEC.com";
                   detial="Dear Member��"+           
                          "\n\n  User Name:"+login+
                          "\n\n  Through the system verification, you are qualified to engage "+
                          "in transactions on PaperEC.com. Your account has already been "+
                          "activated. Using your user name and password, you can log into "+
                          "the members area of PaperEC.com to begin your online transactions."+
                          "\n\n  A 'Transaction Demo' is available on the homepage of "+
                          "PaperEC.com. If you have any questions, Please click on 'Help'."+
                          "You may also call us at +86-755-369-1610 during the working "+
                          " hours of Monday through Friday. "+                              
                          "\n\n\nBest Regards, "+            
                          "\n\n\nPaperEC.com."+                                
                          "\n\nhttp://www.paperec.com";
                  }
             }                          
                            
           inqu.setTitle(title);
           inqu.setDetail (detial);
           inqu.getSingleMess();          
          }
           content="�����޸ĳɹ���";  
        }else{
           content="���ݿ��������Ժ����ԣ�";
        }   
    }else{
       login=request.getParameter("login");
     }  
%>

<script language="javascript">
   function back(){
    window.history.back()
    }
</script>   
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>�й�ֽ����̨����ϵͳ</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "����"; font-size: 9pt}
.title12 {  font-family: "����"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "����"; text-decoration: underline}
a:visited {  font-family: "����"; text-decoration: underline}
a:active {  font-family: "����"; text-decoration: underline}
a:hover {  font-family: "����"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675"> 
  <tr>    
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <form method="post" action="">
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" height="300" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr align="center"> 
        <%  if(lang_code.equals("mimasz")){ %>
            <td class="title12" height="249"><%=membus.getMimaModi(login)%></td>
        <%  }else{ %>  
            <td class="title12" height="249"><%=content%></td>
        <%   }  %>  
          </tr>
          <tr align="center"> 
            <td class="title12">
            <a href="" onclick="javascript:back()">  <input type="image" border="0" name="imageField" src="../images/back.gif" width="68" height="26"></a>
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
<!-- #EndTemplate -->
</html>
</jsp:useBean>
 <%@ page import="java.sql.*" language="java" %> 
 <jsp:useBean id="seller" scope="page" class="mypaperec.SellerApp" />  
 <jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
 <jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />  

<%  
   int jud=0;
   String con=""; String detial="";String title="";  
   String user_id=UserInfo.getUserId();
   seller.setUser_id(user_id);   
   jud=seller.getApply ();   
   seller.getDestroy();
   if(jud<=0){
      con="���ݿ�����������Ժ����ԣ�"; 
   }else{
      con="��PaperEC.com�����۲�Ʒ�����������鵽�������������������������ͨ�ſ���˲Ϣ����ɣ�24Сʱ������ϵ���վʹʱ��ٳ�Ϊ���⣬�������ۿ���չ������ÿһ���䡣���Ͻύ�ͻ������н��ף���Ϊ����Լ�˴������÷��ã��������鹤������ʡ����ĳ�;ͨѶ���á���ݵĽ��ף�Ҳ��Ϊ�����ͳɱ������Ϳ�档<br><br>"+
 	  "ͨ��ע���Ϊ������Ա������������ԭ�еĻ�ԱȨ���⣬����������ר��Ȩ����<br>   "+
          "1��������Ʒ��Ӧ��Ϣ<br>"+
          "2���ɶ�PaperEC.com�ϵ�������Ϣ������ز�Ʒ��Ӧ��Ϣ��<br>"+
          "3��ͬ�л�Ӧ����ҽ�����ۡ����ܱ��ۡ��ɽ�ǩԼ�Ƚ��׻��<br>"+
          "4��ֻ����������ҳɹ���ɽ��׺���������PaperEC.com֧�����á��������<a href=\"#\" onClick=\"javascript:show('memberagreetment_s.htm')\">��ԱЭ��</a>��<br><br>"+
          "PaperEC.com�ȳ���ӭ�г��ŵĳ��̵�PaperEC�����۲�Ʒ��<br><br>"+
          "�ܿ죬���ͻ��յ�һ�⸽��������ĵ����ʼ�������ϸ��д���еı����ɺ���Դ�������ǻ򷢵����ʼ������ǡ�PaperEC.com��Ҫ֪����Щ��Ϣ������֤����͸¶�κ���Ϣ������������PaperEC.com��<a href=\"#\" onClick=\"javascript:show('../html/aboutus/aboutus_bomianq.htm')\">���ܰ�ȫ����</a>�������յ�����PaperEC.com������غ�ʵ����������ݡ�һ����ͨ����ʵ��PaperEC������Ϊ����ͨ������ò�֪ͨ����<br><br>"+
          "лл��";
   }
   
    inqu.setUser_id(user_id);
    if(inqu.getUserLang().equals("GB")){ 
        seller.setLang_code("GB");
        String[] det=seller.getContent();
        det[0]=det[0]==null?"":det[0];
        det[1]=det[1]==null?"":det[1];
       if(det[1].equals("M")){
           det[1]="����";
        }else if(det[1].equals("S")){
           det[1]="С��";
        }else{
           det[1]="��ʿ";
        }
        title="��ӭ��ע��PaperEC.com��������Ա�ʸ�";       
        detial="�𾴵�"+det[0]+det[1]+":"+
               "\n\n    ��ӭ��ע��PaperEC.com��������Ա�ʸ�"+
               "\n\n    PaperEC.com�����ڲ��������������յ�ʱ���ڣ���ɶ������ύ�ı����"+
               "�ݵĺ�ʵ������һ������������Ա�ʸ�õ���׼��PaperEC.com��Ϊ����ͨ���"+
               "���ã������Ե����ʼ���ʽ֪ͨ�������ḽ��һЩ˵��ʹ���ܸ��õ��������ǵ�"+
               "ϵͳ����Ҳ������ʱ��¼���ҵ�ֽ����ҳ�棬�鿴Ϊ�����õĸ�����Ϣ���ģ�"+
               "PaperEC.com����������������Ϣ�����ﶼ�м�¼��"+
               "\n\n    �������������Ա�ʸ���������к����ʣ����������̻��������Ա�ʸ�"+
               "������һ������Ĺ���ʱ���绰�򷢴�������ǡ�"+
               "\n\n\n    ף����졣"+
               "\n\n    PaperEC.com"+
               "\n    Tel:755-3691610 3691613"+
               "\n    Fax:755-3201877"+      
               "\n    Email:members@paperec.com"+ 
               "\n\n    http://www.paperec.com";        
            
    }else{
        seller.setLang_code("EN");
        String[] det=seller.getContent();
        det[0]=det[0]==null?"":det[0];
        det[1]=det[1]==null?"":det[1];
        if(det[1].equals("M")){
           det[1]="Mr. ";
        }else if(det[1].equals("S")){
           det[1]="Ms. ";
        }else{
           det[1]="Dr. ";
        }
        title="Thank you for applying for Seller Membership with PaperEC";       
        detial="Dear "+det[1]+det[0]+":"+
               "\n\n  Thank you for completing the application for Seller Membership!"+
               "\n\n  PaperEC.com will compelete the verification process within two working "+
               "days. Upon approval, you will receive an email notification explaining "+
               "the selling process and new features that have been added to your "+
               "account. You can view these messages at any time by signing in  \"My "+
               "PaperEC\" and clicking on \"My MessageCenter\"."+ 
               "\n\n  If you have any questions about the application procedure, or you want "+
               "to become a Seller immediately, please call us at +86-755-369-1610 or "+
               "fax at +86-755-3201877 during the working hours of Monday through Friday. "+
               "\n\n\n  Best Regards,"+ 
               "\n\n  PaperEC.com."+
               "\n  Tel:+86 755-369-1610, 3691613"+
               "\n  Fax:+86 755-320-1877"+
               "\n  Email:members@paperec.com"+
               "\n\nhttp://www.paperec.com";  
    }        
         
       inqu.setTitle(title);
       inqu.setDetail (detial);
       inqu.getSingleMess();   
       inqu.getDestroy(); 
 
%>
	
<html>
<head>
<title>�ҵ�ֽ��--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "����"; font-size: 10pt}
.algin {  font-family: "����"; font-size: 10pt; line-height: 22pt}
-->
</style>
</head>


<script language="javascript">
   function show(url){
      window.open(url,'quote','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=630,height=210')
   }
</script>

<body bgcolor="#E6EDFB" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="400" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
  <tr align="right"> 
    <td><a href='javascript:window.close();'>�رմ���</a> </td>
  </tr>
  <tr align="left">
    <td>���ã���ӭ������������Ա�ʸ�</td>
  </tr>
</table>
<table cellspacing=0 cellpadding=4 width="400" border=0 bgcolor="#E6EDFB">
  <tbody> 
  <tr> 
    <td width="100%" class="algin"><%=con%>
      </td>
  </tr>
  </tbody>
</table>

<table width="400" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
  <tr align="right"> 
    <td><a href='javascript:window.close();'>�رմ���</a> </td>
  </tr>
</table>
</body>
</html>

</jsp:useBean>
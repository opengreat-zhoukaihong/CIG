 <%@ page import="java.sql.*" language="java" %> 
 <jsp:useBean id="seller" scope="page" class="mypaperec.SellerApp" />  
 <jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
 <jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />  

<%  
   int jud=0;
   String con="";String detial="";String title="";
   String user_id=UserInfo.getUserId();
   seller.setUser_id(user_id);
   jud=seller.getApply ();
   seller.getDestroy();
   if(jud<=0){
      con="System error,please try again for a moment!"; 
   }else{
      con="Selling paper products on PaperEC.com brings you many benifits. PaperEC.com eliminates borders, time zones and business hours, allowing you to expand your market reach while reducing paperwork, becoming more cost-effective and increasing profits.<br><br>"+
 	  "In addition to the standard services of PaperEC.com, as a seller you can also:<br>"+
      "1) Post an \"Offer to Sell\" your pulp and paper products.<br>"+
      "2) Post a counteroffer of a \"Request to Buy\" posting on PaperEC.com.<br>"+
      "3) Engage in transactions when buyers reply you offers. and,<br>"+
      "4) Only incur a small fee when you successfully conclude a transaction. (See details in <a href=\"#\" onClick=\"javascript:show('memberagreetment_s.htm')\">Membership Agreement</a>)<br><br>"+
         "PaperEC.com welcomes all enterprises and traders to buy and sell pulp and paper products on PaperEC.com.<br><br>"+
         "Shortly you'll receive an email with the Application Form attached. Please complete the form and send it back to PaperEC.com through email or Fax.(We apologize for this inconvenience.) PaperEC.com does not share this information with any third party (See details in <a href=\"#\" onClick=\"javascript:show('../../html/html_en/aboutus/aboutus_bomianq.htm')\">Privacy and Safety Statement</a>).<br><br>";
   }
 
  inqu.setUser_id(user_id);
    if(inqu.getUserLang().equals("GB")){ 
        seller.setLang_code("GB");
        String[] det=seller.getContent();
        det[0]=det[0]==null?"":det[0];
        det[1]=det[1]==null?"":det[1];
        if(det[1].equals("M")){
           det[1]="先生";
        }else if(det[1].equals("S")){
           det[1]="小姐";
        }else{
           det[1]="博士";
        }
        title="欢迎您注册PaperEC.com的卖方会员资格";       
        detial="尊敬的"+det[0]+det[1]+":"+
               "\n\n    欢迎您注册PaperEC.com的卖方会员资格。"+
               "\n\n    PaperEC.com将会在不超过两个工作日的时间内，完成对您所提交的表格内"+
               "容的核实工作。一旦您的卖方会员资格得到批准，PaperEC.com会为您开通相关"+
               "设置，并会以电子邮件方式通知您，还会附上一些说明使您能更好地利用我们的"+
               "系统。您也可以随时登录“我的纸网”页面，查看为您设置的个人信息中心，"+
               "PaperEC.com向您发出的所有信息在这里都有记录。"+
               "\n\n    如果您对卖方会员资格申请程序有何疑问，或您想立刻获得卖方会员资格"+
               "请在周一至周五的工作时间打电话或发传真给我们。"+
               "\n\n\n    祝您愉快。"+
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
%>
<html>
<head>
<title>PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
td {  font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; font-size: 10pt}
.algin {  font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; font-size: 10pt; line-height: 18pt}
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
    <td><a href='javascript:window.close();'>CLOSE</a> </td>
  </tr>
  <tr align="left">
    <td>Thank you for choosing to apply for PaperEC.com's Seller Membership.</td>
  </tr>
</table>
<table cellspacing=0 cellpadding=4 width="400" border=0 bgcolor="#E6EDFB">
  <tbody> 
  <tr> 
    <td width="100%" class="algin"><%=con%></td>
  </tr>
  </tbody>
</table>

<table width="400" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
  <tr align="right"> 
    <td><a href='javascript:window.close();'>CLOSE </a> </td>
  </tr>
</table>
</body>
</html>
</jsp:useBean>
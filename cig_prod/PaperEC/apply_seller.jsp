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
      con="数据库操作有误，请稍候再试！"; 
   }else{
      con="在PaperEC.com上销售产品，您会充分体验到电子商务的无穷魅力。跨地域的通信可在瞬息间完成，24小时永不间断的网站使时差不再成为问题，您的销售可伸展到世界每一角落。网上结交客户，进行交易，能为您节约了大量差旅费用，减少文书工作，节省昂贵的长途通讯费用。快捷的交易，也可为您减低成本，降低库存。<br><br>"+
 	  "通过注册成为卖方会员，您除了享有原有的会员权利外，还享有以下专有权利：<br>   "+
          "1）发布产品供应信息<br>"+
          "2）可对PaperEC.com上的需求信息发布相关产品供应信息。<br>"+
          "3）同有回应的买家进行议价、接受报价、成交签约等交易活动。<br>"+
          "4）只有在您跟买家成功达成交易后，您才须向PaperEC.com支付费用。具体详见<a href=\"#\" onClick=\"javascript:show('memberagreetment_s.htm')\">会员协议</a>。<br><br>"+
          "PaperEC.com热忱欢迎有诚信的厂商到PaperEC上销售产品。<br><br>"+
          "很快，您就会收到一封附有申请表格的电子邮件。请仔细填写其中的表格，完成后可以传真给我们或发电子邮件给我们。PaperEC.com需要知道这些信息，并保证不会透露任何信息予第三方（详见PaperEC.com的<a href=\"#\" onClick=\"javascript:show('../html/aboutus/aboutus_bomianq.htm')\">保密安全条款</a>）。在收到表格后，PaperEC.com将尽快地核实您所填的内容。一旦您通过核实，PaperEC会立刻为您开通相关设置并通知您。<br><br>"+
          "谢谢！";
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
       inqu.getDestroy(); 
 
%>
	
<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "宋体"; font-size: 10pt}
.algin {  font-family: "宋体"; font-size: 10pt; line-height: 22pt}
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
    <td><a href='javascript:window.close();'>关闭窗口</a> </td>
  </tr>
  <tr align="left">
    <td>您好！欢迎您申请卖方会员资格。</td>
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
    <td><a href='javascript:window.close();'>关闭窗口</a> </td>
  </tr>
</table>
</body>
</html>

</jsp:useBean>
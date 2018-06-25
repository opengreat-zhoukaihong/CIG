<%@ page language="java"  %>
<jsp:useBean id="succ" scope="page" class="postcenter.Bargain" />
<jsp:useBean id="inms" scope="page" class="postcenter.InserMessage" />
<%  
    String[] userdet=new String[2];
    String posting_id=request.getParameter("posting_id");
    String bid_id=request.getParameter("bid_id"); 
    String phase=request.getParameter("phase");
    String acc_userid=request.getParameter("acc_userid");
    String bid_own=request.getParameter("bid_own");
    String to_userid=request.getParameter("to_userid");  
    String retu=succ.getChange(bid_own,bid_id,phase,acc_userid);
    String cont="";
    if(retu.equals("10"))cont="    很抱歉！数据库操作有误，请稍候再试.";
    if(retu.equals("11"))cont="    很抱歉！您在以前已成交了此定单。";
    if(retu.equals("12"))cont="    很抱歉！您不具备成交的条件，请查看您与买方的议价单状态或产品数量。";
    if(retu.equals("13"))cont="    很抱歉！您不具备成交的条件，请查看您与卖方的议价单状态。";
    if(retu.equals("21"))cont="    您已经选择接受对方报价。网站会自动EMAIL通知卖方前来成交这笔交易。"+
                              "一旦卖方作出回应，PaperEC.com会自动通知您。祝您好运！";
    if(retu.equals("22"))cont="    您已经成功确认要同卖方成交这笔交易。请留意该供应发布上的交易状态。当交易状态"+
                              "处于“核准成交”时，您会看到“签订合同”按钮。您需要跟卖方签订一份电子合同。"+
                              "如果需要，本网也可提供与本次交易相关方面的协助（详见浮动导航面板上“交易服务”"+
                              "页面）。";    
    if(retu.equals("221")||retu.equals("222"))cont="    您已经成功地申请成交。按照会员协议，我们会同您联系，签定佣金支付协议。请留意您"+
                              "与买方的报价交易状态。当交易状态处于“核准成交”时，您会看到“签订合同”按钮。"+
                              "网站要求您及买方共同签定一份电子合同。同时，如果需要，我们也可提供与本次交易相"+
                              "关方面的协助（详见浮动导航面板上“交易服务”页面）。";
   
     String str=""; 
    String title="";
    String time=succ.doRetime();
    if(retu.equals("21")){          
       inms.setUser_id(to_userid);
       if(inms.getUserLang().equals("GB")){   
         succ.setLangcode("GB"); 
         succ.setUserid(to_userid); 
         userdet=succ.getUserdet();
         title="中国纸网——已有买方接受您的报价";
         str="尊敬的"+userdet[1]+userdet[0]+"："+                   
             "\n\n    在您发布的供应ID:"+posting_id+" bid ID:"+bid_id+"上进行的报价，已有买方接受。"+                     
             "\n\n\n    请访问本网，登录进入会员区域，在ID直通车输入框内直接输入"+
             "您的供应发布ID号，进入您与该买方会员的议价室，来申请成交。系"+
             "统在确认后，本网工作人员会同您及买方以电话等方式联系，来完成"+
             "这笔交易的相关手续。"+
             "\n\n    如果您需要我们的即刻服务，请在北京时间每周一至周五的上午"+
             "8:30到下午5:30与我们的交易工作部门联系："+
             "\n    电话 +86-755-3691610"+
             "\n    传真 +86-755-3201877"+
             "\n\n    祝您好运！"+
             "\n\n\n    中国纸网"+
             "\n    交易工作小组"+
             "\n\n\n    http://www.paperec.com   ";
         
          }else{
          
         succ.setLangcode("EN"); 
         succ.setUserid(to_userid); 
         userdet=succ.getUserdet();
        title="PaperEC.com-- Buyer wishes to conclude the deal regarding your posting ID#"+posting_id;
         str="Dear "+userdet[0]+userdet[1]+"："+
             "\n\n  User Name:"+succ.doRelogin(to_userid)+                        
             "\n\n  On your Offer to Sell ID#"+posting_id+" bid ID:"+bid_id+"a buyer has accepted your "+                     
             "offer. If you wish to conclude the transaction, please log "+
             "on to PaperEC.com and comfirm it by clicking on 'Accept Bid' "+
             "button on the posting's details page. PaperEC will then lead "+
             "you to the next step."+
             "\n\n  Should you need immediate assistance,  please call us "+
             "Monday through Friday between the hours of 8:30 am. and 6:00 "+
             "pm. Beijing Standard Time at +86-755-369-1613 "+             
             "\n                 +86-755-320-1877 Fax. "+
             "\n\n\nBest Regards, "+
             "\n\nPaperEC.com."+
             "\n\nhttp://www.paperec.com   ";
               }
         
          
          inms.setTitle(title);
          inms.setDetail (str);
          inms.getSingleMess();
          
          inms.setUser_id(acc_userid); 
    if(inms.getUserLang().equals("GB")){
       succ.setLangcode("GB"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet();   
       title="PaperEC.com——您已经接受供应ID:"+posting_id+"上进行的报价"; 
        str="尊敬的"+userdet[1]+userdet[0]+"："+            
            "\n\n    对供应信息ID:"+posting_id+" bid ID:"+bid_id+" 上的最后议价结果，您已经同意并接受，接受时间:"+time+"。"+        
            "\n\n    本交易系统会自动通知供应方。一旦供应方决定与您做这笔交易，"+
            "本网会另行Email通知您。您也可随时浏览本网会员区域查看。"+
            "根据会员协议，接受报价这一行为受法律约束。希望您信守您的商业行为。"+
            "\n\n    如果您需要我们的即刻服务，请在北京时间每周一至周五的上午"+
            "8:30到下午5:30与我们的交易工作部门联系："+
            "\n    电话 755-3691610"+
            "\n    传真 755-3201877"+
            "\n\n    祝您好运！"+
            "\n\n\n    PaperEC.com"+
            "\n    交易工作小组"+
            "\n\n\n    http://www.paperec.com ";             
     }else{
       succ.setLangcode("EN"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet();   
      title="PaperEC.com-- You have accepted the seller's latest offer on posting ID#"+posting_id; 
        str="Dear "+userdet[0]+userdet[1]+"："+            
            "\n\n  You have accepted the seller's bid on the posting ID#"+posting_id+"."+
            "Your acceptance of the seller's offer is legal binding, as "+
            "outlined in the Membership Agreement. The seller will be "+
            "informed automatically of this through email. "+     
            "\n  Once the seller has agreed to the deal, you will receive "+
            "an email notification."+            
            "\n\n  Should you need immediate assistance,  please call us"+
            "Monday through Friday between the hours of 8:30 am. and 6:00"+
            "pm. Beijing Standard Time at +86-755-369-1613"+
            "\n                +86-755-320-1877 Fax."+
            "\n\n\nBest Regards,"+
            "\n\nPaperEC.com."+            
            "\n\nhttp://www.paperec.com ";            
               }             
          
          inms.setTitle(title);
          inms.setDetail (str);   
          inms.getSingleMess();         
             
     }
    
    if(retu.equals("221")){ 
         String name=succ.doRelogin(to_userid);
         inms.setUser_id(to_userid);
         String lsl=""; 
         succ.setLangcode("GB"); 
         succ.setUserid(to_userid); 
         userdet=succ.getUserdet(); 
         lsl=bid_own; 
        
        if(inms.getUserLang().equals("GB")){ 
       title="PaperEC.com——供应信息ID:"+posting_id+"的发布者希望与您成交";   
         str="尊敬的"+userdet[1]+userdet[0]+"："+       
            "\n\n    供应信息ID"+posting_id+" bid ID:"+lsl+"的发布者已同意与您成交这笔交易。"+                        
            "\n\n    请访问本网，登录进入会员区域，在ID直通车输入框内直接输入"+
            "这个供应发布ID号，进入您与该卖方会员的议价室，来查看交易状态。"+
            "当交易状态为“核准成交”时，请签订一份电子合同。如果需要，本"+
            "网也可提供与本次交易相关方面的协助（详见浮动导航面板上“交易"+
            "服务”页面）。"+
            "\n\n    如果您需要我们的即刻服务，请在北京时间每周一至周五的上午"+
            "8:30到下午5:30与我们的交易工作部门联系："+
            "\n    电话 755-3691610"+
            "\n    传真 755-3201877"+
            "\n\n    祝您好运！"+
            "\n\n\n    PaperEC.com"+
            "\n    交易工作小组"+
            "\n\n\n    http://www.paperec.com";

    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(to_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- Seller Agrees to Concluding the Deal";   
        str="Dear "+userdet[0]+userdet[1]+"："+          
            "\n\n  The seller who posted Offer to Sell ID#"+posting_id+" bid ID:"+lsl+"has agreed to "+                        
            "concluding the deal with you. Please log into My PaperEC to "+
            "view your bid's status. If the status is  \"Awaiting Contract\" "+
            "mode, you will see a \"Sign Contract\" button at the bottom of "+   
            "the screen. Click this button to sign the required electronic "+
            "contract with the seller. "+         
            "\n\n  Should you need immediate assistance,  please call us "+
            "Monday through Friday between the hours of 8:30 am. and 6:00 "+
            "pm. Beijing Standard Time at +86-755-369-1613 "+            
            "\n                  +86-755-320-1877 Fax"+
            "\n\n\nBest Regards,"+
            "\n\nPaperEC.com."+            
            "\n\nhttp://www.paperec.com";
               }          
            
    
    inms.setTitle(title);
    inms.setDetail (str);
    inms.getSingleMess();
    
    inms.setUser_id(acc_userid); 
     if(inms.getUserLang().equals("GB")){ 
       succ.setLangcode("GB"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com——对您供应发布ID"+posting_id+"上买方的行为您已申请成交";   
        str="尊敬的"+userdet[1]+userdet[0]+"："+                 
            "\n\n    对买方在您发布的供应信息ID"+posting_id+" bid ID:"+lsl+"上的行为，您已经同意并申请"+ 
            "成交，申请成交时间 "+ time+                     
            "\n\n    根据会员协议，对每笔成功交易，卖方会员需向本网交纳一定的"+
            "交易服务费。我们会与您联系，鉴定一份交易费支付合同。请留意您"+
            "与买方的报价交易状态。当交易状态处于“核准成交”时，您会看到"+
            "“签订合同”按钮。网站要求您及买方共同签定一份电子合同。根据"+
            "会员协议，申请成交这一行为受法律约束。希望您信守您的商业行为。"+
            
            "\n\n    如果您需要我们的即刻服务，请在北京时间每周一至周五的上午"+
            "8:30到下午5:30与我们的交易工作部门联系："+
            "\n    电话 755-3691610"+
            "\n    传真 755-3201877"+
            "\n\n    祝您好运！"+
            "\n\n\n    PaperEC.com"+
            "\n    交易工作小组"+
            "\n\n\n    http://www.paperec.com"; 
    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- You have agreed to the buyer's conditions on your posting ID#"+posting_id;   
        str="Dear "+userdet[0]+userdet[1]+"："+                                    
            "\n\n  You have agreed to the buyer's conditions on your posting ID#"+posting_id+" bid ID:"+lsl+"."+ 
            "Your acceptance of the buyer's bid is legal binding, as outlined "+  
            "in the Membership Agreement. Shortly, you will receive an email "+ 
            "confirming this, and the buyer will also receive an email "+
            "notification. PaperEC.com will contact the buyer to discuss "+
            "details on this transaction. PaperEC can provide all the foreign "+
            "trade services to buyers in Mainland China who do not have "+
            "foreign trade rights authorized by the goverment, or who just "+
            "want assistance with the import process. (For details, see "+
            "'Services' on the floating pilot panel.) "+                   
            "\n\n  If the buyer confirms the trade and needs our importing  "+
            "services, you and the buyer will be required to sign an  "+
            "electronic contract online.(Please pay attention to your bid's status. "+
            "If the bid's status is  \"Awaiting Contract\", you will see a "+
            "\"Sign Contract\" button.) PaperEC's importer subsidiary will then, "+
            "according to the terms you and the buyer both have reached, assist"+
            "in the import process."+
            "\n\n  If the buyer wishes to complete this trade with you directly, "+
            "you and the buyer will be required to sign an electronic "+
            "contract online. According to the Membership Agreement, you will "+
            "be required to sign an agreement for the Payment of the "+
            "Transaction Fee associated with this deal to PaperEC.com.  "+
            
            "\n\n  Should you need immediate assistance,  please call us "+
            "Monday through Friday between the hours of 8:30 am. and 6:00 "+
            "pm. Beijing Standard Time at +86-755-369-1613 "+
            "\n              +86-755-320-1877 Fax."+
            "\n\n\nBest Regards,"+
            "\n\nPaperEC.com."+
            "\n\nhttp://www.paperec.com"; 
               }               
               
    
     inms.setTitle(title);
    inms.setDetail (str);   
    inms.getSingleMess();  
          }  
            
   if(retu.equals("22")){
     inms.setUser_id(acc_userid); 
     if(inms.getUserLang().equals("GB")){ 
       succ.setLangcode("GB"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com——您已经确认与供应信息ID"+posting_id+" 的发布者成交";   
        str="尊敬的"+userdet[1]+userdet[0]+"："+                 
            "\n\n    供应信息ID"+posting_id+" 的发布者已接受您的报价并希望与您成交这笔交易，"+ 
            "对该行为您已确认。请留意该供应发布上的交易状态。当交易状态处于 "+    
            "“核准成交”时，您会看到“签订合同”按钮。您需要跟卖方签订一份电子"+  
            "合同。如果需要，本网也可提供与本次交易相关方面的协助（详见浮动导航"+
            "面板上“交易服务”页面）。根据会员协议，确认成交这一行为受法律约束，"+
            "请信守您的商业行为。"+  
            "\n\n    如果您需要我们的即刻服务，请在北京时间每周一至周五的上午"+
            "8:30到下午5:30与我们的交易工作部门联系："+
            "\n    电话 755-3691610"+
            "\n    传真 755-3201877"+
            "\n\n    祝您好运！"+
            "\n\n\n    PaperEC.com"+
            "\n    交易工作小组"+
            "\n\n\n    http://www.paperec.com"; 
    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- You Have Re-confirmed the Deal on Posting ID#"+posting_id;   
        str="Dear "+userdet[0]+userdet[1]+"："+
            "\n\n  On the posting ID#"+posting_id+" , the poster has accepted your bid. You have "+ 
            "re-confirmed this deal with the seller. Your re-confirmation of  "+  
            "the deal is legal binding, as outlined in the Membership Agreement. "+ 
            "Please pay attention to your bid's status. If the transaction is in "+
            "\"Awaiting Contract\" status, you will see a \"Sign Contract\" button. Click "+
            "this button to sign the required electronic contract with the seller. "+
            "\n\n  Should you need immediate assistance,  please call us "+
            "Monday through Friday between the hours of 8:30 am. and 6:00 "+
            "pm. Beijing Standard Time at +86-755-369-1613 "+
            "\n              +86-755-320-1877 Fax."+
            "\n\n\nBest Regards,"+
            "\n\nPaperEC.com."+
            "\n\nhttp://www.paperec.com"; 
               }               
               
    
     inms.setTitle(title);
    inms.setDetail (str);   
    inms.getSingleMess();       
    
    } 
           
    if(retu.equals("222")){         
       inms.setUser_id(to_userid);
         String lsl=""; 
         succ.setLangcode("GB"); 
         succ.setUserid(to_userid); 
         userdet=succ.getUserdet(); 
         lsl=bid_id;
        
        if(inms.getUserLang().equals("GB")){ 
       title="PaperEC.com——供应信息ID:"+posting_id+"的发布者希望与您成交";   
         str="尊敬的"+userdet[1]+userdet[0]+"："+       
            "\n\n    供应信息ID"+posting_id+" bid ID:"+lsl+"的发布者对您的购买报价已经同意，并申请"+  
            "与您成交这笔交易。"+                      
            "\n\n    请访问本网，登录进入会员区域，在ID直通车输入框内直接输入"+
            "这个供应发布ID号，进入您与该卖方会员的议价室，来确认这笔交易。"+            
            "\n\n    如果您需要我们的即刻服务，请在北京时间每周一至周五的上午"+
            "8:30到下午5:30与我们的交易工作部门联系："+
            "\n    电话 755-3691610"+
            "\n    传真 755-3201877"+
            "\n\n    祝您好运！"+
            "\n\n\n    PaperEC.com"+
            "\n    交易工作小组"+
            "\n\n\n    http://www.paperec.com";

    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(to_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- Seller has accepted your bid";   
        str="Dear "+userdet[0]+userdet[1]+"："+          
            "\n\n  The seller who posted Offer to Sell ID#"+posting_id+" bid ID:"+lsl+" has accepted your "+                        
            "bid. Please log into My PaperEC, enter the postings' details  "+
            "page, and re-confirm this deal. "+                   
            "\n\n  Should you need immediate assistance,  please call us "+
            "Monday through Friday between the hours of 8:30 am. and 6:00 "+
            "pm. Beijing Standard Time at +86-755-369-1613 "+            
            "\n                  +86-755-320-1877 Fax"+
            "\n\n\nBest Regards,"+
            "\n\nPaperEC.com."+            
            "\n\nhttp://www.paperec.com";
               }          
            
    
    inms.setTitle(title);
    inms.setDetail (str);
    inms.getSingleMess();
    
    inms.setUser_id(acc_userid); 
     if(inms.getUserLang().equals("GB")){ 
       succ.setLangcode("GB"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com——对您供应发布ID"+posting_id+"上买方的行为您已申请成交";   
        str="尊敬的"+userdet[1]+userdet[0]+"："+                 
            "\n\n    对买方在您发布的供应信息ID"+posting_id+" bid ID:"+lsl+"上的行为，您已经同意并申请"+ 
            "成交，申请成交时间 "+ time+                     
            "\n\n    根据会员协议，对每笔成功交易，卖方会员需向本网交纳一定的"+
            "交易服务费。我们会与您联系，鉴定一份交易费支付合同。请留意您"+
            "与买方的报价交易状态。当交易状态处于“核准成交”时，您会看到"+
            "“签订合同”按钮。网站要求您及买方共同签定一份电子合同。根据"+
            "会员协议，申请成交这一行为受法律约束。希望您信守您的商业行为。"+
            
            "\n\n    如果您需要我们的即刻服务，请在北京时间每周一至周五的上午"+
            "8:30到下午5:30与我们的交易工作部门联系："+
            "\n    电话 755-3691610"+
            "\n    传真 755-3201877"+
            "\n\n    祝您好运！"+
            "\n\n\n    PaperEC.com"+
            "\n    交易工作小组"+
            "\n\n\n    http://www.paperec.com"; 
    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- You have agreed to the buyer's conditions on your posting ID#"+posting_id;   
        str="Dear "+userdet[0]+userdet[1]+"："+
            "\n\n  You have agreed to the buyer's conditions on your posting ID#"+posting_id+" bid ID:"+lsl+"."+ 
            "Your acceptance of the buyer's bid is legal binding, as outlined "+  
            "in the Membership Agreement. Shortly, you will receive an email "+ 
            "confirming this, and the buyer will also receive an email "+
            "notification. PaperEC.com will contact the buyer to discuss "+
            "details on this transaction. PaperEC can provide all the foreign "+
            "trade services to buyers in Mainland China who do not have "+
            "foreign trade rights authorized by the goverment, or who just "+
            "want assistance with the import process. (For details, see "+
            "'Services' on the floating pilot panel.) "+                   
            "\n\n  If the buyer confirms the trade and needs our importing  "+
            "services, you and the buyer will be required to sign an  "+
            "electronic contract online.(Please pay attention to your bid's status. "+
            "If the bid's status is  \"Awaiting Contract\", you will see a "+
            "\"Sign Contract\" button.) PaperEC's importer subsidiary will then, "+
            "according to the terms you and the buyer both have reached, assist"+
            "in the import process."+
            "\n\n  If the buyer wishes to complete this trade with you directly, "+
            "you and the buyer will be required to sign an electronic "+
            "contract online. According to the Membership Agreement, you will "+
            "be required to sign an agreement for the Payment of the "+
            "Transaction Fee associated with this deal to PaperEC.com.  "+
            
            "\n\n  Should you need immediate assistance,  please call us "+
            "Monday through Friday between the hours of 8:30 am. and 6:00 "+
            "pm. Beijing Standard Time at +86-755-369-1613 "+
            "\n              +86-755-320-1877 Fax."+
            "\n\n\nBest Regards,"+
            "\n\nPaperEC.com."+
            "\n\nhttp://www.paperec.com"; 
     }               
               
    
     inms.setTitle(title);
    inms.setDetail (str);   
    inms.getSingleMess();       
    
    }
            %>
    
<script><!--
    function reload(){
      
       window.history.back()
         }

//--></script>
    
<html>
<!-- #BeginTemplate "/Templates/paperec_templares.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
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
<script language="JavaScript">
function openForeignX(url){   
        OpenWindow=window.open(url, "foreignXwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,resizable=no,menubar=no,width=142,height=230");
}

function openMeasConv(url){   
        OpenWindow=window.open(url, "measConvwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no,width=300,height=300");
}
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr> 
    <td width="159"> 
      <script language="JavaScript" src="../../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../images/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="product_list.jsp" class="font9"><font color="#000000">供应发布</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="request2buy.jsp"><font color="#000000">需求发布</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="order_search.jsp"><font color="#000000">浏览供需</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">我的客户</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="product_list.jsp"><font color="#000000">我的产品</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">ID直通车</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="进入">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('../foreignX.htm')"><font color="#FFFFFF">外汇汇率换算</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="../jiaoyifu.htm"><font color="#FFFFFF">交易服务</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('../huansuanresult.jsp')"><font color="#FFFFFF">计量单位转换</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../../images/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </td>
    <td valign="top"><!-- #BeginEditable "body" -->
      <table width="270" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF" align="center">
        <tr bordercolor="#FFFFFF" valign="top">  
          <td height="172">   
             <table width="300" border="0" cellspacing="0" cellpadding="0" align="left">
              <tr align="center" bgcolor="#E6EDFB"> 
                <td class="font9" height="185"><%=cont%></td>
              </tr>
              <tr bgcolor="#4078E0" align="center"> 
                <td height="25"> 
                  <input type="submit" name="Submit2" value="返回" onclick="reload()">
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>
<%succ.getDestroy();%>
<%inms.getDestroy();%>
</jsp:useBean>
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
    if(retu.equals("10"))cont="    �ܱ�Ǹ�����ݿ�����������Ժ�����.";
    if(retu.equals("11"))cont="    �ܱ�Ǹ��������ǰ�ѳɽ��˴˶�����";
    if(retu.equals("12"))cont="    �ܱ�Ǹ�������߱��ɽ�����������鿴�����򷽵���۵�״̬���Ʒ������";
    if(retu.equals("13"))cont="    �ܱ�Ǹ�������߱��ɽ�����������鿴������������۵�״̬��";
    if(retu.equals("21"))cont="    ���Ѿ�ѡ����ܶԷ����ۡ���վ���Զ�EMAIL֪ͨ����ǰ���ɽ���ʽ��ס�"+
                              "һ������������Ӧ��PaperEC.com���Զ�֪ͨ����ף�����ˣ�";
    if(retu.equals("22"))cont="    ���Ѿ��ɹ�ȷ��Ҫͬ�����ɽ���ʽ��ס�������ù�Ӧ�����ϵĽ���״̬��������״̬"+
                              "���ڡ���׼�ɽ���ʱ�����ῴ����ǩ����ͬ����ť������Ҫ������ǩ��һ�ݵ��Ӻ�ͬ��"+
                              "�����Ҫ������Ҳ���ṩ�뱾�ν�����ط����Э�������������������ϡ����׷���"+
                              "ҳ�棩��";    
    if(retu.equals("221")||retu.equals("222"))cont="    ���Ѿ��ɹ�������ɽ������ջ�ԱЭ�飬���ǻ�ͬ����ϵ��ǩ��Ӷ��֧��Э�顣��������"+
                              "���򷽵ı��۽���״̬��������״̬���ڡ���׼�ɽ���ʱ�����ῴ����ǩ����ͬ����ť��"+
                              "��վҪ�������򷽹�ͬǩ��һ�ݵ��Ӻ�ͬ��ͬʱ�������Ҫ������Ҳ���ṩ�뱾�ν�����"+
                              "�ط����Э�������������������ϡ����׷���ҳ�棩��";
   
     String str=""; 
    String title="";
    String time=succ.doRetime();
    if(retu.equals("21")){          
       inms.setUser_id(to_userid);
       if(inms.getUserLang().equals("GB")){   
         succ.setLangcode("GB"); 
         succ.setUserid(to_userid); 
         userdet=succ.getUserdet();
         title="�й�ֽ�����������򷽽������ı���";
         str="�𾴵�"+userdet[1]+userdet[0]+"��"+                   
             "\n\n    ���������Ĺ�ӦID:"+posting_id+" bid ID:"+bid_id+"�Ͻ��еı��ۣ������򷽽��ܡ�"+                     
             "\n\n\n    ����ʱ�������¼�����Ա������IDֱͨ���������ֱ������"+
             "���Ĺ�Ӧ����ID�ţ�����������򷽻�Ա������ң�������ɽ���ϵ"+
             "ͳ��ȷ�Ϻ󣬱���������Ա��ͬ�������Ե绰�ȷ�ʽ��ϵ�������"+
             "��ʽ��׵����������"+
             "\n\n    �������Ҫ���ǵļ��̷������ڱ���ʱ��ÿ��һ�����������"+
             "8:30������5:30�����ǵĽ��׹���������ϵ��"+
             "\n    �绰 +86-755-3691610"+
             "\n    ���� +86-755-3201877"+
             "\n\n    ף�����ˣ�"+
             "\n\n\n    �й�ֽ��"+
             "\n    ���׹���С��"+
             "\n\n\n    http://www.paperec.com   ";
         
          }else{
          
         succ.setLangcode("EN"); 
         succ.setUserid(to_userid); 
         userdet=succ.getUserdet();
        title="PaperEC.com-- Buyer wishes to conclude the deal regarding your posting ID#"+posting_id;
         str="Dear "+userdet[0]+userdet[1]+"��"+
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
       title="PaperEC.com�������Ѿ����ܹ�ӦID:"+posting_id+"�Ͻ��еı���"; 
        str="�𾴵�"+userdet[1]+userdet[0]+"��"+            
            "\n\n    �Թ�Ӧ��ϢID:"+posting_id+" bid ID:"+bid_id+" �ϵ������۽�������Ѿ�ͬ�Ⲣ���ܣ�����ʱ��:"+time+"��"+        
            "\n\n    ������ϵͳ���Զ�֪ͨ��Ӧ����һ����Ӧ��������������ʽ��ף�"+
            "����������Email֪ͨ������Ҳ����ʱ���������Ա����鿴��"+
            "���ݻ�ԱЭ�飬���ܱ�����һ��Ϊ�ܷ���Լ����ϣ��������������ҵ��Ϊ��"+
            "\n\n    �������Ҫ���ǵļ��̷������ڱ���ʱ��ÿ��һ�����������"+
            "8:30������5:30�����ǵĽ��׹���������ϵ��"+
            "\n    �绰 755-3691610"+
            "\n    ���� 755-3201877"+
            "\n\n    ף�����ˣ�"+
            "\n\n\n    PaperEC.com"+
            "\n    ���׹���С��"+
            "\n\n\n    http://www.paperec.com ";             
     }else{
       succ.setLangcode("EN"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet();   
      title="PaperEC.com-- You have accepted the seller's latest offer on posting ID#"+posting_id; 
        str="Dear "+userdet[0]+userdet[1]+"��"+            
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
       title="PaperEC.com������Ӧ��ϢID:"+posting_id+"�ķ�����ϣ�������ɽ�";   
         str="�𾴵�"+userdet[1]+userdet[0]+"��"+       
            "\n\n    ��Ӧ��ϢID"+posting_id+" bid ID:"+lsl+"�ķ�������ͬ�������ɽ���ʽ��ס�"+                        
            "\n\n    ����ʱ�������¼�����Ա������IDֱͨ���������ֱ������"+
            "�����Ӧ����ID�ţ����������������Ա������ң����鿴����״̬��"+
            "������״̬Ϊ����׼�ɽ���ʱ����ǩ��һ�ݵ��Ӻ�ͬ�������Ҫ����"+
            "��Ҳ���ṩ�뱾�ν�����ط����Э�������������������ϡ�����"+
            "����ҳ�棩��"+
            "\n\n    �������Ҫ���ǵļ��̷������ڱ���ʱ��ÿ��һ�����������"+
            "8:30������5:30�����ǵĽ��׹���������ϵ��"+
            "\n    �绰 755-3691610"+
            "\n    ���� 755-3201877"+
            "\n\n    ף�����ˣ�"+
            "\n\n\n    PaperEC.com"+
            "\n    ���׹���С��"+
            "\n\n\n    http://www.paperec.com";

    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(to_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- Seller Agrees to Concluding the Deal";   
        str="Dear "+userdet[0]+userdet[1]+"��"+          
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
      title="PaperEC.com����������Ӧ����ID"+posting_id+"���򷽵���Ϊ��������ɽ�";   
        str="�𾴵�"+userdet[1]+userdet[0]+"��"+                 
            "\n\n    �������������Ĺ�Ӧ��ϢID"+posting_id+" bid ID:"+lsl+"�ϵ���Ϊ�����Ѿ�ͬ�Ⲣ����"+ 
            "�ɽ�������ɽ�ʱ�� "+ time+                     
            "\n\n    ���ݻ�ԱЭ�飬��ÿ�ʳɹ����ף�������Ա����������һ����"+
            "���׷���ѡ����ǻ�������ϵ������һ�ݽ��׷�֧����ͬ����������"+
            "���򷽵ı��۽���״̬��������״̬���ڡ���׼�ɽ���ʱ�����ῴ��"+
            "��ǩ����ͬ����ť����վҪ�������򷽹�ͬǩ��һ�ݵ��Ӻ�ͬ������"+
            "��ԱЭ�飬����ɽ���һ��Ϊ�ܷ���Լ����ϣ��������������ҵ��Ϊ��"+
            
            "\n\n    �������Ҫ���ǵļ��̷������ڱ���ʱ��ÿ��һ�����������"+
            "8:30������5:30�����ǵĽ��׹���������ϵ��"+
            "\n    �绰 755-3691610"+
            "\n    ���� 755-3201877"+
            "\n\n    ף�����ˣ�"+
            "\n\n\n    PaperEC.com"+
            "\n    ���׹���С��"+
            "\n\n\n    http://www.paperec.com"; 
    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- You have agreed to the buyer's conditions on your posting ID#"+posting_id;   
        str="Dear "+userdet[0]+userdet[1]+"��"+                                    
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
      title="PaperEC.com�������Ѿ�ȷ���빩Ӧ��ϢID"+posting_id+" �ķ����߳ɽ�";   
        str="�𾴵�"+userdet[1]+userdet[0]+"��"+                 
            "\n\n    ��Ӧ��ϢID"+posting_id+" �ķ������ѽ������ı��۲�ϣ�������ɽ���ʽ��ף�"+ 
            "�Ը���Ϊ����ȷ�ϡ�������ù�Ӧ�����ϵĽ���״̬��������״̬���� "+    
            "����׼�ɽ���ʱ�����ῴ����ǩ����ͬ����ť������Ҫ������ǩ��һ�ݵ���"+  
            "��ͬ�������Ҫ������Ҳ���ṩ�뱾�ν�����ط����Э���������������"+
            "����ϡ����׷���ҳ�棩�����ݻ�ԱЭ�飬ȷ�ϳɽ���һ��Ϊ�ܷ���Լ����"+
            "������������ҵ��Ϊ��"+  
            "\n\n    �������Ҫ���ǵļ��̷������ڱ���ʱ��ÿ��һ�����������"+
            "8:30������5:30�����ǵĽ��׹���������ϵ��"+
            "\n    �绰 755-3691610"+
            "\n    ���� 755-3201877"+
            "\n\n    ף�����ˣ�"+
            "\n\n\n    PaperEC.com"+
            "\n    ���׹���С��"+
            "\n\n\n    http://www.paperec.com"; 
    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- You Have Re-confirmed the Deal on Posting ID#"+posting_id;   
        str="Dear "+userdet[0]+userdet[1]+"��"+
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
       title="PaperEC.com������Ӧ��ϢID:"+posting_id+"�ķ�����ϣ�������ɽ�";   
         str="�𾴵�"+userdet[1]+userdet[0]+"��"+       
            "\n\n    ��Ӧ��ϢID"+posting_id+" bid ID:"+lsl+"�ķ����߶����Ĺ��򱨼��Ѿ�ͬ�⣬������"+  
            "�����ɽ���ʽ��ס�"+                      
            "\n\n    ����ʱ�������¼�����Ա������IDֱͨ���������ֱ������"+
            "�����Ӧ����ID�ţ����������������Ա������ң���ȷ����ʽ��ס�"+            
            "\n\n    �������Ҫ���ǵļ��̷������ڱ���ʱ��ÿ��һ�����������"+
            "8:30������5:30�����ǵĽ��׹���������ϵ��"+
            "\n    �绰 755-3691610"+
            "\n    ���� 755-3201877"+
            "\n\n    ף�����ˣ�"+
            "\n\n\n    PaperEC.com"+
            "\n    ���׹���С��"+
            "\n\n\n    http://www.paperec.com";

    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(to_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- Seller has accepted your bid";   
        str="Dear "+userdet[0]+userdet[1]+"��"+          
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
      title="PaperEC.com����������Ӧ����ID"+posting_id+"���򷽵���Ϊ��������ɽ�";   
        str="�𾴵�"+userdet[1]+userdet[0]+"��"+                 
            "\n\n    �������������Ĺ�Ӧ��ϢID"+posting_id+" bid ID:"+lsl+"�ϵ���Ϊ�����Ѿ�ͬ�Ⲣ����"+ 
            "�ɽ�������ɽ�ʱ�� "+ time+                     
            "\n\n    ���ݻ�ԱЭ�飬��ÿ�ʳɹ����ף�������Ա����������һ����"+
            "���׷���ѡ����ǻ�������ϵ������һ�ݽ��׷�֧����ͬ����������"+
            "���򷽵ı��۽���״̬��������״̬���ڡ���׼�ɽ���ʱ�����ῴ��"+
            "��ǩ����ͬ����ť����վҪ�������򷽹�ͬǩ��һ�ݵ��Ӻ�ͬ������"+
            "��ԱЭ�飬����ɽ���һ��Ϊ�ܷ���Լ����ϣ��������������ҵ��Ϊ��"+
            
            "\n\n    �������Ҫ���ǵļ��̷������ڱ���ʱ��ÿ��һ�����������"+
            "8:30������5:30�����ǵĽ��׹���������ϵ��"+
            "\n    �绰 755-3691610"+
            "\n    ���� 755-3201877"+
            "\n\n    ף�����ˣ�"+
            "\n\n\n    PaperEC.com"+
            "\n    ���׹���С��"+
            "\n\n\n    http://www.paperec.com"; 
    }else{
       succ.setLangcode("EN"); 
       succ.setUserid(acc_userid); 
       userdet=succ.getUserdet(); 
      title="PaperEC.com-- You have agreed to the buyer's conditions on your posting ID#"+posting_id;   
        str="Dear "+userdet[0]+userdet[1]+"��"+
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
<title>�ҵ�ֽ��--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none; color: #000000; font-family: "����"}
a:visited {  text-decoration: none; color: #000000; font-family: "����"}
a:active {  text-decoration: none; color: #000000; font-family: "����"}
a:hover {  color: #330099; text-decoration: underline; font-family: "����"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "����"; font-size: 14px}
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
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="product_list.jsp" class="font9"><font color="#000000">��Ӧ����</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="request2buy.jsp"><font color="#000000">���󷢲�</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="order_search.jsp"><font color="#000000">�������</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">�ҵĿͻ�</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="product_list.jsp"><font color="#000000">�ҵĲ�Ʒ</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">IDֱͨ��</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="����">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('../foreignX.htm')"><font color="#FFFFFF">�����ʻ���</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="../jiaoyifu.htm"><font color="#FFFFFF">���׷���</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('../huansuanresult.jsp')"><font color="#FFFFFF">������λת��</font></a></td>
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
                  <input type="submit" name="Submit2" value="����" onclick="reload()">
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
<%@ page import="java.util.*" language="java" %> 
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>
<jsp:useBean id="prov" scope="page" class="postcenter.SignBarg" />
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />

<jsp:setProperty name="prov" property="*" />



<% 
    String titlename=UserInfo.getTitle();
    String lastname=UserInfo.getLastName();
    String posting_id=request.getParameter("posting_id");
    String bid_id=request.getParameter("bid_id");
    String lang_code=request.getParameter("lang_code");
    String buy_sale=request.getParameter("buy_sale");
    String user_id=UserInfo.getUserId();     
    String act=request.getParameter("act");
    String detial="";
    String title="";
    prov.setUser_id(user_id);
    int i=0;
    String reco="";
    String bool=prov.getHaveCont();
    if(bool.equals("N")){
       if(act.equals("ty")) {                
         i=prov.getModiCont(); 
         String stri[]=prov.getUsercon(); 
         inqu.setUser_id(user_id);
         if(i==20){        
                   
            if(inqu.getUserLang().equals("GB")){
               title="�й�ֽ���������ҵĿͻ�����������¿ͻ�";
              detial="�𾴵�"+lastname+titlename+":"+
                     "\n\n    ��ϲ���� "+stri[4]+
                     "   ���ױʽ��׳ɹ�����Ϊ������ƽ̨��"+
                     "�ṩ�ߣ�����Ϊ���е��ǳ����ˣ�����ףԸ����һֱ������������"+
                     "Ҳϣ�����ǵĽ���ƽ̨�����о��������ʵ�á�"+
                     "\n\n    ϵͳ��Ϊ�����ṩ��һ�ֿͻ�����ҳ�棬�������Զ������ǽ�"+
                     "��˫����ӵ����ԵĿͻ������ߡ������ҵĿͻ������ˡ�������"+
                     "����վ��Աר�����ҵ�ֽ������ҳ�����ɿ�����ߵĵ������ϡ���"+
                     "�Ŀͻ������ӡ������øù��ߣ������������ｫ�������·���ר��"+
                     "֪ͨ���Ŀͻ�������Ҫ�������������ס�"+

                     "\n\n    ��������֪������������Ա���û�������ϣ��������뵽����"+
                     "�ͻ��б��У�������Email������:trade@paper.com  ��������˺������������"+  
                     "\n\n    ף������¡��/n"+            
                     "\n\n    �й�ֽ��"+
                     "\n    ���׹���С�� /n"+          
                     "\n\n\n    http://www.paperec.com";
                  
                  }else{
               title="PaperEC.com-- New business partner added into 'My Customer'";
              detial="Dear "+titlename+lastname+":"+
                     "\n\n  The other party of your recently concluded deal has "+
                     "automatically been added into your 'My Customer'. Using 'My "+
                     "Customer', you can inform your business partners of new posting "+
                     "ID#. PaperEC hopes you find this tool useful."+
                     "\n\n  If you know other member's PaperEC.com User ID, and you wish "+
                     "to add him/her to your 'My Customer', you may email PaperEC at: "+
                     "info@paperec.com. PaperEC.com's staff will do it for you."+                     
                     "\n\n\nBest Regards, "+            
                     "\n\nPaperEC.com."+        
                     "\n\nhttp://www.paperec.com";
                        }                          
                            
                 inqu.setTitle(title);
                 inqu.setDetail (detial);
                 inqu.getSingleMess();            
         }          
         if(i!=10){              
           if(inqu.getUserLang().equals("GB")){
              title="�й�ֽ��������ϲ��ǩ���˵��Ӻ�ͬ";
              detial="�𾴵�"+lastname+titlename+":"+  
                     "\n\n    ��ϲ���ǣ��ڹ�Ӧ����ID:"+stri[2]+" ��Ʒ�ϵ����ID:"+stri[3]+" ���һ�£���ǩ���˵���"+
                     "��ͬ�����ݻ�ԱЭ�飬������ͬ��һ��Ϊ�ܷ���Լ�����������ݿ��"+
                     "¼�˵���ǩ����ʱ�䡣Ϊ������˫�����أ�����˫�����貹��һ��ʵ��"+
                     "�����ͬ����������������������ݺ�ͬ�ı��ʼĸ����ǣ���ǩ�֡�"+
                     "���º�Ļر������������������˫����ͬǩ�ֵĺ�ͬ�Ļظ����ǡ�"+            
                     "\n\n    ��������κ�������Ҫͬ������ϵ�����ڱ���ʱ��ÿ��һ��"+
                     "���������8:30������5:30�����ǵĽ��׹���������ϵ:"+        
                     "\n    �绰 +86-755-3691610"+  
                     "\n    ���� +86-755-3201877"+        
                     "\n\n    ף����졣"+            
                     "\n\n\n    �й�ֽ��"+
                     "\n    ���׹���С��"+          
                     "\n\n\n   http://www.paperec.com";
                   
          }else{
               title="PaperEC.com-- Congratulations! The deal is a success!";
              detial="Dear "+titlename+lastname+":"+            
                     "\n\n  User Name:"+stri[0]+
                     "\n\n  Congratulations! You both have reached an agreement for the product on the posting ID#"+stri[2]+
                     " Your acceptance of the "+
                     "bid is legal binding, as outlined in the Membership "+
                     "Agreement. When you click on  'Sign Contract' button, you are "+
                     "signing an electronic contract, the time of your signature will "+
                     "be recorded into PaperEC's database."+            
                     "\n\n  When PaperEC is to act as the buyer's import agent, PaperEC"+
                     "will send you a witten contract with the signature of a "+
                     "PaperEC.com representative. Please return one copy with your "+
                     "signature as soon as possible, and keep the second copy for your "+
                     "records. When PaperEc.com receives the signed contract, the "+
                     "import/export process can begin."+
                     "\n\n  If the buyer wishes to contact you directly, you will carry"+
                     "out the contract on your own. "+ 
                     "\n\n  Should you need immediate assistance,  please call us"+
                     "Monday through Friday between the hours of 8:30 am. and 6:00"+      
                     "pm. Beijing Standard Time at +86-755-369-1613."+                         
                     "\n\n\nBest Regards,"+            
                     "\n\nPaperEC.com."+          
                     "\n\nhttp://www.paperec.com";
                        }                        
           inqu.setTitle(title);
           inqu.setDetail (detial);
           inqu.getSingleMess();
         } 
      }  
    }
%> 
                      
 <script language="javascript">  
     function reload(e){
        window.history.back()  
       if(e==2){
          window.history.back()
         }        
      }
</script>             
<html>
<head>
<title>�ҵ�ֽ��--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.font9 {  font-size: 13px; font-family: "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 10pt; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  text-decoration: none; color: #000000}
a:visited {  text-decoration: none; color: #000000}
a:active {  text-decoration: none; color: #000000}
a:hover {  color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px}
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
      <script language="JavaScript" src="../../../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../../images/images_en/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="product_list.jsp" class="font9"><font color="#000000">Offer 
                      to Sell</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="request2buy.jsp"><font color="#000000">Request 
                      to Buy</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="order_search.jsp"><font color="#000000">Browse 
                      Trading Floor</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">My 
                      Customers</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="product_list.jsp"><font color="#000000">My 
                      ProductProfile</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">Search 
                      by ID#</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="Go">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('../foreignX.htm')"><font color="#FFFFFF">Currency 
                      Converter</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="../jiaoyifu.htm"><font color="#FFFFFF">Services</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('../huansuanresult.jsp')"><font color="#FFFFFF">Metric 
                      Converter</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../../../images/images_en/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </td>
    <td valign="top"><br>
      <form method="post" action="tongyi.jsp">
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCFF" bordercolorlight="#FFFFFF" align="center">
          <tr bordercolor="#FFFFFF"> 
            <td> 
              <table width="600" border="0" cellspacing="0" cellpadding="0" bgcolor="#E6EDFB" height="400">
                <tr> <%
                  if(bool.equals("Y")){
                     reco="Sorry! You have signed the contract.";
               %> 
                  <td height="362" align="center"><%=reco%></td>
                <tr align="center"> 
                  <td> 
                    <input type="button" name="Submit0" value="Back" onClick="reload(1);">
                  </td>
                </tr>
                <%
                  }else{
               %> <%
                   if(act.equals("ty")&&i!=10) {
                      reco="  Congratulations! You have reached an agreement for the product"+
                           "on the posting ID#"+posting_id+"  bid ID#"+bid_id+".  Clicking on the 'Sign Contract' "+
                           "button is the same as an electronic signature, the time of your signature "+ 
                           "is recorded into PaperEc's database. \n"+
                           "  When PaperEC is to act as the buyer's import agent, you will receive "+
                           "you a witten contract with the signature of a PaperEC.com "+
                           "representative. Please return one copy with your signature as "+ 
                           "soon as possible, and keep the second copy for your records. When "+ 
                           "PaperEC.com receives the signed contract, the import/export process "+
                           "can begin.\n"+
                           "  In the occasion that the buyer directly contact with you, you will "+
                           "carry out the contract on your own.  ";
               %> 
                <td height="362" align="left"><%=reco%></td>
                <%
                     }else if(act.equals("ty")&&i==10){
                          reco="Sorry! Contract was not sign��please try again for a moment.";
                %> 
                <td height="362" align="center"><%=reco%></td>
                <%
                     }else{
                %> 
                <td height="362" align="center"> 
                  <textarea name="textfield" cols="70" rows="20">
                 <%=prov.getContent()%>
                 </textarea>
                </td>
                <%
                     }    
                %> </tr>
                <tr align="center"> 
                  <td> <%
                   if(act.equals("ty")) {
                  %> 
                    <input type="button" name="Submit0" value="Back" onClick="reload(2);">
                    <%
                      }else{
                  %> 
                    <input type="hidden" name="posting_id" value="<%=posting_id%>">
                    <input type="hidden" name="bid_id" value="<%=bid_id%>">
                    <input type="hidden" name="lang_code" value="<%=lang_code%>">
                    <input type="hidden" name="buy_sale" value="<%=buy_sale%>">
                    <input type="hidden" name="act" value="ty">
                    <input type="submit" name="Submit2" value="Agree">
                    <%
                      }   } 
                  %> </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </form> </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../../images/images_en/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%    prov.getDestroy(); %>
<%    inqu.getDestroy(); %>
</jsp:useBean>
<html>
<head>
<title>�ҵ�ֽ��--PaperEC.com</title>
<SCRIPT LANGUAGE="JavaScript"><!--
 function reload(){
  window.history.back()
            }
// --></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "����"}
.font9 {  font-size: 14px; font-family: "����"; color: #000000}
.white10 {  font-size: 10pt; color: #FFFFFF; font-family: "����"}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; color: #000000; font-family: "����"}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr>
    <td width="159"> 
      <script language="JavaScript" src="../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:263px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="141" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td> 
              <table width="142" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000" align="center">
                <tr align="center"> 
                  <td width="139" height="22" bgcolor="#503CC0"><font color="#FFFFFF" class="big">��¼ע��</font></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25"><a href="equip/EquipLogin.jsp" class="dan10">רҵ�豸</a></td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="25" ><a href="bbs/BBS_Manlogin.jsp?area_ID=2" class="dan10">��������</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0" ><a href="memberagreetment.htm" class="white10">��ԱЭ��</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../html/aboutus/aboutus_bomianq.htm" class="white10">��ȫ����</a></td>
                </tr>
                <tr align="center"> 
                  <td height="25" bgcolor="#4078E0"><a href="../html/aboutus/aboutus_banquan.htm" class="white10">�桡��Ȩ</a></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../images/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div></td>

<td valign="top"> 
 
        <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">


  <%@ page import="java.util.*, java.sql.*,java.io.*,postcenter.*" session="true" language="java"%> 
   <%    String arr[]=new String[43];
         ResultSet allData=null; 
         String st1,st2;%>
   <jsp:useBean id="myFind" scope="page" class="postcenter.newRegister" />   
   <jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
   <jsp:useBean id="exect" scope="page" class="postcenter.ExecThread"/>
   <% 
      try{ 
           String st3="";
           boolean bool=false;
           boolean create_mail=false;
           int return_code=3;
           String user_id="";
           String time="";
           String detial="";
           String title="";
           arr[11]=request.getParameter("p_name");
           st1="select name from company_l where name='"+arr[11]+"' and lang_code='GB'";
           myFind.setSqlStc(st1);
           allData=myFind.getAllData();
           if(allData.next()){
              bool=true;
           }
           myFind.disconn();  
           arr[18]= request.getParameter("p_login"); 
           st1="select passwd from users where login='"+arr[18]+"'";  
           myFind.setSqlStc(st1);
           allData=myFind.getAllData();
           if(allData.next()){
               myFind.disconn();
  %>

           <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="center">
                  <td height="200" class="font9">�ܱ�Ǹ!���ĵ�¼���ѱ�ʹ��,�������������!</td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="����" ONCLICK="reload()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          
        <%   }else if(bool){
                     myFind.disconn();
         %>            
          <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="center">
                  <td height="200" class="font9">�ܱ�Ǹ!�����ڹ�˾�Ѵ��ڣ�����ע��!</td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="����" ONCLICK="reload()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
                     
        <%     }else{  
                     myFind.disconn();
                     arr[1]="GB";arr[19]=request.getParameter("p_passwd");
                     arr[29]=request.getParameter("p_question");arr[28]=request.getParameter("p_answer");
                     arr[39]=request.getParameter("title");  
                     arr[31]=request.getParameter("p_first_name");arr[32]=request.getParameter("p_last_name");
                     arr[10]=request.getParameter("p_industry_id");arr[9]=request.getParameter("p_prod_focu_id");
                     arr[17]=request.getParameter("p_dept");arr[36]=request.getParameter("p_job_title");
                     arr[2]=request.getParameter("p_country_id_c");arr[3]=request.getParameter("p_state_id_c");
                     arr[14]=request.getParameter("p_city_id_c");
                     arr[12]=request.getParameter("p_address1_c");arr[13]=request.getParameter("p_address2_c"); 
                     arr[4]=request.getParameter("p_postcode_c");arr[7]=request.getParameter("p_email_c");
                     arr[5]=request.getParameter("p_tel_c");arr[6]=request.getParameter("p_fax_c");
                     arr[25]=request.getParameter("p_mobile");
                     arr[40]=request.getParameter("impo");arr[41]=request.getParameter("impo_prod_id");
                     arr[30]=request.getParameter("p_know_id");  
                     arr[42]=request.getParameter("email_info");
                    
                     arr[38]="B";
                     arr[20]=arr[2];
                     arr[21]=arr[3];arr[33]=arr[14];
                     arr[34]=arr[12];arr[35]=arr[13];
                     arr[24]=arr[6];arr[26]=arr[7];
                     arr[37]="";
                     arr[22]=arr[4];arr[23]=arr[5];     
                     arr[0]="Y";
                     arr[15]=""; arr[8]="";
     
                         arr[16]="";
                         arr[27]="";
                     if ((arr[42].equals("Y"))&&(arr[7].equals(""))){
                     	 arr[7] = arr[18] + "@mail.paperec.com";
                     	 arr[26] = arr[7];
                     	 create_mail=true;
                     }
                    	 
                     st3=myFind.getPreCall(arr);
                     //myFind.disconn();
                         
		
                     if(st3.equals("ok")){


                         st2="select user_id,to_char(sysdate,'yyyy-mm-dd hh:mi:ss') time from users where login='"+arr[18]+"'";
                         myFind.setSqlStc(st2);
                         ResultSet rs=myFind.getAllData();
                         if(rs.next()) 
                             user_id=rs.getString("user_id");
                             time = rs.getString("time");
                         myFind.disconn();         

                         if (arr[39].equals("G")) 
                             arr[39] = "��ʿ";
                         else if (arr[39].equals("S")) 
                             arr[39] = "Ůʿ";
                         else 
                             arr[39] = "����";
                         
                         title="��ӭ������PaperEC.com";
                         
                         detial="�𾴵�"+arr[32]+arr[39]+"��"+
                             "\n\n    ��ϲ����ΪPaperEC.com��Ա��"+
                             "\n\n    �����û����� " +arr[18]+ "�� �����û��������������Ѿ���Ч��"+
                             "\n\n    ����PaperEC.com����ҳ�����������û���������, �Ϳɵ�¼����"+
                             "��Ա���򣬽�������ͽ��ס�������ӵ������Ȩ����"+
                             "\n1�����Է���PaperEC.com�ϵĻ�Ա���������Ա�����е���Դ��"+
                             "\n2�����Է���������Ϣ��"+
                             "\n3�����������Ӧ��������Ϣ���Լ������Ĺ�Ӧ��Ϣ�����빩Ӧ�̽���"+
                             "���ۡ���ۡ����ܡ�ǩԼ����������������׻��"+
                             "\n4��������������ȫ��ѵġ�"+
                             "\n\n    �������Ҫ��PaperEC.com�ϳ��۲�Ʒ�����һ������ΪPaperEC"+
                             "��������Ա�����¼���롰�ҵ�ֽ����ҳ�棬����������Ϲ����ϵ�����"+
                             "��ť����������Ա�ʸ�����ҳ�档"+
                             "\n\n    ���ǵ���ҳ���ṩ��һ����̬������ʾ��Ӱ���ܹ�ʹ����������"+
                             "���׷�������������ʱ��ۿ����ڽ��׹����У�������в�����ĵ�"+
                             "��������ʱ�������ȡ�������������ҳ����ָ������Ȼ����һ��"+
                             "����Ĺ���ʱ�䣬��Ҳ�ɴ�绰�����ǻ�ȡ������ Tel:755-3691610"+
                             "\n\n    �����������ڹ�˾��ز��ŵĸ����ˣ�������֯�ڻ���Ҫ������"+
                             "��ԱҲ���ڱ��������ף�������ϣ���ܹ����������ڱ��������Ľ��ף�"+
                             "����ʡ��ҵ�ֽ����ҳ�棬��������������ϸ������Ϲ���������"+
                             "���á�"+
                             "\n\n    ���⣬���ǻ��ᶨ�ڵؽ�����һЩ��������ͨ��Email��������"+                           
                             "\n\n\n    ף����졣"+            
                             "\n\n\n    PaperEC.com"+
                             "\n    Tel:755-3691610 3691613 "+          
                             "\n    Fax:755-3201877"+
                             "\n    Email:members@paperec.com"+
                             "\n\n    http://www.paperec.com";

                           inqu.setUser_id(user_id);    
                           inqu.setTitle(title);
                           inqu.setDetail(detial);
                           inqu.getSingleMess();
                           
                           if (create_mail){
                               ExecThread exect1=exect.getInstance(arr[18],arr[19],time,2);  
              		       exect1.start();
              		   } 
                         }    

       %>
                                      
           <tr bordercolor="#FFFFFF"> 
            <td height="116">
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="left">
     <% if(st3.equals("ok")){   %>           
                  <td height="200" class="font9">��ϲ��ע��ɹ�����ΪPaperEC.com ��Ա��
    <br>
    <br>�����û����� <%=arr[18]%> �� �����û��������������Ѿ���Ч��
    <br>
    <br>������ӵ������Ȩ����
    <br>1�����Է���PaperEC.com�ϵĻ�Ա���������Ա�����е���Դ��
    <br>2�����Է���������Ϣ��
    <br>3�����������Ӧ��������Ϣ���Լ������Ĺ�Ӧ��Ϣ�����빩Ӧ�̽��б��ۡ���ۡ���
       �ܡ�ǩԼ����������������׻��
    <br>4��������������ȫ��ѵġ�
    <br>
    <br><a href="login.htm">��������</a>�����������û���������, �Ϳɵ�¼�����Ա����
    ��������ͽ��ס�
    <br>    
    <br>�������Ҫ��PaperEC.com�ϳ��۲�Ʒ�����һ������ΪPaperEC��������Ա��        
    ����ͬ���ļ򵥣�����<a href="chenqingchhy_reg.jsp?user_id=<%=user_id%>">�������Ϊ������Ա��</a>�������������뼴��ע���Ϊ������Ա��
    ����ϣ�����Ժ���Ҫ��ʱ���ٽ���ע�ᣬ��������ʱ��½PaperEC.com���롰�ҵ�ֽ������
    �Ӹ������Ϲ��������������Ա�ʸ�ע�ᡣ
    <br>
    <br>�Ա�ҳ��Ϣ��ϵͳ���Զ����������ɹ�ע���Emailȷ����Ϣ, ��Ҳ���Դӡ��ҵ�ֽ����
    ҳ�������ĸ�����Ϣ�����￴����
    <br>
    <br>��������������κ����ʻ��飬������ϵ���ǣ�members@paperec.com
    �򷢴�������ǣ�755-3201877
</td>
     <%   
          }else{    %>
                  <td height="200" class="font9"><%=st3%></td>
     <%   }   %>                      
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <a href="login.htm">������ҳ</a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
                   
   <%       
          }       
      }catch(Exception e){  
   %>
            
             <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="center">
                  <td height="200" class="font9"><p>����������,�Ժ�����!<%=e.getMessage()%></p></td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <input type="submit" name="Submit" value="����" ONCLICK="reload()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>          
             <%    }  %>
                   


   
    
<% myFind.destroy();  %>        
<% inqu.getDestroy(); %>
</jsp:useBean>


 
        </table>
        <div align="center"></div>
      
      
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="/images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="/images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
     
  </tr>
</table>
</body>
</html>

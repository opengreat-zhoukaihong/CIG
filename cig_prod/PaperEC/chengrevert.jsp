<%@ page language="java"%>  
<%@ page import="java.util.*, java.sql.*,java.io.*"%> 

<jsp:useBean id="beco" scope="page" class="postcenter.newRegister" />   
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
<%  String[] arr=new String[33];
    //String user_id=UserInfo.getUserId();
    String country=request.getParameter("country");    
    String state=request.getParameter("state");
    String city=request.getParameter("city");
    String user_id=request.getParameter("user_id");    
    arr[0]=user_id;arr[1]=request.getParameter("full_name");
    arr[2]=request.getParameter("employees");arr[3]=request.getParameter("revenue");
    arr[4]=request.getParameter("corp_f_name");arr[5]=request.getParameter("money_reg");  
    arr[6]=request.getParameter("business_id");arr[7]=request.getParameter("tax_id");
    arr[8]=request.getParameter("bank");arr[9]=request.getParameter("account");
    arr[10]=request.getParameter("iso");arr[11]=request.getParameter("url");
    arr[12]=request.getParameter("address1");
    arr[13]=country+"  "+state+"  "+city+" "+request.getParameter("address2");
    arr[14]=request.getParameter("postcode"); arr[15]=request.getParameter("fax");
    arr[16]=request.getParameter("tel");arr[17]=request.getParameter("email");
    arr[18]=request.getParameter("sell_prod_id");arr[32]="GB";
    for(int i=0;i<33;i++)if(arr[i]==null)arr[i]="";    
    String st3=beco.getBecomeS(arr);
    String title="";
    String detial="";  
                      
                     if(st3.equals("ok")){   
                         String m_title ="";
                         String last_name ="";
                         String st2="select title,last_name from users a,users_l b where a.user_id='"+user_id+"' and a.user_id=b.user_id and b.lang_code='GB'";
                         beco.setSqlStc(st2);
                         ResultSet rs=beco.getAllData();
                         if(rs.next()){ 
                             m_title = rs.getString("title");
                             last_name = rs.getString("last_name"); 
                         }
                         beco.disconn();         

                         if (m_title.equals("G")) 
                             m_title = "��ʿ";
                         else if (m_title.equals("S")) 
                             m_title = "Ůʿ";
                         else 
                             m_title = "����";
                                                 
                         title="��ϲ�����PaperEC.com������Ա�ʸ�";
                         detial="�𾴵�"+last_name+m_title+":"+
                                    "\n\n    ��ϲ��ע���ΪPaperEC.com��������Ա��"+
                                    "\n\n    PaperEC.com�Ѿ�Ϊ��������������ã���Ϊ������Ա�����Ѿ�������"+
				    "PaperEC.com�ϳ������Ĳ�Ʒ��"+
				    "\n\n    ��Ϊ������Ա������������ԭ�еĻ�ԱȨ���⣬����������ר��Ȩ����"+
				    "\n1����׼����PaperEC.com�Ϲ�Ӧ�Ĳ�Ʒ�������Ͽ�"+
				    "\n2��������Ʒ��Ӧ��Ϣ"+
				    "\n3���ɶ�PaperEC.com�ϵ�������Ϣ������ز�Ʒ��Ӧ��Ϣ��"+
				    "\n4��ͬ�л�Ӧ����ҽ�����ۡ����ܱ��ۡ��ɽ�ǩԼ�Ƚ��׻��"+
				    "\n5��ֻ����������ҳɹ���ɽ��׺���������PaperEC.com֧�����ã������ԱЭ�飩"+
				    "\n\n    Ϊ�����ܷ���ķ�����Ʒ��Ӧ��Ϣ��PaperEC.com�ṩ��һ������Ĺ��ߣ�"+
				    "--���ҵĲ�Ʒ������������ɽ������Ĳ�Ʒ���Ͽ⣬������Ʒ��Ӣ��Ʒ����"+
				    "�ơ�������Ϣ����Ʒ���͡���Ʒ������ϣ��ȵȡ��������Ժ����ڷ�����Ʒ��"+
				    "Ӧ��Ϣ��ʱ��Ϳ����ɷ�����"+
				    "\n\n    ��PaperEC.com�������ֳ��۽�ֽ��Ʒ��;���ɹ�ѡ��һ�Ƿ����µĲ�Ʒ"+
				    "��Ӧ��Ϣ����Ա��������������ҷ��������������Ϣר�ŷ������Ĺ�Ӧ��"+
				    "Ϣ��һ������һ�Ӧ��PaperEC����Ϣ֪ͨϵͳ������Ѹ�ٵõ�֪ͨ��"+
				    "\n\n    ������Խ��׹����в�����ĵط����ɹۿ�PaperEC.com��ҳ�ϵ�Flash��"+
				    "����ʾ��Ӱ��ѧϰ��Ҳ����ʱ�������ȡ�������������ҳ����ָ������Ȼ"+
				    "����һ������Ĺ���ʱ�䣬��Ҳ�ɴ�绰�����ǻ�ȡ������"+
                                    "\n\n\n\n    ף����졣"+
                                    "\n\n\n    PaperEC.com"+
                                    "\n    PaperEC.com"+
                                    "\n    Tel:755-3691610 3691613"+
                                    "\n    Email:members@paperec.com"+   
                                    "\n\n    http://www.paperec.com"; 
                                    
                         inqu.setUser_id(user_id);                                    
                         inqu.setTitle(title);
                         inqu.setDetail(detial);
                         inqu.getSingleMess(); 
                     }     
%>

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


  
                                     
           <tr bordercolor="#FFFFFF"> 
            <td height="116"> 
              <table width="500" border="0" cellspacing="0" cellpadding="2">
                <tr bgcolor="#E6EDFB" align="left">
     <% if(st3.equals("ok")){   %>           
                  <td height="200" class="font9"> 
                  ��ϲ��ע���ΪPaperEC.com��������Ա���������Ѿ����Ե�¼PaperEC.com<br>
                  �������Ĳ�Ʒ��PaperEC.com�ȳ���ӭ�г��ŵĳ��̵�PaperEC�����۲�Ʒ��<br>
                  PaperEC.com�᲻�ϵ��ṩ���Ӹ��Ի�������������������������������
                  </td>
     <%  }else{    %>
                  <td height="200" class="font9"><%=st3%></td>
     <%   }   %>                      
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td>
                    <a href="login.htm">�� ��</a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
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
<% beco.destroy();  %>        
<% inqu.getDestroy(); %>
</jsp:useBean>

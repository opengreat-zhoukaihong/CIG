<html>
<%@ page import="java.util.*, java.net.*" %>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.white {  font-family: "����"; font-size: 10pt; color: #FFFFFF}
a:link {  font-family: "����"; text-decoration: none}
a:visited {  font-family: "����"; text-decoration: none}
a:active {  font-family: "����"; text-decoration: none}
a:hover {  font-family: "����"; text-decoration: underline}
td {  font-family: "����"; font-size: 10pt}
.black {  font-family: "����"; color: #000000}
.algin {  font-family: "����"; font-size: 10pt; text-align: justify; line-height: 18pt}
.title {  font-family: "����"; font-size: 14px; font-weight: 400}
-->
</style>
</head>
<script language="JavaScript">
<!--
function validateForm(e){
        
        if(e.ration.value==''){
	  alert('����������������Ȼ���ύ!')
	  e.ration.focus()
	return false;
	}
        if(e.speed.value==''){
	  alert('�����빤�����٣�Ȼ���ύ!')
	  e.speed.focus()
	return false;
	}
        if(e.breadth.value==''){
	  alert('���������Ȼ���ύ!')
	  e.breadth.focus()
	return false;
	}
        if(e.artName.value==''){
	  alert('�������豸���ƣ�Ȼ���ύ!')
	  e.artName.focus()
	return false;
	}
	if(e.cont_Name.value==''){
	  alert('����������������Ȼ���ύ!')
	  e.cont_Name.focus()
	return false;
	}
        if(e.cont_tel.value==''){
	alert('������绰��Ȼ���ύ!')
	e.cont_tel.focus()
	return false;
	}
	if(e.comp_name.value==''){
	alert('�����빫˾���ƣ�Ȼ���ύ!')
	e.comp_name.focus()
	return false;
	}
	if(e.cont_Address.value==''){
	alert('��������ϵ�شˣ�Ȼ���ύ!')
	e.cont_Address.focus()
	return false;
	}
	if(e.cont_Postcode.value==''){
	alert('�������ʱ࣬Ȼ���ύ!')
	e.cont_Postcode.focus()
	return false;
	}
    if(numericCheck(e)!=true)
     return false;	
}

function numericCheck(e){
   nr1=e.vali_Date.value;
   if(nr1.length==0){
   alert("��������Ϊ�գ�ֻ��Ϊ1 !\n");
   e.vali_Date.focus();
   return false;
   }
   cmp="123456789";
   tst=nr1.substring(0,1);
   if(cmp.indexOf(tst)<0){
   alert("���� ֻ�������֣�ֻ��Ϊ1 !\n");
   e.vali_Date.focus();
   return false;
   }
   cmp="0123456789";
   for (var i=1;i<nr1.length;i++){
   tst=nr1.substring(i,i+1);
   if(cmp.indexOf(tst)<0){
   alert("���� ֻ��������!\n");
   e.vali_Date.focus();
   return false;
   }
  }
return true;
}
//-->
</script>
<%
    Hashtable pHash =new Hashtable();
    String queryString = request.getParameter("queryString");
    if(queryString==null)
    queryString = "0000";
    String queryString2 = request.getParameter("queryString2");
    if(queryString2==null)
    queryString2 = "000000000000000000000000000000000000000000000000000000000000";
%>
<jsp:useBean id="Equip_Cate" scope="page" class="com.paperec.equip.Equip_Cate" /> 
<%
    pHash.put("langCode",new String("GB"));
    pHash.put("pageFlag",new String("N"));
    Equip_Cate.setParameteres(pHash);
    String[][] lists;
    int count=0;
    lists = Equip_Cate.getList();
    count = Equip_Cate.getCount();
    String queryID = request.getParameter("queryID");
    if(queryID!=null)
    queryString=Equip_Cate.setBit(queryString,queryID);
    String queryID2 = request.getParameter("queryID2");
    if(queryID2!=null)
    queryString2=Equip_Cate.setBit(queryString2,queryID2);
    
    String[] dates=Equip_Cate.getOthers();
%>
<jsp:useBean id="Equip_Type" scope="page" class="com.paperec.equip.Equip_Type" /> 
<%
    Equip_Type.setParameteres(pHash);
    String[][] tlists;
    int tcount=0;
    tlists = Equip_Type.getList();
    tcount = Equip_Type.getCount();
    
    String art_Type=request.getParameter("art_Type");
    String type_ID=request.getParameter("type_ID");
%>
<jsp:useBean id="Parameter" scope="page" class="com.paperec.Parameter" />
<%
pHash.put("id",new String("21"));
Parameter.setParameteres(pHash);
    String[][] plists;
    int pcount=0;
    plists = Parameter.getList();
    pcount = Parameter.getCount();
%> 
<body bgcolor="#FFFFFF"><table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="159" height="394"> 
      <script language="JavaScript" src="/javascript/caidan.js">
      </script>
      <div style="position:absolute; width:141px; height:131px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr bgcolor="#574ED3"> 
                  <td width="142" height="22" class="white" align="center">רҵ�豸</td>
                </tr>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipPaperPutOut.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&queryString=<%=queryString%>&queryID=0&queryString2=<%=queryString2%>"><font color="#FFFFFF">�����Ӧ��Ϣ</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,0)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipPaperPutOut.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=i%>"><b><%=lists[i][1]%></b></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString2,i)){%>
                <%for(int j=0;j<tcount;j++){%>
                <%if(tlists[j][0].trim().toUpperCase().equals(lists[i][0].trim().toUpperCase())){%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipList.jsp?art_Type=S&type_ID=<%=tlists[j][1]%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipPaperPutOut.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&queryString=<%=queryString%>&queryID=1&queryString2=<%=queryString2%>"><font color="#FFFFFF">���������Ϣ</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,1)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipPaperPutOut.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=count+i%>"><b><%=lists[i][1]%></b></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString2,count+i)){%>
                <%for(int j=0;j<tcount;j++){%>
                <%if(tlists[j][0].trim().toUpperCase().equals(lists[i][0].trim().toUpperCase())){%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipList.jsp?art_Type=B&type_ID=<%=tlists[j][1]%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipPaperPutOut.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&queryString=<%=queryString%>&queryID=2&queryString2=<%=queryString2%>"><font color="#FFFFFF">������Ӧ��Ϣ</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,2)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipPaperPutOut.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=2*count+i%>"><b><%=lists[i][1]%></b></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString2,2*count+i)){%>
                <%for(int j=0;j<tcount;j++){%>
                <%if(tlists[j][0].trim().toUpperCase().equals(lists[i][0].trim().toUpperCase())){%>
                <%if(!(tlists[j][3].toUpperCase().equals("Y"))){%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipPutOut.jsp?type_ID=<%=tlists[j][1]%>&art_Type=S&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}else{%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipPaperPutOut.jsp?type_ID=<%=tlists[j][1]%>&art_Type=S&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipPaperPutOut.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&queryString=<%=queryString%>&queryID=3&queryString2=<%=queryString2%>"><font color="#FFFFFF">����������Ϣ</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,3)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipPaperPutOut.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=3*count+i%>"><b><%=lists[i][1]%></b></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString2,3*count+i)){%>
                <%for(int j=0;j<tcount;j++){%>
                <%if(tlists[j][0].trim().toUpperCase().equals(lists[i][0].trim().toUpperCase())){%>
                <%if(!(tlists[j][3].toUpperCase().equals("Y"))){%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipPutOut.jsp?type_ID=<%=tlists[j][1]%>&art_Type=B&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}else{%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipPaperPutOut.jsp?type_ID=<%=tlists[j][1]%>&art_Type=B&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><font color="#FFFFFF">�豸��ѯ</font></td>
                </tr>
                <tr align="center" bgcolor="#FFCC00"> 
                  <form name="seachform" method="post" action="EquipFindList.jsp">
                    <td height="15" width="142"> 
                      <input type="text" name="keyword" size="8">
                      <input type="submit" name="Submit" value="����">
                    </td>
                  </form>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td height="20"><a href="#top"><img src="/images/leftback.gif"  width="141" height="27" border="0" ></a></td>
          </tr>
        </table>
      </div>
    </td>
     
    <td colspan="2" valign="top" height="466"> 
      <form method="post" name="putout" action="EquipPutOutPost.jsp" onSubmit="return validateForm(putout);">
      <input type=hidden name="art_Type" value="<%=art_Type%>" >
      <input type=hidden name="type_ID" value="<%=type_ID%>" >
      <input type=hidden name="paper_Flag" value="Y" >
      <input type=hidden name="queryString" value="<%=queryString%>" >
      <input type=hidden name="queryString2" value="<%=queryString2%>" >
        <table width="600" border="1" cellspacing="0" cellpadding="6" bordercolorlight="#000000" bordercolordark="#FFFFFF" align="center">
          <tr>
            <td>
              <table width="600" border="0" cellspacing="0" cellpadding="6" bgcolor="#E6EDFB">
                <tr> 
                  <td><span class="title"><b>����<%if(art_Type.trim().toUpperCase().equals("S")){%>��Ӧ<%}else{%>����<%}%>��Ϣ</b></span><b><img src="/images/space.gif" width="300" height="1"> 
                    </b>(����ɫ������Ϊ������Ŀ)</td>
                </tr>
                <tr> 
                  <td> 
                    <hr>
                  </td>
                </tr>
                <tr> 
                  <td>����ʱ�䣺<%=dates[1]%></td>
                </tr>
                <tr> 
                  <td>
                    <table width="600" border="0" cellspacing="1" cellpadding="4">
                      <tr bgcolor="#D8E4F8"> 
                        <td width="123"><font color="#990033">�豸���ƣ�</font></td>
                        <td width="154"> 
                          <input type="text" name="artName" >
                        </td>
                        <td width="94">�ͺŹ��</td>
                        <td width="188"> 
                          <input type="text" name="spec">
                        </td>
                      </tr>
                    <%if(art_Type.trim().toUpperCase().equals("S")){%>                 
                     <tr bgcolor="#B0C8F0"> 
                        <td width="96" bgcolor="#B0C8F0">�������̣�</td>
                        <td width="154"> 
                          <input type="text" name="manufactory">
                        </td>
                        <td width="121">�������ڣ�</td>
                        <td width="188"> 
                          <input type="text" name="manuf_Date" value="<%=dates[1]%>">
                        </td>
                      </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="96">�������ڵأ�</td>
                        <td width="154"> 
                          <input type="text" name="machine_Loca">
                        </td>
                        <td width="121">����Ŀǰ״̬��</td>
                        <td width="188"> 
                          <select size="1" name="machine_Status">
                          <<%for(int i=0;i<pcount;i++){%>
                          <option value="<%=plists[i][0]%>"><%=plists[i][1]%></option>
                          <%}%>
                          </select>
                        </td>
                      </tr>
                      <tr bgcolor="#D8E4F8"> 
                        <td width="96" bgcolor="#D8E4F8">���������ڣ�</td>
                        <td width="154"> 
                          <input type="text" name="repair_Date" value="<%=dates[1]%>">
                        </td>
                        <td width="121"><font color="#990033">������������</font></td>
                        <td width="188"> 
                          <input type="text" name="throughput">
                        </td>
                      </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="96" bgcolor="#B0C8F0">&nbsp;</td>
                        <td width="154">&nbsp; </td>
                        <td width="121">&nbsp;</td>
                        <td width="188">&nbsp;</td>
                      </tr>
                      <%}%>
                      <tr> 
                        <td width="108" bgcolor="#B0C8F0"><font color="#990033">����</font></td>
                        <td width="154" bgcolor="#B0C8F0"> 
                          <input type="text" name="breadth">
                        </td>
                        <td width="117" bgcolor="#B0C8F0"><font color="#990033">�������٣�</font></td>
                        <td width="180" bgcolor="#B0C8F0"> 
                          <input type="text" name="speed">
                        </td>
                      </tr>
                      <tr bgcolor="#D8E4F8"> 
                        <td width="108"><font color="#990033">��������<br>��g/m2����</font></td>
                        <td width="154"> 
                          <input type="text" name="ration">
                        </td>
                        <td width="117"><font color="#990033">��Ϣ��Ч�ڣ��죩��</font></td>
                        <td width="180"> 
                          <input type="text" name="vali_Date">
                        </td>
                      </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="108">�۸�</td>
                        <td width="154"> 
                          <input type="text" name="price">
                        </td>
                        <td width="117">&nbsp;</td>
                        <td width="180">&nbsp;</td>
                      </tr>
                      <tr bgcolor="#D8E4F8"> 
                        <td width="123" height="108" bgcolor="#D8E4F8">��ע˵����</td>
                        <td colspan="3" height="108"> 
                          <textarea name="content" rows="7"></textarea>
                        </td>
                      </tr>
                      <tr valign="bottom" bgcolor="#B0C8F0"> 
                        <td colspan="4" height="35"><b>��ϵ��Ϣ</b></td>
                      </tr>
                      <tr bgcolor="#D8E4F8"> 
                        <td width="123"><font color="#990033">��˾���ƣ�</font></td>
                        <td colspan="3"> 
                          <input type="text" name="comp_name">
                        </td>
                      </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="123"><font color="#990033">��ϵ�ˣ�</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Name">
                        </td>
                        <td width="94"><font color="#990033">��ϵ�绰��</font></td>
                        <td width="188"> 
                          <input type="text" name="cont_tel">
                        </td>
                      </tr>
                      <tr bgcolor="#D8E4F8"> 
                        <td width="123"><font color="#990033">��ϵ��ַ��</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Address">
                        </td>
                        <td width="94">���棺</td>
                        <td width="188"> 
                          <input type="text" name="cont_Fax">
                        </td>
                      </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="123"><font color="#990033">�ʱࣺ</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Postcode">
                        </td>
                        <td width="94">Email��</td>
                        <td width="188"> 
                          <input type="text" name="cont_Email">
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr align="center"> 
                  <td> 
                    <input type="submit" name="Submit2" value="�� ��">
                    <input type="reset" value="ȡ��"   name="button">
                  </td>
                </tr>
              </table>
            </td>
        </tr>
       </table>
     </form>
    </td>
  </tr>
</table>

<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="/images/dline.gif" border="0" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="/images/dipic.gif" border="0" width="80" height="24"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</body>
</html>

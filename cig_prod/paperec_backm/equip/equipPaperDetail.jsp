<html>
<%@ page import="java.util.*, java.net.*" %>
<head>
<title>PAPEREC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.white {  font-family: "宋体"; font-size: 10pt; color: #FFFFFF}
a:link {  font-family: "宋体"; text-decoration: none}
a:visited {  font-family: "宋体"; text-decoration: none}
a:active {  font-family: "宋体"; text-decoration: none}
a:hover {  font-family: "宋体"; text-decoration: underline}
td {  font-family: "宋体"; font-size: 10pt}
.black {  font-family: "宋体"; color: #000000}
.algin {  font-family: "宋体"; font-size: 10pt; text-align: justify; line-height: 18pt}
.title {  font-family: "宋体"; font-size: 14px; font-weight: 400}
-->
</style>
<script language="JavaScript">
<!--
var onTop = false
function launchRemote(url) {
	var newwinn=open(url, "pp", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=666,height=502');
	newwinn.focus();
        return false;
}
//-->
</script>
<script language="JavaScript">
<!--
function validateForm(e){
        
  
       if(e.breadth.value==''){
	  alert('请输入幅宽，然后提交!')
	  e.breadth.focus()
	return false;
	}
        if(e.artName.value==''){
	  alert('请输入设备名称，然后提交!')
	  e.artName.focus()
	return false;
	}
	if(e.cont_Name.value==''){
	  alert('请输入联系人姓名，然后提交!')
	  e.cont_Name.focus()
	return false;
	}
        if(e.cont_tel.value==''){
	alert('请输入电话，然后提交!')
	e.cont_tel.focus()
	return false;
	}
	if(e.comp_name.value==''){
	alert('请输入公司名称，然后提交!')
	e.comp_name.focus()
	return false;
	}
    if(numericCheck(e)!=true)
     return false;	
}

function numericCheck(e){
   nr1=e.vali_Date.value;
   if(nr1.length==0){
   alert("天数不能为空，只少为1 !\n");
   e.vali_Date.focus();
   return false;
   }
   cmp="123456789";
   tst=nr1.substring(0,1);
   if(cmp.indexOf(tst)<0){
   alert("天数 只接受数字，只少为1 !\n");
   e.vali_Date.focus();
   return false;
   }
   cmp="0123456789";
   for (var i=1;i<nr1.length;i++){
   tst=nr1.substring(i,i+1);
   if(cmp.indexOf(tst)<0){
   alert("天数 只接受数字!\n");
   e.vali_Date.focus();
   return false;
   }
  }
return true;
}
//-->
</script>
</head>
<%
    Hashtable pHash =new Hashtable();
    String art_ID=request.getParameter("art_ID");
    pHash.put("art_ID",art_ID);
    pHash.put("langCode",new String("GB"));
    pHash.put("paperFlag",new String("Y"));
    pHash.put("bst",new String("Y"));
%>
<jsp:useBean id="Equip_Art" scope="page" class="com.paperec.equip.Equip_Art" />
<%
     Equip_Art.setParameteres(pHash);
     String[] detail;
    
     detail = Equip_Art.getDetail();
%>
<jsp:useBean id="Parameter" scope="page" class="com.paperec.equip.Parameter" />
<%
pHash.put("pageFlag",new String("N"));
pHash.put("id",new String("21"));
Parameter.setParameteres(pHash);
    String[][] plists;
    int pcount=0;
    plists = Parameter.getList();
    pcount = Parameter.getCount();
%>   
<body bgcolor="#FFFFFF" topmargin="0" marginwidth="0">
<table width="500" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  <tr>
    <td>
      <table width="500" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
        <tr>
          <td class="title"><b><%if(detail[1].trim().toUpperCase().equals("S")){%>供应<%}else{%>需求<%}%><%if(!(detail[2].trim().equals("0"))){%>回复<%}%>信息详情浏览</b></td>
        </tr>
        <tr>
          <td>
            <hr>
          </td>
        </tr>
        <tr>
          <td height="144"> 
          
           <table width="500" border="0" cellspacing="1" cellpadding="4">
           <form method="POST" name="equipMap" action="equipUpdatePost.jsp" onSubmit="return validateForm(equipMap);">
           <input type=hidden name="art_ID" value="<%=art_ID%>" >
           <input type=hidden name="art_Type" value="<%=detail[1]%>" >
              <tr> 
                <td colspan="4" bgcolor="#4078E0"><font color="#FFFFFF"><span class="title"><b><%=detail[23]%><%=detail[0]%></b></span>(<%=detail[24]%>,点击次数为<%if(detail[21]==null){%>0<%}else{%><%=detail[21]%><%}%>次）</font></td>
              </tr>
              <tr bgcolor="#B0C8F0"> 
                <td bgcolor="#B0C8F0" width="126"><b>机器名称：</b></td>
                <td width="100"><input type="text" name="artName" size="20" value="<%=detail[4]%>" ></td>
                <td width="131"><b>型号规格：</b></td>
                <td width="130"><input type="text" name="spec" size="20" value="<%=detail[7]%>" ></td>
              </tr>
              <%if(detail[1].trim().toUpperCase().equals("S")){%> 
              <tr bgcolor="#D8E4F8"> 
                <td width="126"><b>生产厂商：</b></td>
                <td width="100" bgcolor="#D8E4F8"><input type="text" name="manufactory" size="20" value="<%=detail[5]%>" ></td>
                <td width="131"><b>出厂日期：</b></td>
                <td width="130" bgcolor="#D8E4F8"><input type="text" name="manuf_Date" size="20" value="<%=detail[6]%>" ></td>
              </tr>
              <tr bgcolor="#B0C8F0"> 
                <td bgcolor="#B0C8F0" width="126"><b>机器所在地：</b></td>
                <td bgcolor="#B0C8F0" width="100"><input type="text" name="machine_Loca" size="20" value="<%=detail[8]%>" ></td>
                <td width="131"><b>年生产能力：</b></td>
                <td width="107"><input type="text" name="throughput" value="<%=detail[33]%>"></td>
              </tr>
              <tr bgcolor="#D8E4F8"> 
                <td width="126"><b>最后大修日期：</b></td>
                <td width="95"><input type="text" name="repair_Date" value="<%=detail[32]%>"></td>
                <td width="131"><b>机器目前状态：</b></td>
                <td width="100"><select size="1" name="machine_Status">
                  <%for(int i=0;i<pcount;i++){%>
                  <option value="<%=plists[i][0]%>" <%if(detail[9].trim().toUpperCase().equals(plists[i][0].trim().toUpperCase())){%>selected<%}%>><%=plists[i][1]%></option>
                  <%}%>
                  </select></td>
              </tr>
              <%}%>
              <tr bgcolor="#B0C8F0"> 
                <td bgcolor="#B0C8F0" width="126"><b>幅宽：</b></td>
                <td width="95"><input type="text" name="breadth" value="<%=detail[29]%>"></td>
                <td width="131"><b>工作车速：</b></td>
                <td width="107"><input type="text" name="speed" value="<%=detail[30]%>"></td>
              </tr>
              <tr bgcolor="#D8E4F8"> 
                <td width="126"><b>抄纸定量（g/m2）：</b></td>
                <td width="95"><input type="text" name="ration" value="<%=detail[31]%>"></td>
                <td width="131"><b>信息有效期（天）：</b></td>
                <td width="107"><input type="text" name="vali_Date" size="20" value="<%=detail[12]%>" ></td>
              </tr>
              <tr  bgcolor="#B0C8F0"> 
                 <td colspan="4" height="35"><b><%if(!(detail[2].trim().equals("0"))){%>回复人<%}%>联系信息</b></td>
               </tr>
               <tr bgcolor="#D8E4F8"> 
               <td width="123"><font color="#990033">公司名称：</font></td>
                 <td> 
                   <input type="text" name="comp_name" value="<%=detail[13]%>">
                  </td>
                  <td width="123"><font color="#990033">IP</font></td>
                  <td width="123"><font color="#990033"><%=detail[28]%>&nbsp;</font></td>
               </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="123"><font color="#990033">联系人：</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Name" value="<%=detail[14]%>">
                        </td>
                        <td width="94"><font color="#990033">联系电话：</font></td>
                        <td width="188"> 
                          <input type="text" name="cont_tel" value="<%=detail[15]%>">
                        </td>
                      </tr>
                      <tr bgcolor="#D8E4F8"> 
                        <td width="123"><font color="#990033">联系地址：</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Address" value="<%=detail[16]%>">
                        </td>
                        <td width="94">传真：</td>
                        <td width="188"> 
                          <input type="text" name="cont_Fax" value="<%=detail[17]%>">
                        </td>
                      </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="123"><font color="#990033">邮编：</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Postcode" value="<%=detail[18]%>">
                        </td>
                        <td width="94">Email：</td>
                        <td width="188"> 
                          <input type="text" name="cont_Email" value="<%=detail[19]%>">
                        </td>
                      </tr>
               <tr bgcolor="#B0C8F0"> 
                <td width="101"><b>备注说明：</b></td>
                <td colspan="3"><textarea name="content" rows="7"><%=detail[10]%></textarea></td>
               </tr>
               <tr>
                <td>
                <div align="center"><input type="submit" value="内容修改提交" name="changSub"></div>
               </td>
               </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <hr>
          </td>
        </tr>
        <tr>
          <td>〖<a href="mailto:<%=detail[19]%>">email <%=detail[14]%></a>〗<%if(!(detail[2].trim().equals("0"))){%>〖<a href="mailto:<%=detail[27]%>">email 原作者:<%=detail[26]%></a>〗<%}%>〖<a href="javascript:window.close();">关闭返回</a>〗</td>
        </tr>
        <tr>
          <td>
            <hr>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

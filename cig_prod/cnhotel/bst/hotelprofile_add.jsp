<html>
<head>
<title>CNHotelBooking.com��̨������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<SCRIPT LANGUAGE=javascript>
<!--


function PostForm()
{
  if (fmAddHotel.txtName.value == "")
  {	
	alert("��������������!");
	return;
  }
  if (fmAddHotel.txtAddress.value == "")
  {	
	alert("�������ַ!");
	return;
  }
  if (fmAddHotel.txtCity.value == "")
  {	
	alert("���������!");
	return;
  }
  if (fmAddHotel.txtState.value == "")
  {	
	alert("������ʡ��!");
	return;
  }
  if (fmAddHotel.sltCtryCode.value == "")
  {	
	alert("��ѡ�����!");
	return;
  }
  if (fmAddHotel.txtPostCode.value == "")
  {	
	alert("�������������!");
	return;
  }
  if (fmAddHotel.txtTelephone.value == "")
  {	
	alert("������绰����!");
	return;
  }
  fmAddHotel.submit();
}
//-->
</SCRIPT>
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="26">&nbsp; </td>
    <td width="547"> 
      <form name= fmAddHotel method="post" action="/cnhotel/servlet/com.dreamerland.cnhotelbooking.bst.CbstAddHotel">
        <table width="550" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td height="30" class="font12"> ��ӾƵ�����</td>
          </tr>
        </table>
        <table width="554" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr class="font9"> 
            <td width="80" class="font9" height="35">�������ƣ�</td>
            <td class="font9" height="35" width="168"> 
              <input name="txtName" 
           > *
            </td>
            <td class="font9" height="35" width="77">Ӣ�����ƣ�</td>
            <td class="font9" height="35" width="169"> 
              <input name="txtNameEN" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">����</td>
            <td width="168"> 
              <select name="sltArea" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="Dir_setting" />
        <jsp:param name="Display" value="Description" />
        <jsp:param name="Value" value="ID" />
</jsp:include>


      </select> *
    </td>
            <td width="77" class="font9">��ַ��</td>
            <td width="169"> 
              <input name="txtAddress" 
           >&nbsp;*
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">����λ�ã�</td>
            <td width="168"> 
              <input name="txtLocation" 
           >
            </td>
            <td width="77" class="font9">���У�</td>
            <td width="169"> 
              <select name="txtCity" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">    
        <jsp:param name="Display" value="Name" /> 
        <jsp:param name="Table" value="City_gb" /> 
        <jsp:param name="Value" value="CityID" /> 
</jsp:include> 

		</select>


              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">������ţ�</td>
            <td width="168"> 
              <input name="txtPostCode" 
           >&nbsp;*
            </td>
            <td width="77" class="font9">ʡ�ݣ�</td>
            <td width="169"> 
              <select name="txtState" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="State_gb" />
        <jsp:param name="Display" value="Name" />
        <jsp:param name="Value" value="StateID" />
</jsp:include>


              </select>
              * </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9" height="37">���ң�</td>
            <td width="168" height="37"> 
              <select name="sltCtryCode" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Display" value="Name" /> 
        <jsp:param name="Table" value="Country_gb" /> 
        <jsp:param name="Value" value="ID" /> 
</jsp:include> 

              
		</select> *
            </td>
            <td width="77" class="font9" height="37">�绰��</td>
            <td width="169" height="37"> 
              <input name="txtTelephone" 
            style="HEIGHT: 22px; WIDTH: 153px">&nbsp;*
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">���棺</td>
            <td width="168"> 
              <input name="txtFax" 
           >
            </td>
            <td width="77" class="font9">�������䣺</td>
            <td width="169"> 
              <input name="txtEmail" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">�Ƶ���ҳ��</td>
            <td width="168"> 
              <input name="txtUrl" 
           >
            </td>
            <td width="77" class="font9">��ϵ�ˣ�</td>
            <td width="169"> 
              <input name="txtContact" 
           >
            </td>
          </tr>
          <tr> 
            <td width="80" class="font9">�۸�ȼ���</td>
            <td width="168"> 
              <select name="sltPriceRange" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="Price_range" />
        <jsp:param name="Display" value="Description" />
        <jsp:param name="Value" value="ID" />
</jsp:include>

              </select>
            </td>
            <td width="77" class="font9">�Ǽ���</td>
            <td width="169" class="font9"> 
              <select name="sltStarating" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="star_rating" />
        <jsp:param name="Display" value="Name" />
        <jsp:param name="Value" value="ID" />
</jsp:include>


          </select> 
        *
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">ͼƬ·����</td>
            <td width="168"> 
              <select name="sltImageDir" size="1">
              

<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="Dir_setting" />
        <jsp:param name="Display" value="Description" />
        <jsp:param name="Value" value="ID" />
</jsp:include>
		</select>
            </td>
            <td width="77" class="font9">ͼƬ�ļ�1��</td>
            <td width="169"> 
              <input name="txtImageFile1" 
           >
            </td>
          </tr>
          <tr> 
            <td width="80" class="font9">ͼƬ�ļ�2��</td>
            <td width="168" class="font9"> 
              <input name="txtImageFile2" >
            </td>
            <td width="77" class="font9">ͼƬ�ļ�3</td>
            <td width="169"> 
              <input name="txtImageFile3" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">��ͼĿ¼��</td>
            <td width="168"> 
              <select name="sltMapDir" size="1">
              
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="Dir_setting" />
        <jsp:param name="Display" value="Description" />
        <jsp:param name="Value" value="ID" />
</jsp:include>
	</select>
            </td>
            <td width="77">��ͼ�ļ���</td>
            <td width="169"> 
              <input name="txtMapFile" >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">Ҫ���Ƽ���</td>
            <td width="168"> 
              <input type="radio" name="rdPromotion" value="Y">
              �� 
              <input type="radio" name="rdPromotion" value="N" checked>
              �� </td>
            <td width="77">�����ͣ�</td>
            <td width="169"> 
              <input type="radio" name="rdFreeBreakfast" value="Y">
              �� 
              <input type="radio" name="rdFreeBreakfast" value="N" checked>
              �� </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">�Żݷ���</td>
            <td width="168"> 
              <input type="radio" name="rdService" value="Y">
              �� 
              <input type="radio" name="rdService" value="N" checked>
              ��</td>
            <td width="77">����Ԥ����</td>
            <td width="169"> 
              <input type="radio" name="rdStatus" value="Y">
              �� 
              <input type="radio" name="rdStatus" value="N" checked>
              ��</td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">������ʩ��</td>
            <td colspan="3"><TEXTAREA cols=50 name=txtFacilityDrink></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">������ʩ��</td>
            <td colspan="3"><TEXTAREA cols=50 name=txtFacilityEnt></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">������ʩ��</td>
            <td colspan="3"><TEXTAREA cols=50 name=txtFacilityServ></TEXTAREA>
            </td>
          </tr>
          <tr> 
            <td width="80" class="font9">���������</td>
            <td colspan="3"> 
              <table width="109" border="0" cellspacing="0" cellpadding="0">
                <tr align="middle"> 
                  <td><TEXTAREA cols=50 name=txtSDesc></TEXTAREA>
                  </td>
                </tr>
              </table>
              
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">��ϸ������</td>
            <td colspan="3"><TEXTAREA cols=50 name=txtFDesc></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">�������ڣ�</td>
            <td colspan="3"> 
              <input name="txtCreateDate" 
           >
              [�����ʽ YYYY-MM-DD��2000-03-06] </td>
          </tr>
        </table>
        <table width="550" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="40"> <A href="JavaScript:PostForm()"><IMG border=0 height=26 src="images/botton_add.gif" width=68></A><IMG height=1 src="images/dot.gif" width=50> 
              <A href="http://bst.cnbooking.com/Hotelprofile_add.htm"><IMG border=0 height=26 src="images/botton_restore.gif" width=68></a></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
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
	alert("请输入中文名称!");
	return;
  }
  if (fmAddHotel.txtAddress.value == "")
  {	
	alert("请输入地址!");
	return;
  }
  if (fmAddHotel.txtCity.value == "")
  {	
	alert("请输入城市!");
	return;
  }
  if (fmAddHotel.txtState.value == "")
  {	
	alert("请输入省份!");
	return;
  }
  if (fmAddHotel.sltCtryCode.value == "")
  {	
	alert("请选择国家!");
	return;
  }
  if (fmAddHotel.txtPostCode.value == "")
  {	
	alert("请输入邮政编号!");
	return;
  }
  if (fmAddHotel.txtTelephone.value == "")
  {	
	alert("请输入电话号码!");
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
            <td height="30" class="font12"> 添加酒店资料</td>
          </tr>
        </table>
        <table width="554" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr class="font9"> 
            <td width="80" class="font9" height="35">中文名称：</td>
            <td class="font9" height="35" width="168"> 
              <input name="txtName" 
           > *
            </td>
            <td class="font9" height="35" width="77">英文名称：</td>
            <td class="font9" height="35" width="169"> 
              <input name="txtNameEN" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">区域：</td>
            <td width="168"> 
              <select name="sltArea" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="Dir_setting" />
        <jsp:param name="Display" value="Description" />
        <jsp:param name="Value" value="ID" />
</jsp:include>


      </select> *
    </td>
            <td width="77" class="font9">地址：</td>
            <td width="169"> 
              <input name="txtAddress" 
           >&nbsp;*
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">具体位置：</td>
            <td width="168"> 
              <input name="txtLocation" 
           >
            </td>
            <td width="77" class="font9">城市：</td>
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
            <td width="80" class="font9">邮政编号：</td>
            <td width="168"> 
              <input name="txtPostCode" 
           >&nbsp;*
            </td>
            <td width="77" class="font9">省份：</td>
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
            <td width="80" class="font9" height="37">国家：</td>
            <td width="168" height="37"> 
              <select name="sltCtryCode" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Display" value="Name" /> 
        <jsp:param name="Table" value="Country_gb" /> 
        <jsp:param name="Value" value="ID" /> 
</jsp:include> 

              
		</select> *
            </td>
            <td width="77" class="font9" height="37">电话：</td>
            <td width="169" height="37"> 
              <input name="txtTelephone" 
            style="HEIGHT: 22px; WIDTH: 153px">&nbsp;*
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">传真：</td>
            <td width="168"> 
              <input name="txtFax" 
           >
            </td>
            <td width="77" class="font9">电子信箱：</td>
            <td width="169"> 
              <input name="txtEmail" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">酒店主页：</td>
            <td width="168"> 
              <input name="txtUrl" 
           >
            </td>
            <td width="77" class="font9">联系人：</td>
            <td width="169"> 
              <input name="txtContact" 
           >
            </td>
          </tr>
          <tr> 
            <td width="80" class="font9">价格等级：</td>
            <td width="168"> 
              <select name="sltPriceRange" size="1">
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="Price_range" />
        <jsp:param name="Display" value="Description" />
        <jsp:param name="Value" value="ID" />
</jsp:include>

              </select>
            </td>
            <td width="77" class="font9">星级：</td>
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
            <td width="80" class="font9">图片路径：</td>
            <td width="168"> 
              <select name="sltImageDir" size="1">
              

<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="Dir_setting" />
        <jsp:param name="Display" value="Description" />
        <jsp:param name="Value" value="ID" />
</jsp:include>
		</select>
            </td>
            <td width="77" class="font9">图片文件1：</td>
            <td width="169"> 
              <input name="txtImageFile1" 
           >
            </td>
          </tr>
          <tr> 
            <td width="80" class="font9">图片文件2：</td>
            <td width="168" class="font9"> 
              <input name="txtImageFile2" >
            </td>
            <td width="77" class="font9">图片文件3</td>
            <td width="169"> 
              <input name="txtImageFile3" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">地图目录：</td>
            <td width="168"> 
              <select name="sltMapDir" size="1">
              
<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true">
        <jsp:param name="Table" value="Dir_setting" />
        <jsp:param name="Display" value="Description" />
        <jsp:param name="Value" value="ID" />
</jsp:include>
	</select>
            </td>
            <td width="77">地图文件：</td>
            <td width="169"> 
              <input name="txtMapFile" >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">要求推荐：</td>
            <td width="168"> 
              <input type="radio" name="rdPromotion" value="Y">
              是 
              <input type="radio" name="rdPromotion" value="N" checked>
              否 </td>
            <td width="77">免费早餐：</td>
            <td width="169"> 
              <input type="radio" name="rdFreeBreakfast" value="Y">
              是 
              <input type="radio" name="rdFreeBreakfast" value="N" checked>
              否 </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">优惠服务：</td>
            <td width="168"> 
              <input type="radio" name="rdService" value="Y">
              是 
              <input type="radio" name="rdService" value="N" checked>
              否</td>
            <td width="77">建立预订：</td>
            <td width="169"> 
              <input type="radio" name="rdStatus" value="Y">
              是 
              <input type="radio" name="rdStatus" value="N" checked>
              否</td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">餐饮设施：</td>
            <td colspan="3"><TEXTAREA cols=50 name=txtFacilityDrink></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">娱乐设施：</td>
            <td colspan="3"><TEXTAREA cols=50 name=txtFacilityEnt></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">服务设施：</td>
            <td colspan="3"><TEXTAREA cols=50 name=txtFacilityServ></TEXTAREA>
            </td>
          </tr>
          <tr> 
            <td width="80" class="font9">简短描述：</td>
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
            <td width="80" class="font9">详细描述：</td>
            <td colspan="3"><TEXTAREA cols=50 name=txtFDesc></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="80" class="font9">合作日期：</td>
            <td colspan="3"> 
              <input name="txtCreateDate" 
           >
              [输入格式 YYYY-MM-DD，2000-03-06] </td>
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

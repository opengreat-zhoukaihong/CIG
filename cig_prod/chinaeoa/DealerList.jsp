
<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<html>
<head>
<title>ChinaEOA.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="window.moveTo(0,0);" background="/images/temp/bg.gif">
<table width="280" border="0" cellspacing="0" cellpadding="0" height="500">
  <tr valign="top"> 
    <td> 
      <table width="300" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2"><img src="/images/temp/dealer_title.gif" width="280" height="62"></td>
        </tr>
        <tr align="center"> 
          <td colspan="2" class="font4b" height="30">各地经销商名录</td>
        </tr>
        <tr> 
          <td width="14"><img src="/images/spacer.gif" width="14" height="1"></td>
          <td valign="top"> <% ResultSet rs = null;
			String ProvinceId = request.getParameter("ProvinceId");
			String LangCode = request.getParameter("LangCode");
			String SQL = "select m.tel,m.fax,m.zipcode, " +
				 " ml.compName,(ml.address1||ml.address2) address," + 
				 " (ml.contName_f||ml.ContName_l) ContName from " +
 				 " member m ,member_l ml " + 
				 " where ml.memberid = m.memberid and ml.lang_code = '" + LangCode + "' and m.PROVINCEID = " + ProvinceId + "and m.membertype = 4";
			rs = Result.getRS(SQL);
			if (rs!=null)
			{
	              while (rs.next())
			  {	
				%> 
            <table width="267" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="19" bgcolor="#2078CB" colspan="2" align="center"><font color="#FFFFFF"><%=rs.getString("CompName")%></font></td>
                <td height="20" width="13" align="right" rowspan="2"><img src="/images/temp/corner.gif" width="10" height="20" align="absbottom"></td>
              </tr>
              <tr> 
                <td height="1" bgcolor="#2078CB" colspan="2"><img src="/images/spacer.gif" width="257" height="1" align="absbottom"></td>
              </tr>
            </table>
            <table width="267" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="20" align="right" class="font1b" width="70">联 系 人：</td>
                <td height="20" colspan="2" width="197"><% if (rs.getString("ContName") != null)
									out.println(rs.getString("ContName"));%></td>
              </tr>
              <tr> 
                <td height="20" align="right" class="font1b" width="70">地&nbsp;&nbsp;&nbsp;&nbsp;址：</td>
                <td height="20" colspan="2" width="197"><% if (rs.getString("Address") != null)
									out.println(rs.getString("Address"));%></td>
              </tr>
              <tr> 
                <td height="20" align="right" class="font1b" width="70">邮&nbsp;&nbsp;&nbsp;&nbsp;编：</td>
                <td height="20" colspan="2" width="197"><% if (rs.getString("ZipCode") != null)
									out.println(rs.getString("ZipCode"));%></td>
              </tr>
              <tr> 
                <td height="20" align="right" class="font1b" width="70">电话号码：</td>
                <td height="20" colspan="2" width="197"><% if (rs.getString("Tel") != null)
									out.println(rs.getString("Tel"));%></td>
              </tr>
              <tr> 
                <td height="20" align="right" class="font1b" width="70">传&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
                <td height="20" colspan="2" width="197"><% if (rs.getString("Fax") != null)
									out.println(rs.getString("Fax"));%></td>
              </tr>
            </table>
            <%
			  }
			}
			else
			  out.println(SQL);
			 %> </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr valign="top"> 
    <td align="center"> 
      <table width="280" cellspacing="0" cellpadding="0" border="0" bgcolor="#2078CB">
        <tr> 
          <td>&nbsp;</td>
          <td align="right" width="40"><b><a href="javascript:window.close();" target="_self"><font color="#FFFFFF">关&nbsp;&nbsp;闭</font></a></b></td>
          <td width="10" align="center"><img src="/images/temp/corner.gif" width="10" height="20"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%if (Result.CloseStm()) 
        out.println("");%>
</body>
</html>


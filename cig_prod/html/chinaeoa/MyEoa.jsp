<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
   String MemberId  = (String)session.getValue("cneoa.MemberId");
   if (MemberId == null)
   {
     MemberId = "";
         %>
     <jsp:forward page="NotLogin.jsp" />
         <%
    }
   String MemberType = (String)session.getValue("cneoa.MemberType");
   if (MemberType == null)
     MemberType = "";
   String UserLevel = (String)session.getValue("cneoa.UserLevel");
%>
<html><!-- #BeginTemplate "/Templates/ceoa.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ChinaEOA.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
<script
language="JavaScript">
<!--

function imgOn (imgName) {
if (document.images) {
document[imgName].src = eval (imgName + "on.src");
}
}
function imgOff (imgName) {
if (document.images) {
document[imgName].src = eval(imgName + "off.src");
}
}
function MM_preloadImages() { //v3.0
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language="JavaScript">
function opendealer(url)
    {   
        OpenWindow=window.open(url, "newwin", "width=320,toolbar=no,scrollbars=yes,menubar=no");
}
function openorder(url)
    {   
        OpenWindow=window.open(url, "win1", "height=300 width=600,toolbar=no,scrollbars=yes,menubar=no,resize=yes");
}
</script>
</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr> 
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<%@ include file="title.jsp"%>
<table width="640" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" colspan="2"><!-- #BeginEditable "body" --> 
      <table border="0" cellspacing="0" cellpadding="1" height="230" width="640">
        <tr> 
          <td valign="top"> 
            <table width="100" border="0" cellspacing="0" cellpadding="0" height="20">
              <tr>
                <td><font color="#FFFFFF">sf</font></td>
              </tr>
            </table>
            <table width="80" border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="#217ACE">
              <tr> 
                <td> 
                  <table width="150" border="0" cellspacing="1" cellpadding="0" align="center">
                    <% if (MemberType.equals("4"))
					   {
                     %> 
                    <tr bgcolor="#217ACE" align="center"> 
                      <td class="font3b" height="30" bordercolor="1"><font color="#FFFFFF"> 
                        <div align="center"><b>������</b></div>
                        </font></td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"><a href="searchOrders_dealer.jsp">�鿴����</a></td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"><a href="approveOrders1.jsp">������������</a></td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"><a href="approveOrders2.jsp">�����߼�����</a></td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="modifyPasswd.jsp">�޸�����</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="addUserID.jsp">�����û�</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="userIDList.jsp">�޸��ڲ��û�</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="modifyProfile.jsp">�޸��û�����</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="addShip.jsp">�������͵�</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="shipList.jsp?action=browse">��ѯ���͵���Ϣ</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="shipList.jsp?action=modify">�޸����͵���Ϣ</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="shipList.jsp?action=delete">ɾ�����͵�</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"><a href="viewCredits_dealer.jsp">��ѯ���ö��</a></td>
                    </tr>
                    <%   }	
					   else if (MemberType.equals("1"))
                         {
					%> 
                    <tr bgcolor="#217ACE" align="center"> 
                      <td class="font3b" height="30" bordercolor="1"><font color="#FFFFFF"> 
                        <div align="center"><b>EOA</b></div>
                        </font></td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"><a href="searchOrders_eoa.jsp">�鿴����</a></td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"><a href="modifyPasswd.jsp">�޸�����</a></td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"><a href="addUserID.jsp">�����ڲ��û�</a></td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"><a href="modifyProfile.jsp">�޸��ڲ��û�</a></td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"><a href="modifyProfile.jsp">�޸��ҵ�����</a></td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="pendingMemberList.jsp">�����»�Ա</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="searchMember.jsp?action=browse">��ѯ��Ա����</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="searchMember.jsp?action=delete">ɾ����Ա</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="searchCredits.jsp?action=add">���û�Ա����</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="searchCredits.jsp?action=modify">�޸Ļ�Ա����</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="searchCredits.jsp?action=delete">ɾ����Ա����</a><a href="searchCredits.jsp?action=delete"></a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="addSupplier.jsp">���Ӵ�����</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="eoa-bst/bstMain.htm">��̨����ϵͳ</a></div>
                      </td>
                    </tr>
                    <%
					   }	
					   else if (MemberType.equals("5"))
					   {
                    %> 
                    <tr bgcolor="#217ACE" align="center"> 
                      <td class="font3b" height="30" bordercolor="1"><font color="#FFFFFF"> 
                        <div align="center"><b>������</b></div>
                        </font></td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"><a href="searchOrders_supp.jsp">�鿴����</a></td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center">
                      <td height="23" bordercolor="1"><a href="modifyPasswd.jsp">�޸�����</a></td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="searchPayment.jsp?action=add">�������ö��</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="searchPayment.jsp?action=modify">�޸����ö��</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="searchPayment.jsp?action=delete">ɾ�����ö��</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="addUserID.jsp">�����û�</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="userIDList.jsp">�޸��ڲ��û�</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="modifyProfile.jsp">�޸��û�����</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="addDelivery.jsp">�������͹�˾</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="deliveryList.jsp?action=modify">�޸����͹�˾��Ϣ</a></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF" align="center"> 
                      <td height="23" bordercolor="1"><a href="deliveryList.jsp?action=browse">��ѯ���͹�˾��Ϣ</a></td>
                    </tr>
                    <tr bgcolor="#E8F6FF" align="center"> 
                      <td height="23" bordercolor="1"> 
                        <div align="center"><a href="deliveryList.jsp?action=delete">ɾ�����͹�˾</a></div>
                      </td>
                    </tr>
                    <%
					}
                    String LangCode = request.getParameter("LangCode");
 					ResultSet rs = null;
                    %> 
                  </table>
                </td>
              </tr>
            </table>
            <br>
            <br>
          </td>
          <td valign="top"> 
            <table width="400" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>
                  <table border="0" cellspacing="0" cellpadding="0" width="460" align="center">
                    <tr> 
                      <td height="20" colspan="2">
                        <table border="0" cellspacing="0" cellpadding="0" width="460">
                          <tr> 
                            <td height="20" width="227"><img src="/images/temp/path.gif" width="49" height="13"> 
                              <img src="/images/arrow.gif" width="7" height="11"> 
                              <a href="index.jsp">��ҳ</a> <img src="/images/arrow.gif" width="7" height="11"> 
                              MyEOA</td>
                            <td align="right" height="20" width="233"><img src="/images/temp/car.gif" width="19" height="16" align="absbottom"> 
                              <a href="#" onClick="openorder('AddOrder.jsp?LangCode=<%=LangCode%>')">�鿴���ﳵ</a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  
                </td>
              </tr>
              <tr>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0" height="300" width="500">
                    <tr valign="top" align="center"> 
                      <td> <br>
                        <% 
					     rs = Result.getRS("select p.Prodid, p.productNo,p.listprice, b.name, b.Filename as bFilename, c.catename,d.dir,s.filename1 from product p, " + 
  						   " brand b, category c, speci_sale s, dir_setting d " +
 						   " where p.brandid = b.brandid and b.lang_code = 'GB' " + 
						   " and  p.cateid = c.cateid and c.lang_code = b.lang_code " + 
						   " and p.prodid = s.prodid and s.location='P' " +
						   " and s.picdir1 = d.dirid(+)");
                           //rs = null;
   					     if (rs!=null)
                         {

						   
                           if (rs.next())
                           {
					       %> 
                        <table width="347" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
                          <tr> 
                            <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"> 
                              <img src="<%="../images/BrandLogo/"+rs.getString("bFilename")%>" width="80" height="21" border="0" ></a></td>
                          </tr>
                          <tr> 
                            <td> 
                              <table width="347" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td> 
                                    <table width="346" border="0" cellspacing="0" cellpadding="0" background="/images/temp/hot_bg.gif" height="104">
                                      <tr> 
                                        <td align="center"><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"> 
                                          <img src="<%
                                    String FileName = "";
                                    if (rs.getString("Dir") == null)
                                      FileName = "../images/hots/" + rs.getString("FileName1");
									else
    								  FileName = "/" + rs.getString("Dir") + rs.getString("FileName1");
									out.println(FileName);
                                 %>" width="149" height="89" border="0"></a></td>
                                        <td align="center"> 
                                          <table width="160" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                                              <td><%=rs.getString("name")%></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                              <td><%=rs.getString("ProductNo")+rs.getString("catename")%></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                              <td><%="�۸�:" + rs.getString("listPrice") + "Ԫ"%></td>
                                            </tr>
                                            <tr align="center"> 
                                              <td colspan="2" height="30"> 
                                                <table width="160" border="0" cellspacing="0" cellpadding="0">
                                                  <tr align="center"> 
                                                    <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&amp;LangCode=GB"> 
                                                      <img src="/images/temp/b_detail.gif" width="44" height="17" border="0"></a></td>
                                                    <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&amp;LangCode=GB"><img src="/images/temp/b_buy.gif" width="44" height="17" border="0"></a></td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                          </tr>
                        </table>
                         
                        <% 
                          }
                          if (rs.next())
                          {
                          %> 
                        <table width="347" border="0" cellspacing="0" cellpadding="0">
                          <tr align="right"> 
                            <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"><img src="<%="../images/BrandLogo/"+rs.getString("bFilename")%>" width="80" height="21" border="0" ></a></td>
                          </tr>
                          <tr> 
                            <td> 
                              <table width="347" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td> 
                                    <table width="346" border="0" cellspacing="0" cellpadding="0" background="/images/temp/hot_bg.gif" height="104">
                                      <tr> 
                                        <td align="center">
                                          <table width="160" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                                              <td><%=rs.getString("name")%></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                              <td> <%=rs.getString("ProductNo")+rs.getString("catename")%></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                              <td><%="�۸�:" + rs.getString("listPrice")+ "Ԫ"%></td>
                                            </tr>
                                            <tr align="center"> 
                                              <td colspan="2" height="30"> 
                                                <table width="160" border="0" cellspacing="0" cellpadding="0">
                                                  <tr align="center"> 
                                                    <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&amp;LangCode=GB"><img src="/images/temp/b_detail.gif" width="44" height="17" border="0"></a></td>
                                                    <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&amp;LangCode=GB"><img src="/images/temp/b_buy.gif" width="44" height="17" border="0"></a></td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                        <td align="center"><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"><img src="<%
                                    String FileName = "";
                                    if (rs.getString("Dir") == null)
                                      FileName = "../images/hots/" + rs.getString("FileName1");
									else
    								  FileName = "/" + rs.getString("Dir") + rs.getString("FileName1");
									out.println(FileName);
                                 %>" width="149" height="89" border="0"></a> </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                          </tr>
                        </table>
                      <%
                         }
                       }%>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="330" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr align="center"> 
                      <td><a href="/guide.htm">����ָ��</a> | <a href="/service.htm">�ۺ����</a> 
                        | <a href="/about.htm#contactus">��ϵ���� </a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> 
    </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>
<%if (Result.CloseStm()) 
        out.println("");%>

</body>
<!-- #EndTemplate --></html>

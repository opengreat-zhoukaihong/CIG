<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<html>
<head>
<title>ChinaEOA.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
 function Login()
{
  if (fmLogin.User.value == "" || fmLogin.Passwd.value == "")
  {
    alert("�������û������");
  }
  else
  {
    //launchRemote("Login.jsp?User=" + fmLogin.User.value + "&Passwd=" + fmLogin.Passwd.value);
    //fmLogin.action = "";
    fmLogin.submit();
  }
}
function Search()
{
  if (fmSearch.Brand.value == "0" || fmSearch.ProductNo.value == "0")
  {
    alert("��ѡ��Ʒ�����ͺ�");
  }
  else
  {
    fmSearch.action = "ProductDetail.jsp?LangCode=GB&ProdId=" + fmSearch.ProductNo.value;
    fmSearch.submit();
   }
}
//-->
</script>

<script language="JavaScript">
<!--
provinceArray = new Array(
<%=LookUp.getFirstLookUp("select p.brandId,p.productno,P.prodid, C.cateName from product p ," + 
" brand b, category c where p.cateid = c.cateid and p.brandid = b.brandid and b.lang_code = 'GB' and p.typeid in (1,2,3,7,8,9) order by p.brandid,p.cateid, p.productno",3,"CateName")%>);//
  //cityArray = new Array("1.1.guangzhou.1","1.1.shenzheng.2","1.2.xiamen.3","1.2.fuzhou.4");
  dropDownItem = new String();

  function changeProvinceInfo(countryBox,provinceBox)
  {
    var countryItem = countryBox.selectedIndex;
    var itemCount;

    if(countryItem>0)
    {
      provinceBox.length=1;
      //cityBox.length=1;
      for(var i=0;i<provinceArray.length;i++)
      {
        dropDownItem = provinceArray[i].split(".");
        if(countryItem==dropDownItem[0])
        {
          itemCount = provinceBox.length;
          provinceBox.length += 1;
          provinceBox.options[itemCount].value = dropDownItem[2];
          provinceBox.options[itemCount].text = dropDownItem[1];
        }
      }
      if((document.fmSearch.NewProductNo.value==null)||(document.fmSearch.NewProductNo.value==""))
        provinceBox.selectedIndex = 1;
      else
        provinceBox.selectedIndex = document.fmSearch.NewProductNo.value;
    }
    else
    {
      provinceBox.selectedIndex = 1;
      //cityBox.selectedIndex = 1;
      provinceBox.length=1;
      //cityBox.length=1;
    }
  }

function saveProvince()
{
  document.fmSearch.NewProductNo.value =     document.fmSearch.ProductNo.selectedIndex;
}

 

  function initArea()
  {
    	changeProvinceInfo(document.fmSearch.Brand,document.fmSearch.ProductNo);

  }
//-->
</script>
<script
language="JavaScript">
<!--
img1on = new Image();
img1on.src = "/images/temp/menu_1_0.gif"; 
img2on = new Image();
img2on.src = "/images/temp/menu_2_0.gif";
img3on = new Image();
img3on.src = "/images/temp/menu_3_0.gif";
img4on = new Image();
img4on.src = "/images/temp/menu_4_0.gif";
img5on = new Image();
img5on.src = "/images/temp/menu_5_0.gif";
img6on = new Image();
img6on.src = "/images/temp/menu_6_0.gif";
img7on = new Image();
img7on.src = "/images/temp/menu_service_0.gif";
img8on = new Image();
img8on.src = "/images/temp/menu_service10.gif";
img9on = new Image();
img9on.src = "/images/temp/menu_service20.gif";
img10on = new Image();
img10on.src = "/images/temp/menu_service30.gif"; 
img11on = new Image();
img11on.src = "/images/temp/menu_service40.gif";
img12on = new Image();
img12on.src = "/images/temp/menu_service50.gif";
img13on = new Image();
img13on.src = "/images/temp/menu_service60.gif";
img1off = new Image();
img1off .src = "/images/temp/menu_1.gif"; 
img2off = new Image();
img2off .src = "/images/temp/menu_2.gif";
img3off = new Image();
img3off .src = "/images/temp/menu_3.gif";
img4off = new Image();
img4off .src = "/images/temp/menu_4.gif";
img5off = new Image();
img5off .src = "/images/temp/menu_5.gif";
img6off = new Image();
img6off .src = "/images/temp/menu_6.gif";
img7off = new Image();
img7off .src = "/images/temp/menu_service.gif";
img8off = new Image();
img8off .src = "/images/temp/menu_service1.gif";
img9off = new Image();
img9off .src = "/images/temp/menu_service2.gif";
img10off = new Image();
img10off.src = "/images/temp/menu_service3.gif"; 
img11off = new Image();
img11off.src = "/images/temp/menu_service4.gif";
img12off = new Image();
img12off.src = "/images/temp/menu_service5.gif";
img13off = new Image();
img13off.src = "/images/temp/menu_service6.gif";
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
<!--
<!--
window.name = "eoa"
var onTop = false
function launchRemote(url) {
remote=open(url, "login", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=180,height=360')
}
// -->

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif" onLoad="initArea()">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr> 
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=752>
  <tbody> 
  <tr> 
    <td width=752> 
      <table border=0 cellpadding=0 cellspacing=0 width=725>
        <tbody> 
        <tr> 
          <td width=283><a 
            href="index.jsp"><img border=0 
            height=25 src="/images/temp/head_up_1.gif" width=283></a></td>
          <td width=17><img height=25 
                  src="/images/temp/head_menu_1.gif" width=17></td>
          <td width=413 background="/images/temp/dt.gif" align="center"><img src="/images/temp/ico.gif" width="8" height="10" name="pic1"><a href="index.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic1','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">��ҳ</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic2"><a href="ProductCentre.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic2','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">��Ʒ����</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic3"><a href="OrderOnLine.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic3','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">���߶���</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic4"><a href="registration.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic4','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">�û�ע��</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic5"><a href="MyEoa.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic5','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">MYEOA</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic6"><a href="../service.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic6','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">�ͻ�����</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic7"><a href="../dealer.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic7','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">������</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic8"><a href="../about.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic8','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">��������</font></a> 
          </td>
          <td align=right width=12 background="/images/temp/dt.gif"><img height=25 
                  src="/images/temp/head_menu_2.gif" 
              width=8></td>
        </tr>
        </tbody> 
      </table>
    </td>
  </tr>
  <tr> 
    <td width=752> 
      <table border=0 cellpadding=0 cellspacing=0 height=46 width=665>
        <tbody> 
        <tr> 
          <td width=283 valign="top"><img height=46 src="/images/temp/head_dn_1.gif" 
            width=283></td>
          <td width="382"> 
            <table background=/images/temp/head_dn_2.gif border=0 
            cellpadding=0 cellspacing=0 height=46 width=379>
              <form action="Login.jsp" method=post name=fmLogin>
                <tr align="right"> 
                  <td height=28>�� ���� 
                    <input type="text" name="User" size="10" class="font1">
                    �� �룺 
                    <input type="password" name="Passwd" size="10" class="font1">
                    <a href="javascript:Login();"><img src="/images/temp/b_login.gif" width="41" height="15" border="0"> 
                    </a><a href="rpass1.jsp"><img src="/images/temp/b_pw.gif" width="57" height="15" border="0"></a> 
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
        </tbody> 
      </table>
    </td>
  </tr>
  </tbody> 
</table>
<table width="667" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" width="443"> 
      <table width="443" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
            <div id="Layer1" style="position:absolute; left:160px; top:215px;z-index:2; visibility: hidden"> 
              <table width="100" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="5" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(1)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td height="90"> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <% 
						           ResultSet rs = Result.getRS("select * from category where typeid=3 and lang_code='GB' order by cateid");
   						         int i = 0;
                       String CategoryName = "";
                       String CateId = "";
   						         if (rs!=null)
                       {
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=3&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
			        out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=3&LangCode=GB\">����...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer2" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(2)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=1");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=1&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
                                            out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=1&LangCode=GB\">����...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer3" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(3)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td>
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=2 and lang_code='GB' order by cateid");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=2&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
                                            out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=2&LangCode=GB\">����...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer4" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(4)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=7 and lang_code='GB' order by cateid");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=7&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
			       // out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=7&LangCode=GB\">����...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer5" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(5)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=4 and lang_code='GB' order by cateid");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=4&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
          			        out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=4&LangCode=GB\">����...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer6" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(6)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=5 and lang_code='GB' order by cateid");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=5&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
                                            out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=5&LangCode=GB\">����...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>

            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="3"><img src="/images/temp/body_up.gif" width="443" height="146" border="0" usemap="#Map"><map name="Map"><area shape="circle" coords="257,50,26" href="ProductSearch.jsp?TypeId=3&amp;LangCode=GB" onMouseOver="ShowLayer(1)" alt="��ӡ��" title="��ӡ��"><area shape="circle" coords="197,57,23" href="ProductSearch.jsp?TypeId=1&amp;LangCode=GB" onMouseOver="ShowLayer(2)" alt="��ӡ��" title="��ӡ��"><area shape="circle" coords="141,76,25" href="ProductSearch.jsp?TypeId=2&amp;LangCode=GB" onMouseOver="ShowLayer(3)" alt="�����" title="�����"><area shape="circle" coords="101,115,25" onMouseOver="ShowLayer(4)" href="ProductSearch.jsp?TypeId=8&amp;LangCode=GB" alt="ɨ����" title="ɨ����"><area shape="circle" coords="68,153,27" href="ProductSearch.jsp?TypeId=4&amp;LangCode=GB" onMouseOver="ShowLayer(5)" alt="�Ĳ�" title="�Ĳ�"></map></td>
              </tr>
              <tr> 
                <td width="270"><img src="/images/temp/body_m1.gif" width="270" height="72" border="0" usemap="#Map2"><map name="Map2"><area shape="circle" coords="49,56,24" href="ProductSearch.jsp?TypeId=5&amp;LangCode=GB" onMouseOver="ShowLayer(6)" alt="���" title="���"><area shape="circle" coords="65,5,22" href="ProductSearch.jsp?TypeId=4&amp;LangCode=GB" onMouseOver="ShowLayer(5)" alt="�Ĳ�" title="�Ĳ�"></map></td>
                <td width="124">
                  <table width="124" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="23"><a href="/train.htm" onMouseOver="imgOn('img8')" onMouseOut="imgOff('img8')"><img src="/images/temp/menu_service1.gif" width="23" height="72" name="img8" border="0"></a></td>
                      <td width="19"><a href="/tech.htm" onMouseOver="imgOn('img9')" onMouseOut="imgOff('img9')"><img src="/images/temp/menu_service2.gif" width="19" height="72" name="img9" border="0"></a></td>
                      <td width="21"><a href="/guide.htm" onMouseOver="imgOn('img10')" onMouseOut="imgOff('img10')"><img src="/images/temp/menu_service3.gif" width="21" height="72" name="img10" border="0"></a></td>
                      <td width="19"><a href="/service.htm" onMouseOver="imgOn('img11')" onMouseOut="imgOff('img11')"><img src="/images/temp/menu_service4.gif" width="19" height="72" name="img11" border="0"></a></td>
                      <td width="21"><a href="/rate.htm" onMouseOver="imgOn('img12')" onMouseOut="imgOff('img12')"><img src="/images/temp/menu_service5.gif" width="21" height="72" name="img12" border="0"></a></td>
                      <td width="21"><a href="/mk.htm" onMouseOver="imgOn('img13')" onMouseOut="imgOff('img13')"><img src="/images/temp/menu_service6.gif" width="21" height="72" name="img13" border="0"></a></td>
                    </tr>
                  </table>
                </td>
                <td width="49"><img src="/images/temp/body_m2.gif" width="49" height="72"></td>
              </tr>
              <tr> 
                <td colspan="3"><img src="/images/temp/body_b.gif" width="443" height="40" usemap="#Map3" border="0"><map name="Map3"><area shape="circle" coords="51,-22,32" href="ProductSearch.jsp?TypeId=5&amp;LangCode=GB" onMouseOver="ShowLayer(6)"></map></td>
              </tr><form name="FORM_Data"><input type="hidden" name="HIDDEN_LayerCount" value="6"></form>
            </table><script language="JavaScript">
function  ShowLayer(iLayer)
{	
	var strName;
	var theObj;
	HideAllLayer();
	strName = "Layer" + iLayer
	if(navigator.appName == 'Netscape' && document.layers != null){
		strName = "document.layers." + strName
		theObj = eval(strName);
		theObj.visibility = "visible";
	}
	else if (document.all != null){
		document.all(strName).style.visibility = "visible";
	}
}

function  HideLayer(iLayer)
{	
	var strName;
	var theObj;
	strName = "Layer" + iLayer
	//alert("strName");
	if(navigator.appName == 'Netscape' && document.layers != null){
		strName = "document.layers." + strName
		theObj = eval(strName);
		theObj.visibility = "hidden";
	}
	else if (document.all != null){
		document.all(strName).style.visibility = "hidden";
	}
}

function  HideAllLayer()
{	
	var strName, iLayerCount, i;
	var theObj;
	iLayerCount = document.forms.FORM_Data.HIDDEN_LayerCount.value;
	for(i = 1; i <= iLayerCount; i++)
	{
		strName = "Layer" + i
		if(navigator.appName == 'Netscape' && document.layers != null){
			strName = "document.layers." + strName
			theObj = eval(strName);
			theObj.visibility = "hidden";		
		}
			else if (document.all != null){
			document.all(strName).style.visibility = "hidden";
		}
	}
}
</script></td>
        </tr>
        <tr> 
          <td><img src="/images/temp/service.gif" width="443" height="92"></td>
        </tr>
      </table>
    </td>
    <td valign="top" align="center" width="197"> 
      <table width="154" border="0" cellspacing="0" cellpadding="0">
        <tr align="center"> 
          <td valign="top" width="154"><img src="/images/temp/title_search.gif" width="154" height="25"></td>
        </tr>
        <tr align="center"> 
          <td valign="top" width="154"> 
            <table width="154" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="3" valign="top"><img src="/images/temp/left_bars.gif" width="3" height="76"></td>
                <td valign="top" width="149"> 
                  <table width="149" border="0" cellspacing="0" cellpadding="0"><form name="fmSearch" method="post" >
                    <tr> 
                      <td width="54" align="center">Ʒ ��</td>
                      <td width="95"> 
                        <select name="Brand" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                           <option value="0" selected>-��ѡ��-</option>
                           <%=LookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
                        </select>
                      </td>
                    </tr>
                    <tr> 
                      <td width="54" align="center">�� ��</td>
                      <td width="95"> 
                        <select name="ProductNo" onBlur="saveProvince()" >
                           <option value="0" selected>-��ѡ��-</option>
                        </select>
                      </td>
                    </tr>
                    <tr align="center"> 
                      <td width="54">
                          <input type="hidden" name="NewProductNo">
                        </td>
                        <td width="95" height="40"><a href="javascript:Search()"><img src="/images/temp/b_search.gif" width="44" height="17" border="0"></a></td>
                    </tr></form>
                  </table>
                </td>
                <td width="2" valign="top"><img src="/images/temp/right_bars.gif" width="2" height="76"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr align="center"> 
          <td valign="top" width="154">&nbsp;</td>
        </tr>
        <tr align="center"> 
          <td valign="top" width="154"><img src="/images/temp/title_hot.gif" width="154" height="28"></td>
        </tr>
        <tr align="center"> 
          <td width="154"> 
            <table width="154" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="3" valign="top"><img src="/images/temp/left_bars.gif" width="3" height="76"></td>
                <td width="149"> 
                  <table width="149" border="0" cellspacing="0" cellpadding="0">
    				<% 
					  rs = Result.getRS("select p.Prodid, p.productNo,p.listprice, b.name, c.catename,d.dir,s.filename1 from product p, " + 
  						" brand b, category c, speci_sale s, dir_setting d " +
 						" where p.brandid = b.brandid and b.lang_code = 'GB' " + 
						" and  p.cateid = c.cateid and c.lang_code = b.lang_code " + 
						" and p.prodid = s.prodid and s.location='F' " +
						" and s.picdir1 = d.dirid(+)");
                      //rs = null;
   					  if (rs!=null)
                      {
                        if (rs.next())
                        {
					     %>
                    <tr align="center"> 
                      <td colspan="2">
                 	   
                       <a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB">
                       <img src="<% String FileName = "";
                                    if (rs.getString("Dir") == null)
                                      FileName = "../images/hots/" + rs.getString("FileName1");
									else
    								  FileName = "/" + rs.getString("Dir") + rs.getString("FileName1");
									out.println(FileName);
                                 %>" width="149" height="89" border="0"></a></td>
                       
            		</tr>
                    <tr align="center"> 
                      <td colspan="2"> 
                        <table width="149" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="22">&nbsp;</td>
                            <td width="129">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td width="22"><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                            <td width="129"><%=rs.getString("Name")%></td>
                          </tr>
                          <tr> 
                            <td width="22">&nbsp;</td>
                            <td width="129"><%=rs.getString("ProductNo")+rs.getString("CateName")%></td>
                          </tr>
                          <tr> 
                            <td width="22">&nbsp;</td>
                            <td width="129"><%="�۸�: " + rs.getString("ListPrice") + "Ԫ"%></td>
                          </tr>
                          <tr> 
                            <td width="22"><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                            <td width="129"><a href="ProductCentre.jsp?LangCode=GB">����....</a></td>
                          </tr>
                          <tr align="center"> 
                            <td colspan="2" height="30"> 
                              <table width="149" border="0" cellspacing="0" cellpadding="0">
                                <tr align="center"> 
                                  <td>&nbsp;</td>
                                  <td>&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                       <%
					   }
                     }
                    %>
                  </table>
                </td>
                <td width="2" valign="top"><img src="/images/temp/right_bars.gif" width="2" height="76"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="667" border="0" cellspacing="0" cellpadding="0">
  <tr align="center"> 
    <td><img src="/images/temp/foot.gif" width="620" height="23"> </td>
  </tr>
</table>
<%if (LookUp.CloseStm()) 
        out.println("");%>
<%if (Result.CloseStm()) 
        out.println("");%>
</body>
</html>


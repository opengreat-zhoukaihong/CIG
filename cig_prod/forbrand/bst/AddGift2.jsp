<%@ page import="java.util.*, java.sql.*,java.io.*,com.forbrand.order.*" session="true" language="java" errorPage="error.jsp"%>


<html><!-- #BeginTemplate "/Templates/temp.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ForBrand.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="public.css">
<SCRIPT language=JavaScript>

function js_callpage(htmlurl) {
  var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=566,height=327");
  return false;
}
function js_call() {
  pick_tai=document.tv_form.tai_select.options[document.tv_form.tai_select.selectedIndex].value;
  pick_week=document.tv_form.week_select.options[document.tv_form.week_select.selectedIndex].value;
  parent.window.location.href=pick_tai+"-"+pick_week+"\.html";
}

</SCRIPT>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- #BeginEditable "body" --> 
<%!
	String sql_ins_news = null;
	String sql_ins_news_l=null;
	String sql_seq_gift = null;
	String[] sql_array = null;
	Hashtable[] results = null;

	String smallpic_file = null;
	String largepic_file = null;
	String gift_id = null;
	int procReturn;
	int count;
	String fileField = null;
%>

<jsp:useBean id="jdbc" scope="page" class="com.forbrand.order.JDBC" />
<jsp:useBean id="res" scope="page" class="com.forbrand.order.Result" />
<jsp:useBean id="upload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="gift" scope="page" class="com.forbrand.order.Gift" />
<jsp:useBean id="gift_l" scope="page" class="com.forbrand.order.Gift_l" />

<%

	upload.initialize(pageContext);
	upload.upload();
	try
	  {
            count = upload.save("/usr/local/apache/htdocs"+upload.getRequest().getParameter("pic_dirname"));
	   for (int i=0;i<upload.getFiles().getCount();i++)
	   {
		fileField = upload.getFiles().getFile(i).getFieldName();
		System.out.println(fileField);
		if (fileField.equals("smallpic_file"))
		{
		smallpic_file = upload.getFiles().getFile(i).getFileName();
		System.out.println(smallpic_file);
		}
		if (fileField.equals("largepic_file"))
		{
		largepic_file = upload.getFiles().getFile(i).getFileName();
		System.out.println(largepic_file);
		}
	   }//for
	}//try
	catch (Exception e)
	{
	   e.printStackTrace(System.out);
	}
	sql_seq_gift = "select seq_gift_id.NEXTVAL gift_id from dual";
	results = jdbc.executeQuery(sql_seq_gift);
	res.setResult(results);
	if(res.hasNext())
	{
	   gift_id = res.getObject("gift_id").toString();
	}
	System.out.println("gift_id is "+gift_id);

	gift.Gift_ID = Integer.parseInt(gift_id);        
	gift.Cate_ID = Integer.parseInt(upload.getRequest().getParameter("category"));
	gift.Material_ID = Integer.parseInt(upload.getRequest().getParameter("material"));
        gift.Manufact_ID = upload.getRequest().getParameter("manufacture");
        gift.ProductNo = upload.getRequest().getParameter("product_no");
	gift.PicDir = Integer.parseInt(upload.getRequest().getParameter("pic_dir"));
        gift.FileName1 = smallpic_file;
	gift.FileName2 = largepic_file;
	gift.ListPrice = 0.0;     //  NUMBER(9,2),   --List Price
	gift.Consignment_Date = Integer.parseInt(upload.getRequest().getParameter("consignment_date"));

	gift.GiftWt_I = gift.getDataI(upload.getRequest().getParameter("g_weight"),upload.getRequest().getParameter("g_unit_wi"),upload.getRequest().getParameter("g_unit_wm"));   //  NUMBER(7,1),   --礼品重量(英制)
	gift.GiftWt_M = Double.parseDouble(upload.getRequest().getParameter("g_weight")); //  NUMBER(7,1),   --礼品重量(公制)
	gift.GiftWtUnit_I = upload.getRequest().getParameter("g_unit_wi");  //  VARCHAR2(10),  --礼品重量英制单位
	gift.GiftWtUnit_M = upload.getRequest().getParameter("g_unit_wm");  //  VARCHAR2(10),  --礼品重量公制单位
	
	gift.GiftLength_M = Double.parseDouble(upload.getRequest().getParameter("g_length"));  //  NUMBER(7,1),   --礼品长度(公制)
	gift.GiftWidth_M = Double.parseDouble(upload.getRequest().getParameter("g_width"));   //  NUMBER(7,1),   --礼品宽度(公制)
	gift.GiftHeight_M = Double.parseDouble(upload.getRequest().getParameter("g_height"));  //  NUMBER(7,1),   --礼品高度(公制)
	gift.GiftLength_I = gift.getDataI(upload.getRequest().getParameter("g_length"),upload.getRequest().getParameter("g_unit_li"),upload.getRequest().getParameter("g_unit_lm")); //  NUMBER(7,1),   --礼品长度(英制) 
	gift.GiftWidth_I = gift.getDataI(upload.getRequest().getParameter("g_width"),upload.getRequest().getParameter("g_unit_li"),upload.getRequest().getParameter("g_unit_lm"));   //  NUMBER(7,1),   --礼品宽度(英制)
	gift.GiftHeight_I = gift.getDataI(upload.getRequest().getParameter("g_height"),upload.getRequest().getParameter("g_unit_li"),upload.getRequest().getParameter("g_unit_lm"));  //  NUMBER(7,1),   --礼品高度(英制)
	gift.GiftDimUnit_I = upload.getRequest().getParameter("g_unit_li");//  VARCHAR2(10),  --礼品长度英制单位
	gift.GiftDimUnit_M = upload.getRequest().getParameter("g_unit_lm"); //  VARCHAR2(10),  --礼品长度公制单位

	gift.PackGrsWt_M = Double.parseDouble(upload.getRequest().getParameter("p_grswt"));   //  NUMBER(7,1),   --单箱毛重(公制)
	gift.PackNetWt_M = Double.parseDouble(upload.getRequest().getParameter("p_netwt"));  //  NUMBER(7,1),   --单箱净重(公制)
	gift.PackGrsWt_I = gift.getDataI(upload.getRequest().getParameter("p_grswt"),upload.getRequest().getParameter("p_unit_wi"),upload.getRequest().getParameter("p_unit_wm"));   //  NUMBER(7,1),   --单箱毛重(英制)
	gift.PackNetWt_I = gift.getDataI(upload.getRequest().getParameter("p_netwt"),upload.getRequest().getParameter("p_unit_wi"),upload.getRequest().getParameter("p_unit_wm"));   //  NUMBER(7,1),   --单箱净重(英制)
  	gift.PackWtUnit_I = upload.getRequest().getParameter("p_unit_wi");  //  VARCHAR2(10),  --单箱重量英制单位
	gift.PackWtUnit_M = upload.getRequest().getParameter("p_unit_wm"); //  VARCHAR2(10),  --单箱重量公制单位

	gift.PackLength_M = Double.parseDouble(upload.getRequest().getParameter("p_length"));  // NUMBER(7,1),   --单箱长度(公制)
	gift.PackWidth_M = Double.parseDouble(upload.getRequest().getParameter("p_width"));    // NUMBER(7,1),   --单箱宽度(公制)
	gift.PackHeight_M = Double.parseDouble(upload.getRequest().getParameter("p_height"));   // NUMBER(7,1),   --单箱高度(公制)
	gift.ClrPackLength_M = Double.parseDouble(upload.getRequest().getParameter("cp_length"));// NUMBER(7,1),   --彩盒长度(公制)
	gift.ClrPackWidth_M = Double.parseDouble(upload.getRequest().getParameter("cp_width")); // NUMBER(7,1),   --彩盒宽度(公制)
	gift.ClrPackHeight_M = Double.parseDouble(upload.getRequest().getParameter("cp_height"));// NUMBER(7,1),   --彩盒高度(公制)
	gift.PackLength_I = gift.getDataI(upload.getRequest().getParameter("p_length"),upload.getRequest().getParameter("p_unit_li"),upload.getRequest().getParameter("p_unit_lm"));  //  NUMBER(7,1),   --单箱长度(英制)
	gift.PackWidth_I = gift.getDataI(upload.getRequest().getParameter("p_width"),upload.getRequest().getParameter("p_unit_li"),upload.getRequest().getParameter("p_unit_lm"));   //  NUMBER(7,1),   --单箱宽度(英制)
	gift.PackHeight_I = gift.getDataI(upload.getRequest().getParameter("p_height"),upload.getRequest().getParameter("p_unit_li"),upload.getRequest().getParameter("p_unit_lm"));  //  NUMBER(7,1),   --单箱高度(英制)
	gift.ClrPackLength_I = gift.getDataI(upload.getRequest().getParameter("cp_length"),upload.getRequest().getParameter("p_unit_li"),upload.getRequest().getParameter("p_unit_lm"));// NUMBER(7,1),   --彩盒长度(英制)
	gift.ClrPackWidth_I = gift.getDataI(upload.getRequest().getParameter("cp_width"),upload.getRequest().getParameter("p_unit_li"),upload.getRequest().getParameter("p_unit_lm")); // NUMBER(7,1),   --彩盒宽度(英制)
	gift.ClrPackHeight_I = gift.getDataI(upload.getRequest().getParameter("cp_height"),upload.getRequest().getParameter("p_unit_li"),upload.getRequest().getParameter("p_unit_lm"));// NUMBER(7,1),   --彩盒高度(英制)
	gift.PackDimUnit_I = upload.getRequest().getParameter("p_unit_li");  // VARCHAR2(10),  --包装长度英制单位
	gift.PackDimUnit_M = upload.getRequest().getParameter("p_unit_lm");  // VARCHAR2(10),  --包装长度公制单位

	gift.QuantityPerPack = Integer.parseInt(upload.getRequest().getParameter("quantity_pack"));
	gift.Ope_id = session.getValue("operator").toString();
	System.out.println("ok.");
	Timestamp time = new Timestamp(System.currentTimeMillis());
	gift.Cr_Date = time ;         // DATE Default SysDate,
	gift.Md_Date = time ;         // DATE Default SysDate,
	String[] inputArray = new String[2];
        inputArray[0] = upload.getRequest().getParameter("category");
	inputArray[1] = upload.getRequest().getParameter("material");
//	gift.Gift_NO = "2";
	gift.Gift_NO = gift.getGiftNo(inputArray,"creategiftno");        // VARCHAR2(20),  
	if (gift.Gift_NO == null)
	{
	%> <jsp:forward page="BackResultsError.jsp?message=Gift_NO is Null!" /> <%	
	}
	System.out.println("Gift_NO is "+gift.Gift_NO);

	gift_l.Gift_ID = Integer.parseInt(gift_id);
	gift_l.Lang_Code = upload.getRequest().getParameter("lang_code");
	gift_l.GiftName = upload.getRequest().getParameter("gift_name");
	gift_l.CustomMadeInfo = upload.getRequest().getParameter("custommadeinfo");
	gift_l.ColorDesc = upload.getRequest().getParameter("colordesc");
	gift_l.PartMaterial = upload.getRequest().getParameter("partmaterial");
	gift_l.Descr = upload.getRequest().getParameter("descr");

	System.out.println("after gift_l init");
	Gift_Price[] gift_price_array = new Gift_Price[5];
	
	String[] price = upload.getRequest().getParameterValues("price");
	String[] quantity_l = upload.getRequest().getParameterValues("quantity_l");
	String[] quantity_u = upload.getRequest().getParameterValues("quantity_u");
	System.out.println("after create gift_price[] ");

	for(int n=0;n<gift_price_array.length;n++)
	{
		System.out.println(gift_id+" "+price[n]+" "+quantity_l[n]+" "+quantity_u[n]);
		Gift_Price gift_price = new Gift_Price();
		gift_price.setGift_ID(Integer.parseInt(gift_id));
		gift_price.setPrice(Double.parseDouble(price[n]));			//NUMBER(9,2), --批发价 
		gift_price.setQuantity_L(Integer.parseInt(quantity_l[n]));	//NUMBER,      --该批发价对应的购买量下限
		gift_price.setQuantity_U(Integer.parseInt(quantity_u[n]));	//NUMBER,      --该批发价对应的购买量上限
		gift_price_array[n] = gift_price;
	}
	System.out.println("after gift_price init");

	Object[] giftObject = new Object[7];
	giftObject[0] = gift;
	giftObject[1] = gift_l;
	for(int m=0,x=2;m<gift_price_array.length;m++,x++)
	{
		giftObject[x] = gift_price_array[m];
	}

	try
	{
		if(!jdbc.insertObject(giftObject))
		{%>
		<jsp:forward page="BackResultsError.jsp?message=Insert Error!" />
		<%}
		else
		{%>
		<jsp:forward page="BackResultsError.jsp?message=Insert Success!" />
		<%}
	}
	catch(Exception e){e.printStackTrace(System.out);
	}
%>
<table width="755" border="0" cellspacing="4" cellpadding="4">
  <tr> 
	
  </tr>
</table>
<br>
<!-- #EndEditable --> 

</body>
<!-- #EndTemplate --></html>

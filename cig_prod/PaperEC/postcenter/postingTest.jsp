<%--  @# postingTest.jsp Ver.1.2 --%>

<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 
<% if (!UserInfo.getAuthorized()) {%>
<jsp:forward page="error.html" />
<%}%>

<%@ page import="postcenter.*, java.util.*, java.net.*" %>
<jsp:useBean id="Posting" scope="page" class="postcenter.Posting" /> 
<jsp:useBean id="Bid" scope="page" class="postcenter.Bid" /> 

<jsp:setProperty name="Posting" property="langCode" />
<jsp:setProperty name="Posting" property="classFlag" />
<jsp:setProperty name="Posting" property="measureFlag" />
<jsp:setProperty name="Posting" property="buyFlag" />
<jsp:setProperty name="Posting" property="cateId" />
<jsp:setProperty name="Posting" property="typeId" />
<jsp:setProperty name="Posting" property="gradeId" />
<jsp:setProperty name="Posting" property="sampleId" />
<jsp:setProperty name="Posting" property="brandId" />
<jsp:setProperty name="Posting" property="prodCounId" />
<jsp:setProperty name="Posting" property="prodStateId" />
<jsp:setProperty name="Posting" property="prodCityId" />
<jsp:setProperty name="Posting" property="requestPostingId" />

<jsp:setProperty name="Bid" property="bid_beTime" />
<jsp:setProperty name="Bid" property="bid_enTime" />
<jsp:setProperty name="Bid" property="bid_quantity" />
<jsp:setProperty name="Bid" property="bid_unit" />
<jsp:setProperty name="Bid" property="bid_price" />
<jsp:setProperty name="Bid" property="bid_currency" />
<jsp:setProperty name="Bid" property="bid_priceCond" />
<jsp:setProperty name="Bid" property="bid_destPortId" />
<jsp:setProperty name="Bid" property="bid_destStateId" />
<jsp:setProperty name="Bid" property="bid_destCityId" />
<jsp:setProperty name="Bid" property="bid_payMeth" />
<jsp:setProperty name="Bid" property="bid_payCond" />
<jsp:setProperty name="Bid" property="bid_deliMeth" />
<jsp:setProperty name="Bid" property="bid_deliShipDate" />

<% 
    Posting.userId = UserInfo.getUserId();
    Posting.init();
    Posting.bid = Bid;
    
    Spec[] specItems=Posting.specList.specItems;
    Enumeration e = request.getParameterNames();
    int i=0;

    while ( e.hasMoreElements()) {
        i++; 
        String name = (String)e.nextElement();
        String value = request.getParameter(name);

        if ( !value.equals("")) { 
	    for (int j=0; j<specItems.length; j++) {
	        if( name.equals("input_min_Spec"+specItems[j].specId)) {
		    specItems[j].setSpecMinVal(value);
	        }
	        else if( name.equals("input_max_Spec"+specItems[j].specId)) {
		    specItems[j].setSpecMaxVal(value);
	        }
	        else if( name.equals("input_option_Spec"+specItems[j].specId)) {
		    specItems[j].setSpecParaId(value);
	        }
	    }
        }
    }
    
    Posting.getSpecSetCount();
%>

<% 
  String info = "";
  String buyFlag = request.getParameter("buyFlag");
  
  if(Posting.insertPosting()) 
  { 
    //info = "恭喜,您已发布成功!<br> "
    //	    + "postingId = " + Posting.getPostingId() + "<br>"
    //	    + "bidId = " + Posting.getBidId() + "<br>";
    if ((buyFlag!=null) && buyFlag.equals("B"))
    {
        info = "您发布的需求信息已添加到我们的数据库。为方便您快速查看，这个发布信息" +
	       "被赋予了一个标识号（ID）" + Posting.getPostingId() +
	       "。（在浮动导航块上ID直通车里输入这个" +
	       "标识号，即刻快速查看该信息详情。）" +
	       "若有卖家对您的需求信息发布供应信息，网站会自动EMAIL通知您的。祝您好运！";
    }
    if ((buyFlag!=null) && buyFlag.equals("S"))
    {
        info = "您发布的供应信息已添加到我们的数据库。为方便您快速查看，这个发布信息" +
	       "被赋予了一个标识号（ID）" + Posting.getPostingId() +
	       "。（在浮动导航块上ID直通车里输入这个" +
	       "标识号，即刻快速查看该信息详情。）" +
	       "若有买家对您的供应信息有回应，网站会自动EMAIL通知您的。祝您好运！";
    }
  }else
  {
    info = "很抱歉,您未能发布成功，请检查数据!";
    info += "<br><br>" + Posting.getErrSpecMsg();
  }
  
  response.sendRedirect("inform2.jsp?info=" + URLEncoder.encode(info));
%>

<%--
<html>
<head>
  <title> example for posting Bean </title>
</head>

<body>
-------------------------<br>
spec specSetCount = <%=Posting.specSetCount%><br>
<%  for(i=0; i<specItems.length; i++) {
        if (specItems[i].valueIsSet) { %>
---<br>
spec specId = <%=specItems[i].specId%>  specName = <%=specItems[i].specName%><br>
<%          if (!specItems[i].specValFlag.equals("N")) { %>
Defined Range is: <%=specItems[i].specValue1%> -- <%=specItems[i].specValue2%><br>
Value min: <%=specItems[i].specMinVal%> -- max: <%=specItems[i].specMaxVal%><br>
<%          } else { %>
SpecParaId: <%=specItems[i].specParaId %>   SpecParaStr: <%=specItems[i].getSpecParaStr() %><br>
<%          } %>
<%      }
    }%>
===========================<br>
post userId = <%=Posting.userId%><br>
post buyFlag = <%=Posting.buyFlag%><br>
post langCode = <%=Posting.langCode%><br>
post classFlag = <%=Posting.classFlag%><br>
post measureFlag = <%=Posting.measureFlag%><br>
post cateId = <%=Posting.cateId%><br>
post typeId = <%=Posting.typeId%><br>
post gradeId = <%=Posting.gradeId%><br>
post sampleId = <%=Posting.sampleId%><br>
post brandId = <%=Posting.brandId%><br>
post prodCounId = <%=Posting.prodCounId%><br>
post prodStateId = <%=Posting.prodStateId%><br>
post prodCityId = <%=Posting.prodCityId%><br>
post requestPostingId = <%=Posting.requestPostingId%><br>
-------------------------<br>
bid beTime = <%=Bid.beTime%><br>
bid enTime = <%=Bid.enTime%><br>
bid quantity = <%=Bid.quantity%><br>
bid unit = <%=Bid.unit%><br>
bid price = <%=Bid.price%><br>
bid currency = <%=Bid.currency%><br>
bid priceCond = <%=Bid.priceCond%><br>
bid destPortId = <%=Bid.destPortId%><br>
bid destStateId = <%=Bid.destStateId%><br>
bid destCityId = <%=Bid.destCityId%><br>
bid payMeth = <%=Bid.payMeth%><br>
bid payCond = <%=Bid.payCond%><br>
bid deliMeth = <%=Bid.deliMeth%><br>
bid deliShipDate = <%=Bid.deliShipDate%><br>
-------------------------<br>
postingId = <%=Posting.getPostingId()%><br>
bidId = <%=Posting.getBidId()%><br>
<br><%=Posting.errMsg%><br>
last line. <br>
</body>
</html>
--%>
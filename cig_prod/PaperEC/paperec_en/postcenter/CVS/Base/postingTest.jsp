<%--  @# postingTest.jsp EN Ver.1.3 --%>

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
        info = "Your posting has been added successfully to our database. For quick " +
	       "viewing, the posting is numbered by an ID# " + Posting.getPostingId() + ". (On the floating " +
	       "pilot panel, input the posting's ID# in the \"Search by ID#\" " +
	       "column, then you will enter the posting's details page. Note, the letter " +
	       "P in the ID# must be upper-case) " +
	       "When a supplier responds to your posting, you will be notified " +
	       "automatically via email. Good luck. ";
    }
    if ((buyFlag!=null) && buyFlag.equals("S"))
    {
        info = "Your posting has been added successfully to our database. For quick " +
	       "viewing, the posting is numbered by an ID# " + Posting.getPostingId() + ". (On the floating " +
	       "pilot panel, input the posting's ID# in the \"Search by ID#\" " + 
	       "column, then you will enter the posting's details page. Note, the " +
	       "letter P in the ID# must be capitalized.) " +
	       "When a buyer responds to your posting, you will be notified  automatically via email. Good luck. ";
    }
  }else
  {
    info = "Your posting was unsuccessful. Please check your inputed data and try again.";
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
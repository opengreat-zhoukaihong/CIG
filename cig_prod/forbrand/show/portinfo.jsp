<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<jsp:useBean id="port" scope="request" class="com.forbrand.member.PortBean"/>
<jsp:useBean id="ship" scope="request" class="com.forbrand.member.ShipBean"/>
<html>
<head>
<title>Port Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
<script src="/js/formcheck.js"></script>
<script language="JavaScript">
	function answer()
	{
		reStr(document.all.answer)
		document.form1.submit()
	}
</script>

</head>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr>
    <td valign="middle">
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle">
          <td class="white-title"  >
            <p>Port Infomation:</p>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr>
            <td class="bottom-menu" colspan="3" >

            <%! String shipid[],pno; %>
            <%! int i,row,pageno,totalpage,pagelist,beginno,endno; %>
            <%  pno = request.getParameter("page");
                if(pno == null)
                  { pageno = 1;
                    ship.getShipment("EN");
                    session.setAttribute("shipid",ship.getShipmentIDs());
                  }
                  else
                  {  pageno = (Integer.valueOf(pno)).intValue(); }
            %>
            <form name="form3">
              <table width="598" align="center" border="1" class="black-m-text">
                <tr class="white-title" bgcolor="#003399"> 
                  <td width="70" height="18"><font color="#f0f0f0">&nbsp;DepartPort</font></td>
                  <td width="69" height="18"><font color="#f0f0f0">&nbsp;ArrivalPort</font></td>
                  <td width="72" height="18"><font color="#f0f0f0">&nbsp;Price_Cont20</font></td>
                  <td width="88" height="18"><font color="#f0f0f0">&nbsp;Price_Cont40</font></td>
                  <td width="80" height="18"><font color="#f0f0f0">&nbsp;Price_Comp</font></td>
                  <td width="56" height="18"><font color="#f0f0f0">&nbsp;Sail</font></td>
                  <td width="117" height="18"><font color="#f0f0f0">&nbsp;Remark</font></td>
                </tr>
                <% shipid = (String[])session.getAttribute("shipid"); %>
                <% row = shipid.length; %>
                <% pagelist = 2;
                   totalpage = row/pagelist;
                   beginno = (pageno-1)*pagelist;
                   endno = ((beginno+pagelist)<row?(beginno+pagelist):row);
                  for(i=beginno;i<endno;i++)
		    { ship.fetchShipInfo(shipid[i]);
                %>
                      
                <tr class="black-m-text" bgcolor="#E1E0EF"><b> 
                  <td width="70"> <%port.fetchPortInfo(String.valueOf(ship.getDepartPort()));%> 
                    <%=port.getPort()%></td>
                        
                  <td width="69"> <%port.fetchPortInfo(String.valueOf(ship.getArrivalPort()));%> 
                    <%=port.getPort()%></td>
                        
                  <td width="72"><%=ship.getPrice_Cont20()%></td>
                        
                  <td width="88"><%=ship.getPrice_Cont40()%></td>
                        
                  <td width="80"><%=ship.getPrice_Comp()%></td>
                        
                  <td width="56"><%=ship.getSail()%></td>
                        
                  <td width="117"><%=ship.getRemark()%></td>
                        </b> </tr>
               <%   }	%>
             </table>
         </form>
      	<script language="JavaScript1.1">
		function answer(vstr,ostr)
		{
                  urlstr = "answer.jsp?consultation="+vstr
                  titlestr = "Answer Question"
                  sizestr = "width=300,height=400"
                  window.open(urlstr)
                  ostr.checked = true
		}
	  	function first()
		{
                  document.all.page.value=1
                  document.form2.submit()
		}
		function last()
		{
                  document.all.page.value=<%=totalpage%>
                  document.form2.submit()
		}
		function prevp()
		{
                  document.all.page.value=((<%=pageno%>-1)<1?1:(<%=pageno%>-1))
                  document.form2.submit()
		}
		function nextp()
		{
                  document.all.page.value=((<%=pageno%>+1)><%=totalpage%>?<%=totalpage%>:(<%=pageno%>+1))
                  document.form2.submit()
		}
	</script>
	  <form action="/forbrand/login/portinfo.jsp" name="form2" method="get">
	  <input type="hidden" name="page" value="<%=pageno%>">

	          <p align="center" class="black-m-text"><b class="border"> <%=pageno%>/<%=(totalpage<=1?1:totalpage)%> 
                <font onClick="first()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">first 
                page</font> | <font onClick="prevp()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">previous 
                page</font> | <font onClick="nextp()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">next 
                page</font> | <font onClick="last()" style="cursor:hand;" onMouseOver="this.style.color='red';" onMouseOut="this.style.color='black';">last 
                page</font> </b></p>
          </form>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle">
          <td class="bottom-menu"  >
            <p class="white-title" align="right"> &gt;&gt;<a href="javascript:window.close()"><font color="#FFFFFF">Go
              Back</font></a>&lt;&lt;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

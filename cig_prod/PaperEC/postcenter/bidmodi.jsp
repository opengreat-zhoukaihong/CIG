 <%@ page  %>
<jsp:useBean id="pro" scope="page" class="postcenter.Bargain" />
<%  
   
     String numb="";String dw=""; String resu="";       
     String lang=request.getParameter("lang");     
     String posting_id=request.getParameter("posting_id");     
     pro.setLangcode("GB");
     pro.setPostingid(posting_id);
     String[] str=new String[19];
     String[] title=new String[4];
     if(!lang.equals("modi")){
        str=pro.getAllResult();   
                
        }else{
           numb=request.getParameter("number");
           dw=request.getParameter("dqtime");
           resu=pro.getModiDid(numb,dw);
           str=pro.getAllResult();
               }
     title=pro.getTitle(); 
                      %>  
 <script language="javascript">  
      function winclose(){
         window.close()            
            }              
      function validField(object){
	var value = ptrim(object.value);
	if (value !="")
	{
	    if ( !CheckNumber(value))
	    {
	    	alert("输入值非法,请核实!");
	        object.focus();
	    }
	}
}
function validDateField(object){
	var value = ptrim(object.value);

	if ( !CheckDate(value))
	{
	    alert("输入值非法,请核实!");
	    object.focus();
	}
}

  function ptrim(not_trim){
	var x; var x1;
	for (x=0;not_trim.charAt(x)==' ';x++){}
	for (x1=not_trim.length-1; not_trim.charAt(x1)==' '; x1--){}
	if (x>x1) 
		return "";
	else
		return not_trim.substring(x,x1+1);
} 
function CheckNumber(object_value) { 
	var GoodChars = "0123456789"; 
	var firstChar = object_value.charAt(0);
	var numberStr = object_value;
 	var array = new Array();
	var i = 0; 

	if (firstChar=='+'|| firstChar=='-')
	    numberStr = object_value.substring(1, object_value.length);
	
	array = numberStr.split(".");
	if (array.length ==1){
	    if (array[0].length ==0)
		return false;
	}
	else if (array.length >2){
	    return false;
	}
	for (i=0; i< array.length; i++) {
	    for (var j=0; j< array[i].length; j++) { 
		if (GoodChars.indexOf(array[i].charAt(j)) == -1) { 
		    return false; 
		}
	    } 
	} 
	return true; 
} 
function CheckInteger(object_value) { 
	var GoodChars = "0123456789"; 
	var i = 0; 
	for (i=0; i<= object_value.length -1; i++) { 
	    if (GoodChars.indexOf(object_value.charAt(i)) == -1) { 
		return false; 
	    } 
	} 
	return true; 
} 
function CheckDate(object_value) { 
 	var array = new Array();
	
	array = object_value.split("-");
	if (array.length !=3){
	    return false;
	}
	if (!CheckInteger(array[0]))
	    return false;
	if (!CheckInteger(array[1]))
	    return false;
	if (!CheckInteger(array[2]))
	    return false;
	if ( eval(array[0])<2000 ||eval(array[0])>9999)
	    return false;
	if ( eval(array[1])<1 ||eval(array[1])>12)
	    return false;
	if ( eval(array[2])<1 ||eval(array[2])>31)
	    return false;
	    
	return true; 
}   
</script>             
<html><!-- #BeginTemplate "/Templates/paperec_templares.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none; color: #000000; font-family: "宋体"}
a:visited {  text-decoration: none; color: #000000; font-family: "宋体"}
a:active {  text-decoration: none; color: #000000; font-family: "宋体"}
a:hover {  color: #330099; text-decoration: underline; font-family: "宋体"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "宋体"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
</head>

<body bgcolor="#E6EDFB" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a>      
          <tr bgcolor="#E6EDFB"> 
                  <td colspan="3" height="26"> </td>
                </tr>
                <tr valign="top"> 
                  <td colspan="3" bgcolor="#E6EDFB"> 
                    <table width="443" border="0" cellspacing="0" cellpadding="0" height="246">
                      <tr> 
       <% if(!lang.equals("modi")){      %>                        
                        <td><img src="../../images/xiangqing.gif" width="127" height="26">&nbsp;&nbsp;您只能修改产品数量及报价到期时间！</td>
                                              
       <%  }else{      %>                       
                        <td><img src="../../images/xiangqing.gif" width="127" height="26">&nbsp;&nbsp;<%=resu%></td>
                                           
       <%      }       %>
                      </tr> 
                       <form name="ok" method="post" action="bidmodi.jsp">  
                      <tr>
                        <td>
                          <table width="447" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left" height="218">
                            
                            <tr> 
               <% if(lang.equals("modi")){      %>                   
                             <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"> 数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： 
                                 <%=str[6]%> &nbsp;&nbsp; <%=str[7]%> </td>
                <%  }else{      %>   
                             <td class="dan10" height="22">  数 量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：
                                 <input type="text" name="number" size="7" onBlur="validField(this)" value=<%=str[6]%> > &nbsp;<%=str[7]%>
                              </td>
               <%      }       %>             
              </tr>
              <tr> 
                <td class="dan10" height="22" colspan="2" >报价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：<%=str[8]%>&nbsp;<%=str[9]%>/<%=str[7]%> 
                </td>
              </tr>
              <tr> 
                <td class="dan10" height="26" colspan="2" >价格条款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： 
                  <%=str[10]%> <%=str[11]%> </td>
              </tr>
                <td class="dan10" height="22" colspan="2" >支付方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：<%=str[12]%> 
                  <%=str[13]%></td>
              </tr>
              <% if (str[9].equals("RMB")) {%>
              <tr> 
                <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"> <%=title[2] %><%=str[14] %> 
                </td>
              </tr>
              <% }%>
              <tr> 
                <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"><%=title[3]%><%=str[18]%></td>
              </tr>
              <tr bgcolor="#E6EDFB"> 
              <% if(lang.equals("modi")){      %>    
                <td class="dan10" height="22" colspan="2">报价有效期&nbsp;&nbsp;&nbsp;：<%=str[15]%> 至 <%=str[16]%> </td>
              <%  }else{      %>   
                              <td class="dan10" height="22"> 报价有效期&nbsp;&nbsp;&nbsp;：<%=str[15]%> 至  
                              <input type="text" name="dqtime" size="12" onBlur="validDateField(this)" value=<%=str[16]%> >                                 
                    <%      }       %> 
              </tr>      
              <tr bgcolor="#E6EDFB" align="center"> 
                  <td colspan="3" class="big" height="25"> <font color="#FFFFFF"><b>
               <% if(lang.equals("modi")){      %>          
                    <input type="button" name="Submit2" value="关 闭" onClick="winclose();">
                 <%  }else{      %>  
                    <input type="hidden" name="posting_id" value="<%=posting_id%>" >
                    <input type="hidden" name="lang" value="modi" >
                    <input type="submit" name="Submit3" value="保 存" >                   
                                     
               <%      }       %>           
                    </b></font></td>
                </tr>
                          </table>
                        </td>
                      </tr>
               
                     </form>
                 
                    </table>
                  </td>
                </tr>
               </body>
<!-- #EndTemplate --></html> 
     
<%    pro.getDestroy(); %>
</jsp:useBean>
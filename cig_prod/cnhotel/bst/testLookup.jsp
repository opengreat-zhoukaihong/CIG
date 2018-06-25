<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
</HEAD>
<BODY>
<SCRIPT LANGUAGE=javascript>
<!--
var wStr
function PostForm()
{
  wStr = "";
  for (j=0;j<fm.elements.length;++j)
  { 
    if (fm.elements[j].type == "checkbox")
    {
     if (fm.elements[j].checked == true)
      {
        wStr = wStr + "'" + fm.elements[j].value + "',"; 
      }
    }
  }
  alert(wStr + "'0'");
}
//-->
</SCRIPT>
<SELECT id=select2 name=select2 
style="HEIGHT: 22px; WIDTH: 204px"> 

<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true" /></SELECT>
<SELECT id=select2 name=select2 
style="HEIGHT: 22px; WIDTH: 204px"> 

<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true" /></SELECT>
<SELECT id=select2 name=select2 
style="HEIGHT: 22px; WIDTH: 204px"> 

<jsp:include page="/servlet/com.dreamerland.cnhotelbooking.bst.CbstLookUp" flush="true" /></SELECT>
<p></P>

</BODY>
</HTML>

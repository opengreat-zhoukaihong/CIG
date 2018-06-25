<!-- Begin
var how_many_ads = 3;
var now = new Date()
var sec = now.getSeconds()
var ad = sec % how_many_ads;
ad +=1;
if (ad==1) {
txt="";
url="http://www.cnhotelbooking.com/chinese/index.htm";
alt="中港澳酒店订房中心";
banner="../banner/cnhotel_ad468.gif";
width="468";
height="60";
}
if (ad==2) {
txt="";
url="http://www.cnhotelbooking.com/english/index.htm";
alt="CNhotelbooking.com";
banner="../banner/eng_ad01.gif";
width="468";
height="60";
}
if (ad==3) {
txt=""; 
url="http://www.cnhotelbooking.com/hk-tw/index.htm";
alt="中港澳酒店订房中心(繁体版)";
banner="../banner/cnhotel_ad_big.gif";
width="468";
height="60";
}
document.write('<center>');
document.write('<a href=\"' + url + '\" target=\"_top\">');
document.write('<img src=\"' + banner + '\" width=')
document.write(width + ' height=' + height + ' ');
document.write('alt=\"' + alt + '\" border=0><br>');
document.write('<small>' + txt + '</small></a>');
document.write('</center>');
// End -->
<!-- Begin
var how_many_ads = 3;
var now = new Date()
var sec = now.getSeconds() + 1
var ad = sec % how_many_ads;
ad = 3;
if (ad==2) {
txt="";
url="http://www.travelsky.com/";
alt="";
banner="banner/small/travelsky.gif";
}
if (ad==3) {
txt="";
url="http://www.gzgreen.com/";
alt="";
banner="banner/small/logo-lj.gif";
width="134";
height="59";
}
if (ad==1) {
txt=""; 
url="http://www.cig.com.cn/";
alt="";
banner="banner/small/cig.gif";
width="134";
height="59";
}
document.write('<center>');
document.write('<a href=\"' + url + '\" target=\"_blank\">');
document.write('<img src=\"' + banner + '\" ')
document.write('alt=\"' + alt + '\" border=0><br>');
document.write('<small>' + txt + '</small></a>');
document.write('</center>');
// End -->
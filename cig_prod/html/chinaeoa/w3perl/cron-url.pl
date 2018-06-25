#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####               URL MAPPING - DOCUMENTS STATS                    #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 12/08/2000     #####
####                                                                #####
####                                                                #####
#########################################################################

$debug = 0;

$version = "2.72";
$verdate = "12/08/00";

$baudrate = 3;
$baudrate *= 1024;

############ script to launch when you want (weekly for me) ##########

## valeur a modifier par fixperlpath.pl

# modif REM a la fin a oter

require "/home/domisse/public_html/w3perl/libw3perl.pl";

$starttime = time();
print "Document stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

### today date

$month_number = $month_equiv{$month};
$month_number--;
$today = $day." ".$month." ".$year;

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

$countdoc = 0;
$totaref = 0;
$divsize = 0;
$countdiv = 0;

#$notitle = "notitle".$htmlext;
$frame = "frames".$htmlext;
$doublons = "doublons".$htmlext;
$nofile = "nofile".$htmlext;
$fileabsolute = "absolute".$htmlext;
$filelinksym = "symbolic".$htmlext;
$new = "newdoc".$htmlext;
$docimage = "docimage".$htmlext;
$doclien = "doclien".$htmlext;
$docsize = "docsize".$htmlext;
$docrepert = "docrepert".$htmlext;
$tree = "tree".$htmlext;
$useless = "useless".$htmlext;
$imawidth = "width".$htmlext;
$imaalt = "alt".$htmlext;
$cdrom = "cdrom".$htmlext;
$fileunread = "unread".$htmlext;
#$dirdocs2 = $dirdocs;
#$dirdocs2 =~ s/$dirsepurl/$dirsep/g;

$tmp1 = "tmp1";
$tmp2 = "tmp2";
$tmp3 = "tmp3";
$tmp4 = "tmp4";

$nowidth = 0;
$countwidth = 0;
$uniqwidth = 0;
$gif = 0;
$jpg = 0;
$xbm = 0;

# Define marker types
$M_SOF0  = "\xC0";        $M_SOF3  = "\xC3";
$M_SOF5  = "\xC5";        $M_SOF7  = "\xC3";
$M_SOF9  = "\xC9";        $M_SOF11 = "\xCB";
$M_SOF13 = "\xCD";        $M_SOF15 = "\xCF";
$M_SOI   = "\xD8";        $M_EOI   = "\xD9";
$M_SOS   = "\xDA";        $FF      = "\xFF";
 
# Define socket
$AF_INET = 2;
$sockaddr = 'S n a4 x8';
chop($hostname = `hostname`);

%FailStatusMsgs = (-1,"Could Not Look Up Server",
                   -2,"Could Not Open Socket",
                   -3,"Could Not Bind Socket",
                   -4,"Could Not Connect",
                   301,"Found, But Moved",
	           302,"Found, But Data Resides Under a Different URL",
	           303,"Method",304,"Not Modified",
	           400,"Bad Request",
	           401,"Unauthorized",
	           402,"Payment Required",
	           403,"Forbidden",
	           404,"Not Found",
          	   500,"Internal Error",
          	   501,"Not Implemented",
          	   502,"Service Temporarily Overloaded",
          	   503,"Gateway Timeout",
          	   600,"Bad Request",601,"Not Implemented",
          	   602,"Connection Failed",
          	   603,"Timed Out");

$tripart = $tri;
$tmpdirsep = 0;
$pos = length($tripart);
while (($pos = rindex($tripart,$dirsepurl,$pos)) >= 0) {
	$tmpdirsep++;
	$pos--;
	}
$tmpdirsep--;
	          
$pathserver2 = $pathserver;
chop($pathserver2);
chop($tripart);

$pathserver2 =~ s/\$/\\\$/;  # Acorn

#chop($pathserver2) if ($type_serveur == 1);

$defaulthomepage =~ s/\//\./;

#################################################################
###            parsing the command line option                ###
#################################################################

$modifjour = 7; # 7 jours

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -a                    : checking external links\n";      
      print STDOUT "        -c <file>             : load configuration file\n";      
      print STDOUT "        -d <nbdays>           : find files newest than nbdays days\n";
      print STDOUT "        -g <";
      for ($i=0;$i<$#graphic;$i++) {
      print STDOUT "$graphic[$i] ";
      } 
      print STDOUT "$graphic[$#graphic]";
      print STDOUT "> : graphic output (choose one)\n";
      print STDOUT "        -l <";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      } 
      print STDOUT "$lang[$#lang]";
      print STDOUT ">            : language output (comma split)\n";      
      print STDOUT "        -t <toplist>          : display only toplist files\n";
      print STDOUT "        -x                    : show default value for flag options\n";
      print STDOUT "        -v                    : version\n";
      print STDOUT "\n";
      exit;
}

if ($opt_v == 1) {
      print STDOUT "cron-url.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -a            : ";
      &id($opt_a);
      print STDOUT "          -c            : $configfile\n";      
      print STDOUT "          -d <nbdays>   : $modifjour\n";
      print STDOUT "          -g <graphic>  : $graphic[0]\n";
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDOUT "          -t <toplist>  : $topten\n";
      print STDOUT "          -v            : $version\n";
      exit;
}

if ($opt_d ne '') {
$modifjour = $opt_d;
}

if ($opt_t ne '') {
$topten = $opt_t;
}

if ($opt_l ne '') {
  @lang = split(/, /,$opt_l);
  for ($i=0;$i<=$#lang;$i++) {
      $tmp = $dirress.$dirsep."lang".$dirsep.$lang[$i].$plext;
      $tmp = $pathinit.$tmp;
      require "$tmp";
  }
  if ($lang[0] eq '') {
      print STDERR "\nNone of your language choices have been yet translated !\n";
      exit; 
      }
}

if ($opt_g ne '') {
  if ($opt_g eq "3d")  {
      $bargraph = 1;
      $linegraph = 0;
      $tridim = 1;
  }
  if ($opt_g eq "fill") {
      $bargraph = 0;
      $linegraph = 1;
      $fillgraph = 1;
  }
  if ($opt_g eq "line") {
      $bargraph = 0;
      $linegraph = 1;
  }
  if ($opt_g eq "bar") {
      $bargraph = 1;
      $linegraph = 0;
      $tridim = 0;
  }
}

if ($titlename == 0) {
exit;
}

#################################################################
####          debut de l'initialisation                   #######
#################################################################

$lienfile = $path.$dirgraph.$dirsep."lien".$gifext;
$lienfilex = $path.$dirgraph.$dirsep."lienx".$gifext;
$lienfiley = $path.$dirgraph.$dirsep."lieny".$gifext;

$linklienfile = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."lien".$gifext;
$linklienfilex = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."lienx".$gifext;
$linklienfiley = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."lieny".$gifext;

$imafile = $path.$dirgraph.$dirsep."ima".$gifext;
$imafilex = $path.$dirgraph.$dirsep."imax".$gifext;
$imafiley = $path.$dirgraph.$dirsep."imay".$gifext;

$linkimafile = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."ima".$gifext;
$linkimafilex = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."imax".$gifext;
$linkimafiley = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."imay".$gifext;

$sizefile = $path.$dirgraph.$dirsep."size".$gifext;
$sizefilex = $path.$dirgraph.$dirsep."sizex".$gifext;
$sizefiley = $path.$dirgraph.$dirsep."sizey".$gifext;

$linksizefile = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."size".$gifext;
$linksizefilex = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."sizex".$gifext;
$linksizefiley = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."sizey".$gifext;

$recentfile = $path.$dirgraph.$dirsep."recent".$gifext;
$recentfilex = $path.$dirgraph.$dirsep."recentx".$gifext;
$recentfiley = $path.$dirgraph.$dirsep."recenty".$gifext;

$linkrecentfile = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."recent".$gifext;
$linkrecentfilex = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."recentx".$gifext;
$linkrecentfiley = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."recenty".$gifext;

for ($i=0;$i<=$#extension;$i++) {
$search .= "\\.".$extension[$i]."\$|";
}
chop($search);


for ($i=0;$i<=$#extensionimage;$i++) {
$searchima .= "\\.".$extensionimage[$i]."\$|";
}
chop($searchima);

chop($pathserver);
#chop($pathserver) if ($type_serveur == 1);

### create directory

$tmp = $path;
chop($tmp);
mkdir ($tmp,0775) unless -d $tmp;

$dir = $path.$dirdata;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirtmp;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirgraph;
mkdir ($dir,0775) unless -d $dir;

# ML

for ($nblang=0;$nblang<=$#lang;$nblang++) {

$dir = $path.$lang[$nblang];
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirdocument;
mkdir ($dir,0775) unless -d $dir;

}

$timeweek = 60*60*24*$modifjour;

#################################################################
####                   date de ce jour                    #######
#################################################################


### date il y a $modifjour jours

if ($modifjour != 0 ) {

$pastday = $day  - $modifjour;
$pastyear = $year;
$pastmonth = $month_nb[$month_number];

while ($pastday < 1) {
  $month_number--;
  if ($month_number < 0) {
      $pastyear--;
      $month_number = 11;
   }
   $pastmonth = $month_nb[$month_number];
   $pastday = $pastday + $month_of_year{$pastmonth};
}

$pasttoday = $pastday." ".$pastmonth." ".$pastyear;

}

#print "Aujourd'hui nous sommes le $today\n";
#print "il y a $modifjour jours , nous etions le $pasttoday\n";

if ($type_serveur != 1) {
while (index($excluderepert,'~') >= 0) {
$excluderepert =~ s/~(\w+)\/(.*)/$1\/$tildealias\/$2/;
}

$pos = index($tripart,'~');
if ($pos >= 0) {
$tripart =~ s/~//;
$tripart = $tripart.$dirsep if (rindex($tripart,$dirsep,length($tripart))+1 != length($tripart));
$tripart = $tripart.$tildealias.$dirsep;
#print STDOUT "$opt_r is know now as $tripart\n";
}
}

$excluderepert =~ s/\//$dirsep$dirsep/g if ($type_serveur == 1);

#################################################################
####                  Scanning your web                   #######
#################################################################

print STDOUT "Scanning your web...\n";

open(TMPWIDTH,">$path$dirtmp$dirsep$tmp1") || die "Error, unable to open $path$dirtmp$dirsep$tmp1\n";
open(TMPWIDTH2,">$path$dirtmp$dirsep$tmp2") || die "Error, unable to open $path$dirtmp$dirsep$tmp2\n";
open(TMPWIDTH3,">$path$dirtmp$dirsep$tmp3") || die "Error, unable to open $path$dirtmp$dirsep$tmp3\n";
open(TMP4,">$path$dirtmp$dirsep$tmp4") || die "Error, unable to open $path$dirtmp$dirsep$tmp4\n";
open(FILEFRAME,">$path$dirdata$dirsep$dirframe") || die "Error, unable to open $path$dirdata$dirsep$dirframe\n";

open(OUTFILE,">$path$dirdata$dirsep$fileurl");
chdir($pathserver);
print "$pathserver\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

&dodir($pathserver);
close (OUTFILE);

close(TMPWIDTH);
close(TMPWIDTH2);
close(TMPWIDTH3);
close(TMP4);
close(FILEFRAME);

#################################################################
####                    HTML framed pages                 #######
#################################################################

if ($url_frame == 1 && $#framed != -1) {

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FRAMED,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$frame") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$frame\n";
&Framed(*FRAMED, eval($Lang{$lang[$nblang]}));
close (FRAMED);
}
}

sub Framed {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'HTML_pages'} - $L{'Frames'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'HTML_pages'} - $L{'Frames'}</H1>\n";
print FOUT "<P><HR>\n";

for ($i=0;$i<=$#framed;$i++) {
print FOUT "<A HREF=\"$linkpathserver$framed[$i]\" TARGET=\"_top\">$framed[$i]</A><BR>\n";
}

print FOUT "<P><HR>\n";
print FOUT "</BODY></HTML>\n";
}

undef @framed;

#################################################################
####           HTML pages with no TITLE tag               #######
#################################################################

#if ($url_doublon == 1) {
#
#for ($nblang=0;$nblang<=$#lang;$nblang++) {
#open(NOTITLE,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$notitle") || di#e "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$notit#le\n";
#&NoTitle(*NOTITLE, eval($Lang{$lang[$nblang]}));
#close (NOTITLE);
#}
#
#}
#
#sub NoTitle {
#	local(*FOUT,*L) = @_;
#	
#print FOUT "<HTML><HEAD>\n";
#print FOUT "<TITLE>$L{'HTML_pages'} $L{'without_title'}</TITLE>\n";
#print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $h#ourdate -->\n";
#print FOUT "</HEAD>\n";
#print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK#=\"$custom_vlink\">\n";
#print FOUT "<H1> $L{'HTML_pages'} $L{'without_title'}</H1>\n";
#print FOUT "<P><HR>\n";
#
#for ($i=0;$i<=$#notitle;$i++) {
#print FOUT "<A HREF=\"$linkpathserver$notitle[$i]\" TARGET=\"_top\">$notitle#[$i]</A><BR>\n";
#}
#
#print FOUT "<P><HR>\n";
#print FOUT "</BODY></HTML>\n";
#}
#
#undef @notitle;

#################################################################
####              HTML pages with absolute links          #######
#################################################################

if ($url_absolute_link == 1) {
print STDOUT "Liste des liens absolus\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(FILEABS,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$fileabsolute") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$fileabsolute\n";
&Absolute(*FILEABS, eval($Lang{$lang[$nblang]}));
close (FILEABS);
}

}

sub Absolute {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'List_of'} $L{'absolute_links'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'List_of'} $L{'absolute_links'}</H1>\n";
print FOUT "<P><HR><P>\n";
print FOUT "<H3> $L{'HTML_files'} : </H3>\n";

$j = 0;
$absolutebis[0] = $absolute[0];
print FOUT "$absolutebis[0]<UL><I>\n";
for ($k=1;$k<=$ab{$absolutebis[$j]};$k++) {
       print FOUT "<LI>$fileabs{$absolutebis[$j],$k}\n";
}
print FOUT "</I></UL>\n";

for ($i=1;$i<=($#absolute);$i++) {
     if ($absolute[$i] ne $absolute[$i-1]) {
        $absolutebis[$j] = $absolute[$i];
        print FOUT "$absolutebis[$j]<br><UL><I>\n";
        for ($k=1;$k<=$ab{$absolutebis[$j]};$k++) {
            print FOUT "<LI>$fileabs{$absolutebis[$j],$k}\n";
            }
        print FOUT "</I></UL>\n";
        $j++;
     }
}

print FOUT "<P><HR><P>\n";
print FOUT "<H3> $L{'Images'} : </H3>\n";

$j = 0;
$absoluteimabis[0] = $absoluteima[0];
print FOUT "$absoluteimabis[0]<UL><I>\n";
for ($k=1;$k<=$abima{$absoluteimabis[$j]};$k++) {
       print FOUT "<LI>$fileimaabs{$absoluteimabis[$j],$k}\n";
}
print FOUT "</I></UL>\n";

for ($i=1;$i<=($#absoluteima);$i++) {
     if ($absoluteima[$i] ne $absoluteima[$i-1]) {
        $absoluteimabis[$j] = $absoluteima[$i];
        print FOUT "$absoluteimabis[$j]<br><UL><I>\n";
        for ($k=1;$k<=$abima{$absoluteimabis[$j]};$k++) {
            print FOUT "<LI>$fileimaabs{$absoluteimabis[$j],$k}\n";
            }
        print FOUT "</I></UL>\n";
        $j++;
     }
}

print FOUT "<P><HR>\n";
print FOUT "</BODY></HTML>\n";
}

undef @absolute;
undef @absoluteima;


#################################################################
####                     HTML symbolic links              #######
#################################################################

if ($url_symbolic_link == 1) {
print STDOUT "Liste des liens symboliques\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(FILESYM,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$filelinksym") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$filelinksym\n";
&Symbolic(*FILESYM, eval($Lang{$lang[$nblang]}));
close (FILESYM);
}
}

sub Symbolic {
	local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'List_of'} $L{'symbolic_links'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'List_of'} $L{'symbolic_links'}</H1>\n";
print FOUT "<P><HR><P>\n";

print FOUT "<TABLE WIDTH=100% BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'symbolic_links'}</TH><TH>$L{'File'}</TH></TR>\n";
for ($i=0;$i<=($#linkfile);$i++) {
    $linkfilename = readlink($linkfile[$i]);
    $linkfile[$i] =~ s/$pathserver//;
    print FOUT "<TR><TD>$linkfile[$i]</TD><TD>$linkfilename</TD></TR>\n";
}

print FOUT "</TABLE>\n";
print FOUT "<P><HR>\n";
print FOUT "</BODY></HTML>\n";
}


undef @linkfile;

#################################################################
####              HTML pages with bad links               #######
#################################################################

if ($url_bad_link == 1) {

print STDOUT "Liste des liens sur des fichiers inexistants\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(NOFILE,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$nofile") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$nofile\n";
&MissingFiles(*NOFILE, eval($Lang{$lang[$nblang]}));
close (NOFILE);
}
}

sub MissingFiles {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'List_of'} $L{'bad_links'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'List_of'} $L{'bad_links'}</H1>\n";
print FOUT "<P><HR><P>\n";
print FOUT "<A NAME=\"html\">\n";
print FOUT "<H3> $L{'HTML_files'} : </H3>\n";

$j = 0;
$nofilebis[0] = $nofile[0];
print FOUT "<B>$nofilebis[0]</B>\n<UL><I>\n";
for ($k=1;$k<=$no{$nofilebis[$j]};$k++) {
       print FOUT "<LI>$filemiss{$nofilebis[$j],$k}\n";
}
print FOUT "</I></UL>\n";

for ($i=1;$i<=($#nofile);$i++) {
     if ($nofile[$i] ne $nofile[$i-1]) {
        $nofilebis[$j] = $nofile[$i];
        print FOUT "<B>$nofilebis[$j]</B>\n<br><UL><I>\n";
        for ($k=1;$k<=$no{$nofilebis[$j]};$k++) {
            print FOUT "<LI>$filemiss{$nofilebis[$j],$k}\n";
            }
        print FOUT "</I></UL>\n";
        $j++;
     }
}

print FOUT "<P><HR><P>\n";
print FOUT "<A NAME=\"ima\">\n";
print FOUT "<H3> $L{'Images'} : </H3>\n";

$j = 0;
$noimabis[0] = $noima[0];
print FOUT "<B>$noimabis[0]</B>\n<UL><I>\n";
for ($k=1;$k<=$noima{$noimabis[$j]};$k++) {
       print FOUT "<LI>$imamiss{$noimabis[$j],$k}\n";
}
print FOUT "</I></UL>\n";

for ($i=1;$i<=($#noima);$i++) {
     if ($noima[$i] ne $noima[$i-1]) {
        $noimabis[$j] = $noima[$i];
        print FOUT "<B>$noimabis[$j]</B>\n<br><UL><I>\n";
        for ($k=1;$k<=$noima{$noimabis[$j]};$k++) {
            print FOUT "<LI>$imamiss{$noimabis[$j],$k}\n";
            }
        print FOUT "</I></UL>\n";
        $j++;
     }
}

print FOUT "<P><HR><P>\n";
print FOUT "<A NAME=\"background\">\n";
print FOUT "<H3> $L{'Background'} : </H3>\n";

$j = 0;
$nobackbis[0] = $noback[0];
print FOUT "<B>$nobackbis[0]</B>\n<UL><I>\n";
for ($k=1;$k<=$back{$nobackbis[$j]};$k++) {
       print FOUT "<LI>$filebackmiss{$nobackbis[$j],$k}\n";
}
print FOUT "</I></UL>\n";

for ($i=1;$i<=($#noback);$i++) {
     if ($noback[$i] ne $noback[$i-1]) {
        $nobackbis[$j] = $noback[$i];
        print FOUT "<B>$nobackbis[$j]</B>\n<br><UL><I>\n";
        for ($k=1;$k<=$back{$nobackbis[$j]};$k++) {
            print FOUT "<LI>$filebackmiss{$nobackbis[$j],$k}\n";
            }
        print FOUT "</I></UL>\n";
        $j++;
     }
}

print FOUT "<P><HR><P>\n";
print FOUT "<A NAME=\"cgibin\">\n";
print FOUT "<H3> $L{'Cgi-bin'} : </H3>\n";

$j = 0;
$nocgibinbis[0] = $nocgibin[0];
print FOUT "<B>$nocgibinbis[0]</B>\n<UL><I>\n";
for ($k=1;$k<=$nocgi{$nocgibinbis[$j]};$k++) {
       print FOUT "<LI>$filecgimiss{$nocgibinbis[$j],$k}\n";
}
print FOUT "</I></UL>\n";

for ($i=1;$i<=($#nocgibin);$i++) {
     if ($nocgibin[$i] ne $nocgibin[$i-1]) {
        $nocgibinbis[$j] = $nocgibin[$i];
        print FOUT "<B>$nocgibinbis[$j]</B>\n<br><UL><I>\n";
        for ($k=1;$k<=$nocgi{$nocgibinbis[$j]};$k++) {
            print FOUT "<LI>$filecgimiss{$nocgibinbis[$j],$k}\n";
            }
        print FOUT "</I></UL>\n";
        $j++;
     }
}

print FOUT "<P><HR>\n";
print FOUT "</BODY></HTML>\n";
}

undef @nofile;
undef @noima;
undef @noback;
undef @nocgibin;

#################################################################
####         HTML pages with the same TITLE tag           #######
#################################################################

if ($url_doublon ==  1) {
print STDOUT "Liste des pages ayant des TITLE identiques\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

@doublon = sort @doublon;

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(DOUBLONS,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$doublons") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$doublons\n";
&Doublons(*DOUBLONS, eval($Lang{$lang[$nblang]}));
close (DOUBLONS);
}
}

undef @notitle;

sub Doublons {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'HTML_pages'} $L{'with_the_same_title'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'HTML_pages'} $L{'without_title'}</H1>\n";
print FOUT "<P><HR>\n";

for ($i=0;$i<=$#notitle;$i++) {
print FOUT "<A HREF=\"$linkpathserver$notitle[$i]\" TARGET=\"_top\">$notitle[$i]</A><BR>\n";
}

print FOUT "<P><HR><P>\n";
print FOUT "<H1> $L{'HTML_pages'} $L{'with_the_same_title'}</H1>\n";
print FOUT "<P><HR>\n";

$j = 0;
$doublonbis[$j] = $doublon[$j];
print FOUT "<I>null string</I> :<UL>" if ($doublonbis[$j] eq '' && $dou{$doublonbis[$j]} != 0);
print FOUT "$doublonbis[$j] :<UL>\n" if ($doublonbis[$j] ne '');
for ($k=1;$k<=$dou{$doublonbis[$j]};$k++) {
       print FOUT "<LI>$filedoublon{$doublonbis[$j],$k}\n";
}
print FOUT "</UL>\n";

for ($i=1;$i<=($#doublon);$i++) {
     if ($doublon[$i] ne $doublon[$i-1]) {
        $doublonbis[$j] = $doublon[$i];
        print FOUT "$doublonbis[$j] :<BR><UL>\n";
        for ($k=1;$k<=$dou{$doublonbis[$j]};$k++) {
            print FOUT "<LI>$filedoublon{$doublonbis[$j],$k}\n";
            }
        print FOUT "</UL>\n";
        $j++;
     }
}


print FOUT "</BODY></HTML>";
}

undef @doublon;

# extract ~ for alias path

#$debline = $pathserver;
if ($pathserver =~ m/$tildealias/i) {
$userid = $linkpathserver;
$userid =~ s/~//;
$pathserver =~ s/$userid$tildealias//;
($a,$debline) = split($dirsep,$pathserver);
}
#$debline = $debline.$dirsep;

#################################################################
####         write back the file with uniq URL            #######
#################################################################

open (LISTE, "$path$dirdata$dirsep$fileurl");
@lines = <LISTE>;
close LISTE;

@lines = sort @lines;

$tmpa = $linkpathserver;
chop($tmpa);

$pathserver2 =~ s/\\/\//g if ($type_serveur == 1);

open(OUTFILE,">$path$dirdata$dirsep$fileurl");
BOUCLE:
foreach $line (@lines) {
    $line =~ s/\\/\//g;
      $double = 0;
      ($var1,$var2,@end) = split(/"/,$line);
      chop($var1);
      
	# Acorn
                
	if ($dirsep eq ".") {
		$var1 =~ s/\./$dirsepurl/g;
		$var1 =~ s/(.*)$dirsepurl(.*)$/$1\.$2/;
		#print STDERR "$temp1\n";
	}      

#      $var1 =~ s/$userid$tildealias\//$linkpathserver/;
#      $var1 =~ s/$pathserver2//i;

$done = 0;
$done = 1 if ($var1 =~ /$tildealias/);

$var1 =~ s/$pathserver2//i;
$var1 = $tmpa.$var1 if ($done == 1);

#$var1 = $tripart.$var1;

      for ($i=0;$i<=($#doublonbis);$i++) {
#        print STDOUT "$i $doublonbis[$i]\n";
        if ($var2 eq $doublonbis[$i] && $doublonbis[$i] ne '') {
             $double = 1;
             $doubvar2{$var2}++;
             print OUTFILE "$var1 \"$var2 ($doubvar2{$var2})\"@end";
     next BOUCLE;
     }
}
if ($double == 0) {
$done = 0;
$done = 1 if ($line =~ /$tildealias/);
$line =~ s/$pathserver2//i;
$line = $tmpa.$line if ($done == 1);

# Acorn
if ($dirsep eq ".") {
($var1,$var2,@end) = split(/"/,$line);
chop($var1);
$var1 =~ s/\./$dirsepurl/g;
$var1 =~ s/(.*)$dirsepurl(.*)$/$1\.$2/;
$line = "$var1 \"$var2\"@end";
}      

$line = $tripart.$line if ($done == 0);
print OUTFILE $line;

}
}
close (OUTFILE);

### current file time in second

($now)= (stat("$path$dirdata$dirsep$fileurl")) [9];

### images and misc files info

open (LISTE, "$path$dirtmp$dirsep$tmp4");
@lines = <LISTE>;
close LISTE;

@lines = sort @lines;

open(OUTFILE,">$path$dirtmp$dirsep$tmp4");
BOUCLE:
foreach $line (@lines) {
    $line =~ s/\\/\//g;
      ($var1,$var2) = split(/ /,$line);

$done = 0;
$done = 1 if ($var1 =~ /$tildealias/);
$line =~ s/$pathserver2//i;
$line = $tmpa.$line if ($done == 1);

# Acorn
if ($dirsep eq ".") {
($var1,$var2) = split(/ /,$line);
$var1 =~ s/\./$dirsepurl/g;
$var1 =~ s/(.*)$dirsepurl(.*)$/$1\.$2/ if ($var1 =~ /$searchima/i);
$var1 =~ s/(.*)$dirsepurl(.*)$/$1$dirsepurl$2/ if ($var1 !~ /$searchima/i);
$line = "$var1 $var2";
}      

$line = $tripart.$line if ($done == 0);
print OUTFILE $line;

}
close (OUTFILE);

# A faire : gerer les title avec des champs vide !!!!!!!!!!!

#################################################################
####               scanning the file produced             #######
#################################################################

open(TMP4,"$path$dirtmp$dirsep$tmp4") || die "Cannot open $path$dirtmp$dirsep$tmp4\n";
while (<TMP4>) {
($url,$size) = split;
$posslash = rindex($url,$dirsepurl,length($url));
$racine = substr($url,0,$posslash+1);

$freqracima{$racine}++ if ($url =~ /$searchima/i);
$freqracdiv{$racine}++ if ($url !~ /$searchima/i);

#$freqracglob{$racine}++;
#$freqsizeglob{$racine} += $size;   

$freqrac{$racine}++;
$repertunique++ if ($freqrac{$racine} == 1);
#$repertunique++ if ($freqracima{$racine} == 1);
#$repertunique++ if ($freqracdiv{$racine} == 1);
$freqsizeima{$racine} += $size if ($url =~ /$searchima/i);
$freqsizediv{$racine} += $size if ($url !~ /$searchima/i);
$freqsizeall{$racine} += $size;

   $posslash = rindex($racine,'/',length($racine));
   $racine = substr($racine,0,$posslash+1);
   $racinebis = $racine;

   while ($posslash > 0) {
   $freqracglob{$racinebis}++;
   $freqsizeglob{$racinebis} += $size;
#   $freqracglob{$dirsepurl}++;
#   $freqsizeglob{$dirsepurl} += $size;               
   $posslash--;
   $posslash--;
   $posslash = rindex($racinebis,'/',$posslash);
   $racinebis = substr($racinebis,0,$posslash+1);
   }
}

close(TMP4);
unlink("$path$dirtmp$dirsep$tmp4");

open(LIEN,"$path$dirdata$dirsep$fileurl") || die "Cannot open $path$dirdata$dirsep$fileurl\n";
while (<LIEN>) {

($url,$title,$end) = split(/"/);
chop ($url);

$urlconv{$url} = $title;

chop ($title);

($a,$nblink,$nbima,$size,$mtime) = split(/ /,$end);

chop($mtime);

# directories stats

$posslash = rindex($url,$dirsepurl,length($url));
$racine = substr($url,0,$posslash+1);


$freqrachtml{$racine}++;
$freqrac{$racine}++;
$repertunique++ if ($freqrac{$racine} == 1);

#$freqracglob{$racine}++;
#$freqsizeglob{$racine} += $size;   
$freqsizehtml{$racine} += $size;
$freqsizeall{$racine} += $size;

#   $posslash = rindex($racine,'/',length($racine));
#   $racine = substr($racine,0,$posslash+1);
   $racinebis = $racine;

   while ($posslash > 0) {
   $freqracglob{$racinebis}++;
   $freqsizeglob{$racinebis} += $size;
#   $freqracglob{$dirsepurl}++;
#   $freqsizeglob{$dirsepurl} += $size;         

   $posslash--;
   $posslash--;
   $posslash = rindex($racinebis,'/',$posslash);
   $racinebis = substr($racinebis,0,$posslash+1);
   }

   
if ($now - $mtime < $timeweek) {
$frequpdate{$racine}++;
}


# tree

if ($url_tree == 1) {
$leveldepth = 0;
$racine = $url;
$posslash = rindex($racine,$dirsepurl,length($racine));

#print STDERR "$racine\n";

while ($posslash > 1) {
$leveldepth = 1;
$racine = substr($racine,0,$posslash+1); # if ($type_serveur != 1);
#$racine = substr($racine,0,$posslash) if ($type_serveur == 1);
$temp2 = $racine;
$temp2 .= $dirsepurl;
$freqracdepth{$temp2}++;

#$a = substr($racine,$posslash);
#print STDERR "$racine - $temp2 - $freqracdepth{$temp2} - $racine - $a - $dirsepurl\n";

if ($freqracdepth{$temp2} == 1 && substr($racine,$posslash) eq $dirsepurl) {

     # compte le nombre de / dans $racine
     $temp = $racine;
     $pos = rindex($temp,$dirsepurl,length($temp));

     $pos2 = rindex($temp,$dirsepurl,length($temp)-2);
     $remind = substr($temp,$pos2,length($temp));

     while ($pos > 1) {

     $temp = substr($temp,0,$pos);
     $pos = rindex($temp,$dirsepurl,length($temp));
     $leveldepth++;
     }

#     $leveldepth /= 2 if ($type_serveur == 1);
    
     $temp .= $dirsepurl;

#     print STDOUT "temp : $temp racine $racine $leveldepth\n";

     $depthocc{$temp,2} = 1;

     if (!($seen{$temp}++)) {
     $depth{$leveldepth}++;
     $depth{2}++ if ($leveldepth != 2);
     $line{$depth{2}} = $temp if ($leveldepth != 2);
     }

#     print STDOUT "$temp  $leveldepth $depth{$leveldepth} $depth{2}\n";
     $depthocc{$temp,$leveldepth}++ unless (($seen{$racine}++) || $leveldepth == 2);
     $line{$depth{$leveldepth}} = $temp if ($leveldepth == 2);
#     $line{$depth{$leveldepth}} = $temp unless ($seen{$temp}++);

     $depthrac{$temp,$depthocc{$temp,$leveldepth},$leveldepth} = $racine;
     $maxdepth = $leveldepth if ($leveldepth > $maxdepth);
     }

$posslash = rindex($racine,$dirsepurl,length($racine));
$posslash--;
}
}

# find recents documents

if ($url !~ /$pathserver$dirsep$packagename$dirsep/o && $url_new_doc == 1) {
    if ($now - $mtime < $timeweek) {
        $secjour = ($now - $mtime)/(60*60*24);
        $intsecjour = int($secjour);
        $nbmodif{$intsecjour}++;
        $modif{$intsecjour,$nbmodif{$intsecjour}} = $url;
    }
$mostlink{$url} = $nblink;
$mostima{$url} = $nbima;
$mostsize{$url} = $size;
}


$ima{$nbima}++;
$link{$nblink}++;

$imamax = $nbima if ($nbima > $imamax);
$yimamax = $ima{$nbima} if ($ima{$nbima} > $yimamax);

$linkmax = $nblink if ($nblink > $linkmax);
$ylinkmax = $link{$nblink} if ($link{$nblink} > $ylinkmax);


$size = int($mostsize{$url}/1024);
$taille{$size}++;

$sizemax = $size if ($size > $sizemax);
$ysizemax = $taille{$size} if ($taille{$size} > $ysizemax);

}
close (LIEN);


####    checking WIDTH, HEIGHT, ALT and HTML weight

#################################################################
####               width, height and alt tag              #######
#################################################################

if ($url_img_tag == 1) {
print STDOUT "Pages non optimisees\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(IMAWIDTH,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$imawidth") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$imawith\n";
&DocImageWidth(*IMAWIDTH, eval($Lang{$lang[$nblang]}));
close (IMAWIDTH);

open(IMAALT,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$imaalt") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$imaalt\n";
&DocImageAlt(*IMAALT, eval($Lang{$lang[$nblang]}));
close (IMAALT);
}
}

sub DocImageWidth {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_width'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Stats_about_width'}</H1>\n";

print FOUT "<P><HR><P>\n";
print FOUT "<A HREF=\"$nofile#ima\">$L{'Bad_links'}</A> $L{'not_included'} <BR>\n";
print FOUT "$nowidth $L{'hTML_pages'} $L{'With'} $countwidth $L{'images'} $L{'without'} WIDTH, HEIGHT ($L{'among'} $uniqwidth $L{'different_images'})\n<BR>";
print FOUT "GIF : $gif, JPG : $jpg, XBM : $xbm<P>";

print FOUT "<P><HR ALIGN=CENTER WIDTH=30% SIZE=5><P>\n";

print FOUT "<FONT SIZE=+1><B>$L{'Pages'} $L{'without'} WIDTH $L{'and'} HEIGHT : </B></FONT><P>\n";

open(TMPWIDTH,"$path$dirtmp$dirsep$tmp1") || die "Error, unable to open $path$dirtmp$dirsep$tmp1\n";
while (<TMPWIDTH>) {
print FOUT;
}
close(TMPWIDTH);

print FOUT "<P><HR ALIGN=CENTER WIDTH=30% SIZE=5><P>\n";

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH ROWSPAN=2 COLSPAN=2><FONT SIZE=+1>&nbsp;$L{'Pages'} $L{'With'} $L{'wrong'} WIDTH, HEIGHT :</FONT></TH>\n";
print FOUT "<TD COLSPAN=2 ALIGN=CENTER>$L{'Found_in'} $L{'hTML_pages'}</TD><TD COLSPAN=2 ALIGN=CENTER>$L{'Correct_size_taken_from_image'}</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER>WIDTH</TD><TD ALIGN=CENTER>HEIGHT</TD>\n";
print FOUT "<TD ALIGN=CENTER>WIDTH</TD><TD ALIGN=CENTER>HEIGHT</TD>\n";
print FOUT "</TR>\n";

open(TMPWIDTH2,"$path$dirtmp$dirsep$tmp2") || die "Error, unable to open $path$dirtmp$dirsep$tmp2\n";
while (<TMPWIDTH2>) {
($temp1,$url,$linksrc,$x1,$y1,$x,$y) = split(/\t/,$_);
print FOUT "<TR><TD>$L{'Page'}</TD><TD>$temp1</TD>\n";
print FOUT "<TD ROWSPAN=3 ALIGN=CENTER><I>$x1</I></TD><TD ROWSPAN=3 ALIGN=CENTER><I>$y1</I></TD>\n";
print FOUT "<TD ROWSPAN=3 ALIGN=CENTER><B>$x</B></TD><TD ROWSPAN=3 ALIGN=CENTER><B>$y</B></TD></TR>\n";
print FOUT "<TR><TD>$L{'Image'}</TD><TD>$url</TD></TR>\n";
print FOUT "<TR><TD>$L{'Link'}</TD><TD>$linksrc</TD></TR>\n";
}
close(TMPWIDTH2);

print FOUT "</TABLE>\n";

print FOUT "</BODY></HTML>";

}


sub DocImageAlt {
local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_alt'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Stats_about_alt'}</H1>\n";

print FOUT "<P><HR><P>\n";
print FOUT "<FONT SIZE=+1><B>$L{'Pages'} $L{'without'} ALT :</B></FONT> <P>\n";

#print FOUT "<TABLE BORDER=1>\n";
print FOUT "<UL><UL>\n";

open(TMPWIDTH3,"$path$dirtmp$dirsep$tmp3") || die "Error, unable to open $path$dirtmp$dirsep$tmp3\n";
while (<TMPWIDTH3>) {
($temp1,$linksrc) = split(/\t/,$_);
print FOUT "</UL></I><LI>$temp1\n<I><UL>\n" if ($temp1 ne $baktemp1);
$baktemp1 = $temp1;
print FOUT "<LI>$linksrc\n";
}
close(TMPWIDTH3);

print FOUT "</TABLE>\n";

print FOUT "</BODY></HTML>";
}

unlink("$path$dirtmp$dirsep$tmp1");
unlink("$path$dirtmp$dirsep$tmp2");
unlink("$path$dirtmp$dirsep$tmp3");

#################################################################
####               scanning holes in tree                 #######
#################################################################

if ($url_tree == 1) {
for ($j=1;$j<=$depth{2};$j++) {
$temp = $line{$j};
#print STDOUT "\nLine : $temp\n";
for ($leveldepth=$maxdepth;$leveldepth>=3;$leveldepth--) {
#      print STDOUT "Niveau : $leveldepth\n";

      for ($m=0;$m<=$depthocc{$temp,$leveldepth};$m++) {
           $racine = $depthrac{$temp,$m,$leveldepth};
           if ($racine ne '') {
#              print STDOUT "$racine ";

             $match = 0;
             # check si le niveau en dessous existe
             for ($l=0;$l<=$depthocc{$temp,$leveldepth-1};$l++) {
               if ($racine =~ /$depthrac{$temp,$l,$leveldepth-1}/ && $depthrac{$temp,$l,$leveldepth-1} ne '') {
#               print STDOUT " OK $depthrac{$temp,$l,$leveldepth-1}\n";
               $match = 1;
               last;
               }
             }

             if ($match == 0) {
               $subleveldepth = $leveldepth;
#               print STDOUT " HOLE !!! ";
               # extraction de la sous-chaine et iteration
               $temp2 = $racine;
               chop($temp2);
               $pos = rindex($temp2,$dirsepurl,length($temp2))+1;
               $remind = substr($temp2,0,$pos);

               while ($pos > 1) {
                  $temp2 = substr($temp2,0,$pos);
                  $pos = rindex($temp2,$dirsepurl,length($temp2));
                  }
               $temp2 .= $dirsepurl;

#              while ($subleveldepth == 2) {
               $subleveldepth--;
#               print STDOUT "$remind (leveldepth : $subleveldepth) not found (root is $temp2)\n";

               $depthocc{$temp2,$subleveldepth}++ unless (($seen{$remind}++) || $subleveldepth == 2);
               $depthrac{$temp2,$depthocc{$temp2,$subleveldepth},$subleveldepth} = $remind;
#               $pos = rindex($remind,$dirsepurl,length($remind))+1;
#               $remind = substr($remind,0,$pos);

#              }

               }

           }

      }
}

}


#################################################################
####                 valeur de rowspan                    #######
#################################################################

for ($j=1;$j<=$depth{2};$j++) {
$temp = $line{$j};
#print STDOUT "ligne $temp\n\n";

for ($k=1;$k<=$depthocc{$temp,$maxdepth};$k++) {
$rowspan{$temp,$k,$maxdepth} = 1; # derniere colonne a 1
}

for ($i=$maxdepth+1;$i>=2;$i--) {

        $depthocc{$temp,$i} = 1 if ($depthocc{$temp,$i} eq '');

        $boucle = $depthocc{$temp,$i-1};

        for ($k=1;$k<=$boucle;$k++) {

        $racine = $depthrac{$temp,$k,$i-1};

        # valeur de ROWSPAN
        $rowspan{$temp,$k,$i-1} = 0;
        $rowboucle{$temp,$racine,$i-1} = 0;

        if ($racine ne '') {
        for ($m=0;$m<=$depthocc{$temp,$i};$m++) {
             $rowspan{$temp,$k,$i-1}+=$rowspan{$temp,$m,$i} if ($depthrac{$temp,$m,$i} =~ m/$racine/);
             $rowboucle{$temp,$racine,$i-1}++ if ($depthrac{$temp,$m,$i} =~ m/$racine/);
        }
        }

        $rowspan{$temp,$k,$i-1}++ if ($rowspan{$temp,$k,$i-1} == 0);
#        $rowboucle{$temp,$racine,$i-1}++ if ($rowboucle{$temp,$racine,$i-1} == 0);
#       print STDOUT "$racine $rowspan{$temp,$k,$i-1} $rowboucle{$temp,$racine,$i-1}\n";
       }
}
}

$maxrowspan = 0;
for ($j=1;$j<=$depth{2};$j++) {
$temp = $line{$j};
for ($k=1;$k<=$depthocc{$temp,2};$k++) {
$maxrowspan += $rowspan{$temp,$k,2};
}
}

} # end $url_tree

# images

$moysizeimage = $sizeimage/$nbimage if ($nbimage != 0);
$moysizeimage = $moysizeimage/1024;


#################################################################
###               computing maxima and mean                   ###
#################################################################

if ($countdoc == 0) {
print STDERR "Nothing have been scanned !\n";
print STDERR "Check \$pathserver in config.pl, it should be your html home directory\n";
exit;
}

print STDOUT "Tri pour affichage\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# computing mean data

$moyareffloat = $totaref / $countdoc;
$moyaref = int($totaref / $countdoc);

$moyimafloat = $totalima / $countdoc;
$moyima = int($totalima / $countdoc);
$moyima++ if ($moyima == 0);

$moysize = int(($totsize / $countdoc)/1024);

# tri des $topten pages avec le plus de liens

#$bouclelink = $topten unless ($linkmax < $topten);
#$bouclelink = $linkmax unless ($linkmax > ($topten-1));

$bouclelink = $topten;

$occurlink[0] = 0;

foreach $page (keys(%mostlink)) {
if ($mostlink{$page} > $occurlink[0]) {
    $occurlink[0] = $mostlink{$page};
    $bestlink[0] = $page;
}
}

$mostlink{$bestlink[0]} = 0;

for ($i=1;$i < $bouclelink;$i++) {
    $occurlink[$i] = 0;
    foreach $page (keys(%mostlink)) {
        if ($mostlink{$page} > $occurlink[$i]) {
              $occurlink[$i] = $mostlink{$page};
              $bestlink[$i] = $page;
              }
          }
$mostlink{$bestlink[$i]} = 0;
}


# tri des $topten pages avec le plus d'images

#$boucleima = $topten unless ($imamax < $topten);
#$boucleima = $imamax unless ($imamax > ($topten-1));

$boucleima = $topten;

$occurima[0] = 0;

foreach $page (keys(%mostima)) {
if ($mostima{$page} > $occurima[0]) {
    $occurima[0] = $mostima{$page};
    $bestima[0] = $page;
}
}

$mostima{$bestima[0]} = 0;

for ($i=1;$i < $boucleima;$i++) {
    $occurima[$i] = 0;
    foreach $page (keys(%mostima)) {
        if ($mostima{$page} > $occurima[$i]) {
              $occurima[$i] = $mostima{$page};
              $bestima[$i] = $page;
              }
          }
$mostima{$bestima[$i]} = 0;
}


# tri des $topten pages avec les plus lourdes

##### !!!!  sizemax est une taille de fichier....

#$bouclesize = $topten unless ($sizemax < $topten);
#$bouclesize = $sizemax unless ($sizemax > ($topten-1));

$bouclesize = $topten;

$occursize[0] = 0;

foreach $page (keys(%mostsize)) {
if ($mostsize{$page} > $occursize[0]) {
    $occursize[0] = $mostsize{$page};
    $bestsize[0] = $page;
}
}

$mostsize{$bestsize[0]} = 0;

for ($i=1;$i < $bouclesize;$i++) {
    $occursize[$i] = 0;
    foreach $page (keys(%mostsize)) {
        if ($mostsize{$page} > $occursize[$i]) {
              $occursize[$i] = $mostsize{$page};
              $bestsize[$i] = $page;
              }
          }
$mostsize{$bestsize[$i]} = 0;
}

# conversion en Megaoctets

$websize = $totsize + $sizeimage + $divsize;

$divsize /= (1024*1024);
$totsize /= (1024*1024);
$sizeimage /= (1024*1024);
$websize /= (1024*1024);

###############################################################
###         links, images and size graphs                   ###
###############################################################

################ graphs sur les liens #####################

if ($url_link == 1) {

$linkmax = $occurlink[$bouclelink-1] if ($linkmax > (2*$topten));

$it = length($linkmax)-1;
$div = 10**$it;
$factx = ($div*(int($linkmax/$div)+1))/$grad;

$factx = 1 if ($it == 0);

$it = length($ylinkmax)-1;
$div = 10**$it;
$facty = ($div*(int($ylinkmax/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=0;$i<=$linkmax;$i++) {
 $x1 = $i*$xstep/$factx;
 $x2 = ($i+1)*$xstep/$factx;
 $y2 = $ymax - ($ystep/$facty * $link{$i});
 print FLY "frect $x1,$y2,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
 print FLY "frect $x1,$y2,$x2,$ymax,0,,\n" if ($i == $moyaref);
 print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $lienfile |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

### image pour les abscisses

$xlegend = "Number of links";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<=$xmax;$i+=$xstep) {
 $valstep = $i*$factx/$xstep;
 $posx = $i - length(int($valstep))*5;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $lienfilex |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("times")/2));
 print FLY "stringup 0,0,0,5,$posy,medium,times\n";
 for ($i=$ystep;$i<=$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) * ($facty/$ystep));
 $valstep = int(($ymax - $i) / ($ystep/$facty)) if ($facty < $ystep);
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $lienfiley |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);
}

################## graphs sur les images ################################

if ($url_image == 1) {
$imamax = $occurima[$boucleima-1] if ($imamax > (2*$topten));

$it = length($imamax)-1;
$div = 10**$it;
$factx = ($div*(int($imamax/$div)+1))/$grad;

$factx = 1 if ($it == 0);

$it = length($yimamax)-1;
$div = 10**$it;
$facty = ($div*(int($yimamax/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=0;$i<$imamax;$i++) {
 $x1 = $i*$xstep/$factx;
 $x2 = ($i+1)*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $ima{$i});
 print FLY "frect $x1,$y2,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
 print FLY "frect $x1,$y2,$x2,$ymax,,,\n" if ($i == $moyima);
 print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $imafile |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

### image pour les abscisses

$xlegend = "Number of images";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<$xmax;$i+=$xstep) {
 $valstep = $i*$factx/$xstep;
 $posx = $i - length(int($valstep))*5;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $imafilex |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("times")/2));
 print FLY "stringup 0,0,0,5,$posy,medium,times\n";
 for ($i=$ystep;$i<=$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) * ($facty/$ystep));
 $valstep = int(($ymax - $i) / ($ystep/$facty)) if ($facty < $ystep);
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $imafiley |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);
}

################ graphs sur les tailles des documents #####################

if ($url_weight == 1) {
$sizemax++; # pour aller jusqu'au Ko suivant
$sizemax = int($occursize[$bouclesize-1]/1024)+1 if ($sizemax > (2*$topten));

$it = length($sizemax)-1;
$div = 10**$it;
$factx = ($div*(int($sizemax/$div)+1))/$grad;

$factx = 1 if ($it == 0);

$it = length($ysizemax)-1;
$div = 10**$it;
$facty = ($div*(int($ysizemax/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=0;$i<$sizemax;$i++) {
 $x1 = $i*$xstep/$factx;
 $x2 = ($i+1)*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $taille{$i});
 print FLY "frect $x1,$y2,$x2,$ymax,$red[2],$green[2],$blue[2]\n";
 print FLY "frect $x1,$y2,$x2,$ymax,0,0,0\n" if ($i == $moysize);
 print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $sizefile |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

### image pour les abscisses

$xlegend = "Size";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<$xmax;$i+=$xstep) {
 $valstep = $i*$factx/$xstep;
 $posx = $i - length(int($valstep))*5;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $sizefilex |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("time")/2));
 print FLY "stringup 0,0,0,5,$posy,medium,time\n";
 for ($i=$ystep;$i<=$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) / ($facty/$ystep));
 $valstep = int(($ymax - $i) / ($ystep/$facty)) if ($facty < $ystep);
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $sizefiley |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);
}

################ graphs sur les documents recents #####################

if ($url_new_doc == 1) {
for ($i=0;$i<=$modifjour;$i++) {
$max = $nbmodif{$i} if ($nbmodif{$i} > $max);
}

if ($max != 0) {

$it = length($modifjour)-1;
$div = 10**$it;
$factx = ($div*(int($modifjour/$div)+1))/$grad;

$factx = 1 if ($it == 0);

$it = length($max)-1;
$div = 10**$it;
$facty = ($div*(int($max/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=0;$i<$modifjour;$i++) {
 $x1 = $i*$xstep/$factx;
 $x2 = ($i+1)*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $nbmodif{$i});
 print FLY "frect $x1,$y2,$x2,$ymax,$red[3],$green[3],$blue[3]\n";
 print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $recentfile |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

### image pour les abscisses

$xlegend = "$modifjour days (starting $pasttoday)";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<$xmax;$i+=$xstep) {
 $valstep = $i*$factx/$xstep;
 $posx = $i - length(int($valstep))*5;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $recentfilex |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("Number of files")));
 print FLY "stringup 0,0,0,5,$posy,medium,Number of files\n";
 for ($i=$ystep;$i<=$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) / ($facty/$ystep));
 $valstep = int(($ymax - $i) / ($ystep/$facty)) if ($facty < $ystep);
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $recentfiley |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);
}
}

#########################################################################
####                                                                #####
####              FABRICATION DES PAGES HTML                        #####
####                                                                #####
#########################################################################

print STDOUT "Fabrication des pages\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

### page index

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(HOME,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$menu") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$menu\n";
&HomeDoc(*HOME, eval($Lang{$lang[$nblang]}));
close (HOME);
}

sub HomeDoc {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_HTML_files'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Stats_about_HTML_files'}</H1>\n";

print FOUT "<HR size=5>\n";
print FOUT "<CENTER><B>$today</B></CENTER>\n";
print FOUT "<HR size=5><P>\n";

print FOUT "<TABLE WIDTH=100\%>\n";
print FOUT "<TR><TD>\n";

# First cell

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TD>\n";
print FOUT "$L{'Total_number_of_html_files'}";
print FOUT "</TD><TD>";
print FOUT "$countdoc\n";
print FOUT "</TD></TR><TR><TD>";
print FOUT "$L{'Total_number_of_images'}";
print FOUT "</TD><TD>";
print FOUT "$nbimage\n";
print FOUT "</TD></TR><TR><TD>";
print FOUT "$L{'Others'}";
print FOUT "</TD><TD>";
print FOUT "$countdiv\n";
print FOUT "</TD></TR></TABLE>\n";

print FOUT "</TD><TD ROWSPAN=2 VALIGN=TOP>";
# Third cell
print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TD>\n";
print FOUT "$L{'Web_size'}";
print FOUT "</TD><TD>";
printf FOUT "%.2f",$websize;
print FOUT " $L{'Mb'}";
print FOUT "</TD></TR><TR><TD>";
print FOUT "$L{'Images'}";
print FOUT "</TD><TD>";
printf FOUT "%.2f",$sizeimage;
print FOUT " $L{'Mb'}";
print FOUT "</TD></TR><TR><TD>";
print FOUT "$L{'HTML_files'}";
print FOUT "</TD><TD>";
printf FOUT "%.2f",$totsize;
print FOUT " $L{'Mb'}";
print FOUT "</TD></TR><TR><TD>";
print FOUT "$L{'Others'}";
print FOUT "</TD><TD>";
printf FOUT "%.2f",$divsize;
print FOUT " $L{'Mb'}";
print FOUT "</TD></TR></TABLE>";

print FOUT "</TD></TR><TR><TD>";
# Second cell
print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TD>\n";
print FOUT "$L{'Total_number_of_directories'}";
print FOUT "</TD><TD>";
print FOUT "$nbdir\n";
print FOUT "</TD></TR><TR><TD>";
print FOUT "$L{'Total_number_of_links'}";
print FOUT "</TD><TD>";
print FOUT "$totaref\n";
print FOUT "</TD></TR><TR><TD>";
print FOUT "$L{'Total_number_of_images_in_files'}";
print FOUT "</TD><TD>";
print FOUT "$totalima\n";
print FOUT "</TD></TR></TABLE>\n";


print FOUT "</TD></TR></TABLE>\n";
print FOUT "<P><HR>";
print FOUT "<B>$L{'Average'} :</B><UL><P> ";
print FOUT "<LI> <I>$L{'HTML_files'}</I> : ";
print FOUT "<B>$moyaref $L{'links'}</B>";
print FOUT ", <B>$moyima $L{'images'}</B>";
print FOUT " $L{'and'} $L{'weighting'} <B>$moysize $L{'Data_unit_Kb'}</B></DT><BR>\n";
print FOUT "<LI> <I>$L{'Images'}</I> $L{'weighting'} <B>";
printf FOUT "%.1f",$moysizeimage;
print FOUT " $L{'Data_unit_Kb'}</B><BR>\n";
print FOUT "<LI> <I>$L{'HTML_pages'}</I> $L{'weighting'} <B>";
printf FOUT "%.1f",($moyimafloat*$moysizeimage+$moysize);
print FOUT " $L{'Data_unit_Kb'}</B>";
print FOUT "<LI> <I>$L{'Downloading_time'}</I> $L{'hTML_pages'} : <B>";
printf FOUT "%.f",($moyimafloat*$moysizeimage+$moysize)/($baudrate/1024);
print FOUT " $L{'seconds'}</B> ($L{'28800_modem'})\n";
print FOUT "</UL><P><HR><P>\n";

print FOUT "<CENTER>\n";
print FOUT "<TABLE WIDTH=100% CELLPADDING=5 CELLSPACING=5 BORDER=1>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

print FOUT "<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les liens, images, poids et repertoires

if ($url_link == 1) {
print FOUT "<A HREF=\"$doclien\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_links\" ALT=\"$L{'Links'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$doclien\">$L{'Links'}</A>\n";
print FOUT "</FONT>";
}
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_image == 1) {
print FOUT "<A HREF=\"$docimage\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_ima\" ALT=\"$L{'Images'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$docimage\">$L{'Images'}</A>\n";
print FOUT "</FONT>";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_weight == 1) {
print FOUT "<A HREF=\"$docsize\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_pie\" ALT=\"$L{'Weight_of_HTML_files'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$docsize\">$L{'Weight_of_HTML_files'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_directory == 1) {
print FOUT "<A HREF=\"$docrepert\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_docrepert\" ALT=\"$L{'Directories'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$docrepert\">$L{'Directories'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";

print FOUT "</TABLE>\n";

###

print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur arborescence + pages nouvelles

print FOUT "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_new_doc == 1) {
print FOUT "<A HREF=\"$new\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_new\" ALT=\"$L{'Newest_pages'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$new\">$L{'Newest_pages'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_tree == 1) {
print FOUT "<A HREF=\"$tree\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_tree\" ALT=\"$L{'Tree'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$tree\">$L{'Tree'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur liens

print FOUT "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_frame == 1) {
print FOUT "<A HREF=\"$frame\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_null\" ALT=\"$L{'Frames'}\" BORDER=0></A>\n" if ($#framed != -1);
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$frame\">$L{'Frames'}</A>\n" if ($#framed != -1);
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_doublon == 1) {
print FOUT "<A HREF=\"$doublons\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_verif\" ALT=\"$L{'Same_title'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$doublons\">$L{'Same_title'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_img_tag == 1) {
print FOUT "<A HREF=\"$imawidth\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_useless\" ALT=\"WIDTH - HEIGHT\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$imawidth\">WIDTH,&nbsp;HEIGHT</A>\n";
print FOUT "</FONT>\n";
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT "<A HREF=\"$imaalt\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_info2\" ALT=\"ALT\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$imaalt\">ALT</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_useless == 1) {
print FOUT "<A HREF=\"$useless\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_trash\" ALT=\"$L{'Useless_pages'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$useless\">$L{'Useless_pages'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_cdrom == 1) {
print FOUT "<A HREF=\"$cdrom\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_cdrom\" ALT=\"$L{'Index_pages'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$cdrom\">$L{'Index_pages'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

print FOUT "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_absolute_link == 1) {
print FOUT "<A HREF=\"$fileabsolute\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_linkabs\" ALT=\"$L{'Absolute_links'}\" BORDER=0></A>\n" if ($#absolute != 0 || $#absoluteima != 0);
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$fileabsolute\">$L{'Absolute_links'}</A>\n" if ($#absolute != 0 || $#absoluteima != 0);
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_symbolic_link == 1) {
print FOUT "<A HREF=\"$filelinksym\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_linksym\" ALT=\"$L{'Symbolic_links'}\" BORDER=0></A>\n" if ($#linkfile != 0);
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$filelinksym\">$L{'Symbolic_links'}</A>\n" if ($#linkfile != 0);
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
if ($url_bad_link == 1) {
print FOUT "<A HREF=\"$nofile\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_linkerr\" ALT=\"$L{'Bad_links'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$nofile\">$L{'Bad_links'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

print FOUT "</BODY></HTML>\n";
}

###############################################################
###         page sur l'arborescence du serveur              ###
###############################################################

if ($url_tree == 1) {
print STDOUT "Pages sur l'arborescence du serveur\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# compute the tree

open(TMPTREE,">$path$dirtmp$dirsep$tmp1") || die "Error, unable to open $path$dirtmp$dirsep$tmp1\n";
&ComputeTree(*TMPTREE);
close(TMPTREE);

# output pages

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(TREE,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$tree") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$tree\n";
&Tree(*TREE, eval($Lang{$lang[$nblang]}));
close (TREE);
}
}

sub Tree {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Server_tree'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Server_tree'}</H1>\n";

print FOUT "<P><HR>\n";
print FOUT "<CENTER><B>$today</B></CENTER><BR>\n";
print FOUT "<A HREF=\"$new\">$L{'Newest_pages'}</A> $L{'day'} $L{'by'} $L{'day'}\n";
print FOUT "<HR><P>\n";

print FOUT "<I>$L{'Legend_in_bracket'} :</I>\n<UL>\n";
print FOUT "<LI> $L{'Number_of_HTML_files'} $L{'in_whole_directory'}\n";
print FOUT "<LI> $L{'Number_of_HTML_files'} $L{'in_this_directory'}\n";
print FOUT "<LI> $L{'Newest_pages'} $L{'in_this_directory'} ($L{'less_than'} $modifjour $L{'days'})\n";
print FOUT "</UL>\n<P>\n";

print FOUT "<TABLE BORDER=1><TR>\n";

for ($i=0;$i<$maxdepth;$i++) {
print FOUT "<TH ALIGN=CENTER>$L{'Level'} $i</TH>\n";
}
print FOUT "</TR>\n";

# display the tree

open(TMPTREE,"$path$dirtmp$dirsep$tmp1") || die "Error, unable to open $path$dirtmp$dirsep$tmp1\n";
while (<TMPTREE>) {
print FOUT;
}
close(TMPTREE);

print FOUT "</TABLE>\n";
print FOUT "</BODY></HTML>\n";
}



sub ComputeTree {
	local(*FOUT) = @_;
	
print FOUT "<TR>\n<TD ROWSPAN=$maxrowspan>$dirsepurl</TD>\n";

for ($j=1;$j<=$depth{2};$j++) {
$temp = $line{$j};
#print STDOUT "$temp ligne $j\n";
$boucle = 1;
if ($j != 1) {
print FOUT "<TR>\n";
}
for ($i=2;$i<=$maxdepth;$i++) {

        $boucle += $depthocc{$temp,$i}-1;

        for ($k=1;$k<=$boucle;$k++) {

        $racine = $depthrac{$temp,$k,$i};
        $value = $rowspan{$temp,$k,$i};

        print FOUT "<TD";
        print FOUT " ROWSPAN=$value" if ($value != 1 && $value !=0);
        print FOUT ">";
        print FOUT "&nbsp;" if ($value == 0);

        if ($value != 0) {
        $temp2 = $racine;
        $pos2 = rindex($temp2,$dirsepurl,length($temp2)-2);
        $remind = substr($temp2,$pos2,length($temp2));
        print FOUT "<A HREF=\"$racine\">$remind</A>";

#        if ($i == 2) {
        $freqracdepth{$racine} = 0 if ($freqracdepth{$racine} eq '');
        $freqrac{$racine} = 0 if ($freqrac{$racine} eq '');
        $frequpdate{$racine} = 0 if ($frequpdate{$racine} eq '');

        print FOUT "<BR><I>[$freqracdepth{$racine} - ";
        print FOUT "$freqrac{$racine} - ";
        print FOUT "$frequpdate{$racine}]</I>";
#        }
        }

        print FOUT "</TD>\n";

        if ($value != 1 && $value !=0) {
#            print STDOUT "go $value : $i $j $k $temp $racine $maxdepth $boucle\n";
            &row_end(*FOUT,*L,$temp,$value,$racine,$value,$i);
            }
        }
      }

    print FOUT "</TR>\n\n";
    }
}


unlink("$path$dirtmp$dirsep$tmp1");


###############################################################
###             page sur les repertoires                   ####
###############################################################

if ($url_directory == 1) {
print STDOUT "Pages sur les directories\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$freqsizeglob{$tri} = $websize*1024*1024;
$freqracglob{$tri} = $countdoc+$nbimage+$countdiv;

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(REPERT,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$docrepert") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$docrepert\n";
&DocRepert(*REPERT, eval($Lang{$lang[$nblang]}));
close (REPERT);
}
}

sub DocRepert {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} $L{'about'} $repertunique $L{'directories'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Stats'} $L{'about'} $repertunique $L{'directories'}</H1>\n";

print FOUT "<P><HR><P>\n";

print FOUT "<CENTER><TABLE WIDTH=100% BORDER=1><TR>\n";
print FOUT "<TH ROWSPAN=2>$L{'Directories'}</TH>\n";
print FOUT "<TH COLSPAN=4 BGCOLOR=\"#DDDD00\">$L{'global'}</TH>\n";
print FOUT "<TH COLSPAN=4 BGCOLOR=\"#00DDDD\">$L{'Total'}</TH>\n";
print FOUT "<TH COLSPAN=2 BGCOLOR=\"#00DD00\">$L{'HTML_files'}</TH>\n";
print FOUT "<TH COLSPAN=2 BGCOLOR=\"#DD00DD\">$L{'Images'}</TH>\n";
print FOUT "<TH COLSPAN=2 BGCOLOR=\"#DD0000\">$L{'Misc'}</TH>\n";
print FOUT "</TR><TR>\n";

print FOUT "<TH>$L{'Number'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH>$L{'Kb'}</TH>\n";
print FOUT "<TH>%</TH>\n";

print FOUT "<TH>$L{'Number'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH>$L{'Kb'}</TH>\n";
print FOUT "<TH>%</TH>\n";

print FOUT "<TH>$L{'Number'}</TH>\n";
print FOUT "<TH>$L{'Kb'}</TH>\n";

print FOUT "<TH>$L{'Number'}</TH>\n";
print FOUT "<TH>$L{'Kb'}</TH>\n";

print FOUT "<TH>$L{'Number'}</TH>\n";
print FOUT "<TH>$L{'Kb'}</TH>\n";

print FOUT "</TR><TR>\n";

foreach $racine (sort keys(%freqrac)) {

$tmp = 0;
$pos = length($racine);
while (($pos = rindex($racine,$dirsepurl,$pos)) >= 0) {
	$tmp++;
	$pos--;
	}

$tmp -= $tmpdirsep;


print FOUT "<TR>\n<TD ";
print FOUT "BGCOLOR=\"#D0D0D0\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#909090\"" if ($tmp == 1);     
print FOUT "><I><A HREF=\"$racine\">$racine</A></I>";
print FOUT "</TD>\n";

$p1 = 100*$freqsizeglob{$racine}/($websize*1024*1024);
$p2 = 100*$freqracglob{$racine}/($countdoc+$nbimage+$countdiv);

print FOUT "<TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#DDDD00\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#999900\"" if ($tmp == 1);
print FOUT ">$freqracglob{$racine}";
print FOUT "</TD><TD ALIGN=CENTER ";
print FOUT "BGCOLOR=\"#EEEE00\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#888800\"" if ($tmp == 1);
printf FOUT ">%.1f",$p2;
print FOUT "</TD><TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#DDDD00\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#999900\"" if ($tmp == 1);
printf FOUT ">%.1f",($freqsizeglob{$racine}/1024);
print FOUT "</TD><TD ALIGN=CENTER ";
print FOUT "BGCOLOR=\"#EEEE00\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#888800\"" if ($tmp == 1);
printf FOUT ">%.1f",$p1;
print FOUT "</TD>\n";

$p1 = 100*$freqsizeall{$racine}/($websize*1024*1024);
$p2 = 100*$freqrac{$racine}/($countdoc+$nbimage+$countdiv);

print FOUT "<TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#00DDDD\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#009999\"" if ($tmp == 1);
print FOUT ">$freqrac{$racine}";
print FOUT "</TD><TD ALIGN=CENTER ";
print FOUT "BGCOLOR=\"#00EEEE\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#008888\"" if ($tmp == 1);
printf FOUT ">%.1f",$p2;
print FOUT "</TD><TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#00DDDD\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#009999\"" if ($tmp == 1);
printf FOUT ">%.1f",($freqsizeall{$racine}/1024);
print FOUT "</TD><TD ALIGN=CENTER ";
print FOUT "BGCOLOR=\"#00EEEE\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#008888\"" if ($tmp == 1);
printf FOUT ">%.1f",$p1;
print FOUT "</TD>\n";

$freqsizetml{$racine} = 0 if ($freqsizetml{$racine} eq '');
$freqrachtml{$racine} = 0 if ($freqrachtml{$racine} eq '');

print FOUT "<TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#00DD00\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#009900\"" if ($tmp == 1);
print FOUT ">$freqrachtml{$racine}";
print FOUT "</TD>";
print FOUT "<TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#00DD00\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#009900\"" if ($tmp == 1);
printf FOUT ">%.1f",($freqsizehtml{$racine}/1024);
print FOUT "</TD>\n";

$freqsizeima{$racine} = 0 if ($freqsizeima{$racine} eq '');
$freqracima{$racine} = 0 if ($freqracima{$racine} eq '');

print FOUT "<TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#DD00DD\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#990099\"" if ($tmp == 1);
print FOUT ">$freqracima{$racine}";
print FOUT "</TD>";
print FOUT "<TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#DD00DD\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#990099\"" if ($tmp == 1);
printf FOUT ">%.1f",($freqsizeima{$racine}/1024);
print FOUT "</TD>\n";

$freqsizediv{$racine} = 0 if ($freqsizediv{$racine} eq '');
$freqracdiv{$racine} = 0 if ($freqracdiv{$racine} eq '');

print FOUT "<TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#DD0000\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#990000\"" if ($tmp == 1);
print FOUT ">$freqracdiv{$racine}";
print FOUT "</TD>";
print FOUT "<TD ALIGN=RIGHT ";
print FOUT "BGCOLOR=\"#DD0000\"" if ($tmp == 2);
print FOUT "BGCOLOR=\"#990000\"" if ($tmp == 1);
printf FOUT ">%.1f",($freqsizediv{$racine}/1024);
print FOUT "</TD></TR>\n";

#$freqrac{$racine} = 0 if ($freqrac{$racine} eq '');
#$p = 100*$freqrac{$racine}/$countdoc;

#print FOUT "</TD>\n<TD ALIGN=RIGHT>";
#print FOUT "$freqrac{$racine}";
#print FOUT "</TD>\n<TD ALIGN=RIGHT>";
#printf FOUT "%.1f %",$p;

#$frequpdate{$racine} = 0 if ($frequpdate{$racine} eq '');
#$p = 100*$frequpdate{$racine}/$countdoc;

#print FOUT "</TD>\n<TD ALIGN=RIGHT>";
#print FOUT "$frequpdate{$racine}";
#print FOUT "</TD>\n<TD ALIGN=RIGHT>";
#printf FOUT "%.1f %",$p;

#print FOUT "</TD></TR>\n";
}

print FOUT "</TABLE></CENTER>\n";
print FOUT "</BODY></HTML>\n";
}


###############################################################
###        page sur le poids des pages HTML                ###
###############################################################

if ($url_weight == 1) {
print STDOUT "Pages sur le poids des pages HTML\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(SIZE,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$docsize") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$docsize\n";
&DocSize(*SIZE, eval($Lang{$lang[$nblang]}));
close (SIZE);
}
}

sub DocSize {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_HTML_files_weight'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Stats_about_HTML_files_weight'}</H1>\n";

print FOUT "<P><HR><P>\n";
#print FOUT "<I>$L{'Only_HTML_files_itself'}</I>\n";
#print FOUT "<P><HR><P>\n";

print FOUT "<CENTER><TABLE BORDER=0 cellpadding=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linksizefiley\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linksizefile\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linksizefilex\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE></CENTER>\n";
print FOUT "<CENTER><B>$L{'Weight_HTML_files_histogram'}</B><BR>";
print FOUT "<I>($L{'The_Top'} $topten $L{'most_weighty_pages'} $L{'not_included'})</I><P>\n" if ($sizemax > (2*$topten));
print FOUT "<I>$L{'Average_is_black'}</I>\n";

print FOUT "</I></CENTER><P><I>$L{'The_Top'} $topten $L{'most_weighty_pages'}</I>\n";
print FOUT "<UL>\n";
for ($i=0;$i < $bouclesize;$i++) {
 print FOUT "<A HREF=\"$bestsize[$i]\" TARGET=\"_top\">$urlconv{$bestsize[$i]}</A> : <B>$occursize[$i]</B> $L{'Data_unit_octet'}<BR>\n" if ($occursize[$i] != 0);
}
print FOUT "</UL>\n";
print FOUT "\n<BR>";
print FOUT "</BODY></HTML>\n";
}


###############################################################
###               page sur les liens                        ###
###############################################################

if ($url_link == 1) {
print STDOUT "Pages sur les liens\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(LIEN,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$doclien") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$doclien\n";
&DocLien(*LIEN, eval($Lang{$lang[$nblang]}));
close (LIEN);
}
}

sub DocLien {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_internal_links'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Stats_about_internal_links'}</H1>\n";

print FOUT "<P><HR><P>\n";

print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linklienfiley\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linklienfile\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linklienfilex\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE></CENTER>\n";
print FOUT "<CENTER><B>$L{'Links_histogram'}</B><BR>";
print FOUT "<I>($L{'The_Top'} $topten $L{'most_linky_pages'} $L{'not_included'})</I><P>\n" if ($linkmax > (2*$topten));
print FOUT "<I>$L{'Average_is_black'}</I>\n";

print FOUT "</CENTER><P><I>$L{'The_Top'} $topten $L{'most_linky_pages'}</I>\n";
print FOUT "<UL>\n";
for ($i=0;$i < $bouclelink;$i++) {
print FOUT "<A HREF=\"$bestlink[$i]\" TARGET=\"_top\">$urlconv{$bestlink[$i]}</A> : <B>$occurlink[$i]</B> $L{'links'}<BR>\n" if ($occurlink[$i] != 0);
}
print FOUT "</UL>\n";
print FOUT "</BODY></HTML>";
}

###############################################################
###            page sur les images                          ###
###############################################################

if ($url_image == 1) {
print STDOUT "Pages sur les images\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(IMA,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$docimage") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$docimage\n";
&DocImage(*IMA, eval($Lang{$lang[$nblang]}));
close (IMA);
}
}

sub DocImage {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_images'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Stats_about_images'}</H1>\n";

print FOUT "<P><HR><P>\n";

print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkimafiley\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkimafile\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkimafilex\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE></CENTER>\n";
print FOUT "<CENTER><B>$L{'Images_histogram'}</B><BR>";
print FOUT "<I>($L{'The_Top'} $topten $L{'most_graphic_pages'} $L{'not_included'})</I><BR>\n" if ($imamax > (2*$topten));
print FOUT "<I>$L{'Average_is_black'}</I>\n";

print FOUT "</CENTER><P><I>$L{'The_Top'} $topten $L{'most_graphic_pages'}</I>\n";
print FOUT "<UL>\n";
for ($i=0;$i < $boucleima;$i++) {
 print FOUT "<A HREF=\"$bestima[$i]\" TARGET=\"_top\">$urlconv{$bestima[$i]}</A>: <B>$occurima[$i]</B> $L{'images'}<BR>\n" if ($occurima[$i] != 0);
}
print FOUT "</UL>\n";

print FOUT "</BODY></HTML>";
}

###############################################################
###            pages les plus recentes                      ###
###############################################################

if ($url_new_doc == 1) {
print STDOUT "Pages les plus recentes\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(NEW,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$new") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$new\n";
&DocNew(*NEW, eval($Lang{$lang[$nblang]}));
close (NEW);
}
}

sub DocNew {
	local(*FOUT,*L) = @_;
	
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Newest_pages'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Newest_pages'} $L{'since'} $modifjour $L{'days'}</H1>\n";
print FOUT "<P><HR>\n";
print FOUT "<CENTER><B>$today</B></CENTER>\n";
print FOUT "<HR><P>\n";

if ($max != 0) {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkrecentfiley\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkrecentfile\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkrecentfilex\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE></CENTER>\n";
print FOUT "<CENTER><B>$L{'Newest_pages_histogram'}</B></CENTER><P>\n";

print FOUT "<P><HR><P>\n";

for ($j=0;$j<=$modifjour;$j++) {
    $plusi = $j+1;

    $bouclemodif = $nbmodif{$j} if ($nbmodif{$j} < $topten);
    $bouclemodif = $topten if ($nbmodif{$j} > $topten);

    if ($bouclemodif ne '') {
        print FOUT "<UL><B>$bouclemodif $L{'hTML_pages'} $L{'modified_less_than'} $plusi $L{'days'} : </B><UL><BR>\n";
        for ($i=1;$i<=$bouclemodif;$i++) {
            print FOUT "<A HREF=\"$modif{$j,$i}\" TARGET=\"_top\">$urlconv{$modif{$j,$i}}</A><BR>\n";
        }
        print FOUT "</UL></UL><P>\n";
    }
}
print FOUT "<P><HR><P>\n";
print FOUT "<I>$L{'Only_first'} $topten $L{'hTML_pages'} $L{'are_printed'}</I>\n" if ($bouclemodif == $topten);
print FOUT "<P><HR><P>\n" if ($bouclemodif == $topten);

} else {
print FOUT "<CENTER><P><BR><B>$L{'No_modification'} $L{'since'} $modifjour $L{'days'} !</CENTER></b>\n";
}

print FOUT "</BODY></HTML>";
}

###############################################################
###                  compatibilite cdrom                    ###
###############################################################

if ($url_cdrom == 1) {
print STDOUT "Transposition pour cdrom\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(CDROM,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$cdrom") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$cdrom\n";
&Cdrom(*CDROM, eval($Lang{$lang[$nblang]}));
close (CDROM);
}
}

sub Cdrom {
    local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Index_pages'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Index_pages'}</H1>\n";
print FOUT "<P><HR>\n";
print FOUT "<CENTER><B>$today</B></CENTER>\n";
print FOUT "<HR><P>\n";

print FOUT "$L{'You_should_add'} $defaulthomepage $L{'files_stored_locally_CD-ROM'}\n";
print FOUT "<P>\n";

#for ($j=0;$j<=$#cdrom;$j++) {
#print FOUT "$cdrom[$j]<BR>\n";
#}
                                                        
$j = 0;
$cdrombis[0] = $cdrom[0];
print FOUT "<B>$cdrombis[0]</B>\n<UL><I>\n";
for ($k=1;$k<=$noindex{$cdrombis[$j]};$k++) {
	$filecdrom{$cdrombis[$j],$k} =~ s/$defaulthomepage//;
       print FOUT "<LI>$filecdrom{$cdrombis[$j],$k}\n";
}
print FOUT "</I></UL>\n";

for ($i=1;$i<=($#cdrom);$i++) {
     if ($cdrom[$i] ne $cdrom[$i-1]) {
        $cdrombis[$j] = $cdrom[$i];
        print FOUT "<B>$cdrombis[$j]</B>\n<br><UL><I>\n";
        for ($k=1;$k<=$noindex{$cdrombis[$j]};$k++) {
	$filecdrom{$cdrombis[$j],$k} =~ s/$defaulthomepage//;
            print FOUT "<LI>$filecdrom{$cdrombis[$j],$k}\n";
            }
        print FOUT "</I></UL>\n";
        $j++;
     }
}

print FOUT "<P>\n";	

print FOUT "</BODY></HTML>";
}

undef @cdrom;

###############################################################
###                  pages inutiles                         ###
###############################################################

if ($url_useless == 1) {
print STDOUT "Pages inutiles\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#for ($i=0;$i<=$#imafind;$i++) {
#print "$i - $imafind[$i]\n";
#}

#print "---------------------\n";

#for ($i=0;$i<=$#imause;$i++) {
#print "$i - $imause[$i]\n";
#}




grep($temp{$_}++,@imause);
@imafind = grep(!$temp{$_},@imafind);

#print "@imafind\n";

grep($temp{$_}++,@pageuse);
@pagefind = grep(!$temp{$_},@pagefind);

for ($nblang=0;$nblang<=$#lang;$nblang++) {

open(USELESS,">$path$lang[$nblang]$dirsep$dirdocument$dirsep$useless") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdocument$dirsep$useless\n";
&DocUseless(*USELESS, eval($Lang{$lang[$nblang]}));
close (USELESS);
}
}

sub DocUseless {
    local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Useless_pages'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-url.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Useless_pages'}</H1>\n";
print FOUT "<P><HR>\n";
print FOUT "<CENTER><B>$today</B></CENTER>\n";
print FOUT "<HR><P>\n";

print FOUT "$#pagefind $L{'pages_found_on_server'}<BR>\n";
print FOUT "$#pageuse $L{'different_references_found'}<BR>\n";

print FOUT "<P>\n";
print FOUT "$L{'Pages_never_used'} ($L{'no_reference_found'}) :\n<BR>";

for ($j=0;$j<=$#pagefind;$j++) {
#	$pagefind[$j] =~ s/$pathserver$dirsep// if ($type_serveur == 0);
#	$pagefind[$j] =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);
	$pagefind[$j] =~ s/$pathserver2//;
	print FOUT "$pagefind[$j]<BR>\n";
	}

print FOUT "<HR><P>\n";

print FOUT "$#imafind $L{'images_found_on_server'}<BR>\n";
print FOUT "$#imause $L{'different_references_found'} <BR>\n";

print FOUT "<P>\n";
print FOUT "$L{'Images_never_used'} ($L{'no_reference_found'}) :\n<BR>";


for ($j=0;$j<=$#imafind;$j++) {
#	$imafind[$j] =~ s/$pathserver$dirsep// if ($type_serveur == 0);
#	$imafind[$j] =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);	
	$imafind[$j] =~ s/$pathserver2//;
	print FOUT "$imafind[$j]<BR>\n";
	}
	
print FOUT "<P>\n";
	

print FOUT "</BODY></HTML>";
}

$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
($hour,$minute,$second) = split(/:/,$hourdate);

# calculer le temps mis pour le calcul
$endrun = "$hour:$minute:$second";

($min,$sec) = &timetaken($startrun,$endrun);

$endtime = time();
#printf STDOUT "Computing took %d CPU secondes\n",$endtime - $starttime;
#print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

print STDOUT "Real time took $min min $sec sec\n\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$today =~ s/ /\//g;

open(FILE,">>$history");
printf FILE "cron-url\t%s\t%s\t%s\t%d:%d\n",$today,$startrun,$endrun,$min,$sec;
close(FILE);

#################################################################
####         subroutine for scanning each HTML page       #######
#################################################################

sub dodir {
    local($dir,$nlink,$symlinkdir) = @_;
    local($dev,$ino,$mode,$subcount);

    ($dev,$ino,$mode,$nlink) = stat('.') unless $nlink;

    return if (!(opendir(SOURCEDIR,$dir)));
    opendir(SOURCEDIR,$dir) || die "Couldn't open directory $dir !!\n";
    local(@filenames) = readdir(SOURCEDIR);
    closedir(SOURCEDIR);

    if ($nlink == 2 && $dirsep eq '/') {
#    if (($nlink == 0 && $dirsep eq '.') || ($nlink == 2 && $dirsep eq '/')) {    
#    if ($nlink == 2) {    
        for (@filenames) {
           next if $_ eq '.';
           next if $_ eq '..';
	   next if ($_ =~ /^#/);
	   next if ($_ =~ /^_/ && $type_serveur == 1);
	   $tmp = $_;
	   $tmp =~ s/\./\// if ($dirsep eq '.'); # acorn
#           $name = "$dir$dirsep$_";
           $name = "$dir$dirsep$tmp";	   

           push(@linkfile,$name) if (-l $name);
#           next if (-l $name);
           next if ($name =~ /$excluderepert/i  && $excluderepert ne '');
	   $filepicwidth = 0;

           $nbdir++ unless $seen{$dir}++;
	   $fl = 0;
           ($size)= (stat("$name")) [7];
	   
           if (m/$searchima/i && ($name !~ /$pathserver$dirsep$packagename$dirsep/o)) {
               $nbimage++;
               $sizeimage += $size;
               push(@imafind,$name) unless $seen{$name}++;
      	       print TMP4 "$name $size\n";               
               $fl = 1;
               }

           if (m/$search/i) {
               $fl = 1;
               ($size,$mtime)= (stat("$_")) [7,9];
               $nblink = 0;
               $nbima = 0;
               $countdoc++;
               if ($name !~ /$pathserver$dirsep$packagename$dirsep/) {

               push(@pagefind,$name) unless $seen{$name}++;
		}
		
		print "\nLoading $name\n" if ($debug == 1);
		$data = '';
	       	$nameshort = $name;
	       	$nameshort =~ s/$pathserver$dirsep// if ($type_serveur == 0);
	       	$nameshort =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);
#		$nameshort =~ s/$pathserver2//;

		if (!(-r $name)) {
                print STDERR  "Can't open file $name\n";
	    } else {			 
		open(FILE,$name);
		while (<FILE>) {

		if (m/<!--/) {
		$out = 1;
		$data .= $`;
		}
		
		if (m/-->/) {
		$out = 0;
		$data .= $';
		next;
		}
		
        	next if ($out == 1);
		
		$data .= " " if ((!(/<.+"(.)+".+>/)) && ($1 eq ''));		
		$data .= $_;
		}
		close (FILE);
	    }
		$data =~ s/\s*\^M\s*/ /g;
		$data =~ s/\n//g;
		$data =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	       $data = &accent2html($data);

               ##### TITLE #####

		if ($data =~ m/<TITLE>([&;~:' \(\),"&@*#0-9a-z_\!\?\-\/\s.]+)<\/TITLE>/i) {
                $tmp = $1;

#		print OUTFILE "$name \"$tmp\" " if ($tmp ne '');
#		print OUTFILE "$name \"$name\" " if ($tmp eq '');

                $tmp =~ s/"/'/g;
		print "1 - Title $tmp pour $nameshort ....\n" if ($debug == 1);

		push(@doublon,$1) if ($seen{$1}++);
		$dou{$1}++;
		$filedoublon{$1,$dou{$1}} = $nameshort;

		print OUTFILE "$name \"$tmp" if ($tmp ne '');
		print OUTFILE "$name \"$name" if ($tmp eq '');
		print OUTFILE " (symlink)" if ($name =~ /$symlinkdir/);
		print OUTFILE "\" ";

		} else {
	               print OUTFILE "$name \"$name\" ";
		       push(@notitle,$nameshort) if ($name ne "$dirdocument$notitle");
		       }		

	       print OUTFILE "$nblink $nbima $size $mtime\n" if ($name =~ /$pathserver$dirsep$packagename$dirsep/o);

	       # inutile de checker le logiciel de stats !
	       if ($name !~ /$pathserver$dirsep$packagename$dirsep/o) {
	        
               ##### BACKGROUND #####

		if ($data =~ m/<BODY.*BACKGROUND="([&;~#: 0-9a-z_\-\/.]*)".*>/i) {
		print "1 - Background : $1 ($nameshort)\n" if ($debug == 1);

		&background($1,$name);
		}
		
               ##### FORM ACTION #####

	        while ($data =~ m/<FORM([",a-z=\s\d]+)ACTION="([;~#&:*0-9a-z_\?\-\/.]+)"(["a-z=\s\d]*)>/i) {

		   	print "1 - Form action : $1 ($nameshort)\n" if ($debug == 1);
			$temp3 = $2;
                       if (index($2,'/') == 0) {
                            $temp1 = $2;
			    if ($temp1 =~ /cgi-bin/i) {
				$temp2 = $temp1;
				$temp2 =~ s/\/cgi-bin\//$cgipath/;
				$temp2 =~ s/\?.*//;				
                                if (!(-e $temp2)) {
				   push(@nocgibin,$nameshort);
				   $nocgi{$nameshort}++;
				   $filecgimiss{$nameshort,$nocgi{$nameshort}} = $temp2;
#				   next;
			         }
			     }
			 }
			$temp3 =~ s/\?/\\?/g;
			$temp3 =~ s/\*/\\*/g;			
	 		$data =~ s/"$temp3"//i;			 
		   }

               ##### LINKS #####

		while ($data =~ /<[A|AREA]([",a-z=\s\d]+)HREF="([&;~: &*#0-9a-z_\?\-\/.]+)"([\(\)!';",_a-z=\s\d]*)>/i || $data =~ /<FRAME(["a-z=\s\d]+)SRC="([&;~#: 0-9a-z_\-\/.]+)"([\[\]#"a-z=\s\d]*)>/i) {
		print "1 - Liens : $2 ($nameshort)\n" if ($debug == 1);

		$uu = $2;					
		$delstring = $&;
		$delstring =~ s/\?/\\?/g;
                $delstring =~ s/\*/\\*/g;                	
                $delstring =~ s/\(/\\(/g;
                $delstring =~ s/\)/\\)/g;

		&html($uu,$name);
#		$data =~ s/$&//i;
		$data =~ s/$delstring//i;
		}	

               ##### FRAMES #####

		if ($data =~ /<FRAMESET/i) {
        	      push(@framed,$nameshort);
		  print FILEFRAME "$nameshort\n";
		}

               ##### IMAGES #####

		while ($data =~ /<IMG([#"a-z=\s\d]+)SRC="([&;~ :0-9a-z_\-\/.]+)"([\!\?\[\-\]#"a-z=\s\d]*)>/i) {
	   	print "1 - Img src : $2 ($nameshort)\n" if ($debug == 1);
        
                $nbima++;
		$searchwidth = $1.$3;	
	 	$filepicwidth = &ima($2,$searchima,$name);
		$data =~ s/<IMG$1SRC="$2"([\!\?\[\-\]#"a-z=\s\d]*)>//i;
		}		   	

        print OUTFILE "$nblink $nbima $size $mtime\n";

	# fin de la boucle sur $packagename
	}

	print TMPWIDTH "</TABLE></UL><P>\n" if ($filepicwidth != 0);
	
        $totaref += $nblink;
        $totalima += $nbima;
        $totsize += $size;
	# fin de la boucle sur /$search/
	}

	if ($fl == 0 && (-f $name)) {
		$divsize += $size;
		$countdiv++;
		print TMP4 "$name $size\n";	
	   }
	       
		   	
	}
    }
    else {

       $subcount = $nlink-2 if ($dirsep eq "/");
        for (@filenames) {
           next if $_ eq '.';
           next if $_ eq '..';
	   next if ($_ =~ /^#/);           
	   next if ($_ =~ /^_/ && $type_serveur == 1);           
	   $tmp = $_;
	   $tmp =~ s/\./\// if ($dirsep eq '.'); # acorn
#           $name = "$dir$dirsep$_";
           $name = "$dir$dirsep$tmp";	   

           push(@linkfile,$name) if (-l $name);
#           next if (-l $name);
           next if ($name =~ /$excluderepert/i  && $excluderepert ne '');
	   $filepicwidth = 0;

           $nbdir++ unless $seen{$dir}++;
           ($size)= (stat("$name")) [7];
           $fl = 0;
           
           if (m/$searchima/i && ($name !~ /$pathserver$dirsep$packagename$dirsep/o)) {
#           ($size)= (stat("$_")) [7];
           $sizeimage += $size;
           $nbimage++;
           push(@imafind,$name) unless $seen{$name}++;
      	   print TMP4 "$name $size\n";
           $fl = 1;
           }

           if (m/$search/i) {
           ($size,$mtime)= (stat("$_")) [7,9];
               $fl = 1;
               $nblink = 0;
               $nbima = 0;
               $countdoc++;
               if ($name !~ /$pathserver$dirsep$packagename$dirsep/) {

               push(@pagefind,$name) unless $seen{$name}++;
		}
		
	       $nameshort = $name;
	       $nameshort =~ s/$pathserver$dirsep// if ($type_serveur == 0);
	       $nameshort =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);	       
#		$nameshort =~ s/$pathserver2//;
		$data = '';
		print "\n2 - Loading $name\n" if ($debug == 1);
		if (!(-r $name)) {
                print STDERR  "Can't open file $name\n";
	    } else {
		open(FILE,$name);
		while (<FILE>) {
		if (m/<!--/) {
		$out = 1;
		$data .= $`;
		}
		
		if (m/-->/) {
		$out = 0;
		$data .= $';
		next;
		}

        	next if ($out == 1);		
		
		$data .= " " if ((!(/<.+"(.)+".+>/)) && ($1 eq ''));		
		$data .= $_;
		}
		close (FILE);
	    }
		$data =~ s/\s*\^M\s*/ /g;		
		$data =~ s/\n//g;
		$data =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	       $data = &accent2html($data);
		
                ##### TITLE #####

		if ($data =~ m/<TITLE>([&;~:' \(\),"&@*#0-9a-z_\!\?\-\/\s.]+)<\/TITLE>/i) {

                $tmp = $1;
                $tmp =~ s/"/'/g;
		print "2 - Title $tmp pour $nameshort ....\n" if ($debug == 1);

		push(@doublon,$1) if ($seen{$1}++);
		$dou{$1}++;                                      # utile ?
		$filedoublon{$1,$dou{$1}} = $nameshort;          # utile ? pas de test ?

		print OUTFILE "$name \"$tmp" if ($tmp ne '');
		print OUTFILE "$name \"$name" if ($tmp eq '');
		print OUTFILE " (symlink)" if ($name =~ /$symlinkdir/);
		print OUTFILE "\" ";

		} else {
	              print OUTFILE "$name \"$name\" ";
        	      push(@notitle,$nameshort) if ($name ne "$dirdocument$notitle");
        	      }

       	       print OUTFILE "$nblink $nbima $size $mtime\n" if ($name =~ /$pathserver$dirsep$packagename$dirsep/o);

	       # inutile de checker le logiciel de stats !
	       if ($name !~ /$pathserver$dirsep$packagename$dirsep/o) {

               ##### BACKGROUND #####

		if ($data =~ m/<BODY.*BACKGROUND="([&;~#: 0-9a-z_\-\/.]*)".*>/i) {
		print "2 - Background : $1 ($nameshort)\n" if ($debug == 1);

		&background($1,$name);
		}
		
               ##### FORM ACTION #####

	        while ($data =~ m/<FORM([",a-z=\s\d]+)ACTION="([;~#&:*0-9a-z_\?\-\/.]+)"(["a-z=\s\d]*)>/i) {
			
		   	print "2 - Form action : $1 - $2  ($nameshort)\n" if ($debug == 1);			 

		   	$temp3 = $2;

                       if (index($2,'/') == 0) {
                            $temp1 = $2;
			    if ($temp1 =~ /cgi-bin/i) {
				$temp2 = $temp1;
				$temp2 =~ s/\/cgi-bin\//$cgipath/;
				$temp2 =~ s/\?.*//;
                                if (!(-e $temp2)) {
				   push(@nocgibin,$nameshort);
				   $nocgi{$nameshort}++;
				   $filecgimiss{$nameshort,$nocgi{$nameshort}} = $temp2;
#				   next;
			         }
			     }
			 }
			$temp3 =~ s/\?/\\?/g;
			$temp3 =~ s/\*/\\*/g;			
	 		$data =~ s/"$temp3"//i;
		   }

               ##### LINKS #####

		while ($data =~ /<[A|AREA]([",a-z=\s\d]+)HREF="([&;~: &*#0-9a-z_\?\-\/.]+)"([\(\)!';",_a-z=\s\d]*)>/i || $data =~ /<FRAME(["a-z=\s\d]+)SRC="([&;~#: 0-9a-z_\-\/.]+)"([\[\]#"a-z=\s\d]*)>/i) {

		print "2 - Liens : $2 ($nameshort)\n" if ($debug == 1);
		$uu = $2;
                $delstring = $&;
                $delstring =~ s/\?/\\?/g;
                $delstring =~ s/\*/\\*/g;
                $delstring =~ s/\(/\\(/g;
                $delstring =~ s/\)/\\)/g;

		&html($uu,$name);
#		$data =~ s/<[A|AREA]$1HREF="$2"$3>//i;
		$data =~ s/$delstring//i;
		}	

               ##### FRAMES #####

		if ($data =~ /<FRAMESET/i) {
        	      push(@framed,$nameshort);
		  print FILEFRAME "$nameshort\n";
		}
				
               ##### IMAGES #####

		while ($data =~ /<IMG([#"a-z=\s\d]+)SRC="([&;~: 0-9a-z_\-\/.]+)"([\!\?\[\-\]#"a-z=\s\d]*)>/i) {
	   	print "2 - Img src : $2 ($nameshort)\n" if ($debug == 1);
        
                $nbima++;
		$searchwidth = $1.$3;	
	 	$filepicwidth = &ima($2,$searchima,$name);
		$data =~ s/<IMG$1SRC="$2"([\!\?\[\-\]#"a-z=\s\d]*)>//i;
		}		   			

	print OUTFILE "$nblink $nbima $size $mtime\n";

	# fin de la boucle sur $packagename
	}		

	print TMPWIDTH "</TABLE></UL><P>\n" if ($filepicwidth != 0);

        $totaref += $nblink;
        $totalima += $nbima;
        $totsize += $size;

	# fin de la boucle sur /$search/
	}

	if ($fl == 0 && (-f $name)) {
		$divsize += $size;
		$countdiv++;
		print TMP4 "$name $size\n";
	              }
		   	
        next if (($subcount == 0) && ($dirsep eq "/"));

	# Allow to follow symbolic link
          ($dev,$ino,$mode,$nlink) = lstat($_); # if ($dirsep eq '/');

#	   next if ((!(-d $_)) && (!(-l $_)));
	   next if (!(-d $_));
	   $symlinkdir = $name if (-l $_);
	   
           chdir $_ || die "CC - Can't cd to $name";
           &dodir($name,$nlink,$symlinkdir);

           chdir '..';
           --$subcount;
}
}
}

#################################################################
####         subroutine to compute the tree                 #####
#################################################################

sub row_end {
    local(*FOUT,*L,$temp,$value,$racine,$oldvalue,$coi) = @_;
    local($boucle2,$affrac,$it,$loop,$z,$val);

        $boucle2 = $rowboucle{$temp,$racine,$coi};

        $coi++;

        for ($it=1;$it<=$boucle2;$it++) {

        $affrac = $racine;

        for ($loop=$coi;$loop<=$maxdepth;$loop++) {

        $match = 0;
        if ($racine ne '') {
             for ($z=1;$z<=$maxrowspan;$z++) {
                if ($depthrac{$temp,$z,$loop} =~ m/$affrac/) {
                   $affrac = $depthrac{$temp,$z,$loop};
                   $match = 1;
                   last;
                   }
              }
           }

        $val = $rowspan{$temp,$z,$loop};
        $val = 0 if ($match == 0);

        $temp2 = $affrac;
        $pos2 = rindex($temp2,$dirsepurl,length($temp2)-2);
        $remind = substr($temp2,$pos2,length($temp2));

        print FOUT "<TD";
        print FOUT " ROWSPAN=$val" if ($val != 1 && $val !=0);
        print FOUT ">";
        print FOUT "&nbsp;" if ($val == 0);

        if ($val != 0) {
        $freqracdepth{$affrac} = 0 if ($freqracdepth{$affrac} eq '');
        $freqrac{$affrac} = 0 if ($freqrac{$affrac} eq '');
        $frequpdate{$affrac} = 0 if ($frequpdate{$affrac} eq '');

        print FOUT "<A HREF=\"$affrac\">$remind</A>";

        print FOUT "<BR><I>[$freqracdepth{$affrac} - ";
        print FOUT "$freqrac{$affrac} - ";
        print FOUT "$frequpdate{$affrac}]</I>";
        }

        print FOUT "</TD>\n";

        $depthrac{$temp,$z,$loop} = '' if ($match == 1);

        if ($val != 1 && $val !=0) {
           &row_end(*FOUT,*L,$temp,$val,$affrac,$val,$coi);
           $loop = $maxdepth;
           $boucle2 =$rowboucle{$temp,$racine,$coi-1};
           }

        }

        if ($it != $boucle2) {
        print FOUT "</TR>\n\n<TR>\n";
        }

        }
        $i = $maxdepth;
}


#################################################################
####         subroutine to check BACKGROUND link            #####
#################################################################

sub background {
	local($1,$name) = @_;
	
		# lien relatif sans remontee de repertoire

		$linkfile = $1;
		$pospoint = rindex($name,$dirsep,length($name));
		$name2 = substr($name,0,$pospoint+1);
                            
               	if (index($1,'.') != 0) {
                           $temp1 = $name2.$1;
	
			    # lien absolu

                            if (index($1,'/') == 0) {
                               $temp1 = $pathserver.$1;
                               $temp1 =~ s/~(\w+)\///;
			       }
                            }

		# lien relatif commencant par un ..

                if (index($1,'.') == 0) {
                            $temp1 = $1;
                            while ($temp1 =~ m/^\.\.\//) {
                               $pospoint = rindex($name2,$dirsep,length($name2)-2);
                               $name2 = substr($name2,0,$pospoint+1);
                               $temp1 =~ s/\.\.\///;
                               }
                            $temp1 = $name2.$temp1;
                        }

     ($size)+= (stat("$temp1")) [7];
#     $mostsize{$name} += $size;

     # Acorn
                
#	$temp1 =~ s/$dirsepurl/\./g if ($dirsep eq ".");
#	if ($dirsep eq "." && $temp1 !~ /$dirsepurl$/) {
#	$temp1 =~ s/(.*)\.(.*)$/$1$dirsepurl$2/;
#	}

		if ($dirsep eq ".") {
		$temp1 =~ s/$dirsepurl/\./g ;
			if ($temp1 !~ /$dirsepurl$/) { # && $temp1 =~ /$searchima/) {
			$temp1 =~ s/(.*)\.(.*)$/$1$dirsepurl$2/;
			}
		}

		# NT

		$temp1 =~ s/$dirsepurl/\\/g if ($type_serveur == 1);
		     	                            
 if (!(-e $temp1)) {
# 	$temp1 =~ s/$pathserver$dirsep// if ($type_serveur == 0);
# 	$temp1 =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);
        $done = ($temp1 =~ s/$pathserver2//);
	$temp1 = "Security restriction for '$linkfile' - outside root server !" if ($done eq '');
        push(@noback,$nameshort);
        $back{$nameshort}++;
        $filebackmiss{$nameshort,$back{$nameshort}} = $temp1;
#	print "Error $temp1 not found\n";
        }

         push(@imause,$temp1);
                       
}
             
#################################################################
####      subroutine to check FRAME and HREF links          #####
#################################################################

sub html {
	local($linkfile,$name) = @_;

        $nblink++;
        $absolute = 0;

	$linkfile =~ s/\?.*//;
	return if ($linkfile =~ /^\#.*/);	
	return if ($linkfile =~ /^mailto:/);

	### lien interne au serveur web
							
        if ($linkfile !~ /:\/\//i) {

               $pospoint = rindex($name,$dirsep,length($name));
               $name2 = substr($name,0,$pospoint+1);

               if (index($linkfile,'.') != 0) {
                        $temp1 = $name2.$linkfile;
                        $temp1 .= $defaulthomepage if (substr($temp1,length($temp1)-1) eq "/");

			### lien absolu

                        if (index($linkfile,'/') == 0) {
                               $temp1 = $linkfile;
			       $absolute = 1;

			       ##### BEGIN - CGI-BIN #####

			       if ($temp1 =~ /cgi-bin/i) {
			           $absolute = 0;			       
				   $temp2 = $temp1;
				   $temp2 =~ s/\/cgi-bin\//$cgipath/;
				   
                                   if (!(-e $temp2)) {
				        push(@nocgibin,$nameshort);
				        $nocgi{$nameshort}++;
				        $filecgimiss{$nameshort,$nocgi{$nameshort}} = $temp2;
#					$delstring = "$tmp2$linkfile"
#				        $data =~ s/$tmp2$linkfile"//i;
#				        next;
			           }
			       }

			       ##### END - CGI-BIN #####

                               $temp1 =~ s/~(\w+)\///;
                               $temp1 = $pathserver.$temp1;
			  }
               }

	       # lien relatif
			
               if (index($linkfile,'.') == 0) {
                       $temp1 = $linkfile;
                       $temp1 .= $defaulthomepage if (substr($temp1,length($temp1)-1) eq "/");

                        while ($temp1 =~ m/^\.\.\//) {
                             $pospoint = rindex($name2,$dirsep,length($name2)-2);
                             $name2 = substr($name2,0,$pospoint+1);
                             $temp1 =~ s/\.\.\///;
                        }
                        $temp1 = $name2.$temp1;
                }

		$temp2 = $temp1;
                $temp2 =~ s/#.*//;

#		print "$temp2\n";

		# NT

		$temp1 =~ s/$dirsepurl/\\/g if ($type_serveur == 1);
		$temp2 = $temp1 if ($type_serveur == 1);
				
                # Acorn
                
		if ($dirsep eq ".") {
		$temp1 =~ s/$dirsepurl/\./g ;
			if ($temp1 !~ /$dirsepurl$/ && $temp1 =~ /$search/) {
			$temp1 =~ s/(.*)\.(.*)$/$1$dirsepurl$2/;
			}
		$temp2 = $temp1;
		}
		                
		# detection des liens sans $defaulthomepage pour les cdrom (ou local web)
			
		if (substr($linkfile,length($linkfile)-1) eq "/" && (-e $temp2)) {
		  $done = ($temp1 =~ s/$pathserver2//);
		  $temp1 = "Security restriction for '$linkfile' - outside root server !" if ($done eq '');
			push(@cdrom,$nameshort);
                        $noindex{$nameshort}++;
                        $filecdrom{$nameshort,$noindex{$nameshort}} = $temp1;
                }


                if ((!(-e $temp2)) && ($linkfile !~ /cgi-bin/i) && ($nameshort !~ /\/$packagename\/$dirdocs/o)) {
#			  $temp1 =~ s/$pathserver2// if ($type_serveur == 0);
#			  $temp1 =~ s/$pathserver2$dirsep$dirsep// if ($type_serveur == 1);			  
			  $done = ($temp1 =~ s/$pathserver2//);
			  $temp1 = "Security restriction for '$linkfile' - outside root server !" if ($done eq '');
                           push(@nofile,$nameshort);
                           $no{$nameshort}++;
                           $filemiss{$nameshort,$no{$nameshort}} = $temp1;
                           
			   if ($absolute == 1) {
			       push(@absolute,$nameshort);
                               $ab{$nameshort}++;
                               $fileabs{$nameshort,$ab{$nameshort}} = $temp1;
			       $absolute = 0;
                            }
                            
                 } else {
			if ($linkfile =~ m/$searchima$/i) {
			        push(@imause,$temp1) unless $seen{$temp1}++;
		        } else {
#			     push(@pageuse,$temp2) unless ((($temp1 =~ /#.*/) && ($name eq $temp2)) || $seen{$temp2}++);
                             push(@pageuse,$temp2) unless (($temp1 =~ /#.*/) && ($name eq $temp2));
			}
		}
     }

#return($delstring);

        if ($linkfile =~ m#^http:\/\/([\w-\.]+):?(\d*)($|/(.*))#i) {
        	if ($1 =~ /$localserver$tripart/i) {
#        		$temp1 = $1;
#                        $temp1 =~ s/$localserver$tripart//;
#                        $temp1 = $pathserver.$temp1;
			push(@absolute,$nameshort);
                        $ab{$nameshort}++;
                        $fileabs{$nameshort,$ab{$nameshort}} = $linkfile;
                        print "$linkfile\n" if ($debug == 1);
                        
        	}

		if ($opt_a == 1) {
        		$port = $2;
			$link = $3;
			$link = "/" if ($path eq "");
			$port = 80 if ($port eq "");

            	        next if (defined($HTTPStatusList{$linkfile}));
			$rcode = &check_external_link($1,$port,$link);
	    	        $HTTP_Fail_html{$linkfile} = $rcode if (defined($FailStatusMsgs{$rcode}));
	     	        print "$linkfile ($name) : $FailStatusMsgs{$rcode}\n" if (defined($FailStatusMsgs{$rcode}));	        
	     	        $HTTPStatusList{$linkfile} = $rcode;
        	}
        	
        }
        
#        if ($linkfile =~ m#^http:\/\/([\w-\.]+):?(\d*)($|/(.*))#i && $opt_a == 1) {
#        	$port = $2;
#		$link = $3;
#		$link = "/" if ($path eq "");
#		$port = 80 if ($port eq "");
#
#                next if (defined($HTTPStatusList{$linkfile}));
#		$rcode = &check_external_link($1,$port,$link);
#	        $HTTP_Fail_html{$linkfile} = $rcode if (defined($FailStatusMsgs{$rcode}));
#	        print "$linkfile ($name) : $FailStatusMsgs{$rcode}\n" if (defined($FailStatusMsgs{$rcode}));	        
#	        $HTTPStatusList{$linkfile} = $rcode;
#        }

}


#################################################################
####         subroutine to check external links             #####
#################################################################

# code by Darryl Burgdorf <burgdorf@awsd.com> from his webtester.pl script
# http://awsd.com/scripts/

sub check_external_link {
	local($host,$port,$path) = @_;
	local($name,$aliases,$proto,$type,$len,$protocol,$status);
	local($thisaddr,$thataddr,$this,$that,$response);

		$SOCK_STREAM = 1;	
	        ($name,$aliases,$proto) = getprotobyname('tcp');
	        ($name,$aliases,$port) = getservbyname($port,'tcp') unless $port =~ /^\d+$/;
	        ($name,$aliases,$type,$len,$thisaddr) = gethostbyname($hostname);
	        if (!(($name,$aliases,$type,$len,$thataddr) = gethostbyname($host))) {
	                return -1;
	        }
	        $this = pack($sockaddr, $AF_INET, 0, $thisaddr);
	        $that = pack($sockaddr, $AF_INET, $port, $thataddr);
	        if (!(socket(S, $AF_INET, $SOCK_STREAM, $proto))) {
	                $SOCK_STREAM = 2;
	                if (!(socket(S, $AF_INET, $SOCK_STREAM, $proto))) { return -2; }
	        }
	        if (!(bind(S, $this))) {
	                return -3;
	        }
	        if (!(connect(S,$that))) {
	                return -4;
	        }
	        select(S); $| = 1; select(STDOUT);
	        print S "HEAD $path HTTP/1.0\n\n";
	        $response = <S>;
	        ($protocol, $status) = split(/ /, $response);
	        close(S);
	        return $status;	
}

#################################################################
####         subroutine to check IMG tag                    #####
#################################################################

sub ima {
	local($linkfile,$searchima,$name) = @_;
	local($temp1);

#	print "$linkfile $searchima $name\n" if ($debug == 2);

        if ($linkfile !~ /:\/\//i) {

          if ($linkfile !~ /\\_/ && $type_serveur != 1) {

                $pospoint = rindex($name,$dirsep,length($name));
                $name2 = substr($name,0,$pospoint+1);
                          
                if (index($linkfile,'.') != 0) {
                         $temp1 = $name2.$linkfile;

                         if (index($linkfile,'/') == 0) {
                               $temp1 = $linkfile;
                               $temp1 =~ s/~(\w+)\///;
                               $temp1 = $pathserver.$temp1;
			  }
                 }

                 if (index($linkfile,'.') == 0) {
                          $temp1 = $linkfile;
                          while ($temp1 =~ m/^\.\.\//) {
                               $pospoint = rindex($name2,$dirsep,length($name2)-2);
                               $name2 = substr($name2,0,$pospoint+1);
                               $temp1 =~ s/\.\.\///;
                               }
                          $temp1 = $name2.$temp1;
                 }


                # Acorn

		if ($dirsep eq ".") {
		$temp1 =~ s/$dirsepurl/\./g ;
			if ($temp1 !~ /$dirsepurl$/) { # && $temp1 =~ /$searchima/) {
			$temp1 =~ s/(.*)\.(.*)$/$1$dirsepurl$2/;
			}
		}


		# NT

		$temp1 =~ s/$dirsepurl/\\/g if ($type_serveur == 1);
		                
#		$temp1 =~ s/$dirsepurl/\./g if ($dirsep eq ".");
#		if ($dirsep eq "." && $temp1 !~ /$dirsepurl$/) {
#		$temp1 =~ s/(.*)\.(.*)$/$1$dirsepurl$2/;
#		}

                 if ((!(-e $temp1)) && ($nameshort !~ /\/$packagename\/$dirdocs/o)) {
#			      $temp1 =~ s/$pathserver$dirsep// if ($type_serveur == 0);
#			      $temp1 =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);			      
			  $done = ($temp1 =~ s/$pathserver2//);
			  $temp1 = "Security restriction for '$linkfile' - outside root server !" if ($done eq '');
                              push(@noima,$nameshort);
                              $noima{$nameshort}++;
                              $imamiss{$nameshort,$noima{$nameshort}} = $temp1;

			      if (index($linkfile,'/') == 0) {
			          push(@absoluteima,$nameshort);
                                  $abima{$nameshort}++;
                                  $fileimaabs{$nameshort,$abima{$nameshort}} = $temp1;
                               }
                  }



       if (-f $temp1) {

         if (($searchwidth =~ /WIDTH/i) || ($searchwidth =~ /HEIGHT/i)) {
	     $x1 = '-';
	     $y1 = '-';
            $x1 = $1 if ($searchwidth =~ /WIDTH=["]?(\d+)["]?/i);
	    $y1 = $1 if ($searchwidth =~ /HEIGHT=["]?(\d+)["]?/i);
            ($x,$y) = &imaxy($temp1);
	    $urltmp = $name;
	    $urltmp =~ s/$pathserver$dirsep// if ($type_serveur == 0);
	    $urltmp =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);	    
	    $temptmp = $temp1;
	    $temptmp =~ s/$pathserver$dirsep// if ($type_serveur == 0);
	    $temptmp =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);	    
            print TMPWIDTH2 "$urltmp\t$temptmp\t$linkfile\t$x1\t$y1\t$x\t$y\n" if ($x1 != $x || $y1 != $y);
         }       

         if (($searchwidth !~ /WIDTH/i) || ($searchwidth !~ /HEIGHT/i)) {
            $countwidth++;	
            if (!($seen{"$name $linkfile"}++)) {
	       if ($filepicwidth == 0) {
                  $filepicwidth = 1;
                  $nowidth++;
		  $urltmp = $name;
		  $urltmp =~ s/$pathserver$dirsep// if ($type_serveur == 0);
		  $urltmp =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);		  
      	          print TMPWIDTH "<LI>$urltmp\n";
      	          print TMPWIDTH "<P><UL>\n";
      	          print TMPWIDTH "<TABLE BORDER=1><TR><TH>Image</TH><TH>Link</TH><TH>WIDTH</TH><TH>HEIGHT</TH></TR>\n";
      	       }
             ($x,$y) = &imaxy($temp1);
	       $temptmp = $temp1;
	       $temptmp =~ s/$pathserver$dirsep// if ($type_serveur == 0);
	       $temptmp =~ s/$pathserver$dirsep$dirsep// if ($type_serveur == 1);	       
             print TMPWIDTH "<TR><TD ALIGN=LEFT>$temptmp</TD><TD>$linkfile</TD><TD ALIGN=CENTER>$x</TD><TD ALIGN=CENTER>$y</TD></TR>\n";
             $uniqwidth++;
             }
         }

         print TMPWIDTH3 "$name\t$linkfile\n" if (($searchwith !~ /ALT/i) && (!($seen{"$name $temp1 $linkfile"}++)));

     }         
     ($size)+= (stat("$temp1")) [7];
#     $mostsize{$nameshort} += $size;
#		print STDERR "$temp1 $nameshort $size\n";
            }      
         } 
         

         push(@imause,$temp1);

        if ($linkfile =~ m#^http:\/\/([\w-\.]+):?(\d*)($|/(.*))#i) {
        	if ($1 =~ /$localserver$tripart/i) {
			push(@absoluteima,$nameshort);
                        $abima{$nameshort}++;
                        $fileimaabs{$nameshort,$abima{$nameshort}} = $linkfile;        	
                        print "$linkfile\n" if ($debug == 1);
                        
        	}

		if ($opt_a == 1) {
        		$port = $2;
			$link = $3;
			$link = "/" if ($path eq "");
			$port = 80 if ($port eq "");

            	        next if (defined($HTTPStatusList{$linkfile}));
			$rcode = &check_external_link($1,$port,$link);
	    	        $HTTP_Fail_html{$linkfile} = $rcode if (defined($FailStatusMsgs{$rcode}));
	     	        print "$linkfile ($name) : $FailStatusMsgs{$rcode}\n" if (defined($FailStatusMsgs{$rcode}));	        
	     	        $HTTPStatusList{$linkfile} = $rcode;
        	}
        	
        }

         return ($filepicwidth);
 }

#################################################################
####     subroutine to find width and height for IMG tag    #####
#################################################################

# code by Patrick Atoon <patricka@cs.kun.nl> from his fiximg.pl script
# http://www.sci.kun.nl/thalia/guide/#fiximg

sub imaxy {
    local($file) = @_;
    
    open(IMA,$file) || die "Unable to open $file\n";

    local($magic) = '';
    eval { $magic = &read_n_bytes(2); };
    $@ = '';

    $jpgima = 0;
    $gifima = 0;
    $xbmima = 0;

    ### XBM file
    if ($magic eq "#d") {
	$xbm++;
	$a = (<IMA>);
	($a,$b,$width) = split(/ /,$a);
	$a = (<IMA>);
	($a,$b,$height) = split(/ /,$a);
	chop($width);
	chop($height);
	return($width, $height);
    }

    ### JPEG file
    if ($magic eq "$FF$M_SOI") {
	$jpg++;
	$jpgima = 1;
	while ( 1==1 ) {
	    # Get the next marker
	    $db = 0; $ch = &read_1_byte;
	    while ( $ch ne $FF ) {
		$db++; $ch = &read_1_byte;
	    };
	    $ch = &read_1_byte while ( $ch eq $FF );
	    $db && die "Garbage data found in JPEG file : $file\n";
	    	$www = unpack("C",$ch);
#	    print STDERR "$www\n";
	    
	    # What type marker are we looking at?
    
	    # Do we have width and height yet?
	    if ( $ch ge $M_SOF0 && $ch le $M_SOF3 ||
		 $ch ge $M_SOF5 && $ch le $M_SOF7 ||
		 $ch ge $M_SOF9 && $ch le $M_SOF11 ||
		 $ch ge $M_SOF13 && $ch le $M_SOF15 ) {
		($l,$d,$height,$width) =
#		    unpack("SCSS",&read_n_bytes(7));
		    unpack("nCnn",&read_n_bytes(7));
		return($width, $height);
	    }
	    # Or have we reached the end of the header?
	    elsif ( $ch eq $M_SOS || $ch eq $M_EOI ) {
		die "Found no width or height!\n";
	    }
	    # Otherwise, skip this variable
	    else {	
	    
		$l = unpack("n",&read_n_bytes(2)) - 2;
#		print STDERR "data : $temp1 $l\n";
		if ($l < 0 ) {
		    print STDERR "Erroneous JPEG marker length!\n";
		}
		&read_n_bytes($l);
#		return "$l,1000";

	    }
	} # while ( 1==1 )
    }

    ### GIF file
    
    $magic .= &read_n_bytes(4);
    if ( $magic eq "GIF87a" || $magic eq "GIF89a" ) {
	($width,$height) = unpack('vv',&read_n_bytes(4));
	$gif++;
	$gifima = 1;
	return($width, $height);
    }

    if (($gifima != 1) && ($jpgima != 1) && ($xbmima != 1))
    {
        print "\"$file\" : unknown image format (contact me !)\n";
        close(IMA);
        return "";
    }
    
    close(IMA);    
}    

# Reads one byte. If EOF is reached, terminates with an error message.
sub read_1_byte {
    local($ch);
    ($ch = getc(IMA)) || print STDERR  "Premature EOF in image file $file (1 byte)!\n";
    $ch;
}

# Reads N bytes. If EOF is reached, terminates with an error message.
sub read_n_bytes {
    local($n) = @_;
    local($ch);
    read(IMA,$ch,$n) == $n || print STDERR "Premature EOF in image file $file! ($n byte)\n";
    $ch;
}




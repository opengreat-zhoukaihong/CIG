#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                       HISTORY STATS                            #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 16/08/2000     #####
####                                                                #####
#########################################################################

$version = "2.72";
$verdate = "16/08/00";

############ script to launch daily at 00 hour 01 minute  ##########

require "/home/domisse/public_html/w3perl/libw3perl.pl";

$starttime = time();

#$datesyst = &ctime(time);
#($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
#($hour,$minute,$second) = split(/:/,$hourdate);

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";
print "CPU stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -c <file>             : load configuration file\n";
#      print STDOUT "        -d <nbdays>           : number of days to scan\n";
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
      print STDOUT "        -x                    : show default value for flag options\n";
      print STDOUT "        -v                    : version\n"; 
      print STDOUT "\n";
      exit;
}


if ($opt_v == 1) {
      print STDOUT "cron-history.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -c            : $configfile\n";
#      print STDOUT "          -d <nbdays>   : $nbdays\n";
      print STDOUT "          -g <graphic>  : $graphic[0]\n";
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDOUT "          -v            : $version\n";
      exit;
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

#if ($opt_d ne '') {
#$nbdays = $opt_d; 
#}

if ($opt_p ne '') {
$precision = $opt_p; 
}

#################################################################
####          debut de l'initialisation                   #######
#################################################################

for ($nblang=0;$nblang<=$#lang;$nblang++) {
    $dir = $path.$lang[$nblang];
    mkdir ($dir,0775) unless -d $dir;
    $dir = $path.$lang[$nblang].$dirsep.$dirlist;
    mkdir ($dir,0775) unless -d $dir;
}

$dir = $path.$dirtmp;
mkdir ($dir,0775) unless -d $dirtmp;

$dir = $path.$dirgraph;
mkdir ($dir,0775) unless -d $dirgraph;

###

$linkdirdate = $data;

$file1 = $path.$dirgraph.$dirsep."cpu".$gifext;
$file1x = $path.$dirgraph.$dirsep."cpux".$gifext;
$file1y = $path.$dirgraph.$dirsep."cpuy".$gifext;
$linkfile1 = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."cpu".$gifext;
$linkfile1x = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."cpux".$gifext;
$linkfile1y = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."cpuy".$gifext;

$others = "others".$gifext;

#################################################################
####                   date de ce jour                    #######
#################################################################

### today date

#$datesyst = &ctime(time);
#($dayletter,$month,$day,$hourdate,$a,$year) = split(/\s+/,$datesyst);
#$year = $a if ($year eq '');
#$day = "0".$day if (length($day) == 1);
$month_number = $month_equiv{$month};
$month_number--;
#($hour,$minute,$second) = split(/:/,$hourdate);
$today = $day." ".$month." ".$year;

$year_now = $year;

### nombre de jour entre le 1er janvier et $today

$timesec = time;
&get_time($timesec);
($jour_of_year_end) = split(/ /,$datemisc);

#print STDERR "JOUR_OF_YEAR_END : $jour_of_year_end\n";

### date il y a $nbdays jours

if ($nbdays != 0 ) {

$pastday = $day  - $nbdays; 
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
#print STDERR "il y a $nbdays jours , nous etions le $pasttoday\n";


#################################################################
#####               computing history stats                ######
#################################################################

 open(INFILE, "$history") || die "Error, unable to open $history\n";

 while (<INFILE>) {
 ($prg,$date,$time1,$time2,$cpu,$codeline) = split;
 ($min,$sec) = split(/:/,$cpu);

 if ($count_day == 0) {
     $firstjour = $date;

     $date1 = $date;
     $date1 =~ s/\// /g;
     $jour_of_year_tmp = &nbdayan($date1);
 }

 $count_day++ if ($date ne $dateold);
 $dateold = $date;
 $cpu{$prg} += $sec+($min*60);

 if ($codeline ne '') {
 $codeline{$prg} += $codeline;
 $nbcode{$prg}++;
 }
 $codeline = "-" if ($codeline eq '');
 push(@line,"$prg\t$date\t$time1\t$min\t$sec\t$codeline\t") ;
 $nbprg{$prg}++;

 $unique++ unless ($seen{"$prg"}++);
}
 close(INFILE);

####

$date1 = $date;
$date1 =~ s/\// /g;
$jour_of_year_tmp2 = &nbdayan($date1);

$count_day = $jour_of_year_tmp2 - $jour_of_year_tmp;
$count_day += 365 if ($count_day < 0);

####

$occurcpu[0] = 0;

foreach $value (keys(%cpu)) { 
if ($cpu{$value} > $occurcpu[0]) {
    $occurcpu[0] = $cpu{$value};
    $bestcpu[0] = $value;
}
}

for ($i=1;$i < $unique;$i++) {
    $occurcpu[$i] = 0;
    foreach $value (keys(%cpu)) {
        $out = 0;
        if ($cpu{$value} > $occurcpu[$i] && ($cpu{$value} <= $occurcpu[$i-1])) {
               for ($j=0;$j<= $i;$j++) {
                  $out = 1 if ($bestcpu[$j] eq $value);
                }
                if ($out == 0) {
                      $occurcpu[$i] = $cpu{$value};
                      $bestcpu[$i] = $value;
                }
        }
     }
}

####

foreach $value (keys(%cpu)) { 
$moy{$value} = int($cpu{$value}/$nbprg{$value});
$moycodeline{$value} = int($codeline{$value}/$nbcode{$value}) if ($nbcode{$value} != 0);
$tot += $cpu{$value};
$nbtotprg += $nbprg{$value};
for ($nblang=0;$nblang<=$#lang;$nblang++) {
$tabcpu = $path.$lang[$nblang].$dirsep.$dirlist.$dirsep.$value.$htmlext;
open(TABOUT, ">$tabcpu") || die "Error, unable to open $tabcpu\n";
&TableScript(*TABOUT, eval($Lang{$lang[$nblang]}));
close(TABOUT);
}
}


####

for ($nblang=0;$nblang<=$#lang;$nblang++) {

        $tabcpu = $path.$lang[$nblang].$dirsep.$dirlist.$dirsep.$filecpu;

        open(TABOUT, ">$tabcpu") || die "Error, unable to open $tabcpu\n";
        &TableCpu(*TABOUT, eval($Lang{$lang[$nblang]}));
        close(TABOUT);
        }

###

sub TableScript { 
 local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Stats_about_CPU'} - $value</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-history.pl $version - $today $hourdate -->\n";	 
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1>$L{'CPU'} - $value</H1><P>\n";
 print FOUT "<P><HR>\n";
 print FOUT "<CENTER><I>$firstjour - $date</I></CENTER>\n";
 print FOUT "<HR><P><CENTER>\n";
 if ($value !~ /week/ || $value !~ /day/ || $value !~ /url/) {
 $linkfile = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$value.$gifext;
 $linkfilex = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$value."x".$gifext;
 $linkfiley = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$value."y".$gifext;  

        print FOUT "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
        print FOUT "<TR>\n";
        print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkfiley\" ALT=\"y\"></TD>\n";
        print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkfile\" ALT=\"$value\" BORDER=0></TD>\n";
        print FOUT "</TR><TR><TD></TD>\n";
        print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkfilex\" ALT=\"x\"></TD>\n";
        print FOUT "</TR>\n";
        print FOUT "</TABLE><P>\n";
 }
 print FOUT "<TABLE BORDER=1 CELLPADDING=5 CELLSPACING=2>\n";
 print FOUT "<TR>\n";
 print FOUT "<TH COLSPAN=4 BGCOLOR=\"#E0E0E0\" ALIGN=CENTER>$value</TH></TR>\n";
 print FOUT "<TH BGCOLOR=\"#FFFF00\">$L{'Date'}</TH>\n";
 print FOUT "<TH>$L{'Hour'}</TH>\n";
 print FOUT "<TH BGCOLOR=\"#00FF00\">$L{'CPU'}</TH>\n";
 print FOUT "<TH>$L{'Lines_processed'}</TH>\n";
 print FOUT "</TR>\n";
for ($i=0;$i<=$#line;$i++) {
($prg,$date,$time1,$min,$sec,$line) = split(/\t/,$line[$i]);
if ($prg eq $value) {
 $min = "0".$min if (length($min) == 1);
 $sec = "0".$sec if (length($sec) == 1);                                        
print FOUT "<TR><TD ALIGN=CENTER>$date</TD><TD ALIGN=CENTER>$time1</TD><TD ALIGN=CENTER>$min:$sec</TD>";
print FOUT "<TD ALIGN=RIGHT>$line</TD></TR>\n" if ($line ne "-");
print FOUT "<TD ALIGN=CENTER>$line</TD></TR>\n" if ($line eq "-");
}

}
print FOUT "</TABLE>\n";
print FOUT "</CENTER><P><HR><P>\n";    
print FOUT "</BODY></HTML>\n";

}


sub TableCpu { 
 local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Stats_about_CPU'} - $L{'Tab_about_lastdays1'} $count_day $L{'Tab_about_lastdays2'}</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-history.pl $version - $today $hourdate -->\n";	 
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1>$L{'Stats_about_CPU'}</H1><P>\n";
 print FOUT "<P><HR>\n";
 print FOUT "<CENTER><I>$firstjour - $date</I></CENTER>\n";
 print FOUT "<HR><P>\n";
 print FOUT "<B>$L{'Tab_about_lastdays1'} $count_day $L{'Tab_about_lastdays2'}</B><BR><BR>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR>\n";
 print FOUT "<TH ALIGN=CENTER>$L{'Scripts'}</th>\n";
 print FOUT "<TH BGCOLOR=\"#FFFF00\" ALIGN=CENTER>Total CPU <BR>($L{'seconds'})</TH>\n";
 print FOUT "<TH ALIGN=CENTER>$L{'Occurence'}</TH>\n";
 print FOUT "<TH ALIGN=CENTER>$L{'Average_CPU'} <BR>($L{'seconds'})</TH>\n";
 print FOUT "<TH ALIGN=CENTER>$L{'Speed'} <BR>($L{'Lines_processed'}/$L{'seconds'})</TH>\n";
 print FOUT "</TR>\n";

for ($i=0;$i<$unique;$i++) {
$value = $bestcpu[$i];
$tmp = $value.$htmlext;
 print FOUT "<TR><TD ALIGN=CENTER><A HREF=\"$tmp\">$value</A></TD>\n";

 $min = int($cpu{$value}/60);
 $min = "0".$min if (length($min) == 1);
 $sec = $cpu{$value} - ($min*60);
 $sec = "0".$sec if (length($sec) == 1);

 print FOUT "<TD ALIGN=CENTER>$min:$sec</TD>\n";
 print FOUT "<TD ALIGN=CENTER>$nbprg{$value}</TD>\n";

 $min = int($moy{$value}/60);
 $min = "0".$min if (length($min) == 1);
 $sec = $moy{$value} - ($min*60);
 $sec = "0".$sec if (length($sec) == 1);

 print FOUT "<TD ALIGN=CENTER>$min:$sec</TD>\n";
 print FOUT "<TD ALIGN=CENTER>";
 print FOUT "-" if ($nbcode{$value} == 0);
 print FOUT int($moycodeline{$value}/$moy{$value}) if ($nbcode{$value} != 0);
 print FOUT "</TD>\n";
 print FOUT "</TR>\n";
}

 $hour = int($tot/3600);
 $hour = "0".$hour if (length($hour) == 1);
 $min = int(($tot - int($hour*60*60))/60);
 $min = "0".$min if (length($min) == 1);
 $sec = ($tot - int($hour*60*60)) - ($min*60);
 $sec = "0".$sec if (length($sec) == 1);

print FOUT "<TR><TD>&nbsp;</TD><TD ALIGN=CENTER><B>$hour:$min:$sec</B></TD>";
print FOUT "<TD ALIGN=CENTER>$nbtotprg</TD>";

$totmoy = int($tot/$nbtotprg);

 $min = int($totmoy/60);
 $min = "0".$min if (length($min) == 1);
 $sec = $totmoy - ($min*60);
 $sec = "0".$sec if (length($sec) == 1);

print FOUT "<TD ALIGN=CENTER><I>$min:$sec</I></TD>\n";
print FOUT "<TD ALIGN=CENTER>&nbsp;</TD></TR>\n";
print FOUT "</TABLE>\n";
print FOUT "<P><HR><P>\n";    
print FOUT "</BODY></HTML>\n";

}

#################################################################

####

foreach $value (keys(%cpu)) { 

next if ($value =~ /week/ || $value =~ /day/ || $value =~ /url/);

$secmax = 0;
$linemax = 0;

for ($i=0;$i<=$#line;$i++) {
($prg,$date,$time1,$min,$sec,$line) = split(/\t/,$line[$i]);
if ($prg eq $value) {
 $sec = $sec + (60*$min);
 $graphcpu[$sec] = $line;
 $secmax = $sec if ($sec > $secmax);
 $linemax = $line if ($line > $linemax); 
 }

}

$it = length($secmax)-1;
$div = 10**$it;
$factx = ($div*(int($secmax/$div)+1))/$grad;

$repmax = 0;

$it = length($linemax)-1;
$div = 10**$it;
$facty = ($div*(int($linemax/$div)+1))/$grad;

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $oldj = 0;
 
 for ($j=1;$j<=$secmax;$j++) {
 next if ($graphcpu[$j] == 0);

 $x1 = ($j-1)*$xstep/$factx;
 $x2 = $j*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $graphcpu[$j]);

 if ($bargraph == 1) {
    print FLY "frect $x1,$y2,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
    print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
   if ($tridim == 1 && $y2 != $ymax) {

        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;
        $y1plus = $ymax - $perspec;

        print FLY "fpoly $red[0],$green[0],$blue[0],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";

        print FLY "fpoly $red[0],$green[0],$blue[0],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
   }
 }

 if ($linegraph == 1) {
    $y1 = $ymax - ($ystep/$facty * $oldj);
    print FLY "line $oldx,$y1,$x2,$y2,$red[0],$green[0],$blue[0]\n" if ($oldj != 0);

    if ($fillgraph == 1) {
      if ($y1 != $y2 || $y1 != $ymax) {
         print FLY "line $x1,$ymax,$x1,$y2,$red[0],$green[0],$blue[0]\n";
         print FLY "line $x2,$ymax,$x2,$y1,$red[0],$green[0],$blue[0]\n";
         print FLY "line $x1,$ymax,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
         $fx1 = $x1+1;
         $fymax = $ymax-1;
         print FLY "fill $fx1,$fymax,$red[0],$green[0],$blue[0]\n";
       }
    }
 }
 $oldj = $graphcpu[$j];
 $oldx = $x1;
 $graphcpu[$j] = 0;

 }

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$value$gifext |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

$valuex = $value."x".$gifext;

$xlegend = "CPU (seconds)";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";

 for ($j=$xstep;$j<$xmax;$j+=$xstep) {
 $valstep = int($j * ($factx/$xstep));
 $pos = ($ydecal - length($valstep)*9);
# $posy = $j-5;
 $posx = $j - length($valstep)*3;
# print FLY "line $xdecalm,$j,$xdecal,$j,0,0,0\n";
# print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 print FLY "line $j,0,$j,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$valstep\n";
 }
 
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$valuex |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les ordonnees

$valuey = $value."y".$gifext;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("Lines")));
 print FLY "stringup 0,0,0,5,$posy,medium,Lines\n";

 for ($j=$ystep;$j<$ymax;$j+=$ystep) {
 $valstep = int(($ymax - $j) * ($facty/$ystep));
 $pos = ($xdecal - length($valstep)*9);
 $posy = $j-5;
 print FLY "line $xdecalm,$j,$xdecal,$j,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$valuey |");
while( <FOO> ) {print;}
close(FOO);

}

unlink($tmpfly);


# calculer le temps mis pour le calcul

$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
($hour,$minute,$second) = split(/:/,$hourdate);

$endrun = "$hour:$minute:$second";

($min,$sec) = &timetaken($startrun,$endrun);

$endtime = time();
print STDOUT "Computing time took $min min $sec sec\n\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET"); 


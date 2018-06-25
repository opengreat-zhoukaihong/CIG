#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                       DAILY STATS                              #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 01/06/2000     #####
####                                                                #####
#########################################################################

$version = "2.68";
$verdate = "01/06/00";

############ script to launch daily at 00 hour 01 minute  ##########

require "/home/domisse/public_html/w3perl/libw3perl.pl";

$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
($hour,$minute,$second) = split(/:/,$hourdate);

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

print "Daily stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -c <file>             : load configuration file\n";
      print STDOUT "        -d <nbdays>           : number of days to scan\n";
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
      print STDOUT "        -p <level>            : precision level (from 1 to 4)\n";
      print STDOUT "        -x                    : show default value for flag options\n";
      print STDOUT "        -v                    : version\n"; 
      print STDOUT "\n";
      exit;
}


if ($opt_v == 1) {
      print STDOUT "cron-day.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -c            : $configfile\n";
      print STDOUT "          -d <nbdays>   : $nbdays\n";
      print STDOUT "          -g <graphic>  : $graphic[0]\n";
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDOUT "          -p <level>    : $precision\n";
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

if ($opt_d ne '') {
$nbdays = $opt_d; 
}

if ($opt_p ne '') {
$precision = $opt_p; 
}

#################################################################
####          debut de l'initialisation                   #######
#################################################################

$dir = $path.$dirtmp;
mkdir ($dir,0775) unless -d $dirtmp;

$dir = $path.$dirgraph;
mkdir ($dir,0775) unless -d $dirgraph;

$starttime = time();
     
$linkdirdate = $data;

$file1 = $path.$dirgraph.$dirsep."day".$gifext;
$file1x = $path.$dirgraph.$dirsep."dayx".$gifext;
$file1y = $path.$dirgraph.$dirsep."dayy".$gifext;
$linkfile1 = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."day".$gifext;
$linkfile1x = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."dayx".$gifext;
$linkfile1y = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."dayy".$gifext;

$file2 = $path.$dirgraph.$dirsep."daysize".$gifext;
$file2x = $path.$dirgraph.$dirsep."daysizex".$gifext;
$file2y = $path.$dirgraph.$dirsep."daysizey".$gifext;
$linkfile2 = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."daysize".$gifext;
$linkfile2x = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."daysizex".$gifext;
$linkfile2y = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."daysizey".$gifext;

$sizedirgraph = $path.$dirgraph.$dirsep."day_repert_size".$gifext;
$linksizedirgraph = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."day_repert_size".$gifext;

$others = "others".$gifext;

#################################################################
####                   date de ce jour                    #######
#################################################################

### today date

$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/\s+/,$datesyst);
$year = $a if ($year eq '');
$day = "0".$day if (length($day) == 1);
$month_number = $month_equiv{$month};
$month_number--;
($hour,$minute,$second) = split(/:/,$hourdate);
$today = $day." ".$month." ".$year;

$year_now = $year;

# annee bissextile ==> fevrier a 29 jours

if (($year%4 == 0 && $year%100 != 0) || $year%400 == 0) {
$month_of_year{'Feb'} = '29';
$bisextil = 1;
}

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
### number of days found

 open(INFILE, "$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";
 $count_day = 1;
 while (<INFILE>) {
     $count_day++;
     }

$count_day -=4; #ote ligne du header
$count_day = $nbdays if ($count_day > $nbdays);
$line_density = 0.001*$count_day;
$shift_factor = 0.3;

 close(INFILE);

#################################################################
#####               computing daily stats                  ######
#################################################################

for ($nblang=0;$nblang<=$#lang;$nblang++) {

        $tabdays = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamedays;

        open(TABOUT, ">$tabdays") || die "Error, unable to open $tabdays\n";
        &TableHeader(*TABOUT, eval($Lang{$lang[$nblang]}));
        close(TABOUT);
        }

&TableDays();

sub TableHeader { 
 local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Tab_about_lastdays1'} $count_day $L{'Tab_about_lastdays2'} ($L{'Textual_version'})</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-day.pl $version - $today $hourdate -->\n";	 
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1> $L{'Tab_about_lastdays1'} $count_day $L{'Tab_about_lastdays2'}</H1><P>\n";
 print FOUT "<P><HR><P>\n";
 print FOUT "<table border=1 width=100%>\n";
 print FOUT "<tr>\n";
 print FOUT "<th>$L{'Date'}</th>\n";
 print FOUT "<th bgcolor=\"#FFFF00\">$L{'Hosts'}</th>\n";
 print FOUT "<th>$L{'New_Hosts'}</th>\n";
 print FOUT "<th>$L{'Domain_Hosts'}</th>\n";
 print FOUT "<th bgcolor=\"#00FFFF\">$L{'Requests'}</th>\n";
 print FOUT "<th bgcolor=\"#00FF00\">$L{'Accesses'}</th>\n";
 print FOUT "<th>$L{'DomReq'}</th>\n";
 print FOUT "</tr>\n";
}

sub TableDays { 
 $line = 0;
 $inc = 0;
 $count_day = 1;
 $count_week = 1;

 open(INFILE, "$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";

 while (<INFILE>) {
     $line++;
     next unless ($line > 3);

     $count++;
     $oldjour = $jour;
     $oldmonth = $month;

    ($jour,$month,$year,$m_tot,$m_new,$m_dom,$req_tot,$req_dom,$access,$totsize,$tothtmlsize) = split('\s+');

     if ($nbdays != 0) {

     # nombre de jour depuis le 1er janvier

     $jour_of_year = 0;
     $countmonth = 0;
     $month_end = $month_nb[$countmonth];
     
     while ($month_end ne $month) {
       $jour_of_year += $month_of_year{$month_end};
       $countmonth++;
       $month_end = $month_nb[$countmonth];
       }
       
     $jour_of_year += $jour;
     $jour_ecoule = ($jour_of_year_end+($year_now-$year)*365) - $jour_of_year;

     if ($jour_ecoule < 1) {
        $jour_ecoule += 365;
        $jour_ecoule += 1 if ($bisextil == 1); 
        }
     }

     next unless ($jour_ecoule <= $nbdays);

#     print STDERR "JOUR_ECOULE : $jour_ecoule - NBDAYS : $nbdays - $year : $year_now - JOUR_OF_YEAR : $jour_of_year\n";
     
     $inc++;
     $day = $jour." ".$month." ".$year;  

     if ( $start_date eq '') {
       $start_date = $day;
     }

     ### test sur le jour suivant
    
     $intervalle = $jour - $oldjour;
     if ($intervalle != 1 && $line > 4) {
        if ($oldmonth ne $month) {
        $intervalle = $month_of_year{$oldmonth} - $oldjour; # suppose le mois suivant
        $intervalle += $jour;
             }
       $affmonth = $oldmonth;
       for ($i=$count;$i<($intervalle+$count-1);$i++) {
          $oldjour++;
          if ($oldjour > $month_of_year{$oldmonth}) {
                 $oldjour = 1;
                 $affmonth = $month;
                 } 
          
          $oldjour = "0".$oldjour unless (length($oldjour) == 2);

          $day = $oldjour." ".$affmonth." ".$year;

        for ($nblang=0;$nblang<=$#lang;$nblang++) {

                $tabdays = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamedays;
                open(FOUT, ">>$tabdays") || die "Error, unable to open $tabdays\n";
          
                print FOUT "<TR><TD ALIGN=CENTER BGCOLOR=\"#E0E0E0\"><A NAME=\"$count_day\">$day</td>\n";
                print FOUT "<TD ALIGN=CENTER>0</TD><TD ALIGN=CENTER>0</TD><TD ALIGN=CENTER>0</TD><TD ALIGN=CENTER>0</TD><TD ALIGN=CENTER>0</TD><TD ALIGN=CENTER>0</TD></TR>\n";
                close(FOUT);
        }
        
                if ($inc == 7) {
                        for ($nblang=0;$nblang<=$#lang;$nblang++) {

                        $tabdays = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamedays;
                        open(FOUT, ">>$tabdays") || die "Error, unable to open $tabdays\n";
                        print FOUT "<TR><TD></TD><TD ALIGN=CENTER>";
                        print FOUT "-" x (2 + length($m_total));
                        print FOUT "</TD><TD></TD><TD></TD><TD ALIGN=CENTER>";
                        print FOUT "-" x (2 + length($req_total));
                        print FOUT "</TD><TD ALIGN=CENTER>";
                        print FOUT "-" x (2 + length($access_total));
                        print FOUT "</TD><TD></TD></TR>\n";
                        print FOUT "<TR><TD></TD>\n";
                        print FOUT "<TD BGCOLOR=\"#FFFF00\" ALIGN=CENTER><B>$m_total</B></TD>\n";
                        print FOUT "<TD></TD><TD></TD>\n";
                        print FOUT "<TD BGCOLOR=\"#00FFFF\" ALIGN=CENTER><B>$req_total</B></TD>\n";
                        print FOUT "<TD BGCOLOR=\"#00FF00\" ALIGN=CENTER><B>$access_total</B></TD>\n";
                        print FOUT "<TD></TD></TR>\n";
                        print FOUT "<TR><TD COLSPAN=7>&nbsp;</TD></TR>\n";
                }
                close(FOUT);
                $m_total = 0;
                $req_total = 0;
                $access_total = 0;
                $inc -= 7;
        }
        $inc++;
}
     $count+=$intervalle-1;
     $count_day += $intervalle-1;
     $line = $count;
     }

     $access_total += $access;
     $m_total += $m_tot;
     $req_total += $req_tot;
     $reqmaxtot{$count_day} = $req_tot;
     $accessmaxtot{$count_day} = $access;
     $mmaxtot{$count_day} = $m_tot;

     $reqmax = $req_tot if ($req_tot > $reqmax);    

     $sizetot{$count_day} = $totsize if ($optdirsize > 3);
     $sizetot{$count_day} = $tothtmlsize if ($optdirsize < 4);

     $maxtot = $sizetot{$count_day} if ($sizetot{$count_day} > $maxtot);    

     $day = $jour." ".$month." ".$year;

     for ($nblang=0;$nblang<=$#lang;$nblang++) {

#    $linkjour = $linkpath.$lang[$nblang].$dirsepurl.$dirdays.$dirsepurl.$jour."-".$month.$htmlext;

# version sur les resumes heures par heures
#    $linkjour = "..".$dirsepurl.$dirdays.$dirsepurl.$jour."-".$month.$htmlext;
#    $fulljour = $path.$lang[$nblang].$dirsep.$dirdays.$dirsep.$jour."-".$month.$htmlext;

    $linkjour = "..".$dirsepurl.$dirdate.$dirsepurl.$year."-".$month."-".$jour.$dirsepurl.$menu;

      $fulljour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$year."-".$month."-".$jour.$dirsep.$fileresumemenu;

     if (-e $fulljour){
         $writeday = '<A HREF="'.$linkjour.'">'.$day;
         $writeday .= "</A>";
     } else {
        $writeday = $day;
        }


       # MAJ des resumes

    ($dayprevious,$monthprevious,$yearprevious) = split(/ /,$previousday);

    $dirresumeprevious = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$yearprevious."-".$monthprevious."-".$dayprevious.$dirsep.$fileresumemenu;

#      $fullpreviousjour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$yearprevious."-".$monthprevious."-".$dayprevious.$dirsep.$fileresumemenu;

    $dirresume = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$year."-".$month."-".$jour.$dirsep;
    $dirresume2 = $path.$lang[$nblang].$dirsep.$dirsession.$dirsep.$filemoyenne;

#    open(FILERESUME,"$fullpreviousjour");
#    @dataline = (<FILERESUME>);
#    close (FILERESUME);


#    open(FILERESUME,">$fullpreviousjour");
#	for ($i=0;$i<=$#dataline;$i++) {
#	$dataline[$i] =~ s/<!-- NEXT (.*)-->/<IMG SRC=$1/;
#	print FILERESUME "$dataline[$i]";
#    }
#    close (FILERESUME);


    open(FILERESUME,"$fulljour");
    @dataline = (<FILERESUME>);
    close (FILERESUME);

    # Calcul jour suivant
    $dirresumenext = '';
    $jjour = $jour;
    $jjour++;
    $jmonth = $month;
    $jyear = $year;
    $jjour = "0".$jjour if (length($jjour) == 1);
    if ($jjour > $month_of_year{$jmonth}) {
              $jmonth = $month_nb[$month_equiv{$jmonth}];
              $jjour = "01";
       $jyear++ if ($jmonth eq $month_nb[0]);
     }
     $dirresumenext = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$jyear."-".$jmonth."-".$jjour.$dirsep.$fileresumemenu;

    if (-e $fulljour) {
    open(FILERESUME,">$fulljour");
	for ($i=0;$i<=$#dataline;$i++) {
	$dataline[$i] =~ s/<!-- PREVIOUS (.*)-->/<IMG SRC=$1/ if (-e "$dirresumeprevious");

	$dataline[$i] =~ s/<!-- NEXT (.*)-->/<IMG SRC=$1/ if (-e "$dirresumenext");
	$dataline[$i] =~ s/<!-- REFER (.*)-->/<IMG SRC=$1/ if (-e "$dirresume$refer");
        $dataline[$i] =~ s/<!-- REFER2 (.*) -->/$1/ if (-e "$dirresume$refer");
	$dataline[$i] =~ s/<!-- AGENT (.*)-->/<IMG SRC=$1/ if (-e "$dirresume$agent");
        $dataline[$i] =~ s/<!-- AGENT2 (.*) -->/$1/ if (-e "$dirresume$agent");
	$dataline[$i] =~ s/<!-- SESSION (.*)-->/<IMG SRC=$1/ if (-e "$dirresume$dirsession$htmlext");
        $dataline[$i] =~ s/<!-- SESSION2 (.*) -->/$1/ if (-e "$dirresume$dirsession$htmlext");
	$dataline[$i] =~ s/<!-- HOUR (.*)-->/<IMG SRC=$1/ if (-e "$dirresume$filenamehour");
        $dataline[$i] =~ s/<!-- HOUR2 (.*) -->/$1/ if (-e "$dirresume$filenamehour");
	$dataline[$i] =~ s/<!-- AVERAGE (.*)-->/<IMG SRC=$1/ if (-e "$dirresume2");
        $dataline[$i] =~ s/<!-- AVERAGE2 (.*) -->/$1/ if (-e "$dirresume2");
	print FILERESUME "$dataline[$i]";
    }
    close (FILERESUME);
}
       #
    
    $previousday = $day;

#

        $tabdays = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamedays;
        open(FOUT, ">>$tabdays") || die "Error, unable to open $tabdays\n";
        print FOUT "<TR><TD  ALIGN=CENTER BGCOLOR=\"#E0E0E0\"><A NAME=\"$count_day\">$writeday</TD><TD ALIGN=CENTER>$m_tot</TD><TD ALIGN=CENTER>$m_new</TD><TD ALIGN=CENTER>$m_dom</TD><TD ALIGN=CENTER>$req_tot</TD><TD ALIGN=CENTER>$access</TD><TD ALIGN=CENTER>$req_dom</TD></TR>\n";
        close(FOUT);
        }
        
        if ($inc == 7) {
                for ($nblang=0;$nblang<=$#lang;$nblang++) {

                $tabdays = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamedays;
                open(FOUT, ">>$tabdays") || die "Error, unable to open $tabdays\n";
            print FOUT "<TR><TD></TD><TD ALIGN=CENTER>";
            print FOUT "-" x (2 + length($m_total));
            print FOUT "</TD><TD></TD><TD></TD><TD ALIGN=CENTER>";
        print FOUT "-" x (2 + length($req_total));
            print FOUT "</TD><TD ALIGN=CENTER>";
        print FOUT "-" x (2 + length($access_total));
            print FOUT "</TD><TD></TD></TR>\n";
            print FOUT "<TR><TD></TD>\n";
        print FOUT "<TD BGCOLOR=\"#FFFF00\" ALIGN=CENTER><B>$m_total</B></TD>\n";
                print FOUT "<TD></TD><TD></TD>\n";
                print FOUT "<TD BGCOLOR=\"#00FFFF\" ALIGN=CENTER><B>$req_total</B></TD>\n";
                print FOUT "<TD BGCOLOR=\"#00FF00\" ALIGN=CENTER><B>$access_total</B></TD>\n";
                print FOUT "<TD></TD></TR>\n";

 #    print FOUT "<tr><td></td><td align=middle><b>$m_total</b></td><td></td><td></td><td align=middle><b>$req_total</b></td><td align=middle><b>$access_total</b></td><td></td></tr>\n";
                print FOUT "<TR><TD COLSPAN=7>&nbsp;</TD></TR>\n";
        }
        close(FOUT);
        $m_total = 0;
        $req_total = 0;
        $access_total = 0;
        $inc -= 7;
        }
        
     $count_day++;
     
}

 $count_day--;
 close(INFILE);
 close(FLY); 

# fermeture de la page HTML du tableau sur les jours

for ($nblang=0;$nblang<=$#lang;$nblang++) {

$tabdays = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamedays;
open(FOUT, ">>$tabdays") || die "Error, unable to open $tabdays\n";
          
        print FOUT "</TABLE>\n";
        print FOUT "<P><HR><P>\n";    
        print FOUT "</BODY></HTML>\n";
        close (FOUT);
        }
}

# check if something have been log

if ($start_date eq '') {
print STDERR "Error : You choose to scan the $nbdays previous day\n";
print STDERR "        but the most recent day in the data file is only $jour_ecoule days old\n";
print STDERR "        Use the switch \"-d <days>\" with <days> from $jour_ecoule to ".($jour_ecoule+$count).".\n";
exit;
}


#################################################################
#####         requests, accesses and hosts graphs         #######
#################################################################

#################################################################
# Fly

#if (-x $FLY) {
$it = length($count_day)-1;
$div = 10**$it;
$factx = ($div*(int($count_day/$div)+1))/$grad;

$it = length($reqmax)-1;
$div = 10**$it;
$facty = ($div*(int($reqmax/$div)+1))/$grad;

$fymax = $ymax-1;

$perspec = $xstep/$factx if (($perspec > $xstep/$factx) && ($tridim == 1));

### image pour les abscisses

($startday, $startmonth) = split(/ /,$start_date);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);

$xlegend = "$count_day days (starting $start_date)";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<$xmax;$i+=$xstep) {
 $valstep = int(($i/$xmax)*(($xmax*$factx/$xstep)))+$startday;

 $moisvar = $startmonth;
 $valmois = $moischiffre;

 while  ($valstep > $month_of_year{$moisvar}) {
     $valstep = ($valstep - $month_of_year{$moisvar});
     $valmois++;
     $valmois = 0 if ($valmois > 11);
     $moisvar = $month_nb[$valmois];
 }

 $valstep = "0".$valstep if (length($valstep) == 1);
 $val = "$moisvar/$valstep";
 $posx = $i - length($valstep)*10;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$val\n";

 }
print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $file1x |");
while( <FOO> ) {print;}
close(FOO);

### image pour les ordonnees
 
open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=$ystep;$i<$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) * ($facty/$ystep));
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $file1y |");
while( <FOO> ) {print;}
close(FOO);

###

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n"; 
 for ($i=1;$i<=$count_day;$i++) {
 $x1 = ($i-1+$tridim)*$xstep/$factx;
 $x2 = ($i+$tridim)*$xstep/$factx;
 $y2 = $ymax - ($ystep/$facty * $reqmaxtot{$i});

 $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
 $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);


 if ($bargraph == 1) {
   $x2 -= $perspec if ($tridim == 1);
   $x1 -= $perspec if ($tridim == 1);
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
   $y1 = $ymax - ($ystep/$facty * $reqmaxtot{$i+1});
   print FLY "line $x1,$y2,$x2,$y1,$red[0],$green[0],$blue[0]\n";

   if ($fillgraph == 1) {
      if ($y1 != $y2 || $y2 != $ymax) {
        print FLY "line $x1,$ymax,$x1,$y2,$red[0],$green[0],$blue[0]\n";
        print FLY "line $x2,$ymax,$x2,$y1,$red[0],$green[0],$blue[0]\n";
        print FLY "line $x1,$ymax,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
        $fx1 = $x1+1;

        print FLY "fill $fx1,$fymax,$red[0],$green[0],$blue[0]\n";
     }
   }
 }
}

close (FLY);

open(FLY,">>$tmpfly");
 for ($i=1;$i<=$count_day;$i++) {

 $x1 = ($i-1+$tridim)*$xstep/$factx;
 $x2 = ($i+$tridim)*$xstep/$factx;

 $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
 $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);

 $x1 += $factx*$shift_factor;
 $x2 += $factx*$shift_factor;

 $y2 = $ymax - ($ystep/$facty * $accessmaxtot{$i});

 if ($bargraph == 1) {
   $x2 -= $perspec*2 if ($tridim == 1);
   $x1 -= $perspec*2 if ($tridim == 1);
   print FLY "frect $x1,$y2,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
   print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n"; 
   if ($tridim == 1 && $y2 != $ymax) {

        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;
      
        print FLY "fpoly $red[1],$green[1],$blue[1],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";

        print FLY "fpoly $red[1],$green[1],$blue[1],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";

   }
 }

 if ($linegraph == 1) {
    $y1 = $ymax - ($ystep/$facty * $accessmaxtot{$i+1});
    print FLY "line $x1,$y2,$x2,$y1,$red[1],$green[1],$blue[1]\n";

    if ($fillgraph == 1) {
      if ($y1 != $y2 || $y1 != $ymax) {
        print FLY "line $x1,$ymax,$x1,$y2,$red[1],$green[1],$blue[1]\n";
        print FLY "line $x2,$ymax,$x2,$y1,$red[1],$green[1],$blue[1]\n";
        print FLY "line $x1,$ymax,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
        $fx1 = $x1+1;
        print FLY "fill $fx1,$fymax,$red[1],$green[1],$blue[1]\n";
      }
    }
 }
}

close (FLY);

open(FLY,">>$tmpfly");
 for ($i=1;$i<=$count_day;$i++) {

 $x1 = ($i-1+$tridim)*$xstep/$factx;
 $x2 = ($i+$tridim)*$xstep/$factx;

 $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
 $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);

 $x1 += $factx*2*$shift_factor;
 $x2 += $factx*2*$shift_factor;

 $y2 = $ymax - ($ystep/$facty * $mmaxtot{$i});

 if ($bargraph == 1) {
   $x2 -= $perspec*3 if ($tridim == 1);
   $x1 -= $perspec*3 if ($tridim == 1);
   print FLY "frect $x1,$y2,$x2,$ymax,$red[2],$green[2],$blue[2]\n";
   print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n"; 
   if ($tridim == 1 && $y2 != $ymax) {

        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;

        print FLY "fpoly $red[2],$green[2],$blue[2],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";

        print FLY "fpoly $red[2],$green[2],$blue[2],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";

   }
 }

 if ($linegraph == 1) {
   $y1 = $ymax - ($ystep/$facty * $mmaxtot{$i+1});
   print FLY "line $x1,$y2,$x2,$y1,$red[2],$green[2],$blue[2]\n";

   if ($fillgraph == 1) {
    if ($y1 != $y2 || $y1 != $ymax) {
      print FLY "line $x1,$ymax,$x1,$y2,$red[2],$green[2],$blue[2]\n";
      print FLY "line $x2,$ymax,$x2,$y1,$red[2],$green[2],$blue[2]\n";
      print FLY "line $x1,$ymax,$x2,$ymax,$red[2],$green[2],$blue[2]\n";
      $fx1 = $x1+1;

      print FLY "fill $fx1,$fymax,$red[2],$green[2],$blue[2]\n";
    }
   }
 }
}

print FLY "transparent 200,200,200\n";

close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $file1 |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);


for ($nblang=0;$nblang<=$#lang;$nblang++) {

$fileday = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$filenameday;

open(FILEDAY,">$fileday") || die "Error, unable to open $fileday\n";
&DayStats(*FILEDAY, eval($Lang{$lang[$nblang]}), $lang[$nblang]);
close(FILEDAY);
}

unlink($tmpfly);

if ($precision > 2) {
 $optdirsize--;    # les tableaux commencent a l'element 0 !!!

for ($nblang=0;$nblang<=$#lang;$nblang++) {

$tabsize = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$filenametabsize;

open(TABSIZE,">$tabsize") || die "Error, unable to open $tabsize\n";
&TabDaySize(*TABSIZE, eval($Lang{$lang[$nblang]}),$nblang);
close(TABSIZE);
}
}

##############################################################
### creation du fichier contenant les stats pour les jours ###
##############################################################
sub DayStats {
 local(*FOUT, *L, $I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_aboutlastdays1'} $count_day $L{'Stats_aboutlastdays2'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-day.pl $version - $today $hourdate -->\n";	 
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<CENTER>\n";
print FOUT "<table border=0 width=100\%>\n";
print FOUT "<tr>\n";
print FOUT "<td align=left valign=center><B>$L{'Requests'},<br> $L{'Users'}</B><br><br>\n";
print FOUT "<B><A HREF=\"#graph1\">$L{'Graphic'}</A></B><br><br>\n";
print FOUT "<B><A HREF=\"$tabnamedays\">$L{'Text'}</A></B><br><br>\n";
print FOUT "<B><A HREF=\"..$dirsepurl$dirsession$dirsepurl$filemoyenne#moyjour\">$L{'Average'} $L{'by'} $L{'day'}</A></B><br><br>\n" if (-f "$path$I$dirsep$dirsession$dirsep$filemoyenne");
print FOUT "</TD>\n";
print FOUT "<td align=center>\n";
print FOUT "<table border=8 cellpadding=1><tr><td>\n";
print FOUT "<table border=8 cellpadding=3><tr><td>\n";
print FOUT "<table border=8 cellpadding=5><tr><td>\n";
print FOUT "<H1><center>$L{'Stats_aboutlastdays1'}<br>$count_day $L{'Stats_aboutlastdays2'}</center>\n";
print FOUT "</td></tr></table>\n";
print FOUT "</td></tr></table>\n";
print FOUT "</td></tr></table>\n";
print FOUT "</H1>\n";
print FOUT "</td>\n";
print FOUT "<td align=right valign=center>\n";

if ($precision > 2) {
        print FOUT "<B>$L{'Traffic_about'} <br>$L{'directories'}</B><br><br>\n";
        print FOUT "<B><A HREF=\"#graph2\">$L{'Graphic'}</A></B><br><br>\n";
        print FOUT "<B><A HREF=\"$filenametabsize\">$L{'Text'}</A></B><br><br>\n";
}
print FOUT "</td>\n";
print FOUT "</tr>\n";
print FOUT "</table>\n";
print FOUT "</center>\n";

print FOUT "<HR size=5><P>\n";
print FOUT "<A NAME=\"graph1\">\n";

#if (-x $FLY) {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkfile1y\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkfile1\" ALT=\"graph1\" USEMAP=\"#day1\" BORDER=0></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkfile1x\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "<TR><TD></TD>\n";
print FOUT "<TD ALIGN=CENTER>\n";

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[0]\" ALT=\"$gcolor[0]\"></A></TD>\n";
print FOUT "<TD>&nbsp; $L{'Number_of'} $L{'requests'}</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\" ALT=\"$gcolor[1]\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'Number_of'} $L{'HTMLPage_Acc'}</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\" ALT=\"$gcolor[2]\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'Number_of'} $L{'Conn_Mach'}</TD>\n";
print FOUT "</TR></TABLE>\n";

print FOUT "</TD></TR>\n";        
print FOUT "</TABLE></CENTER>\n";
#}


print FOUT "<P><HR>\n";
print FOUT "$L{'For_people'}\n";
print FOUT "$L{'there_is'} <A HREF=\"$tabnamedays\">$L{'table_of_data'}</A>\n";

if (($precision > 2) && (($#selecrepert) != -1)) {

print FOUT "<A NAME=\"graph2\">";
print FOUT "<HR><P>\n";

#if (-x $FLY) {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkfile2y\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkfile2\" ALT=\"graph2\" USEMAP=\"#day2\" BORDER=0></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkfile2x\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "<TR><TD></TD>\n";
print FOUT "<TD ALIGN=CENTER>\n";

print FOUT "<I>\n";
print FOUT "$L{'optdirsize1'}\n" if ($optdirsize == 1);
print FOUT "$L{'optdirsize2'}\n" if ($optdirsize == 2);
print FOUT "$L{'optdirsize3'}\n" if ($optdirsize == 3);
print FOUT "$L{'optdirsize4'}\n" if ($optdirsize == 4);
print FOUT "$L{'optdirsize5'}\n" if ($optdirsize == 5);
print FOUT "$L{'optdirsize6'}\n" if ($optdirsize == 6);
print FOUT "</I><P>\n";

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";

@tmprepert = @selecrepert;

print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$others\" ALT=\"$others\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'total_data_sent_for'} <B>$tri</B></TD>\n";
print FOUT "</TR>\n";

for ($i=$#selecrepert;$i>=0;$i--) {
        $cureper = pop(@tmprepert);
        $j = $i % ($#gcolor);
        $couleur = $gcolor[$j];
	if ($cureper ne $dirsepurl) {
        print FOUT "<TR><TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$couleur\" ALT=\"$couleur\"></TD>\n";
        print FOUT "<TD>&nbsp; $L{'data_sent_for_dir'} <B>$cureper</B></TD>\n";
        print FOUT "</TR>\n";
    }
}

print FOUT "</TABLE>\n";

print FOUT "</TD></TR>\n";        
print FOUT "</TABLE></CENTER>\n";
#}

}
print FOUT "<HR><P>\n";

# USEMAP Day1

$num = 1;
($jour, $monthletter,$year) = split(/ /,$start_date);

$month = $month_equiv{$monthletter};

print FOUT "<MAP NAME=\"day1\">\n";
open(FLY,"$tmpfly");
while (<FLY>) {

if ($_ =~ /^rect/ && $num <= $count_day) {
   ($tmp,$x1,$tmp,$x2) = split(/[ ,]/);
   $x1 = 0 if ($x1 < 0);
   $x1 = int($x1);
   $x2 = int($x2);

   if ($jour > $month_of_year{$monthletter}) {
      $month++;
      $year++ if ($month == 13);
      $month = 1 if ($month == 13);
      $jour = "01";
   }
   $jour = "0".$jour unless (length($jour) == 2);
   $month = "0".$month unless (length($month) == 2);
   $monthletter = $month_nb[$month-1];

# version vers les resumes heures par heures
#   $linkjour = "..".$dirsepurl.$dirdays.$dirsepurl.$jour."-".$monthletter.$htmlext;
#   $fulljour = $path.$lang[$nblang].$dirsep.$dirdays.$dirsep.$jour."-".$monthletter.$htmlext;

   $linkjour = "..".$dirsepurl.$dirdate.$dirsepurl.$year."-".$monthletter."-".$jour.$dirsepurl.$menu;
   $fulljour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$year."-".$monthletter."-".$jour.$dirsep.$menu;

print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$tabnamedays#$num\">\n" if (!(-e $fulljour));
print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$linkjour\">\n" if (-e $fulljour);

   $num++;
   $jour++;
}
}
print FOUT "</MAP>\n";

# USEMAP Day2

$num = 1;
($jour, $monthletter,$year) = split(/ /,$start_date);

$month = $month_equiv{$monthletter};

print FOUT "<MAP NAME=\"day2\">\n";
open(FLY,"$tmpfly");
while (<FLY>) {

if ($_ =~ /^rect/ && $num <= $count_day) {
   ($tmp,$x1,$tmp,$x2) = split(/[ ,]/);
   $x1 = 0 if ($x1 < 0);
   $x1 = int($x1);
   $x2 = int($x2);

   if ($jour > $month_of_year{$monthletter}) {
      $month++;
      $year++ if ($month == 13);
      $month = 1 if ($month == 13);
      $jour = "01";
   }
   $jour = "0".$jour unless (length($jour) == 2);
   $month = "0".$month unless (length($month) == 2);
   $monthletter = $month_nb[$month-1];

   $linkjour = "..".$dirsepurl.$dirdate.$dirsepurl.$year."-".$monthletter."-".$jour.$dirsepurl.$menu;
   $fulljour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$year."-".$monthletter."-".$jour.$dirsep.$menu;

print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$filenametabsize#$num\">\n" if (!(-e $fulljour));
print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$linkjour\">\n" if (-e $fulljour);

   $num++;
   $jour++;
}
}
print FOUT "</MAP>\n";

print FOUT "</BODY></HTML>\n";
}


###########################################################################
####              computing directories data traffic                  #####
###########################################################################

# Need for new format output including totsize
sub TabDaySize {
 local(*FOUT, *L, $langcount) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Tab_about_lastdays1'} $count_day $L{'Tab_about_lastdays2'}</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-day.pl $version - $today $hourdate -->\n";	 
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1> $L{'Tab_about_lastdays1'} $count_day $L{'Tab_about_lastdays2'}</H1><P>\n";
 print FOUT "<P><HR><P>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR>\n";
 print FOUT "<TH>Date</TH>\n";

 @tmprepert = @selecrepert;

 for ($i=0;$i<=$#selecrepert;$i++) {
 $cureper = shift(@tmprepert);
 print FOUT "<TH BGCOLOR=\"#E0E0E0\">$cureper<BR><I>($L{'Kb'})</I></TH>\n";
 }
 print FOUT "</TR>\n";

 open(IN, "$path$dirdata$dirsep$filerepertsize") || die "Error, unable to open $path$dirdata$dirsep$filerepertsize\n";

 $line = 0;
 $inc = 0;
 $count = 0;
 $count_day = 1;
 $count_week = 1;

 while (<IN>) {
     $line++;
     next unless ($line > 3);

     $count++;
        
     $oldjour = $jour;
     $oldmonth = $month;

    ($jour,$month,$year,@reste) = split('\s+');

     if ($nbdays != 0) {

     # nombre de jour depuis le 1er janvier
     
     $jour_of_year = 0;
     $countmonth = 0;
     $month_end = $month_nb[$countmonth];
     
     while ($month_end ne $month) {
       $jour_of_year += $month_of_year{$month_end};
       $countmonth++;
       $month_end = $month_nb[$countmonth];
       }
       
     $jour_of_year += $jour;
     $jour_ecoule = ($jour_of_year_end+($year_now-$year)*365) - $jour_of_year;     
#     $jour_ecoule = $jour_of_year_end - $jour_of_year;

     if ($jour_ecoule < 1) {
        $jour_ecoule += 365;
        $jour_ecoule += 1 if ($bisextil == 1); 
        }
     }

     next unless ($jour_ecoule <= $nbdays);

     $inc++;
     $day = $jour." ".$month." ".$year;  

     if ( $line == 4) {
       $start_date = $day;
     }

     ### test sur le jour suivant
    
     $intervalle = $jour - $oldjour;
     if ($intervalle != 1 && $line > 4) {
        if ($oldmonth ne $month) {
        $intervalle = $month_of_year{$oldmonth} - $oldjour; # suppose le mois suivant
        $intervalle += $jour;
             }
       $affmonth = $oldmonth;
       for ($i=$count;$i<($intervalle+$count-1);$i++) {
          $oldjour++;
          if ($oldjour > $month_of_year{$oldmonth}) {
                 $oldjour = 1;
                 $affmonth = $month;
                 } 
          
          $oldjour = "0".$oldjour unless (length($oldjour) == 2);

          $day = $oldjour." ".$affmonth." ".$year;

          print TABSIZE "<TR><TD ALIGN=CENTER BGCOLOR=\"#E0E0E0\"><A NAME=\"$count_day\">$day</TD>";
           for ($j=0;$j<=$#selecrepert;$j++) {
          print TABSIZE "<TD ALIGN=CENTER>0</TD>\n";
          }
          print TABSIZE "</TR>\n";
          $inc++;
            }
     $count+=$intervalle-1;
     $count_day += $intervalle-1;
     $line = $count;
     }

     $m_total += $m_tot;
     $req_total += $req_tot;
        
     # 1 mod 6 = html tot dir1#
     # 2 mod 6 = html ext dir1#
     # 3 mod 6 = html dom dir1#
     # 4 mod 6 = sizetot  dir1#
     # 5 mod 6 = sizetot ext dir1#
     # 6 mod 6 = sizetot dom dir1#
     # 7 mod 6 = html tot dir2#
     # ...... #

     $day = $jour." ".$month." ".$year;

    $linkjour = "..".$dirsepurl.$dirdate.$dirsepurl.$year."-".$month."-".$jour.$dirsepurl.$menu;
    $fulljour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$year."-".$month."-".$jour.$dirsep.$menu;

     print TABSIZE "<TR><TD ALIGN=CENTER BGCOLOR=\"#E0E0E0\"><A NAME=\"$count_day\">";
     print TABSIZE "<A HREF=\"$linkjour\">" if (-f $fulljour);
     print TABSIZE "$day";
     print TABSIZE "</A>" if (-f $fulljour);
     print TABSIZE "</TD>";
     
     for ($i=0;$i<=$#selecrepert;$i++) {
         $maxdir{$count_day,$i} = $reste[$i*6+$optdirsize];
# Need for new format output including totsize
         $max{$count_day} += $maxdir{$count_day,$i} if ($langcount == 0); 

         $kovalue = $reste[$i*6+$optdirsize]/1024;
         print FOUT "<TD ALIGN=CENTER>";
         printf FOUT "%.1f",$kovalue;
         print FOUT "</TD>";
         }

# Need for new format output including totsize
     $maxtot = $max{$count_day} if ($max{$count_day} > $maxtot);
     print FOUT "</TR>\n";

     $count_day++;
     
}

 $count_day--;

# fermeture de la page HTML du tableau sur les jours
 print FOUT "</TABLE>\n";
 print FOUT "<P><HR><P>\n";    
 print FOUT "</BODY></HTML>\n";
}

###########################################################################
####              directories data traffic graph                      #####
###########################################################################

#################################################################
# Fly

#if (-x $FLY) {

$it = length($count_day)-1;
$div = 10**$it;
$factx = ($div*(int($count_day/$div)+1))/$grad;
 
$it = length($maxtot)-1;
$div = 10**$it;
$facty = ($div*(int($maxtot/$div)+1))/$grad;
 
 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";

###

 for ($i=1;$i<=$count_day;$i++) {
 $x1 = ($i-1)*$xstep/$factx;
 $x2 = $i*$xstep/$factx;
 
 $y2 = $ymax - ($ystep/$facty * $maxdir{$i,0});
 $y1 = $ymax;

 $yfinal = $ymax - ($ystep/$facty * $sizetot{$i});
 
 if ($bargraph == 1) {
  print FLY "frect $x1,$y2,$x2,$y1,$red[0],$green[0],$blue[0]\n";
  print FLY "rect $x1,$y2,$x2,$y1,0,0,0\n";
   if ($tridim == 1 && $y2 != $ymax && ($y1-$y2) > 2) {

        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;
        $y1plus = $ymax-$perspec;

        print FLY "fpoly $red[0],$green[0],$blue[0],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";

#        if ($yfinal == $y1) {

#        print FLY "fpoly $red[0],$green[0],$blue[0],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
#        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
#        last;
#        }
        
   }
 }

 if ($linegraph == 1) {
   $y1 = $ymax - ($ystep/$facty * $maxdir{$i+1,0});
   print FLY "line $x1,$y2,$x2,$y1,$red[0],$green[0],$blue[0]\n";

   if ($fillgraph == 1) {
     if ($y1 != $y2 || $y1 != $ymax) {
       print FLY "line $x1,$ymax,$x1,$y2,$red[0],$green[0],$blue[0]\n";
       print FLY "line $x2,$ymax,$x2,$y1,$red[0],$green[0],$blue[0]\n";
       print FLY "line $x1,$ymax,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
       $fx1 = $x1+1;

       print FLY "fill $fx1,$fymax,$red[0],$green[0],$blue[0]\n";
     }
   }
 }


###

 for ($j=1;$j<=$#selecrepert;$j++) {

 $y1 = $y2;
 $y2 = $y2 - ($ystep/$facty * $maxdir{$i,$j});
 
 $ji = $j % ($#gcolor);

 if ($bargraph == 1) {
   print FLY "frect $x1,$y2,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
   print FLY "rect $x1,$y2,$x2,$y1,0,0,0\n";
   if ($tridim == 1 && ($y1-$y2) > 2) {

        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;
        $y1plus = $y1-$perspec;
        
        print FLY "fpoly $red[$ji],$green[$ji],$blue[$ji],$x2,$y1,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        print FLY "poly 0,0,0,$x2,$y1,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";

        if ($yfinal == $y1) {
        print FLY "fpoly $red[$ji],$green[$ji],$blue[$ji],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        last;
        }

   }

 }

 if ($linegraph == 1) {
    $y2 = $ymax - ($ystep/$facty * $maxdir{$i,$j});
    $y1 = $ymax - ($ystep/$facty * $maxdir{$i+1,$j});
    print FLY "line $x1,$y2,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";

    if ($fillgraph == 1) {
      if ($y1 != $y2 || $y1 != $ymax) {
       print FLY "line $x1,$ymax,$x1,$y2,$red[$ji],$green[$ji],$blue[$ji]\n";
       print FLY "line $x2,$ymax,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
       print FLY "line $x1,$ymax,$x2,$ymax,$red[$ji],$green[$ji],$blue[$ji]\n";
       $fx1 = $x1+1;

       print FLY "fill $fx1,$fymax,$red[$ji],$green[$ji],$blue[$ji]\n";
      }
     }
 }
 
}

###

if ($y1 != $yfinal) {

 $y1 = $y2;
 $y2 = $yfinal;
 
 if ($bargraph == 1) {
   print FLY "frect $x1,$y2,$x2,$y1,$red[100],$green[100],$blue[100]\n";
   print FLY "line $x1,$y2,$x1,$y1,0,0,0\n";
   if ($tridim == 1 && $y1 != $yfinal) {

        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;
        $y1plus = $y1-$perspec;

	if ($y1 < $y2) {
        print FLY "fpoly $red[100],$green[100],$blue[100],$x1,$y1,$x1plus,$y1plus,$x2plus,$y1plus,$x2,$y1\n";
        print FLY "poly 0,0,0,$x1,$y1,$x1plus,$y1plus,$x2plus,$y1plus,$x2,$y1\n";
    } else {
        print FLY "fpoly $red[100],$green[100],$blue[100],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
    }

        print FLY "fpoly $red[100],$green[100],$blue[100],$x2,$y1,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        print FLY "poly 0,0,0,$x2,$y1,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";

   }
 }

 if ($linegraph == 1) {
    $y2 = $ymax - ($ystep/$facty * $maxdir{$i,$j});
    $y1 = $ymax - ($ystep/$facty * $maxdir{$i+1,$j});
    print FLY "line $x1,$y2,$x2,$y1,$red[100],$green[100],$blue[100]\n";

    if ($fillgraph == 1) {
      if ($y1 != $y2 || $y1 != $ymax) {
       print FLY "line $x1,$ymax,$x1,$y2,$red[100],$green[100],$blue[100]\n";
       print FLY "line $x2,$ymax,$x2,$y1,$red[100],$green[100],$blue[100]\n";
       print FLY "line $x1,$ymax,$x2,$ymax,$red[100],$green[100],$blue[100]\n";
       $fx1 = $x1+1;

       print FLY "fill $fx1,$fymax,$red[100],$green[100],$blue[100]\n";
      }
     }
 }

}

}
print FLY "transparent 200,200,200\n";

close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $file2 |");
while( <FOO> ) {print;}
close(FOO);

### image pour les abscisses

($startday, $startmonth) = split(/ /,$start_date);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);

$xlegend = "$count_day days (starting $start_date)";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<$xmax;$i+=$xstep) {
 $valstep = int(($i/$xmax)*(($xmax*$factx/$xstep)))+$startday;

 $moisvar = $startmonth;
 $valmois = $moischiffre;

 while  ($valstep > $month_of_year{$moisvar}) {
     $valstep = ($valstep - $month_of_year{$moisvar});
     $valmois++;
     $valmois = 0 if ($valmois > 11);
     $moisvar = $month_nb[$valmois];
 }

 $valstep = "0".$valstep if (length($valstep) == 1);
 $val = "$moisvar/$valstep";
 $posx = $i - length($valstep)*10;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$val\n";

 }
print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $file2x |");
while( <FOO> ) {print;}
close(FOO);

### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("Kbytes 5total added)")*2));

 if ($maxtot > 1024*1024) {
 print FLY "stringup 0,0,0,5,$posy,medium,Mbytes (Total added)\n";
 } else {
 print FLY "stringup 0,0,0,5,$posy,medium,Kbytes (Total added)\n";
 }
 for ($j=$ystep;$j<$ymax;$j+=$ystep) {
 $valstep = int(($ymax - $j) * ($facty/$ystep));
 $valstep /= 1024; # in Kb
 $valstep /= 1024 if ($maxtot > (1024*1024));
 $valstep = int($valstep*10)/10;
 $valstep .= ".0" if ($valstep !~ /\./);
 $pos = ($xdecal - length($valstep)*11);
 $posy = $j-5;
 print FLY "line $xdecalm,$j,$xdecal,$j,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }

print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $file2y |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

# calculer le temps mis pour le calcul

$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
($hour,$minute,$second) = split(/:/,$hourdate);

$endrun = "$hour:$minute:$second";

($min,$sec) = &timetaken($startrun,$endrun);

$endtime = time();
#printf STDOUT "Computing took %d CPU secondes\n",$endtime - $starttime;
#print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET"); 
print STDOUT "Real time took $min min $sec sec\n\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET"); 

$today =~ s/ /\//g;

open(FILE,">>$history");
#print FILE "cron-day\t$today\t$startrun\t$endrun\t$min:$sec\n";
printf FILE "cron-day\t%s\t%s\t%s\t%d:%d\n",$today,$startrun,$endrun,$min,$sec;
close(FILE);

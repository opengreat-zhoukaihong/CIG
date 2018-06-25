#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                     SESSIONS STATS                             #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 20/08/2000     #####
####                                                                #####
#########################################################################

$version = "2.72";
$verdate = "20/08/00";

############ script to launch when you want ##########

## valeur a modifier par fixperlpath.pl

require "/usr/local/etc/w3perl/cgi-bin/w3perl/libw3perl.pl";

# tres petit bug :
# lorsque une meme machine a le meme nombre de requete pendant
# une session de meme duree...ecrasement de l'ancienne.

$starttime = time();
print "Session stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#$datesyst = &ctime(time);
#($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
#($hour,$minute,$second) = split(/:/,$hourdate);

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

# limitation :
# suppose que le dernier jour du logfile est la date d'aujourd'hui
$thisdayinc = (localtime)[6];

# doit retourner la date du derniere date du logfile
# 1 pou lundi.
# trouver le jour (lundi, mardi..) de $jour juste apres le scan des robots.
# 10/May/1997 ==> day_of_week

if ($zipcut == 2) {
$monthtmp = $month;
$filetmpzip = $fileroot;
$month = $month_equiv{$month};
$month = "0".$month if (length($month) == 1);
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
$compressed_logfile_fields[$i] =~ s/\%/\$/;
$filetmpzip .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}
$filetmpzip = $filetmpzip.$zipext if ($zip == 1);
$month = $monthtmp;
}

$day--;
if ($day < 1) {
     $countmonth--;
     $year-- if ($countmonth < 0);
     $countmonth = 11 if ($countmonth < 0);
     $month = $month_nb[$countmonth];
     $day = $month_of_year{$month};
     }

$day = "0".$day if (length($day) == 1);

$yesterday = "$day"."/"."$month"."/"."$year";
$yesterday =~ s/[\/]/ /g;

#################################################################
####          debut de l'initialisation                   #######
#################################################################

# only session longuer than $seuilt will be displayed
$seuilt = 5; # 5 minute

# maximum time for one session
$tlim = 60 * 10; # 10 heures

# maximum reading time for a HTML page
$tleclim = 30; # 30 minutes

if ($tleclim > $tlim) {
print STDOUT "Assuming no restriction about the reading time...\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
$tleclim = $tlim;
}

#################################################################
####          debut de l'initialisation                   #######
#################################################################

$reqtot = 0;
$av1 = 1;
$av2 = 1;
$sessionnblocal = 0;
$sessionnb = 0;
$nbtotdays = 0;
$incjour = 0;
$diff = 1;
$maxreqhour = 0;
$maxreqjour = 0;
$sessionlocal = 0;
$depassetlim = 0;
$depasseleclim = 0;
$sessionjour = 0;
$sessionrobot = 0;

$dir = $path.$dirinc;
mkdir ($dir,0775) unless -d $dir;

#################################################################
###            parsing the command line option                ###
#################################################################

$robotscan = 0;

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -a                    : include full robot session report\n";
      print STDOUT "        -c <file>             : load configuration file\n"; 
      print STDOUT "        -d <nbdays>           : number of days to display\n";
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
      print STDOUT "        -i <file>             : input log file\n"; 
      print STDOUT "        -m                    : update only robot host detection\n";
      print STDOUT "        -t <minutes>          : session maximum length\n"; 
      print STDOUT "        -r <minutes>          : maximum time to read a page (timeout)\n";
      print STDOUT "        -s <minutes>          : display session longer than this value\n";
      print STDOUT "        -u                    : bypass robot host detection\n";
      print STDOUT "        -j <date>             : starting date (dd/Mmm/yyyy)\n";
      print STDOUT "        -q <date>             : ending date (dd/Mmm/yyyy)\n";
      print STDOUT "        -v                    : version\n";
      print STDOUT "        -x                    : show default value for flag options\n";
      print STDOUT "        -z                    : zip logfiles\n";      
      print STDOUT "\n";
      exit;
}

if ($opt_v == 1) {
      print STDOUT "cron-session.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -a            : ";
      &id($robotscan);
      print STDOUT "          -c            : $configfile\n";
      print STDOUT "          -d <days>     : $nbdays\n";
      print STDOUT "          -g <graphic>  : $graphic[0]\n";
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDOUT "          -i <file>     : $file\n";
      print STDOUT "          -m            : ";
      &id($opt_m);
      print STDOUT "          -t <minutes>  : $tlim\n";
      print STDOUT "          -u            : ";
      &id($opt_u);
      print STDOUT "          -r <minutes>  : $tleclim\n";
      print STDOUT "          -s <minutes>  : $seuilt\n";
      print STDOUT "          -j <date>     : $firstjour\n";
      print STDOUT "          -q <date>     : $yesterday\n";
      print STDOUT "          -v            : $version\n";
      print STDOUT "          -z            : ";
      &id($opt_z);       
      exit;
}

if ($opt_z ne '') {
$zip = $opt_z;
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


if ($opt_a == 1) {
$robotscan = 1;
}

if ($opt_d ne '') {
$nbdays = $opt_d;
}

if ($opt_i ne '') {
$file = $opt_i;
}

if ($opt_t ne '') {
$tlim = $opt_t; 
}

if ($opt_r ne '') {
$tleclim = $opt_r; 
}

if ($opt_s ne '') {
$seuilt = $opt_s; 
}

if ($opt_j ne '') {

if ($opt_j !~ /(\d{2})\/(\w{3})\/(\d{4})/) {
print STDERR "Not a valid starting date format (valid format is for example 02/May/1995)\n";
exit;
} else {

if ($1 < 1 || $1 > 31) {
print STDERR "Day should be between 1 and 31 !\n";
exit;
}

$day = $1;
$lettermonth = $2;
$month = $month_equiv{$lettermonth};
$month = "0".$month if (length($month) == 1);
if ($month < 1 || $month > 12) {
print STDERR "Month should be between Jan and Dec !\n";
exit;
}

$year = $3;
$fyear = $3;
if ($fullyear < $3) {
print STDERR "Year should be less than the current date !\n";
exit;
}

$file = $fileroot;

$smallyear = $year - int($year/100)*100;       
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
    $compressed_logfile_fields[$i] =~ s/\%/\$/;
    $file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}            
$filezip = $file.$zipext if ($zip == 1);

($testday,$testmonth,$testyear) = split(/\//,$opt_j);
$testmonth = $month_equiv{$testmonth};

$testjour = 0;
$countmonth = 0;

while ($countmonth != ($testmonth-1)) {
     $testjour += $month_of_year{$month_nb[$countmonth]};
     $countmonth++;
     $countmonth ="0".$countmonth if (length($countmonth) == 1);
     }

$testjour += $testday;
$tmp4 = $testjour;
$tmpyear = $testyear;

$startday = $opt_j;

if (($testyear < $yearstart) || ($testjour < $ydaystart && $testyear == $yearstart)) {
print STDERR "Error ! Logfile is beginning later !\nI will compute from $firstjour instead\n";
$startday = $firstjour;

($day,$lettermonth,$year) = split(/\//,$firstjour);
$month = $month_equiv{$lettermonth};
$month = "0".$month if (length($month) == 1);

$file = $fileroot;
$smallyear = $year - int($year/100)*100;              
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
    $compressed_logfile_fields[$i] =~ s/\%/\$/;
    $file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
    }            
$filezip = $file.$zipext if ($zip == 1);
}
}
}

$stopday = $today;

if ($opt_q ne '') {

if ($opt_q !~ /(\d{2})\/(\w{3})\/(\d{4})/) {
print STDERR "Not a valid ending date format (valid format is  for example 02/May/1995)\n";
exit;
} else {

if ($1 < 1 || $1 > 31) {
print STDERR "Day should be between 1 and 31 !\n";
exit;
}

$b = int($2);

$tmp = $month_equiv{$2};
$tmp = "0".$tmp if (length($tmp) == 1);
if ($tmp < 1 || $tmp > 12) {
print STDERR "Month should be between Jan and Dec !\n";
exit;
}

if ($fullyear < $3) {
print STDERR "Year should be less than the current date !\n";
exit;
}

($testday,$testmonth,$testyear2) = split(/ /,$yesterday);

$testjour2 = 0;
$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $testmonth) {

     $testjour2 += $month_of_year{$month_end};
     $countmonth++;
     $month_end = $month_nb[$countmonth];
     }

$testjour2 += $testday;

($testday,$testmonth,$testyear) = split(/\//,$opt_q);
$testmonth = $month_equiv{$testmonth};

$testjour = 0;
$countmonth = 0;

while ($countmonth != ($testmonth-1)) {
     $testjour += $month_of_year{$month_nb[$countmonth]};
     $countmonth++;
     $countmonth ="0".$countmonth if (length($countmonth) == 1);
     }

$testjour += $testday;
$stopday = $opt_q;

if ($testjour2 < $testjour && $testyear2 == $testyear) {
print STDERR "Error ! Cannot compute futur !\nI will compute till $yesterday instead\n" ;
$stopday = $yesterday;
$stopday =~ s/ /\//g;
}

if ($testyear > $testyear2) {
print STDERR "Error ! Cannot compute futur !\nI will compute till $yesterday instead\n" ;
$stopday = $yesterday;
$stopday =~ s/ /\//g;
}

}
}


if ($opt_j ne '' && $opt_q ne '') {
#print STDERR "LOGFILE : $firstjour - $yesterday\n";
#print STDERR "USER : $opt_j - $opt_q\n";
#print STDERR "DATE : $startday - $stopday\n";

if ($testyear < $tmpyear) {
print STDERR "Ending date should be later than the starting date !\n";
exit;
}

if ($testjour < $tmp4 && $testyear == $tmpyear) {
print STDERR "$testjour < $tmp4 && $testyear == $tmpyear Ending date should be later than the starting date !\n";
exit;
}

}
 
### create directory

$tmp = $path;
chop($tmp);
mkdir ($tmp,0775) unless -d $tmp;

$dir = $path.$dirtmp;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirgraph;
mkdir ($dir,0775) unless -d $dir;

#$dir = $path.$dirdata;
#mkdir ($dir,0775) unless -d $dir;

for ($nblang=0;$nblang<=$#lang;$nblang++) {
$dir = $path.$lang[$nblang];
mkdir ($dir,0775) unless -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirdate;
mkdir ($dir,0775) unless -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirsession;
$tmp2 = $dir.$dirsep;
mkdir ($dir,0775) unless -d $dir;
unlink(<$dir$dirsep*>);
#$dir = $path.$lang[$nblang].$dirsep.$dirsession.$dirsep.$dirdate;
#mkdir ($dir,0775) unless -d $dir;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>);
}

###

#print STDOUT "Deleting old data...\n";
#print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
#for ($nblang=0;$nblang<=$#lang;$nblang++) {
#$dir = $path.$lang[$nblang].$dirsep.$dirdate;
#&dodirdel($dir);
#}
#unlink(@tmp); # Delete files
#for ($i=0;$i<=$#tmpdir;$i++) {
#rmdir($tmpdir[$i]);  # Delete directories
#}
#sub dodirdel {
#    local($dir) = @_;
#    local($i,@filenames);
#if (-f $dir) {
#opendir(SOURCEDIR,$dir);
#@filenames = readdir(SOURCEDIR);
#closedir(SOURCEDIR);
#for ($i=0;$i<=$#filenames;$i++) {
#if (-f "$dir$dirsep$filenames[$i]") {
#    push(@tmp,"$dir$dirsep$filenames[$i]") if ($filenames[$i] eq "$dirsession$htmlext");
#}
#if (-d "$dir$dirsep$filenames[$i]" && $filenames[$i] ne '.' && $filenames[$i] ne '..') {
#    push(@tmpdir,"$dir$dirsep$filenames[$i]");
#    chdir "$dir$dirsep$filenames[$i]";
#    &dodirdel("$dir$dirsep$filenames[$i]");
#    chdir '..';
#    }
#}
#}
#}

###

$dureesession = "duree".$htmlext;
$filesites = "sites".$htmlext;

$filerobot = "robots".$htmlext;
$filetime = "time".$htmlext;
$filevisit = "visite".$htmlext;
$filelogin = "login".$htmlext;
$fileaverage = "pages".$htmlext;

$sessionima = $path.$dirgraph.$dirsep."session".$gifext;
$sessionimax = $path.$dirgraph.$dirsep."sessionx".$gifext;
$sessionimay = $path.$dirgraph.$dirsep."sessiony".$gifext;
$linksessionima = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."session".$gifext;
$linksessionimax =  "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."sessionx".$gifext;
$linksessionimay =  "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."sessiony".$gifext;

$heureima = $path.$dirgraph.$dirsep."heure".$gifext;
$heureimax = $path.$dirgraph.$dirsep."heurex".$gifext;
$heureimay = $path.$dirgraph.$dirsep."heurey".$gifext;
$linkheureima =  "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."heure".$gifext;
$linkheureimax =  "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."heurex".$gifext;
$linkheureimay =  "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."heurey".$gifext;

$jourima = $path.$dirgraph.$dirsep."jour".$gifext;
$jourimax = $path.$dirgraph.$dirsep."jourx".$gifext;
$jourimay = $path.$dirgraph.$dirsep."joury".$gifext;
$linkjourima = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."jour".$gifext;
$linkjourimax = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."jourx".$gifext;
$linkjourimay = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."joury".$gifext;

$deltaima = $path.$dirgraph.$dirsep."delta".$gifext;
$deltaimax = $path.$dirgraph.$dirsep."deltax".$gifext;
$deltaimay = $path.$dirgraph.$dirsep."deltay".$gifext;
$linkdeltaima = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."delta".$gifext;
$linkdeltaimax = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."deltax".$gifext;
$linkdeltaimay = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."deltay".$gifext;

$visiteima = $path.$dirgraph.$dirsep."visite".$gifext;
$visiteimax = $path.$dirgraph.$dirsep."visitex".$gifext;
$visiteimay = $path.$dirgraph.$dirsep."visitey".$gifext;
$linkvisiteima = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."visite".$gifext;
$linkvisiteimax = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."visitex".$gifext;
$linkvisiteimay = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."visitey".$gifext;

####################

if ($exclude_frame == 1) {
    if (-f "$path$dirdata$dirsep$dirframe") {
open(FILEFRAME,"$path$dirdata$dirsep$dirframe") || die "Error, unable to open $path$dirdata$dirsep$dirframe\n";
while (<FILEFRAME>) {
    chop;
push(@exclude_page_frame,$_);
}
#chop($exclude_page_frame);
close(FILEFRAME);

    if ($#exclude_page_frame == -1) {
	$exclude_frame = 0;
	print STDERR "No HTML frame pages found !\n";
    }

} else {
    print "Use cron-url.pl first to detect framed pages\n";
    exit;
}
}

#################################################################
### today date

#$datesyst = &ctime(time);
#($dayletter,$month,$day,$hourdate,$a,$year) = split(/\s+/,$datesyst);
#$year = $a if ($year eq '');
#$day = "0".$day if (length($day) == 1);
#($hour,$minute) = split(/:/,$hourdate);
$today = $day." ".$month." ".$year;

$month_number = $month_equiv{$month};
$month_number--;
$daytmp = $day;

### GZIP VERSION HERE

if (($zip == 1 || $zipcut != 0) && $opt_j eq '') {

$month = $monthindex;
$monthprev = $month-1;
$yyear = $year;
$year = $fyear;

   # detection du premier mois de log zipe

#   do {
while ($out == 0) {
#while (!(-e $filezip) || !(-e $file)) {
	if ($zipcut == 2) {
		$day++;
	        $day = "0".$day if (length($day) == 1);
		if ($day > $month_of_year{$month_nb[$monthprev]}) {
			$month++;
			$monthprev++;
			$day = "01";
			}
		}
       $month++ if ($zipcut == 1);
       $monthprev++ if ($zipcut == 1);       
       $month = "0".$month if (length($month) == 1);
       $year++ if ($month == 13);
       $month = "01" if ($month == 13);
       $monthprev = 0 if ($month == 1);       
       $lettermonth = $month_nb[$monthprev];       
       if ($year ==  $fullyear && $month > $monthindex && $zipcut != 0) {
            print "No gziped files found !\n" if ($zip == 1);
            print "No log files found !\n" if ($zip != 1);
#            print "Use zip=0 in config.pl.\n";
            exit;
            }
            
       $file = $fileroot;
       
	$smallyear = $year - int($year/100)*100;
        $smallyear = "0".$smallyear if (length($smallyear) == 1);
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}
          $out = 1 if (-e $file && $zip == 0); 
       $filezip = $file.$zipext if ($zip == 1);
	$out = 1 if (-e $filezip && $zip == 1);
     }
#        until (-e $filezip || -e $file);

   $lastfile = $file;
   $lastfilezip = $filezip;
   $stop = 0;
   $fyear = $year;
   $year = $yyear;   
}

$day = $daytmp;


#################################################################
###            time to scan the log file                      ###
#################################################################

if ($zip != 1) {
open(INFILE, $file) || die "Error, unable to open $file\n";
} else {
open(INFILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
}

###### date de depart

$scalar = (<INFILE>);
while ($scalar =~ /^#/) {
$scalar = (<INFILE>);
}

 @line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

# @line_log = split(/[ \t\n\[]+/,$scalar);
# $date = $line_log[$fields_logfile{'%date'}];

#($adresse,$a,$b,$date)=split(/[ \t\n\[]+/,$scalar);
($firstjour) = split(/:/,$date);
($jourstart,$monthstart,$yearstart) = split(/\//,$firstjour);

# calcul le nombre de jour

$ydaystart = 0;

$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $monthstart) {
  $ydaystart += $month_of_year{$month_end};
  $countmonth++;
  $month_end = $month_nb[$countmonth];
  }

$ydaystart += $jourstart;

# taille du fichier de log

($size)= (stat("$file")) [7];

$offset = int($size - 1024);
seek(INFILE,$offset,0);

$scalar = (<INFILE>);
$scalar = (<INFILE>);

# @line_log = split(/[ \t\n\[]+/,$scalar);
# $date = $line_log[$fields_logfile{'%date'}];

 @line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);
 
#($adresse,$a,$b,$date)=split(/[ \t\n\[]+/,$scalar);
($lastjour) = split(/:/,$date);
($dayfinale,$monthfinale,$yearfinale) = split(/\//,$lastjour);

$ydayfinale = 0;

$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $monthfinale) {
  $ydayfinale += $month_of_year{$month_end};
  $countmonth++;
  $month_end = $month_nb[$countmonth];
  }

$ydayfinale += $dayfinale;

close (INFILE);

# nbre de jours total

$intervalleday = ($yearfinale - $yearstart)*365 + ($ydayfinale - $ydaystart)+1;
if ($intervalleday > 19) {
$starstep = $intervalleday/20; # 5% step
$bigstarstep = $intervalleday/4; # 25% step
}

#}

#################################################################
#####                  loading robot file                  ######
#################################################################

### Pour la version incrementale

#if ($mode_incremental_done) {

if ($opt_m eq '' || $opt_u ne '') {
if (-f "$path$dirinc$dirsep$incrobot") {
open(ROBOT,"$path$dirinc$dirsep$incrobot") || die "Error, unable to open $path$dirinc$dirsep$incrobot\n";

while (<ROBOT>) {
    chop;
($a,$adresse,$chiffre,$b,$c) = split(/\t/);
if ($adresse eq '') {
	print "Your robot file is not valid (too old). Run 'cron-session.pl -m' to update it\n";
	exit;
}
$robotname{$adresse} = $a;
$reqrobot{$adresse} = $chiffre;
$visrobot{$adresse} = $b;
$daterobot{$adresse} = $c;


### WARNING : REGEXP TOO BIG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

$robot .= $adresse."|" unless $seen{"$adresse $a"}++;
$sessionrobot += $b;
}
close ROBOT;
chop($robot);
}
}
#}

#############################################################################

### date il y a $nbdays jours

if ($nbdays != 0 ) {
if ($opt_d ne '' || $opt_u ne '') {

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

if ($zip == 1 || $zipcut != 0) {
$pastmonthnb = $month_equiv{$pastmonth};
$pastmonthnb = "0".$pastmonthnb if (length($pastmonthnb) == 1);
$pastday = "0".$pastday if (length($pastday) == 1);

$month = $pastmonthnb;
$fyear = $year;
$year = $pastyear;
$day = $pastday;
$lettermonth = $pastmonth;
#$file = $fileroot.$prefixlog.".".$pastmonthnb."-".$pastyear;
#$filezip = $fileroot.$prefixlog.".".$pastmonthnb."-".$pastyear.".gz";

       $file = $fileroot;
       $smallyear = $year - int($year/100)*100;
       $smallyear = "0".$smallyear if (length($smallyear) == 1);
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}            
       $filezip = $file.$zipext if ($zip == 1);
       
if (!(-e $filezip) && $zip == 1) {
    print STDERR "$filezip doesn't exist...\n";
    while (!(-f $filezip)) {

	$monthprev = $month-1;
	if ($zipcut == 2) {
		$day++;
	        $day = "0".$day if (length($day) == 1);
		if ($day > $month_of_year{$month_nb[$monthprev]}) {
			$month++;
			$monthprev++;
			$day = "01";
			}
		}
       $month++ if ($zipcut == 1);
       $monthprev++ if ($zipcut == 1);       
       $month = "0".$month if (length($month) == 1);
       $year++ if ($month == 13);
       $month = "01" if ($month == 13);
       $monthprev = 0 if ($month == 1);
       $lettermonth = $month_nb[$monthprev];             
       if ($year ==  $fullyear && $month > $monthindex && $zipcut != 0) {
            print "No gziped files found !\n";
            print "Use zip=0 in config.pl.\n";
            exit;
            }
       $file = $fileroot;
       $smallyear = $year - int($year/100)*100;
       $smallyear = "0".$smallyear if (length($smallyear) == 1);
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}            
       $filezip = $file.$zipext if ($zip == 1);

}

    print STDERR "First available file is : $filezip\n";
}

if (!(-e $file) && $zip != 1) {
    print STDERR "$file doesn't exist...choose a more recent date\n";
    exit;
}

}

print "Today is $today\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "$nbdays days ago, we were $pasttoday\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
        

}
}

&load_reverse_dns if ($reverse_dns == 1); # chargement de la table de DNS

#################################################################
#####               scanning robot in the log file         ######
#################################################################

#if ($session_engine == 1) {

($ds1,$ds2,$ds3) = split('/',$startday);
($de1,$de2,$de3) = split('/',$stopday);
$mds2 = $month_equiv{$ds2};
$mde2 = $month_equiv{$de2};

#print "START : $startday - END : $stopday\n";

if ($opt_u eq '') {

#while ($numbermoisgzip != 12) {
while ($stop == 0) {

print STDOUT "Scanning robots : $file ";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

print STDOUT "(* = 5%)" if ($intervalleday > 19);
print STDOUT "\n";

### Boucle principale

if (($zip == 1) && ($file ne $filezip)) {
       open(FILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
#       print STDOUT "Fichier $filezip decompresse\n";
#       print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

    } else {
           open(FILE,$file) || die "Error, unable to open $file\n";
      }


BOUCLE:
while (<FILE>) {

$loglines++;

 @line_log = split(/$logfile_sep/);

 next if ($line_log[0] =~ /^#/);
 
 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);
 $d = $line_log[$fields_logfile{'%method'}];
 $status = $line_log[$fields_logfile{'%status'}];
 $adresse = $line_log[$fields_logfile{'%host'}];
 $page = $line_log[$fields_logfile{'%page'}];
 $from = $line_log[$fields_logfile{'%referer'}];

 $adresse = $nis{$adresse} if ($nis{$adresse} ne '');
 $adresse = &reversedns($adresse) if ($reverse_dns == 1 && $adresse =~ /^[0-9.]+$/);
 $adresse = $adresse.".".$localdomainename if (split(/[.]/,$adresse) == 1);

# $vserver = $line_log[$fields_logfile{'%virtualhost'}] if ($fields_logfile{'%virtualhost'} ne '');
 $page =~ s/\/\/$virtualfilter// if (($virtualCLF != 0 && $virtualfilter ne '') || ($d =~ /$localserver/));
 $page =~ s/\"// if ($requetesize !~ /(\d+)/);
    next if ($status !~ /^(\d+)$/);
    next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
    next if ($page =~ /"$/ && $iis_format != 1); # all format should be %page %protocol
    next if ($d !~ /^\"/ && $iis_format != 1); # all format should be %page %protocol
next if ($adresse eq '');
if ($adresse =~ /\//) {
    ($tmp,$adresse) = split(/:/,$adresse);
    print "Problem : found $tmp ... fixing done\n";
}

if ($opt_j ne '' || $opt_q ne '') {
($fa) = split(':',$date);
($fa1,$fa2,$fa3) = split('/',$fa);
$stop = 1 if ($fa3 > $de3);
next if ($fa3 < $ds3 || $fa3 > $de3);
$mequiv = $month_equiv{$fa2};
$stop = 1 if ($fa3 == $de3 && $mequiv > $mde2);
next if (($fa3 == $ds3 && $mequiv < $mds2) || ($fa3 == $de3 && $mequiv > $mde2));
$stop = 1 if ($fa3 == $de3 && $mequiv == $mde2 && $fa1 > $de1);
next if (($fa3 == $ds3 && $mequiv == $mds2 && $fa1 < $ds1) || ($fa3 == $de3 && $mequiv == $mde2 && $fa1 > $de1));
}

($tmp) = split(/:/,$date);
($daytoday,$monthtoday,$yeartoday) = split(/\//,$tmp);

next if ($month_equiv{$monthtoday} !~ /(\d+)/);
next if (length($yeartoday) != 4);

if ($prefixlog eq $referlog) {
    $i = $fields_logfile{'%agent'};
    $f = $line_log[$i];

     if ($f !~ m/\"/) {
       $f2 = '';
       $tmpi = $i + 1;
       $f3 = $line_log[$tmpi]." ";
       while ($f3 !~ /\-\s+/ && $f3 !~ /http:\/\//i && $f3 ne ' ') {
       $f2 .= $f3;
       $tmpi++;
       $f3 = $line_log[$tmpi]." ";

       }
     $f .= " ".$f2;
     }
$f =~ s/\n//;
$f =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
$from = $line_log[$tmpi];
}

#print "A : $from \n";
next if ($from !~ m/http:\/\//i && $from ne '' && prefixlog eq $referlog);
 

next if ($date !~ m/^((\d+)\/(\w+)\/(\d\d\d\d):)(.*)/);

if ($opt_d ne '') {
($fa) = split(':',$date);
($fa1,$fa2,$fa3) = split('/',$fa);
next if ($fa3 < $pastyear);
$mequiv = $month_equiv{$fa2};
next if ($fa3 == $pastyear && $mequiv < $pastmonthnb);
next if ($fa3 == $pastyear && $mequiv == $pastmonthnb && $fa1 < $pastday);
}

($jour,$heure,$minute) = split(/:/,$date);

$oldjour = $date if ($oldjour eq '');


if ($jour ne $oldjour) {

$jour =~ s/\// /g;
$yday = &nbdayan($jour);
$oldjour =~ s/\// /g;

$ydayold = &nbdayan($oldjour);
$diff = $yday - $ydayold;
$diff += $ydayold if ($diff < 0 && $diff < -1); # && $yday == 1);
#print "$yday $jour $diff $ydayold\n" if ($diff < 0);
#$diff = int($diff);

$nbtotdays += $diff;
$oldjour = $jour;
}

next if ($session_engine != 1);

# robot checking (before excluding no html files

if ($page eq "/robots.txt") {
$sessionrobot++;
$robotname{$adresse} = "$f" if ($prefixlog eq $referlog);
$robotname{$adresse} = $adresse if ($prefixlog ne $referlog);
$robotname{$adresse} =~ s/\"//g;
$visrobot{$adresse}++;
$daterobot{$adresse} = $jour;
#$robot .= $adresse if ($visrobot{$adresse} == 1 && $sessionrobot == 1);
push(@exclude_robot_address,$adresse) if ($visrobot{$adresse} == 1);
#$robot .= "|".$adresse if ($visrobot{$adresse} == 1 && $sessionrobot != 1);
#print STDERR "$adresse\n";
$reqrobot{$adresse} = 0 if ($reqrobot{$adresse} eq '');
}

ROB:
    for ($i=0;$i<=$#exclude_robot_address;$i++) {
	if ($adresse eq $exclude_robot_address[$i]) {
	    $reqrobot{$adresse}++;
	    last ROB;
	}
    }

#$reqrobot{$adresse}++ if ($adresse =~ /$robot/i);
}


close (FILE);

# mois gzip suivant

$stop = 1 if (($zip != 1 && $zipcut == 0) || ($file eq $filezip));

if ($zip == 1 || $zipcut != 0) {

    $day = $jour;
$yyear = $year;
$year = $fyear;

&nextlog;

if ($zip == 0) {
    if ($zipcut == 2) {
    &nextlog while (!(-f $file) && $file ne $filetmpzip);
$stop = 1 if ($file eq $filetmpzip);
}
}

if ($zip == 1) {
   if (-e $filezip) {
       } else {
  if ($zipcut == 2) {
	&nextlog while (!(-f $filezip) && $filezip ne $filetmpzip);
	$stop = 1 if ($filezip eq $filetmpzip);

    } else {
          $filezip = $fileroot.$prefixlog;
          $file = $fileroot.$prefixlog;
          $stop = 1 if (!(-f $file));
      }
    }
} else {
   if (-e $file && $zipcut != 0) {
   } else {
          $stop = 1 if (!(-f $file));
   }
}


   $fyear = $year;
   $year = $yyear;    
}

}
#}

#################################################################
#####                   saving robot file                  ######
#################################################################


if ($sessionrobot != 0) {
    if ($opt_m ne '') {
    open(ROBOT,">>$path$dirinc$dirsep$incrobot") || die "Error, unable to open $path$dirinc$dirsep$incrobot\n";
} else {
open(ROBOT,">$path$dirinc$dirsep$incrobot") || die "Error, unable to open $path$dirinc$dirsep$incrobot\n"; # if ($opt_m ne '');
}
foreach $adresse (keys(%robotname)) {
  if ($reqrobot{$adresse} ne '') {
      print ROBOT "$robotname{$adresse}\t$adresse\t$reqrobot{$adresse}\t$visrobot{$adresse}\t$daterobot{$adresse}\n";
	}
}
close ROBOT;
}

if ($opt_m ne '') {
print "Robot detection have been updated\n" if ($sessionrobot != 0);
print "No new robot session have been found !\n" if ($sessionrobot == 0);
print "Session stats not computed\n";
exit;
}

#################################################################


### date il y a $nbdays jours

$jour = $firstjour if ($jour eq '');
$jour =~ s/\// /g; 
($day,$month,$year) = split(' ',$jour);

if (($year < $pastyear) || ($month_equiv{$month} < $month_equiv{$pastmonth} && $year == $pastyear) || ($day <= $pastday && $month eq $pastmonth && $year == $pastyear) || ($nbdays != 0)) {

### Uncomment this to get stats over the full range
#$nbdays = $nbtotdays; # if ($nbtotdays > $nbdays);

$nbdays = $nbtotdays; # if ($nbtotdays < $nbdays);

$pastday = $day  - $nbdays; 
$pastyear = $year;
$pastmonth = $month;

$month_number = $month_equiv{$month};
$month_number--;

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

#print "$jour : $nbdays : $pasttoday\n";


if ($zip == 1 || $zipcut != 0) {
$pastmonthnb = $month_equiv{$pastmonth};
$pastmonthnb = "0".$pastmonthnb if (length($pastmonthnb) == 1);

#$month = $pastmonthnb;
#$fyear = $pastyear;
#$file = $fileroot.$prefixlog.".".$pastmonthnb."-".$pastyear;
#$filezip = $fileroot.$prefixlog.".".$pastmonthnb."-".$pastyear.".gz";

$day = $pastday;
$day = "0".$day unless (length($day) == 2);

$year = $pastyear;
$month = $pastmonthnb;
$lettermonth = $pastmonth;    
$file = $fileroot;
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
       
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}            
       $filezip = $file.$zipext if ($zip == 1);
       
}

print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "il y a $nbdays jours , nous etions le $pasttoday\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

}

}
$nbtotdays = 0;


#################################################################
#####               scanning the log file                  ######
#################################################################

$stop = 0;

print STDOUT "Maximum time for a session : $tlim minutes\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

print STDOUT "Timeout for an inactive session : $tleclim minutes\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# GZIP VERSION HERE

if (($zip == 1 || $zipcut != 0) && $nbdays == 0) {

$yyear = $year;
$year = $fyear;

$day = $daytmp;
$monthprev = $month-1;
$month = $monthindex;

   # detection du premier mois de log zipe

#   do {
while ($out == 0) {
#while (!(-e $filezip) || !(-e $file)) {
	if ($zipcut == 2) {
		$day++;
	        $day = "0".$day if (length($day) == 1);
		if ($day > $month_of_year{$month_nb[$monthprev]}) {
			$month++;
			$monthprev++;
			$day = "01";
			}
		}
       $month++ if ($zipcut == 1);
       $monthprev++ if ($zipcut == 1);       
       $month = "0".$month if (length($month) == 1);
       $year++ if ($month == 13);
       $month = "01" if ($month == 13);
       $monthprev = 0 if ($month == 1);
       $lettermonth = $month_nb[$monthprev];   
#       print "$year $fullyear - $month $monthindex\n";    
       if ($year ==  $fullyear && $month > $monthindex && $zipcut != 0) {
            print "No gziped files found !\n" if ($zip == 1);
            print "No log files found !\n" if ($zip != 1);
#            print "Use zip=0 in config.pl.\n";
            exit;
            }
            
       $file = $fileroot;

        $smallyear = $year - int($year/100)*100;
        $smallyear = "0".$smallyear if (length($smallyear) == 1);
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}
       $out = 1 if (-e $file && $zip == 0);
       $filezip = $file.$zipext if ($zip == 1);
       $out = 1 if (-e $filezip && $zip == 1);
     }
#        until (-e $filezip || -e $file);

   $lastfile = $file;
   $lastfilezip = $filezip;
   $stop = 0;
   $fyear = $year;
   $year = $yyear;       
}

while ($stop == 0) {
#while ($numbermoisgzip != 12) {

print STDOUT "Scanning logfile : $file";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

print STDOUT "(* = 5%)" if ($intervalleday > 19);
print STDOUT "\n";

### Boucle principale

if (($zip == 1) && ($file ne $filezip)) {
       open(FILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
#       print STDOUT "Fichier $filezip decompresse\n";
#       print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

    } else {
           open(FILE,$file) || die "Error, unable to open $file\n";
      }

BOUCLE:
while (<FILE>) {

 @line_log = split(/$logfile_sep/);
 chop($line_log[$#line_log]);
 next if ($line_log[0] =~ /^#/);
 
 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);
 
 $adresse = $line_log[$fields_logfile{'%host'}];
# next if ($adresse =~ /$robot/i && $robot ne '');

    for ($i=0;$i<=$#exclude_robot_address;$i++) {
	next BOUCLE if ($adresse eq $exclude_robot_address[$i]);
    }

 $b = $line_log[$fields_logfile{'%login'}];
 $d = $line_log[$fields_logfile{'%method'}];
 $page = $line_log[$fields_logfile{'%page'}];
 $query = $line_log[$fields_logfile{'%query'}] if ($fields_logfile{'%query'} ne '');  
 $status = $line_log[$fields_logfile{'%status'}];
 $requetesize = $line_log[$fields_logfile{'%requetesize'}];
 $from = $line_log[$fields_logfile{'%referer'}];
 $vserver = $line_log[$fields_logfile{'%virtualhost'}] if ($fields_logfile{'%virtualhost'} ne '');
 $vserver = $1 if ($page =~ /^\/\/([-.0-9a-z]+)\//i && $virtualCLF != 0);
 $vserver = $line_log[$#line_log] if ($#logfile_fields == $fields_logfile{'%virtualhost'});
 $page =~ s/\/\/$virtualfilter// if (($virtualCLF != 0 && $virtualfilter ne '') || ($d =~ /$localserver/));
 $page =~ s/\"// if ($requetesize !~ /(\d+)/);

     next if ($status !~ /^(\d+)$/);  
    next if ($date !~ m/^((\d+)\/(\w+)\/(\d\d\d\d):)(.*)/);
    next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
    next if ($page =~ /"$/ && $iis_format != 1); # all format should be %page %protocol
    next if ($d !~ /^"/ && $iis_format != 1); # all format should be %page %protocol
next if ($adresse eq '');
if ($adresse =~ /\//) {
    ($tmp,$adresse) = split(/:/,$adresse);
    print "Problem : found $tmp ... fixing done\n";
}

if ($opt_j ne '' || $opt_q ne '') {
($fa) = split(':',$date);
($fa1,$fa2,$fa3) = split('/',$fa);
$stop = 1 if ($fa3 > $de3);
next if ($fa3 < $ds3 || $fa3 > $de3);
$mequiv = $month_equiv{$fa2};
$stop = 1 if ($fa3 == $de3 && $mequiv > $mde2);
next if (($fa3 == $ds3 && $mequiv < $mds2) || ($fa3 == $de3 && $mequiv > $mde2));
$stop = 1 if ($fa3 == $de3 && $mequiv == $mde2 && $fa1 > $de1);
next if (($fa3 == $ds3 && $mequiv == $mds2 && $fa1 < $ds1) || ($fa3 == $de3 && $mequiv == $mde2 && $fa1 > $de1));
}

if ($from !~ m/\"/ && $prefixlog eq $referlog) {
       $i = $fields_logfile{'%referer'};
       $tmpi = $i+1;
       $f = $from;
       chop($f);
       while ($f ne "-" && $f !~ m/http:\/\//i && $f ne '') {
       $f = $line_log[$tmpi];
       chop($f);
       $tmpi++;
       }
     $from = $f;
}

next if ($from !~ m/http:\/\//i && $prefixlog eq $referlog);
     
if ($from =~ /\n/ && $type_serveur == 1) {
    chop($from); # si referer is last field
}
    
$page =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
$page =~ tr/[A-Z]/[a-z]/ if ($type_serveur == 1);

$page .= $defaulthomepage if (substr($page,length($page)-1) eq "/");
$page = $page."?".$query if ($query ne '' && $query ne '-,');
next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
next if ($page =~ /$excluderepert/i && $excluderepert ne '');
next if ($d =~ /$localserver/ && $vserver ne '');
next if ($vserver =~ /$excludevirtual/i && $excludevirtual ne '');
next if ($vserver !~ /$virtualfilter/i && $virtualfilter ne '' && $vserver ne '');

$adresse = $nis{$adresse} if ($nis{$adresse} ne '');
$adresse = &reversedns($adresse) if ($reverse_dns == 1 && $adresse =~ /^[0-9.]+$/);
$adresse = $adresse.".".$localdomainename if (split(/[.]/,$adresse) == 1);

next if (($adresse =~ m/$localdomaine/o) && ($locallog == 0));
next if (($adresse !~ m/$localdomaine/o) && ($localonly == 1));
next if (($adresse =~ /$nolog/i) && ($nolog ne ''));

$pays = substr($adresse,rindex($adresse,'.')+1,length($adresse));
$pays =~ tr/A-Z/a-z/;
next if (length($pays) > 4); 

next if ($pays ne $country_filtering && $country_filtering ne '');

($jour,$heure,$minute,$second) = split(/:/,$date);
($daytoday,$monthtoday,$yeartoday) = split(/\//,$jour);
next if ($month_equiv{$monthtoday} !~ /(\d+)/);
next if (length($yeartoday) != 4);

($heurejour) = split(/\//,$jour);

if ($opt_d ne '') {
($fa) = split(':',$date);
($fa1,$fa2,$fa3) = split('/',$fa);
next if ($fa3 < $pastyear);
$mequiv = $month_equiv{$fa2};
next if ($fa3 == $pastyear && $mequiv < $pastmonthnb);
next if ($fa3 == $pastyear && $mequiv == $pastmonthnb && $fa1 < $pastday);
}

next if ($page !~ m#$tri#); # stats sur une partie du serveur

if ($exclude_frame == 1) {
    for ($i=0;$i<=$#exclude_page_frame;$i++) {
	if ($page eq $exclude_page_frame[$i]) {
	    $exclframed++ ;
	    next BOUCLE;
	}
    }
}

#next if ($page =~ /$exclude_page_frame/i && ($exclude_frame == 1));

$status = $1 if ($query =~ /(\d\d\d);http:\/\// && $type_serveur == 1);

next if ($status == 304) ; #ote les pages ne contenant rien
next if ($status == 302) ; #ote les pages ne contenant rien
next if ($status == 301) ; #redirection automatique

next if (($status >= 400) && ($status < 599));
#next if ($requetesize == 0) ; #ote les pages ne contenant rien

# stats pour login accesses

if ($b ne "-") {
$login{$b}++; # requests pour $b
$login_unique++ if ($login{$b} == 1); #nbre de $b differents
$login_user[$login_unique] = $b if ($login{$b} == 1); #nom des $b differents

$login_page{$b,$page}++; #occurence des pages pour un $b
$login_page_unique{$b}++ if ($login_page{$b,$page} == 1);
$login_pages{$b,$login_page_unique{$b}} = $page if ($login_page{$b,$page} == 1);

$login_date{$b,$page,$login_page{$b,$page}} = $date;
$login_adresse{$b,$page,$login_page{$b,$page}} = $adresse;

}

#

$out = 0;

$out = 1 if ($page =~ m/$extension/i);

next BOUCLE if ($out == 0);
#next if ($adresse =~ /$robot/i);

$reqtot++;

if ($firstday eq '') {
    ($firstday) = $date =~ m/^((\d+)\/(\w+)\/(\d+))(.*)/;
    $oldjour = $firstday;
    $firstday =~ s/[\/]/ /g;

     # nombre de jour depuis le 1er janvier

     ($part1,$month2,$part3) = split('/',$oldjour);

     $startjour_of_year = 0;
     $countmonth = 0;
     $month_end = $month_nb[$countmonth];
     
     while ($month_end ne $month2) {
       $startjour_of_year += $month_of_year{$month_end};
       $countmonth++;
       $month_end = $month_nb[$countmonth];
       }
       
     $startjour_of_year += $part1;
     $sessionjour[0] = 0;

}

($host,$a)=split(/\./,$adresse);
next BOUCLE if ($a eq '');

$from =~ s/"//g;
$from =~ s/http:\/\///;

if ($jour ne $oldjour) {

$jour =~ s/\// /g;
$yday = &nbdayan($jour);

#print STDERR "$ydayold\n";
$oldjour =~ s/\// /g;

$ydayold = &nbdayan($oldjour);
$diff = $yday - $ydayold;
$diff += $ydayold if ($diff < 0 && $diff < -1); # && $yday == 1);
#$diff = int($diff);

#print STDERR "$diff $yday\n";
#$diff = 1;

#$nbsess{$nbtotdays} = $sessionjour;
#print STDERR "$nbtotdays $sessionjour\n";
#$sessionjour = 0;

$nbtotdays += $diff;

$oldjour = $jour;
$incjour += $diff;
$incjour = (($incjour+$diff) - int(($incjour+$diff)/7)*7) - 1 if ($incjour > 6);

if ($intervalleday > 19) {
if ($nbtotdays >= ($starstep*$av1)) {
print STDOUT "*";
$av1++;
}
if ($nbtotdays >= ($bigstarstep*$av2)) {
print STDOUT " ";
$av2++;
}
}

#print STDERR "$jour $nbtotdays\n";

}

$reqhour{$heure}++;
$reqjour{$incjour}++;

#$datenumber = $heurejour*24*60 + $minute + 60*$heure;
$datenumber = $heurejour*24*60*60 + 60*$minute + 60*60*$heure + $second;

# maximum : 9 champs dans une adresse !

next if (split(/[.]/,$adresse) > 9);

$adresse =~ tr/A-Z/a-z/;

$nb{$adresse} = 0 if ($nb{$adresse} eq '');

$session{$adresse,0,$nb{$adresse}} = $datenumber if ($req{$adresse,$nb{$adresse}} == 0);

$req{$adresse,$nb{$adresse}}++;
$reqtot{$adresse}++;

$tdebut{$adresse,$nb{$adresse}} = $date if ($req{$adresse,$nb{$adresse}} == 1);
#print "$adresse - $nb{$adresse} - $date - $page\n" if ($req{$adresse,$nb{$adresse}} == 1);
$fromdebut{$adresse,$nb{$adresse}} = $from if ($req{$adresse,$nb{$adresse}} == 1 &&  $agentlog eq $prefixlog);

$session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} = $datenumber;

$intervalle = $session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} - $session{$adresse,$req{$adresse,$nb{$adresse}}-1,$nb{$adresse}};

#$intervalle += int($session{$adresse,$req{$adresse,$nb{$adresse}}-1,$nb{$adresse}}/(24*60))*24*60 if ($intervalle < 0);
$intervalle += int($session{$adresse,$req{$adresse,$nb{$adresse}}-1,$nb{$adresse}}/(24*60*60))*24*60*60 if ($intervalle < 0);

# verif si on depasse le temps maximum d'une session ou temps de lecture > tmax de lecture

if (($session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} - $session{$adresse,0,$nb{$adresse}} > ($tlim*60)) || ($intervalle > ($tleclim*60))) {

   $depassetlim++ if ($session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} - $session{$adresse,0,$nb{$adresse}} > ($tlim*60));
   $depasseleclim++ if ($intervalle > ($tleclim*60) && ($req{$adresse,$nb{$adresse}}-1 > 0) && ($intervalle < ($tlim*60)));

# verif si on depasse le temps de lecture maximum pour une page
# a perfectionner : superieur a la moyenne des temps de lecture.

   $req{$adresse,$nb{$adresse}}--;
   
   $tecoule{$nb{$adresse}} = int(($session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} - $session{$adresse,0,$nb{$adresse}})/60) + 1;
   $tmax = $tecoule{$nb{$adresse}} if ($tecoule{$nb{$adresse}} > $tmax);

   $t{$tecoule{$nb{$adresse}}}++;
   $tsynchro{$adresse,$t{$tecoule{$nb{$adresse}}}} = $nb{$adresse};
   $tadresse{$adresse,$nb{$adresse}} = $tecoule{$nb{$adresse}};
   $tdelta{$tecoule{$nb{$adresse}},$req{$adresse,$nb{$adresse}}} = $nb{$adresse};

   $text{$tecoule{$nb{$adresse}}}++ if ($adresse !~ m/$localdomaine/o);
   $tlocal{$tecoule{$nb{$adresse}}}++ if ($adresse =~ m/$localdomaine/o);
   $sessionlocal++ if ($adresse =~ m/$localdomaine/o);
   $sessionext++ if ($adresse !~ m/$localdomaine/o);
   $requete{$tecoule{$nb{$adresse}},$t{$tecoule{$nb{$adresse}}},$adresse} = $req{$adresse,$nb{$adresse}};
   $adresse{$tecoule{$nb{$adresse}},$t{$tecoule{$nb{$adresse}}}} = $adresse;

   ($part1,$month2,$part3) = split('/',$tdebut{$adresse,$nb{$adresse}});

   $jour_of_year = 0;
   $countmonth = 0;
   $month_end = $month_nb[$countmonth];
     
   while ($month_end ne $month2) {
       $jour_of_year += $month_of_year{$month_end};
       $countmonth++;
       $month_end = $month_nb[$countmonth];
   }
       
   $jour_of_year += $part1;
   $jour_of_year -= $startjour_of_year-1;

   $jour_of_year += 365 if ($jour_of_year <= 0);

   $sessionjour[$jour_of_year]++;
   
   $nb{$adresse}++;
   $req{$adresse,$nb{$adresse}} = 1;
   $tdebut{$adresse,$nb{$adresse}} = $date;
#print "B - $adresse - $nb{$adresse} - $date - $page\n" if ($req{$adresse,$nb{$adresse}} == 1);   
   $fromdebut{$adresse,$nb{$adresse}} = $from if ($agentlog eq $prefixlog);
   $session{$adresse,0,$nb{$adresse}} = $datenumber;
   $session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} = $datenumber;
}


$delta{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} = $session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} - $session{$adresse,$req{$adresse,$nb{$adresse}}-1,$nb{$adresse}};

$visit{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} = $page;

}

close (FILE);

# mois gzip suivant

$stop = 1 if (($zip != 1 && $zipcut == 0) || ($file eq $filezip));

if ($zip == 1 || $zipcut != 0) {

$yyear = $year;
#$year = $fyear;

#$day++ if ($zipcut == 2);
#$day = "0".$day unless (length($day) == 2);
#$month++ if ($zipcut == 1);
#$monthprev = $month-1 if ($zipcut == 1);
#if ($day > $month_of_year{$month_nb[$monthprev]} && $zipcut == 2) {
#$month++;
#$monthprev++;
#$day = "01";
#}
#$year++ if ($month == 13);
#$month = "01" if ($month == 13);
#$monthprev = 0 if ($month == 1);
#$month = "0".$month unless (length($month) == 2);
#$lettermonth = $month_nb[$monthprev];
#$file = $fileroot;
#for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
#$compressed_logfile_fields[$i] =~ s/\%/\$/;
#$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
#}
#$filezip = $file.$zipext;

&nextlog;

if ($zip == 0) {
    if ($zipcut == 2) {
    &nextlog while (!(-f $file) && $file ne $filetmpzip);
$stop = 1 if ($file eq $filetmpzip);
}
}

if ($zip == 1) {
   if (-e $filezip) {
       } else {
   if ($zipcut == 2) {
	&nextlog while (!(-f $filezip) && $filezip ne $filetmpzip);
	$stop = 1 if ($filezip eq $filetmpzip);

    } else {
          $filezip = $fileroot.$prefixlog;
          $file = $fileroot.$prefixlog;
          $stop = 1 if (!(-f $file));
}
    }

} else {
   if (-e $file && $zipcut != 0) {
   } else {
          $stop = 1 if (!(-f $file));
   }
}

#    $fyear = $year;
#   $year = $yyear;       
}

}

##########################################################################
# derniere journee

$nbtotdays++;

#print STDOUT "\n";

foreach $adresse (keys(%reqtot)) {
 
   $tecoule{$nb{$adresse}} = int(($session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} - $session{$adresse,0,$nb{$adresse}})/60) + 1; 
#   $tecoule{$nb{$adresse}} = $session{$adresse,$req{$adresse,$nb{$adresse}},$nb{$adresse}} - $session{$adresse,0,$nb{$adresse}} + 1;
   $tecoule{$nb{$adresse}} = 1 if ($tecoule{$nb{$adresse}} < 0); # 1 seul document lu

   $t{$tecoule{$nb{$adresse}}}++;
   $tsynchro{$adresse,$t{$tecoule{$nb{$adresse}}}} = $nb{$adresse};
   $tadresse{$adresse,$nb{$adresse}} = $tecoule{$nb{$adresse}};
   $tdelta{$tecoule{$nb{$adresse}},$req{$adresse,$nb{$adresse}}} = $nb{$adresse};
   $tmax = $tecoule{$nb{$adresse}} if ($tecoule{$nb{$adresse}} > $tmax);
   $ytmax = $t{$tecoule{$nb{$adresse}}} if ($t{$tecoule{$nb{$adresse}}} > $ytmax);   
   $text{$tecoule{$nb{$adresse}}}++ if ($adresse !~ m/$localdomaine/o);
   $tlocal{$tecoule{$nb{$adresse}}}++ if ($adresse =~ m/$localdomaine/o);
   $sessionlocal++ if ($adresse =~ m/$localdomaine/o);
   $sessionext++ if ($adresse !~ m/$localdomaine/o);
   $requete{$tecoule{$nb{$adresse}},$t{$tecoule{$nb{$adresse}}},$adresse} = $req{$adresse,$nb{$adresse}};
   $adresse{$tecoule{$nb{$adresse}},$t{$tecoule{$nb{$adresse}}}} = $adresse;

   ($part1,$month2,$part3) = split('/',$tdebut{$adresse,$nb{$adresse}});

   $jour_of_year = 0;
   $countmonth = 0;
   $month_end = $month_nb[$countmonth];
     
   while ($month_end ne $month2) {
       $jour_of_year += $month_of_year{$month_end};
       $countmonth++;
       $month_end = $month_nb[$countmonth];
   }
       
   $jour_of_year += $part1;
   $jour_of_year -= $startjour_of_year-1;

   $jour_of_year += 365 if ($jour_of_year < 0);

   $sessionjour[$jour_of_year]++;
#   print STDERR "$month $jour_of_year $sessionjour[$jour_of_year] - ";
}

$pasttoday = $firstday if ($nbtotdays < $nbdays);
$nbdays = $nbtotdays if ($nbtotdays < $nbdays);

$sessionnb = $sessionext + $sessionlocal;

for ($i=1;$i<=$tmax;$i++) {
    $moyensession += ($i * $t{$i});
}

if ($sessionnb == 0) {
print STDERR "Something strange happens...\nNo session have been found !!!!\n";
exit;
}

$moyensession /= $sessionnb;
$moyensessionmin = int($moyensession);
$moyensessionsec = int(60 * ($moyensession - $moyensessionmin));

for ($i=0;$i<=23;$i++) {
$maxreqhour = $reqhour{$i} if ($reqhour{$i} > $maxreqhour);
}

for ($i=0;$i<=6;$i++) {
$maxreqjour = $reqjour{$i} if ($reqjour{$i} > $maxreqjour);
}

$nbdays = $nbtotdays if ($nbdays > $nbtotdays);

if ($nbtotdays > $nbdays) {
$codays = $nbtotdays-$nbdays;
for ($i=$codays;$i<=$nbtotdays;$i++) {
$sessionjour[$i-$codays+1] = $sessionjour[$i];
}
}

for ($i=1;$i<=$nbdays;$i++) {
$maxvisite = $sessionjour[$i] if ($sessionjour[$i] > $maxvisite);
}


#############################################################################

&save_reverse_dns if ($reverse_dns == 1); # sauvegarde de la table de DNS

sub nextlog {

$day++ if ($zipcut == 2);
$day = "0".$day unless (length($day) == 2);

$month++ if ($zipcut == 1);
$monthprev = $month-1 if ($zipcut == 1);

if ($day > $month_of_year{$month_nb[$monthprev]} && $zipcut == 2) {
$month++;
$monthprev++;
$day = "01";
}

$year++ if ($month == 13);
$month = "01" if ($month == 13);
$monthprev = 0 if ($month == 1);
$lettermonth = $month_nb[$monthprev];
$month = "0".$month unless (length($month) == 2);

$file = $fileroot;
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
$compressed_logfile_fields[$i] =~ s/\%/\$/;
$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}

      $filezip = $file.$zipext;
}

#################################################################
#####                 sessions graphs                     #######
#################################################################

if ($session_description == 1) {
$tgraphmax = $tmax;
$tgraphmax = ($tlim/10) if ($tmax > (2*$topten));

$it = length($tgraphmax)-1;
$div = 10**$it;
$factx = ($div*(int($tgraphmax/$div)+1))/$grad;

$factx = 1 if ($it == 0);

$it = length($ytmax)-1;
$div = 10**$it;
$facty = ($div*(int($ytmax/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=0;$i<=$tgraphmax;$i++) {
 $x1 = $i*$xstep/$factx;
 $x2 = ($i+1)*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $t{$i});
 print FLY "frect $x1,$y2,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
 print FLY "frect $x1,$y2,$x2,$ymax,0,0,0\n" if ($i == $moyensessionmin);
 print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
 }
 print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $sessionima |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

$xlegend = "$tmax minutes";

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

open(FOO,"$FLY -q -i $tmpfly -o $sessionimax |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

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

open(FOO,"$FLY -q -i $tmpfly -o $sessionimay |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);
}

#################################################################
#####                 visits graphs                       #######
#################################################################

if ($session_visit == 1) {

$it = length($nbdays)-1;
$div = 10**$it;
$factx = ($div*(int($nbdays/$div)+1))/$grad;

$perspec = $xstep/$factx if (($perspec > $xstep/$factx) && ($tridim == 1));

$it = length($maxvisite)-1;
$div = 10**$it;
$facty = ($div*(int(($maxvisite+$perspec)/$div)+1))/$grad;

$fymax = $ymax-1;

### image pour les abscisses

($startday, $startmonth) = split(/ /,$pasttoday);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);

$xlegend = "$nbdays days (starting $pasttoday)";

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
 
open(FOO,"$FLY -q -i $tmpfly -o $visiteimax |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les ordonnees
 
open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=$ystep;$i<$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) * ($facty/$ystep))+1;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $visiteimay |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);
#}

###
 
 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n"; 
 for ($i=1;$i<=$nbdays;$i++) {
 $x1 = ($i-1+$tridim)*$xstep/$factx;
 $x2 = ($i+$tridim)*$xstep/$factx;
 $y2 = $ymax - ($ystep/$facty * $sessionjour[$i]);

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
   $y1 = $ymax - ($ystep/$facty * $sessionjour[$i+1]);
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

$moysessionjour += $sessionjour[$i];

}

$moysessionjour /= $nbdays if ($nbdays != 0);
$y2 = $ymax - ($ystep/$facty * $moysessionjour);
$x2 = ($nbdays+1)*$xstep/$factx;

print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
$y2++;
print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
$y2--;
print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
print FLY "transparent 200,200,200\n";

close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $visiteima |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);
}

$jour =~ s/\// /g;

#########################################################################
####                                                                #####
####              FABRICATION DES PAGES HTML                        #####
####                                                                #####
#########################################################################

if ($session_description == 1) {

$daylist2 = $path.$dirtmp.$dirsep."tmp2";

print STDOUT "Building sessions pages\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {
#open(DAY,">$path$lang[$nblang]$dirsep$dirsession$dirsep$daylist") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$daylist\n";
open(DAY,">$daylist2") || die "Error, unable to open $daylist2\n";
open(DUREE,">$path$lang[$nblang]$dirsep$dirsession$dirsep$dureesession") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$dureesession\n";
&PageDuree(*DUREE, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (DUREE);
#close (DAY);
}

$daylist = "daylist".$htmlext;

for ($nblang=0;$nblang<=$#lang;$nblang++) {

#for ($l=0;$l<=$#listday;$l++) {
#$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$listday[$l].$htmlext;
#open(DAY,">>$tmp") || die "Error, unable to open $tmp\n";
#print DAY "</BODY></HTML>\n";
#close (DAY);
#}

open(DAY,">$path$lang[$nblang]$dirsep$dirsession$dirsep$daylist") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$daylist\n";
&PageDay(*DAY, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (DAY);
}

}

unlink($daylist2);

sub PageDay {
  local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Sessions'} : $L{'Sessions'} $L{'by_day'} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1>$L{'Sessions'} $L{'by_day'}</H1><HR>\n";

print FOUT "<I>($L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'hTML_pages'} $L{'will_be_printed'})</I>\n" unless ($seuilsite == 0 || $seuilsite == 1);     
print FOUT "<I><BR>$L{'Only_time_session_upper'} $seuilt $L{'minutes'} $L{'are_printed'}</I><BR>\n" if ($seuilt != 0);

print FOUT "<P><CENTER><TABLE BORDER=1 CELLPADDING=3>\n";
print FOUT "<TR><TH>$L{'Date'}</TH><TH>$L{'Hour'}</TH><TH>$L{'Hosts'}</TH><TH>$L{'HTML_pages'}</TH><TH>$L{'Connection_time'} <I>($L{'minutes'})</I></TH></TR>\n";

open(TMP,"$daylist2") || die "Error, unable to open $daylist2\n";
@lines = (<TMP>);
@lines = sort (@lines);
close(TMP);

#for ($i=0;$i<=$#lines;$i++) {
for ($i=$#lines;$i>=0;$i--) {
chop($lines[$i]);
($tmp1,$tmp2,$tmp3,$tmp4,$tmp5,$tmp6) = split(/\t/,$lines[$i]);
print FOUT "<TR>";

$tmp1 = $tmp2;
$tmp1 =~ s/\//-/g;
($tmp11,$tmp12,$tmp13) = split(/-/,$tmp1);
$tmp1 = "..".$dirsepurl.$dirdate.$dirsepurl.$tmp13."-".$tmp12."-".$tmp11.$dirsepurl.$dirsession.$htmlext;

if ($seen{$tmp2}++) {
print FOUT "<TD>&nbsp;</TD>";
} else {
print FOUT "<TD ALIGN=CENTER><A HREF=\"$tmp1\">$tmp2</A></TD>";
}
print FOUT "<TD ALIGN=CENTER>$tmp3</TD>";
print FOUT "<TD><I>$tmp4</I></TD>";
print FOUT "<TD ALIGN=CENTER><B><A HREF=\"$tmp1#$tmp3\">$tmp5</A></B></TD>";
print FOUT "<TD ALIGN=CENTER>$tmp6</TD>";
print FOUT "</TR>\n";
}

print FOUT "</TABLE>\n";
print FOUT "</CENTER>\n</BODY></HTML>\n";

}


sub PageDuree {
  local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Session_title'} </TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'Session_title'} </H1>\n";
print FOUT "<P><HR>\n";

print FOUT "<center>\n";
print FOUT "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkdeltaimay\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkdeltaima\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGH=$ydecal SRC=\"$linkdeltaimax\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n\n";
print FOUT "<BR><B>$L{'Page_reading_time_histogram'}</B>\n<P>\n";
print FOUT "<I>$L{'only_reading_time_below'} $tgraphmax $L{'minutes'} $L{'are_printed'}</I>" if ($tmax > (2*$topten));
print FOUT "</CENTER><BR>$L{'Only_time_session_upper'} $seuilt $L{'minutes'} $L{'are_printed'}<P>\n" if ($seuilt != 0);
print FOUT "\n<CENTER><P>\n<TABLE BORDER=1>\n";
print FOUT "<TR>\n<TH>$L{'Session'}</TH><TH>$L{'Time'}<BR><I>($L{'minutes'})</I></TH><TH>$L{'Hosts'} - $L{'HTML_accesses'}</TH><TH>$L{'average_HTML_accesses'}</TH></TR>\n";

for ($i=$tmax;$i>$seuilt;$i--) {
    if ($t{$i} != 0) {
    $pagei = $i;
    $pagei .= $htmlext;

     print FOUT "<TR>\n<TD VALIGN=TOP ALIGN=CENTER><A NAME=\"$i\">$t{$i}</TD>\n";
     print FOUT "<TD VALIGN=TOP ALIGN=CENTER><A HREF=\"$pagei\">$i</A></TD>\n";
     print FOUT "<TD VALIGN=TOP ALIGN=RIGHT>";

    $sitebelow = 0;

    open(VISIT,">$path$I$dirsep$dirsession$dirsep$pagei") || die "Error, unable to open $path$I$dirsep$dirsession$dirsep$pagei\n";
    print VISIT "<HTML><HEAD>\n";
    print VISIT "<TITLE>$L{'Sessions'} : $i $L{'minutes'} ($I)</TITLE>\n";
    print VISIT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
    print VISIT "</HEAD>\n";
    print VISIT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
    print VISIT "<CENTER><H1>$L{'Sessions'} : $i ";
    print VISIT "$L{'minutes'}" if ($i > 1);
    print VISIT "$L{'minute'}" if ($i == 1);    
    print VISIT "</H1>\n";
    print VISIT "<P><HR><P>\n";
    print VISIT "<I>($L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'hTML_pages'} $L{'will_be_printed'})</I><P><BR>\n" unless ($seuilsite == 0 || $seuilsite == 1);     
    for ($j=1;$j<=$t{$i};$j++) {

         if ($requete{$i,$j,$adresse{$i,$j}} >= $seuilsite) {

         print FOUT "<I>" if ($adresse{$i,$j} =~ m/$localdomaine/o);
         print FOUT "$adresse{$i,$j}";
         print FOUT "</I>" if ($adresse{$i,$j} =~ m/$localdomaine/o);
         print FOUT " : <I>$requete{$i,$j,$adresse{$i,$j}}</I>";
         print FOUT "\n<BR>\n";

	$tmp = $tdebut{$adresse{$i,$j},$tsynchro{$adresse{$i,$j},$t{$i}}} if ($tsynchro{$adresse{$i,$j},$t{$i}} ne '');
	$tmp = $tdebut{$adresse{$i,$j},0} if ($tsynchro{$adresse{$i,$j},$t{$i}} eq '');
	($daypart1,$daypart2,$daypart3,$daypart4) = split(/:/,$tmp);
	$tmp = $daypart4+$daypart3*60+$daypart2*60*60;
	for ($l=0;$l<=(6-length($tmp));$l++) {
	$tmp = "0".$tmp;
	}
	($tmp1,$tmp2,$tmp3) = split(/\//,$daypart1);
	$tmp2 = $month_equiv{$tmp2};
	$tmp2 = "0".$tmp2 if (length($tmp2) == 1);
	print DAY "$tmp3$tmp2$tmp1$tmp\t$daypart1\t$daypart2:$daypart3:$daypart4\t$adresse{$i,$j}\t$requete{$i,$j,$adresse{$i,$j}}\t$i\n";        
    	$daypart1 =~ s/\//-/g;
    	($tmp11,$tmp12,$tmp13) = split(/-/,$daypart1);
    	push(@listday,$daypart1) unless ($seen{$daypart1}++);
    	$dirresume = $tmp13."-".$tmp12."-".$tmp11;
	$daypart1 = $dirsession.$htmlext;
	$tmp11 = $path.$I.$dirsep.$dirdate.$dirsep.$dirresume;
	mkdir ($tmp11,0775) unless -d $tmp11;
#	 print "$path$I$dirsep$dirdate$dirsep$dirresume$dirsep$daypart1\n";
#    	if (-f "$path$I$dirsep$dirdate$dirsep$dirresume$dirsep$daypart1") {


    	if (-f "$path$I$dirsep$dirdate$dirsep$dirresume$dirsep$daypart1" && $write{$dirresume,$I} == 1) {
        open(DAYPART,">>$path$I$dirsep$dirdate$dirsep$dirresume$dirsep$daypart1") || die "Error, unable to open $path$I$dirsep$dirdate$dirsep$dirresume$dirsep$daypart1\n";
        } else {
        open(DAYPART,">$path$I$dirsep$dirdate$dirsep$dirresume$dirsep$daypart1") || die "Error, unable to open $path$I$dirsep$dirdate$dirsep$dirresume$dirsep$daypart1\n";
	$write{$dirresume,$I} = 1;
        print DAYPART "<HTML><HEAD>\n";
        print DAYPART "<TITLE>$L{'Sessions'} : $dirresume ($I)</TITLE>\n";
        print DAYPART "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
        print DAYPART "</HEAD>\n";
        print DAYPART "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
        print DAYPART "<H1>$L{'Sessions'} : $dirresume </H1><HR>\n";
        print DAYPART "<I>$L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'hTML_pages'} $L{'will_be_printed'}</I>\n" unless ($seuilsite == 0 || $seuilsite == 1);     
         print DAYPART "<I><BR>$L{'Only_time_session_upper'} $seuilt $L{'minutes'} $L{'are_printed'}</I><P>\n" if ($seuilt != 0);
         print DAYPART "<CENTER>\n";
        }
        
        print VISIT "<A NAME=\"$adresse{$i,$j}\">";
        print VISIT "<TABLE BORDER=1>\n<TR>\n<TD COLSPAN=2 ALIGN=CENTER>\n";
        print VISIT "<FONT SIZE=+2 COLOR=\"#FF0000\">$adresse{$i,$j}";
        print VISIT " : $requete{$i,$j,$adresse{$i,$j}} ";
        print VISIT "$L{'request'}" if ($requete{$i,$j,$adresse{$i,$j}} == 1);
        print VISIT "$L{'requests'}" if ($requete{$i,$j,$adresse{$i,$j}} != 1);
        print VISIT "</FONT>\n<BR>\n<FONT COLOR=\"#0000FF\">";
        print VISIT "$tdebut{$adresse{$i,$j},$tsynchro{$adresse{$i,$j},$t{$i}}}" if ($tsynchro{$adresse{$i,$j},$t{$i}} ne '');        
        print VISIT "$tdebut{$adresse{$i,$j},0}" if ($tsynchro{$adresse{$i,$j},$t{$i}} eq '');                
	if ($agentlog eq $prefixlog && ($fromdebut{$adresse{$i,$j},$tsynchro{$adresse{$i,$j},$t{$i}}} ne '' || $fromdebut{$adresse{$i,$j},0} ne '')) {
	print VISIT "</FONT>\n<BR>\n$L{'from'} <FONT COLOR=\"#00FF00\">";
        print VISIT "$fromdebut{$adresse{$i,$j},$tsynchro{$adresse{$i,$j},$t{$i}}}" if ($tsynchro{$adresse{$i,$j},$t{$i}} ne '');        
        print VISIT "$fromdebut{$adresse{$i,$j},0}" if ($tsynchro{$adresse{$i,$j},$t{$i}} eq '');  
        }

        print DAYPART "<A NAME=\"$daypart2:$daypart3:$daypart4\">";
        print DAYPART "<TABLE BORDER=1>\n<TR>\n<TD COLSPAN=2 ALIGN=CENTER>\n";
        print DAYPART "<FONT SIZE=+2 COLOR=\"#FF0000\">$adresse{$i,$j}";
        print DAYPART " : $requete{$i,$j,$adresse{$i,$j}} ";
        print DAYPART "$L{'request'}" if ($requete{$i,$j,$adresse{$i,$j}} == 1);
        print DAYPART "$L{'requests'}" if ($requete{$i,$j,$adresse{$i,$j}} != 1);
        print DAYPART "</FONT>\n<BR>\n<FONT COLOR=\"#0000FF\">";
        print DAYPART "$tdebut{$adresse{$i,$j},$tsynchro{$adresse{$i,$j},$t{$i}}}" if ($tsynchro{$adresse{$i,$j},$t{$i}} ne '');        
        print DAYPART "$tdebut{$adresse{$i,$j},0}" if ($tsynchro{$adresse{$i,$j},$t{$i}} eq '');                
	if ($agentlog eq $prefixlog && ($fromdebut{$adresse{$i,$j},$tsynchro{$adresse{$i,$j},$t{$i}}} ne '' || $fromdebut{$adresse{$i,$j},0} ne '')) {
	print DAYPART "</FONT>\n<BR>\n$L{'from'} <FONT COLOR=\"#00FF00\">";
        print DAYPART "$fromdebut{$adresse{$i,$j},$tsynchro{$adresse{$i,$j},$t{$i}}}" if ($tsynchro{$adresse{$i,$j},$t{$i}} ne '');        
        print DAYPART "$fromdebut{$adresse{$i,$j},0}" if ($tsynchro{$adresse{$i,$j},$t{$i}} eq '');  
        }

        print VISIT "</FONT>\n</TD>\n</TR>\n";
        print VISIT "<TR>\n<TH ALIGN=CENTER>$L{'Reading_time'} <br><I>($L{'minutes'})</I></TH><TH ALIGN=CENTER>$L{'Page_read'} <br><I>($L{'chronological_order'})</I></TH></TR>\n";
        
        print DAYPART "</FONT>\n</TD>\n</TR>\n";
        print DAYPART "<TR>\n<TH ALIGN=CENTER>$L{'Reading_time'} <br><I>($L{'minutes'})</I></TH><TH ALIGN=CENTER>$L{'Page_read'} <br><I>($L{'chronological_order'})</I></TH></TR>\n";        
           
        $p = $tdelta{$i,$requete{$i,$j,$adresse{$i,$j}}};

        for ($k=1;$k<=$req{$adresse{$i,$j},$p};$k++) {
           $knext = $k+1;
           print VISIT "<TR>\n<TD ALIGN=CENTER>$L{'not_defined'}</TD>\n" if ($delta{$adresse{$i,$j},$knext,$p} eq '');
           print DAYPART "<TR>\n<TD ALIGN=CENTER>$L{'not_defined'}</TD>\n" if ($delta{$adresse{$i,$j},$knext,$p} eq '');           
           if ($delta{$adresse{$i,$j},$knext,$p} ne '') {
### NEW
	       $pageaverage{$visit{$adresse{$i,$j},$k,$p}} += $delta{$adresse{$i,$j},$knext,$p};
	       $countpageaverage{$visit{$adresse{$i,$j},$k,$p}}++;

	       $tmpmin = int($delta{$adresse{$i,$j},$knext,$p}/60);
           	$tmpsec = $delta{$adresse{$i,$j},$knext,$p} - (int($delta{$adresse{$i,$j},$knext,$p}/60))*60;
           	$tmpsec = "0".$tmpsec if (length($tmpsec) == 1);
                 print VISIT "<TR>\n<TD ALIGN=CENTER>$tmpmin' $tmpsec</TD>\n";
                 print DAYPART "<TR>\n<TD ALIGN=CENTER>$tmpmin' $tmpsec</TD>\n";                 
                 $somdelta[$delta{$adresse{$i,$j},$knext,$p}]++;
                 $maxsomdelta = $somdelta[$delta{$adresse{$i,$j},$knext,$p}] if ($somdelta[$delta{$adresse{$i,$j},$knext,$p}] > $maxsomdelta);
                 }
           print VISIT "<TD><A HREF=\"$visit{$adresse{$i,$j},$k,$p}\">$visit{$adresse{$i,$j},$k,$p}</A></TD>\n</TR>\n";
           print DAYPART "<TD><A HREF=\"$visit{$adresse{$i,$j},$k,$p}\">$visit{$adresse{$i,$j},$k,$p}</A></TD>\n</TR>\n";           
           }
        print VISIT "</TABLE>\n<P>";
        print DAYPART "</TABLE>\n<P>";
#        close (DAYPART);    
                
        } else {
            $sitebelow++;
            }
         $reqmoy{$i} += $requete{$i,$j,$adresse{$i,$j}};
         }
#    $reqtot += $reqmoy{$i};
    $reqmoy{$i} = int($reqmoy{$i}/$t{$i});

    if ($sitebelow != 0) {
    print FOUT "<I>($sitebelow ";
    print FOUT "$L{'session'}" if ($sitebelow == 1);
    print FOUT "$L{'sessions'}" if ($sitebelow != 1);    
    print FOUT " $L{'with_less_than'} $seuilsite $L{'requests'})</I><br>\n";
    }
 
    print FOUT "</TD>\n";
    print FOUT "<TD VALIGN=TOP ALIGN=CENTER>\n";
    print FOUT "<b>$reqmoy{$i}</b>\n";
    print FOUT "</TD>\n</TR>\n";

    print VISIT "</CENTER>\n</BODY></HTML>\n";
    close (VISIT);
    }
}

print FOUT "</TABLE>\n";
print FOUT "</CENTER>\n</BODY></HTML>\n";
}


#################################################################
#####                    homepage                          ######
#################################################################

$reqmoytot = $reqtot/$sessionnb;

print STDOUT "Building homepage\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(HOME,">$path$lang[$nblang]$dirsep$dirsession$dirsep$filesession") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$filesession\n";
&PageHome(*HOME, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (HOME);
}

sub PageHome {
  local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_sessions'} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Stats_about_sessions'} ($L{'HTML_pages_only'})</H1>\n";

print FOUT "<HR size=5>\n";
print FOUT "<CENTER><B>$firstday - $jour</B></CENTER>\n";
print FOUT "<HR size=5><P>\n";

print FOUT "<I>$L{'Robot_session_exclude'}</I><BR>\n" if ($robotscan == 0);
print FOUT "$L{'Total_number_sessions'} : $sessionnb ";
print FOUT "($L{'among'} $sessionlocal $L{'local'})" if ($locallog != 0);
print FOUT "\n<BR>";
print FOUT "$L{'Longest_session'} : $tmax $L{'minutes'} <I>($L{'maximum'} : $tlim)</I><BR>\n";
print FOUT "$L{'Average_session_time'} : $moyensessionmin ";
print FOUT "$L{'minute'} " if ($moyensessionmin < 2);
print FOUT "$L{'minutes'} " if ($moyensessionmin > 1);
$moyensessionsec = "0".$moyensessionsec if (length($moyensessionsec) == 1);
print FOUT "$moyensessionsec $L{'seconds'}\n<BR>";
print FOUT "$L{'Average_pages_by_session'} : ";
printf FOUT "%.1f",$reqmoytot;
print FOUT "<P>\n";

print FOUT "$L{'Multiple_sessions'} ($L{'exceeding'} $tlim $L{'minutes'}) : $depassetlim<BR>\n";
print FOUT "$L{'Reading_time_sessions'} $L{'exceeding'} $tleclim $L{'minutes'} : $depasseleclim<br>\n";

print FOUT "<P><HR><P>\n";

print FOUT "<CENTER>\n";
print FOUT "<TABLE WIDTH=100% CELLPADDING=5 CELLSPACING=5 BORDER=1>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

print FOUT "<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=100%>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM WIDTH=50%>\n";

### pointeurs sur temps de connexion + visites

if ($session_connection == 1) {
print FOUT "<A HREF=\"$filetime\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_time\" ALT=\"$L{'Connection_time'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$filetime\">$L{'Connection_time'}</A>\n";
print FOUT "</FONT>";
}
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM WIDTH=50%>\n";
if ($session_visit == 1) {
print FOUT "<A HREF=\"$filevisit\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_notes\" ALT=\"$L{'visitors'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "$L{'Number_of'} <A HREF=\"$filevisit\">$L{'visitors'}</A> $L{'by_day'}\n";
print FOUT "</FONT>";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

###

print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur sessions multiples + description

print FOUT "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5 WIDTH=100%>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM WIDTH=50%>\n";
if ($session_description == 1) {
print FOUT "<A HREF=\"$filesites\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_sessmul\" ALT=\"$L{'Multiple_sessions'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$filesites\">$L{'Multiple_sessions'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM WIDTH=50%>\n";
if ($session_description == 1) {
print FOUT "<A HREF=\"$dureesession\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_descsess\" ALT=\"$L{'Session_title'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$dureesession\">$L{'Session_title'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

###

print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur moyenne temporelle + moteurs

print FOUT "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5 WIDTH=100%>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM WIDTH=50%>\n";
if ($session_engine == 1) {
print FOUT "<A HREF=\"$filerobot\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_temp\" ALT=\"$L{'search_engine'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "$L{'Sessions_from'} <A HREF=\"$filerobot\">$L{'search_engine'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM WIDTH=50%>\n";
if ($session_average == 1) {
print FOUT "<A HREF=\"$filemoyenne\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_duree\" ALT=\"$L{'Average'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$filemoyenne\">$L{'Average'}</A> $L{'about_hours_and_days'}\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

###

print FOUT "</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur user login accesses

print FOUT "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5 WIDTH=100%>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM WIDTH=50%>\n";
if ($session_reading == 1) {
print FOUT "<A HREF=\"$fileaverage\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_reading\" ALT=\"$L{'Average_reading_time_per_page'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$fileaverage\">$L{'Average_reading_time_per_page'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER VALIGN=BOTTOM WIDTH=50%>\n";
if ($session_login == 1) {
print FOUT "<A HREF=\"$filelogin\"><IMG SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_login\" ALT=\"$L{'Login'}\" BORDER=0></A>\n";
print FOUT "<BR><FONT SIZE=+1>\n";
print FOUT "<A HREF=\"$filelogin\">$L{'Login'}</A>\n";
print FOUT "</FONT>\n";
}
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

###

print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";
print FOUT "<P>\n</BODY></HTML>\n";
}

############

if ($session_login == 1) {
print STDOUT "Building login accesses\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(LOGING,">$path$lang[$nblang]$dirsep$dirsession$dirsep$filelogin") || die "Error, unable to open $path$lang[$nblang]$dirsep$session$dirsep$filelogin\n";
&PageLogin(*LOGING, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (LOGING);
}
}

sub PageLogin {
  local(*FOUT,*L,$I) = @_;
  
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_login'} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Stats_about_login'}</H1>\n";

print FOUT "$L{'No_login'}\n" if ($login_unique == 0);

for ($i=1;$i<=$login_unique;$i++) {
$user = $login_user[$i];
print FOUT "$L{'Login'} <I>$user</I> : <B>$login{$user}</B> $L{'requests'}\n";
print FOUT "<UL>\n";
#print FOUT "<UL>\n" if ($i == 1);

for ($j=1;$j<=$login_page_unique{$user};$j++) {
    print FOUT "<LI> <A HREF=\"$login_pages{$user,$j}\">";
    print FOUT "$urlconv{$login_pages{$user,$j}}" if ($titlename == 1 && $urlconv{$login_pages{$user,$j}} ne '');
    print FOUT "$login_pages{$user,$j}" if ($titlename == 0 || $urlconv{$login_pages{$user,$j}} eq '');
    print FOUT "</A><UL>";
    for ($k=1;$k<=$login_page{$user,$login_pages{$user,$j}};$k++) {
	print FOUT "<LI> $login_adresse{$user,$login_pages{$user,$j},$k} <I>($login_date{$user,$login_pages{$user,$j},$k})</I>\n";
    }
    print FOUT "</UL>\n";
}

print FOUT "</UL><P>\n";
}

print FOUT "</BODY></HTML>\n";
}

############

if ($session_connection == 1) {
print STDOUT "Building timing sessions\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(TIMING,">$path$lang[$nblang]$dirsep$dirsession$dirsep$filetime") || die "Error, unable to open $path$lang[$nblang]$dirsep$session$dirsep$filetime\n";
&PageTime(*TIMING, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (TIMING);
}
}

sub PageTime {
  local(*FOUT,*L,$I) = @_;
  
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_session_length'} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Stats_about_session_length'}</H1>\n";

print FOUT "<HR size=5>\n";
print FOUT "<CENTER><B>$firstday - $jour</B></CENTER>\n";
print FOUT "<HR size=5><P>\n";

print FOUT "<I>$L{'Robot_session_exclude'}</I><BR>\n" if ($robotscan == 0);
print FOUT "<CENTER>\n";
print FOUT "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linksessionimay\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linksessionima\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linksessionimax\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";
print FOUT "<BR><B>$L{'Histogram_sessions'}</B><P>\n";
print FOUT "<I>$L{'only_session_more_than'} $tgraphmax $L{'minutes'} $L{'are_printed'}</I>" if ($tmax > (2*$topten));
print FOUT "</CENTER><P><HR><P>\n";
print FOUT "<I>$L{'Longest_external_session'} ($L{'minimum'} $topten)</I> :<P><UL>\n";
print FOUT "<TABLE BORDER=1>\n";

$longsession = $topten;
$i=$tmax;
#while (($longsession > 0) && ($i > $seuilt)) {
while (($longsession > 0) && ($i > 0)) {
            if ($text{$i}  != 0) {

                print FOUT "<TR>\n";
                print FOUT "<TD VALIGN=TOP ROWSPAN=$text{$i}>";
                print FOUT "<A HREF=\"$dureesession#$i\">" if ($i > $seuilt);
                print FOUT "$i ";
                print FOUT "$L{'minute'}" if ($i < 2);
                print FOUT "$L{'minutes'}" if ($i > 1);                
                print FOUT "</A>" if ($i > $seuilt);
                print FOUT "</TD>\n";
                print FOUT "<TD VALIGN=TOP ROWSPAN=$text{$i}><b>$text{$i}</b> $L{'session'}";
                print FOUT "s" if ($text{$i}  != 1);
                print FOUT "</TD>\n";
                for ($j=1;$j<=$text{$i};$j++) {
                print FOUT "<TR>\n" if ($j != 1);
                print FOUT "<TD>";
                print FOUT "<A HREF=\"$i$htmlext#$adresse{$i,$j}\">" if ($i > $seuilt);
                print FOUT "$adresse{$i,$j}";
                print FOUT "</A>" if ($i > $seuilt);
                print FOUT "</TD>\n";
                print FOUT "</TR>\n" if ($j != 1);
                }
                print FOUT "</TR>\n";

            }        
       $longsession -= $text{$i};
       $i--;
}

print FOUT "</TABLE><P></UL>\n";

if ($locallog != 0) {

print FOUT "<I>$L{'Longest_local_session'} ($L{'minimum'} $topten)</I> :<P><UL>\n";
print FOUT "<TABLE BORDER=1>\n";

$longsession = $topten;
$i=$tmax;
while (($longsession > 0) && ($i > 0)) {
            if ($tlocal{$i}  != 0) {

                print FOUT "<TR>\n";
                print FOUT "<TD ROWSPAN=$tlocal{$i}>";
                print FOUT "<A HREF=\"$dureesession#$i\">" if ($i > $seuilt);
                print FOUT "$i $L{'minutes'}";
                print FOUT "</A>" if ($i > $seuilt);
                print FOUT "</TD>\n";
                print FOUT "<TD ROWSPAN=$tlocal{$i}><b>$tlocal{$i}</b> $L{'session'}";
                print FOUT "s" if ($tlocal{$i}  != 1);
                print FOUT "</TD>\n";
                for ($j=1;$j<=$tlocal{$i};$j++) {
                print FOUT "<TR>\n" if ($j != 1);
                print FOUT "<TD>";
                print FOUT "<A HREF=\"$tadresse{$adresse{$i,$j},0}$htmlext#$adresse{$i,$j}\">" if ($tadresse{$adresse{$i,$j},0} > $seuilt);
                print FOUT "$adresse{$i,$j}";
                print FOUT "</A>" if ($tadresse{$adresse,0} > $seuilt);
                print FOUT "</TD>\n";
                print FOUT "</TR>\n" if ($j != 1);
                }
                print FOUT "</TR>\n";
            }        
       $longsession -= $tlocal{$i};
       $i--;
}
}

print FOUT "</TABLE><P>\n";
print FOUT "</UL>\n";
print FOUT "</BODY></HTML>\n";
}


############

if ($session_visit == 1) {
print STDOUT "Building users visits\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(VISITEUR,">$path$lang[$nblang]$dirsep$dirsession$dirsep$filevisit") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$filevisit\n";
&PageVisite(*VISITEUR, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (VISITEUR);
}
}

sub PageVisite {
  local(*FOUT,*L,$I) = @_;
  
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_visits'} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Stats_about_visits'}</H1>\n";

print FOUT "<HR size=5>\n";
print FOUT "<CENTER><B>$firstday - $jour</B></CENTER>\n";
print FOUT "<HR size=5><P>\n";
print FOUT "<CENTER>\n";
print FOUT "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkvisiteimay\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkvisiteima\" ALT=\"graph\" USEMAP=\"#visit\" BORDER=0></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkvisiteimax\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";
print FOUT "<B>$L{'Number_of_visits'} $L{'by_day'}</B><P>\n";
print FOUT "<I>$L{'Session_cut1'}<BR>\n";
print FOUT "$L{'Session_cut2'}</I>\n";
print FOUT "<P><I>$L{'Blue_line_is_average'}</I>\n<P></CENTER>\n";
print FOUT "$L{'For_people'}\n";
print FOUT "$L{'there_is'} <A HREF=\"$daylist\">$L{'table_of_data'}</A><P>\n";

# USEMAP

($jour2, $monthletter,$yearb) = split(/ /,$firstday);

$month = $month_equiv{$monthletter};

print FOUT "<MAP NAME=\"visit\">\n";
open(FLY,"$tmpfly");
while (<FLY>) {

if ($_ =~ /^rect/) {
   ($tmp,$x1,$tmp,$x2) = split(/[ ,]/);
   $x1 = 0 if ($x1 < 0);
   $x1 = int($x1);
   $x2 = int($x2);

   if ($jour2 > $month_of_year{$monthletter}) {
      $month++;
      $yearb++ if ($month == 13);
      $month = 1 if ($month == 13);
      $jour2 = "01";
   }
   $jour2 = "0".$jour2 unless (length($jour2) == 2);
   $month = "0".$month unless (length($month) == 2);
   $monthletter = $month_nb[$month-1];

   $linkjour = "..".$dirsepurl.$dirdate.$dirsep.$yearb."-".$monthletter."-".$jour2.$dirsepurl.$dirsession.$htmlext;
   $fulljour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$yearb."-".$monthletter."-".$jour2.$dirsep.$dirsession.$htmlext;

print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$linkjour\">\n" if (-e $fulljour);

   $jour2++;
}
}
print FOUT "</MAP>\n";
print FOUT "</BODY></HTML>\n";
}

############

if ($session_engine == 1) {
print STDOUT "Building robots data\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(ROBOT,">$path$lang[$nblang]$dirsep$dirsession$dirsep$filerobot") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$filerobot\n";
&PageRobot(*ROBOT, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (ROBOT);
}
}

sub PageRobot {
  local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_robots_sessions'} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Stats_about_robots_sessions'}</H1>\n";

print FOUT "<HR size=5>\n";
print FOUT "<CENTER><B>$firstday - $jour</B></CENTER>\n";
print FOUT "<HR size=5><P>\n";

if ($sessionrobot != 0) {
print FOUT "$L{'Total_number_of_robot_session'} : $sessionrobot\n";
print FOUT "<P><TABLE BORDER=1 WIDTH=100%>\n";
print FOUT "<TR>\n";
print FOUT "<TH>$L{'Robot_name'}</TH>\n" if ($agentlog eq $prefixlog);
print FOUT "<TH>$L{'Hosts'}</TH>\n<TH>$L{'Number_of_requests'}</TH>\n<TH>$L{'Number_of_visits'}</TH>\n<TH>$L{'Last_occurence'}</TH>\n</TR>\n";
} else {
print FOUT "<B><CENTER>$L{'No_robot_session'} </CENTER></B>\n";
}

if ($sessionrobot != 0) {
foreach $adresse (keys(%robotname)) {
  if ($reqrobot{$adresse} != 0) {

     print FOUT "<TR>\n";
     if ($agentlog eq $prefixlog) {
     $robotname{$adresse} = "&nbsp;" if ($robotname{$adresse} eq '');
     print FOUT "<TD>";
     print FOUT "$robotname{$adresse}";
     print FOUT "</TD>\n";
     }
     print FOUT "<TD>$adresse</TD>\n<TD ALIGN=CENTER>$reqrobot{$adresse}</TD>\n<TD ALIGN=CENTER>$visrobot{$adresse}</TD>\n<TD ALIGN=CENTER>$daterobot{$adresse}";
     print FOUT "</TD>\n</TR>\n";

  }

}
}

print FOUT "</TABLE>\n" if ($sessionrobot != 0);
print FOUT "</BODY></HTML>\n";
}

############

if ($session_description == 1) {
print STDOUT "Building hosts session\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(SITES,">$path$lang[$nblang]$dirsep$dirsession$dirsep$filesites") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$filesites\n";
&PageSites(*SITES, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (SITES);
}
}

sub PageSites {
  local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_hosts'} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Stats_about_hosts'}</H1>\n";
print FOUT "<P><HR>\n";
print FOUT "\n<BR>";
print FOUT "<I>$L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'hTML_pages'} $L{'will_be_printed'}</I><BR>\n" unless ($seuilsite == 0 || $seuilsite == 1); 
print FOUT "<I>$L{'Only_time_session_upper'} $seuilt $L{'minutes'} $L{'are_printed'}</I><BR>\n" if ($seuilt != 0);
print FOUT "<P><TABLE BORDER=1><TR>\n";
print FOUT "<TH>$L{'Hosts'}</TH><TH>$L{'Sessions'}</TH><TH>$L{'Total_HTML_access'}</TH><TH>$L{'HTML_accesses'}</TH>";
print FOUT "<TH>$L{'Session_time'}</TH></TR>\n";

foreach $adresse (keys(%reqtot)) {
    if ($nb{$adresse} > 0) {
         if ($reqtot{$adresse} >= $seuilsite) {
         
         $exclude = 0;
         $exclhtml = 0;

         $span = $nb{$adresse} + 1;
	 $spanok = 0;
	 $spanok2 = 0;
             for ($j=0;$j<=($nb{$adresse});$j++) {         
         $spanok = 1 if ($tadresse{$adresse,$j} <= $seuilt);
         $spanok2 = 1 if ($tadresse{$adresse,$j} > $seuilt);
         $span-- if ($tadresse{$adresse,$j} <= $seuilt);
	}

	 $span++ if ($spanok == 1);

             print FOUT "<TR>\n";
             print FOUT "<TD VALIGN=TOP ROWSPAN=$span><B>$adresse</B></TD>\n";
             print FOUT "<TD ALIGN=CENTER VALIGN=TOP ROWSPAN=$span>",$nb{$adresse}+1,"</TD>\n";
             print FOUT "<TD ALIGN=CENTER VALIGN=TOP ROWSPAN=$span>$reqtot{$adresse}</TD>\n";

             for ($j=0;$j<=($nb{$adresse});$j++) {
#                 $k = $j+1;

		 if ($tadresse{$adresse,$j} > $seuilt) {
                 print FOUT "<TR>" if ($exclude != $j);
                 print FOUT "<TD ALIGN=CENTER>$req{$adresse,$j}</TD>";
                 print FOUT "<TD ALIGN=CENTER><I>";
#		 if ($tadresse{$adresse,$j} > $seuilt) {
                 print FOUT "<A HREF=\"$tadresse{$adresse,$j}$htmlext";
                 print FOUT "#$adresse" if ($req{$adresse,$j} > $seuilsite);
                 print FOUT "\">";
#		 }
                 print FOUT "$tadresse{$adresse,$j}";
                 print FOUT "</A> $L{'minutes'}";
#                 print FOUT "</A>" if ($tadresse{$adresse,$j} > $seuilt);
                 print FOUT "</I><BR></TD>\n";
                 } else {
			$exclude++;
			$exclhtml += $req{$adresse,$j};
#			print STDERR "$exclude - $adresse - $nb{$adresse}\n";
                 }
            }

	if ($exclude != 0) {
	print FOUT "</TR><TR>" if ($exclude != $nb{$adresse}+1);
	print FOUT "<TD ALIGN=CENTER>$exclhtml</TD><TD ALIGN=CENTER>< $seuilt $L{'minutes'}</TD>\n";
	}            
                 print FOUT "</TR>\n" if ($j != $nb{$adresse});
            
  }
}
}

print FOUT "</TABLE><P>\n</BODY></HTML>\n";
}

#################################################################
#####         graphs des temps de lecture                  ######
#################################################################

if ($session_connection == 1) {
$it = length($tgraphmax)-1;
$div = 10**$it;
$factx = ($div*(int($tgraphmax/$div)+1))/$grad;

$factx = 1 if ($it == 0);
  
$it = length($maxsomdelta)-1;
$div = 10**$it;
$facty = ($div*(int($maxsomdelta/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
print FLY "frect 0,0,0,0,200,200,200\n";
for ($i=0;$i<=$tgraphmax;$i++) {
   $x1 = $i*$xstep/$factx;
   $x2 = ($i+1)*$xstep/$factx;

   $y2 = $ymax - ($ystep/$facty * $somdelta[$i]);
   print FLY "frect $x1,$y2,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
   print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
   }
  print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $deltaima |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

$xlegend = "$tmax minutes";

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

open(FOO,"$FLY -q -i $tmpfly -o $deltaimax |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

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

open(FOO,"$FLY -q -i $tmpfly -o $deltaimay |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);
}

###

if ($session_average == 1) {
# Moyenne sur les heures

for ($i=0;$i<=23;$i++) {
$i = "0".$i unless (length($i) != 1);
$reqhour{$i} /= $reqtot;
$reqhour{$i} *= 100;
$moyreqhour += $reqhour{$i};
}
$maxreqhour /= $reqtot;
$maxreqhour = int($maxreqhour*100)+1;

$moyreqhour /= 24;

# Moyenne sur les jours

for ($i=0;$i<=6;$i++) {
$reqjour{$i} /= $reqtot;
$reqjour{$i} *= 100;
$moyreqjour += $reqjour{$i};
}
$maxreqjour /= $reqtot;
$maxreqjour = int($maxreqjour*100);

$moyreqjour /= 7;

#################################################################
#####                  hourly graphs                      #######
#################################################################

$it = length("24")-1;
$div = 10**$it;
$factx = ($div*(int(24/$div)+1))/$grad;

#$maxreqhour = int($maxreqhour/$reqtot)+1;

$maxreqhour = 1 if ($maxreqhour < 1);
#$maxreqhour = 100; # pourcentage

$it = length($maxreqhour)-1;
$div = 10**$it;
$facty = ($div*(int($maxreqhour/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
print FLY "frect 0,0,0,0,200,200,200\n";
for ($i=0;$i<=23;$i++) {
 $x1 = $i*$xstep/$factx;
 $x2 = ($i+1)*$xstep/$factx;

$i = "0".$i unless (length($i) != 1);

$y2 = $ymax - ($ystep/$facty * $reqhour{$i});

print FLY "frect $x1,$y2,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
}
$y2 = $ymax - ($ystep/$facty * $moyreqhour);
$x2 = 24*$xstep/$factx;
print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
$y2++;
print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
$y2--;
print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $heureima |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

$xlegend = "24 hours";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<=$xmax;$i+=$xstep) {
 $valstep = $i*$factx/$xstep;
 if ($valstep < 25) {
 $posx = $i - length(int($valstep))*5;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$valstep\n";
 }
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $heureimax |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les ordonnees
 
open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("Mean requests")/2));
 print FLY "stringup 0,0,0,5,$posy,medium,Percentage\n";
 for ($i=$ystep;$i<=$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) * ($facty/$ystep));
 $valstep = int(($ymax - $i) / ($ystep/$facty)) if ($facty < $ystep);

 $pos = ($xdecal - length($valstep)*15);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $heureimay |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

#################################################################
#####                   daily graphs                      #######
#################################################################

$it = length("7")-1;
$div = 10**$it;
$factx = ($div*(int(7/$div)+1))/$grad;

#$maxreqjour = int($maxreqjour/$reqtot)+1;

$maxreqjour = 1 if ($maxreqjour < 1);
#$maxreqjour = 100; # pourcentage

$factx = 1 if ($it == 0);

$it = length($maxreqjour)-1;
$div = 10**$it;
$facty = ($div*(int($maxreqjour/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
print FLY "frect 0,0,0,0,200,200,200\n";
for ($i=0;$i<=$nbtotdays;$i++) {
 $x1 = $i*$xstep/$factx;
 $x2 = ($i+1)*$xstep/$factx;

$y2 = $ymax - ($ystep/$facty * $reqjour{$i});
print FLY "frect $x1,$y2,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
}
$y2 = $ymax - ($ystep/$facty * $moyreqjour);
$x2 = 7*$xstep/$factx;
print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
$y2++;
print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
$y2--;
print FLY "line 0,$y2,$x2,$y2,$red[2],$green[2],$blue[2]\n";
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $jourima |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

$xlegend = "Average on $nbtotdays days";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<=$xmax;$i+=$xstep) {
 $valstep = $i*$factx/$xstep;
 if ($valstep < 8) {
 $valjour = $valstep - 1 + $thisdayinc - $incjour;
 $valjour -=  7 if ($valjour > 6);
 $valjour += 7 if ($valjour < 0);
 $posx = $i - ($xstep/2) - ($xstep/4);
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$day_of_week[$valjour]\n";
 }
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $jourimax |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("Mean requests")/2));
 print FLY "stringup 0,0,0,5,$posy,medium,Percentage\n";
 for ($i=$ystep;$i<=$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) * ($facty/$ystep));
 $valstep = int(($ymax - $i) / ($ystep/$facty)) if ($facty < $ystep);
 
 $pos = ($xdecal - length($valstep)*15);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $jourimay |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

} # end $session_average


#################################################################
#####             average timing per page                 #######
#################################################################

if ($session_reading == 1) {
print STDOUT "Building average reading time per page\n";

if (-f "$path$dirdata$dirsep$fileurl") {
open(FILEURL,"$path$dirdata$dirsep$fileurl");
while (<FILEURL>) {
($var1,$var2,$var3) = split(/"/);
chop($var1);
($var2,$var3,$var4,$sizevar) = split(/\s+/,$var3);
$fileurl{$var1} = $sizevar;
}
close(FILEURL);
}

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(AVERAGE,">$path$lang[$nblang]$dirsep$dirsession$dirsep$fileaverage") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$fileaverage\n";
&PageTempsMoyen(*AVERAGE, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (AVERAGE);
}
}

sub PageTempsMoyen {
  local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{''} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{''}</H1>\n";
print FOUT "<P><HR><CENTER>\n";

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH>$L{'Page'}</TH><TH>$L{'Accesses'}</TH><TH>Average Load <BR><I>($L{'seconds'})</I></TH>";

    if (-f "$path$dirdata$dirsep$fileurl") {
	print FOUT "<TH>$L{'Weight_of_HTML_files'} <BR><I>($L{'Kb'})</I></TH>";
	print FOUT "<TH>Load <I>($L{'seconds'})</I> <BR><I>($baudrate $L{'Kb'}/$L{'seconds'})</I></TH>";
	print FOUT "<TH>Average Reading Time<BR><I>($L{'seconds'})</I></TH>";
    }
print FOUT "</TR>\n";

foreach $page (sort keys(%pageaverage)) {

$tmp = $countpageaverage{$page}/($#lang+1);
$tmp2 = $pageaverage{$page}/$tmp;

if ($tmp2 != 0) {

$tmpmin = int($tmp2/60);
$tmpsec = int($tmp2 - (int($tmp2/60))*60);
$tmpsec = "0".$tmpsec if (length($tmpsec) == 1);

print FOUT "<TR><TD>$page</TD>";
print FOUT "<TD ALIGN=CENTER>$tmp</TD>";
print FOUT "<TD ALIGN=CENTER>$tmpmin' $tmpsec</TD>";

    if (-f "$path$dirdata$dirsep$fileurl") {
	print FOUT "<TD ALIGN=CENTER>".(int($fileurl{$page}/1024))."</TD>" if ($fileurl{$page} ne '');
	print FOUT "<TD ALIGN=CENTER>-</TD>" if ($fileurl{$page} eq '');
        $tmp = int($fileurl{$page}/($baudrate*1024));
	$tmpmin = int($tmp/60);
	$tmpsec = int($tmp - (int($tmp/60))*60);
	$tmpsec = "0".$tmpsec if (length($tmpsec) == 1);
	print FOUT "<TD ALIGN=CENTER>$tmpmin' $tmpsec</TD>" if ($fileurl{$page} ne '');
	print FOUT "<TD ALIGN=CENTER>-</TD>" if ($fileurl{$page} eq '');
	$tmp2 = $tmp2 - $tmp;
	$tmpmin = int($tmp2/60);
	$tmpsec = int($tmp2 - (int($tmp2/60))*60);
	$tmpsec = "0".$tmpsec if (length($tmpsec) == 1);
	print FOUT "<TD ALIGN=CENTER";
	print FOUT " BGCOLOR=\"#AEAEAE\"" if ($tmpmin >= 1 && $fileurl{$page} ne '');
        print FOUT ">$tmpmin' $tmpsec</TD>" if ($fileurl{$page} ne '');
	print FOUT ">-</TD>" if ($fileurl{$page} eq '');
    }
print FOUT "</TR>\n"; 
}
}

print FOUT "</TABLE>\n";
print FOUT "</CENTER><P></BODY></HTML>\n";
}


#################################################################
#####             mean hour and day page                  #######
#################################################################

if ($session_average == 1) {
print STDOUT "Building average acceses over hours and days of week\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(MOYENNE,">$path$lang[$nblang]$dirsep$dirsession$dirsep$filemoyenne") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsession$dirsep$filemoyenne\n";
&PageMoyenne(*MOYENNE, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (MOYENNE);
}
}

sub PageMoyenne {
  local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Average_on_hours_and_days'} ($I)</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-session.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1>$L{'Average_on_hours_and_days'}</H1>\n";
print FOUT "<P><HR>\n";

print FOUT "<A NAME=\"moyheure\">\n";
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkheureimay\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkheureima\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkheureimax\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE></CENTER>\n";
print FOUT "<CENTER><B>$L{'Histogram_about_average_request'} $L{'by_hour'}</B></CENTER><P>\n";

print FOUT "<A NAME=\"moyjour\">\n";
print FOUT "<CENTER><TABLE BORDER=0 CELLPADING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkjourimay\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkjourima\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkjourimax\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE></CENTER>\n";
print FOUT "<CENTER><B>$L{'Histogram_about_average_request'} $L{'by_day'}</B></CENTER><P>\n";

print FOUT "<P><CENTER><I>($L{'Blue_line_is_average'})</I></CENTER><P>";
print FOUT "<P>\n</BODY></HTML>\n";

}

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
#print FILE "cron-session\t$today\t$startrun\t$endrun\t$min:$sec\t$loglines\n";
printf FILE "cron-session\t%s\t%s\t%s\t%d:%d\t%d\n",$today,$startrun,$endrun,$min,$sec,$loglines;
close(FILE);

__END__

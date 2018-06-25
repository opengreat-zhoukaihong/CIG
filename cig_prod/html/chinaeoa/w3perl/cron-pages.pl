#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####            LECTURE DU FICHIER DE LOG (pages HTML)              #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 20/08/2000     #####
####                                                                #####
####                                                                #####
#########################################################################

########## WIDTH et HEIGHT a ajouter
##########

$debug = 1;
$fullday = 1;

$version = "2.72";
$verdate = "20/08/00";

############ script to launch only once  ##########

require "/usr/local/etc/w3perl/cgi-bin/w3perl/libw3perl.pl";

# debut de l'initialisation

$starttime = time();
print "Main stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

$countmonth--;

$daytmp = $day;
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

$nbdayscf = $nbdays;

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

#print STDERR "$yesterday\n";

### number of the current day

$ydaystarttoday = 0;
$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $month) {
     $ydaystarttoday += $month_of_year{$month_end};
     $countmonth++;
     $month_end = $month_nb[$countmonth];
}

$ydaystarttoday += $day + ($year*365);

# verif que le format est bien en anglais

for ($i=0;$i<=($#month_nb);$i++)
{
   $ok = 1 if ($month_nb[$i] eq $month);
}

if ($ok == 0) {
print STDERR "Date format not valid\n";
print STDERR "You should use the english date format, set your LANG environnment variable\n";
print STDERR "('setenv LANG eng' or 'export LANG=\"eng\"')\n";
exit;
}

undef $ok;

## variables initialisees

$redirect = 0;
$forbiden = 0;
$notfound = 0;
$exclpages = 0;
$exclframed = 0;
$exclrobots = 0;
$excladdr = 0;
$av1 = 1;
$av2 = 1;
$nbpageserveur{$adresse}= 0;
$domreq = 0;
$reqdomtot = 0;
$locserverjour = 0;
$locserver = 0;
$add = 0;
$nbdays = 0;
$ok = 0;
$accessdom = 0;
$totsizejour = 0;
$tothtmlsizejour = 0;
$totsizeold = 0;
$tothtmlsizeold = 0;
$proxy = 0;
$exclpages = 0;
$excladdr = 0;
$forbiden = 0;
$notfound = 0;
$redirect = 0;
$scriptunique = 0;
$domsize = 0;
$virtualunique = 0;
$serverunique = 0;
$serveruniquejour = 0;
$paysunique = 0;
$externesize = 0;
$reqtotjour = 0;

for ($i=0;$i<=($#selecrepert);$i++) {
$freqjourrac{$selecrepert[$i]} = 0;
$freqrac{$selecrepert[$i]} = 0;
$freqrachtml{$selecrepert[$i]} = 0;
$freqrachtmldom{$selecrepert[$i]} = 0;
$sizejourrachtml{$selecrepert[$i]} = 0;
$sizejourrachtmldom{$selecrepert[$i]} = 0;
$sizejourrachtmlext{$selecrepert[$i]} = 0;
$totsize{$selecrepert[$i]} = 0;
$extsize{$selecrepert[$i]} = 0;
$domsize{$selecrepert[$i]} = 0;
}

#print STDOUT "today is : $today \nyesterday is $yesterday\n" if ($debug > 0);;

#################################################################
###            parsing the command line option                ###
#################################################################

# GZIP VERSION HERE

if ($zip == 1 || $zipcut != 0) {

$day = $daytmp;
$month = $monthindex;
$monthprev = $month-1;
$yyear = $year;
$year = $fyear;

   # detection du premier mois de log zipe

#   do {
while ($out == 0) {
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
       $lettermonth =  $month_nb[$monthprev];
       if ($year ==  $fullyear && $month > $monthindex && $zipcut != 0) {
            print "No gziped files found !\n" if ($zip == 1);
            print "No log files found !\n" if ($zip == 0);
#            print "Use zip=0 in config.pl.\n";
            exit;
            }
       $smallyear = $year - int($year/100)*100;
       $smallyear = "0".$smallyear if (length($smallyear) == 1);

       $file = $fileroot;

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


if (($zip == 1) && ($file ne $filezip)) {
       open(FILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
    } else {
           open(FILE,$file) || die "Error, unable to open $file\n";
      }
      
###### date de depart

$scalar = (<FILE>);
while ($scalar =~ /^#/) {
$scalar = (<FILE>);
}

close(FILE);

 @line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1); 
 
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

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -c <file>    : load configuration file\n";
      print STDOUT "        -d <nbdays>  : scan only nbdays previous day\n";
      print STDOUT "        -i <file>    : input logfile\n";
      print STDOUT "        -p <level>   : precision level\n";
      print STDOUT "        -l <";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      } 
      print STDOUT "$lang[$#lang]";
      print STDOUT ">   : language output (comma split)\n";            
      print STDOUT "        -q <tri>     : scanning this matching string only\n";
      print STDOUT "        -s <date>    : starting date (dd/Mmm/yyyy)\n";
      print STDOUT "        -r <date>    : ending date (dd/Mmm/yyyy)\n";
      print STDOUT "        -t <toplist> : display only toplist files\n";
      print STDOUT "        -u           : update homepage links\n";
      print STDOUT "        -x           : show default value for flag options\n";
      print STDOUT "        -v           : version\n";
      print STDOUT "        -z           : zip logfiles\n";            
      print STDOUT "\n";
      exit;
}


if ($opt_v == 1) {
      print STDOUT "cron-pages.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -c            : $configfile\n";
      print STDOUT "          -d <nbdays>   : all\n";
      print STDOUT "          -i <file>     : $file\n";
      print STDOUT "          -p <level>    : $precision\n";
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
#      print STDOUT "          -r <tri>      : $tri\n";
#      print STDOUT "          -s <seuil>       : $seuilpage\n";
      print STDOUT "          -s <date>     : $firstjour\n";
      print STDOUT "          -r <date>     : $yesterday\n";
      print STDOUT "          -u            : ";
      &id($opt_u);
      print STDOUT "          -t <toplist>  : $topten\n";
      print STDOUT "          -v            : $version\n";
      print STDOUT "          -z            : ";
      &id($opt_z);      
      exit;
}

# argument cmds line

if ($opt_z ne '') {
$zip = $opt_z;
}

if ($opt_u ne '') {

if (!(-f "$path$dirinc$dirsep$incgeneral")) {
        print STDERR "You should first run once the package !\n";
        exit;
        }

print STDOUT "Updating stats homepage\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
        
# hmmm la il faut recharger les valeurs et les updater !

open(GENERAL,"$path$dirinc$dirsep$incgeneral") || die "Error, unable to open $path$dirinc$dirsep$incgeneral\n";
while (<GENERAL>) {
($date1,$date2,$date3,$reqtot,$reqdomtot,$totsize,$externesize,$domsize,$nbdays,$access,$accessdom,$tothtmlsize,$loglines,$proxy,$redirect,$forbiden,$notfound,$exclpages,$excladdr,$exclframed,$exclrobots) = split;
}
close GENERAL;

$firstday = "$date1"." "."$date2"." "."$date3";

# conversion en Megaoctets

$totsize /= (1024*1024);
$externesize /= (1024*1024);
$domsize /= (1024*1024);

# general est charge pour avoir nbdays !

for ($nblang=0;$nblang<=$#lang;$nblang++) {
        $top = $path.$lang[$nblang].$dirsep.$dirframe.$dirsep.$topframe;
        open(TOP,">$top") || die "Error, unable to open $topframe\n";
        &CreateTopFrame(*TOP, eval($Lang{$lang[$nblang]}), $homepagesframed[$nblang], $lang[$nblang]);
        close (TOP);
}

for ($nblang=0;$nblang<=$#lang;$nblang++) {
        $bottom = $path.$lang[$nblang].$dirsep.$dirframe.$dirsep.$bottomframe;
        open(BOTTOM,">$bottom") || die "Error, unable to open $bottom\n";
        &CreateBottomFrame(*BOTTOM, eval($Lang{$lang[$nblang]}), $homepages[$nblang], $lang[$nblang]);
        close (BOTTOM);
}

open(PAGESLUES,"$path$dirinc$dirsep$incpage") || die "Error, unable to open $path$dirinc$dirsep$incpage\n";
while (<PAGESLUES>) {
$pageunique++;
}
close PAGESLUES;

open(PAYS,"$path$dirinc$dirsep$incpays") || die "Error, unable to open $path$dirinc$dirsep$incpays\n";
while (<PAYS>) {
($tmp) = split(/\s+/,$_);
$paysunique++ if ($tmp ne "Unknown");
}
close PAYS;


open(SERVEXTERNE,"$path$dirinc$dirsep$incservexterne") || die "Error, unable to open $path$dirinc$dirsep$incservexterne\n";
while (<SERVEXTERNE>) {
$serverunique++;
}
close SERVEXTERNE;

open(SERVINTERNE,"$path$dirinc$dirsep$incservinterne") || die "Error, unable to open $path$dirinc$dirsep$incservinterne\n";
while (<SERVINTERNE>) {
$locserver++;
}
close SERVINTERNE;

if (-f "$path$dirinc$dirsep$incvirtual") {
open(VIRTUAL,"$path$dirinc$dirsep$incvirtual") || die "Error, unable to open $path$dirinc$dirsep$incvirtual\n";
while (<VIRTUAL>) {
$virtualunique++;
}
}

if ($precision == 1) {
for ($nblang=0;$nblang<=$#lang;$nblang++) {
        open(LITTLEINDEX,">$path$homepages[$nblang]") || die "Error,  unable to open $path$homepages[$nblang]\n";
        &CreateLittleIndex(*LITTLEINDEX, eval($Lang{$lang[$nblang]}), $homepages[$nblang], $lang[$nblang], $homepagesframed[$nblang]);
        close (LITTLEINDEX);
}
}

for ($nblang=0;$nblang<=$#lang;$nblang++) {
        $mainindex = $path.$homepages[$nblang];
        $mainindex2 = $path.$lang[$nblang].$dirsep.$dirframe.$dirsep.$homepagesframed[$nblang];
  
        open(MAININDEX,">$mainindex") || die "Error, unable to open $mainindex\n";
        open(MAININDEX2,">$mainindex2") || die "Error, unable to open $mainindex2\n";
        &CreateMainIndex(*MAININDEX,*MAININDEX2, eval($Lang{$lang[$nblang]}), $homepages[$nblang], $lang[$nblang], $homepagesframed[$nblang]);
        close (MAININDEX);
        close (MAININDEX2);
}

print "End<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");
exit;
}

if ($opt_s ne '') {

if ($opt_s !~ /(\d{2})\/(\w{3})\/(\d{4})/) {
print STDERR "Not a valid starting date format (valid format is for example 02/May/1995)\n";
exit;
} else {

#$b = int($1);
if ($1 < 1 || $1 > 31) {
print STDERR "Day should be between 1 and 31 !\n";
exit;
}

$lettermonth = $2;
$month = $month_equiv{$lettermonth};
$month = "0".$month if (length($month) == 1);
if ($month < 1 || $month > 12) {
print STDERR "Month should be between Jan and Dec !\n";
exit;
}

#$year++ if ($month == 13);
#$month = "01" if ($month == 13);

#$lettermonth =  $month_nb[$month-1] if ($month != 0);
#$lettermonth =  $month_nb[12] if ($month == 0);

#$b = $smallyear2_today.$3 if ($3 <= $smallyear_today); 
#$b = eval($smallyear2_today-1).$3 if ($3 > $smallyear_today); 
#$b = "20".$3 if ($3 < 95);
#$b = "19".$3 if ($3 >= 95);
$year = $3;
$fyear = $3;
if ($fullyear < $3) {
print STDERR "Year should be less than the current date !\n";
exit;
}

#$tmp = $b;
#$tmp = "0".$tmp if (length($tmp) == 1);
#$mois = $tmp;

$file = $fileroot;

$smallyear = $year - int($year/100)*100;       
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
    $compressed_logfile_fields[$i] =~ s/\%/\$/;
    $file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}            
$filezip = $file.$zipext if ($zip == 1);


($testday,$testmonth,$testyear) = split(/\//,$opt_s);
$testmonth = $month_equiv{$testmonth};

$testjour = 0;
$countmonth = 0;

while ($countmonth != ($testmonth-1)) {
     $testjour += $month_of_year{$month_nb[$countmonth]};
     $countmonth++;
     $countmonth ="0".$countmonth if (length($countmonth) == 1);
     }

#$testyear = "19".$testyear if ($testyear >= 95);
#$testyear = "20".$testyear if ($testyear < 95);

$testjour += $testday;
$tmp4 = $testjour;
$tmpyear = $testyear;

#$c = $yearstart - int($yearstart/100)*100;

#print STDERR "$opt_s est le $testjour de l'annee\n";
#print STDERR "$firstjour est le $ydaystart de l'annee\n";

$startday = $opt_s;
#$startday =~ s/-/\//g;
#$startday =~ s/(.*)\/(.*)\/(.*)/$1\/$month_nb[($2-1)]\/$3/;

#$tmp = $3;

#$startday =~ s/$tmp/20$tmp/ if ($tmp < 95);
#$startday =~ s/$tmp/19$tmp/ if ($tmp >= 95);

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

if ($opt_r ne '') {

if ($opt_r !~ /(\d{2})\/(\w{3})\/(\d{4})/) {
print STDERR "Not a valid ending date format (valid format is  for example 02/May/1995)\n";
exit;
} else {

#$b = int($1);
if ($1 < 1 || $1 > 31) {
print STDERR "Day should be between 1 and 31 !\n";
exit;
}

$b = int($2);

#$lettermonth = $2;

$tmp = $month_equiv{$2};
$tmp = "0".$tmp if (length($tmp) == 1);
if ($tmp < 1 || $tmp > 12) {
print STDERR "Month should be between Jan and Dec !\n";
exit;
}

#$b = "20".$3 if ($3 < 95);
#$b = "19".$3 if ($3 >= 95);
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

#print STDERR "$yesterday est le $testjour2 de l'annee\n";          

($testday,$testmonth,$testyear) = split(/\//,$opt_r);
$testmonth = $month_equiv{$testmonth};

$testjour = 0;
$countmonth = 0;

while ($countmonth != ($testmonth-1)) {
     $testjour += $month_of_year{$month_nb[$countmonth]};
     $countmonth++;
     $countmonth ="0".$countmonth if (length($countmonth) == 1);
     }

$testjour += $testday;

#print STDERR "$opt_r est le $testjour de l'annee\n";

#$testyear = "19".$testyear if ($testyear >= 95);
#$testyear = "20".$testyear if ($testyear < 95);

$stopday = $opt_r;
#$stopday =~ s/-/\//g;
#$stopday =~ s/(.*)\/(.*)\/(.*)/$1\/$month_nb[($2-1)]\/$3/;

#$tmp = $3;

#$stopday =~ s/$tmp/20$tmp/ if ($tmp < 95);
#$stopday =~ s/$tmp/19$tmp/ if ($tmp >= 95);

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


if ($opt_s ne '' && $opt_r ne '') {
#print STDERR "LOGFILE : $firstjour - $yesterday\n";
#print STDERR "USER : $opt_s - $opt_r\n";
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
 
 
if ($opt_t ne '') {
$topten = $opt_t;
}

if ($opt_p ne '') {
$precision = $opt_p;
}

if ($opt_i ne '') {
$file = $opt_i;
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

if ($opt_q ne '') {
$tri = $opt_q;
}

$tmptri = 0;
$pos = length($tri);
while (($pos = rindex($tri,$dirsepurl,$pos)) >= 0) {
        $tmptri++;
        $pos--;
        }
$tmptri--;

## charge la librairie


## choix des fichiers de sortie et d'entree

$linkfilerep = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert.$gifext;
$linkfilerepx = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert."x".$gifext;
$linkfilerepy = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert."y".$gifext;

#######################################################

if ($exclude_robot == 1) { 
    if (-f "$path$dirinc$dirsep$incrobot") {
open(FILEROBOT,"$path$dirinc$dirsep$incrobot") || die "Error, unable to open $path$dirinc$dirsep$incrobot\n";
while (<FILEROBOT>) {
($tmp1,$tmp2) = split(/\t/);

   if ($tmp2 eq '') {
	print "Your robot file is not valid (too old). Run 'cron-session.pl -m' to update it\n";
	exit;
   }

push(@exclude_robot_address,$tmp2) unless ($seen{"$tmp2 $tmp1"}++);
}
#chop($exclude_robot_address);
close(FILEROBOT);

    if ($#exclude_robot_address == -1) {
	$exclude_robot = 0;
	print STDERR "No robot session found !\n";
    }

} else {
    print "Use cron-session.pl -m first to detect robot session\n";
    exit;
}

}

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

#######################################################
### creation du fichier contenant la liste des pays ###
#######################################################

# correspondance entre pays et code du pays

open(PAYSCONV,"$pathinit$dirress$dirsep$paysconv") || die "Error, unable to open $pathinit$dirress$dirsep$paysconv\n";

while (<PAYSCONV>) {
    chop;
    ($newpays,$pays,$zone)=split(/\s+/);  # format 'France (.fr)'
    if ($zone eq '') {
	$zone[$pays] = $newpays;
$nbzone++;
} else {
    $pays =~ s/\(\.(.*)\)/$1/;
$newflag{$pays}=$newpays;
$flagpage{$pays} = $newflag{$pays};
$flagpage{$pays} .= $htmlext;
$zonepays{$pays} = $zone; 
}
}
$newflag{Unknown} = "Unknown";
$flagpage{Unknown} = $unresolved;
#$flagpage{Unknown} .= $htmlext;
close PAYSCONV;


# correspondance entre fichiers et extension

open(EXTCONV,"$pathinit$dirress$dirsep$extconv") || die "Error, unable to open $pathinit$dirress$dirsep$extconv\n";

while (<EXTCONV>) {
    chop;
    ($tmp,$tmp1)=split(/\(/);
    if ($tmp1 eq '') {
	($tmp,$tmp1)=split(/\s+/,$tmp);
$zonefile[$tmp1] = $tmp;
$nbzonefile++;
} else {
    ($tmp1,$zone)=split(/\)\s+/,$tmp1);
#    $tmp1 =~ s/(.*)\)/$1/;
$extfile{$tmp1}=$tmp;
$extfilenb{$tmp1}=$zone;
#    $flagext{$tmp1} = $tmp1.$htmlext;
#print "$extfile{$tmp1} - $tmp1 - $tmp\n";
}
}
close EXTCONV;


###################################################################
## purge des repertoires si ceux-ci existent

print STDOUT "Deleting old data...\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");


for ($nblang=0;$nblang<=$#lang;$nblang++) {
$dir = $path.$lang[$nblang].$dirsep.$dirdate;
&dodirdel($dir);
}


for ($nblang=0;$nblang<=$#lang;$nblang++) {
$dir = $path.$lang[$nblang].$dirsep.$dirsite;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirscript;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirpage;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirlist;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirframe;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirdate;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirpays;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirinc;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirdomain;
$tmp2 = $dir.$dirsep."*";
unlink(<$dir$dirsep*>) if -d $dir;
}

### creation des sous directories si ceux-ci n'existent pas

# directory a la racine

$tmp = $path;
chop($tmp);
mkdir ($tmp,0775) unless -d $tmp;

$dir = $path.$dirtmp;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirinc;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirdata;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirgraph;
mkdir ($dir,0775) unless -d $dir;


# ML

for ($nblang=0;$nblang<=$#lang;$nblang++) {

$dir = $path.$lang[$nblang];
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirframe;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirpays;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirsite;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirlist;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirscript;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirpage;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirdate;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirsession;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirdocument;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirdomain;
mkdir ($dir,0775) unless -d $dir;

#$dir = $path.$lang[$nblang].$dirsep.$dirdays;
#mkdir ($dir,0775) unless -d $dir;
}

if ($debug == 1 ) {
    if (-f "$path$dirdata$dirsep$filecpu") {
open (CPUTIME,">>$path$dirdata$dirsep$filecpu") || die "Error, unable to open $path$dirdata$dirsep$filecpu\n";
} else {
open (CPUTIME,">$path$dirdata$dirsep$filecpu") || die "Error, unable to open $path$dirdata$dirsep$filecpu\n";
}
}


###################################################################
# title

chop($pathserver);

if (!(-e "$path$dirdata$dirsep$fileurl")) {
$titlename = 0;
}

&load_reverse_dns if (($reverse_dns == 1) && -f "$path$dirdata$dirsep$ip_table");

if ($titlename == 1) {
   open(URL,"$path$dirdata$dirsep$fileurl") || die "cannot open $path$dirdata$dirsep$fileurl\n";
        while (<URL>) {
        ($url,$title) = split(/\"/);
        chop($url);
#        $url =~ s/$pathserver//i;
        $urlconv{$url} = $title;
        }
}

###################################################################
#open(FILESIZE, ">$dirdate$filesize") || die "Error, unable to open $dirdate$filesize\n";

open(FILEREPERTSIZE, ">$path$dirdata$dirsep$filerepertsize") || die "Error, unable to open $path$dirdata$dirsep$filerepertsize\n";
for ($i=0;$i<=($#selecrepert);$i++) {
print FILEREPERTSIZE "$selecrepert[$i] \t";
}
print FILEREPERTSIZE "\n    ----       -----                 --------\n\n";


open(FILEDATE, ">$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";
print FILEDATE "    Date       Hosts:   New   Domain Requests: Domain  Accesses Trafic: Total HTML\n";
print FILEDATE "    ----       -----                 --------                   -------\n\n";

open(STATREPERT, ">$path$dirdata$dirsep$statrepert") || die "Error, unable to open $path$dirdate$dirsep$statrepert\n";
for ($i=0;$i<=($#selecrepert);$i++) {
print STATREPERT "$selecrepert[$i] \t";
}
print STATREPERT "\n    ----       -----                 --------\n\n";

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

close(INFILE);

  @line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);
 
# $date = $line_log[$fields_logfile{'%date'}];

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

$tmp = $fileroot.$prefixlog;
$tmp = $lastfile if (!(-f $tmp));

if (-f $tmp) {
    open(INFILE, $tmp) || die "Error, unable to open $tmp\n";
    ($size)= (stat("$tmp")) [7];
}

if (!(-f $tmp)) {
    open(INFILE, "$GZIP $lastfilezip |") || die "Error, unable to open $lastfilezip\n";
    ($size)= (stat("$lastfile")) [7];
}

$offset = int($size - 1024);
seek(INFILE,$offset,0);

$scalar = (<INFILE>);
$scalar = (<INFILE>);

 @line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);
 
($lastjour) = split(/:/,$date);
($dayfinale,$monthfinale,$yearfinale) = split(/\//,$lastjour);

#print STDERR "$lastjour - $monthfinale\n";
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

$intervalle = ($yearfinale - $yearstart)*365 + ($ydayfinale - $ydaystart)+1;
if ($intervalle > 19) {
#$starstep = int($intervalle/20); # 5% step
#$bigstarstep = int($intervalle/4); # 25% step
$starstep = $intervalle/20; # 5% step
$bigstarstep = $intervalle/4; # 25% step
}
#}

# nbre de jour il y a $nbdays days ($opt_d)

if ($opt_d ne '') {

#    print STDERR "$monthfinale - $daytmp - $monthindex\n";

#$month_number = $month_equiv{$monthfinale};
#$month_number--;
$monthindex2 = $monthindex;
$monthindex2--;

#$pastday = $dayfinale  - $opt_d; 
$pastday = $daytmp  - $opt_d; 
$pastyear = $fullyear;
#$pastmonth = $month_nb[$month_number];
$pastmonth = $month_nb[$monthindex2];

while ($pastday < 1) {
#  $month_number--;
  $monthindex2--;
  if ($monthindex2 < 0) {
      $pastyear--;
      $monthindex2 = 11;
   }
   $pastmonth = $month_nb[$monthindex2];
   $pastday = $pastday + $month_of_year{$pastmonth};
}

$pasttoday = $pastday." ".$pastmonth." ".$pastyear;  

#    print STDERR "$pasttoday\n";

#($dd1,$dd2,$dd3) = split(/\s+,$pasttoday);

$pastmonthnb = $month_equiv{$pastmonth};
$pastmonthnb = "0".$pastmonthnb if (length($pastmonthnb) == 1);

$day = $pastday;
$month = $month_equiv{$pastmonth};
$lettermonth = $pastmonth;
$year = $pastyear;

$month = "0".$month if (length($month) == 1);
$day = "0".$day if (length($day) == 1);

$smallyear = $year - int($year/100)*100;              
$smallyear = "0".$smallyear if (length($smallyear) == 1);

if ($zip != 0) {       
$file = $fileroot;
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
     $compressed_logfile_fields[$i] =~ s/\%/\$/;
     $file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
     }            
$filezip = $file.$zipext if ($zip == 1);
}

#$file = $fileroot.$prefixlog.".".$pastmonthnb."-".$pastyear;
#$filezip = $fileroot.$prefixlog.".".$pastmonthnb."-".$pastyear.".gz";
 
#print STDERR "$filezip $ydayfinale $opt_d $month\n";

#print STDERR "Day : $pasttoday\n";

}

#undef @month_nb;

if ($opt_s ne '' && $zipcut == 2) {

($ds1,$ds2,$ds3) = split('/',$startday);
$day = $ds1;
$month = $month_equiv{$ds2};
$lettermonth = $ds2;
$year = $ds3;

$month = "0".$month if (length($month) == 1);
$day = "0".$day if (length($day) == 1);

$file = $fileroot;
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);

for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
     $compressed_logfile_fields[$i] =~ s/\%/\$/;
     $file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
     }            
$filezip = $file.$zipext if ($zip == 1);
}


#################################################################
###            beginning to scan the log file                 ###
#################################################################

print STDERR "\nWarning : Reverse dns is on...it will slow down speed !\n" if ($reverse_dns == 1);
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET" && $reverse_dns == 1);

($ds1,$ds2,$ds3) = split('/',$startday);
($de1,$de2,$de3) = split('/',$stopday);
$mds2 = $month_equiv{$ds2};
$mde2 = $month_equiv{$de2};

#print "$startday $ds1 $mds2 $ds3 - $stopday $de1 $mde2 $de3\n";

while ($stop == 0) {

print STDOUT "Log file : $file ";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print STDOUT "(* = 5%)" if ($intervalle > 19);
print STDOUT "\n";

### Boucle principale

if (($zip == 1) && ($file ne $filezip)) {
       open(FILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
#       print STDOUT "File $filezip uncompressed\n";
#       print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    } else {
           open(FILE,$file) || die "Error, unable to open $file\n";
      }

#seek(INFILE,$offset,0);
#seek(FILE,0,0);
$sizeold = $size if ($debug == 1);
($size)= (stat("$filezip")) [7] if ($debug == 1);


BOUCLE:
while (<FILE>) {

 @line_log = split(/$logfile_sep/);
 chop($line_log[$#line_log]);
 next if ($line_log[0] =~ /^#/);

 $adresse = $line_log[$fields_logfile{'%host'}];

 $b = $line_log[$fields_logfile{'%login'}];
 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

 $d = $line_log[$fields_logfile{'%method'}];
 $page = $line_log[$fields_logfile{'%page'}];

 $query = $line_log[$fields_logfile{'%query'}] if ($fields_logfile{'%query'} ne ''); 
 $status = $line_log[$fields_logfile{'%status'}];
 $requetesize = $line_log[$fields_logfile{'%requetesize'}];

 $vserver = $line_log[$fields_logfile{'%virtualhost'}] if ($fields_logfile{'%virtualhost'} ne '');
 $vserver = $1 if ($page =~ /^\/\/([-.0-9a-z]+)\//i && $virtualCLF != 0);

 $vserver = $line_log[$#line_log] if ($#logfile_fields == $fields_logfile{'%virtualhost'});

 $page =~ s/\/\/$virtualfilter// if (($virtualCLF != 0 && $virtualfilter ne '') || ($d =~ /$localserver/));
 $page =~ s/\"// if ($requetesize !~ /(\d+)/);


 next if ($page !~ /^\//);
 next if ($status !~ /^(\d+)$/);
 next if ($date !~ m/^((\d+)\/(\w+)\/(\d\d\d\d):)(.*)/);
 next if ($adresse eq '');

if ($adresse =~ /\//) {
    ($tmp,$adresse) = split(/:/,$adresse);
    print "Problem : found $tmp ... fixing done\n";
}

if ($opt_s ne '' || $opt_r ne '') {
($fa) = split(':',$date);
($fa1,$fa2,$fa3) = split('/',$fa);
$stop = 1 if ($fa3 > $de3);
next if ($fa3 < $ds3 || $fa3 > $de3);
$mequiv = $month_equiv{$fa2};
$stop = 1 if ($fa3 == $de3 && $mequiv > $mde2);
#if ($stop == 1) {
#print "Error 1 : $fa3 = $de3 - $mequiv > $mde2\n";
#print "TOTO : $_";
#$stop = 0;
#}

next if (($fa3 == $ds3 && $mequiv < $mds2) || ($fa3 == $de3 && $mequiv > $mde2));
$stop = 1 if ($fa3 == $de3 && $mequiv == $mde2 && $fa1 > $de1);
#if ($stop == 1) {
#print "Error 2 : $fa3 = $de3 - $mequiv = $mde2 - $fa1 $de1\n";
#print "TOTO : $_";
#$stop = 0;
#}

next if (($fa3 == $ds3 && $mequiv == $mds2 && $fa1 < $ds1) || ($fa3 == $de3 && $mequiv == $mde2 && $fa1 > $de1));
}

if ($opt_d ne '') {
($fa) = split(':',$date);
($fa1,$fa2,$fa3) = split('/',$fa);
next if ($fa3 < $pastyear);
$mequiv = $month_equiv{$fa2};
next if ($fa3 == $pastyear && $mequiv < $pastmonthnb);
next if ($fa3 == $pastyear && $mequiv == $pastmonthnb && $fa1 < $pastday);
}

$co_last = 1 if ($date =~ $today);
next if ($date =~ $today);

$page =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
$page =~ tr/[A-Z]/[a-z]/ if ($type_serveur == 1);
next if ($page !~ m#$tri#); # stats sur une partie du serveur
next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
next if ($d =~ /$localserver/ && $vserver ne '');
next if ($vserver =~ /$excludevirtual/i && $excludevirtual ne '');
next if ($vserver !~ /$virtualfilter/i && $virtualfilter ne '' && $vserver ne '');

$page .= $defaulthomepage if (substr($page,length($page)-1) eq "/");
next if ($page =~ /\"$/ && $iis_format != 1); # all format should be %page %protocol
next if ($d !~ /^\"/ && $iis_format != 1); # all format should be %page %protocol


$loglines++;

$exclpages++ if ($page =~ /$excluderepert/i && $excluderepert ne '');
next if ($page =~ /$excluderepert/i && $excluderepert ne '');

if ($exclude_frame == 1) {
    for ($i=0;$i<=$#exclude_page_frame;$i++) {
	if ($page eq $exclude_page_frame[$i]) {
	    $exclframed++ ;
	    next BOUCLE;
	}
    }
}

#$exclframed++ if ($page =~ /$exclude_page_frame/i && ($exclude_frame == 1));
#next if ($page =~ /$exclude_page_frame/i && ($exclude_frame == 1));

$status = $1 if ($query =~ /(\d\d\d);http:\/\// && $type_serveur == 1);

$proxy++ if ($status == 304);
$redirect++ if ($status == 302 || $status == 301);
next if ($status == 304) ; #ote les pages ne contenant rien
next if ($status == 302) ; #ote les pages ne contenant rien
next if ($status == 301) ; #redirect automatique

#next if ($requetesize == 0) ; #ote les pages ne contenant rien

$adresse = $nis{$adresse} if ($nis{$adresse} ne '');
$adresse = &reversedns($adresse) if ($reverse_dns == 1 && $adresse =~ /^[0-9.]+$/);
$adresse = $adresse.".".$localdomainename if (split(/[.]/,$adresse) == 1);

$excladdr++ if (($adresse =~ m/$localdomaine/o) && ($locallog == 0));
$excladdr++ if (($adresse =~ /$nolog/i) && ($nolog ne ''));

next if (($adresse =~ m/$localdomaine/o) && ($locallog == 0));
next if (($adresse !~ m/$localdomaine/o) && ($localonly == 1));
next if (($adresse =~ /$nolog/i) && ($nolog ne ''));

$notfound++ if ($status == 404);
$forbiden++ if ($status == 403);
next if (($status >= 400) && ($status < 599));

if ($exclude_robot == 1) {
    for ($i=0;$i<=$#exclude_robot_address;$i++) {
	if ($adresse eq $exclude_robot_address[$i]) {
	    $exclrobots++ ;
	    next BOUCLE;
	}
    }
}


$page = $page."?".$query if ($query ne '' && $query ne '-,');

#if ($inc_script == 1) {
#$d =~ s/\"//g;
#$d =~ tr/[a-z]/[A-Z]/;
#if ($d eq "POST") {
#$method{$d}++;
#$script{$page}++;
#$scriptunique++ if ($script{$page} == 1);
#}
#if ($d eq "GET" && $page =~ /[^\/]\?/) {
#    $method{$d}++;
#    ($namescript,$argscript) = split(/\?/,$page);
#    @valarg = split(/&/,$argscript);
#    foreach $pair (@valarg) {
#	($name,$value) = split(/=/,$pair);
#	$value =~ tr/+/ /;
#	$name =~ tr/[a-z]/[A-Z]/;
#	$value =~ tr/[A-Z]/[a-z]/;
##    $value = "-" if ($value eq '');
#	if (!($seen{"$namescript $name"}++)) {
#            $argunique{$namescript}++;
#            $scriptdata{$namescript,$argunique{$namescript}} = $name;
##            }
##    if (!($seen{"$namescript $name $value"}++)) {
#            $nameunique{$namescript,$name}++;
#            $countargval{$namescript,$name,$nameunique{$namescript,$name}} = $value;
#	}           
#	$countarg{$namescript,$name,$value}++;
#    }
#    $script{$namescript}++;
#    $scriptunique++ if ($script{$namescript} == 1);
#}
#if ($fullday == 1) {
#    $scriptday{$namescript}++;
#    $scriptuniquejour++ unless ($scriptday{$namescript} != 1);
#}
#}


#for ($j=1;$j<=$argunique{$script};$j++) {
#$tmp = $scriptdata{$script,$j};

($jour) = split(/:/,$date);
($daytoday,$monthtoday,$yeartoday) = split(/\//,$jour);

next if ($month_equiv{$monthtoday} !~ /(\d+)/);
next if (length($yeartoday) != 4);
$jour =~ s/[\/]/ /g;

if ($firstday eq '') {
    ($firstday) = $date =~ m/^((\d+)\/(\w+)\/(\d+))(.*)/;
    $firstday =~ s/[\/]/ /g;
    $oldjour = $firstday;

    ### number of the current day

    $ydayyesterday = 0;
    $countmonth = 0;
    $month_end = $month_nb[$countmonth];

     while ($month_end ne $monthtoday) {
     $ydayyesterday += $month_of_year{$month_end};
     $countmonth++;
     $month_end = $month_nb[$countmonth];
     }

     $ydayyesterday += $daytoday + ($yeartoday*365);
}


$pays = substr($adresse,rindex($adresse,'.')+1,length($adresse));
$pays =~ tr/A-Z/a-z/;
print "Problem found : $date - $adresse (skipping...)\n" if (length($pays) > 4);
next if (length($pays) > 4); 

next if ($pays ne $country_filtering && $country_filtering ne '');

$adresse =~ tr/A-Z/a-z/;

### tri par jour sur les pages, requetes.... ###
# aucune variable utilise ne doit porte le meme nom que dans la suite...

if ($jour ne $oldjour) {


($var1,$var2) = split(' ',$jour);
($oldvar1,$oldvar2) = split(' ',$oldjour);

next BOUCLE if (($var2 eq $oldvar2) && ($var1 < $oldvar1));
next BOUCLE if (($var2 ne $oldvar2) && ($var1 > $oldvar1));


###
    if ($debug == 1) {

$datesyst = &ctime(time);
($dayletterxx,$monthxx,$dayxx,$hourdatexx,$axx,$yearxx) = split(/[ \t\n\[]+/,$datesyst);
($hourxx,$minutexx,$secondxx) = split(/:/,$hourdatexx);

# calculer le temps mis pour le calcul
$endrun2 = "$hourxx:$minutexx:$secondxx";

($minxx,$secxx) = &timetaken($startrun2,$endrun2) if ($oldjour ne $firstday);
($minxx,$secxx) = &timetaken($startrun,$endrun2) if ($oldjour eq $firstday);

#$endtime = time();

#print "$oldjour :  $lineread hits - $sizeold Kb - $newhost hosts : $minxx min $secxx sec\n";
print "$oldjour : $minxx min $secxx sec\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$tmpsecxx = ($minxx*60) + $secxx;
print CPUTIME "$tmpsecxx $lineread $sizeold\n";
$starttime = time();
$startrun2 = "$hourxx:$minutexx:$secondxx";
$lineread = 0;
}


###

$nbdays++;

if ($intervalle > 19 && $zip != 1 && $debug == 0) {

if ($nbdays >= ($starstep*$av1)) {
print STDERR "*";
$av1++;
}

if ($nbdays >= ($bigstarstep*$av2)) {
print STDERR " ";
$av2++;
}

}

### number of the current day

$ydayyesterday = 0;
$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $monthtoday) {
    $ydayyesterday += $month_of_year{$month_end};
$countmonth++;
$month_end = $month_nb[$countmonth];
}

$ydayyesterday += $daytoday + ($yeartoday*365);

$totsizejour = $totsize - $totsizeold;
$totsizeold = $totsize;

$tothtmlsizejour = $tothtmlsize - $tothtmlsizeold;
$tothtmlsizeold = $tothtmlsize;

if ($fullday == 1 && ($ydayyesterday > ($ydaystarttoday - $nbdayscf+1))) {

$oldjour =~ s/ /\//g;

# Tri Pages

foreach $tmp (sort (keys(%pagesluesday))) {
    push(@counterpage,$pagesluesday{$tmp}) unless $seen{"$oldjour $tmp $pagesluesday{$tmp}"}++;
    $countpage[$pagesluesday{$tmp}]++;
    $occur_counterpage{$pagesluesday{$tmp},$countpage[$pagesluesday{$tmp}]} = $tmp;
}

@bestpagesluesday = reverse sort bynumber @counterpage;

# Tri Scripts

foreach $tmp (sort (keys(%scriptday))) {
    push(@counterscript,$scriptday{$tmp}) unless $seen{"$oldjour $tmp $scriptday{$tmp} $script"}++;
    $countscript[$scriptday{$tmp}]++;
    $occur_counterscript{$scriptday{$tmp},$countscript[$scriptday{$tmp}]} = $tmp;
}

@bestscriptday = reverse sort bynumber @counterscript;

# Tri Hosts

foreach $tmp (sort (keys(%serverjour))) {
    push(@counterserver,$serverjour{$tmp}) unless $seen{"$oldjour $tmp $serverjour{$tmp}"}++;
    $countserver[$serverjour{$tmp}]++;
    $occur_counterserver{$serverjour{$tmp},$countserver[$serverjour{$tmp}]} = $tmp;
}

@bestserverjour = reverse sort bynumber @counterserver;

# Tri Countries

foreach $tmp (sort (keys(%paysjour))) {
    push(@counterpays,$paysjour{$tmp}) unless $seen{"$oldjour $tmp $paysjour{$tmp}"}++;
    $countpays[$paysjour{$tmp}]++;
    $occur_counterpays{$paysjour{$tmp},$countpays[$paysjour{$tmp}]} = $tmp;
}

@bestpaysjour = reverse sort bynumber @counterpays;

$oldjour =~ s/[\/]/ /g;

# Tri des zones de filetype

for ($k=0;$k<=$#listext;$k++) {

    next if ($listext[$k] =~ /$extension/);
    $listextbis[$k] = $listext[$k];

    $tmp2 = 0;
    for ($j=1;$j<=$maxdownloadjourlength;$j++) {
	$tmp2 += $downloadjour{$listext[$k],$j};
    }
    $zoneextjour[$extfilenb{$listext[$k]}] += $tmp2;

}

##

for ($k=1;$k<=$nbzonefile;$k++) {
    $zoneextbis[$k] = $zoneextjour[$k];
}

  for ($j=1;$j<=$nbzonefile;$j++) {
      $max = $zoneextbis[$j];
      $filetypejourmax[$j] = 0;
      for ($k=1;$k<=$nbzonefile;$k++) {
	  if ($zoneextbis[$k] > $max) {
	      $max = $zoneextbis[$k];
	      $filetypejourmax[$j] = $k;
	  }
      }
      $zoneextbis[$filetypejourmax[$j]] = 0;      
  }




# Tri directories

$occur[0] = 0;

foreach $rootrepert (keys(%freqjourrachtml)) {
if ($freqjourrachtml{$rootrepert} > $occur[0]) {
    $occur[0] = $freqjourrachtml{$rootrepert};
    $bestselecrepert[0] = $rootrepert;
}
}

for ($i=1;$i <=$topten;$i++) {
    $occur[$i] = 0;
    foreach $rootrepert (keys(%freqjourrachtml)) {
        $out = 0;
        if ($freqjourrachtml{$rootrepert} > $occur[$i] && ($freqjourrachtml{$rootrepert} <= $occur[$i-1])) {
               for ($j=0;$j<= $i;$j++) {
                  $out = 1 if ($bestselecrepert[$j] eq $rootrepert);
                }
                if ($out == 0) {
                      $occur[$i] = $freqjourrachtml{$rootrepert};
                      $bestselecrepert[$i] = $rootrepert;
               }
	   }
    }
}

($tmp1,$tmp2,$tmp3) = split(/ /,$oldjour);
$dirresume = $tmp3."-".$tmp2."-".$tmp1;
$fileresume = $tmp3."-".$tmp2."-".$tmp1.$htmlext;

for ($nblang=0;$nblang<=$#lang;$nblang++) {

$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
mkdir ($tmp,0775) unless -d $tmp;

open(FILERESUMEFRAME,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$menu") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$menu\n";
open(FILERESUMEMENU,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$fileresumemenu") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$fileresumemenu\n";
open(FILERESUMETAB,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$filemoyenne") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$filemoyenne\n";

&PageResumeFrame(*FILERESUMEFRAME, eval($Lang{$lang[$nblang]}));
&PageResumeMenu(*FILERESUMEMENU, eval($Lang{$lang[$nblang]}));
&PageResumeTab(*FILERESUMETAB, eval($Lang{$lang[$nblang]}));

close (FILERESUMEFRAME);
close (FILERESUMEMENU);
close (FILERESUMETAB);

open(FILERESUMEPAYS,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirpays$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirpays$htmlext\n";
open(FILERESUMEDIR,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirlist$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirlist$htmlext\n";
open(FILERESUMEPAGE,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirpage$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirpage$htmlext\n";
open(FILERESUMEHOSTS,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirsite$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirsite$htmlext\n";
open(FILERESUMESCRIPT,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirscript$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirscript$htmlext\n";
open(FILERESUMEFILETYPE,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$filetype$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$filetype$htmlext\n";

&PageResumePays(*FILERESUMEPAYS, eval($Lang{$lang[$nblang]}));
&PageResumeDir(*FILERESUMEDIR, eval($Lang{$lang[$nblang]}));
&PageResumeHosts(*FILERESUMEHOSTS, eval($Lang{$lang[$nblang]}));
&PageResumePage(*FILERESUMEPAGE, eval($Lang{$lang[$nblang]}));
&PageResumeScript(*FILERESUMESCRIPT, eval($Lang{$lang[$nblang]}));
&PageResumeFiletype(*FILERESUMEFILETYPE, eval($Lang{$lang[$nblang]}));

close (FILERESUMEPAYS);
close (FILERESUMEDIR);
close (FILERESUMEHOSTS);
close (FILERESUMESCRIPT);
close (FILERESUMEPAGE);
close (FILERESUMEFILETYPE);
}
}

#

if ($precision > 1) {
print FILEDATE "$oldjour \t $serveruniquejour \t $newhost \t $locserverjour \t $reqtotjour \t $domreq \t $accessjour \t $totsizejour \t $tothtmlsizejour\n";

#print FILESIZE "$oldjour \t $totsize $externesize $domsize \n";

print FILEREPERTSIZE "$oldjour \t";
for ($i=0;$i<=($#selecrepert);$i++) {
$rootrepert = $selecrepert[$i];
$sizejourrachtml{$rootrepert} = 0 if ($sizejourrachtml{$rootrepert} eq '');
$sizejourrachtmlext{$rootrepert} = 0 if ($sizejourrachtmlext{$rootrepert} eq '');
$sizejourrachtmldom{$rootrepert} = 0 if ($sizejourrachtmldom{$rootrepert} eq '');
$totsize{$rootrepert} = 0 if ($totsize{$rootrepert} eq '');
$extsize{$rootrepert} = 0 if ($extsize{$rootrepert} eq '');
$domsize{$rootrepert} = 0 if ($domsize{$rootrepert} eq '');
print FILEREPERTSIZE "$sizejourrachtml{$rootrepert} $sizejourrachtmlext{$rootrepert} $sizejourrachtmldom{$rootrepert} $totsize{$rootrepert} $extsize{$rootrepert} $domsize{$rootrepert} \t ";
}
print FILEREPERTSIZE "\n";



print STATREPERT "$oldjour \t ";
for ($i=0;$i<=($#selecrepert);$i++) {
$rootrepert = $selecrepert[$i];
$freqjourrac{$rootrepert} = 0 if ($freqjourrac{$rootrepert} eq '');
print STATREPERT "$freqjourrac{$rootrepert} \t ";
}
print STATREPERT "\n";
}


#$serveroldunique = $serverunique;
##$serveroldunique = $serveruniquejour;

# recopie du tableau pour comparaison avec le jour suivant
#for ($i=0;$i<$serverunique;$i++) {
#    $listoldadresse[$i] = $listadresse[$i];
#    }

# mise a 0 des serveurs du jour
#for ($j=0;$j<$serveruniquejour;$j++) {
#    $listadressejour[$j] = 0 ;
#    }

for ($l=0;$l<=$nbzonefile;$l++) {
    $zoneextjour[$l] = 0;
    $zoneextbis[$l] = 0;
}

for ($k=0;$k<=$#listext;$k++) {
for ($j=1;$j<=$maxdownloadjourlength;$j++) {
    $downloadjour{$listext[$k],$j} = 0;
}
}

$maxdownloadjourlength = 0;

$oldoldjour = $oldjour;

# mise a zero des variables journalieres
$reqtotjour = 0;
$newhost = 0;
$domreq = 0;
#$domsize = 0;
$accessjour = 0;
$locserverjour = 0;
$serveruniquejour = 0;
$scriptuniquejour = 0;
#$totsizejour = 0;
#$tothtmlsizejour = 0;
$oldjour = $jour;

$pageuniquejour = 0;

if ($fullday == 1) {

foreach $tmp (keys(%pagesluesday)) {
#for ($i=0;$i<=$countpage[$pagesluesday{$tmp}];$i++) {
#$occur_counterpage{$pagesluesday{$tmp},$i} = '';
#}
$countpage[$pagesluesday{$tmp}] = 0;
#$pagesluesday{$tmp} = 0;
}

undef %occur_counterpage;
undef %pagesluesday;
undef @counterpage;

foreach $tmp (keys(%scriptday)) {
    $countscript[$scriptday{$tmp}] = 0;
}

undef %occur_counterscript;
undef %scriptday;
undef @counterscript;

foreach $tmp (keys(%serverjour)) {
#for ($i=0;$i<=$countserver[$serverjour{$tmp}];$i++) {
#$occur_counterserver{$serverjour{$tmp},$i} = '';
#}
$countserver[$serverjour{$tmp}] = 0;
#$serverjour{$tmp} = 0;
}

undef %occur_counterserver;
undef %serverjour;
undef @counterserver;

$paysuniquejour = 0;
$paysjournew = 0;

foreach $tmp (keys(%paysjour)) {
#for ($i=0;$i<=$countpays[$paysjour{$tmp}];$i++) {
#$occur_counterpays{$paysjour{$tmp},$i} = '';
#}
$countpays[$paysjour{$tmp}] = 0;
#$paysjour{$tmp} = 0;
#$paysjourlist{$tmp} = 0;
}

undef %occur_counterpays;
undef %paysjour;
undef %paysjourlist;
undef @counterpays;

} else {

# effacement du tableau des machines locales par jour
#foreach $var_adr (keys(%serverjour)) {
#$serverjour{$var_adr} = 0;
#}

undef %serverjour;

}



#foreach $tmp (keys(%freqjourrachtml)) {
#    $sizejourrachtml{$tmp} = 0;
#    $freqjourrachtml{$tmp} = 0;
#}

undef %sizejourrachtml;
undef %freqjourrachtml;

if ($precision > 2) {
#for ($i=0;$i<=($#selecrepert);$i++) {
#$freqjourrac{$selecrepert[$i]} = 0;
#$sizejourrachtml{$selecrepert[$i]} = 0;
#$sizejourrachtmldom{$selecrepert[$i]} = 0;
#$sizejourrachtmlext{$selecrepert[$i]} = 0;
#$totsize{$selecrepert[$i]} = 0;
#$extsize{$selecrepert[$i]} = 0;
#$domsize{$selecrepert[$i]} = 0;
#}
undef %freqjourrac;
undef %sizejourrachtml;
undef %sizejourrachtmldom;
undef %sizejourrachtmlext;
undef %totsize;
undef %extsize;
undef %domsize;
}

}

############################################################################################

$lineread++ if ($debug == 1);

### virtual host (NECLF)

if ($vserver ne '') {
$vserver =~ s/[()]//g;
$virtual{$vserver}++;
$virtualsize{$vserver} += $requetesize;
$virtualunique++ if ($virtual{$vserver} == 1);
#print "$vserver - $virtual{$vserver} - $virtualunique\n";
}


### scripts

if ($inc_script == 1) {
    $d =~ s/\"//g;
    $d =~ tr/[a-z]/[A-Z]/;
if ($d eq "POST") {
    $method{$d}++;
$script{$page}++;
$scriptunique++ if ($script{$page} == 1);
}
if ($d eq "GET" && $page =~ /[^\/]\?/) {
    $method{$d}++;
    ($namescript,$argscript) = split(/\?/,$page);
    @valarg = split(/&/,$argscript);
    foreach $pair (@valarg) {
	($name,$value) = split(/=/,$pair);
	$value =~ tr/+/ /;
	$name =~ tr/[a-z]/[A-Z]/;
	$value =~ tr/[A-Z]/[a-z]/;
	if (!($seen{"$namescript $name"}++)) {
            $argunique{$namescript}++;
            $scriptdata{$namescript,$argunique{$namescript}} = $name;
            $nameunique{$namescript,$name}++;
            $countargval{$namescript,$name,$nameunique{$namescript,$name}} = $value;
	}           
	$countarg{$namescript,$name,$value}++;
    }
$script{$namescript}++;
$scriptunique++ if ($script{$namescript} == 1);
}

if ($fullday == 1) {
    $scriptday{$namescript}++;
    $scriptuniquejour++ unless ($scriptday{$namescript} != 1);
}

}


### requetes locales

if ($adresse =~ m/$localdomaine/o) {
     $domreq++;
     $domsize += $requetesize;
     $reqdomtot++;
     } else {
         $externesize += $requetesize;
         }

### requetes totales

$reqtot++;
$totsize += $requetesize;
$reqtotjour++;

### liste des acces par pays

if ($precision > 2) {
$pays = "Unknown" if ($pays =~ /^[0-9]+/);
$pays = substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)) if ($adresse =~ /$localdomaine/);
$payslist{$pays}++;
$sizepays{$pays} += $requetesize;
#$sizepaysdom += $requetesize if ($locallog == 1 && $adresse =~ m/$localdomaine/);
$paysunique++ if ($payslist{$pays} == 1 && $pays ne "Unknown");
if ($fullday == 1) {
$paysjour{$pays}++;
$paysuniquejourlist[$paysuniquejour] = $pays if ($paysjour{$pays} == 1);
$paysuniquejour++ if ($paysjour{$pays} == 1);
$paysjournew++ if ($payslist{$pays} == 1);
}
}

### liste des differentes adresses et le nbre de requetes associees

$server{$adresse}++ unless ($adresse =~ m/$localdomaine/);
$localserver{$adresse}++ unless ($adresse !~ m/$localdomaine/);
if ($server{$adresse} == 1 || $localserver{$adresse} == 1) {
#   $listadresse[$serverunique] = $adresse;
   $serverunique++ if ($adresse !~ m/$localdomaine/);
   $locserver++ if ($adresse =~ m/$localdomaine/);
   $nbpageserveur{$adresse}=0;
   $serverpays{$pays}++;
}

### machine local (domaine) se connectant par jour

$serverjour{$adresse}++;
if (($serverjour{$adresse}) == 1) {
#   $listadressejour[$serveruniquejour] = $adresse;
   $newhost++ unless ($seen{$adresse}++);
   $serveruniquejour++;

if ($fullday == 1) {
   $locserverjour++ if ($adresse =~ m/$localdomaine/);
   $paysjourlist{$pays}++;
}

 }
 
### Classement par type de fichiers

#if ($page !~  /\?/ && $page =~ /\./ && $status == 200 && $precision > 2) {
if ($precision > 2 && $page =~ /\./) {
$tmp = length($requetesize);
if ($page =~ /\?/) {
    $tmp1 = substr($page,0,index($page,'?'));
    $tmp1 = substr($tmp1,rindex($tmp1,'.'));
} else {
    $tmp1 = substr($page,rindex($page,'.'));
}
$tmp1 =~ tr/[A-Z]/[a-z]/;
$tmp1 =~ s/\#.*$//;
$tmp1 =~ s/\/.*$//;
$maxdownloadlength = $tmp if ($tmp > $maxdownloadlength);
$maxdownloadjourlength = $tmp if ($tmp > $maxdownloadjourlength);
$download{$tmp1,$tmp}++;
$downloadjour{$tmp1,$tmp}++;
$downloadsize{$tmp1,$tmp} += $requetesize;
$filetype{$page}++ if ($tmp1 !~ /$extension/);
push(@listext,$tmp1) if ($downloadsizeext{$tmp1} eq '');
$downloadsizeext{$tmp1} += $requetesize;
}

### Date de la derniere visite pour chaque domaine

if ($adresse =~ /^[0-9.]+$/) {
        $domaindate{$adresse} = $jour;
} else {
        $domadresse = substr($adresse,(rindex(substr($adresse,0,rindex($adresse,'.')),'.')+1),length($adresse));
        $domaindate{$domadresse} = $jour;
}

### liste par pages consultees

# unix or nt serveur
if ($type_serveur != 2) {
    if (substr($page,rindex($page,'.')) =~ /$extension/i) {
    $pagesite{$adresse,($nbpageserveur{$adresse})}=$page if ($precision > 3);
    $nbpageserveur{$adresse}++;     
    $access++;
    $accessdom++ if ($adresse =~ m/$localdomaine/);    
    $accessjour++;
    $payshtml{$pays}++;
    $payshtmldom++ if ($locallog == 1 && $adresse =~ m/$localdomaine/);
    $tothtmlsize += $requetesize;
    $pageslues{$page}++;
if ($fullday == 1) {
    $pagesluesday{$page}++;
    $pageuniquejour++ unless ($pagesluesday{$page} != 1);
}
    $pageunique++ unless ($pageslues{$page} != 1);
     }
#   }
}

# domino server
if ($type_serveur == 2) {
$domino_image = 0;      
DOMINO_IMAGE:
for ($i=0;$i<=($#extensionimage);$i++) {
    if (substr($page,rindex($page,'.')+1) =~ /^$extensionimage[$i]$/i) {
    $domino_image = 1;  
    last DOMINO_IMAGE;
        }
    }

if ($domino_image == 0) {
    $pagesite{$adresse,($nbpageserveur{$adresse})}=$page if ($precision > 3);
    $nbpageserveur{$adresse}++;     
    $access++;
    $accessdom++ if ($adresse =~ m/$localdomaine/);    
    $accessjour++;
    $payshtml{$pays}++;
    $payshtmldom++ if ($locallog == 1 && $adresse =~ m/$localdomaine/);
    $tothtmlsize += $requetesize;
    $pageslues{$page}++;
if ($fullday == 1) {
    $pagesluesday{$page}++;
    $pageuniquejour++ unless ($pagesluesday{$page} != 1);
}
    $pageunique++ unless ($pageslues{$page} != 1);
   }   
}

### chargement des adresses pour quelques pages selectionnees

if ($precision > 2) {

if ($ydayyesterday > ($ydaystarttoday - $nbdayscf+1)) {

for ($i=0;$i<=($#selection);$i++) {
    if ($page =~ m/^$selection[$i]/i) {
     push(@selecadresse,$adresse);
     push(@selecpages,$page);
     push(@selecdate,$date);
     $pageslues{$page}++ if (substr($page,rindex($page,'.')) !~ /$extension/i);
     $pagesluesday{$page}++ if (substr($page,rindex($page,'.')) !~ /$extension/i);   
     }
 }
}
}

### chargement des repertoires consultes et calcul de la frequentation de ceux-ci

if ($precision > 2) {
if ($page =~ m/\/.*\//) {
    $page =~ s/\/\//\//;
    $page =~ s/(.*)\?(.*)/$1/ if ($page =~ /\?/);
   $posslash = rindex($page,'/',length($page));
   $racine = substr($page,0,$posslash+1);

# ajout des sous-repertoires

   $racinebis = $racine;

   $scandirrec = 0;
      
   while ($posslash > 0) {
   $freqrac{$racinebis}++;
   $freq2rac{$racine}++ if ($scandirrec == 0);

    if (substr($page,rindex($page,'.')) =~ /$extension/i) {
#    if (substr($page,rindex($page,'.')+1) =~ /^$extension[$i]$/i) {
            $freqrachtml{$racinebis}++;
            $freq2rachtml{$racine}++ if ($scandirrec == 0);
	    $freqjourrachtml{$racine}++ if ($scandirrec == 0);
            $sizejourrachtml{$racinebis} += $requetesize;
            if ($adresse =~ m/$localdomaine/) {
                      $freqrachtmldom{$racinebis}++;
                      $sizejourrachtmldom{$racinebis} += $requetesize;
                      } else {
                      $sizejourrachtmlext{$racinebis} += $requetesize;
                      }
            }

   $totsize{$racinebis} += $requetesize;
   $extsize{$racinebis} += $requetesize if ($adresse !~ m/$localdomaine/);
   $domsize{$racinebis} += $requetesize if ($adresse =~ m/$localdomaine/);

   $freqtotsize{$racinebis} += $requetesize;
   $freqextsize{$racinebis} += $requetesize if ($adresse !~ m/$localdomaine/);
   $freqdomsize{$racinebis} += $requetesize if ($adresse =~ m/$localdomaine/);

   $freq2totsize{$racine} += $requetesize if ($scandirrec == 0);
#   $freq2extsize{$racine} += $requetesize if ($adresse !~ m/$localdomaine/);
#   $freq2domsize{$racine} += $requetesize if ($adresse =~ m/$localdomaine/);

   $freqjourrac{$racinebis}++;
#   $repertunique++ if ($freqrac{$racinebis} == 1);

   $posslash--;
   $posslash--;
   $posslash = rindex($racinebis,'/',$posslash);
   $racinebis = substr($racinebis,0,$posslash+1);
   $scandirrec = 1;

  }
  # fin du ($page =~ m/)
  } else {
   if ($tri eq "/") {
   $racine = $dirsepurl;
   $racinebis = $racine;
   $freq2rac{$racine}++; # if ($scandirrec == 0);

    if (substr($page,rindex($page,'.')) =~ /$extension/i) {   
            $freq2rachtml{$racine}++; # if ($scandirrec == 0);
            $sizejourrachtml{$racinebis} += $requetesize;
            if ($adresse =~ m/$localdomaine/) {
                      $freqrachtmldom{$racinebis}++;
#                      $freq2rachtmldom{$racine}++ if ($scandirrec == 0);
		      $freqjourrachtml{$racine}++ if ($scandirrec == 0);
                      $sizejourrachtmldom{$racinebis} += $requetesize;
                      } else {
                      $sizejourrachtmlext{$racinebis} += $requetesize;
                      }
            }

   $freq2totsize{$racine} += $requetesize; # if ($scandirrec == 0);
   $freqjourrac{$racinebis}++;
   }
   # fin du else
  }
# fin du ($precision > 2)
}


}

#################################################################################################

# stockage de la derniere journee
#$newhost = $serveruniquejour;

#for ($j=0;$j<$serveroldunique;$j++) {

#        $adressetmp = $listadresse[$j];
#        for ($i=0;$i<$serveruniquejour;$i++) {
#           $newhost-- if ($adressetmp eq $listadressejour[$i]);
#           last if ($adressetmp eq $listadressejour[$i]);
#        }
#}

close FILE;

###############################################################################################

# mois gzip suivant

$stop = 1 if (($zip != 1 && $zipcut == 0) || ($filezip eq $file));

if ($zip == 1 || $zipcut != 0) {

#$yyear = $year;
#$year = $fyear if ($opt_d eq '');
#$day++ if ($zipcut == 2);
#$day = "0".$day unless (length($day) == 2);
#$month++ if ($zipcut == 1);
#$monthprev = $month-1 if ($zipcut == 1);
#if ($day > $month_of_year{$month_nb[$monthprev]} && $zipcut == 2) {
#$month++;
#$monthprev++;
#$day = "01";
#}
#$month = "0".$month unless (length($month) == 2);
#$year++ if ($month == 13);
#$month = "01" if ($month == 13);
#$monthprev = 0 if ($month == 1);
#$lettermonth =  $month_nb[$monthprev];
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

   $fyear = $year;
#   $year = $yyear;
}

}


    if ($debug == 1) {

$datesyst = &ctime(time);
($dayletterxx,$monthxx,$dayxx,$hourdatexx,$axx,$yearxx) = split(/[ \t\n\[]+/,$datesyst);
($hourxx,$minutexx,$secondxx) = split(/:/,$hourdatexx);

# calculer le temps mis pour le calcul
$endrun2 = "$hourxx:$minutexx:$secondxx";

($minxx,$secxx) = &timetaken($startrun2,$endrun2) if ($oldjour ne $firstday);
($minxx,$secxx) = &timetaken($startrun,$endrun2) if ($oldjour eq $firstday);

#$endtime = time();

#print "$oldjour :  $lineread - $sizeold - $newhost : $minxx min $secxx sec\n";
print "$oldjour : $minxx min $secxx sec\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$tmpsecxx = ($minxx*60) + $secxx;
print CPUTIME "$tmpsecxx $lineread $sizeold\n";
$starttime = time();
$startrun2 = "$hourxx:$minutexx:$secondxx";
$lineread = 0;
}



# 100% pour le repertoire /

if ($tri eq "/") {
$freqrachtml{$dirsepurl} = $access;
$freqrac{$dirsepurl} = $reqtot;   
$totsize{$dirsepurl} = $totsize;
$extsize{$dirsepurl} = $externesize;
$domsize{$dirsepurl} = $domsize;
$freqtotsize{$dirsepurl} = $totsize; 
$freqextsize{$racinebis} = $externesize;
$freqdomsize{$racinebis} = $domsize;
}

print STDERR "*" if ($intervalle > 19 && $zip != 1);
print STDOUT "\n";


$nbdays--;
if ($yesterday ne $jour) {
        $yesterday = $jour; 
}


############ Derniere journee
if ($zip == 1 || $co_last == 1) {

# jour suivant de oldjour : jour

($tmp1,$tmp2,$tmp3) = split(/\s+/,$oldjour);

$tmp1++;
if ($tmp1 > $month_of_year{$tmp2}) {
    $tmp1 = "01";
    $tmp2 = $month_equiv{$tmp2};
    $tmp2++;
    if ($tmp2 == 13) {
	$tmp3++;
	$tmp2 = $month_nb[0];
    }
    $tmp2 = $month_nb[$tmp2];
}

$jour = "$tmp1 $tmp2 $tmp3";

$totsizejour = $totsize - $totsizeold;
#$totsizeold = $totsize;

$tothtmlsizejour = $tothtmlsize - $tothtmlsizeold;
#$tothtmlsizeold = $tothtmlsize;

# Tri Pages

foreach $tmp (sort (keys(%pagesluesday))) {
    push(@counterpage,$pagesluesday{$tmp}) unless $seen{"$oldjour $tmp $pagesluesday{$tmp}"}++;
    $countpage[$pagesluesday{$tmp}]++;
    $occur_counterpage{$pagesluesday{$tmp},$countpage[$pagesluesday{$tmp}]} = $tmp;
}

@bestpagesluesday = reverse sort bynumber @counterpage;

# Tri Scripts

foreach $tmp (sort (keys(%scriptday))) {
    push(@counterscript,$scriptday{$tmp}) unless $seen{"$oldjour $tmp $scriptday{$tmp} $script"}++;
    $countscript[$scriptday{$tmp}]++;
    $occur_counterscript{$scriptday{$tmp},$countscript[$scriptday{$tmp}]} = $tmp;
}

@bestscriptday = reverse sort bynumber @counterscript;

# Tri Hosts

foreach $tmp (sort (keys(%serverjour))) {
    push(@counterserver,$serverjour{$tmp}) unless $seen{"$oldjour $tmp $serverjour{$tmp}"}++;
    $countserver[$serverjour{$tmp}]++;
    $occur_counterserver{$serverjour{$tmp},$countserver[$serverjour{$tmp}]} = $tmp;
}

@bestserverjour = reverse sort bynumber @counterserver;

# Tri des zones de filetype

for ($k=0;$k<=$#listext;$k++) {

    next if ($listext[$k] =~ /$extension/);
    $listextbis[$k] = $listext[$k];

    $tmp2 = 0;
    for ($j=1;$j<=$maxdownloadjourlength;$j++) {
	$tmp2 += $downloadjour{$listext[$k],$j};
    }
    $zoneextjour[$extfilenb{$listext[$k]}] += $tmp2;

}

##

for ($k=1;$k<=$nbzonefile;$k++) {
    $zoneextbis[$k] = $zoneextjour[$k];
}

  for ($j=1;$j<=$nbzonefile;$j++) {
      $max = $zoneextbis[$j];
      $filetypejourmax[$j] = 0;
      for ($k=1;$k<=$nbzonefile;$k++) {
	  if ($zoneextbis[$k] > $max) {
	      $max = $zoneextbis[$k];
	      $filetypejourmax[$j] = $k;
	  }
      }
      $zoneextbis[$filetypejourmax[$j]] = 0;      
  }


# Tri Countries

foreach $tmp (sort (keys(%paysjour))) {
    push(@counterpays,$paysjour{$tmp}) unless $seen{"$oldjour $tmp $paysjour{$tmp}"}++;
    $countpays[$paysjour{$tmp}]++;
    $occur_counterpays{$paysjour{$tmp},$countpays[$paysjour{$tmp}]} = $tmp;
}

@bestpaysjour = reverse sort bynumber @counterpays;

$oldjour =~ s/[\/]/ /g;

# Tri directories

$occur[0] = 0;

foreach $rootrepert (keys(%freqjourrachtml)) {
if ($freqjourrachtml{$rootrepert} > $occur[0]) {
    $occur[0] = $freqjourrachtml{$rootrepert};
    $bestselecrepert[0] = $rootrepert;
}
}

for ($i=1;$i <=$topten;$i++) {
    $occur[$i] = 0;
    foreach $rootrepert (keys(%freqjourrachtml)) {
        $out = 0;
        if ($freqjourrachtml{$rootrepert} > $occur[$i] && ($freqjourrachtml{$rootrepert} <= $occur[$i-1])) {
               for ($j=0;$j<= $i;$j++) {
                  $out = 1 if ($bestselecrepert[$j] eq $rootrepert);
                }
                if ($out == 0) {
                      $occur[$i] = $freqjourrachtml{$rootrepert};
                      $bestselecrepert[$i] = $rootrepert;
               }
	   }
    }
}

($tmp1,$tmp2,$tmp3) = split(/ /,$oldjour);
$dirresume = $tmp3."-".$tmp2."-".$tmp1;
$fileresume = $tmp3."-".$tmp2."-".$tmp1.$htmlext;

for ($nblang=0;$nblang<=$#lang;$nblang++) {

$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
mkdir ($tmp,0775) unless -d $tmp;

open(FILERESUMEFRAME,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$menu") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$menu\n";
open(FILERESUMEMENU,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$fileresumemenu") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$fileresumemenu\n";
open(FILERESUMETAB,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$filemoyenne") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$filemoyenne\n";

&PageResumeFrame(*FILERESUMEFRAME, eval($Lang{$lang[$nblang]}));
&PageResumeMenu(*FILERESUMEMENU, eval($Lang{$lang[$nblang]}));
&PageResumeTab(*FILERESUMETAB, eval($Lang{$lang[$nblang]}));

close (FILERESUMEFRAME);
close (FILERESUMEMENU);
close (FILERESUMETAB);

open(FILERESUMEPAYS,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirpays$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirpays$htmlext\n";
open(FILERESUMEDIR,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirlist$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirlist$htmlext\n";
open(FILERESUMEPAGE,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirpage$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirpage$htmlext\n";
open(FILERESUMEHOSTS,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirsite$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirsite$htmlext\n";
open(FILERESUMESCRIPT,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirscript$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirscript$htmlext\n";
open(FILERESUMEFILETYPE,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$filetype$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$filetype$htmlext\n";

&PageResumePays(*FILERESUMEPAYS, eval($Lang{$lang[$nblang]}));
&PageResumeDir(*FILERESUMEDIR, eval($Lang{$lang[$nblang]}));
&PageResumeHosts(*FILERESUMEHOSTS, eval($Lang{$lang[$nblang]}));
&PageResumePage(*FILERESUMEPAGE, eval($Lang{$lang[$nblang]}));
&PageResumeScript(*FILERESUMESCRIPT, eval($Lang{$lang[$nblang]}));
&PageResumeFiletype(*FILERESUMEFILETYPE, eval($Lang{$lang[$nblang]}));

close (FILERESUMEPAYS);
close (FILERESUMEDIR);
close (FILERESUMEHOSTS);
close (FILERESUMESCRIPT);
close (FILERESUMEPAGE);
close (FILERESUMEFILETYPE);
}
}

############

$maxdownloadjourlength = 0;

$totsizejour = $totsize - $totsizeold;
#$totsizeold = $totsize;

$tothtmlsizejour = $tothtmlsize - $tothtmlsizeold;
#$tothtmlsizeold = $tothtmlsize;

print FILEDATE "$oldjour \t $serveruniquejour \t $newhost \t $locserverjour \t $reqtotjour \t $domreq \t $accessjour \t $totsizejour \t $tothtmlsizejour\n";

#print FILESIZE "$oldjour \t $totsize $externesize $domsize \n";

print FILEREPERTSIZE "$oldjour \t";
for ($i=0;$i<=($#selecrepert);$i++) {
$rootrepert = $selecrepert[$i];
$sizejourrachtml{$rootrepert} = 0 if ($sizejourrachtml{$rootrepert} eq '');
$sizejourrachtmlext{$rootrepert} = 0 if ($sizejourrachtmlext{$rootrepert} eq '');
$sizejourrachtmldom{$rootrepert} = 0 if ($sizejourrachtmldom{$rootrepert} eq '');
$totsize{$rootrepert} = 0 if ($totsize{$rootrepert} eq '');
$extsize{$rootrepert} = 0 if ($extsize{$rootrepert} eq '');
$domsize{$rootrepert} = 0 if ($domsize{$rootrepert} eq '');
print FILEREPERTSIZE "$sizejourrachtml{$rootrepert} $sizejourrachtmlext{$rootrepert} $sizejourrachtmldom{$rootrepert} $totsize{$rootrepert} $extsize{$rootrepert} $domsize{$rootrepert} \t ";
}
print FILEREPERTSIZE "\n";

print STATREPERT "$oldjour \t ";
for ($i=0;$i<=($#selecrepert);$i++) {
$rootrepert = $selecrepert[$i];
$freqjourrac{$rootrepert} = 0 if ($freqjourrac{$rootrepert} eq '');
print STATREPERT "$freqjourrac{$rootrepert} \t ";
}
print STATREPERT "\n";


close FILEDATE;
close FILEREPERTSIZE;
#close FILESIZE;
close STATREPERT;

sub nextlog {

$yyear = $year;
$year = $fyear if ($opt_d eq '');
$day++ if ($zipcut == 2);
$day = "0".$day unless (length($day) == 2);

$month++ if ($zipcut == 1);
$monthprev = $month-1 if ($zipcut == 1);

if ($day > $month_of_year{$month_nb[$monthprev]} && $zipcut == 2) {
$month++;
$monthprev++;
$day = "01";
}

$month = "0".$month unless (length($month) == 2);

$year++ if ($month == 13);
$month = "01" if ($month == 13);
$monthprev = 0 if ($month == 1);
$lettermonth =  $month_nb[$monthprev];
$file = $fileroot;
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
$compressed_logfile_fields[$i] =~ s/\%/\$/;
$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}


$filezip = $file.$zipext if ($zip == 1);
}

#############################################################################
# check if something strange

if ($totsize == 0) {
print STDERR "\n\nWARNING : It seems you have excluded all your documents.\n";
print STDERR "Your logfile must be at least two days long.\n";
print STDERR "Please check in config.pl your \$tri or/and your \@excluderepert variables (same value ?).\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");
exit;
}

if ($access == 0) {
print STDERR "\n\nWARNING : It seems you have excluded all your HTML documents.\n";
print STDERR "So you should check your \@extension variable in config.pl.\n";
print STDERR "\@extension contains : \n";
for ($i=0;$i<=($#extension);$i++) {
    print STDERR "$extension[$i] ";
}
print STDERR "\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");
exit;
}

if ($paysunique == 0) {
print STDERR "\n\nWARNING : Your logfile contains only IP address.\n";
print STDERR "So no countries stats could be done.\n";
print STDERR "You could select the reverse DNS option in your\n";
print STDERR "configuration file to activate countries stats\n";
print STDERR "Warning : reverse DNS may take longer to compute !\n\n"; 
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");
if ($domsize == 0) {
print STDERR "To be able to compute domain stats, you should :\n";
print "<UL><LI>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print STDERR "   - specify \$localserver with your IP address\n";
print "<LI>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print STDERR "   - or add your IP domain in \$localdomaine (best)\n";
print "<BR>>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print STDERR "     ( ex : \$localdomainename|^209\.42\.196\.) for Class C domain\n\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

}

#############################################################################

&save_reverse_dns if ($reverse_dns == 1); # sauvegarde de la table de DNS

#############################################################################
# sauvegarde des donnees incrementales

open(GENERAL,">$path$dirinc$dirsep$incgeneral") || die "Error, unable to open $path$dirinc$dirsep$incgeneral\n";
print GENERAL "$firstday ";
print GENERAL "$reqtot ";
print GENERAL "$reqdomtot ";
print GENERAL "$totsize ";
print GENERAL "$externesize ";
print GENERAL "$domsize ";
print GENERAL "$nbdays ";
print GENERAL "$access ";
print GENERAL "$accessdom ";
print GENERAL "$tothtmlsize ";
print GENERAL "$loglines ";
print GENERAL "$proxy ";
print GENERAL "$redirect ";
print GENERAL "$forbiden ";
print GENERAL "$notfound ";
print GENERAL "$exclpages ";
print GENERAL "$excladdr ";
print GENERAL "$exclframed ";
print GENERAL "$exclrobots ";
close GENERAL;

if ($inc_script == 1) {
open(SCRIPT,">$path$dirinc$dirsep$incscript") || die "Error, unable to open $path$dirinc$dirsep$incscript\n";
foreach $val (keys(%method)) {
    print SCRIPT "$val,$method{$val} ";
}
print SCRIPT "\n";
foreach $val (keys(%script)) {
print SCRIPT "$val^$script{$val}";
for ($j=1;$j<=$argunique{$val};$j++) {
        $tmp = $scriptdata{$val,$j};
	print SCRIPT "^" if ($j == 1);
        print SCRIPT "[$tmp";
        for ($k=1;$k<=$nameunique{$val,$tmp};$k++) {
                print SCRIPT "\t\"$countargval{$val,$tmp,$k}\",$countarg{$val,$tmp,$countargval{$val,$tmp,$k}}";
                }
        print SCRIPT "]";
        print SCRIPT "^" if ($j != $argunique{$val});
        }

print SCRIPT "\n";
}
close SCRIPT;
}

if ($precision > 2) {
open(DOWNLOAD,">$path$dirinc$dirsep$dirdownload") || die "Error, unable to open $path$dirinc$dirsep$dirdownload\n";
for ($i=0;$i<=$#listext;$i++) {
print DOWNLOAD "$listext[$i] $downloadsizeext{$listext[$i]} ";
for ($j=1;$j<=$maxdownloadlength;$j++) {
$downloadsize{$listext[$i],$j} = 0 if ($downloadsize{$listext[$i],$j} eq '');
$download{$listext[$i],$j} = 0 if ($download{$listext[$i],$j} eq '');
print DOWNLOAD "$downloadsize{$listext[$i],$j} $download{$listext[$i],$j} ";
}
print DOWNLOAD "\n";
}
close DOWNLOAD;
}


if ($precision > 2) {
open(FILETYPE,">$path$dirinc$dirsep$filetype") || die "Error, unable to open $path$dirinc$dirsep$filetype\n";
foreach $page (keys(%filetype)) {
print FILETYPE "$page $filetype{$page}\n";
}
close FILETYPE;
}


open(PAGESLUES,">$path$dirinc$dirsep$incpage") || die "Error, unable to open $path$dirinc$dirsep$incpage\n";
foreach $page (keys(%pageslues)) {
print PAGESLUES "$page $pageslues{$page} 0 0 0 0 0 0 0\n";
}
close PAGESLUES;

open(PAYS,">$path$dirinc$dirsep$incpays") || die "Error, unable to open $path$dirinc$dirsep$incpays\n";
foreach $pays (keys(%payslist)) {
$payshtml{$pays} = 0 if ($payshtml{$pays} eq '');
print PAYS "$pays $serverpays{$pays} $payslist{$pays} $payshtml{$pays} $sizepays{$pays}\n";
}
close PAYS;

open(DOMAIN,">$path$dirinc$dirsep$dirdomain") || die "Error, unable to open $path$dirinc$dirsep$dirdomain\n";
foreach $domadresse (keys(%domaindate)) {
    print DOMAIN "$domadresse $domaindate{$domadresse}\n";
}
close (DOMAIN);

open(SERVEXTERNE,">$path$dirinc$dirsep$incservexterne") || die "Error, unable to open $path$dirinc$dirsep$incservexterne\n";
foreach $adresse (keys(%server)) {
print SERVEXTERNE "$adresse $server{$adresse} $nbpageserveur{$adresse}\n";

#if ($adresse =~ /^[0-9.]+$/) {
#        $tmp = $domaindate{$adresse};
#	print DOMAIN "$adresse $tmp\n";
#} else {
#        $domadresse = substr($adresse,(rindex(substr($adresse,0,rindex($adresse,'.')),'.')+1),length($adresse));
#        $tmp = $domaindate{$domadresse};
#	print DOMAIN "$domadresse $tmp\n";
#}

}
close SERVEXTERNE;

open(SERVINTERNE,">$path$dirinc$dirsep$incservinterne") || die "Error, unable to open $path$dirinc$dirsep$incservinterne\n";
foreach $adresse (keys(%localserver)) {
print SERVINTERNE "$adresse $localserver{$adresse} $nbpageserveur{$adresse}\n";
#if ($adresse =~ /^[0-9.]+$/) {
#        $tmp = $domaindate{$adresse};
#	print DOMAIN "$adresse $tmp\n";	
#} else {
#        $domadresse = substr($adresse,(rindex(substr($adresse,0,rindex($adresse,'.')),'.')+1),length($adresse));
#        $tmp = $domaindate{$domadresse};
#	print DOMAIN "$domadresse $tmp\n";
#}

}
close SERVINTERNE;
#close DOMAIN;

open(SERVPAGESELECT,">$path$dirinc$dirsep$incpageselect") || die "Error, unable to open $path$dirinc$dirsep$incpageselect\n";
for ($i=0;$i<=$#selecpages;$i++) {
print SERVPAGESELECT "$selecpages[$i] $selecadresse[$i] $selecdate[$i]\n";
}
close SERVPAGESELECT;


open(REPERT,">$path$dirinc$dirsep$increpert") || die "Error, unable to open $path$dirinc$dirsep$increpert\n";
foreach $racine (keys(%freqrac)) {
$freqrac{$racine} = 0 if ($freqrac{$racine} eq '');
$freqrachtml{$racine} = 0 if ($freqrachtml{$racine} eq '');
$freqrachtmldom{$racine} = 0 if ($freqrachtmldom{$racine} eq '');
$freqtotsize{$racine} =  0 if ($freqtotsize{$racine} eq '');
$freqextsize{$racine} = 0 if ($freqextsize{$racine} eq '');
$freqdomsize{$racine} = 0 if ($freqdomsize{$racine} eq '');
$freq2rac{$racine} = 0 if ($freq2rac{$racine} eq '');
$freq2rachtml{$racine} = 0 if ($freq2rachtml{$racine} eq '');
$freq2totsize{$racine} = 0 if ($freq2totsize{$racine} eq '');
   print REPERT "$racine $freqrac{$racine} $freqrachtml{$racine} $freqrachtmldom{$racine} $freqtotsize{$racine} $freqextsize{$racine} $freqdomsize{$racine} $freq2rac{$racine} $freq2rachtml{$racine} $freq2totsize{$racine}\n";
}
close REPERT;

#if ($struct_logfile =~ /\%virtualhost/) {
if ($virtualunique != 0) {
open(VIRTUAL,">$path$dirinc$dirsep$incvirtual") || die "Error, unable to open $path$dirinc$dirsep$incvirtual\n";
foreach $vserver (keys(%virtual)) {
print VIRTUAL "$vserver\t$virtual{$vserver}\t$virtualsize{$vserver}\n";
}
close (VIRTUAL);
}


if ($precision > 3) {
open(PAGES,">$path$dirinc$dirsep$inchosts") || die "Error, unable to open $path$dirinc$dirsep$inchosts\n";
        foreach $adresse (keys(%server)) {
        print PAGES "$adresse";
        for ($i=0;$i<=$nbpageserveur{$adresse};$i++) {
                print PAGES " $pagesite{$adresse,$i}";
                }
        print PAGES "\n";
        }
        
        foreach $adresse (keys(%localserver)) {
        print PAGES "$adresse";
        for ($i=0;$i<$nbpageserveur{$adresse};$i++) {
                print PAGES " $pagesite{$adresse,$i}";
                }
        print PAGES "\n";               
        }
close(PAGES);
}

#######################################################################################

print STDOUT "Sorting data\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# tri des sites pour chaque virtual server

$occur[0] = 0;

foreach $vserver (keys(%virtual)) {
if ($virtual{$vserver} > $occur[0]) {
    $occur[0] = $virtual{$vserver};
    $bestvirtual[0] = $vserver;
}
}

for ($i=1;$i < $virtualunique;$i++) {
    $occur[$i] = 0;
    foreach $vserver (keys(%virtual)) {
        $out = 0;
        if ($virtual{$vserver} > $occur[$i] && ($virtual{$vserver} <= $occur[$i-1])) {
               for ($j=0;$j<= $i;$j++) {
                  $out = 1 if ($bestvirtual[$j] eq $vserver);
                }
                if ($out == 0) {
                      $occur[$i] = $virtual{$vserver};
                      $bestvirtual[$i] = $vserver;
               }
       }
     }
}


# tri des sites par pays

$occur[0] = 0;

foreach $pays (keys(%serverpays)) {
if ($serverpays{$pays} > $occur[0]) {
    $occur[0] = $serverpays{$pays};
    $bestsitepays[0] = $pays;
}
}

for ($i=1;$i <= $paysunique;$i++) {
    $occur[$i] = 0;
    foreach $pays (keys(%serverpays)) {
        $out = 0;
        if ($serverpays{$pays} > $occur[$i] && ($serverpays{$pays} <= $occur[$i-1])) {
               for ($j=0;$j< $i;$j++) {
                  $out = 1 if ($bestsitepays[$j] eq $pays);
                }
                if ($out == 0) {
                      $occur[$i] = $serverpays{$pays};
                      $bestsitepays[$i] = $pays;
               }
       }
     }
}

# tri des $topten meilleures pages lues

$bouclepages = $topten unless ($pageunique < $topten);
$bouclepages = $pageunique unless ($pageunique > ($topten-1));

$occur[0] = 0;

foreach $page (keys(%pageslues)) {
if ($pageslues{$page} > $occur[0]) {
    $occur[0] = $pageslues{$page};
    $bestpage[0] = $page;
}
}

for ($i=1;$i < $bouclepages;$i++) {
    $occur[$i] = 0;
    foreach $page (keys(%pageslues)) {
        $out = 0;
        if ($pageslues{$page} > $occur[$i] && ($pageslues{$page} <= $occur[$i-1])) {
               for ($j=0;$j< $i;$j++) {
                  $out = 1 if ($bestpage[$j] eq $page);
                }
                if ($out == 0) {
                      $occur[$i] = $pageslues{$page};
                      $bestpage[$i] = $page;
                }
        }
     }
}

# tri des $topten meilleurs pays

if ($precision > 2) {
$bouclepays = $topten unless ($paysunique < $topten);
$bouclepays = $paysunique unless ($paysunique > ($topten-1));

$occurpays[0] = 0;

foreach $pays (keys(%payslist)) {
if ($payslist{$pays} > $occurpays[0]) {
    $occurpays[0] = $payslist{$pays};
    $bestpays[0] = $pays;
}
}

for ($i=1;$i < $bouclepays;$i++) {
    $occurpays[$i] = 0;
    foreach $pays (keys(%payslist)) {
        $out = 0;
        if ($payslist{$pays} > $occurpays[$i] && ($payslist{$pays} <= $occurpays[$i-1])) {
               for ($j=0;$j< $i;$j++) {
                  $out = 1 if ($bestpays[$j] eq $pays);
                }
                if ($out == 0) {
                      $occurpays[$i] = $payslist{$pays};
                      $bestpays[$i] = $pays;
                }
        }
     }
}

}

# tri des $topten meilleurs serveurs externes

$boucleservers = $topten unless ($serverunique < $topten);
$boucleservers = $serverunique unless ($serverunique > ($topten-1));

$occurserver[0] = 0;

foreach $adresse (keys(%server)) {
if ($server{$adresse} > $occurserver[0]) {
    $occurserver[0] = $server{$adresse};
    $bestserver[0] = $adresse;
}
}

for ($i=1;$i < $boucleservers;$i++) {
    $occurserver[$i] = 0;
    foreach $adresse (keys(%server)) {
        $out = 0;
        if ($server{$adresse} > $occurserver[$i] && ($server{$adresse} <= $occurserver[$i-1])) {
               for ($j=0;$j< $i;$j++) {
                  $out = 1 if ($bestserver[$j] eq $adresse);
                }
                if ($out == 0) {
                      $occurserver[$i] = $server{$adresse};
                      $bestserver[$i] = $adresse;
                }
        }
     }
}

# tri des $topten meilleurs serveurs locaux

if ($locallog != 0) {
$bouclelocservers = $topten unless ($locserver < $topten);
$bouclelocservers = $locserver unless ($locserver > ($topten-1));

$occurlocserver[0] = 0;

foreach $adresse (keys(%localserver)) {
if ($localserver{$adresse} > $occurlocserver[0]) {
    $occurlocserver[0] = $localserver{$adresse};
    $bestlocserver[0] = $adresse;
}
}

for ($i=1;$i < $bouclelocservers;$i++) {
    $occurlocserver[$i] = 0;
    foreach $adresse (keys(%localserver)) {
        $out = 0;
        if ($localserver{$adresse} > $occurlocserver[$i] && ($localserver{$adresse} <= $occurlocserver[$i-1])) {
               for ($j=0;$j< $i;$j++) {
                  $out = 1 if ($bestlocserver[$j] eq $adresse);
                }
                if ($out == 0) {
                      $occurlocserver[$i] = $localserver{$adresse};
                      $bestlocserver[$i] = $adresse;
                }
        }
     }
}

}

# tri des $topten meilleurs scripts

$bouclescript = $topten unless ($scriptunique < $topten);
$bouclescript = $scriptunique unless ($scriptunique > ($topten-1));

$occurscript[0] = 0;

foreach $val (keys(%script)) {
if ($script{$val} > $occurscript[0]) {
    $occurscript[0] = $script{$val};
    $bestscript[0] = $val;
}
}

for ($i=1;$i < $bouclescript;$i++) {
    $occurscript[$i] = 0;
    foreach $val (keys(%script)) {
        $out = 0;
        if ($script{$val} > $occurscript[$i] && ($script{$val} <= $occurscript[$i-1])) {
               for ($j=0;$j< $i;$j++) {
                  $out = 1 if ($bestscript[$j] eq $val);
                }
                if ($out == 0) {
                      $occurscript[$i] = $script{$val};
                      $bestscript[$i] = $val;
                }
        }
     }
}

# conversion en Megaoctets

$totsize /= (1024*1024);
$externesize /= (1024*1024);
$domsize /= (1024*1024);

#########################################################################
####                                                                #####
####              FABRICATION DES PAGES HTML                        #####
####                                                                #####
#########################################################################

### Frames TOP

for ($nblang=0;$nblang<=$#lang;$nblang++) {
        $top = $path.$lang[$nblang].$dirsep.$dirframe.$dirsep.$topframe;
        open(TOP,">$top") || die "Error, unable to open $topframe\n";
        &CreateTopFrame(*TOP, eval($Lang{$lang[$nblang]}), $homepagesframed[$nblang], $lang[$nblang]);
        close (TOP);
}

sub CreateTopFrame {
  local(*FOUT,*L, $H, $I) = @_;

  print FOUT "<HTML><HEAD>\n";
  print FOUT "<TITLE>W3Perl Frames Top : $L{'Language'}</TITLE>\n";
  print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
  print FOUT "<META NAME=\"ROBOTS\" CONTENT=\"NOFOLLOW\">";
  print FOUT "<META NAME=\"ROBOTS\" CONTENT=\"NOINDEX\">";
  print FOUT "</HEAD>\n";

  print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
  print FOUT "<CENTER>\n";
#print FOUT "[<A HREF=\"javascript:history.back()\" TARGET=\"_top\">$L{'Back'}</A> | <A HREF=\"http://$localserver$tri\" TARGET=\"_top\">Homepage</A>] | ";
  
  if ($frame_updown == 1) {
      print FOUT "[";
      print FOUT "$topframelinks";
      print FOUT "] | ";
      print FOUT "[" if ($#lang != 0);
  } else {
      print FOUT "$topframelinks<P><HR><P>";
  }

for ($i=0;$i<=$#lang;$i++) {
print FOUT "<A HREF=\"..$dirsepurl..$dirsepurl$homepages[$i]\" TARGET=\"_top\"><IMG BORDER=0 WIDTH=30 HEIGHT=15 SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$flag[$i]\" ALT=\"$flag[$i]\"></A>\n" unless ($I eq $lang[$i]);
print FOUT "| " if (($i != ($#lang) && ($I ne $lang[$i])) && !($lang[$#lang] eq $I && $i == (($#lang)-1)) && ($frame_updown == 1) ); 
print FOUT "<BR>" if ($i != ($#lang) && ($I ne $lang[$i]) && !($lang[$#lang] eq $I && $i == (($#lang)-1)) && ($frame_updown != 1));
}

if ($frame_updown == 1) {
print FOUT "] | " if ($#lang != 0);
print FOUT "[$packagename : ";
print FOUT "<A HREF=\"$H\" TARGET=\"display\">$L{'Index'}</A> - ";
print FOUT "<A HREF=\"http://www.w3perl.com/demo/docs/html/new.html?$version\" TARGET=\"display\">$L{'News'}</A> - ";
print FOUT "<A HREF=\"..$dirsepurl..$dirsepurl$linkpathinit$dirdocs$dirsepurl$help\" TARGET=\"display\">$L{'Docs'}</A>]\n";
} else {
print FOUT "<P><HR><P>\n" if ($#lang != 0);
print FOUT "[$packagename]<P>";
print FOUT "<A HREF=\"$H\" TARGET=\"display\"><IMG WIDTH=41 HEIGHT=28 SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$drawstatsmall\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"$H\" TARGET=\"display\">$L{'Index'}</A><BR>";
print FOUT "<A HREF=\"http://www.w3perl.com/demo/docs/html/new.html?$version\" TARGET=\"display\"><IMG WIDTH=42 HEIGHT=20 SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$icon_new_w3perl\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"http://www.w3perl.com/demo/docs/html/new.html?$version\" TARGET=\"display\">$L{'News'}</A><BR>";
print FOUT "<A HREF=\"..$dirsepurl..$dirsepurl$linkpathinit$dirdocs$dirsepurl$help\" TARGET=\"display\"><IMG WIDTH=41 HEIGHT=41 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_info\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl..$dirsepurl$linkpathinit$dirdocs$dirsepurl$help\" TARGET=\"display\">$L{'Docs'}</A>\n";
}

print FOUT "</CENTER>";
print FOUT "</BODY></HTML>";
}



### Frames Bottom

for ($nblang=0;$nblang<=$#lang;$nblang++) {
        $bottom = $path.$lang[$nblang].$dirsep.$dirframe.$dirsep.$bottomframe;
        open(BOTTOM,">$bottom") || die "Error, unable to open $bottom\n";
        &CreateBottomFrame(*BOTTOM, eval($Lang{$lang[$nblang]}), $homepages[$nblang], $lang[$nblang]);
        close (BOTTOM);
}

sub CreateBottomFrame {
  local(*FOUT,*L, $H, $I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>W3Perl Frames Bottom: $L{'Language'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "<META NAME=\"ROBOTS\" CONTENT=\"NOFOLLOW\">";
print FOUT "<META NAME=\"ROBOTS\" CONTENT=\"NOINDEX\">";
print FOUT "</HEAD>\n";

print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<CENTER>\n";

if ($frame_updown == 1) {
print FOUT "[<A HREF=\"..$dirsepurl$dirsite$dirsepurl$filesites\" TARGET=\"display\">$L{'Hosts'}</A> | ";
print FOUT "<A HREF=\"..$dirsepurl$dirpage$dirsepurl$filepages\" TARGET=\"display\">$L{'Pages'}</A>";
print FOUT " | <A HREF=\"..$dirsepurl$dirscript$dirsepurl$filescript\" TARGET=\"display\">$L{'Scripts'}</A>" if ($inc_script == 1);

if ($precision > 2) {
print FOUT " | <A HREF=\"..$dirsepurl$dirlist$dirsepurl$filetype$htmlext\" TARGET=\"display\">$L{'Filetype'}</A> | ";
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filerepert\" TARGET=\"display\">$L{'Directories'}</A> | ";
print FOUT "<A HREF=\"..$dirsepurl$dirpays$dirsepurl$filepays\" TARGET=\"display\">$L{'Countries'}</A> | ";
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$dirdownload$htmlext\" TARGET=\"display\">$L{'Download'}</A>";
}

print FOUT "] | [<A HREF=\"..$dirsepurl$dirdate$dirsepurl$filehour\" TARGET=\"display\">$L{'Hours'}</A> | ";
print FOUT "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileday\" TARGET=\"display\">$L{'Days'}</A>";
print FOUT " | <A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileweek\" TARGET=\"display\">$L{'Weeks'}</A> " unless ($nbdays < 14);
print FOUT " | <A HREF=\"..$dirsepurl$dirdate$dirsepurl$filemonth\" TARGET=\"display\">$L{'Months'}</A> " unless ($nbdays < 30);
print FOUT "]\n";

if ((-e "$path$I$dirsep$dirdocument$dirsep$menu") || (-e "$path$I$dirsep$dirsession$dirsep$filesession") || (-e "$path$I$dirsep$dirlist$dirsep$filevirtual") || (-e "$path$I$dirsep$dirlist$dirsep$error") || (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")) {
print FOUT "<BR>\n";
print FOUT "[";
print FOUT "<A HREF=\"..$dirsepurl$dirdocument$dirsepurl$menu\" TARGET=\"display\">$L{'Documents'}</A>" if (-e "$path$I$dirsep$dirdocument$dirsep$menu");
print FOUT " | " if ((-e "$path$I$dirsep$dirdocument$dirsep$menu") && ((-e "$path$I$dirsep$dirsession$dirsep$filesession") || (-e "$path$I$dirsep$dirlist$dirsep$filevirtual") || (-e "$path$I$dirsep$dirlist$dirsep$error") || (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")));
print FOUT "<A HREF=\"..$dirsepurl$dirsession$dirsepurl$filesession\" TARGET=\"display\">$L{'Sessions'}</A>"  if (-e "$path$I$dirsep$dirsession$dirsep$filesession");
print FOUT " | " if ((-e "$path$I$dirsep$dirsession$dirsep$filesession") && ((-e "$path$I$dirsep$dirlist$dirsep$filevirtual") || (-e "$path$I$dirsep$dirlist$dirsep$error") || (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")));
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filevirtual\" TARGET=\"display\">$L{'Virtual_servers'}</A>"  if (-e "$path$I$dirsep$dirlist$dirsep$filevirtual");

print FOUT " | " if ((-e "$path$I$dirsep$dirlist$dirsep$filevirtual") && ((-e "$path$I$dirsep$dirlist$dirsep$error") || (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")));
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$error\" TARGET=\"display\">$L{'Errors'}</A>"  if (-e "$path$I$dirsep$dirlist$dirsep$error");
print FOUT " | " if ((-e "$path$I$dirsep$dirlist$dirsep$error") && ((-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")));
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$agent\" TARGET=\"display\">$L{'Browsers'}</A>"  if (-e "$path$I$dirsep$dirlist$dirsep$agent");
print FOUT " | " if ((-e "$path$I$dirsep$dirlist$dirsep$agent") && (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer"));
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$tabnamerefer\" TARGET=\"display\">$L{'Referer'}</A>"  if (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer");
print FOUT "]";
}
} else {

print FOUT "<A HREF=\"..$dirsepurl$dirsite$dirsepurl$filesites\" TARGET=\"display\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_hosts\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirsite$dirsepurl$filesites\" TARGET=\"display\">$L{'Hosts'}</A><BR>";
print FOUT "<A HREF=\"..$dirsepurl$dirpage$dirsepurl$filepages\" TARGET=\"display\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_pages\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirpage$dirsepurl$filepages\" TARGET=\"display\">$L{'Pages'}</A><BR>";
if ($inc_script == 1) {
    print FOUT "<A HREF=\"..$dirsepurl$dirscript$dirsepurl$filescript\" TARGET=\"display\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_script\" BORDER=0></A><BR>\n";
    print FOUT "<A HREF=\"..$dirsepurl$dirscript$dirsepurl$filescript\" TARGET=\"display\">$L{'Scripts'}</A><BR>";
}

if ($precision > 2) {
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filetype$htmlext\" TARGET=\"display\"><IMG WIDTH=36 HEIGHT=28 SRC=\"$homeicons$dirsepurl$icon_filetype\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filetype$htmlext\" TARGET=\"display\">$L{'Filetype'}</A><BR>";
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filerepert\" TARGET=\"display\"><IMG WIDTH=34 HEIGHT=29 SRC=\"$homeicons$dirsepurl$icon_dir\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filerepert\" TARGET=\"display\">$L{'Directories'}</A><BR>";
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$dirdownload$htmlext\" TARGET=\"display\"><IMG WIDTH=35 HEIGHT=30 SRC=\"$homeicons$dirsepurl$icon_pie\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$dirdownload$htmlext\" TARGET=\"display\">$L{'Download'}</A><BR>";
print FOUT "<A HREF=\"..$dirsepurl$dirpays$dirsepurl$filepays\" TARGET=\"display\"><IMG WIDTH=33 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_countries\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirpays$dirsepurl$filepays\" TARGET=\"display\">$L{'Countries'}</A>";
}

print FOUT "<P><HR><P>";
print FOUT "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$filehour\" TARGET=\"display\"><IMG WIDTH=26 HEIGHT=29 SRC=\"$homeicons$dirsepurl$icon_hours\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$filehour\" TARGET=\"display\">$L{'Hours'}</A><BR>";
print FOUT "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileday\" TARGET=\"display\"><IMG WIDTH=75 HEIGHT=42 SRC=\"$homeicons$dirsepurl$icon_days\" BORDER=0></A><BR>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileday\" TARGET=\"display\">$L{'Days'}</A>";
print FOUT "<BR><A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileweek\" TARGET=\"display\"><IMG WIDTH=80 HEIGHT=50 SRC=\"$homeicons$dirsepurl$icon_weeks\" BORDER=0></A>" unless ($nbdays < 14);
print FOUT "<BR><A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileweek\" TARGET=\"display\">$L{'Weeks'}</A>" unless ($nbdays < 14);
print FOUT "<BR><A HREF=\"..$dirsepurl$dirdate$dirsepurl$filemonth\" TARGET=\"display\"><IMG WIDTH=33 HEIGHT=33 SRC=\"$homeicons$dirsepurl$icon_months\" BORDER=0></A>" unless ($nbdays < 30);
print FOUT "<BR><A HREF=\"..$dirsepurl$dirdate$dirsepurl$filemonth\" TARGET=\"display\">$L{'Months'}</A>" unless ($nbdays < 30);
print FOUT "<P><HR><P>\n";

if ((-e "$path$I$dirsep$dirlist$dirsep$error") || (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")) {
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$error\" TARGET=\"display\"><IMG WIDTH=42 HEIGHT=40 SRC=\"$homeicons$dirsepurl$icon_error\" BORDER=0></A><BR>\n" if (-e "$path$I$dirsep$dirlist$dirsep$error");
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$error\" TARGET=\"display\">$L{'Errors'}</A>" if (-e "$path$I$dirsep$dirlist$dirsep$error");
print FOUT "<BR>" if ((-e "$path$I$dirsep$dirlist$dirsep$error") && ((-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")));
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$agent\" TARGET=\"display\"><IMG WIDTH=37 HEIGHT=39 SRC=\"$homeicons$dirsepurl$icon_agent\" BORDER=0></A><BR>\n" if (-e "$path$I$dirsep$dirlist$dirsep$agent");
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$agent\" TARGET=\"display\">$L{'Browsers'}</A>" if (-e "$path$I$dirsep$dirlist$dirsep$agent");
print FOUT "<BR>" if ((-e "$path$I$dirsep$dirlist$dirsep$agent") && (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer"));
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$tabnamerefer\" TARGET=\"display\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_refer\" BORDER=0></A><BR>\n" if (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer");
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$tabnamerefer\" TARGET=\"display\">$L{'Referer'}</A>" if (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer");
print FOUT "<P><HR><P>\n";
}

if ((-e "$path$I$dirsep$dirdocument$dirsep$menu") || (-e "$path$I$dirsep$dirsession$dirsep$filesession")) {
print FOUT "<A HREF=\"..$dirsepurl$dirdocument$dirsepurl$menu\" TARGET=\"display\"><IMG WIDTH=53 HEIGHT=33 SRC=\"$homeicons$dirsepurl$icon_doc\" BORDER=0></A><BR>\n" if (-e "$path$I$dirsep$dirdocument$dirsep$menu");
print FOUT "<A HREF=\"..$dirsepurl$dirdocument$dirsepurl$menu\" TARGET=\"display\">$L{'Documents'}</A>" if (-e "$path$I$dirsep$dirdocument$dirsep$menu");
print FOUT "<BR>" if ((-e "$path$I$dirsep$dirdocument$dirsep$menu") && ((-e "$path$I$dirsep$dirsession$dirsep$filesession") || (-e "$path$I$dirsep$dirlist$dirsep$error") || (-e "$path$I$dirsep$dirlist$dirsep$tabnamerefer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")));
print FOUT "<A HREF=\"..$dirsepurl$dirsession$dirsepurl$filesession\" TARGET=\"display\"><IMG WIDTH=38 HEIGHT=39 SRC=\"$homeicons$dirsepurl$icon_session\" BORDER=0></A><BR>\n" if (-e "$path$I$dirsep$dirsession$dirsep$filesession");
print FOUT "<A HREF=\"..$dirsepurl$dirsession$dirsepurl$filesession\" TARGET=\"display\">$L{'Sessions'}</A>" if (-e "$path$I$dirsep$dirsession$dirsep$filesession");
print FOUT "<BR>";
}

}
print FOUT "</CENTER>";

print FOUT "</BODY></HTML>";
}


#############################################

print STDOUT "Creating homepage\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

if ($precision == 1) {

for ($nblang=0;$nblang<=$#lang;$nblang++) {
        open(LITTLEINDEX,">$path$homepages[$nblang]") || die "Error,  unable to open $path$homepages[$nblang]\n";
        &CreateLittleIndex(*LITTLEINDEX, eval($Lang{$lang[$nblang]}), $homepages[$nblang], $lang[$nblang], $homepagesframed[$nblang]);
        close (LITTLEINDEX);
}

exit;
}

sub CreateLittleIndex {
  local(*FOUT,*L, $H, $I, $J) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_host'} $localserver </TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "<META NAME=\"ROBOTS\" CONTENT=\"NOFOLLOW\">";
print FOUT "</HEAD>\n";

print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> <IMG WIDTH=49 HEIGHT=49 SRC=\"$linkpathinit$dirress$dirsepurl$drawstat\"> $L{'Stats'} $firstday - $yesterday</H1><P>\n";

print FOUT "<HR>";
for ($i=0;$i<=$#lang;$i++) {
print FOUT "<A HREF=\"$homepages[$i]\"><IMG border=0 WIDTH=30 HEIGHT=15 SRC=\"$linkpathinit$dirress$dirsepurl$flag[$i]\" ALT=\"$flag[$i]\"> $lang[$i]</A>  \n" unless ($I eq $lang[$i]);
}

print FOUT "<HR><P>\n" if ($#lang > 0);

print FOUT "<CENTER>\n";
print FOUT "[<A HREF=\"http://$localserver$tri\">Homepage</A>] | [";
print FOUT "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$menu\">$L{'Documents'}</A> | "  if (-e "$path$I$dirsep$dirlist$dirsep$menu");
print FOUT "<A HREF=\"$I$dirsepurl$dirsession$dirsepurl$filesession\">$L{'Sessions'}</A> | "  if (-e "$path$I$dirsep$dirsession$dirsep$filesession");
print FOUT "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$error\">$L{'Errors'}</A> | "  if (-e "$path$I$dirsep$dirlist$dirsep$error");
print FOUT "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$refer\">$L{'Referer'}</A> | "  if (-e "$path$I$dirsep$dirlist$dirsep$refer");
print FOUT "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$agent\">$L{'Browsers'}</A> | "  if (-e "$path$I$dirsep$dirlist$dirsep$agent");
print FOUT "<A HREF=\"http://www.w3perl.com/demo/docs/html/new.html?$version\">$L{'News'}</A> | ";
print FOUT "<A HREF=\"$linkpathinit$dirdocs$dirsepurl$help\">$L{'Docs'}</A>\n";
print FOUT "]</CENTER>";

print FOUT "<HR><P>\n";

print FOUT "$L{'Total_number_of_requests'} ($L{'all_sites'}) : $reqtot\n<BR>";
print FOUT "$L{'Total_number_of_requests'} $L{'from_dom'} <I>$localdomainename</I> : $reqdomtot\n<BR>" if ($locallog != 0);
print FOUT "<P>";
print FOUT "$L{'Number_of_different_sites'} : $serverunique\n<BR>";
print FOUT "$L{'Number_of_pages_read'} : $access\n<br>";
print FOUT "$L{'Number_of_different_pages_used'} : $pageunique\n\n<BR>";
print FOUT "$L{'Total_data_sent'} : ";
printf FOUT "%.2f",$totsize;
print FOUT " $L{'Mb'}\n";
if ($locallog != 0) {
print FOUT "($L{'among'} ";
printf FOUT "%.2f",$externesize;
print FOUT " $L{'from_outside'})";
}
print FOUT "\n<BR>";

print FOUT "<P><HR><P>";

print FOUT "<I>$L{'The_Top'} $topten $L{'top_external_sites'} ($L{'among'} $serverunique)</I> :<P><UL>\n";
for ($i=0;$i < $boucleservers;$i++) {
print FOUT "$bestserver[$i] : <b>$occurserver[$i]</b> $L{'times'}<br>";
}

print FOUT "</UL>";

if ($locallog != 0) {
print FOUT "<I>$L{'The_Top'} $topten $L{'top_local_sites'} ($L{'among'} $locserver)</I> :<P><UL>\n";
for ($i=0;$i < $bouclelocservers;$i++) {
print FOUT "$bestlocserver[$i] : <b>$occurlocserver[$i]</b><br>";
}
}

print FOUT "</UL><I>$L{'The_Top'} $topten $L{'pages'} ($L{'among'} $pageunique) $L{'MostSuccesf'}</I> :<P><UL>\n";
for ($i=0;$i < $bouclepages;$i++) {
print FOUT "<A HREF=\"$linkpage$bestpage[$i]\">";
print FOUT "$bestpage[$i]" if ($titlename == 0);
print FOUT "<b>$urlconv{$bestpage[$i]}</b>" if ($titlename == 1 && $urlconv{$bestpage[$i]} ne '');
print FOUT "$bestpage[$i]" if ($titlename == 1 && $urlconv{$bestpage[$i]} eq '');
print FOUT "</A> : <B>$occur[$i]</B> $L{'times'}<BR>\n";
}
print FOUT "</UL>";

print FOUT "<BR>\n";

print FOUT "<TABLE BORDER=0 WIDTH=100\%><TR>\n";
print FOUT "<TD ALIGN=LEFT><I><FONT SIZE=2>&#169; Copyright 1995/2000 <A HREF=\"mailto:domisse\@w3perl.com\">Laurent DOMISSE</A></FONT></I></TD>\n";
print FOUT "<TD ALIGN=RIGHT><I><FONT SIZE=2>$L{'Stats'} $L{'computed_with'} <A HREF=\"$linkpathinit$dirdocs$dirsepurl$help\">W3Perl $version</A> </FONT></I>\n";
print FOUT "</TR></TABLE>\n";
print FOUT "</BODY>\n";
print FOUT "</HTML>\n";
}


##############################
##### Pages des index... #####
##############################

### Version Frames

for ($nblang=0;$nblang<=$#lang;$nblang++) {
        $mainindex = $path.$homepages[$nblang];
        $mainindex2 = $path.$lang[$nblang].$dirsep.$dirframe.$dirsep.$homepagesframed[$nblang];
  
        open(MAININDEX,">$mainindex") || die "Error, unable to open $mainindex\n";
        open(MAININDEX2,">$mainindex2") || die "Error, unable to open $mainindex2\n";
        &CreateMainIndex(*MAININDEX,*MAININDEX2, eval($Lang{$lang[$nblang]}), $homepages[$nblang], $lang[$nblang], $homepagesframed[$nblang]);
        close (MAININDEX);
        close (MAININDEX2);
}


sub CreateMainIndex {
  local(*FOUT1,*FOUT2,*L, $H, $I, $J) = @_;

print FOUT1 "<HTML>\n";
print FOUT1 "<HEAD>\n";
print FOUT1 "<TITLE>$L{'Stats_about_host'} $localserver - Frames</TITLE>\n";
print FOUT1 "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT1 "<META NAME=\"ROBOTS\" CONTENT=\"NOFOLLOW\">";
print FOUT1 "</HEAD>\n";

print FOUT1 "<FRAMESET ROWS=\"8\%,*,10\%\">" if ($frame_updown == 1);
print FOUT1 "<FRAMESET COLS=\"8\%,*,8\%\">" if ($frame_updown == 0);
print FOUT1 "<FRAME SCROLLING=\"auto\"  NAME=\"top\" SRC=\"$I$dirsepurl$dirframe$dirsepurl$topframe\">\n";
print FOUT1 "<FRAME SCROLLING=\"auto\" NAME=\"display\" SRC=\"$I$dirsepurl$dirframe$dirsepurl$J\">\n";
print FOUT1 "<FRAME SCROLLING=\"auto\"  NAME=\"bottom\" SRC=\"$I$dirsepurl$dirframe$dirsepurl$bottomframe\">\n";
print FOUT1 "</FRAMESET>\n";

print FOUT1 "<NOFRAMES>\n";

print FOUT1 "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT1 "<H1> <IMG WIDTH=49 HEIGHT=49 SRC=\"$linkpathinit$dirress$dirsepurl$drawstat\"> $L{'Stats'} $firstday - $yesterday</H1><P>\n";
print FOUT1 "<HR>\n";

for ($i=0;$i<=$#lang;$i++) {
print FOUT1 "<A HREF=\"$homepages[$i]\" TARGET=\"_top\"><IMG border=0 WIDTH=30 HEIGHT=15 SRC=\"$linkpathinit$dirress$dirsepurl$flag[$i]\" ALT=\"$flag[$i]\"> $lang[$i]</A> \n" unless ($I eq $lang[$i]);
}

print FOUT1 "<HR><P>\n" if ($#lang > 0);

print FOUT1 "<CENTER>\n";
print FOUT1 "[<A HREF=\"http://$localserver$tri\">Homepage</A>] | [";
print FOUT1 "<A HREF=\"http://www.w3perl.com/demo/docs/html/new.html?$version\">$L{'News'}</A> | ";
print FOUT1 "<A HREF=\"$linkpathinit$dirdocs$dirsepurl$help\">$L{'Docs'}</A>\n";
print FOUT1 "]</CENTER>";

print FOUT1 "<HR><P>\n";

### Big tableau

print FOUT1 "<CENTER>\n";
print FOUT1 "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=8 WIDTH=100%><TR><TD VALIGN=TOP>\n";

### 1er tableau

print FOUT1 "<TABLE BORDER=1 CELLPADDING=1 CELLSPACING=3><TR>\n";
print FOUT1 "<TH><FONT SIZE=+1>$L{'Global_access'}</FONT></TD><TD ALIGN=CENTER><I>$L{'Total'}</I></TH>\n";
print FOUT1 "<TD ALIGN=CENTER><I>$L{'external'}</I></TD><TD ALIGN=CENTER><I>$L{'local'}</I></TD>" if ($locallog == 1 && $localonly != 1);
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD>$L{'Hits'}</TD>\n";
print FOUT1 "<TD ALIGN=CENTER BGCOLOR=\"#00FFFF\">$reqtot</TD>\n";
if ($locallog == 1 && $localonly != 1) {
print FOUT1 "<TD ALIGN=CENTER>".($reqtot - $reqdomtot)."</TD>\n";
print FOUT1 "<TD ALIGN=CENTER>$reqdomtot</TD>\n";
}
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD>$L{'HTML_pages'}</TD>\n";
print FOUT1 "<TD ALIGN=CENTER BGCOLOR=\"#00FF00\">$access</TD>\n";
if ($locallog == 1 && $localonly != 1) {
print FOUT1 "<TD ALIGN=CENTER>".($access - $accessdom)."</TD>\n";
print FOUT1 "<TD ALIGN=CENTER>$accessdom</TD>\n";
}
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD>$L{'Traffic'} ($L{'Mb'})</TD>\n";
print FOUT1 "<TD ALIGN=CENTER BGCOLOR=\"#CCCCCC\">";
printf FOUT1 "%.2f",$totsize;
print FOUT1 "</TD>\n";
if ($locallog == 1 && $localonly != 1) {
print FOUT1 "<TD ALIGN=CENTER>";
printf FOUT1 "%.2f",$externesize;
print FOUT1 "</TD>\n";
print FOUT1 "<TD ALIGN=CENTER>";
printf FOUT1 "%.2f",$domsize;
print FOUT1 "</TD>\n";
}
print FOUT1 "</TR></TABLE>\n";

#

print FOUT1 "</TD><TD VALIGN=TOP ROWSPAN=2>";

### 3ieme tableau

print FOUT1 "<TABLE BORDER=1 CELLPADDING=1 CELLSPACING=3><TR>\n";
print FOUT1 "<TH ALIGN=LEFT COLSPAN=4><FONT SIZE=+1>$L{'Acces_not_taken_into_account'}</FONT></TH>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD COLSPAN=3 ALIGN=LEFT>$L{'Total'}</TD><TD ALIGN=RIGHT BGCOLOR=\"#00FFFF\">".($loglines - $reqtot)."</TD>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "</TD><TD>$L{'Proxy'} (304)</TD><TD ALIGN=RIGHT>$proxy</TD>\n";
print FOUT1 "<TD>$L{'Pages_excluding'}</TD><TD ALIGN=RIGHT>$exclpages</TD>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD>$L{'Redirect'} (302)</TD><TD ALIGN=RIGHT>$redirect</TD>\n";
print FOUT1 "<TD>$L{'Hosts_excluding'}</TD><TD ALIGN=RIGHT>$excladdr</TD>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "</TD><TD>$L{'Forbidden'} (403)</TD><TD ALIGN=RIGHT>$forbiden</TD>\n";
print FOUT1 "<TD>$L{'Frames_excluding'}</TD><TD ALIGN=RIGHT>$exclframed</TD>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD>$L{'Not_found'} (404)</TD><TD ALIGN=RIGHT>$notfound</TD>\n";
print FOUT1 "<TD>$L{'Robots_excluding'}</TD><TD ALIGN=RIGHT>$exclrobots</TD>\n";
#print FOUT1 "</TR><TR>\n";
#print FOUT1 "</TR><TR>\n";
print FOUT1 "</TR></TABLE>\n";

#

print FOUT1 "</TD></TR><TR><TD VALIGN=BOTTOM>";

### 2ieme tableau

print FOUT1 "<TABLE BORDER=1 CELLPADDING=0 CELLSPACING=3>\n";
print FOUT1 "<TR>\n";
print FOUT1 "<TD>$L{'Number_of_different_pages_used'}</TD>";
print FOUT1 "<TD ALIGN=CENTER>$pageunique</TD>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD>$L{'Number_of_different_sites'}</TD>";
print FOUT1 "<TD ALIGN=CENTER>$serverunique</TD>\n";
print FOUT1 "</TR>\n";
if ($precision > 2) {
print FOUT1 "<TR><TD>$L{'Number_of_different_resolved_countries'}</TD>";
print FOUT1 "<TD ALIGN=CENTER>$paysunique</TD></TR>\n";
}
print FOUT1 "</TABLE>\n";

#

print FOUT1 "</TD></TR></TABLE>\n";
print FOUT1 "</CENTER>\n";

print FOUT1 "<P><HR><P>\n";

print FOUT1 "<CENTER>\n";
print FOUT1 "<TABLE WIDTH=100% CELLPADDING=5 CELLSPACING=5 BORDER=1>\n";
print FOUT1 "<TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les sites, pages et pays

print FOUT1 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT1 "<TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirsite$dirsepurl$filesites\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_hosts\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirsite$dirsepurl$filesites\">$L{'Hosts'}</A>\n";
print FOUT1 "</FONT></TD>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirpage$dirsepurl$filepages\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_pages\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirpage$dirsepurl$filepages\">$L{'Pages'}</A>\n";
print FOUT1 "</FONT></TD>\n";
if ($precision > 2) {
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$filetype$htmlext\"><IMG WIDTH=36 HEIGHT=28 SRC=\"$homeicons$dirsepurl$icon_filetype\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$filetype$htmlext\">$L{'Filetype'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
}
if ($inc_script == 1) {
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirscript$dirsepurl$filescript\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_script\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirscript$dirsepurl$filescript\">$L{'Scripts'}</A>\n";
print FOUT1 "</FONT></TD>\n";
}
print FOUT1 "</TR>\n";
if ($precision > 2) {
print FOUT1 "<TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$filerepert\"><IMG WIDTH=34 HEIGHT=29 SRC=\"$homeicons$dirsepurl$icon_dir\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$filerepert\">$L{'Directories'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirpays$dirsepurl$filepays\"><IMG WIDTH=30 HEIGHT=30 SRC=\"$homeicons$dirsepurl$icon_countries\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirpays$dirsepurl$filepays\">$L{'Countries'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$dirdownload$htmlext\"><IMG WIDTH=35 HEIGHT=30 SRC=\"$homeicons$dirsepurl$icon_pie\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$dirdownload$htmlext\">$L{'Download'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
print FOUT1 "</TR>\n";
}

print FOUT1 "</TABLE>\n";

###

print FOUT1 "</TD>\n";
print FOUT1 "<TD ROWSPAN=3 ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les heures,jours, semaines et mois

print FOUT1 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT1 "<TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdate$dirsepurl$filehour\">" if (-e "$path$lang[0]$dirsep$dirdate$dirsep$filenamehour");
print FOUT1 "<IMG WIDTH=26 HEIGHT=29 SRC=\"$homeicons$dirsepurl$icon_hours\" BORDER=0>";
print FOUT1 "</A>\n" if (-e "$path$lang[0]$dirsep$dirdate$dirsep$filenamehour");
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdate$dirsepurl$filehour\">" if (-e "$path$lang[0]$dirsep$dirdate$dirsep$filenamehour");
print FOUT1 "$L{'Hours'}";
print FOUT1 "</A>\n" if (-e "$path$lang[0]$dirsep$dirdate$dirsep$filenamehour");
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdate$dirsepurl$fileday\"><IMG WIDTH=75 HEIGHT=42 SRC=\"$homeicons$dirsepurl$icon_days\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdate$dirsepurl$fileday\">$L{'Days'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdate$dirsepurl$fileweek\">" unless ($nbdays < 14);
print FOUT1 "<IMG WIDTH=80 HEIGHT=50 SRC=\"$homeicons$dirsepurl$icon_weeks\" BORDER=0>";
print FOUT1 "</A>\n" unless ($nbdays < 14);
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdate$dirsepurl$fileweek\">" unless ($nbdays < 14);
print FOUT1 "$L{'Weeks'}";
print FOUT1 "</A>" unless ($nbdays < 14);
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
print FOUT1 "</TR><TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdate$dirsepurl$filemonth\">" unless ($nbdays < 30);
print FOUT1 "<IMG WIDTH=33 HEIGHT=33 SRC=\"$homeicons$dirsepurl$icon_months\" BORDER=0>";
print FOUT1 "</A>\n" unless ($nbdays < 30);
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdate$dirsepurl$filemonth\">" unless ($nbdays < 30);
print FOUT1 "$L{'Months'}";
print FOUT1 "</A>" unless ($nbdays < 30);
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
print FOUT1 "</TR>\n";
print FOUT1 "</TABLE>\n";

###

print FOUT1 "</TD>\n";
print FOUT1 "</TR>\n";
print FOUT1 "<TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les erreurs, references et fureteurs

if ((-e "$path$I$dirsep$dirlist$dirsep$error") || (-e "$path$I$dirsep$dirlist$dirsep$refer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")) {
print FOUT1 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT1 "<TR>\n";
if (-e "$path$I$dirsep$dirlist$dirsep$error") {
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$error\"><IMG WIDTH=42 HEIGHT=40 SRC=\"$homeicons$dirsepurl$icon_error\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$error\">$L{'Errors'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
}
if (-e "$path$I$dirsep$dirlist$dirsep$agent") {
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$agent\"><IMG WIDTH=37 HEIGHT=39 SRC=\"$homeicons$dirsepurl$icon_agent\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$agent\">$L{'Browsers'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
}
if (-e "$path$I$dirsep$dirlist$dirsep$refer") {
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$refer\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_refer\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$refer\">$L{'Referer'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
}
print FOUT1 "</TR>\n";
print FOUT1 "</TABLE>\n";
}

###

print FOUT1 "</TD>\n";
print FOUT1 "</TR>\n";
print FOUT1 "<TR>\n";
print FOUT1 "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les sessions et documents

if ((-e "$path$I$dirsep$dirdocument$dirsep$menu") || (-e "$path$I$dirsep$dirsession$dirsep$filesession") || ($virtualfilter eq '' && $virtualunique != 0)) {
print FOUT1 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT1 "<TR>\n";
if (-e "$path$I$dirsep$dirdocument$dirsep$menu") {
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdocument$dirsepurl$menu\"><IMG WIDTH=53 HEIGHT=33 SRC=\"$homeicons$dirsepurl$icon_doc\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirdocument$dirsepurl$menu\">$L{'Documents'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
}
if (-e "$path$I$dirsep$dirsession$dirsep$filesession") {
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirsession$dirsepurl$filesession\"><IMG WIDTH=38 HEIGHT=39 SRC=\"$homeicons$dirsepurl$icon_session\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirsession$dirsepurl$filesession\">$L{'Sessions'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
}
if ($virtualfilter eq '' && $virtualunique != 0) {
print FOUT1 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT1 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filevirtual\"><IMG WIDTH=34 HEIGHT=33 SRC=\"$homeicons$dirsepurl$icon_virtual\" BORDER=0></A>\n";
print FOUT1 "<BR><FONT SIZE=+1>\n";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$filevirtual\">$L{'Virtual_servers'}</A>\n";
print FOUT1 "</FONT>\n";
print FOUT1 "</TD>\n";
}
print FOUT1 "</TR>\n";
print FOUT1 "</TABLE>\n";
}

##

print FOUT1 "</TD>\n";
print FOUT1 "</TR>\n";
print FOUT1 "</TABLE>\n";

print FOUT1 "</CENTER>\n";

print FOUT1 "<BR>\n";

print FOUT1 "<TABLE BORDER=0 WIDTH=100\%><TR>\n";
print FOUT1 "<TD ALIGN=LEFT><I><FONT SIZE=2>&#169; Copyright 1995/2000 <A HREF=\"mailto:domisse\@w3perl.com\">Laurent DOMISSE</A></FONT></I></TD>\n";
print FOUT1 "<TD ALIGN=RIGHT><I><FONT SIZE=2>";
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$filecpu\">" if (-e "$path$I$dirsep$dirlist$dirsep$filecpu");
print FOUT1 "$L{'Stats'}";
print FOUT1 "</A>" if (-e "$path$I$dirsep$dirlist$dirsep$filecpu");
print FOUT1 " $L{'computed_with'} <A HREF=\"$linkpathinit$dirdocs$dirsepurl$help\">W3Perl $version</A> </FONT></I></TD>\n";
print FOUT1 "</TR></TABLE>\n";
print FOUT1 "</BODY>\n";

print FOUT1 "</NOFRAMES>\n";
print FOUT1 "</HTML>\n";

### version pour le frame

print FOUT2 "<HTML><HEAD>\n";
print FOUT2 "<TITLE>$L{'Stats_about_host'} $localserver - Frame Menu</TITLE>\n";
print FOUT2 "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT2 "<META NAME=\"ROBOTS\" CONTENT=\"NOFOLLOW\">";
print FOUT2 "</HEAD>\n";

print FOUT2 "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT2 "<H1> <IMG WIDTH=49 HEIGHT=49 SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$drawstat\"> $L{'Stats'} $firstday - $yesterday</H1><P>\n";
print FOUT2 "<HR>\n";

for ($i=0;$i<=$#lang;$i++) {
print FOUT2 "<A HREF=\"..$dirsepurl..$dirsepurl$homepages[$i]\" TARGET=\"_top\"><IMG BORDER=0 WIDTH=30 HEIGHT=15 SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$flag[$i]\"> $lang[$i]</A> \n" unless ($I eq $lang[$i]);
}

print FOUT2 "<HR><P>\n" if ($#lang > 0);

### Big tableau

print FOUT2 "<CENTER>\n";
print FOUT2 "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=8 WIDTH=100%><TR><TD VALIGN=TOP>\n";

### 1er tableau

print FOUT2 "<TABLE BORDER=1 CELLPADDING=1 CELLSPACING=3><TR>\n";
print FOUT2 "<TH><FONT SIZE=+1>$L{'Global_access'}</FONT></TD><TD ALIGN=CENTER><I>$L{'Total'}</I></TH>\n";
print FOUT2 "<TD ALIGN=CENTER><I>$L{'external'}</I></TD><TD ALIGN=CENTER><I>$L{'local'}</I></TD>" if ($locallog == 1 && $localonly != 1);
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD>$L{'Hits'}</TD>\n";
print FOUT2 "<TD ALIGN=CENTER BGCOLOR=\"#00FFFF\">$reqtot</TD>\n";
if ($locallog == 1 && $localonly != 1) {
print FOUT2 "<TD ALIGN=CENTER>".($reqtot - $reqdomtot)."</TD>\n";
print FOUT2 "<TD ALIGN=CENTER>$reqdomtot</TD>\n";
}
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD>$L{'HTML_pages'}</TD>\n";
print FOUT2 "<TD ALIGN=CENTER BGCOLOR=\"#00FF00\">$access</TD>\n";
if ($locallog == 1 && $localonly != 1) {
print FOUT2 "<TD ALIGN=CENTER>".($access - $accessdom)."</TD>\n";
print FOUT2 "<TD ALIGN=CENTER>$accessdom</TD>\n";
}
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD>$L{'Traffic'} ($L{'Mb'})</TD>\n";
print FOUT2 "<TD ALIGN=CENTER BGCOLOR=\"#CCCCCC\">";
printf FOUT2 "%.2f",$totsize;
print FOUT2 "</TD>\n";
if ($locallog == 1 && $localonly != 1) {
print FOUT2 "<TD ALIGN=CENTER>";
printf FOUT2 "%.2f",$externesize;
print FOUT2 "</TD>\n";
print FOUT2 "<TD ALIGN=CENTER>";
printf FOUT2 "%.2f",$domsize;
print FOUT2 "</TD>\n";
}
print FOUT2 "</TR></TABLE>\n";

#

print FOUT2 "</TD><TD VALIGN=TOP ROWSPAN=2>";

### 3ieme tableau

print FOUT2 "<TABLE BORDER=1 CELLPADDING=1 CELLSPACING=3><TR>\n";
print FOUT2 "<TH ALIGN=LEFT COLSPAN=4><FONT SIZE=+1>$L{'Acces_not_taken_into_account'}</FONT></TH>\n";
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD COLSPAN=3 ALIGN=LEFT>$L{'Total'} :</TD><TD ALIGN=RIGHT BGCOLOR=\"#00FFFF\">".($loglines - $reqtot)."</TD>\n";
print FOUT2 "</TR><TR>\n";
print FOUT2 "</TD><TD>$L{'Proxy'} (304)</TD><TD ALIGN=RIGHT>$proxy</TD>\n";
print FOUT2 "<TD>$L{'Pages_excluding'}</TD><TD ALIGN=RIGHT>$exclpages</TD>\n";
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD>$L{'Redirect'} (302)</TD><TD ALIGN=RIGHT>$redirect</TD>\n";
print FOUT2 "<TD>$L{'Hosts_excluding'}</TD><TD ALIGN=RIGHT>$excladdr</TD>\n";

print FOUT2 "</TR><TR>\n";
print FOUT2 "</TD><TD>$L{'Forbidden'} (403)</TD><TD ALIGN=RIGHT>$forbiden</TD>\n";
print FOUT2 "<TD>$L{'Frames_excluding'}</TD><TD ALIGN=RIGHT>$exclframed</TD>\n";
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD>$L{'Not_found'} (404)</TD><TD ALIGN=RIGHT>$notfound</TD>\n";
print FOUT2 "<TD>$L{'Robots_excluding'}</TD><TD ALIGN=RIGHT>$exclrobots</TD>\n";

print FOUT2 "</TR></TABLE>\n";

#

print FOUT2 "</TD></TR><TR><TD VALIGN=BOTTOM>";

### 2ieme tableau

print FOUT2 "<TABLE BORDER=1 CELLPADDING=0 CELLSPACING=3>\n";
print FOUT2 "<TR>\n";
print FOUT2 "<TD>$L{'Number_of_different_pages_used'}</TD>";
print FOUT2 "<TD ALIGN=CENTER>$pageunique</TD>\n";
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD>$L{'Number_of_different_sites'}</TD>";
print FOUT2 "<TD ALIGN=CENTER>$serverunique</TD>\n";
print FOUT2 "</TR>\n";
if ($precision > 2) {
print FOUT2 "<TR><TD>$L{'Number_of_different_resolved_countries'}</TD>";
print FOUT2 "<TD ALIGN=CENTER>$paysunique</TD></TR>\n";
}
print FOUT2 "</TABLE>\n";

#

print FOUT2 "</TD></TR></TABLE>\n";
print FOUT2 "</CENTER>\n";

#if ($inc_script == 1) {
#$tmp = $method{'GET'} + $method{'POST'};
#print FOUT2 "<TD>$L{'Total_number_of_scripts'} :</TD><TD ALIGN=RIGHT>$tmp\n";
#print FOUT2 "</TR><TR>\n";
#}

print FOUT2 "<P><HR><P>\n";

print FOUT2 "<CENTER>\n";
print FOUT2 "<TABLE WIDTH=100% CELLPADDING=5 CELLSPACING=5 BORDER=1>\n";
print FOUT2 "<TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les sites, pages et script

print FOUT2 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT2 "<TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirsite$dirsepurl$filesites\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_hosts\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirsite$dirsepurl$filesites\">$L{'Hosts'}</A>\n";
print FOUT2 "</FONT></TD>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirpage$dirsepurl$filepages\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_pages\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirpage$dirsepurl$filepages\">$L{'Pages'}</A>\n";
print FOUT2 "</FONT></TD>\n";
if ($precision > 2) {
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filetype$htmlext\"><IMG WIDTH=36 HEIGHT=28 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_filetype\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filetype$htmlext\">$L{'Filetype'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
}
if ($inc_script == 1) {
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirscript$dirsepurl$filescript\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_script\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirscript$dirsepurl$filescript\">$L{'Scripts'}</A>\n";
print FOUT2 "</FONT></TD>\n";
}
print FOUT2 "</TR>\n";

if ($precision > 2) {
print FOUT2 "<TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filerepert\"><IMG WIDTH=34 HEIGHT=29 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_dir\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filerepert\">$L{'Directories'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirpays$dirsepurl$filepays\"><IMG WIDTH=30 HEIGHT=30 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_countries\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirpays$dirsepurl$filepays\">$L{'Countries'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$dirdownload$htmlext\"><IMG WIDTH=35 HEIGHT=30 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_pie\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$dirdownload$htmlext\">$L{'Download'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
print FOUT2 "<TD></TD>\n";
print FOUT2 "</TR>\n";
}

print FOUT2 "</TABLE>\n";

###

print FOUT2 "</TD>\n";
print FOUT2 "<TD ROWSPAN=3 ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les heures,jours, semaines et mois

print FOUT2 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT2 "<TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$filehour\">" if (-e "$path$lang[0]$dirsep$dirdate$dirsep$filenamehour");
print FOUT2 "<IMG WIDTH=26 HEIGHT=29 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_hours\" BORDER=0>";
print FOUT2 "</A>\n" if (-e "$path$lang[0]$dirsep$dirdate$dirsep$filenamehour");
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$filehour\">" if (-e "$path$lang[0]$dirsep$dirdate$dirsep$filenamehour");
print FOUT2 "$L{'Hours'}";
print FOUT2 "</A>\n" if (-e "$path$lang[0]$dirsep$dirdate$dirsep$filenamehour");
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileday\"><IMG WIDTH=75 HEIGHT=42 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_days\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileday\">$L{'Days'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileweek\">" unless ($nbdays < 14);
print FOUT2 "<IMG WIDTH=80 HEIGHT=50 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_weeks\" BORDER=0>";
print FOUT2 "</A>\n" unless ($nbdays < 14);
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$fileweek\">" unless ($nbdays < 14);
print FOUT2 "$L{'Weeks'}";
print FOUT2 "</A>" unless ($nbdays < 14);
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
print FOUT2 "</TR><TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$filemonth\">" unless ($nbdays < 30);
print FOUT2 "<IMG WIDTH=33 HEIGHT=33 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_months\" BORDER=0>";
print FOUT2 "</A>\n" unless ($nbdays < 30);
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdate$dirsepurl$filemonth\">" unless ($nbdays < 30);
print FOUT2 "$L{'Months'}";
print FOUT2 "</A>" unless ($nbdays < 30);
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
print FOUT2 "</TR>\n";
print FOUT2 "</TABLE>\n";

###

print FOUT2 "</TD>\n";
print FOUT2 "</TR>\n";
print FOUT2 "<TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les erreurs, references et fureteurs

if ((-e "$path$I$dirsep$dirlist$dirsep$error") || (-e "$path$I$dirsep$dirlist$dirsep$refer") || (-e "$path$I$dirsep$dirlist$dirsep$agent")) {
print FOUT2 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT2 "<TR>\n";
if (-e "$path$I$dirsep$dirlist$dirsep$error") {
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$error\"><IMG WIDTH=42 HEIGHT=40 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_error\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$error\">$L{'Errors'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
}
if (-e "$path$I$dirsep$dirlist$dirsep$agent") {
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$agent\"><IMG WIDTH=37 HEIGHT=39 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_agent\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$agent\">$L{'Browsers'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
}
if (-e "$path$I$dirsep$dirlist$dirsep$refer") {
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$refer\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_refer\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$refer\">$L{'Referer'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
}
print FOUT2 "</TR>\n";
print FOUT2 "</TABLE>\n";
}

###

print FOUT2 "</TD>\n";
print FOUT2 "</TR>\n";
print FOUT2 "<TR>\n";
print FOUT2 "<TD ALIGN=CENTER VALIGN=CENTER>\n";

### pointeurs sur les sessions et documents

if ((-e "$path$I$dirsep$dirdocument$dirsep$menu") || (-e "$path$I$dirsep$dirsession$dirsep$filesession") || ($virtualfilter eq '' && $virtualunique != 0)) {
print FOUT2 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>\n";
print FOUT2 "<TR>\n";
if (-e "$path$I$dirsep$dirdocument$dirsep$menu") {
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdocument$dirsepurl$menu\"><IMG WIDTH=53 HEIGHT=33 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_doc\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirdocument$dirsepurl$menu\">$L{'Documents'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
}
if (-e "$path$I$dirsep$dirsession$dirsep$filesession") {
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirsession$dirsepurl$filesession\"><IMG WIDTH=38 HEIGHT=39 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_session\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirsession$dirsepurl$filesession\">$L{'Sessions'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
}
if ($virtualfilter eq '' && $virtualunique != 0) {
print FOUT2 "<TD ALIGN=CENTER VALIGN=BOTTOM>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filevirtual\"><IMG WIDTH=34 HEIGHT=33 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_virtual\" BORDER=0></A>\n";
print FOUT2 "<BR><FONT SIZE=+1>\n";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filevirtual\">$L{'Virtual_servers'}</A>\n";
print FOUT2 "</FONT>\n";
print FOUT2 "</TD>\n";
}

print FOUT2 "</TR>\n";
print FOUT2 "</TABLE>\n";
}

##

print FOUT2 "</TD>\n";
print FOUT2 "</TR>\n";
print FOUT2 "</TABLE>\n";

print FOUT2 "</CENTER>\n";

print FOUT2 "<BR>\n";

print FOUT2 "<TABLE BORDER=0 WIDTH=100\%><TR>\n";
print FOUT2 "<TD ALIGN=LEFT><I><FONT SIZE=2>&#169; Copyright 1995/2000 <A HREF=\"mailto:domisse\@w3perl.com\">Laurent DOMISSE</A></FONT></I></TD>\n";
print FOUT2 "<TD ALIGN=RIGHT><I><FONT SIZE=2>";
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filecpu\">" if (-e "$path$I$dirsep$dirlist$dirsep$filecpu");
print FOUT2 "$L{'Stats'}";
print FOUT2 "</A>" if (-e "$path$I$dirsep$dirlist$dirsep$filecpu");
print FOUT2 " $L{'computed_with'} <A HREF=\"..$dirsepurl..$dirsepurl$linkpathinit$dirdocs$dirsepurl$help\">W3Perl $version</A> </FONT></I></TD>\n";
print FOUT2 "</TR></TABLE>\n";
print FOUT2 "</BODY></HTML>\n";
}


#################################################################
### creation des fichiers de log des pages lues par les sites ###
#################################################################

### Si adresse IP ==> 1 fichier                        ###
### Si adresse litterale ==> regroupement par domaine  ###

if ($precision > 3) {

    print STDOUT "Creating pages accesses per hosts\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

    for ($nblang=0;$nblang<=$#lang;$nblang++) {
        &Pagesbysites(*LITTLEINDEX, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
    }
}

### creation des nouveaux....

# serveur externe

sub Pagesbysites {
    local(*FOUT,*L,$I) = @_;

    foreach $site (keys(%server)) {
#	print "$site - $nbpageserveur{$site} - $seuilpage\n";
#        if ($nbpageserveur{$site} > $seuilpage) { # pages HTML
        if ($server{$site} > $seuilpage) {  # requetes 
        $newsite = $site;
        $newsite =~ s/[.]/_/g;
        $newsite .= $htmlext;

        if ($site =~ /^[0-9.]+$/) {
            open(PAGESITE,">$path$I$dirsep$dirsite$dirsep$newsite") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$newsite\n";
            print PAGESITE "<HTML><HEAD>\n";
            print PAGESITE "<TITLE>$L{'Page_read'} - $site </TITLE>\n";
            print PAGESITE "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
            print PAGESITE "</HEAD>\n";
            print PAGESITE "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
        }
        else {
            $pospoint = index($newsite,'_',0);
            $domadresse = substr($newsite,$pospoint+1,(length($newsite)-length($pospoint)));
            
            # si le fichier existe deja, on ajoute l'adresse dans le fichier de domaine
            
            if (-e "$path$I$dirsep$dirsite$dirsep$domadresse") {
                open(PAGESITE,">>$path$I$dirsep$dirsite$dirsep$domadresse") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$domadresse\n";
            } else {
                open(PAGESITE,">$path$I$dirsep$dirsite$dirsep$domadresse") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$domadresse\n";
                print PAGESITE "<HTML><HEAD>\n";
                print PAGESITE "<TITLE>$L{'Page_read'} - $L{'domain'} $domadresse </TITLE>\n";
                print PAGESITE "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
                print PAGESITE "</HEAD>\n";
                print PAGESITE "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
            }
        }

        print PAGESITE "<A NAME=\"$site\">\n";
        print PAGESITE "<H1> $L{'Page_read'} - $site</H1>\n";
        print PAGESITE "<I>($nbpageserveur{$site} ";
        print PAGESITE "$L{'pages'}" if ($nbpageserveur{$site} != 1);
        print PAGESITE "$L{'page'}" if ($nbpageserveur{$site} == 1);
        print PAGESITE " HTML";
        print PAGESITE " $L{'among'} $server{$site} ";
        print PAGESITE "$L{'request'}" if ($server{$site} == 1);
        print PAGESITE "$L{'requests'}" if ($server{$site} != 1);
        print PAGESITE ")</I>\n";
        print PAGESITE "<P><HR><P>\n";
	print PAGESITE "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";

        for ($i=0;$i<($nbpageserveur{$site});$i++) {
           if (!($seen{"$I $site $pagesite{$site,$i}"}++)) {
	       $tmp2 = 0;
	       $tmp1 = $pagesite{$site,$i};
	       $tmp2++ while $tmp1 =~ s/$dirsepurl//;
	       print PAGESITE "<TR>";
	       for ($j=1;$j<$tmp2;$j++) {
		   print PAGESITE "<TD BGCOLOR=\"#F0F0F0\">&nbsp;</TD>\n";
	       }
            print PAGESITE "<TD BGCOLOR=\"#C0C0C0\"><A HREF=\"$pagesite{$site,$i}\">";
            print PAGESITE "$pagesite{$site,$i}" if ($titlename == 0);
            print PAGESITE "$urlconv{$pagesite{$site,$i}}" if ($titlename == 1 && $urlconv{$pagesite{$site,$i}} ne '');
            print PAGESITE "$pagesite{$site,$i}" if ($titlename == 1 && $urlconv{$pagesite{$site,$i}} eq '');
            print PAGESITE "</A></TD>\n</TR>\n";
            }
        }
	print PAGESITE "</TABLE>\n";
        print PAGESITE "$L{'No_request'}<P>\n" if ($nbpageserveur{$site} == 0);
        print PAGESITE "<P><HR><P>\n";
        close PAGESITE;
    }
}

# serveur locaux

    if ($locallog != 0) {
        foreach $site (keys(%localserver)) {
#        if ($nbpageserveur{$site} > $seuilpage) {    # pages HTML    
        if ($localserver{$site} > $seuilpage) {        # requetes
            $newsite = $site;
            $newsite =~ s/[.]/_/g;
            $newsite .= $htmlext;
                $pospoint = index($newsite,'_',0);
                $domadresse = substr($newsite,$pospoint+1,(length($newsite)-length($pospoint)));
                
                # si le fichier existe deja, on ajoute l'adresse dans le fichier de domaine
                
                if (-e "$path$I$dirsep$dirsite$dirsep$domadresse") {
                    open(PAGESITE,">>$path$I$dirsep$dirsite$dirsep$domadresse") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$domadresse\n";
                } else {
                    open(PAGESITE,">$path$lang[$nbalng]$dirsep$dirsite$dirsep$domadresse") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$domadresse\n";
                    print PAGESITE "<HTML><HEAD>\n";
                    print PAGESITE "<TITLE>$L{'Page_read'} - $L{'domaine'} $domadresse </TITLE>\n";
                    print PAGESITE "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
                    print PAGESITE "</HEAD>\n";
                    print PAGESITE "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
                }
#            }
            print PAGESITE "<A NAME=\"$site\">\n";
            print PAGESITE "<H1> $L{'Pages_read'} - $site </H1>";
            print PAGESITE "<I>($nbpageserveur{$site} ";
            print PAGESITE "$L{'pages'}" if ($nbpageserveur{$site} != 1);
            print PAGESITE "$L{'page'}" if ($nbpageserveur{$site} == 1);
            print PAGESITE " HTML";
            print PAGESITE " $L{'among'} $localserver{$site} ";
            print PAGESITE "$L{'request'}" if ($localserver{$site} == 1);
            print PAGESITE "$L{'requests'}" if ($localserver{$site} != 1);
            print PAGESITE ") </I>\n";
            print PAGESITE "<P><HR><P>\n";
	    print PAGESITE "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";

            for ($i=0;$i<($nbpageserveur{$site});$i++) {
           if (!($seen{"$I $site $pagesite{$site,$i}"}++)) {
	       $tmp2 = 0;
	       $tmp1 = $pagesite{$site,$i};
	       $tmp2++ while $tmp1 =~ s/$dirsepurl//;
	       print PAGESITE "<TR>";
	       for ($j=1;$j<$tmp2;$j++) {
		   print PAGESITE "<TD BGCOLOR=\"#F0F0F0\">&nbsp;</TD>\n";
	       }
            print PAGESITE "<TD BGCOLOR=\"#C0C0C0\"><A HREF=\"$pagesite{$site,$i}\">";
            print PAGESITE "$pagesite{$site,$i}" if ($titlename == 0);
            print PAGESITE "$urlconv{$pagesite{$site,$i}}" if ($titlename == 1 && $urlconv{$pagesite{$site,$i}} ne '');
            print PAGESITE "$pagesite{$site,$i}" if ($titlename == 1 && $urlconv{$pagesite{$site,$i}} eq '');
            print PAGESITE "</A></TD>\n</TR>\n";
	   }            
       }
	print PAGESITE "</TABLE>\n";
           print PAGESITE "$L{'No_request'}<P>\n"if ($nbpageserveur{$site} == 0);
            print PAGESITE "<P><HR><P>\n";
            close PAGESITE;
        }
    }
}

### enfin ajout du </BODY></HTML> sur tous les fichiers

# sites externes

    foreach $site (keys(%server)) {
        if ($nbpageserveur{$site} > $seuilpage) {    
        $newsite = $site;
        $newsite =~ s/[.]/_/g;
        $newsite .= $htmlext;
        if ($site =~ /^[0-9.]+$/) {
            open(PAGESITE,">>$path$I$dirsep$dirsite$dirsep$newsite") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$newsite\n";
            print PAGESITE "</BODY></HTML>\n";
            close PAGESITE;
        }
        else {
            $pospoint = index($newsite,'_',0);
            $domadresse = substr($newsite,$pospoint+1,(length($newsite)-length($pospoint)));
            open(PAGESITE,">>$path$I$dirsep$dirsite$dirsep$domadresse") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$domadresse\n";
            print PAGESITE "</BODY></HTML>\n" unless $seen{$domadresse}++;
            close PAGESITE;
        }
    }
    }
       
# sites locaux

    if ($locallog != 0) {
        foreach $site (keys(%localserver)) {
        if ($nbpageserveur{$site} > $seuilpage) {
            $newsite = $site;
            $newsite =~ s/[.]/_/g;
            $newsite .= $htmlext;
            if ($site =~ /^[0-9.]+$/) {
                open(PAGESITE,">>$path$I$dirsep$dirsite$dirsep$newsite") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$newsite\n";
                print PAGESITE "</BODY></HTML>\n";
                close PAGESITE;
            }
            else {
                $pospoint = index($newsite,'_',0);
                $domadresse = substr($newsite,$pospoint+1,(length($newsite)-length($pospoint)));
                open(PAGESITE,">>$path$I$dirsep$dirsite$dirsep$domadresse") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$domadresse\n";
                print PAGESITE "</BODY></HTML>\n" unless $seen{$domadresse}++;
                close PAGESITE;
            }
        }
    }
}
}

############################################################
### creation des fichiers de log de certaines pages lues ###
############################################################

if ($precision > 2) {

### number of firstday and lastday

($tmp1,$tmp2,$tmp3) = split(/ /,$firstday);

$jour_of_year = 0;
$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $tmp2) {
     $jour_of_year += $month_of_year{$month_end};
     $countmonth++;
     $month_end = $month_nb[$countmonth];
}

$firstday_nb = $jour_of_year + $tmp1 + ($tmp3*365);

#

($tmp1,$tmp2,$tmp3) = split(/ /,$yesterday);

$jour_of_year = 0;
$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $tmp2) {
     $jour_of_year += $month_of_year{$month_end};
     $countmonth++;
     $month_end = $month_nb[$countmonth];
}

$lastday_nb = $jour_of_year + $tmp1 + ($tmp3*365);

# date il y a $nbdays jours

if ($nbdayscf != 0 ) {

$monthindex--;
$pastday = $daytmp  - $nbdayscf; 
$pastyear = $fullyear;
$pastmonth = $month_nb[$monthindex];

while ($pastday < 1) {
  $monthindex--;
  if ($monthindex < 0) {
      $pastyear--;
      $monthindex = 11;
   }
   $pastmonth = $month_nb[$monthindex];
   $pastday = $pastday + $month_of_year{$pastmonth};
}

$pasttoday = $pastday." ".$pastmonth." ".$pastyear;         
#print STDERR "Day :  $pasttoday\n";  
}

###

print STDOUT "Creating selected pages stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($i=0;$i<=($#selection);$i++) {

$newpage = "page".$i;

# trouve les sites differents ainsi que leur occurence

$found = 0;
for ($j=0;$j<=$#selecpages;$j++) {
if ($selecpages[$j] =~ m/^$selection[$i]/i) {
   $found++;
   $found{$selection[$i],$selecadresse[$j]}++;
   push (@list,$selecadresse[$j]);
   push (@version,$selecdate[$j]);
   ($tmp1,$tmp2,$tmp3) = split(/\//,$selecdate[$j]);
   
       $jour_of_year = 0;
       $countmonth = 0;
       $month_end = $month_nb[$countmonth];

       while ($month_end ne $tmp2) {
          $jour_of_year += $month_of_year{$month_end};
          $countmonth++;
          $month_end = $month_nb[$countmonth];
       }

       $jour_of_year += $tmp1;
       $jour_of_year += ($tmp3*365);
       $jour_of_year -= $firstday_nb;       
       $pagesel{$selection[$i],$jour_of_year}++;
       $maxday[$i] = $pagesel{$selection[$i],$jour_of_year} if ($pagesel{$selection[$i],$jour_of_year} > $maxday[$i]);
   }
}


####

sort (@list);

### graph

$graphpage = $path.$dirgraph.$dirsep.$newpage.$gifext;
$graphpagex = $path.$dirgraph.$dirsep.$newpage."x".$gifext;
$graphpagey = $path.$dirgraph.$dirsep.$newpage."y".$gifext;
$linkgraphpage = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$newpage.$gifext;
$linkgraphpagex = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$newpage."x".$gifext;
$linkgraphpagey = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$newpage."y".$gifext;

$tmp = $lastday_nb - $firstday_nb;
$add = 0;
$add = ($tmp - $nbdayscf) if ($tmp > $nbdayscf);
$add = $add + $ydaystarttoday +1 - $lastday_nb +1 if ($tmp > $nbdayscf);
$tmp = $nbdayscf if ($add != 0);

$it = length($tmp)-1;
$div = 10**$it;
$factx = ($div*(int($tmp/$div)+1))/$grad;

$perspec = $xstep/$factx if (($perspec > $xstep/$factx) && ($tridim == 1));

$it = length($maxday[$i])-1;
$div = 10**$it;
$facty = ($div*(int($maxday[$i]/$div)+1))/$grad;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
print FLY "frect 0,0,0,0,200,200,200\n";
for ($k=0;$k<=$tmp;$k++) {
# $x1 = $k*$xstep/$factx;
# $x2 = ($k+1)*$xstep/$factx;
# $y2 = $ymax - ($ystep/$facty * $pagesel{$selection[$i],$k});

$k2 = $k + $add;

 $x1 = ($k+$linegraph+$tridim)*$xstep/$factx;
 $x2 = ($k+1+$linegraph+$tridim)*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $pagesel{$selection[$i],$k2});

 $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
 $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);

#print FLY "frect $x1,$y2,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
#print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";

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
    $y1 = $ymax - ($ystep/$facty * $pagesel{$selection[$i],$k2});
    print FLY "line $x1,$y2,$x2,$y1,$red[0],$green[0],$blue[0]\n";

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
  
}
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $graphpage |");
while( <FOO> ) {print;}
close(FOO);

### image pour les abscisses

($startday, $startmonth) = split(/ /,$firstday) if ($add == 0);
($startday, $startmonth) = split(/ /,$pasttoday) if ($add != 0);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);

$xlegend = "$tmp days (starting $firstday)" if ($add == 0);
$xlegend = "$tmp days (starting $pasttoday)" if ($add != 0);

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($k=$xstep;$k<$xmax;$k+=$xstep) {
 $valstep = int(($k/$xmax)*(($xmax*$factx/$xstep)))+$startday;

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
 $posx = $k - length($valstep)*10;
 print FLY "line $k,0,$k,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$val\n";

 }
print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $graphpagex |");
while( <FOO> ) {print;}
close(FOO);
 
### image pour les ordonnees
 
open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($k=$ystep;$k<$ymax;$k+=$ystep) {
 $valstep = int(($ymax - $k) * ($facty/$ystep));
 print FLY "line $xdecalm,$k,$xdecal,$k,0,0,0\n";
 $pos = ($xdecal - length($valstep)*9);
 $posy = $k-5;
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $graphpagey |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

#####

$newpage .= $htmlext;

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(PAGESELECT,">$path$lang[$nblang]$dirsep$dirpage$dirsep$newpage") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpage$dirsep$newpage\n";
&PageSelection(*PAGESELECT, eval($Lang{$lang[$nblang]}),$lang[$nblang],$found);
close (PAGESELECT);
}

undef @list;
undef @version;

}
}

undef @selecpage;
undef @selecdate;
undef @selecadresse;

sub PageSelection {
  local(*FOUT,*L,$I,$found) = @_;
  local($k);
  
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Hosts'} $L{'connecting_to'} $L{'page'} $selection[$i] </TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<h1> $L{'Hosts'} $L{'connecting_to'} $L{'page'} $selection[$i] </H1>\n";
print FOUT "<P><HR><P>\n";

if ($found != 0) {

print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkgraphpagey\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkgraphpage\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkgraphpagex\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE><P>\n";
print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH>$L{'Hosts'}</TH><TH>$L{'Occurence'}</TH><TH>$L{'last_read_on'}</TH></TR>\n";

   for ($k=$#list;$k>=0;$k--) {
   ($tmp1,$tmp2,$tmp3,$tmp4) = split(/:/,$version[$k]);
   print FOUT "<TR><TD><b>$list[$k]</b></TD><TD ALIGN=RIGHT>$found{$selection[$i],$list[$k]} $L{'times'}</TD><TD><I>$tmp1&nbsp;&nbsp;$tmp2:$tmp3:$tmp4</I></TD>\n" unless ($seen{"$I $selection[$i] $list[$k] $found{$selection[$i],$list[$k]}"}++);
   }
print FOUT "</TABLE></CENTER>\n";
} else {
   print FOUT "$L{'No_request'}<P>\n";
   }

print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

#######################################################
### creation du fichier contenant la liste des pays ###
#######################################################

if ($precision > 2) {

print STDOUT "Creating countries stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

## tri, calcul

foreach $pays (sort keys(%payslist)) {
        $pourcentpays{$pays} = $payslist{$pays}*100/$reqtot;
        $pourcent2pays{$pays} = $payshtml{$pays}*100/$access;
}

$pourcentpaysunknown = $pourcentpays{Unknown};
$pourcentpays2unknown = $pourcent2pays{Unknown};

for ($i=0;$i <= $paysunique;$i++) {
$maxi = 0;
foreach $pays (keys(%pourcentpays)) {
    if ($pourcentpays{$pays} > $maxi) {
         $maxi = $pourcentpays{$pays};
         $bestpays[$i] = $pays;
         $occurpays2[$i] = $pourcentpays{$pays};
         $occurhtml[$i] = $pourcent2pays{$pays};
         }
    }
$pourcentpays{$bestpays[$i]} = 0;
}

for ($i=0;$i <= $paysunique;$i++) {
        next if ($bestpays[$i] eq "Unknown");
        $pays = $bestpays[$i];
        $sizepays{$pays} /= 1024; # convert in Kb
    }

$sizepays{Unknown} /= 1024; # convert in Kb

## Area stats

for ($i=0;$i <= $paysunique;$i++) {
        next if ($bestpays[$i] eq "Unknown");
        $pays = $bestpays[$i];
	$zone = $zonepays{$pays};
	$zonehits[$zone] += $payslist{$pays};
	$zonehtml[$zone] += $payshtml{$pays};
        $zoneserver[$zone] += $serverpays{$pays};
	$zonesize[$zone] += $sizepays{$pays};
    }

##

  $string_map{'Europe'} = "213,18,298,74";
  $string_map{'North-America'} = "15,3,19,55,122,109,238,4";
  $string_map{'Central-America'} = "109,109,133,100,145,86,160,103,142,113,138,119";
  $string_map{'South-America'} = "142,113,147,109,173,109,207,132,154,214,126,181,140,118";
  $string_map{'Africa'} = "236,77,199,104,282,185,338,158,322,109,312,108,294,80,262,73,234,77,278,123";
  $string_map{'Asia'} = "302,13,499,16,500,51,462,144,437,138,372,151,330,73,308,66,301,55";
  $string_map{'Middle-East'} = "296,182,305,66,333,72,335,94,313,108";
  $string_map{'Oceania'} = "408,146,444,140,468,144,500,100,500,200,409,183";

## ML support

for ($nblang=0;$nblang<=$#lang;$nblang++) {

    for ($i=1;$i<=$nbzone;$i++) {
	if ($zonehits[$i] ne '') {
	open(FILEZONE,">$path$lang[$nblang]$dirsep$dirpays$dirsep$zone[$i]$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpays$dirsep$zone[$i]$htmlext\n";
	&ZonePays(*FILEZONE, eval($Lang{$lang[$nblang]}),$i);
	close (FILEZONE);
    }
    }

    open(FILEPAYS,">$path$lang[$nblang]$dirsep$dirpays$dirsep$filepays") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpays$dirsep$filepays\n";
    &PagePays(*FILEPAYS, eval($Lang{$lang[$nblang]}));
    close (FILEPAYS);
}


## Geographic area

sub ZonePays {
  local(*FOUT,*L,$zone) = @_;
  local($i);

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - $L{'countries'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $zone[$zone]</H1><P>\n";
print FOUT "<P><HR><P>\n";

#  print FOUT "$zone[$zone] : $zonehits[$zone] hits - $zonehtml[$zone] html - $zoneserver[$zone] server - $zonesize[$zone] Ko<P>\n";

print FOUT "<TABLE BORDER=1 WIDTH=100%><TR>\n";
print FOUT "<TH>$L{'Countries'}</TH>\n";
print FOUT "<TH COLSPAN=2>$L{'Hits'}</TH>";
print FOUT "<TH COLSPAN=2>$L{'HTML_pages'}</TH>";
print FOUT "<TH COLSPAN=2>$L{'Hosts'}</TH>";
print FOUT "<TH COLSPAN=2>$L{'Traffic'} ($L{'Kb'})</TH>";
print FOUT "</TR>\n";

for ($i=0;$i <= $paysunique;$i++) {
        next if ($bestpays[$i] eq "Unknown");
        $pays = $bestpays[$i];
	if ($zonepays{$pays} == $zone) {

        print FOUT "<TR>\n";
        print FOUT "<TD ALIGN=MIDDLE><A HREF=\"$flagpage{$pays}\"\>";
        print FOUT "$L{$newflag{$pays}}</A>";
        print FOUT "</TD><TD>\n ";
	$percentage = ($payslist{$pays}*100)/$zonehits[$zone];
        $tmp2 = int($percentage);
        print FOUT "<img width=$tmp2 height=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">" if ($tmp2 != 0);
        print FOUT " <B>$payslist{$pays}</B></TD>";
        printf FOUT "<TD ALIGN=RIGHT>%3.1f %",$percentage;
        print FOUT "</TD>\n";

	$percentage = 0;
        $percentage = ($payshtml{$pays}*100)/$zonehtml[$zone] if ($payshtml{$pays} != 0);
        $tmp2 = int($percentage);
        print FOUT "<TD>\n";
        print FOUT "<img width=$tmp2 height=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">" if ($tmp2 != 0);
        printf FOUT " <B>%d</B></TD>",$payshtml{$pays};
        printf FOUT "<TD ALIGN=RIGHT>%3.1f %",$percentage;
        print FOUT "</TD>\n";

	$percentage = 0;
        $percentage = ($serverpays{$pays}*100)/$zoneserver[$zone] if ($serverpays{$pays} != 0);
        $tmp2 = int($percentage);
        print FOUT "<TD>\n";
        print FOUT "<img width=$tmp2 height=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">" if ($tmp2 != 0);
        print FOUT " <B>$serverpays{$pays}</B>";
        print FOUT "</TD>\n";
        printf FOUT "<TD ALIGN=RIGHT>%.1f %",$percentage;
        print FOUT "</TD>\n";        

	$percentage = 0;
        $percentage = $sizepays{$pays}*100/$zonesize[$zone] if ($sizepays{$pays} != 0);
        $tmp = int($percentage);

        print FOUT "<TD>\n";
        print FOUT "<img width=$tmp height=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">" if ($tmp != 0);
        printf FOUT " <B>%d</B></TD>",$sizepays{$pays};
        printf FOUT "<TD ALIGN=RIGHT>%3.1f %",$percentage;
        print FOUT "</TD>\n";
        print FOUT "</TR>\n";
    }
    }

print FOUT "</TABLE>\n";

print FOUT "</BODY></HTML>\n";
}

## Countries

sub PagePays {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - $L{'countries'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'Countries'} $L{'connecting_to_the_server'} :</H1><P>\n";
print FOUT "<P><HR><P>\n";

  if ($paysunique != 0) {
  print FOUT "<CENTER>\n";
  print FOUT "<IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$earthmap\" WIDTH=500 HEIGHT=250 BORDER=0 USEMAP=\"#world\"><P>\n";


  print FOUT "<MAP NAME=\"world\">\n";
  for ($i=1;$i<$nbzone;$i++) {
      print FOUT "<AREA SHAPE=\"POLY\" COORDS=\"$string_map{$zone[$i]}\" HREF=\"$zone[$i]$htmlext\">\n" if ($zonehits[$i] ne '');
  }
  print FOUT "<AREA SHAPE=\"POLY\" COORDS=\"1,100,90,142,90,200,1,200\" HREF=\"Oceania.html\">\n" if ($zonehits[$i] ne '');
  print FOUT "</MAP>";

print FOUT "<TABLE BORDER=1 CELLPADDING=0 CELLSPACING=0>\n";
  print FOUT "<TR><TD></TD><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Hits'}&nbsp;</FONT></TH><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Percentage'}&nbsp;</FONT></TH>";
print FOUT "<TH ALIGN=CENTER><FONT SIZE=-1>&nbsp;$L{'HTML_pages'}&nbsp;</FONT></TH><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Percentage'}&nbsp;</FONT></TH>";
print FOUT "<TH ALIGN=CENTER><FONT SIZE=-1>&nbsp;$L{'Hosts'}&nbsp;</FONT></TH><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Percentage'}&nbsp;</FONT>";
print FOUT "<TH ALIGN=CENTER><FONT SIZE=-1>&nbsp;$L{'Traffic'}</FONT></TH><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Percentage'}&nbsp;</FONT></TR>\n";

  for ($i=1;$i<=$nbzone;$i++) {
      print FOUT "<TR><TD><FONT SIZE=-1>";
      print FOUT "<A HREF=\"$zone[$i]$htmlext\">" if ($zonehits[$i] ne '');
      print FOUT "$zone[$i]";
      print FOUT "</A>" if ($zonehits[$i] ne '');
      print FOUT "</FONT>&nbsp;</TD>\n";
      $tmp = ($zonehits[$i]*1000/$reqtot)/10;
      $tmp2 = int($tmp);
      if ($zonehits[$i] eq '') {
	  print FOUT "<TD ALIGN=CENTER><FONT SIZE=-1>-</FONT></TD>";
	  print FOUT "<TD ALIGN=CENTER><FONT SIZE=-1>-</FONT></TD>";
      } else {
      print FOUT "<TD>&nbsp;" if ($tmp2 == 0);
      print FOUT "<TD>&nbsp;<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
      print FOUT "<B><FONT SIZE=-1>$zonehits[$i]</FONT></B>&nbsp;</TD>";
      printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%.1f %</FONT></TD>",$tmp;
  }
      $tmp = ($zonehtml[$i]*1000/$access)/10;
      $tmp2 = int($tmp);
      if ($zonehtml[$i] eq '') {
	  print FOUT "<TD ALIGN=CENTER><FONT SIZE=-1>-</FONT></TD>";
	  print FOUT "<TD ALIGN=CENTER><FONT SIZE=-1>-</FONT></TD>";
      } else {
      print FOUT "<TD>&nbsp;" if ($tmp2 == 0);
      print FOUT "<TD>&nbsp;<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">&nbsp;" if ($tmp2 != 0);
      print FOUT "<B><FONT SIZE=-1>$zonehtml[$i]</FONT></B>&nbsp;</TD>\n";
      printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%.1f %</FONT></TD>",$tmp;
  }
      $tmp = ($zoneserver[$i]*1000/($serverunique+$locserver))/10;
      $tmp2 = int($tmp);
      if ($zoneserver[$i] eq '') {
	  print FOUT "<TD ALIGN=CENTER><FONT SIZE=-1>-</FONT></TD>";
	  print FOUT "<TD ALIGN=CENTER><FONT SIZE=-1>-</FONT></TD>";
      } else {
      print FOUT "<TD>&nbsp;" if ($tmp2 == 0);
      print FOUT "<TD>&nbsp;<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">&nbsp;" if ($tmp2 != 0);
      print FOUT "<B><FONT SIZE=-1>$zoneserver[$i]</FONT></B>&nbsp;</TD>\n";
      printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%.1f %</FONT></TD>",$tmp;
  }
      $tmp = ($zonesize[$i]*1000/($totsize*1024))/10;
      $tmp2 = int($tmp);
      if ($zonesize[$i] eq '') {
	  print FOUT "<TD ALIGN=CENTER><FONT SIZE=-1>-</FONT></TD>";
	  print FOUT "<TD ALIGN=CENTER><FONT SIZE=-1>-</FONT></TD>";
      } else {
      print FOUT "<TD>&nbsp;" if ($tmp2 == 0);
      print FOUT "<TD>&nbsp;<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">&nbsp;" if ($tmp2 != 0);
      printf FOUT "<B><FONT SIZE=-1>%d</FONT></B>&nbsp;</TD>\n",$zonesize[$i];
      printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%.1f %</FONT></TD>",$tmp;
  }
      print FOUT "</TR>\n";
  }


$pourcentvalue = $sizepays{Unknown}*100/($totsize*1024);
$tmp = int($pourcentvalue);

print FOUT "<TR>\n";
print FOUT "<TD><FONT SIZE=-1><A HREF=\"$unresolved\"\>$L{'List_of_unresolved_hosts'}</A></FONT> </TD><TD>&nbsp;";
$tmp2 = int($pourcentpaysunknown);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
print FOUT "<B><FONT SIZE=-1>$payslist{Unknown}</FONT></B></TD>\n";
printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%3.1f %</FONT>",$pourcentpaysunknown;
print FOUT "</TD><TD>&nbsp;";
$tmp2 = int($pourcentpays2unknown);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">&nbsp;" if ($tmp2 != 0);
printf FOUT "<B><FONT SIZE=-1>%d</FONT></B></TD>",$payshtml{Unknown};
printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%3.1f %</FONT>",$pourcentpays2unknown;
print FOUT "</TD><TD>&nbsp;";
$tmpa = $serverpays{Unknown}*100/($serverunique+$locserver) if ($localonly != 1);
$tmpa = $serverpays{Unknown}*100/$locserver if ($localonly == 1);
$tmp2 = int($tmpa);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">&nbsp;" if ($tmp2 != 0);
print FOUT "<B><FONT SIZE=-1>$serverpays{Unknown}</FONT></B>";
print FOUT "</TD>\n";
printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%.1f %</FONT>",$tmpa;
print FOUT "</TD><TD>&nbsp;";        
        
print FOUT "<IMG WIDTH=$tmp HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">&nbsp;" if ($tmp != 0);
printf FOUT "<B><FONT SIZE=-1>%d</FONT></B></TD>",$sizepays{Unknown};
printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%3.1f %</FONT>",$pourcentvalue;
print FOUT "</TD>\n";

print FOUT "</TR></TABLE></CENTER><P>\n";
print FOUT "<P><HR><P>\n";
}

if ($paysunique != 0) {
print FOUT "<I>$L{'The_Top'} $topten $L{'top'} $L{'resolved_countries'} ($L{'among'} $paysunique)</I> :<P><UL>\n";

for ($i=0;$i < $bouclepays;$i++) {
print FOUT "<A HREF=\"$flagpage{$bestpays[$i]}\"\>$L{$newflag{$bestpays[$i]}}</A>  : <B>$occurpays[$i]</B> $L{'times'} (<I>$bestpays[$i]</I>)";
print FOUT " <I>[$L{'domain'} $localdomainename : <B>$reqdomtot</B> $L{'times'}]</I>" if ($locallog == 1 && $bestpays[$i] eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)));
print FOUT "<BR>\n";
}
print FOUT "</UL><P><HR><P>\n";

print FOUT "<P><CENTER>";
print FOUT "<IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"..$dirsepurl..$dirsepurl$dirgraph$dirsepurl$paysgraph\" ALT=\"graph\">\n";
print FOUT "<P><I>$L{'Traffic'} $L{'by'} $L{'countries'} ($L{'percentage'})";
print FOUT "<BR><B>$L{'all_sites'}</B></I>\n<BR><P>";
}

if ($locallog == 1 && $localonly != 1) {
print FOUT "<CENTER><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"..$dirsepurl..$dirsepurl$dirgraph$dirsepurl$paysgraph2\" ALT=\"graph2\"><P>\n";
print FOUT "<P><I>$L{'Traffic'} $L{'by'} $L{'countries'} ($L{'percentage'})";
print FOUT "<BR><B>$L{'excluding'} $localdomainename</B></I>";
}

print FOUT "</CENTER><P><HR><P>\n" if ($paysunique != 0);

print FOUT "<TABLE BORDER=1 WIDTH=100%><TR>\n";
print FOUT "<TH ROWSPAN=2>$L{'Countries'}</TH>\n";
print FOUT "<TH COLSPAN=4>$L{'Hits'}</TH>" if ($locallog == 1 && $localonly == 0);
print FOUT "<TH COLSPAN=2>$L{'Hits'}</TH>" if ($locallog == 0 || $localonly == 1);
print FOUT "<TH COLSPAN=4>$L{'HTML_pages'}</TH>" if ($locallog == 1 && $localonly == 0);
print FOUT "<TH COLSPAN=2>$L{'HTML_pages'}</TH>" if ($locallog == 0 || $localonly == 1);
print FOUT "<TH COLSPAN=2>$L{'Hosts'}</TH>";
print FOUT "<TH COLSPAN=4>$L{'Traffic'} ($L{'Kb'})</TH>" if ($locallog == 1 && $localonly == 0);
print FOUT "<TH COLSPAN=2>$L{'Traffic'} ($L{'Kb'})</TH>" if ($locallog == 0 || $localonly == 1);
print FOUT "</TR><TR>\n";
print FOUT "<TH ALIGN=CENTER>$L{'all_sites'}</TH>";
print FOUT "<TH>%</TH>";
if ($locallog == 1 && $localonly == 0) {
print FOUT "<TH>$L{'excluding'} $localdomainename</TH>";
print FOUT "<TH>%</TH>";
}
print FOUT "<TH ALIGN=CENTER>$L{'all_sites'}</TH>";
print FOUT "<TH>%</TH>";
if ($locallog == 1 && $localonly == 0) {
print FOUT "<TH>$L{'excluding'} $localdomainename</TH>";
print FOUT "<TH>%</TH>";
}
print FOUT "<TH ALIGN=CENTER>$L{'all_sites'}</TH>";
print FOUT "<TH>%</TH>";
print FOUT "<TH ALIGN=CENTER>$L{'all_sites'}</TH>";
print FOUT "<TH>%</TH>";
if ($locallog == 1 && $localonly == 0) {
print FOUT "<TH>$L{'excluding'} $localdomainename</TH>";
print FOUT "<TH>%</TH>";
}
print FOUT "</TR>\n";

for ($i=0;$i <= $paysunique;$i++) {
        next if ($bestpays[$i] eq "Unknown");
        $pays = $bestpays[$i];
        $pourcentvalue = $sizepays{$pays}*100/($totsize*1024);
        $tmp = int($pourcentvalue);

        print FOUT "<TR>\n";
        print FOUT "<TD ALIGN=MIDDLE><A HREF=\"$flagpage{$pays}\"\>";
        print FOUT "$L{$newflag{$pays}}</A>";
        print FOUT "</TD><TD>\n ";
        $tmp2 = int($occurpays2[$i]);
        print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
        print FOUT "<B>$payslist{$pays}</B></TD>";
        printf FOUT "<TD ALIGN=RIGHT>%3.1f",$occurpays2[$i];
        print FOUT "</TD>\n";
        if ($locallog == 1 && $localonly == 0) {
        $tmpb = $payslist{$pays};
        $tmpb -= $reqdomtot if ($locallog == 1 && $pays eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)));;
        $tmpa = $tmpb*100/($reqtot-$reqdomtot) if ($reqtot != $reqdomtot);
        $tmpa = 100 if ($reqtot == $reqdomtot);        
        $tmp2 = int($tmpa);
        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
        printf FOUT "<B>%d</B></td>",$tmpb;
        printf FOUT "<TD ALIGN=RIGHT>%3.1f",$tmpa;
        print FOUT "</TD>\n";
        }


        $tmp2 = int($occurhtml[$i]);
        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">&nbsp;" if ($tmp2 != 0);
        printf FOUT "<B>%d</B></TD>",$payshtml{$pays};
        printf FOUT "<TD ALIGN=RIGHT>%3.1f",$occurhtml[$i];
        print FOUT "</TD>\n";
        if ($locallog == 1 && $localonly == 0) {
        $tmpb = $payshtml{$pays};
        $tmpb -= $payshtmldom if ($locallog == 1 && $pays eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)));;
        $tmpa = $tmpb*100/($access-$payshtmldom) if ($access != $payshtmldom);  
        $tmpa = 100 if ($access == $payshtmldom);
        $tmp2 = int($tmpa);
        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">&nbsp;" if ($tmp2 != 0);
        printf FOUT "<B>%d</B></TD>",$tmpb;
        printf FOUT "<TD ALIGN=RIGHT>%3.1f",$tmpa;        
        print FOUT "</TD>\n"; 
        }

        $tmpa = $serverpays{$pays}*100/($serverunique+$locserver) if ($localonly != 1);
        $tmpa = $serverpays{$pays}*100/$locserver if ($localonly == 1);
        $tmp2 = int($tmpa);
        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">&nbsp;" if ($tmp2 != 0);
        print FOUT "<B>$serverpays{$pays}</B>";
        print FOUT "</TD>\n";
        printf FOUT "<TD ALIGN=RIGHT>%.1f",$tmpa;
        print FOUT "</TD>\n";        

        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">&nbsp;" if ($tmp != 0);
        printf FOUT "<B>%d</B></TD>",$sizepays{$pays};
        printf FOUT "<TD ALIGN=RIGHT>%3.1f",$pourcentvalue;
        print FOUT "</TD>\n";
        if ($locallog == 1 && $localonly == 0) {
        $tmpa = $sizepays{$pays};
        $tmpa -= ($totsize-$externesize)*1024 if ($locallog == 1 && $pays eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)));
        $pourcentvalue = $tmpa*100/($totsize*1024);        
        $tmp = int($pourcentvalue);
        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">&nbsp;" if ($tmp != 0);
        printf FOUT "<B>%d</B></TD>",$tmpa;
        printf FOUT "<TD ALIGN=RIGHT>%3.1f",$pourcentvalue;        
        print FOUT "</TD>\n";
        }
        
        print FOUT "</TR>\n";
}

$pourcentvalue = $sizepays{Unknown}*100/($totsize*1024);
$tmp = int($pourcentvalue);

print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$unresolved\"\>$L{'List_of_unresolved_hosts'}</A> </TD><TD>\n";
$tmp2 = int($pourcentpaysunknown);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
print FOUT "<B>$payslist{Unknown}</B></td>\n";
printf FOUT "<TD ALIGN=RIGHT>%3.1f",$pourcentpaysunknown;
print FOUT "</TD><TD>\n";
if ($locallog == 1 && $localonly == 0) {
$tmpb = $payslist{Unknown};
#$tmpb -= $reqdomtot if ($locallog == 1 && $pays eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)));
$tmpb -= $reqdomtot if ($locallog == 1 && $paysunique == 0);
$tmpa = $tmpb*100/($reqtot-$reqdomtot) if ($reqtot != $reqdomtot);
$tmpa = 100 if ($reqtot == $reqdomtot);
$tmp2 = int($tmpa);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
printf FOUT "<B>%d</B></td>",$tmpb;
printf FOUT "<TD ALIGN=RIGHT>%3.1f",$tmpa;
print FOUT "</TD><TD>\n";
}
                
$tmp2 = int($pourcentpays2unknown);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">&nbsp;" if ($tmp2 != 0);
printf FOUT "<B>%d</B></TD>",$payshtml{Unknown};
printf FOUT "<TD ALIGN=RIGHT>%3.1f",$pourcentpays2unknown;
print FOUT "</TD><TD>\n";
if ($locallog == 1 && $localonly == 0) {
$tmpb = $payshtml{Unknown};
$tmpb -= $payshtmldom if ($locallog == 1 && $paysunique == 0);
$tmpa = $tmpb*100/($access-$payshtmldom) if ($access != $payshtmldom);
$tmpa = 100 if ($access == $payshtmldom);
$tmp2 = int($tmpa);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">&nbsp;" if ($tmp2 != 0);
printf FOUT "<B>%d</B></TD>",$tmpb;
printf FOUT "<TD ALIGN=RIGHT>%3.1f",$tmpa;        
print FOUT "</TD><TD>\n"; 
}


$tmpa = $serverpays{Unknown}*100/($serverunique+$locserver) if ($localonly != 1);
$tmpa = $serverpays{Unknown}*100/$locserver if ($localonly == 1);
$tmp2 = int($tmpa);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">&nbsp;" if ($tmp2 != 0);
print FOUT "<B>$serverpays{Unknown}</B>";
print FOUT "</TD>\n";
printf FOUT "<TD ALIGN=RIGHT>%.1f",$tmpa;
print FOUT "</TD><TD>\n";        
        
print FOUT "<IMG WIDTH=$tmp HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">&nbsp;" if ($tmp != 0);
printf FOUT "<B>%d</B></TD>",$sizepays{Unknown};
printf FOUT "<TD ALIGN=RIGHT>%3.1f",$pourcentvalue;
print FOUT "</TD>\n";
if ($locallog == 1 && $localonly == 0) {
$tmpa = $sizepays{Unknown};
$tmpa -= ($totsize-$externesize)*1024 if ($locallog == 1 && $paysunique == 0);
$pourcentvalue = $tmpa*100/(($totsize-$domsize)*1024) if ($domsize != $totsize);        
$pourcentvalue = 100 if ($domsize == $totsize);        
$tmp = int($pourcentvalue);
print FOUT "<TD>\n";
print FOUT "<IMG WIDTH=$tmp HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">&nbsp;" if ($tmp != 0);
printf FOUT "<B>%d</B></TD>",$tmpa;
printf FOUT "<TD ALIGN=RIGHT>%3.1f",$pourcentvalue;        
print FOUT "</TD>\n";
}

print FOUT "</TR>\n ";
print FOUT "</TABLE>\n";
print FOUT "<P><HR><P>\n";
print FOUT "</BODY></HTML>\n";

}


$sizepays2{Unknown} = $sizepays{Unknown};
foreach $pays (keys(%payslist)) {
$sizepays2{$pays} = $sizepays{$pays};
}

for ($i=0;$i <= $paysunique;$i++) {
$maxi = 0;

foreach $pays (keys(%payslist)) {
$sizesortpays = $sizepays{$pays}/($totsize*1024);
if ($sizesortpays > $maxi) {
         $maxi = $sizesortpays;
         $bestsizepays[$i] = $pays;
         $occursizepays[$i] = $sizesortpays;
#	 print "$i - $bestsizepays[$i] - $sizesortpays\n";
         }
}
$sizepays{$bestsizepays[$i]} = 0;
}

## graphs camenbert

$deg1 = 0;
$deg2 = 0;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
print FLY "frect 0,0,0,0,200,200,200\n";

print FLY "arc $halfxmax,$halfymax,$diam,$diam,0,360,0,0,0\n";

for ($i=0;$i <= $paysunique;$i++) {

$j = $i % ($#gcolor+1);

if (360*$occursizepays[$i] > 1) {

$deg1 = $deg2;
$deg2 += $occursizepays[$i]*360;

# arc
#print FLY "arc $halfxmax,$halfymax,$diam,$diam,$deg1,$degint2,0,0,0\n";

# segment 1
$posx = $halfxmax+(cos($deg1*$piradiant)*$rayon);
$posy = $halfymax+(sin($deg1*$piradiant)*$rayon);
print FLY "line $halfxmax,$halfymax,$posx,$posy,0,0,0\n";

# segment 2
$posx = $halfxmax+(cos($deg2*$piradiant)*$rayon);
$posy = $halfymax+(sin($deg2*$piradiant)*$rayon);
print FLY "line $halfxmax,$halfymax,$posx,$posy,0,0,0\n";

# fill the arc
$deg1 = ($deg1 + $deg2)/2;
$posx = $halfxmax+(cos($deg1*$piradiant)*3*$rayon/4);
$posy = $halfymax+(sin($deg1*$piradiant)*3*$rayon/4);
print FLY "fill $posx,$posy,$red[$j],$green[$j],$blue[$j]\n";

}
}


### completion du camenbert

if (int($deg2) != 360) {
$deg1= int($deg2)-1;
$deg2 = 360;

#print STDERR "Completion du camenbert de $deg1 a $deg2 !\n";

# arc
#print FLY "arc $halfxmax,$halfymax,$diam,$diam,$deg1,$deg2,0,0,0\n";

# segment 1
$posx = $halfxmax+(cos($deg1*$piradiant)*$rayon);
$posy = $halfymax+(sin($deg1*$piradiant)*$rayon);
print FLY "line $halfxmax,$halfymax,$posx,$posy,0,0,0\n";

# segment 2
$posx = $halfxmax+(cos($deg2*$piradiant)*$rayon);
$posy = $halfymax+(sin($deg2*$piradiant)*$rayon);
print FLY "line $halfxmax,$halfymax,$posx,$posy,0,0,0\n";

# fill the arc
$deg1 = ($deg1 + $deg2)/2;
$posx = $halfxmax+(cos($deg1*$piradiant)*3*$rayon/4);
$posy = $halfymax+(sin($deg1*$piradiant)*3*$rayon/4);
print FLY "fill $posx,$posy,0,0,0\n";
}

### print the country name

$deg1 = 0;
$deg2 = 0;

for ($i=0;$i <= $paysunique;$i++) {

#    print "$newflag{$bestsizepays[$i]} - $value\n";

if (100*$occursizepays[$i] > 5) {

$deg1 = $deg2;
$deg2 += $occursizepays[$i]*360;
$deg1 = ($deg1 + $deg2)/2;

$posx = $halfxmax+(cos($deg1*$piradiant)*$rayon/2);
$posy = $halfymax+(sin($deg1*$piradiant)*$rayon/2);

$value = 100*$occursizepays[$i];
$value = int($value)+1 if ($value - int($value) > 0.5);
$value = int($value) if ($value - int($value) <= 0.5);
$posx2 = $posx + $ymax/3 if ($posx > $halfxmax);
$posx2 = $posx - $ymax/3 + length($newflag{$bestsizepays[$i]})*2 if ($posx < $halfxmax);
$posy2 = $posy + 10;
$stringposx = $posx2 + 5 if ($posx > $halfxmax);
$stringposx = 5 if ($posx < $halfxmax);

print FLY "line $posx,$posy,$posx2,$posy2,0,0,0\n";
print FLY "string 0,0,0,$stringposx,$posy,medium,$newflag{$bestsizepays[$i]} $value%\n";
}
}

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$paysgraph |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

###
### deuxieme graph camembert
###

if ($locallog == 1 && $localonly != 1) {

for ($i=0;$i <= $paysunique;$i++) {
$maxi = 0;
foreach $pays (keys(%payslist)) {
    if ($externesize != 0) {
	$sizesortpays = $sizepays2{$pays}/($externesize*1024);
	$sizesortpays = ($sizepays2{$pays}-(($totsize-$externesize)*1024))/($externesize*1024) if ($pays eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)) || $paysunique == 0);
    } else {
	$sizesortpays = 100;
    }
if ($sizesortpays > $maxi) {
         $maxi = $sizesortpays;
         $bestsizepays[$i] = $pays;
         $occursizepays[$i] = $sizesortpays;
         }
}
$sizepays2{$bestsizepays[$i]} = 0;
}

$deg1 = 0;
$deg2 = 0;

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
print FLY "frect 0,0,0,0,200,200,200\n";

print FLY "arc $halfxmax,$halfymax,$diam,$diam,0,360,0,0,0\n";

for ($i=0;$i <= $paysunique;$i++) {

$j = $i % ($#gcolor+1);

if (360*$occursizepays[$i] > 1) {

$deg1 = $deg2;
$deg2 += $occursizepays[$i]*360;

# arc
#print FLY "arc $halfxmax,$halfymax,$diam,$diam,$deg1,$degint2,0,0,0\n";

# segment 1
$posx = $halfxmax+(cos($deg1*$piradiant)*$rayon);
$posy = $halfymax+(sin($deg1*$piradiant)*$rayon);
print FLY "line $halfxmax,$halfymax,$posx,$posy,0,0,0\n";

# segment 2
$posx = $halfxmax+(cos($deg2*$piradiant)*$rayon);
$posy = $halfymax+(sin($deg2*$piradiant)*$rayon);
print FLY "line $halfxmax,$halfymax,$posx,$posy,0,0,0\n";

# fill the arc
$deg1 = ($deg1 + $deg2)/2;
$posx = $halfxmax+(cos($deg1*$piradiant)*3*$rayon/4);
$posy = $halfymax+(sin($deg1*$piradiant)*3*$rayon/4);
print FLY "fill $posx,$posy,$red[$j],$green[$j],$blue[$j]\n";

}
}


### completion du camenbert

if (int($deg2) != 360) {
$deg1= int($deg2)-1;
$deg2 = 360;

#print STDERR "Completion du camenbert de $deg1 a $deg2 !\n";

# arc
#print FLY "arc $halfxmax,$halfymax,$diam,$diam,$deg1,$deg2,0,0,0\n";

# segment 1
$posx = $halfxmax+(cos($deg1*$piradiant)*$rayon);
$posy = $halfymax+(sin($deg1*$piradiant)*$rayon);
print FLY "line $halfxmax,$halfymax,$posx,$posy,0,0,0\n";

# segment 2
$posx = $halfxmax+(cos($deg2*$piradiant)*$rayon);
$posy = $halfymax+(sin($deg2*$piradiant)*$rayon);
print FLY "line $halfxmax,$halfymax,$posx,$posy,0,0,0\n";

# fill the arc
$deg1 = ($deg1 + $deg2)/2;
$posx = $halfxmax+(cos($deg1*$piradiant)*3*$rayon/4);
$posy = $halfymax+(sin($deg1*$piradiant)*3*$rayon/4);
print FLY "fill $posx,$posy,0,0,0\n";
}

### print the country name

$deg1 = 0;
$deg2 = 0;

for ($i=0;$i <= $paysunique;$i++) {

if (100*$occursizepays[$i] > 5) {

$deg1 = $deg2;
$deg2 += $occursizepays[$i]*360;
$deg1 = ($deg1 + $deg2)/2;

$posx = $halfxmax+(cos($deg1*$piradiant)*$rayon/2);
$posy = $halfymax+(sin($deg1*$piradiant)*$rayon/2);

$value = 100*$occursizepays[$i];
$value = int($value)+1 if ($value - int($value) > 0.5);
$value = int($value) if ($value - int($value) <= 0.5);
$posx2 = $posx + $ymax/3 if ($posx > $halfxmax);
$posx2 = $posx - $ymax/3 + length($newflag{$bestsizepays[$i]})*2 if ($posx < $halfxmax);
$posy2 = $posy + 10;
$stringposx = $posx2 + 5 if ($posx > $halfxmax);
$stringposx = 5 if ($posx < $halfxmax);

print FLY "line $posx,$posy,$posx2,$posy2,0,0,0\n";
print FLY "string 0,0,0,$stringposx,$posy,medium,$newflag{$bestsizepays[$i]} $value%\n";
}
}

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$paysgraph2 |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

}


undef($occurpays2); ############ ATTENTION !


### header des fichiers pour chaque pays

foreach $pays (sort keys(%payslist)) {

     if ($flagpage{$pays} eq "") {
         $flagpage{$pays} = "divers-$pays".$htmlext;
         $tmppays = $path.$lang[0].$dirsep.$dirpays.$dirsep.$flagpage{$pays};
         print STDERR "You have to add $pays in the file $paysconv in $pathinit$dirress to match this new country code\n" if (!(-f $tmppays));
     }

     ## ML support

     for ($nblang=0;$nblang<=$#lang;$nblang++) {
         open(FILESITEPAYS,">$path$lang[$nblang]$dirsep$dirpays$dirsep$flagpage{$pays}") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpays$dirsep$flag{$pays}\n";
         &PageHeaderPays(*FILESITEPAYS, eval($Lang{$lang[$nblang]}));
         close (FILESITEPAYS);
     }
}


# pays inconnu

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FILESITEPAYS,">$path$lang[$nblang]$dirsep$dirpays$dirsep$unresolved") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpays$dirsep$unresolved\n";
&PageHeaderPaysUnknow(*FILESITEPAYS, eval($Lang{$lang[$nblang]}));
close (FILESITEPAYS);
}

}


sub PageHeaderPaysUnknow {
  local(*FOUT,*L) = @_;
	print FOUT "<HTML><HEAD>\n";
	print FOUT "<TITLE>$L{'Pages'} $L{'read_by'} $L{'sites'} $L{'unresolved'}</TITLE>\n";
	print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
	print FOUT "</HEAD>\n";
	print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
	print FOUT "<H1>$L{'Pages'} $L{'read_by'} $L{'sites'} $L{'unresolved'}</H1>\n";
	print FOUT "<P><HR><P>\n";
	print FOUT "<i>($L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'requests'} $L{'will_be_printed'})</i><P>\n" unless ($seuilsite == 1 || $seuilsite == 0);

        print FOUT "<P><TABLE BORDER=0 CELLPADDING=1>\n";
        print FOUT "<TR>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Hosts'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Date'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Hits'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Percentage'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'HTML_pages'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Percentage'}&nbsp;</TH>";  
        print FOUT "</TH></TR>\n";
}


sub PageHeaderPays {
  local(*FOUT,*L) = @_;

        print FOUT "<HTML><HEAD>\n";
        print FOUT "<TITLE>$L{'Hosts'} $L{'in'} $L{$newflag{$pays}} </TITLE>\n";
        print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
        print FOUT "</HEAD>\n";
        print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
        print FOUT "<H1>$L{'Hosts'} $L{'in'} $L{$newflag{$pays}}</H1><P>\n";
        print FOUT "<P><HR><P>\n";
        print FOUT "<I>($L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'requests'} $L{'will_be_printed'})</I><P>\n" unless ($seuilsite == 1 || $seuilsite == 0);

#        $tmp = 0;
#        foreach $domadresse (sort keys(%domserver)) {
#        if ($domserver{$domadresse} > $seuilsite) {
#               $pospoint = rindex($domadresse,'.');
#               $extpays = substr($domadresse,$pospoint+1,length($domadresse));
#               next if ($extpays ne $pays);
#               $tmp = 1;
#               }
#        }
                        
        print FOUT "<P><TABLE BORDER=0 CELLPADDING=1>\n";
        print FOUT "<TR>";
#        if ($tmp == 1) {
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Domain'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Date'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Hosts'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Percentage'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Hits'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Percentage'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'HTML_pages'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Percentage'}&nbsp;</TH>";        
#        print FOUT "<TH ALIGN=CENTER>$L{'Requests'}</TH>";
#        print FOUT "<TH ALIGN=CENTER>%</TH>\n";
#        print FOUT "<TH ALIGN=CENTER>$L{'Hosts'}</TH>";
#        print FOUT "<TH ALIGN=CENTER>$L{'Requests'}</TH>";
#        print FOUT "<TH ALIGN=CENTER>%";
#        }
        print FOUT "</TH></TR>\n";
        
}

########################################################
### creation du fichier contenant la liste des sites ###
########################################################

print STDOUT "Creating hosts stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

foreach $serveur (keys(%server)) {
        if ($serveur =~ /[a-z]+$/i) {
        $pospoint = rindex($serveur,'.');
        $newserveur = substr($serveur,0,$pospoint);
        $pospoint = rindex($newserveur,'.');
        $domadresse = substr($serveur,$pospoint+1,length($serveur));
        $nb{$domadresse}++;
        $domserver{$domadresse} += $server{$serveur};
        $domserverhtml{$domadresse} += $nbpageserveur{$serveur};
        $domsites{$domadresse,$nb{$domadresse}} = $serveur;
                }
}

foreach $serveur (keys(%localserver)) {
        $totlocaldomainename += $localserver{$serveur};
        }
        
## ML support

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FILESITE,">$path$lang[$nblang]$dirsep$dirsite$dirsep$filesites") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirsite$dirsep$filesites\n";
&PageSites(*FILESITE, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
close (FILESITE);
}


## printing subroutine

sub PageSites {
  local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Hosts'} $L{'connecting_to_the_server'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'Hosts'} $L{'connecting_to_the_server'} :</H1><P>\n";

if ($localonly != 1) {
print FOUT "<P><HR><P>\n";
print FOUT "<I>$L{'The_Top'} $topten $L{'top_external_sites'} ($L{'among'} $serverunique)</I> :<P><UL>\n";

#if ($precision > 3) {
#print FOUT "<FORM METHOD=\"POST\" ACTION=\"http://$localserver$pathbin$findprg\">";
#print FOUT "Recherche d'un site en particulier , indiquer l'adresse \n";
#print FOUT " complete :<br>\n";
#print FOUT "<INPUT NAME=\"adressedemandee\"><P>\n";
#print FOUT "<Input TYPE=\"submit\" VALUE=\"Envoi\">\n";
#print FOUT "<Input TYPE=\"reset\" VALUE=\"Effacer\">\n";
#print FOUT "</FORM>\n";
#print FOUT "<P><HR><P>\n";
#print FOUTENG "<FORM METHOD=\"POST\" ACTION=\"http://$localserver$pathbin$findprg\">";
#print FOUTENG "Search for a site, give the full address :<br>\n";
#print FOUTENG "<INPUT NAME=\"adressedemandee\"><P>\n";
#print FOUTENG "<Input TYPE=\"submit\" VALUE=\"Send\">\n";
#print FOUTENG "<Input TYPE=\"reset\" VALUE=\"Cancel\">\n";
#print FOUTENG "</FORM>\n";
#print FOUTENG "<P><HR><P>\n";
#}

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";
print FOUT "<TR><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Hosts'}</FONT>&nbsp;</TH><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Requests'}</FONT>&nbsp;</TH><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Percentage'}</FONT>&nbsp;</TH></TR>\n";
for ($i=0;$i < $boucleservers;$i++) {
        $newserveur = $bestserver[$i];
        $newserveur =~ s/[.]/_/g;
        $newserveur = $newserveur.$htmlext;
	$pourcentage = (($occurserver[$i]*1000)/$reqtot)/10;
	$pourcentageint = int($pourcentage);
	print FOUT "<TR><TD>\n";
        if ($newserveur =~ /^[0-9]+/) {

             print FOUT "<A HREF=\"$newserveur\"\>" if ($precision > 3 && $occurserver[$i] > $seuilpage);
             print FOUT "$bestserver[$i]";
             print FOUT "</A> " if ($precision > 3 && $occurserver[$i] > $seuilpage);

            } else {
             $pospoint = index($newserveur,'_',0);
             $domadresse = substr($newserveur,$pospoint+1,(length($newserveur)-length($pospoint)));

             print FOUT "<A HREF=\"$domadresse#$bestserver[$i]\"\>" if ($precision > 3 && $occurserver[$i] > $seuilpage);
             print FOUT "$bestserver[$i]";
             print FOUT "</A> " if ($precision > 3 && $occurserver[$i] > $seuilpage);

        }

        print FOUT "&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$occurserver[$i]</B> ";
#        print FOUT "$L{'request'}" if ($occurserver[$i] == 1);
#        print FOUT "$L{'requests'}" if ($occurserver[$i] != 1);
        print FOUT "&nbsp;</TD><TD ALIGN=LEFT>&nbsp;\n";
	print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($pourcentageint != 0);
	printf FOUT "%.1f ",$pourcentage;
	print FOUT " %</TD></TR>\n";
    }
}

  print FOUT "</TABLE>\n";

if ($locallog != 0 && $locserver != 0) {

print FOUT "</UL><P><HR><P>\n";
print FOUT "<I>$L{'The_Top'} $topten $L{'top_local_sites'} ($L{'among'} $locserver)</I> :<P><UL>\n";

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";
print FOUT "<TR><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Hosts'}</FONT>&nbsp;</TH><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Requests'}</FONT>&nbsp;</TH><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Percentage'}</FONT>&nbsp;</TH></TR>\n";
for ($i=0;$i < $bouclelocservers;$i++) {
        $newserveur = $bestlocserver[$i];
        $newserveur =~ s/[.]/_/g;
        $newserveur = $newserveur.$htmlext;
	$pourcentage = (($occurlocserver[$i]*1000)/$reqdomtot)/10;
	$pourcentageint = int($pourcentage);
	print FOUT "<TR><TD>\n";
        if ($newserveur =~ /[0-9]+$/) {

             print FOUT "<A HREF=\"$newserveur\"\>" if ($precision > 3 && $occurlocserver[$i] > $seuilpage);
             print FOUT "$bestlocserver[$i]";
             print FOUT "</A> " if ($precision > 3 && $occurlocserver[$i] > $seuilpage);

            } else {
             $pospoint = index($newserveur,'_',0);
             $domadresse = substr($newserveur,$pospoint+1,(length($newserveur)-length($pospoint)));

             print FOUT "<A HREF=\"$domadresse#$bestlocserver[$i]\"\>" if ($precision > 3 && $occurlocserver[$i] > $seuilpage);
             print FOUT "$bestlocserver[$i]";
             print FOUT "</A> " if ($precision > 3 && $occurlocserver[$i] > $seuilpage);

        }

        print FOUT "&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$occurlocserver[$i]</B> ";
#        print FOUT "$L{'request'}" if ($occurlocserver[$i] == 1);
#        print FOUT "$L{'requests'}" if ($occurlocserver[$i] != 1);
        print FOUT "&nbsp;</TD><TD ALIGN=LEFT>&nbsp;\n";
	print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($pourcentageint != 0);
	printf FOUT "%.1f ",$pourcentage;
	print FOUT " %</TD></TR>\n";

}

}

print FOUT "</TABLE>\n";
print FOUT "</UL><P><HR><P>\n";


if ($precision > 2) {
print FOUT "<I>$L{'Sorted_countries_list'} $L{'by'} $L{'hosts'}</I> :<P><OL>\n";
print FOUT "<TABLE CELLSPACING=1>\n";
print FOUT "<TR><TH></TH><TH ALIGN=CENTER><I>$L{'Hosts'}</I></TH><TH ALIGN=CENTER>$L{'Requests'}</TH><TH ALIGN=CENTER>$L{'HTML_pages'}</TH><TH ALIGN=CENTER><I>$L{'HTML_pages'} $L{'by'} $L{'host'}</I></TH></TR>\n";

for ($i=0;$i<=$paysunique;$i++) {
$pays = $bestsitepays[$i];

        print FOUT "<TR><TD><LI>";
        print FOUT "<A HREF=\"..$dirsepurl$dirpays$dirsepurl$flagpage{$pays}\"\>";
        print FOUT "$L{$newflag{$pays}}";
        print FOUT "</A> (<I>$pays</I>)&nbsp;</TD>\n";
        print FOUT "<TD ALIGN=CENTER><I>$serverpays{$pays}</I></TD>\n";
#        print FOUT "$L{'host'}" if ($serverpays{$pays} == 1);        
#        print FOUT "$L{'hosts'}" if ($serverpays{$pays} != 1);                
        print FOUT "<TD ALIGN=CENTER><B>$payslist{$pays}</B></TD>\n";
        print FOUT "<TD ALIGN=CENTER><B>$payshtml{$pays}</B></TD>\n";

#        print FOUT "$L{'request'}" if ($payslist{$pays} == 1);
#        print FOUT "$L{'requests'}" if ($payslist{$pays} != 1);
        print FOUT "<TD ALIGN=CENTER><I>";
        $tmp = $payshtml{$pays}/$serverpays{$pays} if ($serverpays{$pays} != 0);
        printf FOUT "%.1f ",$tmp;
#        print FOUT "$L{'request'}" if (int($tmp) == 1);
#        print FOUT "$L{'requests'}" if (int($tmp) != 1);
#        print FOUT " $L{'by'} $L{'host'})";
        print FOUT "</I></TD></TR>\n";
}

print FOUT "</TABLE>\n";
print FOUT "</OL>\n";
}


if ($precision > 2) {

# sites externes

# sites avec DNS

foreach $domadresse (sort keys(%domserver)) {

        if ($domserver{$domadresse} > $seuilsite) {
        
		$newsite = $domadresse;
	        $newsite =~ s/[.]/_/g;
	        $newsite .= $htmlext; 

               $pospoint = rindex($domadresse,'.');
                $extpays = substr($domadresse,$pospoint+1,length($domadresse));
                $pourcentage = 100*$domserver{$domadresse}/$payslist{$extpays};
                $pourcentage2 = 100*$domserverhtml{$domadresse}/$payshtml{$extpays} if ($payshtml{$extpays} != 0);                
                $pourcentage2 = 0 if ($payshtml{$extpays} == 0);                
                $pourcentage3 = 100*$nb{$domadresse}/$serverpays{$extpays};

                open(FILESITEPAYS,">>$path$lang[$nblang]$dirsep$dirpays$dirsep$flagpage{$extpays}") || die "Error, unable to open file $path$lang[$nblang]$dirsep$dirpays$dirsep$flagpage{$extpays}\n";

                print FILESITEPAYS "<TR><TD><B><A HREF=\"..$dirsepurl$dirdomain$dirsepurl$newsite\">$domadresse</A></B></TD>";
                print FILESITEPAYS "<TD ALIGN=CENTER><I>&nbsp;$domaindate{$domadresse}&nbsp;</I></TD>";
                print FILESITEPAYS "<TD>&nbsp;";
		if (int($pourcentage3) != 0) {
		print FILESITEPAYS "<IMG WIDTH=";
                printf FILESITEPAYS "%d",$pourcentage3;
                print FILESITEPAYS " HEIGHT=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">";
		}
		print FILESITEPAYS " $nb{$domadresse}</TD>";
                printf FILESITEPAYS "<TD ALIGN=RIGHT>%3.1f \%",$pourcentage3;
                print FILESITEPAYS "<TD>&nbsp;";
		if (int($pourcentage) != 0) {
		print FILESITEPAYS "<IMG WIDTH=";
                printf FILESITEPAYS "%d",$pourcentage;
                print FILESITEPAYS " HEIGHT=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">";
	    }
		print FILESITEPAYS " $domserver{$domadresse}</TD>";
                printf FILESITEPAYS "<TD ALIGN=RIGHT>%3.1f \%",$pourcentage;
                print FILESITEPAYS "&nbsp;</TD>";
                print FILESITEPAYS "<TD>&nbsp;";
		if (int($pourcentage2) != 0) {
		print FILESITEPAYS "<IMG WIDTH=";
                printf FILESITEPAYS "%d",$pourcentage2;
                print FILESITEPAYS " HEIGHT=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">";
	    }
		print FILESITEPAYS " $domserverhtml{$domadresse}</TD>";
                printf FILESITEPAYS "<TD ALIGN=RIGHT>%3.1f \%",$pourcentage2;
                print FILESITEPAYS "&nbsp;</TD>";                
                print FILESITEPAYS "</TR>\n";

                open(FILESITEPAYSLIST,">$path$lang[$nblang]$dirsep$dirdomain$dirsep$newsite") || die "Error, unable to open file $path$lang[$nblang]$dirsep$dirdomain$dirsep$newsite\n";

        	print FILESITEPAYSLIST "<HTML><HEAD>\n";
        	print FILESITEPAYSLIST "<TITLE>$L{'Hosts'} - $domadresse </TITLE>\n";
        	print FILESITEPAYSLIST "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
        	print FILESITEPAYSLIST "</HEAD>\n";
        	print FILESITEPAYSLIST "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
        	print FILESITEPAYSLIST "<H1>$L{'Hosts'} - $domadresse</H1><P>\n";
        	print FILESITEPAYSLIST "<P><HR><P>\n";
        	print FILESITEPAYSLIST "<I>($L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'requests'} $L{'will_be_printed'})</I><P>\n" unless ($seuilsite == 1 || $seuilsite == 0);
		print FILESITEPAYSLIST "<TABLE CELLSPACING=1>\n";
		print FILESITEPAYSLIST "<TR><TH ALIGN=CENTER>$L{'Hosts'}</TH><TH ALIGN=CENTER>$L{'Requests'}</TH><TH ALIGN=CENTER>$L{'Percentage'}</TH><TH ALIGN=CENTER>$L{'HTML_pages'}</TH><TH ALIGN=CENTER>$L{'Percentage'}</TH></TR>\n";
                                   
                for ($j=1;$j<=$nb{$domadresse};$j++) {          
                if ($server{$domsites{$domadresse,$j}} > $seuilsite) {
                        $newserveur = $domsites{$domadresse,$j};
                        $newserveur =~ s/[.]/_/g;
                        $newserveur = $newserveur.$htmlext;

                        $pospoint = index($newserveur,'_',0);
                        $saveadresse = substr($newserveur,$pospoint+1,(length($newserveur)-length($pospoint)));
                        $pourcentage = 100*$server{$domsites{$domadresse,$j}}/$domserver{$domadresse};
                        $pourcentage2 = 100*$nbpageserveur{$domsites{$domadresse,$j}}/$domserverhtml{$domadresse} if ($domserverhtml{$domadresse} != 0);                        
                        $pourcentage2 = 0 if ($domserverhtml{$domadresse} == 0); 
                                                                       
                        print FILESITEPAYSLIST "<TR><TD>";
                        print FILESITEPAYSLIST "<A HREF=\"..$dirsepurl$dirsite$dirsepurl$saveadresse#$domsites{$domadresse,$j}\"\>"  if ($precision > 3);
                        print FILESITEPAYSLIST "$domsites{$domadresse,$j}";
                        print FILESITEPAYSLIST "</A> " if ($precision > 3);
                        print FILESITEPAYSLIST "</TD><TD>";
			if (int($pourcentage) != 0) {
			print FILESITEPAYSLIST "<IMG WIDTH=";
                        printf FILESITEPAYSLIST "%d",$pourcentage;
                        print FILESITEPAYSLIST " HEIGHT=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">";
		    }
			print FILESITEPAYSLIST " <B>$server{$domsites{$domadresse,$j}}</B>";
                        printf FILESITEPAYSLIST "</TD><TD ALIGN=RIGHT>%3.1f \%",$pourcentage;
                        print FILESITEPAYSLIST "</TD><TD>";
			if (int($pourcentage2) != 0) {
			print FILESITEPAYSLIST "<IMG WIDTH=";
                        printf FILESITEPAYSLIST "%d",$pourcentage2;
                        print FILESITEPAYSLIST " HEIGHT=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">";
		    }
			print FILESITEPAYSLIST " <B>$nbpageserveur{$domsites{$domadresse,$j}}</B>";
                        printf FILESITEPAYSLIST "</TD><TD ALIGN=RIGHT>%3.1f \%",$pourcentage2;                        
                        print FILESITEPAYSLIST "</TD></TR>\n";
                        }        
                }   
        	print FILESITEPAYSLIST "</TABLE><P><HR><P>\n</BODY></HTML>\n";
               close(FILESITEPAYSLIST);
        }
}    


foreach $serveur (sort keys(%server)) {
        if ($serveur =~ /[0-9]+$/ && $server{$serveur} > $seuilsite) {
        
        $newserveur = $serveur;
        $newserveur =~ s/[.]/_/g;
        $newserveur = $newserveur.$htmlext;
        $pourcentage = 100*$server{$serveur}/$payslist{Unknown};
        $pourcentage2 = 100*$nbpageserveur{$serveur}/$payshtml{Unknown};                
        open(FILESITEPAYS,">>$path$lang[$nblang]$dirsep$dirpays$dirsep$unresolved") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpays$dirsep$unresolved\n";
        
        print FILESITEPAYS "<TR><TD>";        
        print FILESITEPAYS "<A HREF=\"..$dirsepurl$dirsite$dirsepurl$newserveur\"\>" if ($precision > 3 && $server{$serveur} > $seuilpage);
        print FILESITEPAYS "<B>$serveur</B>";
        print FILESITEPAYS "</A>" if ($precision > 3 && $server{$serveur} > $seuilpage);
        print FILESITEPAYS "</TD><TD ALIGN=CENTER><I>&nbsp;$domaindate{$serveur}&nbsp;</I></TD>";
        print FILESITEPAYS "<TD>&nbsp;";
	if (int($pourcentage) != 0) {
	print FILESITEPAYS "<IMG WIDTH=";
        printf FILESITEPAYS "%d",$pourcentage;
        print FILESITEPAYS " HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">";
    }
	print FILESITEPAYS " $server{$serveur}</TD>";
        printf FILESITEPAYS "<TD ALIGN=RIGHT>%3.1f \%",$pourcentage;
        print FILESITEPAYS "&nbsp;</TD>";
        print FILESITEPAYS "<TD>&nbsp;";
	if (int($pourcentage2) != 0) {
	print FILESITEPAYS "<IMG WIDTH=";
        printf FILESITEPAYS "%d",$pourcentage2;
        print FILESITEPAYS " HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">";
    }
	print FILESITEPAYS " $nbpageserveur{$serveur}</TD>";
        printf FILESITEPAYS "<TD ALIGN=RIGHT>%3.1f \%",$pourcentage2;
        print FILESITEPAYS "&nbsp;</TD>";                
        print FILESITEPAYS "</TR>\n";        

        close(FILESITEPAYS);
}
}



# sites locaux

if ($locallog != 0 && $totlocaldomainename != 0 && ($localdomainename !~ m/[0-9]+$/i)) {

        $pospoint = rindex($localdomainename,'.');
        $extpays = substr($localdomainename,$pospoint+1,length($localdomainename));
        $tmp = 0;
        
	foreach $serveur (sort keys(%localserver)) {
	$tmp++ if ($localserver{$serveur} > $seuilsite);
	$domserverhtml{$localdomainename} += $nbpageserveur{$serveur};
	}

        open(FILESITEPAYS,">>$path$lang[$nblang]$dirsep$dirpays$dirsep$flagpage{$extpays}") || die "Error, unable to open file $path$lang[$nblang]$dirsep$dirpays$dirsep$flagpage{$extpays}\n";
        
	        $newsite = $localdomainename;        
	        $newsite =~ s/[.]/_/g;
	        $newsite .= $htmlext; 

	        $pourcentage = 100*$totlocaldomainename/$payslist{$extpays};
        	$pourcentage2 = 100*$domserverhtml{$localdomainename}/$payshtml{$extpays} if ($payshtml{$extpays} != 0);
        	$pourcentage2 = 0 if ($payshtml{$extpays} == 0);
        	$pourcentage3 = 100*$tmp/$serverpays{$extpays};
        	                        
                print FILESITEPAYS "<TR><TD><B><A HREF=\"..$dirsepurl$dirdomain$dirsepurl$newsite\">$localdomainename</A></B></TD>";
                print FILESITEPAYS "<TD ALIGN=CENTER><I>&nbsp;$domaindate{$localdomainename}&nbsp;</I></TD>";
                print FILESITEPAYS "<TD>&nbsp;";
	if (int($pourcentage3) != 0) {
	        print FILESITEPAYS "<IMG WIDTH=";
                printf FILESITEPAYS "%d",$pourcentage3;
                print FILESITEPAYS " HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">";
		}
	print FILESITEPAYS " $tmp</TD>";
                printf FILESITEPAYS "<TD ALIGN=RIGHT>%3.1f \%",$pourcentage3;
                print FILESITEPAYS "<TD>&nbsp;";
	if (int($pourcentage) != 0) {
	        print FILESITEPAYS "<IMG WIDTH=";
                printf FILESITEPAYS "%d",$pourcentage;
                print FILESITEPAYS " HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">";
	    }
	        print FILESITEPAYS " $totlocaldomainename</TD>";
                printf FILESITEPAYS "<TD ALIGN=RIGHT>%3.1f \%",$pourcentage;
                print FILESITEPAYS "&nbsp;</TD>";
                print FILESITEPAYS "<TD>&nbsp;";
	if (int($pourcentage2) != 0) {
	        print FILESITEPAYS "<IMG WIDTH=";
                printf FILESITEPAYS "%d",$pourcentage2;
                printf FILESITEPAYS " HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">";
	    }
	        print FILESITEPAYS " $domserverhtml{$localdomainename}</TD>";
                printf FILESITEPAYS "<TD ALIGN=RIGHT>%3.1f \%",$pourcentage2;
                print FILESITEPAYS "&nbsp;</TD>";                
                print FILESITEPAYS "</TR>\n";

close(FILESITEPAYS);


                open(FILESITEPAYSLIST,">$path$lang[$nblang]$dirsep$dirdomain$dirsep$newsite") || die "Error, unable to open file $path$lang[$nblang]$dirsep$dirdomain$dirsep$newsite\n";

        	print FILESITEPAYSLIST "<HTML><HEAD>\n";
        	print FILESITEPAYSLIST "<TITLE>$L{'Hosts'} - $localdomainename </TITLE>\n";
        	print FILESITEPAYSLIST "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
        	print FILESITEPAYSLIST "</HEAD>\n";
        	print FILESITEPAYSLIST "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
        	print FILESITEPAYSLIST "<H1>$L{'Hosts'} - $localdomainename</H1><P>\n";
        	print FILESITEPAYSLIST "<P><HR><P>\n";
        	print FILESITEPAYSLIST "<I>($L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'requests'} $L{'will_be_printed'})</I><P>\n" unless ($seuilsite == 1 || $seuilsite == 0);
		print FILESITEPAYSLIST "<TABLE CELLSPACING=1>\n";
		print FILESITEPAYSLIST "<TR><TH ALIGN=CENTER>$L{'Hosts'}</TH><TH ALIGN=CENTER>$L{'Requests'}</TH><TH ALIGN=CENTER>$L{'Percentage'}</TH><TH ALIGN=CENTER>$L{'HTML_pages'}</TH><TH ALIGN=CENTER>$L{'Percentage'}</TH></TR>\n";                       

foreach $serveur (sort keys(%localserver)) {

        $pourcentage = 100*$localserver{$serveur}/$totlocaldomainename;

        $pourcentage2 = 100*$nbpageserveur{$serveur}/$domserverhtml{$localdomainename} if ($domserverhtml{$localdomainename} != 0);                        
        $pourcentage2 = 0 if ($domserverhtml{$localdomainename} == 0); 
        
        $newsite = $serveur;
        $newsite =~ s/[.]/_/g;
        $newsite = $newsite.$htmlext;

        print FILESITEPAYSLIST "<TR><TD>";
        print FILESITEPAYSLIST "<A HREF=\"..$dirsepurl$dirsite$dirsepurl$newsite#$serveur\"\>"  if ($precision > 3);
        print FILESITEPAYSLIST "<I>$serveur</I>";
        print FILESITEPAYSLIST "</A> " if ($precision > 3);
        print FILESITEPAYSLIST "</TD><TD>";
	if (int($pourcentage) != 0) {
	print FILESITEPAYSLIST "<IMG WIDTH=";
        printf FILESITEPAYSLIST "%d",$pourcentage;
        print FILESITEPAYSLIST " HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">";
    }
	print FILESITEPAYSLIST " <B>$localserver{$serveur}</B>";
        printf FILESITEPAYSLIST "</TD><TD ALIGN=RIGHT>%3.1f \%",$pourcentage;
        print FILESITEPAYSLIST "</TD><TD>";
	if (int($pourcentage2) != 0) {
	print FILESITEPAYSLIST "<IMG WIDTH=";
        printf FILESITEPAYSLIST "%d",$pourcentage2;
        print FILESITEPAYSLIST " HEIGHT=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">";
    }
	print FILESITEPAYSLIST " <B>$nbpageserveur{$serveur}</B>";
        printf FILESITEPAYSLIST "</TD><TD ALIGN=RIGHT>%3.1f \%",$pourcentage2;                        
        print FILESITEPAYSLIST "</TD></TR>\n";
}
        print FILESITEPAYSLIST "</TABLE>\n";
        close(FILESITEPAYSLIST);
}
}

print FOUT "</BODY></HTML>\n";


if ($precision > 2) {
    foreach $pays (keys(%payslist)) {
        open(FILESITEPAYS,">>$path$lang[$nblang]$dirsep$dirpays$dirsep$flagpage{$pays}") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpays$dirsep$flagpage{$pays}\n";
        print FILESITEPAYS "</TABLE><P><HR><P>\n</BODY></HTML>\n";
        close FILESITEPAYS;
    }
}

}

#################################################################
####               scanning the file produced             #######
#################################################################

foreach $url (sort keys(%pageslues)) {
        if ($pageslues{$url} > $seuilpage && $url !~ /\?/) {

# directories stats

$posslash = rindex($url,$dirsepurl,length($url));
$racine = substr($url,0,$posslash+1);

$count{$racine}++;
$newpageslues{$racine,$count{$racine}} = $url;
push(@listracine,$racine) if ($count{$racine} == 1);

$freqracurl{$racine}++;
$leveldepth = 0;
$racine = $url;
$posslash = rindex($racine,$dirsepurl,length($racine));

#print STDERR "$racine\n";

while ($posslash > 1) {
$leveldepth = 1;
$racine = substr($racine,0,$posslash+1); # if ($type_serveur != 1);
$temp2 = $racine;
$temp2 .= $dirsepurl;
$freqracdepth{$temp2}++;

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

     $temp .= $dirsepurl;

#     print STDOUT "temp : $temp racine $racine $leveldepth\n";

     $depthocc{$temp,2} = 1;

     if (!($seen{$temp}++)) {
     $depth{$leveldepth}++;
     $depth{2}++ if ($leveldepth != 2);
     $line{$depth{2}} = $temp if ($leveldepth != 2);
     }

     $depthocc{$temp,$leveldepth}++ unless (($seen{$racine}++) || $leveldepth == 2);
     $line{$depth{$leveldepth}} = $temp if ($leveldepth == 2);
     $depthrac{$temp,$depthocc{$temp,$leveldepth},$leveldepth} = $racine;
     $maxdepth = $leveldepth if ($leveldepth > $maxdepth);
     }

$posslash = rindex($racine,$dirsepurl,length($racine));
$posslash--;
}

}
}

#################################################################
####               scanning holes in tree                 #######
#################################################################

#if ($url_tree == 1) {
for ($j=1;$j<=$depth{2};$j++) {
$temp = $line{$j};
#print STDOUT "\nLine : $temp\n";
for ($leveldepth=$maxdepth;$leveldepth>=3;$leveldepth--) {
#      print STDOUT "Niveau : $leveldepth\n";

      for ($m=0;$m<=$depthocc{$temp,$leveldepth};$m++) {
           $racine = $depthrac{$temp,$m,$leveldepth};
           if ($racine ne '') {
             $match = 0;
             # check si le niveau en dessous existe
             for ($l=0;$l<=$depthocc{$temp,$leveldepth-1};$l++) {
               if ($racine =~ /$depthrac{$temp,$l,$leveldepth-1}/ && $depthrac{$temp,$l,$leveldepth-1} ne '') {
               $match = 1;
               last;
               }
             }

             if ($match == 0) {
               $subleveldepth = $leveldepth;
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

               $subleveldepth--;
               $depthocc{$temp2,$subleveldepth}++ unless (($seen{$remind}++) || $subleveldepth == 2);
               $depthrac{$temp2,$depthocc{$temp2,$subleveldepth},$subleveldepth} = $remind;
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

########################################################
### creation du fichier contenant la liste des pages ###
########################################################

print STDOUT "Creation pages stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# compute the tree

open(TMPTREE,">$path$dirtmp$dirsep$dirtmp") || die "Error, unable to open $path$dirtmp$dirsep$dirtmp\n";
&ComputeTree(*TMPTREE);
close(TMPTREE);

## ML support

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FILEPAGE,">$path$lang[$nblang]$dirsep$dirpage$dirsep$filepages") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpage$dirsep$filepages\n";
&Pages(*FILEPAGE, eval($Lang{$lang[$nblang]}));
close (FILEPAGE);
for ($i=0;$i<=$#listracine;$i++) {
	$tmp = $listracine[$i];
	chop($tmp);
	$tmp = substr($tmp,1,length($tmp));
	$tmp =~ s/\//_/g;
	$tmp = $tmp.$htmlext;
	$tmp = "index_".$htmlext if ($tmp eq $filepages);

#	print "Creating $tmp - $filepages\n";
open(FILEPAGEDIR,">$path$lang[$nblang]$dirsep$dirpage$dirsep$tmp") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirpage$dirsep$tmp\n";
 &PagesDir(*FILEPAGEDIR, eval($Lang{$lang[$nblang]}),$listracine[$i]);
 close (FILEPAGEDIR);
}
}


## printing subroutine

sub Pages {
  local(*FOUT,*L) = @_;

  print FOUT "<HTML><HEAD>\n";
  print FOUT "<TITLE> $L{'Stats'} - $L{'Pages'}</TITLE>\n";
  print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
  print FOUT "</HEAD>\n";
  print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
  print FOUT "<H1> $L{'ListOf'} $L{'pages'} $L{'used'} :</H1><P>\n";
  print FOUT "<P><HR><P>\n";

  print FOUT "<I>$L{'The_Top'} $topten $L{'pages'} ($L{'among'} $pageunique) $L{'MostSuccesf'}</I> :<P><UL>\n";
  
#
  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";
  print FOUT "<TR><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Pages'}</FONT>&nbsp;</TH><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Requests'}</FONT>&nbsp;</TH><TH ALIGN=CENTER>&nbsp;<FONT SIZE=-1>$L{'Percentage'}</FONT>&nbsp;</TH></TR>\n";
  for ($i=0;$i < $bouclepages;$i++) {
      if ($occur[$i] != 0) {
	  $pourcentage = (($occur[$i]*1000)/$access)/10;
	  $pourcentageint = int($pourcentage);
	  print FOUT "<TR><TD ALIGN=LEFT><A HREF=\"$bestpage[$i]\">";
	  print FOUT "$bestpage[$i]" if ($titlename == 0);
	  print FOUT "<b>$urlconv{$bestpage[$i]}</b>" if ($titlename == 1 && $urlconv{$bestpage[$i]} ne '');
	  print FOUT "$bestpage[$i]" if ($titlename == 1 && $urlconv{$bestpage[$i]} eq '');
	  print FOUT "</A>&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$occur[$i]</B>&nbsp;</TD><TD ALIGN=LEFT>&nbsp;\n";
	  print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($pourcentageint != 0);
	  printf FOUT "%.1f ",$pourcentage;
	  print FOUT " %</TD></TR>\n";
      }
  }

  print FOUT "</TABLE></UL><P><HR><P>\n";

  if ($precision > 2 && $#selection > 0) {
      print FOUT " $L{'Send_me_an'} <A HREF=\"mailto:$mailadr\">email</A> $L{'added_pages'}\n<UL>";


      for ($i=0;$i<=($#selection);$i++) {
	  $numero = $i +1;
	  $newpage = "page".$i.$htmlext;
	  $pageslues{$selection[$i]} = 0 unless ($pageslues{$selection[$i]} != '');
	  print FOUT "<LI> Page n.$numero : <A HREF=\"$selection[$i]\"><I>";
	  print FOUT "$selection[$i]" if ($titlename == 0);
	  print FOUT "$urlconv{$selection[$i]}" if ($titlename == 1 && $urlconv{$selection[$i]} ne '');
	  print FOUT "$selection[$i]" if ($titlename == 1 && $urlconv{$selection[$i]} eq '');
	  print FOUT "</I></A> : <B><A HREF=\"$newpage\">$pageslues{$selection[$i]} $L{'times'}</A></B>";
      }
      
      print FOUT "</UL><P><HR><P>\n";
      
  }

  print FOUT "<I>($L{'Only_pages'} $L{'with_at_least'} $seuilpage $L{'requests'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilpage == 1 || $seuilpage == 0);

#

  print FOUT "<I>$L{'Legend_in_bracket'} :</I>\n<UL>\n";
  print FOUT "<LI> $L{'Number_of_HTML_files'} $L{'in_whole_directory'}\n";
  print FOUT "<LI> $L{'Number_of_HTML_files'} $L{'in_this_directory'}\n";
  print FOUT "</UL>\n<P>\n";
  
  print FOUT "<TABLE BORDER=1><TR>\n";
  
  for ($i=0;$i<$maxdepth;$i++) {
      print FOUT "<TH ALIGN=CENTER>$L{'Level'} $i</TH>\n";
  }
  print FOUT "</TR>\n";

# display the tree

  open(TMPTREE,"$path$dirtmp$dirsep$dirtmp") || die "Error, unable to open $path$dirtmp$dirsep$dirtmp\n";
  while (<TMPTREE>) {
      print FOUT;
  }
  close(TMPTREE);
  print FOUT "</TABLE>\n";
  
#

#print FOUT "<TABLE>\n";
#print FOUT "<TR><TH>$L{'Page_read'}</TH><TH>$L{'Total'}</TH><TH>%</TH>\n";
#print FOUT "</TR>\n";

#foreach $page (sort keys(%pageslues)) {
#        if ($pageslues{$page} > $seuilpage) {

#        print FOUT "<TR><TD><A HREF=\"$page\">";
#        print FOUT "$page" if ($titlename == 0);
#        print FOUT "<b>$urlconv{$page}</b>" if ($titlename == 1 && $urlconv{$page} ne '');
#        print FOUT "$page" if ($titlename == 1 && $urlconv{$page} eq '');
#        print FOUT "</A></TD><TD ALIGN=CENTER>";

#        $i=0;
#        $lien=0;
#        if ($precision > 2) {
#            while ($i <= ($#selection)) {
#                 if ($page =~ /^$selection[$i]/) {
#                        $newpage = "page".$i.$htmlext;                 
#                      print FOUT "<B><BLINK><A HREF=\"$newpage\">$pageslues{$page} $L{'times'}</A></B></BLINK>";
#                      $lien=1;
#                      }
#                 $i++;
#                 }
#            }
#        print FOUT "<B>$pageslues{$page}</B> $L{'times'}" unless ($lien == 1);
#        $tmpa = $pageslues{$page}*100/$access;
#        $tmp2 = int($tmpa);

#        print FOUT "</TD><TD ALIGN=CENTER>";
#        printf FOUT "%.1f",$tmpa;
#        print FOUT "</TD></TR>\n";
#        }

#}

#print FOUT "</TABLE>\n";
  print FOUT "<P><HR><P>\n";
  print FOUT "</BODY></HTML>\n";
}

#

sub PagesDir {
  local(*FOUT,*L,$racine) = @_;
  local($i);
  
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE> $L{'Stats'} - $L{'Pages'} - $racine</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> $L{'ListOf'} $L{'pages'} : $racine</H1><P>\n";
print FOUT "<P><HR><P>\n";

#

print FOUT "<I>($L{'Only_pages'} $L{'with_at_least'} $seuilpage $L{'requests'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilpage == 1 || $seuilpage == 0);

print FOUT "<TABLE>\n";
print FOUT "<TR><TH>$L{'Page_read'}</TH><TH>$L{'Total'}</TH><TH>%</TH>\n";
print FOUT "</TR>\n";

for ($j=1;$j<=$count{$racine};$j++) {

$page = $newpageslues{$racine,$j};
        if ($pageslues{$page} > $seuilpage) {        

        print FOUT "<TR><TD><A HREF=\"$page\">";
        print FOUT "$page" if ($titlename == 0);
        print FOUT "<b>$urlconv{$page}</b>" if ($titlename == 1 && $urlconv{$page} ne '');
        print FOUT "$page" if ($titlename == 1 && $urlconv{$page} eq '');
        print FOUT "</A></TD><TD ALIGN=CENTER>";

        $i=0;
        $lien=0;
        if ($precision > 2) {
            while ($i <= ($#selection)) {
                 if ($page =~ /^$selection[$i]/) {
                        $newpage = "page".$i.$htmlext;                 
                      print FOUT "<B><BLINK><A HREF=\"$newpage\">$pageslues{$page} $L{'times'}</A></B></BLINK>";
                      $lien=1;
                      }
                 $i++;
                 }
            }
        print FOUT "<B>$pageslues{$page}</B> $L{'times'}" unless ($lien == 1);
        $tmpa = $pageslues{$page}*100/$access;
        $tmp2 = int($tmpa);

        print FOUT "</TD><TD ALIGN=CENTER>";
        printf FOUT "%.1f",$tmpa;
        print FOUT "</TD></TR>\n";
        }

}

print FOUT "</TABLE>\n";
print FOUT "<P><HR><P>\n";
print FOUT "</BODY></HTML>\n";
}

#

sub ComputeTree {
	local(*FOUT) = @_;
	
print FOUT "<TR>\n<TD ROWSPAN=$maxrowspan>$dirsepurl</TD>\n";

for ($j=1;$j<=$depth{2};$j++) {
$temp = $line{$j};
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

        $freqracdepth{$racine} = 0 if ($freqracdepth{$racine} eq '');
        $freqracurl{$racine} = 0 if ($freqracurl{$racine} eq '');
        
        if ($freqracurl{$racine} != 0) {
	$tmp = $racine;
	chop($tmp);
	$tmp = substr($tmp,1,length($tmp));
	$tmp =~ s/\//_/g;
	$tmp = $tmp.$htmlext;
	$tmp = "index_".$htmlext if ($tmp eq $filepages);

        print FOUT "<A HREF=\"$tmp\">";
	}
	
        print FOUT "$remind";
        print FOUT "</A>" if ($freqracurl{$racine} != 0);

        print FOUT "<BR><I>[$freqracdepth{$racine} - ";
        print FOUT "$freqracurl{$racine}";
        print FOUT "]</I>";
        }

        print FOUT "</TD>\n";

        if ($value != 1 && $value !=0) {
            &row_end(*FOUT,*L,$temp,$value,$racine,$value,$i,1);
            }
        }
      }

    print FOUT "</TR>\n\n";
    }
}


if ($precision < 3)
{
exit;
}


##############################################################
### creation du fichier contenant la liste des repertoires ###
##############################################################

print STDOUT "Creating directories stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#$tmp2 = 0;
#$pos = length($tri);
#while (($pos = rindex($tri,$dirsepurl,$pos)) >= 0) {
#        $tmp2++;
#        $pos--;
#        }
#$tmp2--;

## ML support

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FILEREPERT,">$path$lang[$nblang]$dirsep$dirlist$dirsep$filerepert") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirlist$dirsep$filerepert\n";
&PagesRepert(*FILEREPERT, eval($Lang{$lang[$nblang]}));
close (FILEREPERT);
}


## printing subroutine

sub PagesRepert {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - $L{'Directories'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";


print FOUT "<H1> $L{'ListOf'} $L{'directories'} $L{'used2'} :</H1><P>\n";
print FOUT "<P><HR><P>\n";


if (($nbdays > 13) && ($#selecrepert != -1)) {

#if (-x $FLY)  {
print FOUT "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG  WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkfilerepy\"></TD>\n";
print FOUT "<TD><IMG  WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkfilerep\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG  WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkfilerepx\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "<TR><TD></TD>\n";
print FOUT "<TD ALIGN=CENTER>\n";

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";
for ($i=$#selecrepert;$i>=0;$i--) {
        $j = $i % ($#gcolor);
        $couleur = $gcolor[$j];

        $selecrepertbis[$i] = "dir".$i.$htmlext;

        print FOUT "<TR><TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$couleur\"></TD>\n";
        print FOUT "<TD>&nbsp; $L{'directory'} : <B>";
        print FOUT "<A HREF=\"$selecrepertbis[$i]\">";
        print FOUT "$selecrepert[$i]";
        print FOUT "</A>";
        print FOUT "</B></TD></TR>\n";
        }
print FOUT "</TABLE>\n";

print FOUT "</TD></TR>\n";        
print FOUT "</TABLE></CENTER><P>\n";

#}
}

if ($#selecrepert != -1) {

print FOUT "<CENTER><TABLE WIDTH=100% BORDER=1><TR>\n";
print FOUT "<TH ROWSPAN=2>$L{'Directories'}</TH>\n";
print FOUT "<TH COLSPAN=2>$L{'Requests'}</TH>\n";
print FOUT "<TH COLSPAN=6>$L{'HTML_accesses'} </TH>\n";
print FOUT "<TH COLSPAN=6>$L{'Traffic'} ($L{'Mb'})</TH>\n";
print FOUT "</TR><TR>\n";

print FOUT "<TH ALIGN=CENTER>$L{'total'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'total'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'external'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'local'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'total'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'external'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'local'}</TH>\n";
print FOUT "<TH>%</TH>\n";

print FOUT "</TR><TR>\n";

for ($i=0;$i<=($#selecrepert);$i++) {

     print FOUT "<TR>\n<TD>";
     print FOUT "<A HREF=\"$selecrepertbis[$i]\">" unless ($nbdays < 14);
     print FOUT "<I>$selecrepert[$i]</I>";
     print FOUT "</A>" unless ($nbdays < 14);

     $p = 100*$freqrac{$selecrepert[$i]}/$reqtot;

     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     print FOUT "$freqrac{$selecrepert[$i]}";
     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",$p;

     $p = 100*$freqrachtml{$selecrepert[$i]}/$access;

     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     print FOUT "$freqrachtml{$selecrepert[$i]}";
     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",$p;

     $p1 = 100*$freqrachtmldom{$selecrepert[$i]}/$reqtot;
     $p2 = $p - $p1;
     $value2 = $freqrachtml{$selecrepert[$i]} - $freqrachtmldom{$selecrepert[$i]};

     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     print FOUT "$value2";
     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",$p2;

     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     print FOUT "$freqrachtmldom{$selecrepert[$i]}";
     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",$p1;

     $p = 100*$freqtotsize{$selecrepert[$i]}/(1024*1024*$totsize);

     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",($freqtotsize{$selecrepert[$i]}/(1024*1024));
     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",$p;

     $p = 100*$freqextsize{$selecrepert[$i]}/(1024*1024*$totsize);

     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",($freqextsize{$selecrepert[$i]}/(1024*1024));
     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",$p;

     $p = 100*$freqdomsize{$selecrepert[$i]}/(1024*1024*$totsize);

     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",($freqdomsize{$selecrepert[$i]}/(1024*1024));
     print FOUT "</TD>\n<TD ALIGN=RIGHT>";
     printf FOUT "%.1f",$p;

     print FOUT "</TD></TR>\n";
     }
print FOUT "</TABLE></CENTER>\n";
}

print FOUT "<P><i>($L{'Only_directories'} $L{'with_at_least'} $seuilrepert $L{'requests'} $L{'will_be_printed'})</i><P>\n" unless ($seuilrepert == 0);

print FOUT "<CENTER><TABLE WIDTH=100% BORDER=1><TR>\n";
print FOUT "<TH ROWSPAN=2>$L{'Directories'}</TH>\n";
print FOUT "<TH COLSPAN=4>$L{'Requests'}</TH>\n";
print FOUT "<TH COLSPAN=4>$L{'HTML_accesses'} </TH>\n";
print FOUT "<TH COLSPAN=4>$L{'Traffic'} ($L{'Mb'})</TH>\n";
print FOUT "</TR><TR>\n";

print FOUT "<TH ALIGN=CENTER>$L{'internal'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'global'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'internal'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'global'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'internal'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'global'}</TH>\n";
print FOUT "<TH>%</TH>\n";
print FOUT "</TR><TR>\n";

foreach $racine (sort keys(%freqrac)) {

$tmp = 0;
$pos = length($racine);
while (($pos = rindex($racine,$dirsepurl,$pos)) >= 0) {
        $tmp++;
        $pos--;
        }

$tmp -= $tmptri;
        
if ($freqrac{$racine} > $seuilrepert) {
     print FOUT "<TR>\n<TD ";
#     print FOUT "BGCOLOR=\"#F0F0F0\"" if ($tmp == 3);
     print FOUT "BGCOLOR=\"#D0D0D0\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#909090\"" if ($tmp == 1);     
     print FOUT "><I><A HREF=\"$racine\">$racine</A></I></TD>\n";

     $p = 100*$freqrac{$racine}/$reqtot;
     $p2 = 100*$freq2rac{$racine}/$reqtot;
     
     print FOUT "<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#DDDD00\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#999900\"" if ($tmp == 1);
     print FOUT ">$freq2rac{$racine}";     
     print FOUT "</TD>\n<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#DDDD00\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#999900\"" if ($tmp == 1);
     printf FOUT ">%.1f %",$p2;     
     print FOUT "</TD>\n";

     print FOUT "<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#DDDD00\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#999900\"" if ($tmp == 1);
     print FOUT ">$freqrac{$racine}";
     print FOUT "</TD>\n<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#DDDD00\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#999900\"" if ($tmp == 1);
     printf FOUT ">%.1f %",$p;
     print FOUT "</TD>\n";
          
     $p = 100*$freqrachtml{$racine}/$access;
     $p2 = 100*$freq2rachtml{$racine}/$access;     
     
     print FOUT "<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#00DDDD\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#009999\"" if ($tmp == 1);
     print FOUT ">$freq2rachtml{$racine}";     
     print FOUT "</TD>\n<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#00DDDD\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#009999\"" if ($tmp == 1);
     printf FOUT ">%.1f %",$p2;     
     print FOUT "</TD>\n";
     print FOUT "<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#00DDDD\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#009999\"" if ($tmp == 1);
     print FOUT ">$freqrachtml{$racine}";
     print FOUT "</TD>\n<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#00DDDD\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#009999\"" if ($tmp == 1);
     printf FOUT ">%.1f %",$p;
     print FOUT "</TD>\n";
          
     $p = 100*$freqtotsize{$racine}/(1024*1024*$totsize);
     $p2 = 100*$freq2totsize{$racine}/(1024*1024*$totsize);     
     
     print FOUT "<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#00DD00\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#009900\"" if ($tmp == 1);     
     printf FOUT ">%.2f",($freq2totsize{$racine}/(1024*1024));
     print FOUT "</TD>\n<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#00DD00\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#009900\"" if ($tmp == 1);     
     printf FOUT ">%.1f %",$p2;     
     print FOUT "</TD>\n";

     print FOUT "<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#00DD00\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#009900\"" if ($tmp == 1);
     printf FOUT ">%.2f",($freqtotsize{$racine}/(1024*1024));
     print FOUT "</TD>\n<TD ALIGN=RIGHT ";
     print FOUT "BGCOLOR=\"#00DD00\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#009900\"" if ($tmp == 1);     
     printf FOUT ">%.1f %",$p;
          
     print FOUT "</TD></TR>\n";
}

}


print FOUT "</TABLE></CENTER>\n";
print FOUT "</BODY></HTML>\n";
}

##############################################################
###                  virtual host stats                    ###
##############################################################

if ($virtualunique != 0) {
print STDOUT "Creating virtual hosts stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

## ML support

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FILEVIRTUAL,">$path$lang[$nblang]$dirsep$dirlist$dirsep$filevirtual") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirlist$dirsep$filevirtual\n";
&PagesVirtual(*FILEVIRTUAL, eval($Lang{$lang[$nblang]}));
close (FILEVIRTUAL);
}
}

## 

sub PagesVirtual {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_virtual_servers'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H1> $L{'Stats_about_virtual_servers'} : </H1><P>\n";
print FOUT "<P><HR><P>\n";

print FOUT "<I>$L{'Sorted_virtual_server_list'} $L{'by'} $L{'requests'}</I> :<P><UL>\n";
print FOUT "<TABLE CELLSPACING=1><TR>\n";
print FOUT "<TH ALIGN=CENTER>$L{'Virtual_servers'}</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'Requests'}</TH>\n";
print FOUT "<TH ALIGN=CENTER>%</TH>\n";
print FOUT "<TH ALIGN=CENTER>$L{'Traffic'} ($L{'Mb'})</TH>\n";
print FOUT "<TH ALIGN=CENTER>%</TH></TR>\n";

for ($i=0;$i<$virtualunique;$i++) {
$vserver = $bestvirtual[$i];
$tmp = $dirsepurl.$vserver.$dirsepurl;

print FOUT "<TR><TD><LI> $vserver&nbsp;</TD><TD ALIGN=CENTER>&nbsp;<B>$virtual{$vserver}</B> ";
print FOUT "&nbsp;</TD>\n";

$p = 100*$virtual{$vserver}/$reqtot;

printf FOUT "</TD>\n<TD ALIGN=RIGHT><I>%.1f %</I>",$p;

if ($virtualCLF == 1) {
$p = 100*$freqtotsize{$tmp}/(1024*1024*$totsize);
printf FOUT "<TD ALIGN=CENTER><B>%.2f </B>",($freqtotsize{$tmp}/(1024*1024));
} else {
$p = 100*$virtualsize{$vserver}/(1024*1024*$totsize);
printf FOUT "<TD ALIGN=CENTER><B>%.2f </B>",($virtualsize{$vserver}/(1024*1024));
}

printf FOUT "</TD>\n<TD ALIGN=RIGHT><I>%.1f %</I>",$p;
print FOUT "&nbsp;</TD></TR>\n";

}

print FOUT "</TABLE>\n";
print FOUT "</UL>\n";
print FOUT "<P><HR><P></BODY></HTML>\n";
}

#################################################################
###                    day summary                            ###
#################################################################

sub PageResumeFrame {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $oldjour - Frame</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";

  print FOUT "<FRAMESET COLS=\"35%,*\" FRAMESPACING=0 BORDER=false FRAMEBORDER=0>\n";
  print FOUT "<FRAME SCROLLING=\"auto\" MARGINHEIGHT=0 MARGINWIDTH=0 NAME=\"left\" SRC=\"menu.html\">\n";
  print FOUT "<FRAME SCROLLING=\"auto\" MARGINHEIGHT=0 MARGINWIDTH=0 NAME=\"right\" SRC=\"$filemoyenne\">\n";
  print FOUT "</FRAMESET>\n";

  print FOUT "<NOFRAMES>\n";


print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";

  print FOUT "</NOFRAMES>\n";
  print FOUT "</HTML>\n";
}

###

sub PageResumeTab {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $oldjour - $L{'Summary'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

#print FOUT "<CENTER><TABLE WIDTH=100%><TR>\n";

#$tmp = $oldjour;
#$tmp =~ s/\// /g;

#print FOUT "<TD ALIGN=CENTER><H3>$L{'Stats'} $tmp</H3></TD>\n";
#print FOUT "</TR></TABLE></CENTER>\n";

print FOUT "<P><BR>\n";

print FOUT "<CENTER><TABLE BORDER=1 CELLPADDING=2><TR>";
print FOUT "<TD><I>$L{'Requests'}</I></TD><TD ALIGN=CENTER BGCOLOR=\"#00FFFF\">$reqtotjour</TD>\n";
print FOUT "<TD><I>$L{'Hosts'}</I></TD><TD ALIGN=CENTER>$serveruniquejour</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD><I>$L{'HTML_pages'}</I></TD><TD ALIGN=CENTER BGCOLOR=\"#00FF00\">$accessjour</TD>\n"; 
print FOUT "<TD><I>$L{'New_Hosts'}</I></TD><TD ALIGN=CENTER>$newhost</TD>\n";
print FOUT "</TR><TR>\n";
$tmp = int(($totsizejour/1024)*10)/10;
$tmp2 = int(($tmp/1024)*10)/10 if ($tmp >= 1024);
print FOUT "<TD><I>$L{'Total_traffic'}</I></TD><TD ALIGN=CENTER BGCOLOR=\"#CCCCCC\">";
print FOUT "$tmp $L{'Kb'}</TD>" if ($tmp < 1024);
print FOUT "$tmp2 $L{'Mb'}</TD>\n" if ($tmp >= 1024);
print FOUT "<TD><I>$L{'Countries'}</I></TD><TD ALIGN=CENTER>$paysuniquejour</TD>\n";
print FOUT "</TR><TR>\n";
$tmp = int(($tothtmlsizejour/1024)*10)/10;
$tmp2 = int(($tmp/1024)*10)/10 if ($tmp >= 1024);
print FOUT "<TD><I>$L{'Traffic'} $L{'HTML_pages'}</I></TD><TD ALIGN=CENTER>";
print FOUT "$tmp $L{'Kb'}</TD>\n" if ($tmp < 1024);
print FOUT "$tmp2 $L{'Mb'}</TD>\n" if ($tmp >= 1024);
print FOUT "<TD><I>$L{'New_country'}</I></TD><TD ALIGN=CENTER>$paysjournew</TD>\n";
print FOUT "</TR></TABLE>\n";

if ($locallog == 1 || $localonly == 1) {

print FOUT "<P><BR>";

print FOUT "<TABLE BORDER=1><TR>";
print FOUT "<TD COLSPAN=2><I>$L{'Domain'}</I> : $localdomainename</TD>\n";
print FOUT "</TR><TR>";
print FOUT "<TD><I>$L{'Requests'}</I></TD><TD ALIGN=CENTER>$domreq</TD></TR><TR>\n";
print FOUT "<TD><I>$L{'Hosts'}</I></TD><TD ALIGN=CENTER>$locserverjour</TD></TR><TR>\n";
$tmp = int((($domsize-$domsize2)/1024)*10)/10;
$tmp2 = int(($tmp/1024)*10)/10 if ($tmp >= 1024);
print FOUT "<TD><I>$L{'Traffic'}</I></TD><TD ALIGN=CENTER>";
print FOUT "$tmp $L{'Kb'}</TD>\n" if ($tmp < 1024);
print FOUT "$tmp2 $L{'Mb'}</TD>\n" if ($tmp >= 1024);
#print FOUT "<TD><I>$L{'Traffic'}</I></TD><TD ALIGN=CENTER>",(int(($domsize-$domsize2)/1024))," $L{'Kb'}</TD>\n";
print FOUT "</TR></TABLE>\n";

}

print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

###

sub PageResumeMenu {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $oldjour</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

$tmp = $oldjour;
$tmp =~ s/\// /g;

($tmp1,$tmp2,$tmp3) = split(/ /,$jour);
$nextdayresume = "\.\.$dirsepurl".$tmp3."-".$tmp2."-".$tmp1."$dirsepurl$menu";

($tmp1,$tmp2,$tmp3) = split(/ /,$oldoldjour);
$previousdayresume = "\.\.$dirsepurl".$tmp3."-".$tmp2."-".$tmp1."$dirsepurl$menu";

print FOUT "<CENTER>\n";
print FOUT "<FONT SIZE=+1><B>$L{'Stats'} $tmp</B></FONT>\n";
print FOUT "<P><TABLE CELLPADDING=2><TR>\n";
print FOUT "<TD ALIGN=RIGHT>";
print FOUT "<A HREF=\"$previousdayresume\" TARGET=\"display\"><!-- PREVIOUS \"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_flecheg\" WIDTH=20 HEIGHT=14 BORDER=0>--></A>" if ($tmp3 ne '');
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$filemoyenne\" TARGET=\"right\">- $L{'Summary'} -</A></TD>\n";
print FOUT "<TD ALIGN=LEFT><A HREF=\"$nextdayresume\" TARGET=\"display\"><!-- NEXT \"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_fleched\" WIDTH=20 HEIGHT=14 BORDER=0>--></A></TD>\n";
print FOUT "</TR></TABLE></CENTER>\n";

print FOUT "<P>\n";

### Countries, Directories

print FOUT "<CENTER><TABLE BORDER=0 WIDTH=100%>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirpays$htmlext\" TARGET=\"right\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_countries\" BORDER=0></A></TD>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirlist$htmlext\" TARGET=\"right\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_dir\" BORDER=0></A></TD>\n";

print FOUT "</TR><TR>";

print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirpays$htmlext\" TARGET=\"right\"><FONT SIZE=+1>$L{'Countries'}</FONT></A></TD>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirlist$htmlext\" TARGET=\"right\"><FONT SIZE=+1>$L{'Directories'}</FONT></A></TD>\n";

print FOUT "</TR><TR>";

### Hosts, Pages

print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirsite$htmlext\" TARGET=\"right\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_hosts\" BORDER=0></A></TD>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirpage$htmlext\" TARGET=\"right\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_pages\" BORDER=0></A></TD>\n";

print FOUT "</TR><TR>\n";

print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirsite$htmlext\" TARGET=\"right\"><FONT SIZE=+1>$L{'Hosts'}</FONT></A></TD>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirpage$htmlext\" TARGET=\"right\"><FONT SIZE=+1>$L{'Pages'}</FONT></A></TD>\n";

print FOUT "</TR><TR>\n";


### Scripts, Filetype

print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirscript$htmlext\" TARGET=\"right\"><IMG WIDTH=33 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_script\" BORDER=0></A></TD>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$filetype$htmlext\" TARGET=\"right\"><IMG WIDTH=36 HEIGHT=28 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_filetype\" BORDER=0></A></TD>\n";

print FOUT "</TR><TR>\n";

print FOUT "<TD ALIGN=CENTER><A HREF=\"$dirscript$htmlext\" TARGET=\"right\"><FONT SIZE=+1>$L{'Scripts'}</FONT></A></TD>\n";
print FOUT "<TD ALIGN=CENTER><A HREF=\"$filetype$htmlext\" TARGET=\"right\"><FONT SIZE=+1>$L{'Filetype'}</FONT></A></TD>\n";

print FOUT "</TR><TR>\n";

### Refer, Agent

print FOUT "<TD ALIGN=CENTER>";

if (-e "$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$refer") {
print FOUT "<A HREF=\"$refer\" TARGET=\"right\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_refer\" BORDER=0></A>\n";
} else {
print FOUT "<A HREF=\"$refer\" TARGET=\"right\"><!-- REFER \"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_refer\" WIDTH=34 HEIGHT=34 BORDER=0>--></A>\n";
}

print FOUT "</TD><TD ALIGN=CENTER>";
if (-e "$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$agent") {
print FOUT "<A HREF=\"$agent\" TARGET=\"right\"><IMG SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_agent\" WIDTH=37 HEIGHT=39 BORDER=0></A>\n";
} else {
print FOUT "<A HREF=\"$agent\" TARGET=\"right\"><!-- AGENT \"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_agent\" WIDTH=37 HEIGHT=39 BORDER=0>--></A>\n";
}
print FOUT "</TD></TR><TR>\n";
print FOUT "<TD ALIGN=CENTER>";

if (-e "$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$refer") {
print FOUT "<A HREF=\"$refer\" TARGET=\"right\"><FONT SIZE=+1>$L{'Referer'}</FONT></A>\n";
} else {
print FOUT "<A HREF=\"$refer\" TARGET=\"right\"><FONT SIZE=+1><!-- REFER2 $L{'Referer'} --></FONT></A>\n";
}
print FOUT "</TD><TD ALIGN=CENTER>";
if (-e "$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$agent") {
print FOUT "<A HREF=\"$agent\" TARGET=\"right\"><FONT SIZE=+1>$L{'Browsers'}</FONT></A>\n";
} else {
print FOUT "<A HREF=\"$agent\" TARGET=\"right\"><FONT SIZE=+1><!-- AGENT2 $L{'Browsers'} --></FONT></A>\n";
}

print FOUT "</TD></TR><TR>\n";

### Days, Moyenne

print FOUT "<TD ALIGN=CENTER>";

print FOUT "<A HREF=\"..$dirsepurl$tabnamedays\" TARGET=\"display\"><IMG WIDTH=75 HEIGHT=42 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_days\" BORDER=0></A>\n";

print FOUT "</TD><TD ALIGN=CENTER>";

$linkjour = "..".$dirsepurl."..".$dirsepurl.$dirsession.$dirsep.$filemoyenne;
$fulljour = $path.$lang[$nblang].$dirsep.$dirsession.$dirsep.$filemoyenne;

if (-e $fulljour) {
print FOUT "<A HREF=\"$linkjour\" TARGET=\"display\"><IMG SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_duree\" WIDTH=34 HEIGHT=34 ALT=\"$L{'Average'}\" BORDER=0></A>\n";
} else {
print FOUT "<A HREF=\"$linkjour\" TARGET=\"right\"><!-- AVERAGE \"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_duree\" WIDTH=34 HEIGHT=34 BORDER=0>--></A>\n";
}


print FOUT "</TD></TR><TR>\n";
print FOUT "<TD ALIGN=CENTER>";

print FOUT "<A HREF=\"..$dirsepurl$tabnamedays\" TARGET=\"display\"><FONT SIZE=+1>$L{'Days'}</FONT></A>";

print FOUT "</TD><TD ALIGN=CENTER>";

if (-e $fulljour) {
print FOUT "<A HREF=\"$linkjour\" TARGET=\"display\"><FONT SIZE=+1>$L{'Average'}</FONT></A>\n";
} else {
print FOUT "<A HREF=\"$linkjour\" TARGET=\"display\"><FONT SIZE=+1><!-- AVERAGE2 $L{'Average'} --></FONT></A>\n";
}


print FOUT "</TD></TR><TR>\n";

### Hours, Session

print FOUT "<TD ALIGN=CENTER>";

($tmp,$monthletter) = split(/ /,$yesterday);

$linkjour = $filenamehour;
$fulljour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume.$dirsep.$filenamehour;

if (-e $fulljour) {
print FOUT "<A HREF=\"$linkjour\" TARGET=\"right\"><IMG WIDTH=26 HEIGHT=29 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_hours\" BORDER=0></A>\n";
} else {
print FOUT "<A HREF=\"$linkjour\" TARGET=\"right\"><!-- HOUR \"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_hours\" WIDTH=26 HEIGHT=29 BORDER=0>--></A>\n";
}

print FOUT "</TD><TD ALIGN=CENTER>";

if (-e "$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirsession$htmlext") {
print FOUT "<A HREF=\"$dirsession$htmlext\" TARGET=\"right\"><IMG WIDTH=38 HEIGHT=39 SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_session\" BORDER=0></A>\n";
} else {
print FOUT "<A HREF=\"$dirsession$htmlext\" TARGET=\"right\"><!-- SESSION \"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_session\" WIDTH=38 HEIGHT=39 BORDER=0>--></A>\n";
}

print FOUT "</TD></TR><TR>\n";
print FOUT "<TD ALIGN=CENTER>";

if (-e $fulljour) {
print FOUT "<A HREF=\"$linkjour\" TARGET=\"right\"><FONT SIZE=+1>$L{'Hours'}</FONT></A>\n";
} else {
print FOUT "<A HREF=\"$linkjour\" TARGET=\"right\"><FONT SIZE=+1><!-- HOUR2 $L{'Hours'} --></FONT></A>\n";
}

print FOUT "</TD><TD ALIGN=CENTER>";

if (-e "$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$dirsession$htmlext") {
print FOUT "<A HREF=\"$dirsession$htmlext\" TARGET=\"right\"><FONT SIZE=+1>$L{'Sessions'}</FONT></A>\n";
} else {
print FOUT "<A HREF=\"$dirsession$htmlext\" TARGET=\"right\"><FONT SIZE=+1><!-- SESSION2 $L{'Sessions'} --></FONT></A>\n";
}

print FOUT "</TD></TR></TABLE></CENTER>\n";
print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

###

sub PageResumePays {
  local(*FOUT,*L) = @_;
  local ($pays);

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Countries'} - $oldjour</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'Countries'} $L{'connecting_to_the_server'} :</H3><P>\n";

print FOUT "<I>$L{'The_Top'} $topten $L{'top'} $L{'resolved_countries'} ($L{'among'} $paysuniquejour)</I> :<P>\n";

#print FOUT "<I>($L{'Only_countries'} $L{'with_at_least'} $seuilsite $L{'requests'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilsite == 1 || $seuilsite == 0);

print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Countries'}</TH><TH ALIGN=CENTER>$L{'Requests'}</TH><TH ALIGN=CENTER>$L{'Percentage'}</TH><TH ALIGN=CENTER>$L{'Hosts'}</TH><TH ALIGN=CENTER>$L{'Percentage'}</TH></TR>\n";


#for ($i=0;$i<$topten;$i++) {
##$pays = $paysuniquejourlist[$i];
#$pays = $bestpaysjour[$i];
##if ($paysjour{$pays} > $seuilsite) {
#print FOUT "<TR><TD>$L{$newflag{$pays}}</TD><TD ALIGN=CENTER>$paysjour{$pays}</TD><TD ALIGN=CENTER>$paysjourlist{$pays}</TD></TR>\n"; 
##}
#}

###
#for ($i=0;$i<$paysuniquejour;$i++) {
$tmp = 0;
  $i = 0;
#for ($i=0;$i <$topten;$i++) {
while ($tmp < $topten && $bestpaysjour[$i] != 0) {

#if ($bestpaysjour[$i] != 0) {

for ($j=1;$j<= $countpays[$bestpaysjour[$i]];$j++) {
$tmp++;
last if ($tmp > $topten);
$pays = $occur_counterpays{$bestpaysjour[$i],$j};
$percentage = $paysjour{$pays}*100/$reqtotjour;
$percentageint = int($percentage);
print FOUT "<TR><TD>$L{$newflag{$pays}}</TD><TD ALIGN=CENTER>$paysjour{$pays}</TD><TD ALIGN=LEFT>";
print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
printf FOUT "%.1f %</TD>\n",$percentage;
$percentage = $paysjourlist{$pays}*100/$serveruniquejour;
$percentageint = int($percentage);
print FOUT "<TD ALIGN=CENTER>$paysjourlist{$pays}</TD><TD ALIGN=LEFT>\n"; 
print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
printf FOUT "%.1f %</TD></TR>\n",$percentage;
}
$i += $countpays[$bestpaysjour[$i]];



#}
}
###

print FOUT "</TR></TABLE></CENTER>\n";
print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

####

sub PageResumeHosts {
  local(*FOUT,*L) = @_;
  local($adresse);

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Hosts'} - $oldjour</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'Hosts'} $L{'connecting_to_the_server'} :</H3><P>\n";

print FOUT "<I>$L{'The_Top'} $topten $L{'top_external_sites'} ($L{'among'} $serveruniquejour)</I> :<P>\n";
#print FOUT "<P><I>($L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'requests'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilsite == 1 || $seuilsite == 0);

print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Hosts'}</TH><TH ALIGN=CENTER>$L{'Requests'}</TH><TH>$L{'Percentage'}</TH></TR>";
##for ($i=0;$i<$serveruniquejour;$i++) {

$tmp = 0;
  $i = 0;
while ($tmp < $topten && $bestserverjour[$i] != 0) {
#for ($i=0;$i <$topten;$i++) {
#if ($bestpagesluesday[$i] > $seuilpage) {
#if ($bestserverjour[$i] != 0) {
for ($j=1;$j<= $countserver[$bestserverjour[$i]];$j++) {
$tmp++;
last if ($tmp > $topten);
$adresse = $occur_counterserver{$bestserverjour[$i],$j};
$percentage = $bestserverjour[$i]*100/$reqtotjour;
$percentageint = int($percentage);
print FOUT "<TR><TD>$adresse</TD><TD ALIGN=CENTER>$bestserverjour[$i]</TD><TD ALIGN=LEFT>\n";
print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
printf FOUT "%.1f %</TD></TR>\n",$percentage;
}
$i += $countserver[$bestserverjour[$i]];

#}
}

print FOUT "</TR></TABLE></CENTER>\n";
print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}


####

sub PageResumeDir {
  local(*FOUT,*L) = @_;
  local($rootrepert);
print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Directories'} - $oldjour</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'ListOf'} $L{'directories'} $L{'used2'} :</H3><P>\n";

print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Directories'}</TH><TH ALIGN=CENTER>$L{'HTML_pages'}</TH><TH ALIGN=CENTER>$L{'Traffic'} HTML</TH>";

for ($i=0;$i<=$topten;$i++) {
#$rootrepert = $selecrepert[$i];
$rootrepert = $bestselecrepert[$i];

if ($freqjourrachtml{$rootrepert} ne '') {

$tmp = 0;
$pos = length($rootrepert);
while (($pos = rindex($rootrepert,$dirsepurl,$pos)) >= 0) {
        $tmp++;
        $pos--;
        }
$tmp -= $tmptri;

print FOUT "<TR><TD \n";
print FOUT "BGCOLOR=\"#E7E7E7\"" if ($tmp == 4);
print FOUT "BGCOLOR=\"#C4C4C4\"" if ($tmp == 3);
print FOUT "BGCOLOR=\"#909090\"" if ($tmp == 2);     
print FOUT ">$rootrepert</TD><TD ALIGN=CENTER>$freqjourrachtml{$rootrepert}</TD>";
$tmp = int($sizejourrachtml{$rootrepert}/1024);
print FOUT "<TD ALIGN=CENTER>$tmp $L{'Kb'}</TD></TR>";
}

#print FOUT "$extsize{$rootrepert} $domsize{$rootrepert} \t ";
#print FOUT "$sizejourrachtmlext{$rootrepert} $sizejourrachtmldom{$rootrepert}</TD></TR>";
}

print FOUT "</TR></TABLE></CENTER>\n";
print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

####

sub PageResumePage {
  local(*FOUT,*L) = @_;
  local($page);

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Pages'} - $oldjour</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'ListOf'} $L{'pages'} $L{'used'} :</H3><P>\n";

print FOUT "<I>$L{'The_Top'} $topten $L{'pages'} ($L{'among'} $pageuniquejour) $L{'MostSuccesf'}</I> :<P>\n";

#print FOUT "<I>($L{'Only_pages'} $L{'with_at_least'} $seuilpage $L{'occurence'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilpage == 1 || $seuilpage == 0);

print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Pages'}</TH><TH ALIGN=CENTER>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";
#foreach $page (sort keys(%pagesluesday)) {
$tmp = 0;
$i = 0;
#for ($i=0;$i <$pageuniquejour;$i++) {
#for ($i=0;$i <$topten;$i++) {

while ($tmp < $topten && $bestpagesluesday[$i] != 0) {
#if ($bestpagesluesday[$i] > $seuilpage) {
#if ($bestpagesluesday[$i] != 0) {

for ($j=1;$j<= $countpage[$bestpagesluesday[$i]];$j++) {
$tmp++;
last if ($tmp > $topten);
$page = $occur_counterpage{$bestpagesluesday[$i],$j};
$percentage = $bestpagesluesday[$i]*100/$accessjour;
$percentageint = int($percentage);
print FOUT "<TR><TD>";
print FOUT "$page" if ($titlename == 0);
print FOUT "$urlconv{$page}" if ($titlename == 1 && $urlconv{$page} ne '');
print FOUT "$page" if ($titlename == 1 && $urlconv{$page} eq '');
#print FOUT "</TD><TD ALIGN=CENTER>$pagesluesday{$page}</TD></TR>";
print FOUT "</TD><TD ALIGN=CENTER>$bestpagesluesday[$i]</TD><TD ALIGN=LEFT>";

print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
printf FOUT "%.1f %</TD></TR>\n",$percentage;
}
$i += $countpage[$bestpagesluesday[$i]];

#}
}
#}
print FOUT "</TR></TABLE></CENTER>\n";

print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

####

sub PageResumeScript {
  local(*FOUT,*L) = @_;
  local($page);

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Script'} - $oldjour</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'ListOf'} $L{'scripts'} $L{'used'} :</H3><P>\n";

  if ($scriptuniquejour != 0) {

print FOUT "<I>$L{'The_Top'} $topten $L{'scripts'} ($L{'among'} $scriptuniquejour) $L{'MostSuccesf'}</I> :<P>\n";

print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Pages'}</TH><TH ALIGN=CENTER>$L{'Occurence'}</TH>\n";
$tmp = 0;
$i = 0;

while ($tmp < $topten && $bestscriptday[$i] != 0) {

for ($j=1;$j<= $countscript[$bestscriptday[$i]];$j++) {
$tmp++;
last if ($tmp > $topten);
$page = $occur_counterscript{$bestscriptday[$i],$j};
print FOUT "<TR><TD>";
print FOUT "$page" if ($titlename == 0);
print FOUT "$urlconv{$page}" if ($titlename == 1 && $urlconv{$page} ne '');
print FOUT "$page" if ($titlename == 1 && $urlconv{$page} eq '');
print FOUT "</TD><TD ALIGN=CENTER>$bestscriptday[$i]</TD></TR>";
}
$i += $countscript[$bestscriptday[$i]];

}
print FOUT "</TR></TABLE></CENTER>\n";
} else {
  print FOUT "<I>$L{'No_request'}</I>\n";
}

print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

####

sub PageResumeFiletype {
  local(*FOUT,*L) = @_;
  local($page);

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Filetype'} - $oldjour</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'Filetype'} :</H3><P>\n";
print FOUT "<P>\n";

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH>$L{'File'}</TH><TH ALIGN=CENTER>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";


for ($l=1;$l<=$nbzonefile;$l++) {

    $k = $filetypejourmax[$l];
    next if ($zoneextjour[$k] == 0 || $k == 0);

    $percentage = $zoneextjour[$k]*100/($reqtotjour-$accessjour);
    $percentageint = int($percentage);
    print FOUT "<TR><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>$zonefile[$k]</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=RIGHT>$zoneextjour[$k] $L{'times'}</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>";
    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($percentageint != 0);
    printf FOUT "%.1f %</TH></TR>\n",$percentage;

    for ($i=0;$i<=$#listext;$i++) {
	next if ($listext[$k] =~ /$extension/);
	if ($k == $extfilenb{$listext[$i]}) {
	    $tmp2 = 0;
	    for ($j=1;$j<=$maxdownloadjourlength;$j++) {
		$tmp2 += $downloadjour{$listext[$i],$j};
	    }
	    if ($tmp2 != 0) {
	    $percentage = $tmp2*100/$zoneextjour[$k];
	    $percentageint = int($percentage);
	    print FOUT "<TR><TD ALIGN=LEFT>$extfile{$listext[$i]} ($listext[$i])</TD><TD ALIGN=RIGHT>$tmp2 $L{'times'}</TD><TD ALIGN=LEFT>\n";
	    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
	    printf FOUT "%.1f %</TD></TR>\n",$percentage;
	}
	}
    }
}
print FOUT "</TABLE>\n";

print FOUT "<P>\n";

print FOUT "</BODY></HTML>\n";
}

##############################################################
###  creation du fichier pour les stats sur le download    ###
##############################################################

if ($precision > 2) {
print STDOUT "Creating download stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

## ML support

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FILEDOWNLOAD,">$path$lang[$nblang]$dirsep$dirlist$dirsep$dirdownload$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirlist$dirsep$dirdownload$htmlext\n";
&Download(*FILEDOWNLOAD, eval($Lang{$lang[$nblang]}));
close (FILEDOWNLOAD);
}
}

## 

sub Download {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - $L{'Download'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";


print FOUT "<H1> $L{'Download'} :</H1><P>\n";
print FOUT "<P><HR><P>\n";

print FOUT "<I>($L{'Only_pages'} $L{'with_at_least'} $seuilpage $L{'requests'} $L{'occurence'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilpage == 1 || $seuilpage == 0);

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH>$L{'File'}</TH><TH>&nbsp;</TH><TH>$L{'Traffic'}</TH><TH>$L{'Percentage'}</TH><TH>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";

for ($i=0;$i<=$#listext;$i++) {
$tmp2 = 0;
for ($j=1;$j<=$maxdownloadlength;$j++) {
$tmp2 += $download{$listext[$i],$j};
}
next if ($tmp2 < $seuilpage);
$tmp3 = $downloadsizeext{$listext[$i]}/(1024*1024);
$pourcentage = ($tmp3*100)/$totsize;
$pourcentageint = int($pourcentage);
print FOUT "<TR><TH ALIGN=LEFT BGCOLOR=\"#C4C4C4\">";
print FOUT "$extfile{$listext[$i]}" if ($extfile{$listext[$i]} ne '');
print FOUT "$listext[$i]" if ($extfile{$listext[$i]} eq '');
print FOUT "</TH><TH BGCOLOR=\"#C4C4C4\">&nbsp;</TH><TH ALIGN=LEFT BGCOLOR=\"#C4C4C4\">";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if (int($pourcentage) != 0);
printf FOUT "%.2f",$tmp3;
print FOUT " $L{'Mb'}</TH>";

print FOUT "<TH ALIGN=RIGHT BGCOLOR=\"#C4C4C4\">";
printf FOUT "%.1f ",$pourcentage;
$pourcentage = ($tmp2*100)/$reqtot;
$pourcentageint = int($pourcentage);
print FOUT " %</TH><TH ALIGN=LEFT BGCOLOR=\"#C4C4C4\">";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if (int($pourcentage) != 0);
print FOUT "$tmp2</TH><TH ALIGN=RIGHT BGCOLOR=\"#C4C4C4\">";
printf FOUT "%.1f ",$pourcentage;
print FOUT "%</TH></TR>\n";

for ($j=1;$j<=$maxdownloadlength;$j++) {

print FOUT "<TR><TD>&nbsp;</TD>";

#print "A - $downloadsize{$listext[$i],$j}\n";
#$downloadsize{$listext[$i],$j} = $downloadsize{$listext[$i],$j}/(1024*1024);
$tmp = 10**($j-1);
$tmp1 = 10**$j;
#print "B - $downloadsize{$listext[$i],$j}\n";

print FOUT "<TD>$tmp - $tmp1 $L{'bytes'}</TD>" if ($tmp1 <= 1000);
if ($tmp1 > 1000 && $tmp1 <= 1000000) {
$tmp = int($tmp/1000);
$tmp1 = int($tmp1/1000);
print FOUT "<TD>$tmp - $tmp1 $L{'Kb'}</TD>"; 
}
if ($tmp1 > 1000000) {
$tmp = int($tmp/1000000);
$tmp1 = int($tmp1/1000000);
print FOUT "<TD>$tmp - $tmp1 $L{'Mb'}</TD>";
}

if ($download{$listext[$i],$j} != 0) {
$tmp = $downloadsize{$listext[$i],$j}/(1024*1024);
$pourcentage = ($tmp*100)/$tmp3 if (int($tmp3) != 0);
$pourcentage = 0 if (int($tmp3) == 0);
$pourcentageint = int($pourcentage);
print FOUT "<TD>";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if (int($pourcentage) != 0);
printf FOUT "%.2f",$tmp;
print FOUT " $L{'Mb'}</TD><TD ALIGN=RIGHT>";
printf FOUT "%.1f ",$pourcentage;
print FOUT "%</TD><TD>";

#$pourcentage = ($tmp*100)/$tmp2;
$pourcentage = ($download{$listext[$i],$j}*100)/$tmp2;
$pourcentageint = int($pourcentage);
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if (int($pourcentage) != 0);
print FOUT "$download{$listext[$i],$j}</TD><TD ALIGN=RIGHT>";
printf FOUT "%.1f ",$pourcentage;
print FOUT "%</TD>\n";
} else {
print FOUT "<TD ALIGN=CENTER>-</TD><TD ALIGN=CENTER>-</TD><TD ALIGN=CENTER>-</TD><TD ALIGN=CENTER>-</TD>\n";
}
print FOUT "</TR>\n";
}
}

print FOUT "</TABLE>\n";
print FOUT "<P><HR><P></BODY></HTML>\n";
}


##############################################################
###  creation du fichier pour les stats sur les filetypes  ###
##############################################################

if ($precision > 2) {
print STDOUT "Creating filetype stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#

$tmp3 =  $reqtot-$access;

# Tri des filetypes

foreach $tmp (sort (keys(%filetype))) {
    push(@countertype,$filetype{$tmp}) unless $seen{"$tmp $filetype{$tmp}"}++;
    $counttype[$filetype{$tmp}]++;
    $occur_countertype{$filetype{$tmp},$counttype[$filetype{$tmp}]} = $tmp;
}

@besttype = reverse sort bynumber @countertype;

# Cumule des filetypes

for ($k=0;$k<=$#listext;$k++) {

#    print "A - $listext[$k]\n";
    next if ($listext[$k] =~ /$extension/);
    $listextbis[$k] = $listext[$k];

#    print "A - $download{$listext[$k],$j}\n";
    $tmp2 = 0;
    for ($j=1;$j<=$maxdownloadlength;$j++) {
	$tmp2 += $download{$listext[$k],$j};
    }

#    print "B - $tmp2 - $extfilenb{$listext[$k]}\n";
    $zoneext[$extfilenb{$listext[$k]}] += $tmp2;


}

# Tri des tetes de filetype 

  for ($j=0;$j<=$#listext;$j++) {

      next if ($listext[$j] =~ /$extension/);
      $max = 0;
      for ($i=1;$i<=$maxdownloadlength;$i++) {
	  $max += $download{$listextbis[$j],$i};
      }
      for ($k=0;$k<=$#listext;$k++) {

	  next if ($listext[$k] =~ /$extension/);
	  $max2 = 0;
	  for ($i=1;$i<=$maxdownloadlength;$i++) {
	      $max2 += $download{$listextbis[$k],$i};
	  }
	  if ($max2 > $max) {
	      $max = $max2;
	      $filetypelistmax[$j] = $k;
	  }
      }
#      $listextbis[$k] = '';
      $listextbis[$filetypelistmax[$j]] = '';

  }

# Tri des zones de filetype

for ($k=1;$k<=$nbzonefile;$k++) {
    $zoneextbis[$k] = $zoneext[$k];
}

  for ($j=1;$j<=$nbzonefile;$j++) {
      $max = $zoneextbis[$j];
      $filetypemax[$j] = 0;
      for ($k=1;$k<=$nbzonefile;$k++) {
	  if ($zoneextbis[$k] > $max) {
	      $max = $zoneextbis[$k];
	      $filetypemax[$j] = $k;
	  }
      }
#      $zoneextbis[$k] = 0;
      $zoneextbis[$filetypemax[$j]] = 0;
      
  }


## ML support

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FILETYPE,">$path$lang[$nblang]$dirsep$dirlist$dirsep$filetype$htmlext") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirlist$dirsep$filetype$htmlext\n";
&Filetype(*FILETYPE, eval($Lang{$lang[$nblang]}));
close (FILETYPE);
}
}

## 

sub Filetype {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - $L{'Filetype'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";


print FOUT "<H1> $L{'Filetype'} :</H1><P>\n";
print FOUT "<P><HR><P>\n";

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH>$L{'File'}</TH><TH ALIGN=CENTER>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";


for ($l=1;$l<=$nbzonefile;$l++) {

    $k = $filetypemax[$l];
    next if ($zoneext[$k] == 0 || $k == 0);

    $percentage = $zoneext[$k]*100/$tmp3;
    $percentageint = int($percentage);
    print FOUT "<TR><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>$zonefile[$k]</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=RIGHT>$zoneext[$k] $L{'times'}</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>";
    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($percentageint != 0);
    printf FOUT "%.1f %</TH></TR>\n",$percentage;

    for ($i=0;$i<=$#listext;$i++) {
#	      $filetypelistmax[$j] = $k;
	next if ($listext[$k] =~ /$extension/);
#	if ($filetypelistmax[$i] == $extfilenb{$listext[$i]}) {
	if ($k == $extfilenb{$listext[$i]}) {
	    $tmp2 = 0;
	    for ($j=1;$j<=$maxdownloadlength;$j++) {
		$tmp2 += $download{$listext[$i],$j};
	    }
	    $percentage = $tmp2*100/$zoneext[$k];
	    $percentageint = int($percentage);
	    print FOUT "<TR><TD ALIGN=LEFT>$extfile{$listext[$i]} ($listext[$i])</TD><TD ALIGN=RIGHT>$tmp2 $L{'times'}</TD><TD ALIGN=LEFT>\n";
	    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
	    printf FOUT "%.1f %</TD></TR>\n",$percentage;
	}
    }
}
print FOUT "</TABLE>\n";

print FOUT "<P>\n";

print FOUT "<I>($L{'Only_files'} $L{'with_at_least'} $seuilpage $L{'requests'} $L{'occurence'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilpage == 1 || $seuilpage == 0);


print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH>$L{'File'}</TH><TH ALIGN=CENTER>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";

for ($l=0;$l<=$#listext;$l++) {

    $k = $filetypelistmax[$l];

    next if ($listext[$k] =~ /$extension/);
    $tmp2 = 0;
    for ($j=1;$j<=$maxdownloadlength;$j++) {
	$tmp2 += $download{$listext[$k],$j};
    }

    if ($tmp2 > $seuilpage) {

    $percentage = $tmp2*100/$tmp3;
    $percentageint = int($percentage);
    print FOUT "<TR><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>";
    print FOUT "$extfile{$listext[$k]}" if ($extfile{$listext[$k]} ne '');
    print FOUT "<I>Unknown</I> ($listext[$k])" if ($extfile{$listext[$k]} eq '');
    print FOUT "</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=RIGHT>$tmp2 $L{'times'}</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>";
    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($percentageint != 0);
    printf FOUT "%.1f %</TH></TR>\n",$percentage;

    $i=0;
    $tmp = 0;
    while ($tmp < $topten && $besttype[$i] != 0) {
	for ($j=1;$j<= $counttype[$besttype[$i]];$j++) {
	    $page = $occur_countertype{$besttype[$i],$j};
	    
	    $tmp1 = substr($page,rindex($page,'.'));
	    $tmp1 =~ tr/[A-Z]/[a-z]/;
	    $tmp1 =~ s/\#.*$//;

	    if ($tmp1 eq $listext[$k]) {
		$tmp++;
		last if ($tmp > $topten);
		$percentage = $besttype[$i]*100/$tmp2;
		$percentageint = int($percentage);
		print FOUT "<TR>";
		print FOUT "<TD>$page</TD>\n";
                print FOUT "<TD ALIGN=RIGHT>$besttype[$i] $L{'times'}</TD><TD>\n";
		print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
                printf FOUT "%.1f %</TD>\n",$percentage;
		print FOUT "</TR>\n";
	    }
	    
	}
	$i += $counttype[$besttype[$i]];
    }
 }      
}

print FOUT "</TABLE>\n";
print FOUT "<P><HR><P></BODY></HTML>\n";
}

##############################################################
###    creation du fichier pour les stats sur les scripts  ###
##############################################################

if ($inc_script == 1) {
print STDOUT "Creating scripts stats\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

## ML support

for ($nblang=0;$nblang<=$#lang;$nblang++) {
open(FILESCRIPT,">$path$lang[$nblang]$dirsep$dirscript$dirsep$filescript") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirscript$dirsep$filescript\n";
&PagesScripts(*FILESCRIPT, eval($Lang{$lang[$nblang]}));
close (FILESCRIPT);
}
}

## 

sub PagesScripts {
  local(*FOUT,*L) = @_;

  print FOUT "<HTML><HEAD>\n";
  print FOUT "<TITLE>$L{'Stats'} - $L{'Scripts'}</TITLE>\n";
  print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
  print FOUT "</HEAD>\n";
  print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
  
  print FOUT "<H1> $L{'ListOf'} $L{'scripts'} $L{'used2'} :</H1><P>\n";
  print FOUT "<P><HR><P>\n";

  $allscript = 0;
  foreach $val (keys (%method)) {
      $allscript += $method{$val};
  }

  print FOUT "$L{'Total_number_of_scripts'} : $allscript<P><UL>\n";
  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";
  foreach $val (keys (%method)) {
      $pourcentage = (($method{$val}*1000)/$allscript)/10;
      $pourcentageint = int($pourcentage);
      print FOUT "<TD ALIGN=LEFT><LI> $L{'Method'} $val&nbsp;</TD>";
      print FOUT "<TD ALIGN=RIGHT>&nbsp;<B>$method{$val}</B> $L{'times'}&nbsp;</TD><TD ALIGN=LEFT>&nbsp;\n";
      print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($pourcentageint != 0);
      printf FOUT "%.1f ",$pourcentage;
      print FOUT " %</TD></TR>\n";
  }
  print FOUT "</TABLE>\n";

  print FOUT "</UL>\n";

  if ($scriptunique != 0) {

  print FOUT "<P><HR><P>\n";
  print FOUT "<I>$L{'The_Top'} $topten $L{'scripts'} ($L{'among'} $scriptunique) $L{'MostSuccesf'}</I> :<P><UL>\n";
  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";  
  for ($i=0;$i < $bouclescript;$i++) {
      if ($occurscript[$i] != 0) {
	  
	  $scriptparam = "script".$i.$htmlext;
	  print FOUT "<TR><TD><LI> ";
	  print FOUT "<A HREF=\"$scriptparam\">" if ($argunique{$bestscript[$i]} ne '');
	  print FOUT "$bestscript[$i]";
	  print FOUT "</A>" if ($argunique{$bestscript[$i]} ne '');
	  print FOUT "&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$occurscript[$i]</B> $L{'times'}</TD></TR>\n";
	  
	  if ($argunique{$bestscript[$i]} ne '') {
	      open(SCRIPTPARAM,">$path$lang[$nblang]$dirsep$dirscript$dirsep$scriptparam") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirscript$dirsep$scriptparam\n";
	      &ScriptsParam(*SCRIPTPARAM, eval($Lang{$lang[$nblang]}),$bestscript[$i]);
	      close(SCRIPTPARAM);
	  }	  
      }
  }
  print FOUT "</TABLE>\n";
  print FOUT "</UL><P><HR><P>\n";
  print FOUT "<I>($L{'Only_scripts'} $L{'with_at_least'} $seuilscript $L{'requests'} $L{'will_be_printed'})</I><P>\n" unless ($seuilscript == 1 || $seuilscript == 0);

  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";
  foreach $val (sort keys(%script)) {
      print FOUT "<TR><TD>$val&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$script{$val}</B> $L{'times'}</TD></TR>\n" if ($script{$val} > $seuilscript);
  }
  print FOUT "</TABLE>\n";
  }
  print FOUT "<P><HR><P></BODY></HTML>\n";
}

## 

sub ScriptsParam {
  local(*FOUT,*L,$script) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - $L{'Scripts'} : $script</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-pages.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

$tmp = substr($script,rindex($script,$dirsepurl,length($script))+1,length($script));

print FOUT "<H1> $L{'Scripts'} : $tmp</H1><P>\n";
print FOUT "<P><HR><P>\n";

print FOUT "<TABLE BORDER=1><TR>\n";

$pourcentage = (($occurscript[$i]*1000)/$allscript)/10;
$pourcentageint = int($pourcentage);
print FOUT "<TH COLSPAN=2>$script</TD><TD ALIGN=LEFT>";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($pourcentageint != 0);
printf FOUT "%.1f ",$pourcentage;
print FOUT " %</TD><TD><B>$occurscript[$i]</B> $L{'times'}</TD></TR>\n";

for ($j=1;$j<=$argunique{$script};$j++) {
$tmp = $scriptdata{$script,$j};
print FOUT "<TR><TD VALIGN=TOP ROWSPAN=$nameunique{$script,$tmp}>$tmp</TD>";
for ($k=1;$k<=$nameunique{$script,$tmp};$k++) {
print FOUT "<TR>\n" if ($k != 1);
print FOUT "<TD><I>";
print FOUT "$countargval{$script,$tmp,$k}" if ($countargval{$script,$tmp,$k} ne '');
print FOUT "&nbsp;" if ($countargval{$script,$tmp,$k} eq '');
$pourcentage = (($countarg{$script,$tmp,$countargval{$script,$tmp,$k}}*1000)/$occurscript[$i])/10;
$pourcentageint = int($pourcentage);

print FOUT "</I></TD><TD ALIGN=LEFT>";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($pourcentageint != 0);
printf FOUT "%.1f ",$pourcentage;
print FOUT " %</TD><TD ALIGN=RIGHT><B>$countarg{$script,$tmp,$countargval{$script,$tmp,$k}}</B> $L{'times'}</TD>\n";
print FOUT "</TR>\n";
}
}

print FOUT "</TABLE>\n";

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

print STDOUT "Computing took $min min $sec sec\n\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

if ($debug == 1) {
    close(CPUTIME);
}

open(FILE,">>$history");
printf FILE "cron-pages\t%s\t%s\t%s\t%d:%d\t%d\n",$today,$startrun,$endrun,$min,$sec,$loglines;
close(FILE);

__END__

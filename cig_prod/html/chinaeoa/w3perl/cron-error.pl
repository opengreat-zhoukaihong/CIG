#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                     ERROR STATS                                #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@w3perl.com                   version 20/08/2000     #####
####                                                                #####
#########################################################################

$version = "2.72";
$verdate = "20/08/00";

#### verifier que le jour suivant est bien +1 (pas de trou)

############ script a lancer a XX heures 01 minutes ##########

## valeur a modifier avec fixperlpath.pl

require "/usr/local/etc/w3perl/cgi-bin/w3perl//libw3perl.pl";

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";
print "Error stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

### afficher la liste des refer (cern) pour chaque page avec file not found ?

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

#################################################################
####          debut de l'initialisation                   #######
#################################################################

$starttime = time();

# variables

$file = $fileroot.$errorlog;
$file = $fileroot.$prefixlog if ($type_serveur == 1);
$divers = 0;
$ncsa = 0;
$cern = 0;
$scan = 1;
$count_day = 1;
$diversday = 0;
$ref = 0;
$addit = 0;
$prefixlog = $errorlog;

#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -r <tildealias>       : substitue ~ by the path alias\n";
      print STDOUT "        -b                    : don't run incremental mode\n";      
      print STDOUT "        -c <file>             : load configuration file\n";
      print STDOUT "        -i <file>             : input logfile\n";
      print STDOUT "        -d <nbdays>           : number of days to scan\n"; 
      print STDOUT "        -j <dd/Mmm/yyyy>      : stats on dd/Mmm/yyyy\n";
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
      print STDOUT "        -f                    : 'file does not exist', HTML files only\n";
      print STDOUT "        -q <tri>              : 'file does not exist', matching string only\n";
      print STDOUT "        -k                    : 'file does not exist', show referer page\n";
      print STDOUT "        -s <seuil>            : display pages with at least seuil errors\n";
      print STDOUT "        -t <toplist>          : display only toplist most found errors\n";
      print STDOUT "        -x                    : show default value for flag options\n";
      print STDOUT "        -v                    : version\n";
      print STDOUT "        -z                    : zip logfiles\n";       
      print STDOUT "\n";
      exit;
}

if ($opt_v == 1) {
      print STDOUT "cron-error.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -r <tildealias>  : $tildealias\n";
      print STDOUT "          -b               : ";
      &id($opt_b);      
      print STDOUT "          -g <graphic>     : $graphic[0]\n";
      print STDOUT "          -l <language>    : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDOUT "          -i <file>        : $file\n";
      print STDOUT "          -d <nbdays>      : $nbdays\n"; 
      print STDOUT "          -j <dd/Mmm/yyyy> : <none>\n";
      print STDOUT "          -f               : No\n";
      print STDOUT "          -q <tri>         : $tri\n";
      print STDOUT "          -k               : ";
      &id($ref);
      print STDOUT "          -s <seuil>       : $seuilpage\n";
      print STDOUT "          -t <toplist>     : $topten\n";
      print STDOUT "          -v               : $version\n";
      print STDOUT "          -z               : ";
      &id($opt_z);           
      exit;
}

if ($opt_z ne '') {
$zip = $opt_z;
}

if ($opt_l ne '') {
  @lang = split(/, /,$opt_l);
  for ($i=0;$i<=$#lang;$i++) {
      $tmp = $dirress.$dirsep."lang".$dirsep.$lang[$i].$plext;
      $tmp = $pathinit.$tmp;
      require "$tmp";
  }
  if ($lang[0] eq '') {
      print STDERR "\nNone of your language choices have been yet translated !\n
";
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


if ($opt_k == 1) {
$cref = 1;
$ref = 1;
}

# argument cmds line

if ($opt_r ne '') {
$tildealias = $opt_r;
}

if ($opt_s ne '') {
$seuilpage = $opt_s;
}

if ($opt_t ne '') {
$topten = $opt_t;
}

if ($opt_j ne '')
     {
       if ($opt_j =~  /(\d\d)\/([JFMASOND][aepuco][nbrylgptvc])\/(\d\d\d\d)/) {
       $day = $1 ;
       $month = $2 ;
       $year = $3 ;
       $dayscan = "$1"." "."$2"." "."$3";
} else {
 print STDERR "Error : date should be in dd/Mmm/yyyy format\n";
 print STDERR "        dd is the day number\n";
 print STDERR "        Mmm is the abbreviated month name with first letter upper\n";
 print STDERR "        yyyy is the year number\n\n";
 exit;
}
}

if ($opt_d ne '') {
$nbdays = $opt_d;
}

if ($opt_i ne '') {
$file = $opt_i;
}

if ($opt_q ne '') {
$tri = $opt_q;
}

$pos = index($tri,'~');

if ($pos >= 0) {
$tri =~ s/~//;
$tri = $tri."/" if (rindex($tri,'/',length($tri))+1 != length($tri));
$tri = $tri.$tildealias."/";
}

$errorgraph = $path.$dirgraph.$dirsep."error".$gifext;
$errorgraphx = $path.$dirgraph.$dirsep."errorx".$gifext;
$errorgraphy = $path.$dirgraph.$dirsep."errory".$gifext;

$linkerrorgraph = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."error".$gifext;
$linkerrorgraphx = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."errorx".$gifext;
$linkerrorgraphy = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."errory".$gifext;

$others = "others".$gifext;

$tmp = $path;
chop($tmp);
mkdir ($tmp,0775) unless -d $tmp;

$dir = $path.$dirinc;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirtmp;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirgraph;
mkdir ($dir,0775) unless -d $dir;

for ($nblang=0;$nblang<=$#lang;$nblang++) {
$dir = $path.$lang[$nblang];
mkdir ($dir,0775) unless -d $dir;
$dir = $path.$lang[$nblang].$dirsep.$dirlist;
mkdir ($dir,0775) unless -d $dir;

}

$nbline = 0;

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

### nombre de jour entre le 1er janvier et $today

$timesec = time;
&get_time($timesec);
($jour_of_year_end) = split(/ /,$datemisc);

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

$pastday = "0".$pastday if (length($pastday) == 1);
$pasttoday = $pastday." ".$pastmonth." ".$pastyear;         

$pastjour_of_year = 0;
$countmonth = 0;
$month_end = $month_nb[$countmonth];
     
while ($month_end ne $pastmonth) {
   $pastjour_of_year += $month_of_year{$month_end};
   $countmonth++;
   $month_end = $month_nb[$countmonth];
   }
       
$pastjour_of_year += $pastday;

}

if (($pastyear%4 == 0 && $pastyear%100 != 0) || $pastyear%400 == 0) {
$pastbisextil = 1;
}


$jour_of_year_end +=365 if ($pastjour_of_year > $jour_of_year_end || $pastyear != $year);
$addit = 365 if ($pastjour_of_year > $jour_of_year_end || $pastyear != $year);
$jour_of_year_end++ if ($pastjour_of_year > $jour_of_year_end || $pastyear != $year && $pastbisextil == 1);

#print "Aujourd'hui nous sommes le $today ($jour_of_year_end)\n";
#print "il y a $nbdays jours , nous etions le $pasttoday ($pastjour_of_year)\n";

#################################################################
###               CERN or NCSA error logfile ?                ###
#################################################################

#if ($type_serveur != 1) {
#open(INFILE, $file) || die "Error, unable to open $file\n";

#($date,$failed)=split(/]/,<INFILE>);
#$date =~ s/\[//;

#$cern = 1 if ($date =~ m/^((\d+)\/(\w+)\/(\d+))(.*)/);
#$ncsa = 1 if ($date =~ m/^(\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);
#$ncsa = 1 if ($date =~ m/^(.+): (\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);
#$falsebegin = 1 if ($date =~ m/^(\w+): (\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);
#$falsebegin = 1 if ($date =~ m/^(.+): (\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);

#if ($ncsa == 0 && $cern == 0) {
#print STDERR "Error logfile format is unknown !\n";
#print STDERR "Please send me a piece of your file and tell me which httpd server you are running !\n";
#exit;
#}
 
#print STDOUT "Seems to be a ";
#print STDOUT "NCSA" if ($ncsa == 1);
#print STDOUT "CERN or Netscape" if ($cern == 1);
#print STDOUT " error logfile.\n";
#print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
#close(INFILE);
#}

#if ($ncsa == 1) {
#  @stringerror = ('File does not exist','socket error: accept failed','SIGHUP received','shutting down','directory as script','script not found or unable to stat','malformed header from script','timed out','password mismatch','send aborted','No file matching','file permissions deny','connection reset by peer','Directory index forbidden by rule','Premature end of script headers','unable to include');
#  $cref = 1;
#}

#if ($cern == 1) {
#  @stringerror = ('Connection interrupted','Invalid request','Restart','Timed out','Bad configuration','host:','SIGHUP caught','no handler function','No such file or directory');
#  @stringerror = ('no handler function','No such file or directory'); # netscape msgs
#  $cref = 0;
#}

#if ($type_serveur == 1) {
#  @stringerror = ('404','403');
#  for ($i=0;$i<=($#stringerror);$i++) {
#	$stringerror[$i] .= ";http://$localserver";
#  }
#}

#for ($i=0;$i<=($#stringerror);$i++) {
#$error{$stringerror[$i]} = 0;
#$errorday{$stringerror[$i]} = 0;
#}

#($size)= (stat("$file")) [7];

#&load_reverse_dns if (($reverse_dns == 1) && -f "$path$dirdata$dirsep$ip_table");

#################################################################
#######        chargement des anciennes valeurs      ############
#################################################################

$opt_b = 1 if (!(-f "$path$dirinc$dirsep$incerror"));
$opt_b = 1 if ($opt_d ne '');

if ($opt_b != 1) {

if (-f "$path$dirinc$dirsep$incerror") {

print STDOUT "Loading incremental data ...\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

open(OUT,"$path$dirinc$dirsep$incerror") || die "Error, unable to open $path$dirinc$dirsep$incerror\n";
$a = (<OUT>);
($nbline,$sizeold,$divers,$diversday,$firstday,$oldjour) = split(/\t/,$a);
chop($oldjour);
while (<OUT>) {
chop;
($err,$nb) = split(/\t/);
$error{$err} = $nb;
$toterror += $nb;
$unique++ if ($error{$err} != 0);
}
close(OUT);    

$toterror += $divers;

($pastday,$pastmonth) = split(/ /,$firstday);

$jour_of_year = 0;
$countmonth = 0;
$month_end = $month_nb[$countmonth];
     
while ($month_end ne $pastmonth) {
    $jour_of_year += $month_of_year{$month_end};
    $countmonth++;
    $month_end = $month_nb[$countmonth];
}
       
$jour_of_year += $pastday;
$jour_of_year += $addit;

#   $jour_of_year = (365 - $jour_of_year) if ($jour_of_year > $jour_of_year_end || $pastyear != $year);
$jour_of_year_first = $jour_of_year; 
   
open(OUT,"$path$dirinc$dirsep$incerrpage") || die "Error, unable to open $path$dirinc$dirsep$incerrpage\n";
while (<OUT>) {
chop;
($page,$nb,$nbdate,$refer) = split(/\t/);
$notexistpage{$page} = $nb;
$notexistdate{$page} = $nbdate;
$notexistrefer{$page} = $refer;
}
close (OUT);

open(OUT,"$path$dirinc$dirsep$dayerror") || die "Error, unable to open $path$dirinc$dirsep$dayerror\n";
while (<OUT>) {
(@err) = split;
for ($i=0;$i<=$#err;$i++) {
$evolerror{$count_day,$i} = $err[$i];
}
$count_day++;

}
close (OUT);

$count_day--;
for ($i=0;$i<$#err;$i++) {
      $errorday{$stringerror[$i]} = $err[$i];
      }
      
}
}

$jour = $oldjour;
$yeartmp = $year;

#################################################################
###                     gzip log file                         ###
#################################################################

$nb = 0;

if (($zip == 1 || $zipcut != 0) && (($opt_b == 1) || ($nbline == 0))) {

$month = $monthindex;
$monthprev = $month-1;
$year = $fyear;

   # detection du premier mois de log zipe

#      do {
while ($out == 0) {
#       while (!(-e $filezip) || !(-e $file) || $out != 1);
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
            print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
            $out = 1;
#            $filezip = $fileroot.$prefixlog;
#            print "Use zip=0 in config.pl.\n";
#            exit;
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
#        until (-e $filezip || -e "$fileroot$prefixlog");
#        until ((-e $filezip) || -e $file || $out == 1);

   $file = $fileroot.$prefixlog if ($out == 1);
   $zipcut = 0 if ($out == 1);
   $zip = 0 if ($out == 1);
   $lastfile = $file;
   $lastfilezip = $filezip;
   $stop = 0;
   $yeartmp = $year;
   
}

#################################################################

if ($zipcut != 0 && $opt_b != 1) {
	if (!(-f $file)) {
	($day,$month2,$year) = split(' ',$oldjour);
        $month = $month_equiv{$month2};
        $month = "0".$month unless (length($month_equiv{$month}) == 2);
        $lettermonth = $month2;    
        $file = $fileroot;
        $smallyear = $year - int($year/100)*100;
        $smallyear = "0".$smallyear unless (length($smallyear) == 2);
     	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	        }
#	print "A - $file\n";
	$filezip = $file.$zipext if (!(-f $file) && $zip == 1);	        
	}   
}      

$file = $fileroot.$errorlog if (!(-f $filezip) && !(-f $file));

#################################################################
###               CERN or NCSA error logfile ?                ###
#################################################################

if ($type_serveur != 1) {
open(INFILE, $file) || die "Error, unable to open $file\n";

($date,$failed)=split(/]/,<INFILE>);
$date =~ s/\[//;

$cern = 1 if ($date =~ m/^((\d+)\/(\w+)\/(\d+))(.*)/);
$ncsa = 1 if ($date =~ m/^(\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);
#$ncsa = 1 if ($date =~ m/^(\w+): (\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);
$ncsa = 1 if ($date =~ m/^(.+): (\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);
#$falsebegin = 1 if ($date =~ m/^(\w+): (\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);
$falsebegin = 1 if ($date =~ m/^(.+): (\w+) (\w+)(\s+)(\d+) ([0-9:])+ (\d+)/);

if ($ncsa == 0 && $cern == 0) {
print STDERR "Error logfile format is unknown !\n";
print STDERR "Please send me a piece of your file and tell me which httpd server you are running !\n";
exit;
}
 
print STDOUT "Seems to be a ";
print STDOUT "NCSA" if ($ncsa == 1);
print STDOUT "CERN or Netscape" if ($cern == 1);
print STDOUT " error logfile.\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
close(INFILE);
}

if ($ncsa == 1) {
  @stringerror = ('File does not exist','socket error: accept failed','SIGHUP received','shutting down','directory as script','script not found or unable to stat','malformed header from script','timed out','password mismatch','send aborted','No file matching','file permissions deny','connection reset by peer','Directory index forbidden by rule','Premature end of script headers','unable to include');
  $cref = 1;
}

if ($cern == 1) {
  @stringerror = ('Connection interrupted','Invalid request','Restart','Timed out','Bad configuration','host:','SIGHUP caught','no handler function','No such file or directory');
#  @stringerror = ('no handler function','No such file or directory'); # netscape msgs
  $cref = 0;
}

if ($type_serveur == 1) {
  @stringerror = ('404','403');
  for ($i=0;$i<=($#stringerror);$i++) {
	$stringerror[$i] .= ";http://$localserver";
  }
}

for ($i=0;$i<=($#stringerror);$i++) {
$error{$stringerror[$i]} = 0;
$errorday{$stringerror[$i]} = 0;
}

($size)= (stat("$file")) [7];

&load_reverse_dns if (($reverse_dns == 1) && -f "$path$dirdata$dirsep$ip_table");


#################################################################
###                 scanning the log file                     ###
#################################################################

#if ($zipcut != 0 && $opt_b != 1) {
#	if (!(-f $file)) {
#	($day,$month2,$year) = split(' ',$oldjour);
#        $month = $month_equiv{$month2};
#        $month = "0".$month unless (length($month_equiv{$month}) == 2);
#        $lettermonth = $month2;    
#        $file = $fileroot;
#        $smallyear = $year - int($year/100)*100;
#     	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
#		$compressed_logfile_fields[$i] =~ s/\%/\$/;
#		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
#	        }
#	$filezip = $file.$zipext if (!(-f $file) && $zip == 1);	        
#	}   
#}      

#$file = $fileroot.$errorlog if (!(-f $filezip) && !(-f $file));

if ($size < $sizeold) {
$nbline = 0;
print STDERR "Your logfile $file have been cut\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

while ($stop == 0) {

print STDOUT "Scanning $file file...\n" if (-f $file);
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

if (($zip == 1) && (-f $filezip) && ((($file ne $filezip) && ($nbline == 0 || $opt_b == 0)) || ($zipcut == 2))) {
#if (($zip == 1) && ($file ne $filezip) && ($nbline == 0)) {
       open(INFILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
    } else {
           open(INFILE,$file) || die "Error, unable to open $file\n";
      }

$line = 0;
$nbline = 0 if ($opt_b ne '');

      
BOUCLE:
while (<INFILE>) {

next if ($_ !~ /(\w+)/);
$line++;

next BOUCLE if (-f "$path$dirinc$dirsep$incerror" && $line <= $nbline);

# Unix
if ($type_serveur != 1) {

$linetoscan = $_;

($date,$failed,$cer1,$page)=split(/] /,$linetoscan);
$failed = $cer1."] ".$page if ($cern == 1 && $page ne '');

if ($falsebegin == 1) {
($a,$date) = split(/ \[/,$date);
$date = "[".$date;
}

$failed = $failed."] ".$cer1 if ($ncsa == 1 && $cer1 ne '');
$failed .= "] ".$page if ($ncsa == 1 && $page ne '');
#print STDERR "$date - $failed";

chop($failed);

$cernok = 0 if ($cern == 1);
$cernok = 1 if ($date =~ m/^\[(\w+) (\w+) (\d)/ || $date =~ m/^\[(\d+)\/(\w+)\/(\d+)/);
next if ($cernok != 1 && $cern == 1);

next if ($date !~ /\[/);
$date =~ s/\[//;
#print STDERR "$date\n";
($jow,$month2,$day,$hour,$year) = split(/ +/,$date) if ($ncsa == 1);
($day,$month2,$year,$hour) = split(/[\/:]/,$date) if ($cern == 1);

$jour = $day." ".$month2." ".$year;
#print STDERR "$jour - $_\n";
next if ($jour !~ m/^((\d+) (\w+) (\d+))/);

if ($firstday eq '') {
   $firstday = $jour;

   ($pastday,$pastmonth) = split(/ /,$firstday);

   $jour_of_year = 0;
   $countmonth = 0;
   $month_end = $month_nb[$countmonth];
     
   while ($month_end ne $pastmonth) {
       $jour_of_year += $month_of_year{$month_end};
       $countmonth++;
       $month_end = $month_nb[$countmonth];
   }
       
   $jour_of_year += $pastday;
#   $jour_of_year = (365 - $jour_of_year) if ($jour_of_year > $jour_of_year_end || $pastyear != $year);
   $jour_of_year_first = $jour_of_year; 
        $jour_of_year += $addit;
   
   $oldjour = $firstday;
#   print STDERR "$jour_of_year\n";
}


next BOUCLE if ($jour ne $dayscan && $opt_j ne '');

if ($jour ne $oldjour && $opt_j eq '') {

     for ($i=0;$i<=($#stringerror);$i++) {
     $evolerror{$count_day,$i} = $errorday{$stringerror[$i]};
     $errorday{$stringerror[$i]} = 0;
     }
     $evolerror{$count_day,$i} = $diversday;
     $diversday = 0;


   $yday = &nbdayan($jour);
   $ydayold = &nbdayan($oldjour);
   $diff = $yday - $ydayold;
   $diff += $ydayold if ($diff < 0);
   $diff++ if ($yday == 0);
   $count_day += $diff;

    $jour_of_year += $diff;

     if ($jour_of_year < $pastjour_of_year) {
       $oldjour = $jour;
       $scan = 0;
       next BOUCLE;
     }


#print STDERR "$jour_of_year $evolerror{$count_day,0} - ";
#     print STDOUT "$jour $oldjour $jour_of_year\n";

     $scan = 1;
     $oldjour = $jour;
}

#print STDERR "$scan - $jour_of_year - $pastjour_of_year\n";
if ($scan == 1 && ($jour_of_year > $pastjour_of_year) ) {
ERROR :
for ($i=0;$i<=($#stringerror);$i++) {

#    print STDERR "$failed\n";
   if ($failed =~ m/$stringerror[$i]/i) {
      $divers--;
      $diversday--;

#print "C : $date - $failed\n";

      if ($stringerror[$i] eq "No such file or directory") {
#         ($a,$b,$c,$refer,$d,$e,$f,$page) = split(/ /,$failed);
	  # Bug report (Netscape server)
	  # Thanks to Laurinda Chamberlin <lchamber@fcpa.fujitsu.com>
	  if ($failed =~ /\( (\d+)\)/) {
	      ($a,$b,$c,$refer,$d,$e,$f,$g,$h,$page) = split(/ /,$failed);
	  } elsif ($failed =~ /\((\d+)\)/) {
	      ($a,$b,$c,$refer,$d,$e,$f,$g,$page) = split(/ /,$failed);
	  } else {
	      ($a,$b,$c,$refer,$d,$e,$f,$page) = split(/ /,$failed);
	  }
	 chop($page);
         last ERROR if ($page !~ /\.(s)?htm(l)?/i && $opt_f == 1);
         last ERROR if ($page !~ /$tri/oi); 
         $notexistpage{$page}++;
         $notexistdate{$page} = $jour;
         $notexistrefer{$page} = &reversedns($refer);
         $error{$stringerror[$i]}++;
         $errorday{$stringerror[$i]}++;
         $unique++ if ($error{$stringerror[$i]} == 1);
         last ERROR;
      }





      if ($stringerror[$i] eq "File does not exist" || $stringerror[$i] eq "No file matching") {
         ($part1,$refer) = split(/ f[rom ]/,$failed);
#         print "A : $part1 : $refer\n";
         ($a,$b,$page,$d,@endlast) = split(/ /,$part1);


         $page = $d if ($a eq "httpd:");
         $refer = $page if ($a eq "[error]" && $refer eq '');
         $refer =~ s/\]//g if ($a eq "[error]");         
         $page = $endlast[$#endlast] if ($a eq "[error]");
         chop($page) if ($a eq "[error]" && $page =~ /\n/);
         $cref = 1 if ($a eq "[error]" && $refer ne '');
#	 print "$page - $refer - $failed\n";
         last ERROR if (substr($page,rindex($page,'.')) !~ /$extension/i && $opt_f == 1);
#         last ERROR if ($page !~ /\.(s)?htm(l)?/i && $opt_f == 1);
         last ERROR if ($page !~ /$tri/oi); 
#         print "$page - $opt_f - $extension\n";
         
         $notexistpage{$page}++;
         $notexistdate{$page} = $jour;
         ($a,$refer) = split(/[ ,]/,$refer) if ($a ne "[error]");
#         if ($refer =~ /http:\/\//o) {
           $notexistrefer{$page} = &reversedns($refer) if ($cref == 1 && $refer =~ /^[0-9.]+$/);
#           $cref = 1;
#         }
         $error{$stringerror[$i]}++;
         $errorday{$stringerror[$i]}++;
         $unique++ if ($error{$stringerror[$i]} == 1);
         last ERROR;
      }

      if ($stringerror[$i] eq "host:" && index($failed,"] /") != -1) {
         ($a,$host,$c,$refer,$page) = split(/ /,$failed);
         $refer = "&nbsp;" if ($page eq '');
         $page = $c if ($page eq '');
         last ERROR if (substr($page,rindex($page,'.')) !~ /$extension/i && $opt_f == 1);
         last ERROR if ($page !~ /$tri/oi);
         $notexistpage{$page}++;
         $notexistdate{$page} = $jour;
         $notexistrefer{$page} = &reversedns($refer);
         $error{$stringerror[$i]}++;
         $errorday{$stringerror[$i]}++;
         $unique++ if ($error{$stringerror[$i]} == 1);
         last ERROR;
      }

      $error{$stringerror[$i]}++;
      $errorday{$stringerror[$i]}++;
      $unique++ if ($error{$stringerror[$i]} == 1);

      last ERROR;
   }
}

$divers++;
$diversday++;
$toterror++;

}

# End Unix
}
# NT

if ($type_serveur == 1) {

@line_log = split(/$logfile_sep/);
next if ($line_log[0] =~ /^#/);

$date = $line_log[$fields_logfile{'%date'}];
$date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);
($jour,$heure,$minute,$seconde) = split(/:/,$date);
$jour =~ s/\// /g;

if ($firstday eq '') {
   $firstday = $jour;

   ($pastday,$pastmonth) = split(/ /,$firstday);
   
   $jour_of_year = 0;
   $countmonth = 0;
   $month_end = $month_nb[$countmonth];
     
   while ($month_end ne $pastmonth) {
       $jour_of_year += $month_of_year{$month_end};
       $countmonth++;
       $month_end = $month_nb[$countmonth];
   }

   $jour_of_year += $pastday;
   $jour_of_year_first = $jour_of_year; 
   $jour_of_year += $addit;
   
   $oldjour = $firstday;
}
   
$page = $line_log[$fields_logfile{'%page'}];
$query = $line_log[$fields_logfile{'%query'}] if ($fields_logfile{'%query'} ne '');
next BOUCLE if ($query !~ /\d\d\d;http/);

#print STDERR "$page - $query\n";

next BOUCLE if ($jour ne $dayscan && $opt_j ne '');

if ($jour ne $oldjour && $opt_j eq '') {

     for ($i=0;$i<=($#stringerror);$i++) {
     $evolerror{$count_day,$i} = $errorday{$stringerror[$i]};
     $errorday{$stringerror[$i]} = 0;
     }
     $evolerror{$count_day,$i} = $diversday;
     $diversday = 0;

   $yday = &nbdayan($jour);
   $ydayold = &nbdayan($oldjour);
   $diff = $yday - $ydayold;
   $diff += $ydayold if ($diff < 0);
   $diff++ if ($yday == 0);
   $count_day += $diff;

    $jour_of_year += $diff;

     if ($jour_of_year < $pastjour_of_year) {
       $oldjour = $jour;
       $scan = 0;
       next BOUCLE;
     }

     $scan = 1;
     $oldjour = $jour;
}

if ($scan == 1 && ($jour_of_year > $pastjour_of_year) ) {
for ($i=0;$i<=($#stringerror);$i++) {
   if ($query =~ m/$stringerror[$i]/i) {  
   
      $divers--;
      $diversday--;   
#print "$page\n";
$query =~ s/$stringerror[$i]//;
$notexistpage{$query}++;
$notexistdate{$query} = $jour;
$notexistrefer{$query} = $query;
         $error{$stringerror[$i]}++;
         $errorday{$stringerror[$i]}++;
         $unique++ if ($error{$stringerror[$i]} == 1);
}
}
	
$divers++;
$diversday++;
$toterror++;

}

}

}

close (INFILE);

# mois gzip suivant

#$numbermoisgzip++;
$stop = 1 if (($zip != 1 && $zipcut == 0) || ($file eq $filezip));
$stop = 1 if ($file eq "$fileroot$errorlog");

if (($zip == 1 || $zipcut != 0) && $stop != 1) {

$nbline = 0;
$year = $yeartmp;

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
          $filezip = $fileroot.$errorlog;
          $file = $fileroot.$errorlog;
          $stop = 1 if (!(-f $file));
      }
    }
} else {
   if (-e $file && $zipcut != 0) {
   } else {
          $filezip = $fileroot.$errorlog;
          $file = $fileroot.$errorlog;
          $stop = 1 if (!(-f $file));
   }
}

}


}

### date de la derniere journee du fichier de log

($lastday,$lastmonth,$lastyear) = split(/ /,$jour);         

$lastjour_of_year = 0;
$countmonth = 0;
$month_end = $month_nb[$countmonth];
     
while ($month_end ne $lastmonth) {
   $lastjour_of_year += $month_of_year{$month_end};
   $countmonth++;
   $month_end = $month_nb[$countmonth];
   }
       
$lastjour_of_year += $lastday;
$ecart = $jour_of_year_end -  $lastjour_of_year;
$ecart += 365 if ($ecart < 0);

#print STDERR "derniere date du fichier de log : $jour ($lastjour_of_year)\n";
#print STDERR "ecart : $ecart\n";

# last day

for ($i=0;$i<=($#stringerror);$i++) {
   $evolerror{$count_day,$i} = $errorday{$stringerror[$i]};
}
$evolerror{$count_day,$i} = $diversday;

#################################################################
####             sauvegarde des donnees                   #######
#################################################################

open(OUT,">$path$dirinc$dirsep$incerror") || die "Error, unable to open $path$dirinc$dirsep$incerror\n";
print OUT "$line\t$size\t$divers\t$diversday\t$firstday\t$oldjour\n";
 for ($j=0;$j<=$#stringerror;$j++) {
     print OUT "$stringerror[$j]\t$error{$stringerror[$j]}\n";
}
close(OUT);    

open(OUT,">$path$dirinc$dirsep$incerrpage") || die "Error, unable to open $path$dirinc$dirsep$incerrpage\n";
foreach $page (sort keys(%notexistpage)) {
print OUT "$page\t$notexistpage{$page}\t$notexistdate{$page}\t$notexistrefer{$page}\t$notexistrefer{$page}\n";
}
close (OUT);

open(OUT,">$path$dirinc$dirsep$dayerror") || die "Error, unable to open $path$dirinc$dirsep$dayerror\n";
for ($j=1;$j<=$count_day;$j++) {
for ($i=0;$i<=($#stringerror+1);$i++) {
	$evolerror{$j,$i} = 0 if ($evolerror{$j,$i} eq '');
        print OUT "$evolerror{$j,$i} ";
}
print OUT "\n";
}
close (OUT);

&save_reverse_dns if ($reverse_dns == 1); # sauvegarde de la table de DNS


    if ($line == $nbline) {
	print "Nothing new scanned...\n";
	exit;
    }

sub nextlog {

$day++ if ($zipcut == 2);
$day = "0".$day unless (length($day) == 2);

if ($day > $month_of_year{$month_nb[$monthprev]} && $zipcut == 2) {
$month++;
$monthprev++;
$day = "01";
}

$month++ if ($zipcut == 1);
$month = "0".$month unless (length($month) == 2);
$monthprev = $month-1 if ($zipcut == 1);

$year++ if ($month == 13);
$month = "01" if ($month == 13);
$monthprev = 0 if ($month == 1);
$lettermonth = $month_nb[$monthprev];
$prefixlog = $errorlog;
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
###                    computing maxima                       ###
#################################################################

# tri des $topten error les plus frequentes

$boucle = $topten unless ($unique < $topten);
$boucle = $unique unless ($unique > ($topten-1));

for ($i=0;$i<$boucle;$i++) {
 $maxi = 0;
 for ($j=0;$j<=$#stringerror;$j++) {
 $string = $stringerror[$j];
   if ($error{$string} > $maxi) {
         $maxi = $error{$string};
         $occurerror[$i] = $error{$string};
         $besterror[$i] = $string;
   }
 }
 $error{$besterror[$i]} = 0;
}

#################################################################
#####               error evolution graphs                #######
#################################################################

# check if something have been scan !

if ($jour_of_year < $pastjour_of_year && $pastyear == $year && $opt_j eq '' && $nbline == 0) {
$increase = $jour_of_year_end - $jour_of_year_first;
$increase +=365 if ($increase < 1);
print STDERR "Last day recorded in logfile is too old.\n";
print STDERR "Use \"-d $increase\" option to scan all the logfile!\n";
print STDERR "or nothing have been scanned !\n";
exit;
}

if ($opt_j ne '' && $toterror == 0) {
print STDERR "$opt_j not found !.\n";
print STDERR "Log file starting $firstday and ending $jour\n";
exit;
}

### recompute array

#print STDERR "\n";

$start_date = $firstday;

#print STDERR "$count_day $nbdays\n";

if ($count_day > $nbdays) {
$initday = $count_day - $nbdays + $ecart;
$start_date = $pasttoday;
#print STDERR "$initday\n";
}

for ($i=0;$i<$boucle;$i++) {
 for ($j=0;$j<=$#stringerror;$j++) {
  if ($stringerror[$j] eq $besterror[$i]) {
    for ($k=$initday;$k<=$count_day;$k++) {
     $newevolerror{$k-$initday,$i} = $evolerror{$k,$j};
#      print STDERR "$k $newevolerror{$k-$initday,$i} - ";
    }
  }
 }
}


# value for divers

for ($k=$initday;$k<=$count_day;$k++) {
  $newevolerror{$k-$initday,$boucle} = $evolerror{$k,$#stringerror+1};
}

#for ($j=0;$j<=$count_day;$j++) {
#    $max = 0;
#    for ($i=0;$i<=$#stringerror;$i++) {
#       $max += $evolerror{$initday+$j,$i};
#    }
#    $newevolerror{$j,$boucle} += $max;

#    for ($i=0;$i<$boucle;$i++) {
#       $newevolerror{$j,$boucle} -= $newevolerror{$j,$i};
#    }
#}

### 

#$intervalleday = $jour_of_year_end - $jour_of_year_first;
#$nbdays = $intervalleday if ($intervalleday < $nbdays);
#$toto = ($count_day+$jour_of_year_first);
#$nbdays = $count_day if ($toto < $jour_of_year_end);

$nbdays = $count_day if ($count_day < $nbdays);

### maximum

$maxtot = 0;
for ($j=0;$j<=$nbdays;$j++) {
    $max = 0;
    for ($i=0;$i<=$boucle;$i++) {
       $max += $newevolerror{$j,$i};
#       print STDOUT "$j $stringerror[$i] $max\n";
    }
    $maxtot = $max if ($max > $maxtot);
}

### compute graph

#if (-x $FLY) {

$it = length($nbdays)-1;
$div = 10**$it;
$factx = ($div*(int($nbdays/$div)+1))/$grad;
 
$perspec = $xstep/$factx if (($perspec > $xstep/$factx) && ($tridim == 1));

$it = length($maxtot)-1;
$div = 10**$it;
$facty = ($div*(int(($maxtot+$perspec)/$div)+1))/$grad;
 
 $yfirst = $ymax-1;
 $fy = $yfirst-1;

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 
 for ($i=0;$i<=$nbdays;$i++) {
 $x1 = ($i+$tridim)*$xstep/$factx;
 $x2 = ($i+1+$tridim)*$xstep/$factx;
 
 $y2 = $ymax;
 $y1 = $ymax;
 $yfinal = $ymax;

 for ($j=0;$j<=$boucle;$j++) {
 $yfinal -= ($ystep/$facty * $newevolerror{$i,$j});
 }

 $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
 $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);

 for ($j=0;$j<=$boucle;$j++) {

 $ji = $j % ($#gcolor+1);
 $ji = 100 if ($j == $boucle);

 if ($bargraph == 1) {
   $y2 -= ($ystep/$facty * $newevolerror{$i,$j});
   $y1 -= ($ystep/$facty * $newevolerror{$i,$j-1});
   print FLY "frect $x1,$y2,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
   print FLY "rect $x1,$y2,$x2,$y1,0,0,0\n";
   if ($tridim == 1 && ($y1-$y2) > 0) {
        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;
        $y1plus = $y1-$perspec;

        print FLY "fpoly $red[$ji],$green[$ji],$blue[$ji],$x2,$y1,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        print FLY "poly 0,0,0,$x2,$y1,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";

        if (int($y2) == int($yfinal)) {
        print FLY "fpoly $red[$ji],$green[$ji],$blue[$ji],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
	last;
        }

   }
 }

 if ($linegraph == 1) {
    $y2 = $ymax - ($ystep/$facty * $newevolerror{$i,$j});
    $y1 = $ymax - ($ystep/$facty * $newevolerror{$i+1,$j});
    print FLY "line $x1,$y2,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
    }

 if ($fillgraph == 1) {
     $ji = ($boucle-$j) % ($#gcolor);
     $ji = 100 if ($j == 0);
     $y2 = $ymax;
     $y1 = $ymax;
     for ($l=0;$l<=($boucle-$j);$l++) {
          $y2 -= ($ystep/$facty * $newevolerror{$i,$l});
          $y1 -= ($ystep/$facty * $newevolerror{$i+1,$l});
     }
     if ($y2 != $ymax || $y1 != $ymax) {
     print FLY "line $x1,$y2,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
 
     print FLY "line $x1,$ymax,$x1,$y2,$red[$ji],$green[$ji],$blue[$ji]\n";
     print FLY "line $x2,$ymax,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
     print FLY "line $x1,$yfirst,$x2,$yfirst,$red[$ji],$green[$ji],$blue[$ji]\n";

     $fx = ($x1+$x2)/2;

     print FLY "fill $fx,$fy,$red[$ji],$green[$ji],$blue[$ji]\n";
      } 
 }

 }
 }

 print FLY "transparent 200,200,200\n";
 close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $errorgraph |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

#$nbdays++; # start at 0 !

($startday, $startmonth) = split(/ /,$start_date);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);

$xlegend = "$nbdays days (starting $start_date)";

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

open(FOO,"$FLY -q -i $tmpfly -o $errorgraphx |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);
 
### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 if ($fillgraph == 1 || $bargraph == 1) {
 $posy = $ymax - (($ymax/2)-(length("Total added)")*2));
 print FLY "stringup 0,0,0,5,$posy,medium,Total added\n";
 }
 for ($i=$ystep;$i<$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) * ($facty/$ystep));
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);
 
open(FOO,"$FLY -q -i $tmpfly -o $errorgraphy |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);
#}

### change le message pour affichage

for ($i=0;$i<=($#stringerror);$i++) {
$besterror[$i] = "File does not exist" if ($besterror[$i] eq "host:");
$besterror[$i] = "File does not exist" if ($besterror[$i] eq "No file matching");
}

$ref = 0 if ($cref == 0);

###############################################################
###               creation du fichier HTML                  ###
###############################################################

$ydayfirst = &nbdayan($firstday);

if ($type_serveur == 1) {
for ($i=0;$i<$boucle;$i++) {
         $besterror[$i] =~ s/;http:\/\/$localserver//; 
}
}
   
foreach $page (sort keys(%notexistpage)) {
  if ($notexistpage{$page} >= $seuilpage) {
	$yday = &nbdayan($notexistdate{$page});
	$intervalle = $yday-$ydayfirst;
	$intervalle += 365 if ($intervalle < 0);
	$tri[$nb] = $intervalle;
	$page[$nb] = $page;
#	print "$notexistpage{$page} - $seuilpage - $page\n";
	$nb++;
	}
}

for ($j=0;$j<$nb;$j++) {
	for ($i=0;$i<$nb;$i++) {
	if ($tri[$j] > $tri[$i]) {
		$tmp = $tri[$j];
		$tri[$j] = $tri[$i];
		$tri[$i] = $tmp;
		
		$tmp = $page[$j];
		$page[$j] = $page[$i];
		$page[$i] = $tmp;
		}
	}
}

for ($nblang=0;$nblang<=$#lang;$nblang++) {
$fileerror = $path.$lang[$nblang].$dirsep.$dirlist.$dirsep.$tabnameerror;

open(FILEERROR,">$fileerror") || die "Error, unable to open $fileerror\n";
&Error(*FILEERROR, eval($Lang{$lang[$nblang]}));
close(FILEERROR);
}




#################################################################
sub Error {
 local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats_about_errors'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-error.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1>$L{'Stats_about_errors'}</H1><P>\n";

print FOUT "<HR size=5>\n";
print FOUT "<CENTER><B>$firstday - $jour</B></CENTER>\n";
print FOUT "<HR size=5><P>\n";

#if (-x $FLY) {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkerrorgraphy\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkerrorgraph\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkerrorgraphx\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "<TR><TD></TD>\n";
print FOUT "<TD ALIGN=CENTER>\n";

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";
for ($i=0;$i<$boucle;$i++) {
$j = $i % ($#gcolor+1);
$couleur = $gcolor[$j];
print FOUT "<TR><TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$couleur\" ALT=\"$couleur\"></TD>\n";
print FOUT "<TD>&nbsp; $besterror[$i]</TD></TR>\n";
}
print FOUT "<TR><TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$others\" ALT=\"$others\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'Others'}</TD>\n";
print FOUT "</TR></TABLE>\n";

print FOUT "</TD></TR>\n";        
print FOUT "</TABLE></CENTER>\n";

print FOUT "<P><I><CENTER>$L{'Evolution_of'} $boucle $L{'most_common_errors'}</CENTER></I>\n";
print FOUT "<P><HR><P>\n"; 
#}

print FOUT "$L{'The_Top'} $boucle $L{'most_common_errors'} ($L{'among'} $unique)<p>\n";
print FOUT "<CENTER><TABLE BORDER=1>\n";
print FOUT "<TR>\n<TH>$L{'Error'}</TH><TH>$L{'Occurence'}</TH></TH><TH>$L{'Percentage'}</TH>\n</TR>\n";


for ($i=0;$i<=($#stringerror);$i++) {
if ($occurerror[$i] != 0) {
$pourcentage = ($occurerror[$i]*100)/$toterror;
$pourcentageint = int($pourcentage);
print FOUT "<TR>\n<TD>$besterror[$i]</TD>\n<TD ALIGN=MIDDLE><B>$occurerror[$i]</B> $L{'times'}</TD>\n<TD>";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">" if ($pourcentageint != 0);
print FOUT " <B>";
printf FOUT "%.1f",$pourcentage;
print FOUT " %</B></TD>\n</TR>\n\n";
}
}

$pourcentage = ($divers*100)/$toterror;
$pourcentageint = int($pourcentage);
print FOUT "<TR>\n<TD><I>$L{'Others'}</I></TD>\n<TD ALIGN=MIDDLE><B>$divers</B> $L{'times'}</TD><TD>";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">" if ($pourcentageint != 0);
print FOUT " <B>";
printf FOUT "%.1f",$pourcentage;
print FOUT " %</B></TD>\n</TR>\n\n";

print FOUT "</TABLE></CENTER>\n";

print FOUT "<P><HR><P>\n";

print FOUT "File does not exist ($L{'with_at_least'} $seuilpage $L{'requests'})\n";
print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR>\n<TH>$L{'File'}</TH><TH>$L{'Occurence'}</TH><TH>$L{'Last_try'}</TH>";
print FOUT "<TH>$L{'since'}</TH>" if ($ref == 1);
print FOUT "\n</TR>\n";

for ($i=0;$i<$nb;$i++) {
    $page = $page[$i];
    print FOUT "<TR>\n<TD>$page</TD>\n<TD ALIGN=CENTER>$notexistpage{$page}</TD>\n<TD ALIGN=CENTER>$notexistdate{$page}</TD>\n";
    $notexistrefer{$page} = "&nbsp;" if ($notexistrefer{$page} eq '' && $ref == 1);
    print FOUT "<TD>$notexistrefer{$page}</TD>\n" if ($ref == 1);
    print FOUT "</TR>\n";
}

print FOUT "</TABLE></CENTER>\n";

print FOUT "</BODY></HTML>\n";
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
#print FILE "cron-error\t$today\t$startrun\t$endrun\t$min:$sec\t$line\n";
printf FILE "cron-error\t%s\t%s\t%s\t%d:%d\t%d\n",$today,$startrun,$endrun,$min,$sec,$line;
close(FILE);

__END__


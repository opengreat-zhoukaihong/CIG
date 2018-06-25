#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                   INCREMENTALE VERSION                         #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 20/08/2000     #####
####                                                                #####
#########################################################################

$version = "2.72";
$verdate = "20/08/00";

$fullday = 1;

############ script to launch daily at 00 hour 01 minute ##########

## valeur a modifier par fixperlpath.pl

require "/usr/local/etc/w3perl/cgi-bin/w3perl/libw3perl.pl";

$starttime = time();
print "Incremental stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

$daytmp = $day;

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
#$month_end = 0;
#$countmonth = 0;

###################################################################
# variables initialisees

$offset = 0;
$diffmax = 7;
$nbdayscf = $nbdays;

#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -c <file>        : load configuration file\n";
      print STDOUT "        -i <file>        : input logfile\n";
      print STDOUT "        -j <dd/MMM/yyyy> : stats on dd/MMM/yyyy\n";
      print STDOUT "        -p <level>       : precision level (from 1 to 4)\n";
      print STDOUT "        -l <";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      } 
      print STDOUT "$lang[$#lang]";
      print STDOUT ">       : language output (comma split)\n";            
      print STDOUT "        -s <nbdays>      : scan for the nbdays previous day\n";
      print STDOUT "        -t <toplist>     : display only toplist files\n";
      print STDOUT "        -x               : show default value for flag options\n";
      print STDOUT "        -v               : version\n";
      print STDOUT "\n";
      exit;
}

if ($opt_v == 1) {
      print STDOUT "cron-inc.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -c               : $configfile\n";
      print STDOUT "          -i <file>        : $fileroot\n";
      print STDOUT "          -j <dd/Mmm/yyyy> : <none>\n";
      print STDOUT "          -p <level>       : $precision\n";
      print STDOUT "          -l <language>    : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDOUT "          -s <nbdays>      : $diffmax\n";
      print STDOUT "          -t <toplist>     : $topten\n";
      print STDOUT "          -v               : $version\n";
      exit;
}

# argument cmds line

if ($opt_t ne '') {
$topten = $opt_t;
}

if ($opt_p ne '') {
$precision = $opt_p;
}

if ($opt_s ne '') {
$diffmax = $opt_s;
}

if ($opt_j ne '')
     {
       if ($opt_j =~  /(\d\d)\/([JFMASOND][aepuco][nbrylgptvc])\/(\d\d\d\d)/) {
          $day = $1 ;
          $month = $2 ;
          $year = $3 ;
          $yesterday = "$1"."/"."$2"."/"."$3";
          $testccmonth = $month_equiv{$2};
          $onlyone = 1;
          $firstday = $yesterday;
          $firstday =~ s/[\/]/ /g;
          print STDOUT "Scanning for one day : $yesterday\n";
	  print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
          } else {
             print STDERR "Error : date should be in dd/Mmm/yyyy format\n";
             print STDERR "        dd is the day number\n";
             print STDERR "        Mmm is the abbreviated month name with first letter upper\n";
             print STDERR "        yyyy is the year number\n\n";
             exit;
             }
      } else {

          $datesyst = &ctime(time);
          ($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
          $year = $a if ($year eq '');
          $day = "0".$day if (length($day) == 1);
          $currentmonth = $month;
          $month_number = $month_equiv{$month};
          ($hour,$minute,$second) = split(/:/,$hourdate);
          $today = $day."/".$month."/".$year;
          $nextjour = $day."/".$month."/".$year;

         $day--;
         if ($day < 1) {
             $month_number--;
             $year-- if ($month_number < 1);
             $month_number = 12 if ($month_number < 1);
             for ($i=0;$i<$month_number;$i++) {
                 $month = shift(@month_nb);
                 }
             $day = $month_of_year{$month};
         }

         $day = "0".$day if (length($day) == 1);

         $yesterday = "$day"."/"."$month"."/"."$year";
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

if ($opt_i ne '') {
$fileroot = $opt_i;
}

$tmptri = 0;
$pos = length($tri);
while (($pos = rindex($tri,$dirsepurl,$pos)) >= 0) {
        $tmptri++;
        $pos--;
        }
$tmptri--;


# check if cron-page have been run before
$dir = $path.$dirinc;
if (!(-d $dir)) {
print "\nYou should run once cron-pages.pl before !\n\n";
exit;
}

$linkfilerep = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert.$gifext;
$linkfilerepx = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert."x".$gifext;
$linkfilerepy = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert."y".$gifext;

#################################################################
#####       correspondance entre pays et code du pays       #####
#################################################################

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
$extfile{$tmp1}=$tmp;
$extfilenb{$tmp1}=$zone;
}
}
close EXTCONV;

###################################################################
# title

chop($pathserver);

if (!(-e "$path$dirdata$dirsep$fileurl")) {
$titlename = 0;
}

if ($titlename == 1) {
   open(URL,"$path$dirdata$dirsep$fileurl") || die "cannot open $path$dirdata$dirsep$fileurl\n";
        while (<URL>) {
        ($url,$title) = split(/\"/);
        chop($url);
#        $url =~ s/$pathserver//i;
        $urlconv{$url} = $title;
        }
}


$cday = $day;
$cmonth = $month;
$ccmonth = $month_number;
$cyear = $year;

#print STDOUT "yesterday was : $yesterday\n";

# Checking directories exists

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
}

#############################################################################

&load_reverse_dns if ($reverse_dns == 1); # chargement de la table de DNS

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
    print "Use cron-session.pl first to detect robot session\n";
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

#################################################################

# verification qu'on n'a pas oublie un jour et qu'on en recorde pas deux fois
# la meme journee

########
######## boucle generale pour le scan pour scanner plusieurs jours
########

while ($diff != 1) {

  if ($onlyone != 1) {

     open(FILEDATE,"$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";
        while (<FILEDATE>) {
           ($jo,$mo,$ye) = split;
        }
     close (FILEDATE);

     $finjour = $jo."/".$mo."/".$ye;
     $previousjour = $jo."/".$mo."/".$ye;
     $yesterday = $cday."/".$cmonth."/".$cyear;

#print STDOUT "Dernier jour dans time-stat : $finjour\n";
#print STDOUT "Jour a scanne : $yesterday\n";

     if ($yesterday eq $finjour) {
        print "You have already computed the incremental stats today ... wait tomorrow !\n";
        print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
        exit;
     }

#verifier que $finjour est bien la veille de $yesterday sinon exit
# et message d'erreur.....

     @month_nb = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

     $month_number = $month_equiv{$month};

     if ($yesterday ne $finjour) {
#print STDERR "\nProblem : you seems to have forgotten to run $nomprgs !\n";
#print STDERR "The last incremental day stored in the data is $finjour\n";
#print STDERR "And the date I would like to found was the day previous $yesterday\n";

# calcul de la difference du nombre de jour entre les deux dates
# si inferieur a 7 jours...on recalcule sinon on arrete et envoie sur cron-pages.pl
# nombre de jour entre le 1er janvier et $yesterday

          ($testday,$testmonth,$testyear) = split(/\//,$yesterday);

          $test2jour = 0;
          $countmonth = 0;
          $month_end = $month_nb[$countmonth];

          while ($month_end ne $testmonth) {
             $test2jour += $month_of_year{$month_end};
             $countmonth++;
             $month_end = $month_nb[$countmonth];
          }

          $test2jour += $testday;

# nombre de jour entre le 1er janvier et $finjour

          ($testday,$testmonth,$testyear) = split(/\//,$finjour);

          $testjour = 0;
          $countmonth = 0;
          $month_end = $month_nb[$countmonth];

          while ($month_end ne $testmonth) {
             $testjour += $month_of_year{$month_end};
             $countmonth++;
             $month_end = $month_nb[$countmonth];
          }

          $testjour += $testday;

          $diff = $test2jour - $testjour;

          if ($diff < 0) {
              $diff += 366;
              $year--;
               if (($year%4 == 0 && $year%100 != 0) || $year%400 == 0) {
                   $diff++;
               }

          }

          if ($diff > $diffmax) {
            print STDERR "$finjour est le $testjour jour de l'annee\n";
            print STDERR "$yesterday est le $test2jour jour de l'annee\n";

            print STDERR "If you don't want to loose some stats, you would better rerun cron-pages.pl\n";
            print STDERR "Incremental script is able to run over the last $diffmax days but $diff have been found !\n"; # stop if diff higher than $diffmax days
            exit;
          } else {
#print STDOUT "I'll scan for the last $diff days\n";

             $testday = $cday;
             $testmonth = $cmonth;
             $testccmonth = $ccmonth;
             $testyear = $cyear;

             $testday = ($testday - $diff);

             $testday = "0".$testday if (length($testday) == 1);

             if ($testday < 1) {
                 $testccmonth--;
                 if ($testccmonth < 1) {
                     $testyear--;
                     $testccmonth = 12;
                 }
                 $testmonth = $month_nb[$testccmonth-1];
                 $testday = $month_of_year{$testmonth};
             }

             $previousjour = "$testday"."/"."$testmonth"."/"."$testyear";

             #

             $testday = $cday;
             $testmonth = $cmonth;
             $testccmonth = $ccmonth;
             $testyear = $cyear;

             $testday = ($testday - $diff + 2);

             $testday = "0".$testday if (length($testday) == 1);

             if ($testday < 1) {
                 $testccmonth--;
                 if ($testccmonth < 1) {
                     $testyear--;
                     $testccmonth = 12;
                 }
                 $testmonth = $month_nb[$testccmonth-1];
                 $testday = $month_of_year{$testmonth};
             }

             $nextjour = "$testday"."/"."$testmonth"."/"."$testyear";

             #
 
             $testday = $cday;
             $testmonth = $cmonth;
             $testccmonth = $ccmonth;
             $testyear = $cyear;

             $testday = ($testday - $diff + 1);

             $testday = "0".$testday if (length($testday) == 1);

             if ($testday < 1) {
                 $testccmonth--;
                 if ($testccmonth < 1) {
                     $testyear--;
                     $testccmonth = 12;
                 }
                 $testmonth = $month_nb[$testccmonth-1];
                 $testday = $month_of_year{$testmonth}+$testday;
             }

             $yesterday = "$testday"."/"."$testmonth"."/"."$testyear";
         }
     }
   }

   $diff = 1 if ($onlyone == 1);

   $jour = $yesterday;
   $jour =~ s/[\/]/ /g;

#################################################################
###       seek to the right place to scan the log file        ###
#################################################################

($day,$month_yesterday,$year) = split(/\//,$yesterday);

if ($zipcut != 2) {

$monthold = $month;
$tmp = 10 if (!(-f "$file"));


#if ($zip == 1 && $tmp == 10 && ($month_yesterday ne $currentmonth || $opt_j ne '')) {
if ($zip == 1 && $tmp == 10 || $opt_j ne '') {

        $month = $testccmonth;
        $month = "0".$month if (length($month) == 1);
        $day = "0".$day if (length($day) == 1);
#       $day = $testday;
        $lettermonth = $month_nb[$testccmonth-1];       
        $lettermonth = $month_nb[$testccmonth] if ($opt_j ne '');       

        $file = $fileroot;
	$smallyear = $year - int($year/100)*100;
	$smallyear = "0".$smallyear if (length($smallyear) == 1);
        for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
                $compressed_logfile_fields[$i] =~ s/\%/\$/;
                $file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
        }

               $file = $file.$zipext;

open(INFILE, "$GZIP $file |") || die "Error, unable to open $file\n";
}

open(INFILE, $file) || die "Error, unable to open $file\n" if ($tmp != 10);
 



# taille du fichier de log

($size)= (stat("$file")) [7];

###### date d'arrivee

# calcul le nombre de jour

$jour_of_year_end = 0;

$countmonth = 0;
$month_end = $month_nb[$countmonth];

$month = $currentmonth;

while ($month_end ne $month) {
  $jour_of_year_end += $month_of_year{$month_end};
  $countmonth++;
  $month_end = $month_nb[$countmonth];
  }

$jour_of_year_end += $day;

#print STDOUT "$today est le $jour_of_year_end jour de l'annee\n";

###### date de depart

#sysread (INFILE,$scalar,250);

$scalar = (<INFILE>);
while ($scalar =~ /^#/) {
$scalar = (<INFILE>);
}

@line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

#($adresse,$a,$b,$date)=split(/[ \t\n\[]+/,$scalar);
($firstjour) = split(/:/,$date);
($jo,$month,$year1) = split(/\//,$firstjour);

# calcul le nombre de jour

$jour_of_year_end1 = 0;

$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $month) {
  $jour_of_year_end1 += $month_of_year{$month_end};
  $countmonth++;
  $month_end = $month_nb[$countmonth];
  }

$jour_of_year_end1 += $firstjour;

#print STDOUT "$firstjour est le $jour_of_year_end1 jour de l'annee\n";

close (INFILE);

# nbre de jours

$intervalle = ($year - $year1)*365 + ($jour_of_year_end - $jour_of_year_end1)+1;

# taille moyenne d'une journee

if ($intervalle != 0) {
$sizejour = $size/$intervalle;
} else {
print STDERR "Your logfile $fileroot$prefixlog seems to have been cut\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print STDERR "Some data will be loose...\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
$firstjour = $yesterday;
}

##################

$sizejour = 512 if ($sizejour < 512);

if ($firstjour ne $yesterday) {
   $nb = 1;
   $verifjour = $yesterday;

#    open(INFILE, $file) || die "1 Error, unable to open $file\n"; # if ($month_yesterday eq $currentmonth);

    if ($zip == 1 && $tmp == 10 && $month_yesterday eq $currentmonth) {

#if ($zip == 1 && ($month_yesterday ne $currentmonth || $zipcut == 2)) {
        $month = $testccmonth;
        $month = "0".$month if (length($month) == 1);
#       $day = $testday;
        $lettermonth = $month_nb[$testccmonth-1];       
        $file = $fileroot;
	$smallyear = $year - int($year/100)*100;
	$smallyear = "0".$smallyear if (length($smallyear) == 1);
        for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
                $compressed_logfile_fields[$i] =~ s/\%/\$/;
                $file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
        }
               $file = $file.$zipext;


#    $file = $fileroot.$prefixlog.".".$month_yesterday."-".$year.".gz";
    open(INFILE, "$GZIP $file |") || die "2 Error, unable to open $file\n";
    } else {
    open(INFILE, $file) || die "1 Error, unable to open $file\n"; # if ($month_yesterday eq $currentmonth);
    }

    while ($verifjour eq $yesterday) {
       $offset = int($size - ($nb*$sizejour));
       #print STDOUT "offset : $offset\n";

       # verif de la date
       seek(INFILE,$offset,0);
       sysread (INFILE,$scalar,512);

#       ($adresse,$date)=split(/[\[]/,$scalar);

# @line_log = split(/[\[]/,$scalar);
# $date = $line_log[$fields_logfile{'%date'}];

@line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

       ($verifjour) = split(/:/,$date);

       #print STDOUT "verif : $verifjour\n";
       $nb++;
   }
   close (INFILE);
}

$offset = 0 if ($firstjour eq $yesterday);
}

#################################################################
#######            variables initialisees            ############
#################################################################

$redirect = 0;
$forbiden = 0;
$notfound = 0;
$exclpages = 0;
$exclframed = 0;
$exclrobots = 0;
$excladdr = 0;
$newhost = 0;
$locserverjour = 0;
$domreq = 0;
$accessjour = 0;
$nbpageserveur{$adresse}= 0;
$domreq = 0;
$reqdomtot = 0;
$locserverjour = 0;
$add = 0;
$nbdays = 0;
$tothtmlsizejour = 0;
$totsizejour = 0;
$virtualunique = 0;
$paysunique = 0;

undef @selecpages;
undef @selecadresse;
undef @selecdate;

for ($i=0;$i<=($#selecrepert);$i++) {
$freqjourrac{$selecrepert[$i]} = 0;
$freqrachtml{$selecrepert[$i]} = 0;
$freqrachtmldom{$selecrepert[$i]} = 0;
$sizejourrachtml{$selecrepert[$i]} = 0;
$sizejourrachtmldom{$selecrepert[$i]} = 0;
$sizejourrachtmlext{$selecrepert[$i]} = 0;
$totsize{$selecrepert[$i]} = 0;
$extsize{$selecrepert[$i]} = 0;
$domsize{$selecrepert[$i]} = 0;
}

$pageuniquejour = 0;

foreach $page (keys(%pagesluesday)) {
$pagesluesday{$page} = 0;
}

$paysuniquejour = 0;
$paysjournew = 0;
foreach $pays (keys(%paysjour)) {
    $paysjour{$pays} = 0;
    $paysjourlist{$pays} = 0;
}


#for ($i=0;$i<=$paysuniquejour;$i++) {
#    $pays = $paysuniquejourlist[$i];
#    $paysjour{$pays} = 0;
#}

#################################################################
#######        chargement des anciennes valeurs      ############
#################################################################

if ($onlyone != 1) {

print STDOUT "Loading data\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$newhost = 0;
$nbpageserveur{$adresse}= 0;
$reqdomtot = 0;
$add = 0;
$nbdays = 0;

$serveruniquejour = 0;
$locserverjour = 0;
$pageunique = 0;
$pageuniquejour = 0;

$scriptuniquejour = 0 ;
$paysuniquejour = 0;
$paysjournew = 0;
$locserver = 0;
$serverunique = 0;
$reqtotjour = 0;
$domreq = 0;
$access = 0;
$accessdom = 0;
$excladdr = 0;
$exclframed = 0;
$exclrobots = 0;
$exclpages = 0;
$notfound = 0;
$forbiden = 0;
$redirect = 0;
$proxy = 0;
$loglines = 0;

open(GENERAL,"$path$dirinc$dirsep$incgeneral") || die "Error, unable to open $path$dirinc$dirsep$incgeneral\n";
while (<GENERAL>) {
($date1,$date2,$date3,$reqtot,$reqdomtot,$totsize,$externesize,$domsize,$nbdays,$access,$accessdom,$tothtmlsize,$loglines,$proxy,$redirect,$forbiden,$notfound,$exclpages,$excladdr,$exclframed,$exclrobots) = split;
}
close GENERAL;

$domsize2 = $domsize;
$prevloglines = $loglines;
$exclframed = 0 if ($exclframed eq '');
$exclrobots = 0 if ($exclrobots eq '');

$firstday = "$date1"." "."$date2"." "."$date3";

if (-f "$path$dirinc$dirsep$filetype" && $precision > 2) {
open(FILETYPE,"$path$dirinc$dirsep$filetype") || die "Error, unable to open $path$dirinc$dirsep$filetype\n";
while (<FILETYPE>) {
($page,$chiffre) = split;
$filetype{$page} = $chiffre;
}
close FILETYPE;
}

open(PAGESLUES,"$path$dirinc$dirsep$incpage") || die "Error, unable to open $path$dirinc$dirsep$incpage\n";
while (<PAGESLUES>) {

($page,$chiffre,@tmp) = split;
for ($i=0;$i<$#tmp;$i++) {
$tmpage{$i,$page} = $tmp[$i];
}

#($page,$chiffre) = split;
$pageslues{$page} = $chiffre;
$bestpageslues{$page} = $chiffre;
$pageunique++;
}
close PAGESLUES;

$i = 0;
if (-f "$path$dirinc$dirsep$dirdownload" && $precision > 2) {
open(DOWNLOAD,"$path$dirinc$dirsep$dirdownload") || die "Error, unable to open $path$dirinc$dirsep$dirdownload\n";
while (<DOWNLOAD>) {
$adresse = $_;
chop($adresse);
($tmp1,$tmp2,@val) = split(/ /,$adresse);
$listext[$i] = $tmp1;
$downloadsizeext{$tmp1} = $tmp2;
$maxdownloadlength = ($#val)+1;
for ($j=1;$j<=($maxdownloadlength/2);$j++) {
$a = 2*($j-1);
$chiffre = (2*$j)-1;
$downloadsize{$tmp1,$j} = $val[$a];
$download{$tmp1,$j} = $val[$chiffre];
}
$i++;

}
close DOWNLOAD;
}

$maxdownloadlength /= 2;

if ($inc_script == 1 && (-f "$path$dirinc$dirsep$incscript")) {
    open(SCRIPT,"$path$dirinc$dirsep$incscript") || die "Error, unable to open $path$dirinc$dirsep$incscript\n";
$a = <SCRIPT>;
(@val) = split(/ /,$a);
for ($i=0;$i<$#val;$i++) {
    ($tmp1,$tmp2) = split(/,/,$val[$i]);
    $method{$tmp1} = $tmp2;
}

while (<SCRIPT>) {
    chop;
    ($namescript,$chiffre,@lines) = split(/\^/);
    $script{$namescript} = $chiffre;
    $scriptunique++;
    for ($j=0;$j<=$#lines;$j++) {
#	chop($lines[$j]) if ($j == $#lines);
	($name,@group) = split(/\t/,$lines[$j]);
	$name =~ s/\[//;
	if (!($seen{"$namescript $name"}++)) {
	    $argunique{$namescript}++;
	    $nameunique{$namescript,$name}++;
	}
	$tmp = $j+1;
	$scriptdata{$namescript,$tmp} = $name;

	for ($k=0;$k<=$#group;$k++) {
	    ($value,$b) = split(/,/,$group[$k]);
	    $value =~ s/\"//g;
	    chop($b);
	    $tmp = $k+1;
	    $countargval{$namescript,$name,$tmp} = $value;
	    $countarg{$namescript,$name,$value} = $b;
	}
    }
}
close SCRIPT;
}


open(PAYS,"$path$dirinc$dirsep$incpays") || die "Error, unable to open $path$dirinc$dirsep$incpays\n";
while (<PAYS>) {
($pays,$chiffre,$chiffre2,$chiffre3,$chiffre4) = split;
$serverpays{$pays} = $chiffre;
$payslist{$pays} = $chiffre2;
$payshtml{$pays} = $chiffre3;
#$bestpayslist{$pays} = $chiffre2; # pourquoi mettre les best ???????????????
$sizepays{$pays} = $chiffre4;
$paysunique++ if ($pays ne "Unknown");
}
close PAYS;

if (-f "$path$dirinc$dirsep$dirdomain") {
open(DOMAIN,"$path$dirinc$dirsep$dirdomain") || die "Error, unable to open $path$dirinc$dirsep$dirdomain\n";
while (<DOMAIN>) {
($adresse,$date1,$date2,$date3) = split;
$domaindate{$adresse} = $date1." ".$date2." ".$date3;
}
close DOMAIN;
}

open(SERVEXTERNE,"$path$dirinc$dirsep$incservexterne") || die "Error, unable to open $path$dirinc$dirsep$incservexterne\n";
while (<SERVEXTERNE>) {
($adresse,$chiffre,$tmp2) = split;
$server{$adresse} = $chiffre;
$listadresse[$serverunique] = $adresse;
$listadresseold[$serverunique] = $adresse;
$nbpageserveur{$adresse} = $tmp2; 
$serverunique++;
}
close SERVEXTERNE;

open(SERVINTERNE,"$path$dirinc$dirsep$incservinterne") || die "Error, unable to open $path$dirinc$dirsep$incservinterne\n";
while (<SERVINTERNE>) {
($adresse,$chiffre,$tmp2) = split;
$localserver{$adresse} = $chiffre;
$locserver++;
$listadresse[$serverunique] = $adresse;
$listadresseold[$serverunique] = $adresse;
$nbpageserveur{$adresse} = $tmp2; 
$serverunique++;
}
close SERVINTERNE;


open(SERVPAGESELECT,"$path$dirinc$dirsep$incpageselect") || die "Error, unable to open $path$dirinc$dirsep$incpageselect\n";
while (<SERVPAGESELECT>) {
($page,$adresse,$date) = split;
push(@selecadresse,$adresse);
push(@selecpages,$page);
push(@selecdate,$date);
}
close SERVPAGESELECT;


open(REPERT,"$path$dirinc$dirsep$increpert") || die "Error, unable to open $path$dirinc$dirsep$increpert\n";
while (<REPERT>) {
($racine,$vale1,$vale2,$vale3,$vale4,$vale5,$vale6,$vale7,$vale8,$vale9) = split;
$freqrac{$racine} = $vale1;
$freqrachtml{$racine} = $vale2;
$freqrachtmldom{$racine} = $vale3;
$freqtotsize{$racine} = $vale4;
$freqextsize{$racine} = $vale5;
$freqdomsize{$racine} = $vale6;
$freq2rac{$racine} = $vale7;
$freq2rachtml{$racine} = $vale8;
$freq2totsize{$racine} = $vale9;
}

close REPERT;

if (-f "$path$dirinc$dirsep$incvirtual") {
open(VIRTUAL,"$path$dirinc$dirsep$incvirtual") || die "Error, unable to open $path$dirinc$dirsep$incvirtual\n";
while (<VIRTUAL>) {
chop;
($vserver,$vale1,$vale2) = split(/\t/);
$virtual{$vserver} = $vale1;
$virtualsize{$vserver} = $vale2;
$virtualunique++;
}
close (VIRTUAL);
}

if ($precision > 3) {
open(PAGES,"$path$dirinc$dirsep$inchosts") || die "Error, unable to open $path$dirinc$dirsep$inchosts\n";
while (<PAGES>) {
($adresse,@page) = split;
$nbpageserveur{$adresse} = $#page;
for ($i=0;$i<=$#page;$i++) {
        $pagesite{$adresse,$i} = $page[$i];
#       print "$pagesite{$adresse,$i} - $adresse - $i $nbpageserveur{$adresse}\n";
        }
}
close(PAGES);
}

}

#################################################################
#######        ouverture du fichier de log           ############
#################################################################

#print STDERR "\nWarning : Reverse dns is on...it will slow down speed !\n" if ($reverse_dns == 1);

$tmp = 10 if (!(-f "$fileroot$prefixlog"));

if ($zipcut != 0 && (($month_yesterday ne $currentmonth || $zipcut == 2) || $tmp == 10)) {
    $month = $testccmonth;
    $month = "0".$month if (length($month) == 1);
#$day = $testday;
$day = "0".$day if (length($day) == 1);
$lettermonth = $month_nb[$testccmonth-1];       
$lettermonth = $month_nb[$testccmonth] if ($opt_j ne '');       
$file = $fileroot;
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
    $compressed_logfile_fields[$i] =~ s/\%/\$/;
$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}
$file = $file.$zipext if ($zip == 1);

$abort = 0 if (-f $file);
$abort = 1 if ($zip == 0 && !(-f $file));
$abort = 1 if ($zip == 1 && !(-f $file));
if ($abort != 1) {
print STDOUT "Log file : $file ($yesterday)\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
open(FILE, "$GZIP $file |") || die "Error, unable to open $file\n" if ($zip == 1);
open(FILE, "$file") || die "Error, unable to open $file\n" if ($zip == 0);
} else {
    print "<FONT COLOR=\"#FF0000\">" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print "File $file not found\n";
    print "</FONT><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

} else {

print STDOUT "Log file : $fileroot$prefixlog ($yesterday)\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
open(FILE,"$fileroot$prefixlog") || die "Error, unable to open $fileroot$prefixlog\n";
}
    
#seek(INFILE,$offset,0);

BOUCLE:
while (<FILE>) {

 @line_log = split(/$logfile_sep/);
 chop($line_log[$#line_log]);
 next if ($line_log[0] =~ /^#/);
 
 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

 $adresse = $line_log[$fields_logfile{'%host'}];
 $b = $line_log[$fields_logfile{'%login'}];
 $d = $line_log[$fields_logfile{'%method'}];
 $page = $line_log[$fields_logfile{'%page'}];
 $query = $line_log[$fields_logfile{'%query'}] if ($fields_logfile{'%query'} ne ''); 
 $status = $line_log[$fields_logfile{'%status'}];
 $requetesize = $line_log[$fields_logfile{'%requetesize'}];
 $vserver = $line_log[$fields_logfile{'%virtualhost'}] if ($fields_logfile{'%virtualhost'} ne ''); 
 $vserver = $1 if ($page =~ /^\/\/([-.0-9a-z]+)\//i && $virtualCLF != 0);
 $vserver = $line_log[$#line_log] if ($#logfile_fields == $fields_logfile{'%virtualhost'});

 $page =~ s/\/\/$virtualfilter// if (($virtualCLF != 0 && $virtualfilter ne '') || ($d =~ /$localserver/));
    
next if ($page !~ /^\//);
next if ($date !~ m/$yesterday/);
next if ($status !~ /^(\d+)$/);
next if ($adresse eq '');
if ($adresse =~ /\//) {
    ($tmp,$adresse) = split(/:/,$adresse);
    print "Problem : found $tmp ... fixing done\n";
}
#next if (($status >= 400) && ($status < 599));

$page =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
$page =~ tr/[A-Z]/[a-z]/ if ($type_serveur == 1);
next if ($page !~ m#$tri#); # stats sur une partie du serveur
next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
next if ($d =~ /$localserver/ && $vserver ne '');
next if ($vserver =~ /$excludevirtual/i && $excludevirtual ne '');
next if ($vserver !~ /$virtualfilter/i && $virtualfilter ne '' && $vserver ne '');

 $page =~ s/\"// if ($requetesize !~ /(\d+)/);
 
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

#$exclrobots++ if ($adresse =~ /$exclude_robot_address/i && ($exclude_robot == 1));
#next if ($adresse =~ /$exclude_robot_address/i && ($exclude_robot == 1));

$pays = substr($adresse,rindex($adresse,'.')+1,length($adresse));
$pays =~ tr/A-Z/a-z/;
print "Problem found : $date - $adresse (skipping...)\n" if (length($pays) > 4);
next if (length($pays) > 4);

next if ($pays ne $country_filtering && $country_filtering ne '');

$adresse =~ tr/A-Z/a-z/;

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
#$method{$d}++;
#($namescript,$argscript) = split(/\?/,$page);
#@valarg = split(/&/,$argscript);
#foreach $pair (@valarg) {
#    ($name,$value) = split(/=/,$pair);
#    $value =~ tr/+/ /;
#    $name =~ tr/[a-z]/[A-Z]/;
#    $value =~ tr/[A-Z]/[a-z]/;
##    $value = "-" if ($value eq '');
#    if (!($seen{"$namescript $name"}++)) {
#            $argunique{$namescript}++;
#            $scriptdata{$namescript,$argunique{$namescript}} = $name;
##            }
##    if (!($seen{"$namescript $name $value"}++)) {
#            $nameunique{$namescript,$name}++;
#            $countargval{$namescript,$name,$nameunique{$namescript,$name}} = $value;
##	    print "Adding $nameunique{$namescript,$name} $namescript $name $value\n";
#            }          
#    $countarg{$namescript,$name,$value}++;
#}
#$script{$namescript}++;
#$scriptunique++ if ($script{$namescript} == 1);
#}
#}

($tmp) = split(/:/,$date);
($daytoday,$monthtoday,$yeartoday) = split(/\//,$tmp);
next if ($month_equiv{$monthtoday} !~ /(\d+)/);
next if (length($yeartoday) != 4);

#####

### virtual host (NECLF)

if ($vserver ne '') {
$vserver =~ s/[()]//g;
$virtual{$vserver}++;
$virtualsize{$vserver} += $requetesize;
$virtualunique++ if ($virtual{$vserver} == 1);
}


### Scripts
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
#    $value = "-" if ($value eq '');

    if (!($seen{"$namescript $name"}++)) {
            $argunique{$namescript}++;
            $scriptdata{$namescript,$argunique{$namescript}} = $name;
#            }

#    if (!($seen{"$namescript $name $value"}++)) {
            $nameunique{$namescript,$name}++;
            $countargval{$namescript,$name,$nameunique{$namescript,$name}} = $value;
#	    print "Adding $nameunique{$namescript,$name} $namescript $name $value\n";
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

if ($adresse =~ m/$localdomaine/) {
     $domreq++;
     $domsize += $requetesize;
     $reqdomtot++;
     } else {
         $externesize += $requetesize;
         }

### requetes totales

$reqtot++;
$totsize += $requetesize;
$totsizejour += $requetesize;
$reqtotjour++;

### liste des acces par pays

if ($precision > 2) {
$pays = "Unknown" if ($pays =~ /^[0-9]+/);
$pays = substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)) if ($adresse =~ /$localdomaine/);
$payslist{$pays}++;
$sizepays{$pays} += $requetesize;
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
   $listadresse[$serverunique] = $adresse;
   $serverunique++ if ($adresse !~ m/$localdomaine/);
   $locserver++ if ($adresse =~ m/$localdomaine/);
   $nbpageserveur{$adresse}=0;
   $serverpays{$pays}++;
}

### machine local (domaine) se connectant par jour

$serverjour{$adresse}++;
if (($serverjour{$adresse}) == 1) {
   $listadressejour[$serveruniquejour] = $adresse;
   $serveruniquejour++;
   $newhost++ unless ($seen{$adresse}++);
if ($fullday == 1) {
   $locserverjour++ if ($adresse =~ m/$localdomaine/);
   $paysjourlist{$pays}++;
}
}

### Classement par type de fichiers

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

### chargement des pages lues pour chaque serveur

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
    $tothtmlsize += $requetesize;
    $tothtmlsizejour += $requetesize;
    $pageslues{$page}++;
if ($fullday == 1) {
    $pagesluesday{$page}++;    
    $pageuniquejour++ unless ($pagesluesday{$page} != 1);
}
    $pageunique++ unless ($pageslues{$page} != 1);

   }
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
    $pageuniquejour++ unless ($pagesluesday{$page} != 1) ;
}
    $pageunique++ unless ($pageslues{$page} != 1) ;
   }   
}

### chargement des adresses pour quelques pages selectionnees

if ($precision > 2) {
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
   
#     $p = 100*$freqrachtml{$racine}/$access;

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
#     }

   $totsize{$racinebis} += $requetesize;
   $extsize{$racinebis} += $requetesize if ($adresse !~ m/$localdomaine/);
   $domsize{$racinebis} += $requetesize if ($adresse =~ m/$localdomaine/);

   $freqtotsize{$racinebis} += $requetesize;
   $freqextsize{$racinebis} += $requetesize if ($adresse !~ m/$localdomaine/);
   $freqdomsize{$racinebis} += $requetesize if ($adresse =~ m/$localdomaine/);

   $freq2totsize{$racine} += $requetesize if ($scandirrec == 0);
   
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

#   for ($i=0;$i<=($#extension);$i++) {
    if (substr($page,rindex($page,'.')) =~ /$extension/i) {   
#    if (substr($page,rindex($page,'.')+1) =~ /^$extension[$i]$/i) {
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
#     }   
   $freq2totsize{$racine} += $requetesize; # if ($scandirrec == 0);
   $freqjourrac{$racinebis}++;
   }
   # fin du else
  }

# fin du ($precision > 2)
}

}

close (FILE);

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

#################################################################
#####  append des fichiers pour cron-jour, semaines et mois #####
#################################################################

if ($onlyone != 1) {

#open(FILESIZE,">>$dirdate$filesize") || die "Error, unable to open $dirdate$filesize\n";
open(FILEREPERTSIZE,">>$path$dirdata$dirsep$filerepertsize") || die "Error, unable to open $path$dirdata$dirsep$filerepertsize\n";
open(FILEDATE,">>$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";
open(STATREPERT,">>$path$dirdata$dirsep$statrepert") || die "Error, unable to open $path$dirdata$dirsep$statrepert\n";


$nbdays++;
#$newhost = $serveruniquejour;

#for ($j=0;$j<($serverunique-$serveruniquejour);$j++) {

#        $adressetmp = $listadresseold[$j];
#        for ($i=0;$i<$serveruniquejour;$i++) {
#           $newhost-- if ($adressetmp eq $listadressejour[$i]);
#           last if ($adressetmp eq $listadressejour[$i]);
#        }
#}

#undef (@listadresseold);

if ($precision > 1) {
print FILEDATE "$jour \t $serveruniquejour \t $newhost \t $locserverjour \t $reqtotjour \t $domreq \t $accessjour \t $totsizejour \t $tothtmlsizejour\n";

#print FILESIZE "$jour \t $totsize $externesize $domsize \n";

print FILEREPERTSIZE "$jour \t";
for ($i=0;$i<=($#selecrepert);$i++) {
$rootrepert = $selecrepert[$i];
#chop($rootrepert);
print FILEREPERTSIZE "$sizejourrachtml{$rootrepert} $sizejourrachtmlext{$rootrepert} $sizejourrachtmldom{$rootrepert} $totsize{$rootrepert} $extsize{$rootrepert} $domsize{$rootrepert} \t ";
}
print FILEREPERTSIZE "\n";

print STATREPERT "$jour \t ";
for ($i=0;$i<=($#selecrepert);$i++) {
$rootrepert = $selecrepert[$i];
#chop($rootrepert);
print STATREPERT "$freqjourrac{$rootrepert} \t ";
}
print STATREPERT "\n";
}

#close(FILESIZE);
close(FILEREPERTSIZE);
close(FILEDATE);
close(STATREPERT);
}

#############################################################################

&save_reverse_dns if ($reverse_dns == 1); # sauvegarde de la table de DNS

#

@tmp = @selecdate;

for ($i=0;$i<=$#selecdate;$i++) {
    $dateread = shift(@tmp);
    ($dateread) = split(/:/,$date);
    ($daytoday,$monthtoday,$yeartoday) = split(/\//,$dateread);
    $ydayyesterday = 0;
    $countmonth = 0;
    $month_end = $month_nb[$countmonth];

     while ($month_end ne $monthtoday) {
     $ydayyesterday += $month_of_year{$month_end};
     $countmonth++;
     $month_end = $month_nb[$countmonth];
     }

     $ydayyesterday += $daytoday + ($yeartoday*365);

    if ($ydayyesterday < ($ydaystarttoday - $nbdayscf)) {
	shift(@selecpages);
	shift(@selecdate);
	shift(@selecadresse);
#    print "$dateread - $ydayyesterday - $ydaystarttoday - $nbdayscf\n";


    }

}


#################################################################
#####          sauvegarde des nouvelles valeurs             #####
#################################################################

$hitexcl = $excladdr + $exclpages + $notfound + $forbiden + $redirect + $proxy + $exclframed + $exclrobots;

if ($onlyone != 1) {

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
	    print SCRIPT "^" if ($j == 1);
	    $tmp = $scriptdata{$val,$j};
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

open(PAGESLUES,"$path$dirinc$dirsep$incpage") || die "Error, unable to open $path$dirinc$dirsep$incpage\n";
while (<PAGESLUES>) {
($page,$chiffre,@tmp) = split;
for ($i=0;$i<$#tmp;$i++) {
$tmpage{$i,$page} = $tmp[$i];
}
}
close PAGESLUES;

$tmpagenb = $#tmp-1;

open(PAGESLUES,">$path$dirinc$dirsep$incpage") || die "Error, unable to open $path$dirinc$dirsep$incpage\n";
foreach $page (sort keys(%pageslues)) {
print PAGESLUES "$page $pageslues{$page}";
$pagesluesday{$page} = 0 if ($pagesluesday{$page} eq '');

print PAGESLUES " $pagesluesday{$page}";
for ($i=0;$i<=$tmpagenb;$i++) {
$tmpage{$i,$page} = 0 if ($tmpage{$i,$page} eq '');
print PAGESLUES " $tmpage{$i,$page}";
}
print PAGESLUES "\n";

}
close PAGESLUES;

open(PAYS,">$path$dirinc$dirsep$incpays") || die "Error, unable to open $path$dirinc$dirsep$incpays\n";
foreach $pays (sort keys(%payslist)) {
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
foreach $adresse (sort keys(%server)) {
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
foreach $adresse (sort keys(%localserver)) {
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
foreach $racine (sort keys(%freqrac)) {
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

}

#################################################################
#####                       summary day                     #####
#################################################################

if ($fullday == 1 && $abort == 0) {

print STDOUT "Creating day summary\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$jour =~ s/ /\//g;

# Tri Pages

foreach $tmp (sort (keys(%pagesluesday))) {
    push(@counterpage,$pagesluesday{$tmp}) unless $seen{"$jour $tmp $pagesluesday{$tmp}"}++;
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
    push(@counterserver,$serverjour{$tmp}) unless $seen{"$jour $tmp $serverjour{$tmp}"}++;
    $countserver[$serverjour{$tmp}]++;
    $occur_counterserver{$serverjour{$tmp},$countserver[$serverjour{$tmp}]} = $tmp;
}

@bestserverjour = reverse sort bynumber @counterserver;

# Tri Countries

foreach $tmp (sort (keys(%paysjour))) {
    push(@counterpays,$paysjour{$tmp}) unless $seen{"$jour $tmp $paysjour{$tmp}"}++;
    $countpays[$paysjour{$tmp}]++;
    $occur_counterpays{$paysjour{$tmp},$countpays[$paysjour{$tmp}]} = $tmp;
}

@bestpaysjour = reverse sort bynumber @counterpays;

$jour =~ s/[\/]/ /g;

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

## ML support

($tmp1,$tmp2,$tmp3) = split(/\//,$yesterday);
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

foreach $tmp (keys(%pagesluesday)) {
#for ($i=0;$i<=$countpage[$pagesluesday{$tmp}];$i++) {
#$occur_counterpage{$pagesluesday{$tmp},$i} = '';
#}
$countpage[$pagesluesday{$tmp}] = 0;
#$pagesluesday{$tmp} = 0;
}

undef %occur_counterpage;
#undef %pagesluesday;
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

foreach $tmp (keys(%paysjour)) {
$countpays[$paysjour{$tmp}] = 0;
}

undef %occur_counterpays;
undef %paysjour;
undef @counterpays;

}

undef %serverjour;
undef %sizejourrachtml;
undef %freqjourrachtml;

print STDOUT "End of processing...\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

############

# date il y a $nbdays jours

if ($nbdayscf != 0 ) {

($pastday,$pastmonth,$pastyear) = split(/\//,$yesterday);

$monthindextmp = $month_equiv{$pastmonth};
$monthindextmp--;
$pastday = $pastday  - $nbdayscf; 

while ($pastday < 1) {
  $monthindextmp--;
  if ($monthindextmp < 0) {
      $pastyear--;
      $monthindextmp = 11;
   }
   $pastmonth = $month_nb[$monthindextmp];
   $pastday = $pastday + $month_of_year{$pastmonth};
}

$tmp = $pastyear."-".$pastmonth."-".$pastday;
for ($nblang=0;$nblang<=$#lang;$nblang++) {
$dir = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tmp;
&dodirdel($dir);
rmdir("$dir") if -d $dir;
}
}
###
}

############ fin de la boucle generale sur les jours manquants
############

#################################################################
#####          affichage des nouvelles valeurs              #####
#################################################################

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
               for ($j=0;$j<= $i;$j++) {
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
               for ($j=0;$j<= $i;$j++) {
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
               for ($j=0;$j<= $i;$j++) {
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
               for ($j=0;$j<= $i;$j++) {
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
               for ($j=0;$j<= $i;$j++) {
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
               for ($j=0;$j<= $i;$j++) {
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

$yesterday =~ s/[\/]/ /g;

#########################################################################
####                                                                #####
####              FABRICATION DES PAGES HTML                        #####
####                                                                #####
#########################################################################

print STDOUT "Creating frames header\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
print FOUT "<A HREF=\"..$dirsepurl..$dirsepurl$homepages[$i]\" TARGET=\"_top\"><IMG BORDER=0 WIDTH=30 HEIGHT=15 SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$flag[$i]\"></A>  \n" unless ($I eq $lang[$i]);
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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filerepert\" TARGET=\"display\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_dir\" BORDER=0></A><BR>\n";
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


###

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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "<META NAME=\"ROBOTS\" CONTENT=\"NOFOLLOW\">";
print FOUT "</HEAD>\n";

print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<H1> <IMG WIDTH=49 HEIGHT=49 SRC=\"$linkpathinit$dirress$dirsepurl$drawstat\"> $L{'Stats'} $firstday - $yesterday</H1><P>\n";

print FOUT "<HR>";
for ($i=0;$i<=$#lang;$i++) {
print FOUT "<A HREF=\"$homepages[$i]\"><IMG border=0 WIDTH=30 HEIGHT=15 SRC=\"$linkpathinit$dirress$dirsepurl$flag[$i]\"> $lang[$i]</A>  \n" unless ($I eq $lang[$i]);
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
print FOUT "<TD ALIGN=RIGHT><I><FONT SIZE=2>$L{'Stats'} $L{'computed_with'} <A HREF=\"$linkpathinit$dirdocs$dirsepurl$help\">W3Perl $version</A> </FONT></I></TD>\n";
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
print FOUT1 "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT1 "<META NAME=\"ROBOTS\" CONTENT=\"NOFOLLOW\">";
print FOUT1 "</HEAD>\n";

print FOUT1 "<FRAMESET ROWS=\"8\%,*,10\%\" FRAMESPACING=0 BORDER=false FRAMEBORDER=0>\n" if ($frame_updown == 1);
print FOUT1 "<FRAMESET COLS=\"8\%,*,8\%\" FRAMESPACING=0 BORDER=false FRAMEBORDER=0>\n" if ($frame_updown == 0);
print FOUT1 "<FRAME SCROLLING=\"auto\"  NAME=\"top\"  MARGINHEIGHT=0 MARGINWIDTH=0 SRC=\"$I$dirsepurl$dirframe$dirsepurl$topframe\">\n";
print FOUT1 "<FRAME SCROLLING=\"auto\" NAME=\"display\"  MARGINHEIGHT=0 MARGINWIDTH=0 SRC=\"$I$dirsepurl$dirframe$dirsepurl$J\">\n";
print FOUT1 "<FRAME SCROLLING=\"auto\"  NAME=\"bottom\"  MARGINHEIGHT=0 MARGINWIDTH=0 SRC=\"$I$dirsepurl$dirframe$dirsepurl$bottomframe\">\n";
print FOUT1 "</FRAMESET>\n";

print FOUT1 "<NOFRAMES>\n";

print FOUT1 "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT1 "<H1> <IMG WIDTH=49 HEIGHT=49 SRC=\"$linkpathinit$dirress$dirsepurl$drawstat\"> $L{'Stats'} $firstday - $yesterday</H1><P>\n";
print FOUT1 "<HR>\n";

for ($i=0;$i<=$#lang;$i++) {
print FOUT1 "<A HREF=\"$homepages[$i]\" TARGET=\"_top\"><IMG BORDER=0 WIDTH=30 HEIGHT=15 SRC=\"$linkpathinit$dirress$dirsepurl$flag[$i]\"> $lang[$i]</A> \n" unless ($I eq $lang[$i]);
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
print FOUT1 "<TD COLSPAN=3 ALIGN=LEFT>$L{'Total'}</TD><TD ALIGN=RIGHT BGCOLOR=\"#00FFFF\">$hitexcl</TD>\n";
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
print FOUT1 "<A HREF=\"$I$dirsepurl$dirlist$dirsepurl$filerepert\"><IMG WIDTH=34 HEIGHT=34 SRC=\"$homeicons$dirsepurl$icon_dir\" BORDER=0></A>\n";
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
print FOUT2 "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
print FOUT2 "<TD ALIGN=LEFT COLSPAN=3>$L{'Total'}</TD><TD ALIGN=RIGHT BGCOLOR=\"#00FFFF\">".($loglines - $reqtot)."</TD>\n";
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
print FOUT2 "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filerepert\"><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_dir\" BORDER=0></A>\n";
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

### delete external

    for ($nblang=0;$nblang<=$#lang;$nblang++) {

    unlink ("$path$lang[$nblang]$dirsep$dirsite$dirsep$localdomainename");

    foreach $site (keys(%server)) {
        if ($server{$site} > $seuilpage) {    
        $newsite = $site;
        $newsite =~ s/[.]/_/g;
        $newsite .= $htmlext;
        if ($site !~ /^[0-9.]+$/) {
            $pospoint = index($newsite,'_',0);
            $domadresse = substr($newsite,$pospoint+1,(length($newsite)-length($pospoint)));
            unlink ("$path$lang[$nblang]$dirsep$dirsite$dirsep$domadresse");
        } else {
            unlink ("$path$lang[$nblang]$dirsep$dirsite$dirsep$newsite");
        }
    }

    }
    }


### delete local

    if ($locallog != 0) {
    for ($nblang=0;$nblang<=$#lang;$nblang++) {

        foreach $site (keys(%localserver)) {

        if ($localserver{$site} > $seuilpage) {    
        $newsite = $site;
        $newsite =~ s/[.]/_/g;
        $newsite .= $htmlext;
        if ($site !~ /^[0-9.]+$/) {
            $pospoint = index($newsite,'_',0);
            $domadresse = substr($newsite,$pospoint+1,(length($newsite)-length($pospoint)));
            unlink ("$path$lang[$nblang]$dirsep$dirsite$dirsep$domadresse");
        } else {
            unlink ("$path$lang[$nblang]$dirsep$dirsite$dirsep$newsite");
        }
    }

    }
    }
}


### create 

    for ($nblang=0;$nblang<=$#lang;$nblang++) {            
        &Pagesbysites(*LITTLEINDEX, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
    }
}



### creation des nouveaux....

# serveur externe

sub Pagesbysites {
    local(*FOUT,*L,$I) = @_;

    foreach $site (keys(%server)) {
#        if ($nbpageserveur{$site} > $seuilpage) { # pages HTML
        if ($server{$site} > $seuilpage) {  # requetes 
        $newsite = $site;
        $newsite =~ s/[.]/_/g;
        $newsite .= $htmlext;
        if ($site =~ /^[0-9.]+$/) {
            open(PAGESITE,">$path$I$dirsep$dirsite$dirsep$newsite") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$newsite\n";
            print PAGESITE "<HTML><HEAD>\n";
            print PAGESITE "<TITLE>$L{'Pages'} HTML $L{'read_by'} $site </TITLE>\n";
            print PAGESITE "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
                print PAGESITE "<TITLE>$L{'Pages'} HTML $L{'read_by'} $L{'domain'} $domadresse </TITLE>\n";
                print PAGESITE "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
                print PAGESITE "</HEAD>\n";
                print PAGESITE "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
            }
            
        }

        print PAGESITE "<A NAME=\"$site\">\n";
        print PAGESITE "<H1> $L{'Pages'} $L{'read_by'} $site</H1>\n";
        print PAGESITE "<I>(",($nbpageserveur{$site}+1)," ";
        print PAGESITE "$L{'pages'}" if ($nbpageserveur{$site} != 1);
        print PAGESITE "$L{'page'}" if ($nbpageserveur{$site} == 1);
        print PAGESITE " HTML";
        print PAGESITE " $L{'among'} $server{$site} ";
        print PAGESITE "$L{'request'}" if ($server{$site} == 1);
        print PAGESITE "$L{'requests'}" if ($server{$site} != 1);
        print PAGESITE ")</I>\n";
        print PAGESITE "<P><HR><P>\n";
	print PAGESITE "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";

        for ($i=0;$i<=($nbpageserveur{$site});$i++) {
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
#            if ($site =~ /^[0-9.]+$/) {
#                open(PAGESITE,">$path$I$dirsep$dirsite$dirsep$newsite") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$newsite\n";
#                print PAGESITE "<HTML><HEAD>\n";
#                print PAGESITE "<TITLE>$L{'Pages'} HTML $L{'read_by'} $site </TITLE>\n";
#                print PAGESITE "</HEAD>\n";
#                print PAGESITE "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
#            }
#            else {
                $pospoint = index($newsite,'_',0);
                $domadresse = substr($newsite,$pospoint+1,(length($newsite)-length($pospoint)));
                
                # si le fichier existe deja, on ajoute l'adresse dans le fichier de domaine
                
                if (-e "$path$I$dirsep$dirsite$dirsep$domadresse") {
                    open(PAGESITE,">>$path$I$dirsep$dirsite$dirsep$domadresse") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$domadresse\n";
                } else {
                    open(PAGESITE,">$path$lang[$nbalng]$dirsep$dirsite$dirsep$domadresse") || die "Error, unable to open $path$I$dirsep$dirsite$dirsep$domadresse\n";
                    print PAGESITE "<HTML><HEAD>\n";
                    print PAGESITE "<TITLE>$L{'Pages'} HTML $L{'read_by'} $L{'domaine'} $domadresse </TITLE>\n";
                    print PAGESITE "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
                    print PAGESITE "</HEAD>\n";
                    print PAGESITE "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
                }
#            }
            print PAGESITE "<A NAME=\"$site\">\n";
            print PAGESITE "<H1> $L{'Pages'} HTML $L{'read_by'} $site </H1>";
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

            for ($i=0;$i<=($nbpageserveur{$site});$i++) {
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
    }

### enfin ajout du </BODY></HTML> sur tous les fichiers

# sites externes

    foreach $site (keys(%server)) {
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
    
# sites locaux

    if ($locallog != 0) {
        foreach $site (keys(%localserver)) {
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

# mise en forme du fichier de sortie

sort @list;

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
$add = $add + $ydaystarttoday +1 - $lastday_nb if ($tmp > $nbdayscf);
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

#print "$k2 - $add - $pagesel{$selection[$i],$k}\n";

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

###

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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<h1> $L{'Hosts'} $L{'connecting_to'} $L{'page'} $selection[$i] </H1>\n";
print FOUT "<P><HR><P>\n";

if ($found !=0) {

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
        print FOUT "<IMG WIDTH=$tmp2 height=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
        print FOUT "<B>$payslist{$pays}</B></TD>";
        printf FOUT "<TD ALIGN=RIGHT>%3.1f %",$percentage;
        print FOUT "</TD>\n";

	$percentage = 0;
        $percentage = ($payshtml{$pays}*100)/$zonehtml[$zone] if ($payshtml{$pays} != 0);
        $tmp2 = int($percentage);
        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp2 height=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">&nbsp;" if ($tmp2 != 0);
        printf FOUT "<B>%d</B></TD>",$payshtml{$pays};
        printf FOUT "<TD ALIGN=RIGHT>%3.1f %",$percentage;
        print FOUT "</TD>\n";

	$percentage = 0;
        $percentage = ($serverpays{$pays}*100)/$zoneserver[$zone] if ($serverpays{$pays} != 0);
        $tmp2 = int($percentage);
        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp2 height=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">&nbsp;" if ($tmp2 != 0);
        print FOUT "<B>$serverpays{$pays}</B>";
        print FOUT "</TD>\n";
        printf FOUT "<TD ALIGN=RIGHT>%.1f %",$percentage;
        print FOUT "</TD>\n";        

	$percentage = 0;
        $percentage = $sizepays{$pays}*100/$zonesize[$zone] if ($sizepays{$pays} != 0);
        $tmp = int($percentage);

        print FOUT "<TD>\n";
        print FOUT "<IMG WIDTH=$tmp height=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">&nbsp;" if ($tmp != 0);
        printf FOUT "<B>%d</B></TD>",$sizepays{$pays};
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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
print FOUT "<IMG WIDTH=$tmp2 height=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
print FOUT "<B><FONT SIZE=-1>$payslist{Unknown}</FONT></B></TD>\n";
printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%3.1f %</FONT>",$pourcentpaysunknown;
print FOUT "</TD><TD>&nbsp;";
$tmp2 = int($pourcentpays2unknown);
print FOUT "<IMG WIDTH=$tmp2 height=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">&nbsp;" if ($tmp2 != 0);
printf FOUT "<B><FONT SIZE=-1>%d</FONT></B></TD>",$payshtml{Unknown};
printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%3.1f %</FONT>",$pourcentpays2unknown;
print FOUT "</TD><TD>&nbsp;";
$tmpa = $serverpays{Unknown}*100/($serverunique+$locserver) if ($localonly != 1);
$tmpa = $serverpays{Unknown}*100/$locserver if ($localonly == 1);
$tmp2 = int($tmpa);
print FOUT "<IMG WIDTH=$tmp2 height=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\">&nbsp;" if ($tmp2 != 0);
print FOUT "<B><FONT SIZE=-1>$serverpays{Unknown}</FONT></B>";
print FOUT "</TD>\n";
printf FOUT "<TD ALIGN=RIGHT><FONT SIZE=-1>%.1f %</FONT>",$tmpa;
print FOUT "</TD><TD>&nbsp;";        
        
print FOUT "<IMG WIDTH=$tmp height=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\">&nbsp;" if ($tmp != 0);
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
        print FOUT "<TD ALIGN=CENTER><A HREF=\"$flagpage{$pays}\"\>";
        print FOUT "$L{$newflag{$pays}}</A>";
#        print FOUT " <I>($L{'all_sites'})</I>" if ($locallog == 1 && $pays eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)));
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
        printf FOUT "<B>%d</B></TD>",$tmpb;
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
        $tmpa -= ($totsize-$externesize)*1024 if ($locallog == 1 && $pays eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)));;
        $pourcentvalue = $tmpa*100/($externesize*1024);        
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
print FOUT "<TD ALIGN=CENTER><A HREF=\"$linkdirpays$unresolved\"\>$L{'List_of_unresolved_hosts'}</A> </td><TD>\n";
$tmp2 = int($pourcentpaysunknown);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
print FOUT "<B>$payslist{Unknown}</B></TD>\n";
printf FOUT "<TD ALIGN=RIGHT>%3.1f",$pourcentpaysunknown;
print FOUT "</TD><TD>\n";
if ($locallog == 1 && $localonly == 0) {
$tmpb = $payslist{Unknown};
#$tmpb -= $reqdomtot if ($locallog == 1 && $pays eq substr($localdomainename,(rindex($localdomainename,'.')+1),length($localdomaine)));;
$tmpb -= $reqdomtot if ($locallog == 1 && $paysunique == 0);
$tmpa = $tmpb*100/($reqtot-$reqdomtot) if ($reqtot != $reqdomtot);
$tmpa = 100 if ($reqtot == $reqdomtot);
$tmp2 = int($tmpa);
print FOUT "<IMG WIDTH=$tmp2 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">&nbsp;" if ($tmp2 != 0);
printf FOUT "<B>%d</B></TD>",$tmpb;
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
#$pourcentvalue = $tmpa*100/($externesize*1024);        
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
         }
}
$sizepays{$bestsizepays[$i]} = 0;
}

### graphs camenbert

$deg1 = 0;
$deg2 = 0;

for ($i=0;$i <= $paysunique;$i++) {
$maxi = 0;
foreach $pays (keys(%payslist)) {
$sizesortpays = $sizepays{$pays}/($totsize*1024);
if ($sizesortpays > $maxi) {
         $maxi = $sizesortpays;
         $bestsizepays[$i] = $pays;
         $occursizepays[$i] = $sizesortpays;
         }
}
$sizepays{$bestsizepays[$i]} = 0;
}

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ymax\n";
print FLY "frect 0,0,0,0,1,2,3\n";

print FLY "arc $halfxmax,$halfymax,$diam,$diam,0,360,0,0,0\n";

for ($i=0;$i<= $paysunique;$i++) {

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

#print STDOUT "Completion du camenbert de $deg1 a $deg2 !\n";

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

$deg1 = $deg2;
$deg2 += $occursizepays[$i]*360;
$deg1 = ($deg1 + $deg2)/2;

$posx = $halfxmax+(cos($deg1*$piradiant)*$rayon/2);
$posy = $halfymax+(sin($deg1*$piradiant)*$rayon/2);

# print the country name
if (100*$occursizepays[$i] > 5) {
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

print FLY "transparent 1,2,3\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$paysgraph |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

###
### deuxieme graph camembert
###

if ($locallog == 1) {

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

# header des fichiers pour chaque pays

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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
        print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Domain'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Date'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Hosts'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Percentage'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Hits'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Percentage'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'HTML_pages'}&nbsp;</TH>";
        print FOUT "<TH ALIGN=CENTER>&nbsp;$L{'Percentage'}&nbsp;</TH>";        
        print FOUT "</TH></TR>\n";
}


#################################################################
###                    day summary                            ###
#################################################################

sub PageResumeFrame {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $yesterday - Frame</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";

  print FOUT "<FRAMESET COLS=\"35%,*\" FRAMESPACING=0 BORDER=false FRAMEBORDER=0>\n";
  print FOUT "<FRAME SCROLLING=\"auto\" MARGINHEIGHT=0 MARGINWIDTH=0 NAME=\"left\" SRC=\"menu.html\">\n";
  print FOUT "<FRAME SCROLLING=\"auto\" MARGINHEIGHT=0 MARGINWIDTH=0 NAME=\"right\" SRC=\"$filemoyenne\">\n";
  print FOUT "</FRAMESET>\n";

  print FOUT "<NOFRAMES>\n";


print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

($tmp,$monthletter) = split(/\//,$yesterday);

print FOUT "<TABLE WIDTH=100%><TR>\n";

print FOUT "<TD WIDTH=33%>";
print FOUT "<A HREF=\"..$dirsepurl$tabnamedays#$nbdayscf\" TARGET=\"display\">$L{'Tab_about_lastdays1'} $nbdayscf $L{'Tab_about_lastdays2'}</A><P>\n";
print FOUT "</TD>\n";

$tmp = $yesterday;
$tmp =~ s/\// /g;

print FOUT "<TD WIDTH=33% ALIGN=CENTER><H1>$L{'Stats'} : $tmp</H1></TD>\n";

#$linkjour = "..".$dirsepurl.$dirsession.$dirsep.$dirdate.$dirsep.$tmp."-".$monthletter."-".$year.$htmlext;
#$fulljour = $path.$lang[$nblang].$dirsep.$dirsession.$dirsep.$dirdate.$dirsep.$tmp."-".$monthletter."-".$year.$htmlext;

print FOUT "<TD WIDTH=33%>";
#print FOUT "<A HREF=\"$linkjour\">$L{'Session'}</A><P>\n" if (-e $fulljour);

$linkjour = "..".$dirsepurl."..".$dirsepurl.$dirsession.$dirsep.$filemoyenne;
$fulljour = $path.$lang[$nblang].$dirsep.$dirsession.$dirsep.$filemoyenne;

print FOUT "<A HREF=\"$linkjour\">$L{'Average'} $L{'about_hours_and_days'}</A>\n" if (-e $fulljour);

print FOUT "</TD>\n";

print FOUT "</TR></TABLE>\n";
print FOUT "<P><HR><P>\n";

print FOUT "<TABLE CELLPADDING=3 BORDER=0><TR><TD>";

print FOUT "<TABLE BORDER=1 CELLPADDING=2><TR>";
print FOUT "<TD><I>$L{'Requests'}</I></TD><TD ALIGN=CENTER BGCOLOR=\"#00FFFF\">$reqtotjour</TD>\n";
print FOUT "<TD><I>$L{'Hosts'}</I></TD><TD ALIGN=CENTER>$serveruniquejour</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD><I>$L{'HTML_pages'}</I></TD><TD ALIGN=CENTER BGCOLOR=\"#00FF00\">$accessjour</TD>\n"; 
print FOUT "<TD><I>$L{'New_Hosts'}</I></TD><TD ALIGN=CENTER>$newhost</TD>\n";
print FOUT "</TR><TR>\n";
$tmp = int($totsizejour/1024);
print FOUT "<TD><I>$L{'Total_traffic'}</I></TD><TD ALIGN=CENTER BGCOLOR=\"#CCCCCC\">$tmp $L{'Kb'}</TD>";
print FOUT "<TD><I>$L{'Countries'}</I></TD><TD ALIGN=CENTER>$paysuniquejour</TD>\n";
print FOUT "</TR><TR>\n";
$tmp = int($tothtmlsizejour/1024);
print FOUT "<TD><I>$L{'Traffic'} $L{'HTML_pages'}</I></TD><TD ALIGN=CENTER>$tmp $L{'Kb'}</TD>\n";
print FOUT "<TD><I>$L{'New_country'}</I></TD><TD ALIGN=CENTER>$paysjournew</TD>\n";
print FOUT "</TR></TABLE>\n";

if ($locallog == 1 || $localonly == 1) {

print FOUT "<P><BR>";

print FOUT "<TABLE BORDER=1><TR>";
print FOUT "<TD COLSPAN=2><I>$L{'Domain'}</I> : $localdomainename</TD>\n";
print FOUT "</TR><TR>";
print FOUT "<TD><I>$L{'Requests'}</I></TD><TD ALIGN=CENTER>$domreq</TD></TR><TR>\n";
print FOUT "<TD><I>$L{'Hosts'}</I></TD><TD ALIGN=CENTER>$locserverjour</TD></TR><TR>\n";
print FOUT "<TD><I>$L{'Traffic'}</I></TD><TD ALIGN=CENTER>",(int($domsize-$domsize2)/1024)," $L{'Kb'}</TD>\n";
print FOUT "</TR></TABLE>\n";

}

print FOUT "</TD></TR></TABLE><P>";

###

print FOUT "<TABLE BORDER=0 WIDTH=100%>\n";
print FOUT "<TR>\n";
print FOUT "<TD ALIGN=CENTER><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_countries\" BORDER=0></TD>\n";
print FOUT "<TD ALIGN=CENTER><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_dir\" BORDER=0></TD>\n";


print FOUT "</TR><TR><TD ALIGN=CENTER VALIGN=TOP>";

# Countries


print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Countries'}</TH><TH ALIGN=CENTER>$L{'Requests'}</TH><TH ALIGN=CENTER>$L{'Hosts'}</TH>\n";
for ($i=0;$i<$paysuniquejour;$i++) {
#$pays = $paysuniquejourlist[$i];
$pays = $bestpaysjour[$i];
print FOUT "<TR><TD>$L{$newflag{$pays}}</TD><TD ALIGN=CENTER>$paysjour{$pays}</TD><TD ALIGN=CENTER>$paysjourlist{$pays}</TD></TR>\n"; 
}
print FOUT "</TR></TABLE>\n";

print FOUT "</TD><TD ALIGN=CENTER VALIGN=TOP>";

# Directories

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Directories'}</TH><TH ALIGN=CENTER>$L{'HTML_pages'}</TH><TH ALIGN=CENTER>$L{'Traffic'} HTML</TH>";
for ($i=0;$i<=$topten;$i++) {
#$rootrepert = $selecrepert[$i];
$rootrepert = $bestselecrepert[$i];
if ($freqjourrachtml{$rootrepert} ne '') {
print FOUT "<TR><TD>$rootrepert</TD><TD ALIGN=CENTER>$freqjourrachtml{$rootrepert}</TD>";
$tmp = int($sizejourrachtml{$rootrepert}/1024);
print FOUT "<TD ALIGN=CENTER>$tmp $L{'Kb'}</TD></TR>";
}
}
print FOUT "</TR></TABLE>\n";


print FOUT "</TD></TR><TR>";
print FOUT "<TD ALIGN=CENTER><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_hosts\" BORDER=0></TD>\n";
print FOUT "<TD ALIGN=CENTER><IMG WIDTH=34 HEIGHT=34 SRC=\"..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_pages\" BORDER=0></TD>\n";

print FOUT "</TR><TR><TD ALIGN=CENTER VALIGN=TOP>";

# Hosts

print FOUT "<TABLE BORDER=1>";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Hosts'}</TH><TH ALIGN=CENTER>$L{'Requests'}</TH></TR>";
for ($i=0;$i<$serveruniquejour;$i++) {
$adresse = $bestserverjour[$i];
print FOUT "<TR><TD>$adresse</TD><TD ALIGN=CENTER>$serverjour{$adresse}</TD></TR>\n";
}
print FOUT "</TABLE><P>\n";


print FOUT "</TD><TD ALIGN=CENTER VALIGN=TOP>";

# Pages

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Pages'}</TH><TH ALIGN=CENTER>$L{'Occurence'}</TH>\n";
for ($i=0;$i < $pageuniquejour;$i++) {
$page = $bestpagesluesday[$i];

if ($pagesluesday{$page} != 0) {
print FOUT "<TR><TD>";
print FOUT "$page" if ($titlename == 0);
print FOUT "$urlconv{$page}" if ($titlename == 1 && $urlconv{$page} ne '');
print FOUT "$page" if ($titlename == 1 && $urlconv{$page} eq '');
print FOUT "</TD><TD ALIGN=CENTER>$pagesluesday{$page}</TD></TR>";
}

}
print FOUT "</TR></TABLE>\n";
print FOUT "<P>\n";

print FOUT "</TD></TR></TABLE>\n";

print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";

  print FOUT "</NOFRAMES>\n";
  print FOUT "</HTML>\n";
}

###

sub PageResumeTab {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $yesterday - $L{'Summary'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

#print FOUT "<CENTER><TABLE WIDTH=100%><TR>\n";

#$tmp = $oldjour;
#$tmp =~ s/\// /g;

#print FOUT "<TD ALIGN=CENTER><H3>$L{'Stats'} $tmp</H3></TD>\n";
#print FOUT "</TR></TABLE></CENTER>\n";

print FOUT "<P>\n";

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
print FOUT "$tmp2 $L{'Mb'}</TD>" if ($tmp >= 1024);
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
print FOUT "</TR></TABLE>\n";

}

print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

###


sub PageResumeMenu {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $yesterday</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

#($tmp,$monthletter) = split(/ /,$yesterday);

$tmp = $yesterday;
$tmp =~ s/\// /g;

($tmp1,$tmp2,$tmp3) = split(/\//,$nextjour);
$nextdayresume = "\.\.$dirsepurl".$tmp3."-".$tmp2."-".$tmp1."$dirsepurl$menu";

($tmp1,$tmp2,$tmp3) = split(/\//,$previousjour);
$previousdayresume = "\.\.$dirsepurl".$tmp3."-".$tmp2."-".$tmp1."$dirsepurl$menu";

print FOUT "<CENTER>\n";
print FOUT "<FONT SIZE=+1><B>$L{'Stats'} $tmp</B></FONT>\n";
print FOUT "<P><TABLE CELLPADDING=2><TR>\n";
print FOUT "<TD ALIGN=RIGHT><A HREF=\"$previousdayresume\" TARGET=\"display\"><!-- PREVIOUS \"..$dirsepurl..$dirsepurl..$dirsepurl$homeicons$dirsepurl$icon_flecheg\" WIDTH=20 HEIGHT=14 BORDER=0>--></A></TD>\n";
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

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Countries'} - $yesterday</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'Countries'} $L{'connecting_to_the_server'} :</H3><P>\n";

print FOUT "<I>$L{'The_Top'} $topten $L{'top'} $L{'resolved_countries'} ($L{'among'} $paysuniquejour)</I> :<P><UL>\n";

#print FOUT "<I>($L{'Only_countries'} $L{'with_at_least'} $seuilsite $L{'requests'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilsite == 1 || $seuilsite == 0);

print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Countries'}</TH><TH ALIGN=CENTER>$L{'Requests'}</TH><TH ALIGN=CENTER>$L{'Percentage'}</TH><TH ALIGN=CENTER>$L{'Hosts'}</TH><TH ALIGN=CENTER>$L{'Percentage'}</TH></TR>\n";

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

print FOUT "</TR></TABLE></CENTER>\n";
print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

####

sub PageResumeHosts {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Hosts'} - $yesterday</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'Hosts'} $L{'connecting_to_the_server'} :</H3><P>\n";

print FOUT "<I>$L{'The_Top'} $topten $L{'top_external_sites'} ($L{'among'} $serveruniquejour)</I> :<P>\n";

#print FOUT "<P><I>($L{'Only_hosts'} $L{'with_at_least'} $seuilsite $L{'requests'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilsite == 1 || $seuilsite == 0);

print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Hosts'}</TH><TH ALIGN=CENTER>$L{'Requests'}</TH><TH>$L{'Percentage'}</TH></TR>";

$tmp = 0;
  $i = 0;
while ($tmp < $topten && $bestserverjour[$i] != 0) {
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

}

print FOUT "</TR></TABLE></CENTER>\n";
print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}


####

sub PageResumeDir {
  local(*FOUT,*L) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Directories'} - $yesterday</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Pages'} - $yesterday</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<H3> $L{'ListOf'} $L{'pages'} $L{'used'} :</H3><P>\n";

print FOUT "<I>$L{'The_Top'} $topten $L{'pages'} ($L{'among'} $pageuniquejour) $L{'MostSuccesf'}</I> :<P>\n";

#print FOUT "<I>($L{'Only_pages'} $L{'with_at_least'} $seuilpage $L{'occurence'} $L{'will_be_printed'})</I>\n<P>" unless ($seuilpage == 1 || $seuilpage == 0);

print FOUT "<P><CENTER><TABLE BORDER=1>\n";
print FOUT "<TR><TH ALIGN=CENTER>$L{'Pages'}</TH><TH ALIGN=CENTER>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";

$tmp = 0;
  $i = 0;
while ($tmp < $topten && $bestpagesluesday[$i] != 0) {
#for ($i=0;$i <$topten;$i++) {

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
print FOUT "</TD><TD ALIGN=CENTER>$bestpagesluesday[$i]</TD><TD ALIGN=LEFT>";
print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
printf FOUT "%.1f %</TD></TR>\n",$percentage;
}
$i += $countpage[$bestpagesluesday[$i]];
#}
}
print FOUT "</TR></TABLE></CENTER>\n";

print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

###

sub PageResumeScript {
  local(*FOUT,*L) = @_;
  local($page);

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} - Summary report $L{'Script'} - $oldjour</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
#        print FOUT "<BR>\n";
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
#        print FOUT "<BR>\n";
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
        print FOUT "<TD ALIGN=CENTER>&nbsp;<B>$serverpays{$pays}</B></TD>\n";
#        print FOUT "$L{'host'}" if ($serverpays{$pays} == 1);        
#        print FOUT "$L{'hosts'}" if ($serverpays{$pays} != 1);                
        print FOUT "<TD ALIGN=CENTER><B>$payslist{$pays}</B></TD>\n";
        print FOUT "<TD ALIGN=CENTER><B>$payshtml{$pays}</B></TD>\n";
#        print FOUT "$L{'request'}" if ($payslist{$pays} == 1);
#        print FOUT "$L{'requests'}" if ($payslist{$pays} != 1);
        print FOUT "<TD ALIGN=CENTER><I>";
        $tmp = $payslist{$pays}/$serverpays{$pays} if ($serverpays{$pays} != 0);
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
                        $tmpserveur = $newserveur;
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
                print FILESITEPAYS " HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\"> ";
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

print STDOUT "Creating pages stats\n";
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
#	print "Creating $tmp\n";
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
  print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
	  print FOUT "<B>$urlconv{$bestpage[$i]}</B>" if ($titlename == 1 && $urlconv{$bestpage[$i]} ne '');
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
	  print FOUT "</I></A> : <b><A HREF=\"$newpage\">$pageslues{$selection[$i]} $L{'times'}</A></b>";
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

#print FOUT "<P><TABLE><TR>\n";
#print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"><FONT SIZE=-1> $L{'Increase_over_the_previous_day'}</FONT></TD>";
#print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\"><FONT SIZE=-1> $L{'Same_over_the_previous_day'}</FONT></TD>";
#print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[0]\"><FONT SIZE=-1> $L{'Decrease_over_the_previous_day'}</FONT></TD>";
#print FOUT "</TR></TABLE>\n";
        
#$tmp = $cday." ".$cmonth;

#$testday = $cday;
#$testmonth = $cmonth;
#$testccmonth = $ccmonth;

#print FOUT "<P><TABLE>\n";
#print FOUT "<TR><TH>$L{'Page_read'}</TH><TH>$L{'Total'}</TH><TH>%</TH>\n";
#print FOUT "<TH><FONT SIZE=-1>$tmp</FONT></TH>\n";
#for ($i=0;$i<=$tmpagenb;$i++) {

#$testday--;
#$testday = "0".$testday if (length($testday) == 1);

#if ($testday < 1) {
#     $testccmonth--;
#     if ($testccmonth < 1) {
#            $testccmonth = 12;
#      }
#      $testmonth = $month_nb[$testccmonth-1];
#      $testday = $month_of_year{$testmonth};
#      }

#$tmp = "$testday"." "."$testmonth";


#print FOUT "<TH><FONT SIZE=-1>$tmp</FONT></TH>\n";
#}
#print FOUT "</TR>\n";

#foreach $page (sort keys(%pageslues)) {
#        if ($pageslues{$page} > $seuilpage) {

#        print FOUT "<TR><TD><A HREF=\"$page\">";
#        print FOUT "$page" if ($titlename == 0);
#        print FOUT "<B>$urlconv{$page}</B>" if ($titlename == 1 && $urlconv{$page} ne '');
#        print FOUT "$page" if ($titlename == 1 && $urlconv{$page} eq '');
#        print FOUT "</A></TD><TD ALIGN=CENTER>";

#        $i=0;
#        $lien=0;
#        if ($precision > 2) {
#            while ($i <= ($#selection)) {
#                 if ($page =~ /^$selection[$i]/) {
#                        $newpage = "page".$i.$htmlext;                 
#                      print FOUT "<B><BLINK><A HREF=\"$newpage\">$pageslues{$page} $L{'times'}</A></B></BLINK>\n";
#                      $lien=1;
#                      }
#                 $i++;
#                 }
#            }
#        print FOUT "<B>$pageslues{$page}</B> $L{'times'}\n" unless ($lien == 1);
        
#        $tmp2 = ($pageslues{$page}-$pagesluesday{$page})*100/($access-$accessjour) if ($access != $accessjour);

#        $tmpa = $pageslues{$page}*100/$access;
#        $tmpstr = "#55FFFF" if (($tmpa - $tmp2) < 0.1);
#        $tmpstr = "#55FF55" if ($tmpa > ($tmp2+0.1));
#        $tmpstr = "#FF5555" if ($tmpa < ($tmp2-0.1));
        
#        $tmp2 = int($tmpa);

#        print FOUT "</TD><TD ALIGN=CENTER BGCOLOR=\"$tmpstr\">";
#        printf FOUT "%.1f",$tmpa;
                
#        print FOUT "</TD><TD ALIGN=CENTER>";
#        print FOUT "$pagesluesday{$page}</TD>";
#        for ($i=0;$i<=$tmpagenb;$i++) {
#        print FOUT "<TD ALIGN=CENTER>$tmpage{$i,$page}</TD>";
#        }
#        print FOUT "</TR>\n";
#        }

#}

#print FOUT "</TABLE>\n";
  print FOUT "<P><HR><P>\n";
  print FOUT "</BODY></HTML>\n";
}

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

#
print FOUT "<P><TABLE><TR>\n";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"><FONT SIZE=-1> $L{'Increase_over_the_previous_day'}</FONT></TD>";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[3]\"><FONT SIZE=-1> $L{'Same_over_the_previous_day'}</FONT></TD>";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[0]\"><FONT SIZE=-1> $L{'Decrease_over_the_previous_day'}</FONT></TD>";
print FOUT "</TR></TABLE>\n";
        
$tmp = $cday." ".$cmonth;

$testday = $cday;
$testmonth = $cmonth;
$testccmonth = $ccmonth;

print FOUT "<P><TABLE>\n";
print FOUT "<TR><TH>$L{'Page_read'}</TH><TH>$L{'Total'}</TH><TH>%</TH>\n";
print FOUT "<TH><FONT SIZE=-1>$tmp</FONT></TH>\n";
for ($i=0;$i<=$tmpagenb;$i++) {

$testday--;
$testday = "0".$testday if (length($testday) == 1);

if ($testday < 1) {
     $testccmonth--;
     if ($testccmonth < 1) {
#                     $testyear--;
            $testccmonth = 12;
      }
      $testmonth = $month_nb[$testccmonth-1];
      $testday = $month_of_year{$testmonth};
      }

$tmp = "$testday"." "."$testmonth";


print FOUT "<TH><FONT SIZE=-1>$tmp</FONT></TH>\n";
}
print FOUT "</TR>\n";

#

#print FOUT "<TABLE>\n";
#print FOUT "<TR><TH>$L{'Page_read'}</TH><TH>$L{'Total'}</TH><TH>%</TH>\n";
#print FOUT "</TR>\n";

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
        
        $tmp2 = ($pageslues{$page}-$pagesluesday{$page})*100/($access-$accessjour) if ($access != $accessjour);

        $tmpa = $pageslues{$page}*100/$access;
        $tmpstr = "#55FFFF" if (($tmpa - $tmp2) < 0.1);
        $tmpstr = "#55FF55" if ($tmpa > ($tmp2+0.1));
        $tmpstr = "#FF5555" if ($tmpa < ($tmp2-0.1));
        
        $tmp2 = int($tmpa);

        print FOUT "</TD><TD ALIGN=CENTER BGCOLOR=\"$tmpstr\">";
        printf FOUT "%.1f",$tmpa;
                
        print FOUT "</TD><TD ALIGN=CENTER>";
        print FOUT "$pagesluesday{$page}</TD>";
        for ($i=0;$i<=$tmpagenb;$i++) {
        print FOUT "<TD ALIGN=CENTER>$tmpage{$i,$page}</TD>";
        }
        print FOUT "</TR>\n";
        }        

#        $tmpa = $pageslues{$page}*100/$access;
#        $tmp2 = int($tmpa);

#        print FOUT "</TD><TD ALIGN=CENTER>";
#        printf FOUT "%.1f",$tmpa;
#        print FOUT "</TD></TR>\n";
#        }

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

$tmp2 = 0;
$pos = length($tri);
while (($pos = rindex($tri,$dirsepurl,$pos)) >= 0) {
        $tmp2++;
        $pos--;
        }
$tmp2--;

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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";


print FOUT "<H1> $L{'ListOf'} $L{'directories'} $L{'used2'} :</H1><P>\n";
print FOUT "<P><HR><P>\n";

if (($nbdays > 13) && ($#selecrepert != -1)) {

#if (-x $FLY)  {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
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
print FOUT "<TH COLSPAN=6>$L{'HTML_accesses'}</TH>\n";
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

print FOUT "<P><I>($L{'Only_directories'} $L{'with_at_least'} $seuilrepert $L{'requests'} $L{'will_be_printed'})</I><P>\n" unless ($seuilrepert == 0);

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
$tmp -= $tmp2;
        
if ($freqrac{$racine} > $seuilrepert) {
     print FOUT "<TR>\n<TD ";
     print FOUT "BGCOLOR=\"#D0D0D0\"" if ($tmp == 2);
     print FOUT "BGCOLOR=\"#909090\"" if ($tmp == 1);     
     print FOUT "><I><A HREF=\"$racine\">$racine</A></I>";

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

#if ($struct_logfile =~ /\%virtualhost/) {
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

##############################################################
###  creation du fichier pour les stats sur les filetypes  ###
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

#$totsizejour += $requetesize;
#$reqtotjour++;

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH>$L{'File'}</TH><TH>&nbsp;</TH><TH>$L{'Traffic'}</TH><TH>$L{'Percentage'}</TH><TH>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";

$tmp4 = 0;
$tmp = 0;
for ($i=0;$i<=$#listext;$i++) {
$tmp4 += $downloadsizeext{$listext[$i]};
#print "$tmp4 - $listext[$i] - $downloadsizeext{$listext[$i]}\n";
for ($j=1;$j<=$maxdownloadlength;$j++) {
$tmp += $download{$listext[$i],$j};
}
}
$tmp4 = $tmp4/(1024*1024);
print FOUT "<TR><TH ALIGN=LEFT BGCOLOR=\"#909090\">$L{'All_requests'}</TH><TH BGCOLOR=\"#909090\">&nbsp;</TH><TH BGCOLOR=\"#909090\">";
print FOUT "<IMG WIDTH=100 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> ";
printf FOUT "%.2f",$tmp4;
print FOUT " $L{'Mb'}</TH><TH ALIGN=RIGHT BGCOLOR=\"#909090\">100 %</TH><TH BGCOLOR=\"#909090\">";
print FOUT "<IMG WIDTH=100 HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> $tmp";
print FOUT "</TH><TH ALIGN=RIGHT BGCOLOR=\"#909090\">100 %</TH></TR>\n";


for ($i=0;$i<=$#listext;$i++) {
$tmp2 = 0;
for ($j=1;$j<=$maxdownloadlength;$j++) {
$tmp2 += $download{$listext[$i],$j};
}
next if ($tmp2 < $seuilpage);
$tmp3 = $downloadsizeext{$listext[$i]}/(1024*1024);
#$pourcentage = ($tmp3*100)/$totsize;
$pourcentage = ($tmp3*100)/$tmp4;
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
#$pourcentage = ($tmp2*100)/$reqtot;
$pourcentage = ($tmp2*100)/$tmp;
$pourcentageint = int($pourcentage);
print FOUT " %</TH><TH ALIGN=LEFT BGCOLOR=\"#C4C4C4\">";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if (int($pourcentage) != 0);
print FOUT "$tmp2</TH><TH ALIGN=RIGHT BGCOLOR=\"#C4C4C4\">";
printf FOUT "%.1f ",$pourcentage;
print FOUT "%</TH></TR>\n";

for ($j=1;$j<=$maxdownloadlength;$j++) {
print FOUT "<TR><TD>&nbsp;</TD>";

$tmpstr = 10**($j-1);
$tmp1 = 10**$j;

print FOUT "<TD>$tmpstr - $tmp1 $L{'bytes'}</TD>" if ($tmp1 <= 1000);
if ($tmp1 > 1000 && $tmp1 <= 1000000) {
$tmpstr = int($tmpstr/1000);
$tmp1 = int($tmp1/1000);
print FOUT "<TD>$tmpstr - $tmp1 $L{'Kb'}</TD>"; 
}
if ($tmp1 > 1000000) {
$tmpstr = int($tmpstr/1000000);
$tmp1 = int($tmp1/1000000);
print FOUT "<TD>$tmpstr - $tmp1 $L{'Mb'}</TD>";
}

if ($download{$listext[$i],$j} != 0) {
$tmp1 = $downloadsize{$listext[$i],$j}/(1024*1024);
$pourcentage = ($tmp1*100)/$tmp3 if (int($tmp3) != 0);
$pourcentage = 0 if (int($tmp3) == 0);
$pourcentageint = int($pourcentage);
print FOUT "<TD>";
print FOUT "<IMG WIDTH=$pourcentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if (int($pourcentage) != 0);
printf FOUT "%.2f",$tmp1;
print FOUT " $L{'Mb'}</TD><TD ALIGN=RIGHT>";
printf FOUT "%.1f ",$pourcentage;
print FOUT "%</TD><TD>";

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

    next if ($listext[$k] =~ /$extension/);
    $listextbis[$k] = $listext[$k];

    $tmp2 = 0;
    for ($j=1;$j<=$maxdownloadlength;$j++) {
	$tmp2 += $download{$listext[$k],$j};
    }

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

for ($l=1;$l<$nbzonefile;$l++) {

    $k = $filetypemax[$l];
    next if ($zoneext[$k] == 0);

    $percentage = $zoneext[$k]*100/$tmp3;
    $percentageint = int($percentage);
    print FOUT "<TR><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>$zonefile[$k]</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=RIGHT>$zoneext[$k] $L{'times'}</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>";
    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($percentageint != 0);
    printf FOUT "%.1f %</TH></TR>\n",$percentage;

    for ($i=0;$i<=$#listext;$i++) {
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

## printing subroutine

sub PagesScripts {
  local(*FOUT,*L) = @_;

  print FOUT "<HTML><HEAD>\n";
  print FOUT "<TITLE>$L{'Stats'} - $L{'Scripts'}</TITLE>\n";
  print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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
      print FOUT "<TD ALIGN=LEFT><LI>$L{'Method'} $val&nbsp;</TD>";
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
  print FOUT "<i>($L{'Only_scripts'} $L{'with_at_least'} $seuilscript $L{'requests'} $L{'will_be_printed'})</i><P>\n" unless ($seuilscript == 1 || $seuilscript == 0);
  
  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>\n";
  foreach $val (sort keys(%script)) {
      print FOUT "<TR><TD>$val&nbsp</TD><TD ALIGN=RIGHT>&nbsp;<B>$script{$val}</B> $L{'times'}</TD></TR>\n" if ($script{$val} > $seuilscript);
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
print FOUT "<!-- Page generated by w3perl - cron-inc.pl $version - $today $hourdate -->\n";
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

# calculer le temps mis pour le calcul

$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
($hour,$minute,$second) = split(/:/,$hourdate);

$endrun = "$hour:$minute:$second";

($min,$sec) = &timetaken($startrun,$endrun);

$endtime = time();
#printf STDOUT "Computing took %d CPU secondes\n",$endtime - $starttime;
#print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print STDOUT "Computing took $min min $sec sec\n\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$tmp = $loglines - $prevloglines;

open(FILE,">>$history");
printf FILE "cron-inc\t%s\t%s\t%s\t%d:%d\t%d\n",$today,$startrun,$endrun,$min,$sec,$tmp;
close(FILE);

__END__



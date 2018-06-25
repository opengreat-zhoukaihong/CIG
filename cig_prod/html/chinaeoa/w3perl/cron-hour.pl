#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                    HOURLY STATS                                #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@w3perl.com                   version 20/08/2000     #####
####                                                                #####
#########################################################################

$version = "2.72";
$verdate = "20/08/00";

############ script a lancer a XX heures 01 minutes ##########

## valeur a modifier avec fixperlpath.pl

require "/home/domisse/public_html/w3perl/libw3perl.pl";

$starttime = time();
print "Hourly stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#################################################################
####                   date de ce jour                    #######
#################################################################

### today date

#$datesyst = &ctime(time);
#($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
#$year = $a if ($year eq '');
#$day = "0".$day if (length($day) == 1);
#$countmonth = $month_equiv{$month};
#($hour,$minute,$second) = split(/:/,$hourdate);
#$today = $day."/".$month."/".$year;

#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -a               : stats on full logfile\n";
      print STDOUT "        -c <file>        : load configuration file\n";
      print STDOUT "        -i <file>        : input logfile\n";
      print STDOUT "        -o <file>        : output filename\n";
      print STDOUT "        -l <";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      } 
      print STDOUT "$lang[$#lang]";
      print STDOUT ">       : language output (comma split)\n";
      print STDOUT "        -j <dd/Mmm/yyyy> : stats on dd/MMM/yyyy\n";
      print STDOUT "        -p <level>       : precision level\n";
      print STDOUT "        -r <tri>         : scanning this matching string only\n";
      print STDOUT "        -s <seuilsite>   : display host with more than requests\n";
      print STDOUT "        -t <toplist>     : display only toplist files\n";
      print STDOUT "        -x               : show default value for flag options\n";
      print STDOUT "        -v               : version\n";
      print STDOUT "\n";
      exit;
}

if ($opt_v == 1) {
      print STDOUT "cron-hour.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -a               : ";
      &id($opt_a);
      print STDOUT "          -c               : $configfile\n";
      print STDOUT "          -i <file>        : $file\n";
      print STDOUT "          -o <file>        : \n";
      for ($nblang=0;$nblang<=$#lang;$nblang++) {
      $filehour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$filenamehour;
      print STDOUT "                      ($lang[$nblang]) : $filehour \n";
      }
      print STDOUT "          -j <dd/Mmm/yyyy> : <none>\n";
      print STDOUT "          -l <language>    : \@lang\n";
      print STDOUT "          -p <level>       : $precision\n";
      print STDOUT "          -r <tri>         : $tri\n";
      print STDOUT "          -s <seuilsite>   : $seuilsite\n";
      print STDOUT "          -t <toplist>     : $topten\n";
      print STDOUT "          -v               : $version\n";
      exit;
}


# argument cmds line

if ($opt_l ne '') {
  @lang = split(/, /,$opt_l);
  for ($i=0;$i<=$#lang;$i++) {
      $tmp = $dirress.$dirsep."lang".$dirsep.$lang[$i].$plext;
      $tmp = $pathinit.$tmp;
      require "$tmp";
  }

#  @oldlang = @lang;
#  @lang = ();
#  for ($j=0;$j<=$#newlang;$j++) {
#     $ok = 0;
#     for ($i=0;$i<=$#oldlang;$i++) {
#        $ok = 1 if ($newlang[$j] eq $oldlang[$i]);
#     }
#     if ($ok == 0) {
#     print STDERR "$newlang[$j] not yet available !\n";
#     print STDERR "Will you be interested in a translation ? ... contact me !\n";
#     }
#     push(@lang,$newlang[$j]) if ($ok == 1);
#     print "TOO @lang<BR>";
#  }

#  undef @newlang;
  if ($lang[0] eq '') {
      print STDERR "\nNone of your language choices have been yet translated !\n";
      exit; 
  }
}

if ($opt_p ne '') {
$precision = $opt_p;
}

if ($opt_r ne '') {
$tri = $opt_r;
}

if ($opt_t ne '') {
$topten = $opt_t;
}

if ($opt_s ne '') {
$seuilsite = $opt_s;
}

if ($opt_o ne '') {
    $filenamehour = $opt_o;
}

if ($opt_j ne '')
     {
       if ($opt_j =~  /(\d\d)\/([JFMASOND][aepuco][nbrylgptvc])\/(\d\d\d\d)/) {

       if ($2 ne $month || $zipcut == 2) {
        $file = $fileroot;
	$day = $1;
        $month = "0" unless (length($month_equiv{$2}) == 2);
        $month .= $month_equiv{$2};	
        $year = $3;
	$lettermonth = $2;
	$smallyear = $year - int($year/100)*100;
       $smallyear = "0".$smallyear if (length($smallyear) == 1);
     	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	        }    
        $filezip = $file.$zipext;
       }
       $day = $1 ;
       $month = $2 ;
       $year = $3 ;
       $today = "$1"."/"."$2"."/"."$3";
       $hour=24;
} else {
 print STDERR "Error : date should be in dd/Mmm/yyyy format\n";
 print STDERR "        dd is the day number\n";
 print STDERR "        Mmm is the abbreviated month name with first letter upper\n";
 print STDERR "        yyyy is the year number\n\n";
 exit;
}
}

if ($opt_i ne '') {
$file = $opt_i;
}

#################################################################
####                   initialisation                     #######
#################################################################

$offset = 0;
$nbdays = 0;
$oldheure = 0;
$domreq = 0;
$reqtot = 0;
$serverunique = 0;
$extreq = 0;
$RequeteHtml = 0;
$RequeteGif = 0;

# globale
$VolumeTotal = 0;
$VolumeTotalExt = 0;
$VolumeTotalInt = 0;
$VolumeHtml = 0;
$VolumeGif = 0;

# interne
$RequeteGifInt = 0;
$RequeteHtmlInt = 0;
$VolumeHtmlInt = 0;
$VolumeGifInt = 0;

# externe
$RequeteGifExt = 0;
$RequeteHtmlExt = 0;
$VolumeHtmlExt = 0;
$VolumeGifExt = 0;

$scriptunique = 0;

#############################################################################

&load_reverse_dns if ($reverse_dns == 1); # chargement de la table de DNS
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET" && $reverse_dns == 1);

#################################################################
####               directories building                   #######
#################################################################

$tmp = $path;
chop($tmp);
mkdir ($tmp,0775) unless -d $tmp;

for ($nblang=0;$nblang<=$#lang;$nblang++) {
$dir = $path.$lang[$nblang];
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirdate;
mkdir ($dir,0775) unless -d $dir;

#$dir = $path.$lang[$nblang].$dirsep.$dirdays;
#mkdir ($dir,0775) unless -d $dir;

$dirresume = $year."-".$month."-".$day;
$dir = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
mkdir ($dir,0775) unless -d $dir;
}


#################################################################
####               URL to title conversion                #######
#################################################################

chop($pathserver);

if (!(-e "$path$dirdata$dirsep$fileurl")) {
$titlename = 0;
}

if ($titlename == 1) {
    &error_open("$path$dirdata$dirsep$fileurl") if (!(-r "$path$dirdata$dirsep$fileurl"));
   open(URL,"$path$dirdata$dirsep$fileurl") || die "cannot open $path$dirdata$dirsep$fileurl\n";
        while (<URL>) {
        ($url,$title) = split(/\"/);
        chop($url);
#        $url =~ s/$pathserver//i;
        $urlconv{$url} = $title;
        }
close URL;
}


#################################################################
###         correspondance entre fichiers et extension        ###
#################################################################

if ($precision > 2) {

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

}

#################################################################
###                   jour precedent                          ###
#################################################################

if ($precision > 2) {

$dernier_month = $month;
$hier = $day - 1;

$hier = "0".$hier if (length($hier) == 1);

if ($hier < 1) {
    $countmonth--;
    if ($countmonth < 1) {
       $year--;
        $countmonth = 12;
    }
    $dernier_month = $month_nb[$countmonth-1];

    $hier = $month_of_year{$dernier_month};
    }

#$precedent = "$hier/$dernier_month/$year";

$filejour = $hier."-".$dernier_month.$htmlext;

if ($hour == 0) {
           $hour=24;
           $today = $hier."/".$dernier_month."/".$year;
           $dirresume = $year."-".$dernier_month."-".$hier;
           }
}



if ($opt_j ne '') {

         print STDOUT "Output files are : ";
	 print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
#         $filejour = $day."-".$month.$htmlext;
         for ($nblang=0;$nblang<=$#lang;$nblang++) {
             $filejourarc = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume.$dirsep.$filenamehour;
             print STDOUT "\n$filejourarc";
	 print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
         }
	 print STDOUT "\n";
}

if ($opt_a == 1) {

    print STDOUT "The file will be save in : \n";
	 print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
        $filenamehour = "all".$htmlext;
         for ($nblang=0;$nblang<=$#lang;$nblang++) {
             $filejourarc = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$filenamehour;
             print STDOUT "\n$filejourarc";
	 print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
         }

    $hour = 24;
}


#################################################################
###       seek to the right place to scan the log file        ###
#################################################################

if ($opt_a != 1) {
if ($filezip eq '' && $zipcut == 0) {

&error_open($file) if (!(-r $file));
open(INFILE, $file) || die "Error, unable to open $file\n";

# taille du fichier de log

($size)= (stat("$file")) [7];

###### date selectionnee

# calcul le nombre de jour

$yday = 0;

$countmonth = 0;
$month_end = $month_nb[$countmonth];

while ($month_end ne $month) {
  $yday += $month_of_year{$month_end};
  $countmonth++;
  $month_end = $month_nb[$countmonth];
  }

$yday += $day;

#print STDERR "date selectionnee : $today est le $yday jour de l'annee\n";

###### date finale

$timesec = time;

&get_time($timesec);

$todaylast = $date;

($dayfinale,$monthfinale,$yearfinale) = split(/\//,$date);

($ydayfinale) = split(/ /,$datemisc);

#print STDERR "date actuelle : $todaylast est le $ydayfinale jour de l'annee\n";


###### date de depart

$scalar = (<INFILE>);
$scalar = (<INFILE>) if ($scalar =~ /\"format\=/i); # Fasttrack server bug
while ($scalar =~ /^#/) {
$scalar = (<INFILE>);
}

 @line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

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

#print STDERR "debut du logfile : $firstjour est le $ydaystart jour de l'annee\n";

close (INFILE);

# nbre de jours total

$intervalle = ($year - $yearstart)*365 + ($yday - $ydaystart)+1;

# taille moyenne d'une journee

$sizejour = $size/$intervalle;
#print STDERR "SIZE : $size $sizejour $intervalle\n";

# intervalle entre dernier jour et date choisie

$nb = ($yearfinale - $year)*365 + ($ydayfinale - $yday)+1;

#print STDERR "NB : $nb $yday $ydayfinale $sizejour $size\n";

##################

$sizejour = 512 if ($sizejour < 512);
$sizejour = 512 if ($nb == 0);

#print STDOUT "$sizejour $nb $firstjour $todaylast $today $precedent\n";

if (($firstjour ne $today)) {
&error_open($file) if (!(-r $file));
  open(INFILE, $file) || die "Error, unable to open $file\n";
  $verifjour = $today;
  while ($verifjour eq $today) {
     $offset = int($size - ($nb*$sizejour));
     # print STDOUT "offset : $offset $sizejour\n";

     # verif de la date
     seek(INFILE,$offset,0);

     $scalar = (<INFILE>);
     $scalar = (<INFILE>);

#     @line_log = split(/[\[]/,$scalar);
#     $date = $line_log[$fields_logfile{'%date'}];

 @line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

#     ($adresse,$date)=split(/[\[]/,$scalar);

     ($verifjour) = split(/:/,$date);
     $nb++;
     }

  close (INFILE);
  }
}
}

#print STDERR "verif : $nb $verifjour $precedent\n";

$nb++;
$offset = int($size - ($nb*$sizejour));

$offset = 0 if (($firstjour eq $today) || ($opt_a == 1));
$offset = 0 if ($filezip ne '');

#print STDERR "$offset\n";

($date) = split(/ /,$date);

#################################################################
###       scanning the log file matching for today            ###
#################################################################

if ($zipcut != 0) {
	if (!(-f $file)) {
	($day,$month2,$year) = split('/',$today);
        $month = $month_equiv{$month2};
        $month = "0".$month unless (length($month) == 2);
        $lettermonth = $month2;
        $file = $fileroot;
	$smallyear = $year - int($year/100)*100;	
       $smallyear = "0".$smallyear if (length($smallyear) == 1);
     	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	        }
	}   
       $filezip = $file.$zipext if (!(-f $file));
}        

$filezip = "" if (!(-f $filezip));

if ($filezip eq '') {
&error_open($file) if (!(-r $file));
    open(INFILE, $file) || die "Error, unable to open $file\n";
} else {
&error_open($filezip) if (!(-r $filezip));
       open(INFILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
       print "File $filezip uncompressed\n";
       print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
   }

$offset = 0 if ($offset < 0);
seek(INFILE,$offset,0);

BOUCLE:
while (<INFILE>) {

@line_log = split(/$logfile_sep/);
chop($line_log[$#line_log]);
next if ($line_log[0] =~ /^#/);

$date = $line_log[$fields_logfile{'%date'}];

$date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

$out = 0;
$out = 1 if (($date !~ $today) && ($opt_a != 1));

last BOUCLE if (($nbdays != 0) && ($out == 1));
#next if (($date !~ /$today/) && ($opt_a != 1)); # stats sur la journee courante
next if ($out == 1); # stats sur la journee courante
next if (/\"format\=/i); # Fasttrack server bug

 $adresse = $line_log[$fields_logfile{'%host'}];
 $page = $line_log[$fields_logfile{'%page'}];
 $d = $line_log[$fields_logfile{'%method'}];
 $query = $line_log[$fields_logfile{'%query'}] if ($fields_logfile{'%query'} ne ''); 
 $status = $line_log[$fields_logfile{'%status'}];
 $requetesize = $line_log[$fields_logfile{'%requetesize'}];
 $vserver = $line_log[$fields_logfile{'%virtualhost'}] if ($fields_logfile{'%virtualhost'} ne '');
 $vserver = $1 if ($page =~ /^\/\/([-.0-9a-z]+)\//i && $virtualCLF != 0);
 $vserver = $line_log[$#line_log] if ($#logfile_fields == $fields_logfile{'%virtualhost'});
 $page =~ s/\/\/$virtualfilter// if (($virtualCLF != 0 && $virtualfilter ne '') || ($d =~ /$localserver/));
 
$status = $1 if ($query =~ /(\d\d\d);http:\/\// && $type_serveur == 1);

next if ($status !~ /^(\d+)$/);
next if (($status >= 400) && ($status < 599));
next if ($adresse eq '');

$page =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
$page =~ tr/[A-Z]/[a-z]/ if ($type_serveur == 1);

next if ($page !~ /^\//);
next if ($page =~ /$excluderepert/i && $excluderepert ne '');
next if ($page !~ m#$tri#);
next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
next if ($d =~ /$localserver/ && $vserver ne '');
next if ($vserver =~ /$excludevirtual/i && $excludevirtual ne '');
next if ($vserver !~ /$virtualfilter/i && $virtualfilter ne '' && $vserver ne '');
next if ($requetesize == 0) ; #ote les pages ne contenant rien
next if ($page =~ /"$/ && $iis_format != 1); # all format should be %page %protocol
next if ($d !~ /^"/ && $iis_format != 1); # all format should be %page %protocol

$adresse = $nis{$adresse} if ($nis{$adresse} ne '');
$adresse = &reversedns($adresse) if ($reverse_dns == 1 && $adresse =~ /^[0-9.]+$/);
$adresse = $adresse.".".$localdomainename if (split(/[.]/,$adresse) == 1);

next if (($adresse =~ m/$localdomaine/i) && ($locallog == 0));
next if (($adresse =~ /$nolog/i) && ($nolog ne ''));

$page .= $defaulthomepage if (substr($page,length($page)-1) eq "/");
$page = $page."?".$query if ($query ne '' && $query ne '-,');

$previousjour = $jour;
($jour,$heure,$minute,$seconde) = split(/:/,$date);
($daytoday,$monthtoday,$yeartoday) = split(/\//,$jour);
next if ($month_equiv{$monthtoday} !~ /(\d+)/);
next if (length($yeartoday) != 4);
$nbdays++ if ($jour ne $previousjour);

# maximum : 9 champs dans une adresse !

next if (split(/[.]/,$adresse) > 9);

#($machine,$extra)=split(/[.]/,$adresse);
#next if ($extra eq "" && $locallog == 0);

if ($oldheure == $heure) {
     $servheure{$adresse}++;
     $size[$heure] += $requetesize;
     if ($servheure{$adresse} == 1) {
          $user[$heure]++;
          }
 } else {
     $oldheure = $heure;
     foreach $adr (keys(%servheure)) {
        $servheure{$adr} = 0;
         }
#      $accesstot[$heure]++;
      $servheure{$adresse}++;
      $size[$heure] += $requetesize;
      if ($servheure{$adresse} == 1) {
          $user[$heure]++;
          }
}


### liste des cgi de ce jour
if ($precision > 2) {
    $d =~ s/\"//g;
    $d =~ tr/[a-z]/[A-Z]/;
    if ($d eq "POST") {
	$script{$page}++;
	$scriptunique++ if ($script{$page} == 1);
    }
    if ($d eq "GET" && $page =~ /[^\/]\?/) {
	($namescript,$argscript) = split(/\?/,$page);
	$script{$namescript}++;
	$scriptunique++ if ($script{$namescript} == 1);
    }
}

### liste des serveurs de ce jour
$server{$adresse}++;
if (($server{$adresse}) == 1) {
   $serverunique++;
   if ($precision > 2) {
       $listadresse[$serverunique] = $adresse;
       $locserver++ unless ($adresse !~ m/$localdomaine/);
       }
}

### Classement par type de fichiers

if ($precision > 2 && $page =~ /\./) {
$tmp = length($requetesize);
if ($page =~ /\?/) {
    $tmp1 = substr($page,0,rindex($page,'?'));
    $tmp1 = substr($tmp1,rindex($tmp1,'.'));
} else {
    $tmp1 = substr($page,rindex($page,'.'));
}
$tmp1 =~ tr/[A-Z]/[a-z]/;
$tmp1 =~ s/\#.*$//;
$tmp1 =~ s/\/.*$//;
$maxdownloadlength = $tmp if ($tmp > $maxdownloadlength);
$download{$tmp1,$tmp}++;
$downloadsize{$tmp1,$tmp} += $requetesize;
$filetype{$page}++; # if ($tmp1 !~ /$extension/);
push(@listext,$tmp1) if ($downloadsizeext{$tmp1} eq '');
$downloadsizeext{$tmp1} += $requetesize;
}

### liste des pages lues de ce jour
#for ($i=0;$i<=($#extension);$i++) {
#    if (substr($page,rindex($page,'.')+1) =~ /^$extension[$i]$/i) {
    if (substr($page,rindex($page,'.')) =~ /$extension/i) {
         if ($precision > 2) {
       $VolumeHtml+=$requetesize ;
       $RequeteHtml++;
       $accesstot[$heure]++;
       if ($adresse !~ m/$localdomaine/) {
           $VolumeHtmlExt+=$requetesize;
           $RequeteHtmlExt++;
       } else {
           $VolumeHtmlInt+=$requetesize;
           $RequeteHtmlInt++;
       }
        }
        $pageslues{$page}++;
        $pageunique++ unless ($pageslues{$page} != 1) ;
     }
#  }


if ($precision > 2) {
for ($i=0;$i<=($#extensionimage);$i++) {
    if (substr($page,rindex($page,'.')+1) =~ /^$extensionimage[$i]$/i) {
       $VolumeGif+=$requetesize ;
       $RequeteGif++;
       if ($adresse !~ m/$localdomaine/) {
           $VolumeGifExt+=$requetesize;
           $RequeteGifExt++;
       } else {
           $VolumeGifInt+=$requetesize;
           $RequeteGifInt++;
       }
     }
   }
$VolumeTotal+=$requetesize ;

if ($adresse !~ m/$localdomaine/) {
    $VolumeTotalExt+=$requetesize ;
    $extreq++;
} else {
    $VolumeTotalInt+=$requetesize ;
}
}

$reqtot++;
$domreq++ unless ($adresse !~ m/$localdomaine/);

}

close(INFILE);

#################################################################
###                    computing maxima                       ###
#################################################################

# nbre max de users , d'access html et sur la taille

$max = 0;
$maxsize = 0;
$maxhtml = 0;
for ($i=0;$i<=$hour;$i++) {
    if ($user[$i] > $max) {
         $max = $user[$i];
     }
    if ($size[$i] > $maxsize) {
         $maxsize = $size[$i];
     }
    if ($accesstot[$i] > $maxhtml) {
         $maxhtml = $accesstot[$i];
     }
}

# Tri des zones de filetype

for ($k=0;$k<=$#listext;$k++) {

#    next if ($listext[$k] =~ /$extension/);
    $listextbis[$k] = $listext[$k];

    $tmp2 = 0;
    $tmp3 = 0;
    for ($j=1;$j<=$maxdownloadlength;$j++) {
	$tmp2 += $download{$listext[$k],$j};
	$tmp3 += $downloadsize{$listext[$k],$j};
    }
    $zoneext[$extfilenb{$listext[$k]}] += $tmp2;
    $downloadext[$extfilenb{$listext[$k]}] += $tmp3;

}

##

for ($k=0;$k<=$nbzonefile;$k++) {
    $zoneextbis[$k] = $zoneext[$k];
}

  for ($j=0;$j<=$nbzonefile;$j++) {
      $max = $zoneextbis[$j];
      $filetypemax[$j] = 0;
      for ($k=0;$k<=$nbzonefile;$k++) {
	  if ($zoneextbis[$k] > $max) {
	      $max = $zoneextbis[$k];
	      $filetypemax[$j] = $k;
	  }
      }
      $zoneextbis[$filetypemax[$j]] = 0;      
  }



# tri des $topten meilleurs script
$bouclescript = $topten unless ($scriptunique < $topten);
$bouclescript = $scriptunique unless ($scriptunique > ($topten-1));

for ($i=0;$i < $bouclescript;$i++) {
$maxi = 0;
foreach $page (keys(%script)) {
    if ($script{$page} > $maxi) {
         $maxi = $script{$page};
         $bestscript[$i] = $page;
         $occurscript[$i] = $script{$page};
         }
    }
$script{$bestscript[$i]} = 0;
}

# tri des $topten meilleures pages lues
$boucle = $topten unless ($pageunique < $topten);
$boucle = $pageunique unless ($pageunique > ($topten-1));

for ($i=0;$i < $boucle;$i++) {
$maxi = 0;
foreach $page (keys(%pageslues)) {
    if ($pageslues{$page} > $maxi) {
         $maxi = $pageslues{$page};
         $bestpage[$i] = $page;
         $occur[$i] = $pageslues{$page};
         }
    }
$pageslues{$bestpage[$i]} = 0;
}

# unite pour l'affichage a l'ecran
$unite = ($max*$square)/100 unless ($max == 0);
$unite = 1 unless ($max != 0);

$unitehtml = ($maxhtml*$square)/100 unless ($maxhtml == 0);
$unitehtml = 1 unless ($maxhtml != 0);

$unitesize = $maxsize/10 unless ($maxsize == 0);
$unitesize = 1 unless ($maxsize != 0);

# conversion en Mo

$VolumeTotal /= (1024*1024);
$VolumeTotalExt /= (1024*1024);
$VolumeTotalInt /= (1024*1024);
$VolumeHtml /= (1024*1024);
$VolumeHtmlExt /= (1024*1024);
$VolumeHtmlInt /= (1024*1024);
$VolumeGif /= (1024*1024);
$VolumeGifExt /= (1024*1024);
$VolumeGifInt /= (1024*1024);

#############################################################################

&save_reverse_dns if ($reverse_dns == 1); # sauvegarde de la table de DNS

#if ($reverse_dns == 1) {
#print STDOUT "Saving DNS table\n";
#open(IP,">$path$dirdata$dirsep$ip_table");
#foreach $ipdata (sort keys(%revdns)) {
#print IP "$ipdata\t$revdns{$ipdata}\n";
#}
#close(IP);
#}

###############################################################
### creation du fichier contenant les stats pour les heures ###
###############################################################

for ($nblang=0;$nblang<=$#lang;$nblang++) {

$filehour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$filenamehour;

  open(FILEHOUR,">$filehour") || die "Error, unable to open $filehour\n";
      &HourHeader(*FILEHOUR, eval($Lang{$lang[$nblang]}),$lang[$nblang]);
      &HourHosts(*FILEHOUR, eval($Lang{$lang[$nblang]}));
      &HourPages(*FILEHOUR, eval($Lang{$lang[$nblang]}));
      &HourTraffic(*FILEHOUR, eval($Lang{$lang[$nblang]})) if ($precision > 2);
      &HourFoot1(*FILEHOUR, eval($Lang{$lang[$nblang]}));
      &HourSites(*FILEHOUR, eval($Lang{$lang[$nblang]})) if ($precision > 2);
      &HourTopTen(*FILEHOUR, eval($Lang{$lang[$nblang]}));
      &HourScript(*FILEHOUR, eval($Lang{$lang[$nblang]})) if ($precision > 2 && $scriptunique != 0);
#      &HourTotal(*FILEHOUR, eval($Lang{$lang[$nblang]})) if ($precision > 2);
      &HourDownload(*FILEHOUR, eval($Lang{$lang[$nblang]})) if ($precision > 2);
      &HourFoot2(*FILEHOUR, eval($Lang{$lang[$nblang]}));
  close(FILEHOUR);
}

# sauvegarde des fichiers de la journee

#if (($precision > 2) && ($hour == 24) && ($opt_a != 1)) {
if (($precision > 2) && ($opt_a != 1)) {

for ($nblang=0;$nblang<=$#lang;$nblang++) {

#   $filejourarc = $path.$lang[$nblang].$dirsep.$dirdays.$dirsep.$filejour;

    $tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
    mkdir ($tmp,0775) unless -d $tmp;

   $filejourarc = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume.$dirsep.$filenamehour;
   $filehour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$filenamehour;

      open(DEST,">$filejourarc") || die "Cannot open $filejourarc : $!";
      open(LECT,$filehour) || die "Cannot read $filehour : $!";
      while (<LECT>) {
#         s/$dirress/\.\.$dirsepurl$dirress/i if (/IMG/);
         s/^/^\.\.$dirsepurl/i if (/IMG/);
         print DEST;
         }
      close (LECT);
      close (DEST);
}
}

$endtime = time();
printf "Computing took %d CPU secondes\n\n",$endtime - $starttime;
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#################################################################
sub HourHeader {
 local(*FOUT,*L,$I) = @_;

print FOUT "<HTML><HEAD>\n";
print FOUT "<TITLE>$L{'Stats'} $L{'about'} $L{'hours'} - $today</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-hour.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";

print FOUT "<CENTER>\n";
print FOUT "<TABLE BORDER=0 WIDTH=100\%>\n";
print FOUT "<TR>\n";
print FOUT "<TD align=left valign=center><B><A HREF=\"#utilisateur\">$L{'Users'} $L{'by'} $L{'hour'}</A></B><br><br>\n";
print FOUT "<B><A HREF=\"#traffic\">$L{'Traffic'} $L{'by'} $L{'hour'}</A></B><br><br>\n" if ($precision > 2);
print FOUT "<B><A HREF=\"#acces\">$L{'Accesses'} $L{'by'} $L{'hour'}</A></B><br><br>\n";
print FOUT "<B><A HREF=\"..$dirsepurl$dirsession$dirsepurl$filemoyenne#moyheure\">$L{'Average'} $L{'by'} $L{'hour'}</A></B><br>\n" if (-f "$path$I$dirsep$dirsession$dirsep$filemoyenne");
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=CENTER>\n";
print FOUT "<TABLE BORDER=8 CELLPADDING=1><TR><TD>\n";
print FOUT "<TABLE BORDER=8 CELLPADDING=3><TR><TD>\n";
print FOUT "<TABLE BORDER=8 CELLPADDING=5><TR><TD>\n";
print FOUT "<H1><CENTER>$L{'Stats'}<br>$L{'about'} $L{'the'} $L{'hours'}\n";
print FOUT "<BR>($L{'total_for'} $nbdays $L{'days'})\n" if ($opt_a == 1);
print FOUT "</CENTER></TD></TR></TABLE>\n";
print FOUT "</TD></TR></TABLE>\n";
print FOUT "</TD></TR></TABLE>\n";
print FOUT "</H1>\n";
print FOUT "</TD>\n";
print FOUT "<TD ALIGN=RIGHT VALIGN=CENTER><B>\n";
print FOUT "<A HREF=\"#site\">$L{'ListOfSites'}</A></B><br><br>\n" if ($precision > 2);
print FOUT "<B><A HREF=\"#page\">$L{'Successful_pages'}</A></B><br><br>\n";
print FOUT "<B><A HREF=\"#total\">$L{'Total_traffic'}</A></B>\n" if ($precision > 2);
print FOUT "</TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";
print FOUT "</CENTER>\n";

print FOUT "<HR SIZE=5>\n";
print FOUT "<CENTER><B>$date</B></CENTER>\n";
print FOUT "<HR SIZE=5><P>\n";

print FOUT "<A NAME=\"utilisateur\">\n";
print FOUT "  $L{'Hour'} \t - \t $L{'Number'} ";
print FOUT "<B>$L{'total'}</B> " if ($opt_a == 1);
print FOUT "$L{'of_different_hosts'}\n";
print FOUT "<P>\n";
}

#################################################################
sub HourHosts {
 local(*FOUT,*L) = @_;

for ($heure=0;$heure < $hour;$heure++) {
$nbre = 3*$user[$heure];           # $square est la largeur du bloc image
$nbre *= 3 if ($max > 100);
$nbre = int($nbre/$unite) if ($max > 100);
$heuresuivante = $heure + 1;
$heure = "0".$heure unless (length($heure) != 1);
$heuresuivante = "0".$heuresuivante unless (length($heuresuivante) != 1);
print FOUT "$heure - $heuresuivante $L{'hour'} : ";
print FOUT "<IMG WIDTH=$nbre HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[0]\"> <B> $user[$heure] </B>" if ($user[$heure] != 0);
print FOUT "<BR>\n";
 }
}

#################################################################
sub HourPages {
 local(*FOUT,*L) = @_;

print FOUT "<P><HR SIZE=5><P>\n";

print FOUT "<A NAME=\"acces\">\n";
print FOUT "  $L{'Hour'} \t - \t $L{'Number'} ";
print FOUT "<B>$L{'total'}</B> " if ($opt_a == 1);
print FOUT "$L{'HTMLPage_Acc'}\n";
print FOUT "<P>\n";

for ($heure=0;$heure < $hour;$heure++) {
$nbre = 3*$accesstot[$heure];           # $square est la largeur du bloc image
$nbre *= 3 if ($maxhtml > 100);
$nbre = int($nbre/$unitehtml) if ($maxhtml > 100);
$heuresuivante = $heure + 1;
$heure = "0".$heure unless (length($heure) != 1);
$heuresuivante = "0".$heuresuivante unless (length($heuresuivante) != 1);
print FOUT "$heure - $heuresuivante $L{'hour'} : ";
print FOUT "<IMG WIDTH=$nbre HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[4]\"> <B>$accesstot[$heure]</B>" if ($accesstot[$heure] != 0);
print FOUT "<BR>\n";
 }
}

#################################################################
sub HourTraffic {
 local(*FOUT,*L) = @_;

$conv = 1;
 $convunit = $L{'Data_unit_octet'};


if ($maxsize > 1024) {
    $conv = 1024;
    $convunit = $L{'Data_unit_Kb'};
}


if ($maxsize > (1024*1024)) {
    $conv = 1024*1024;
    $convunit = $L{'Data_unit_Mb'};
}


print FOUT "<A NAME=\"traffic\">\n";
print FOUT "<P><HR SIZE=5><p>\n";
print FOUT "  $L{'Hour'} \t - \t $L{'Data'} ";
print FOUT "<B>total</B> " if ($opt_a == 1);
print FOUT "$L{'traffic_in'} $convunit\n";
print FOUT "<P>\n";

for ($heure=0;$heure < $hour;$heure++) {
$nbre = int(3*$size[$heure]*$square/$unitesize);       # $square est la largeur du bloc image
$heuresuivante = $heure + 1;
$heure = "0".$heure unless (length($heure) != 1);
$heuresuivante = "0".$heuresuivante unless (length($heuresuivante) != 1);
print FOUT "$heure - $heuresuivante $L{'hour'} :  ";
print FOUT "<IMG WIDTH=$nbre HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">" if ($nbre != 0);
$affsize = $size[$heure]/$conv;
printf FOUT "<B> %.2f",$affsize if ($size[$heure] != 0);
print FOUT "</B><BR>\n";
 }
}

#################################################################
sub HourFoot1 {
 local(*FOUT,*L) = @_;

print FOUT "<A NAME=\"requete\">\n";
print FOUT "<P><HR>\n";
print FOUT "$L{'At'} $hour $L{'hours'}," if ($opt_a != 1);
print FOUT "$L{'on'} $nbdays $L{'days'}," if ($opt_a == 1);
print FOUT " $L{'there_are'} $reqtot $L{'requests'} $L{'coming_from'} $serverunique $L{'sites'}\n";

if ($locallog != 0) {
print FOUT "($L{'among'} $domreq ";
print FOUT "$L{'request'}" if ($domreq == 0 || $domreq == 1);
print FOUT "$L{'requests'}" unless ($domreq == 0 || $domreq == 1);
print FOUT " $L{'from domain'} $localdomainename)\n";
 }
}

#################################################################
sub HourSites {
 local(*FOUT,*L) = @_;

print FOUT "<A NAME=\"site\">\n";
print FOUT "<HR><P>\n";
print FOUT "<I>$L{'ListOfSites'} ";
print FOUT "$L{'on'} $nbdays $L{'days'}</I> " if ($opt_a == 1);
print FOUT "$L{'for_today'}</I>" if ($opt_a != 1);
print FOUT " ($L{'more_than'} $seuilsite $L{'requests'}) :<P><UL>\n";

foreach $adresse (sort (keys(%server))) {
if ($server{$adresse} > $seuilsite) {
print FOUT "$adresse" unless ($adresse =~ m/$localdomaine/);
print FOUT "<I>$adresse</I>" unless ($adresse !~ m/$localdomaine/);
print FOUT " : <B>$server{$adresse}</B> ";
print FOUT "$L{'request'}" if ($server{$adresse} == 1);
print FOUT "$L{'requests'}" if ($server{$adresse} != 1);
print FOUT "<BR>\n";
}
}
print FOUT "<BR></UL><P>\n";
}

#################################################################
sub HourTopTen {
 local(*FOUT,*L) = @_;

print FOUT "<A NAME=\"page\">\n";
print FOUT "<HR><P>\n";
print FOUT "<I>$L{'ListOf'} $boucle $L{'pages'} ($L{'among'} $pageunique) $L{'with_most_accesses'} ";
print FOUT "sur $nbdays $L{'days'}" if ($opt_a == 1);
print FOUT "</I> :<P><UL>\n";
for ($i=0;$i < $boucle;$i++) {
print FOUT "<A HREF=\"$bestpage[$i]\">";
print FOUT "$bestpage[$i]" if ($titlename == 0);
print FOUT "<b>$urlconv{$bestpage[$i]}</b>" if ($titlename == 1 && $urlconv{$bestpage[$i]} ne '');
print FOUT "$bestpage[$i]" if ($titlename == 1 && $urlconv{$bestpage[$i]} eq '');
print FOUT "</A> : <B>$occur[$i]</B> $L{'times'}<BR>\n";
}

print FOUT "</UL><P>\n";
}


#################################################################
sub HourScript {
 local(*FOUT,*L) = @_;

print FOUT "<A NAME=\"script\">\n";
print FOUT "<HR><P>\n";
print FOUT "<I>$L{'ListOf'} $bouclescript $L{'scripts'} ($L{'among'} $scriptunique) $L{'with_most_accesses'} ";
print FOUT "sur $nbdays $L{'days'}" if ($opt_a == 1);
print FOUT "</I> :<P><UL>\n";
for ($i=0;$i < $bouclescript;$i++) {
#print FOUT "<A HREF=\"$bestscript[$i]\">";
print FOUT "$bestscript[$i]";
#print FOUT "$bestscript[$i]" if ($titlename == 0);
#print FOUT "<b>$urlconv{$bestscript[$i]}</b>" if ($titlename == 1 && $urlconv{$bestscript[$i]} ne '');
#print FOUT "$bestscript[$i]" if ($titlename == 1 && $urlconv{$bestscript[$i]} eq '');
#print FOUT "</A>";
print FOUT " : <B>$occurscript[$i]</B> $L{'times'}<BR>\n";
}

print FOUT "</UL><P>\n";
}

#################################################################
sub HourTotal {
 local(*FOUT,*L) = @_;

print FOUT "<A NAME=\"total\">\n";
print FOUT "<HR><P>\n";

print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
print FOUT "<TR>\n";
print FOUT "<TH COLSPAN=2 ALIGN=LEFT>\n" if ($locallog == 0);
print FOUT "<TH COLSPAN=4 ALIGN=LEFT>\n" if ($locallog != 0);
print FOUT "$L{'Traffic_statistics'} ";
print FOUT "$L{'on'} $nbdays $L{'days'} " if ($opt_a == 1);
print FOUT ":</TH>\n";
print FOUT "</TR>\n";
print FOUT "<TR>\n";
print FOUT "<TD></TD>\n";
print FOUT "<TD ALIGN=MIDDLE>$L{'All_sites'}</TD>\n" if ($locallog != 0);
print FOUT "<TD ALIGN=MIDDLE>$L{'Outside'}</TD>\n";
print FOUT "<TD ALIGN=MIDDLE>$L{'Inside'}</TD>\n" if ($locallog != 0);
print FOUT "</TR>\n";
print FOUT "<TR>\n";
print FOUT "<TD>$L{'All_requests'}</TD>\n";

if ($locallog != 0) {
print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeTotal;
print FOUT " $L{'Mb'} <BR><I> $reqtot $L{'requests'}</I></TD>\n";
}

print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeTotalExt;
print FOUT " $L{'Mb'} <BR><I> $extreq $L{'requests'}</I></TD>\n";

if ($locallog != 0) {
print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeTotalInt;
print FOUT " $L{'Mb'} <BR><I> $domreq $L{'requests'}</I></TD>\n";
}

print FOUT "</TR>\n";
print FOUT "<TR>\n";
print FOUT "<TD>$L{'All_html_pages_requests'}</TD>\n";

if ($locallog != 0) {
print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeHtml;
print FOUT " $L{'Mb'} <BR><I> $RequeteHtml $L{'requests'}</I></TD>\n";
}

print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeHtmlExt;
print FOUT " $L{'Mb'} <BR><I> $RequeteHtmlExt $L{'requests'}</I></TD>\n";

if ($locallog != 0) {
print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeHtmlInt;
print FOUT " $L{'Mb'} <BR><I> $RequeteHtmlInt $L{'requests'}</I></TD>\n";
}

print FOUT "</TR>\n";
print FOUT "<TR>\n";
print FOUT "<TD>$L{'All_images_requests'}</TD>\n";

if ($locallog != 0) {
print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeGif;
print FOUT " $L{'Mb'} <BR><I> $RequeteGif $L{'requests'}</I></TD>\n";
}

print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeGifExt;
print FOUT " $L{'Mb'} <BR><I> $RequeteGifExt $L{'requests'}</I></TD>\n";

if ($locallog != 0) {
print FOUT "<TD ALIGN=MIDDLE>";
printf FOUT "%.2f",$VolumeGifInt;
print FOUT " $L{'Mb'} <BR><I> $RequeteGifInt $L{'requests'}</I></TD>\n";
}

print FOUT "</TR>\n";
print FOUT "</TABLE>\n";

}


#################################################################
sub HourDownload {
 local(*FOUT,*L) = @_;

print FOUT "<A NAME=\"total\">\n";
print FOUT "<HR><P>\n";

print FOUT "<TABLE BORDER=1>\n";
print FOUT "<TR><TH>$L{'File'}</TH><TH ALIGN=CENTER>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH><TH ALIGN=CENTER>$L{'Traffic'}</TH><TH>$L{'Percentage'}</TH></TR>\n";


 $percentage = 100;
 $percentageint = int($percentage);
 print FOUT "<TR><TH BGCOLOR=\"#C0C0C0\" ALIGN=LEFT>$L{'All_requests'}</TH><TH BGCOLOR=\"#C0C0C0\" ALIGN=RIGHT>$reqtot $L{'times'}</TH><TH BGCOLOR=\"#C0C0C0\" ALIGN=LEFT>";
 print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($percentageint != 0);
 printf FOUT "%.1f %</TH>\n",$percentage;

 $percentage = 100;
 $percentageint = int($percentage);
 print FOUT "<TH ALIGN=RIGHT BGCOLOR=\"#C0C0C0\">";
 printf FOUT "%.1f $L{'Mb'}",$VolumeTotal;
 print FOUT "</TH><TH ALIGN=LEFT BGCOLOR=\"#C0C0C0\">";
 print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($percentageint != 0);
 printf FOUT "%.1f %</TH></TR>\n",$percentage;

#$downloadsize{$tmp1,$tmp} += $requetesize;
#$downloadsizeext{$tmp1} += $requetesize;

for ($l=0;$l<$nbzonefile;$l++) {

    $k = $filetypemax[$l];
    next if ($zoneext[$k] == 0 || $k == 0);

    $percentage = $zoneext[$k]*100/($reqtot-$access);
    $percentageint = int($percentage);
    print FOUT "<TR><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>$zonefile[$k]</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=RIGHT>$zoneext[$k] $L{'times'}</TH><TH BGCOLOR=\"#D0D0D0\" ALIGN=LEFT>";
    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($percentageint != 0);
    printf FOUT "%.1f %</TH>\n",$percentage;

    $percentage = $downloadext[$k]*100/($VolumeTotal*1024*1024);
    $percentageint = int($percentage);
    print FOUT "<TH ALIGN=RIGHT BGCOLOR=\"#D0D0D0\">";
    printf FOUT "%.1f $L{'Mb'}",$downloadext[$k]/(1024*1024);
    print FOUT "</TH><TH ALIGN=LEFT BGCOLOR=\"#D0D0D0\">";
    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"> " if ($percentageint != 0);
    printf FOUT "%.1f %</TH></TR>\n",$percentage;

    for ($i=0;$i<=$#listext;$i++) {
#	next if ($listext[$k] =~ /$extension/);
	if ($k == $extfilenb{$listext[$i]}) {
	    $tmp2 = 0;
	    for ($j=1;$j<=$maxdownloadlength;$j++) {
		$tmp2 += $download{$listext[$i],$j};
	    }
	    if ($tmp2 != 0) {
	    $percentage = $tmp2*100/$zoneext[$k];
	    $percentageint = int($percentage);
	    print FOUT "<TR><TD ALIGN=LEFT>$extfile{$listext[$i]} ($listext[$i])</TD><TD ALIGN=RIGHT>$tmp2 $L{'times'}</TD><TD ALIGN=LEFT>\n";
	    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
	    printf FOUT "%.1f %</TD>\n",$percentage;

	    $percentage = $downloadsizeext{$listext[$i]}*100/$downloadext[$k];
	    $percentageint = int($percentage);
	    print FOUT "<TD ALIGN=RIGHT>";
	    printf FOUT "%.1f $L{'Mb'}",$downloadsizeext{$listext[$i]}/(1024*1024);
	    print FOUT "</TD><TD ALIGN=LEFT>";
	    print FOUT "<IMG WIDTH=$percentageint HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"> " if ($percentageint != 0);
	    printf FOUT "%.1f %</TD></TR>\n",$percentage;
	}
	}
    }
}
print FOUT "</TABLE>\n";
}

#################################################################
sub HourFoot2 {
 local(*FOUT,*L) = @_;

print FOUT "<P><HR><P>\n";
print FOUT "</BODY></HTML>\n";
}

__END__



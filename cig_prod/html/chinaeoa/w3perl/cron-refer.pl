#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                    REFERER STATS                               #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@w3perl.com                   version 20/08/2000     #####
####                                                                #####
#########################################################################

$version = "2.72";
$verdate = "20/08/00";

## valeur a modifier par fixperlpath.pl

require "/usr/local/etc/w3perl/cgi-bin/w3perl/libw3perl.pl";

$filerefday = $path.$dirinc.$dirsep."refday";
$datafile = "time-refer";

#$server_ip = gethostbyname($localserver);

# debut de l'initialisation

$starttime = time();

print "Referer stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

$localrefer = 0;
$year_now = $year;
$timesec = time;
&get_time($timesec);
($jour_of_year_end) = split(/ /,$datemisc);
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
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -b           : don't run incremental mode\n";
      print STDOUT "        -c <file>    : load configuration file\n";
      print STDOUT "        -d <nbdays>           : number of days to scan (Extended NCSA logifle only)\n"; 
      print STDOUT "        -l <";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      } 
      print STDOUT "$lang[$#lang]";
      print STDOUT ">   : language output (comma split)\n";          
      print STDOUT "        -i <file>    : input logfile\n";
      print STDOUT "        -f           : local reference include\n";
      print STDOUT "        -p <page>    : referer for this page\n";
      print STDOUT "        -t <toplist> : display only toplist files\n";
      print STDOUT "        -x           : show default value for flag options\n";
      print STDOUT "        -v           : version\n";
      print STDOUT "        -z           : zip logfiles\n";        
      print STDOUT "\n";
      exit;
}


if ($opt_v == 1) {
      print STDOUT "cron-refer.pl version $version $verdate\n";
      exit;
}

#if ($opt_p ne '') {
#$pageselect = $opt_p;

#if (index($pageselect,'/') != 0) {
#print STDERR "Your page $opt_p should start from your root server\n";
#print STDERR "Try /$pageselect instead of $pageselect\n";
#exit;
#}
#$pageselect .= $defaulthomepage if (substr($pageselect,length($pageselect)-1) eq "/");
#}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -b            : ";
      &id($opt_b);
      print STDOUT "          -c            : $configfile\n";
      print STDOUT "          -d <nbdays>   : $nbdays\n"; 
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDOUT "          -i <file>     : $filerefer\n";
      print STDOUT "          -f            : ";
      &id($localrefer);
      print STDOUT "          -p <page>     : <none>\n";
      print STDOUT "          -t <toplist>  : $topten\n";
      print STDOUT "          -v            : $version\n";
      print STDOUT "          -z            : ";
      &id($opt_z);      
      exit;
}

if ($opt_z ne '') {
$zip = $opt_z;
}

if ($opt_d ne '') {
$nbdays = $opt_d;
print STDERR "Only extended NSCA logfile !!!\nThis switch \"-d\" has no effect.\n" if ($file ne $fileagent);
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

if ($opt_f == 1) {
$localrefer = 1;
}

# argument cmds line

if ($opt_i ne '') {
$filerefer = $opt_i;
}

if ($opt_t ne '') {
$topten = $opt_t;
}

if ($opt_p ne '') {
$pageselect = $opt_p;
if (index($pageselect,'/') != 0) {
print STDERR "Your page should start from your root server\n";
print STDERR "Try /$pageselect instead of $pageselect\n";
exit;
}
$pageselect .= $defaulthomepage if (substr($pageselect,length($pageselect)-1) eq "/");
}


$tmp = $path;
chop($tmp);
mkdir ($tmp,0775) unless -d $tmp;

$dir = $path.$dirinc;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirdata;
mkdir ($dir,0775) unless -d $dir;

for ($nblang=0;$nblang<=$#lang;$nblang++) {
$dir = $path.$lang[$nblang];
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirlist;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$lang[$nblang].$dirsep.$dirdate;
mkdir ($dir,0775) unless -d $dir;
}

### Delete file
#if ($opt_b == 1) {
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
#}
#sub dodirdel {
#    local($dir) = @_;
#    local($i,@filenames);
#opendir(SOURCEDIR,$dir) || die "Couldn't open directory $dir !!\n";
#@filenames = readdir(SOURCEDIR);
#closedir(SOURCEDIR);
#for ($i=0;$i<=$#filenames;$i++) {
#if (-f "$dir$dirsep$filenames[$i]") {
#    push(@tmp,"$dir$dirsep$filenames[$i]") if ($filenames[$i] eq $tabnamerefer);
#}
#if (-d "$dir$dirsep$filenames[$i]" && $filenames[$i] ne '.' && $filenames[$i] ne '..') {
#    push(@tmpdir,"$dir$dirsep$filenames[$i]");
#    chdir "$dir$dirsep$filenames[$i]";
#    &dodirdel("$dir$dirsep$filenames[$i]");
#    chdir '..';
#    }
#}
#}

### URL to title conversion

chop($pathserver);

if (!(-e "$path$dirdata$dirsep$fileurl")) {
$titlename = 0;
}

if ($titlename == 1) {
   open(URL,"$path$dirdata$dirsep$fileurl") || die "cannot open $path$dirdata$dirsep$fileurl\n";
   while (<URL>) {
        ($url,$title) = split(/"/);
        chop($url);
#        $url =~ s/$pathserver//i;
        $urlconv{$url} = $title;
        }
   close URL;
}

$month_number = $month_equiv{$month};
$month_number--;

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

if ($opt_d ne '') {
$jour = $pasttoday;
}

###################################################################

if ($zipcut == 0) {
die "Referencelog file $filerefer not found\nAre you sure your server produce one ?\n" unless (-f $filerefer);
}
$nbline = 0;

($size)= (stat("$filerefer")) [7];
#$prefixlog = $referlog if ($file ne $filerefer);

#############################################################################

&load_reverse_dns if ($reverse_dns == 1); # chargement de la table de DNS

#################################################################
#######        chargement des anciennes valeurs      ############
#################################################################

$opt_b = 1 if (!(-f "$path$dirinc$dirsep$increfsites"));

if ($opt_b != 1 && $opt_d eq '') {

#if ($file eq $filerefer && (-f "$path$dirinc$dirsep$increfsites")) {
if (-f "$path$dirinc$dirsep$increfsites") {

open(FILE,"$path$dirinc$dirsep$increfsites") || die "Error, unable to open $path$dirinc$dirsep$increfersites\n";
$a = (<FILE>);
($nbline,$firstday,$jour,$sizeold) = split(/\t/,$a);
chop($sizeold);
while (<FILE>) {
($site,$nb) = split;
$nbre{$site} = $nb;
$unique++;
}
close(FILE);    

open(FILE,"$path$dirinc$dirsep$increfpages") || die "Error, unable to open $path$dirinc$dirsep$increfpages\n";    
while (<FILE>) {
($site,$nb) = split;
$nbrefull{$site} = $nb;
}
close(FILE);

open(FILE,"$path$dirinc$dirsep$increfin") || die "Error, unable to open $path$dirinc$dirsep$increfin\n";    
while (<FILE>) {
($url,$nb) = split;
$occur{$url} = $nb;
$uniqueurl++;
}
close(FILE);

open(FILE,"$path$dirinc$dirsep$increfkey") || die "Error, unable to open $path$dirinc$dirsep$increfkey\n";    
while (<FILE>) {
($url,$nb) = split;
push(@words,$url);
$w{$url} = $nb;
}
close(FILE);

open(FILE,"$path$dirinc$dirsep$increfengine") || die "Error, unable to open $path$dirinc$dirsep$increfengine\n";    
while (<FILE>) {
chop;
($url,$nb,@fields) = split(/\t/);
if ($nb != 0) {
push(@postring,$url);
#print STDERR "PUSH $url\n";
$seen{$url}++;
$keysh{$url} = $nb;

$grnb{$url} = $nb;

#print STDERR "$url $keysh{$url}\n";
for ($i=0;$i<=$#fields;$i+=2) {
$pagerobot{$url,(($i+2)/2)} = $fields[$i];
$seen{"$url $fields[$i]"}++;
$full{$url,$fields[$i]} = $fields[$i+1];
#print STDERR "$pagerobot{$url,($i/2)} $full{$url,$fields[$i]}\n";
}
} else {

$grnbtot{$url} = (($#fields+1)/2);
for ($i=0;$i<=$#fields;$i+=2) {
$seen{"$fields[$i] $url"}++;
#print STDERR "WWW $url $fields[$i]\n";
$grtot{$url,(($i+2)/2)} = $fields[$i];
$keysh{$grtot{$url,(($i+2)/2)}} = $fields[$i+1];
#print STDERR "$grnbtot{$url} : ($i+2/2) $grtot{$url,(($i+2)/2)} $keysh{$grtot{$url,(($i+2)/2)}}\n";

$gr{$url,($i+2)/2} = $fields[$i];

}
}
}
close(FILE);

if ($opt_p ne '' && -f "$path$dirinc$dirsep$increfselec") {
open(FILE,"$path$dirinc$dirsep$increfselec") || die "Error, unable to open $path$dirinc$dirsep$increfselec\n";    
$a = (<FILE>);
($pageselect2) = split(/\t/,$a);
chop($pageselect2);
while (<FILE>) {
($site,$nb,$nbdate,$tmp) = split(/\t/);
chop($tmp);

if ($pageselect2 eq $pageselect) {
$page{$site} = $nb;
$pagedate{$site} = $nbdate;
$pagequery{$site} = $tmp;
}

}
close(FILE);
}

}
}

# load inc day data

if (-f $filerefday && $opt_b != 1 && $opt_d eq  '' && $referlog eq $prefixlog) {
print "Loading daily incremental data : $filerefday\n";

open(FILEDAYREF,"$filerefday") || die "Error, unable to open $filerefday\n";
$oldjour = <FILEDAYREF>;
#$oldjour =~ s/ /\//g;
chop($oldjour);

#if ($today eq $checkdate) {

while (<FILEDAYREF>) {

($tmp,$tmp1,$tmp2) = split(/\t/,$_);
chop($tmp2);

if ($tmp eq "A") {
$nbreday{$tmp1} = $tmp2;
$uniqueday++;
}

if ($tmp eq "B") {
$nbrefullday{$tmp1} = $tmp2;
$uniquenbrefullday++;
}

if ($tmp eq "C") {
$occurday{$tmp1} = $tmp2;
$uniqueurlday++;
}

if ($tmp eq "D") {
push(@wordsday,$tmp1);
$wday{$tmp1} = $tmp2;

}
#}

}

close (FILEDAYREF);
}


if (($opt_b == 1 && $referlog eq $prefixlog) || (!(-f "$path$dirdata$dirsep$datafile"))) {
open(FILEDATE, ">$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";
print FILEDATE "    Date       Hosts:   Refer:   URL:  Keywords:\n";
print FILEDATE "    ----       -----    -----    ----  --------\n\n";
} else {
open(FILEDATE, ">>$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";
}

#################################################################
###                     gzip log file                         ###
#################################################################

if (($zip == 1 || $zipcut != 0) && (($opt_b == 1) || ($nbline == 0))) {

$month = $monthindex;
$monthprev = $month-1;
$year = $fyear;

   # detection du premier mois de log zipe

while ($out == 0) {
#     while (!(-e $filezip) || !(-e $filerefer)) {
#     do {
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
       $filerefer = $fileroot;

        $smallyear = $year - int($year/100)*100;       
        $smallyear = "0".$smallyear if (length($smallyear) == 1);
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$filerefer .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}
$out = 1 if (-e $filerefer && $zip == 0);
#       $filezip = $filerefer.$zipext if (!(-f $filerefer) && ($zip == 1));
       $filezip = $filerefer.$zipext if ($zip == 1);
	$out = 1 if (-e $filezip && $zip == 1);
     }
#        until (-e $filezip || -e $filerefer);

   $lastfile = $filerefer;
   $lastfilezip = $filezip;
   $stop = 0;
}

# nbre de jour il y a $nbdays days ($opt_d)

#if ($opt_d ne '') {

#$monthindex2 = $monthindex;
#$monthindex2--;

#$pastday = $day  - $opt_d; 
#$pastyear = $fullyear;
#$pastmonth = $month_nb[$monthindex2];

#while ($pastday < 1) {
#  $monthindex2--;
#  if ($monthindex2 < 0) {
#      $pastyear--;
#      $monthindex2 = 11;
#   }
#   $pastmonth = $month_nb[$monthindex2];
#   $pastday = $pastday + $month_of_year{$pastmonth};
#}

#$pasttoday = $pastday." ".$pastmonth." ".$pastyear;  

#$pastmonthnb = $month_equiv{$pastmonth};
#$pastmonthnb = "0".$pastmonthnb if (length($pastmonthnb) == 1);
#}

###################################################################
###             computing referer stats                         ###
###################################################################

if ($zipcut != 0 && ($opt_b != 1 || $opt_d ne '')) {
	($day,$month2,$year) = split(' ',$oldjour) if ($opt_d eq '');	
	($day,$month2,$year) = split(' ',$pasttoday) if ($opt_d ne '');	
        $day = "0".$day unless (length($day) == 2);
        $month = $month_equiv{$month2};
        $month = "0".$month unless (length($month) == 2);
        $lettermonth = $month2;
        $out = 0 if (!(-f $filerefer));
#	if (!(-f $filerefer)) {
        while ($out == 0 && ($year <=  $fullyear && $month <= $monthindex)) {
        $smallyear = $year - int($year/100)*100;
        $smallyear = "0".$smallyear if (length($smallyear) == 1);
        $filerefer = $fileroot; 
    	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$filerefer .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	        }
	$filezip = $filerefer.$zipext if ((!(-f $filerefer)) && $zip == 1);

        $out = 1 if (-f $filerefer || -f $filezip);
        if (!(-f $filezip) && !(-f $filerefer)) {
        if ($zipcut == 2) {
                $day++;
                $day = "0".$day if (length($day) == 1);
                if ($day > $month_of_year{$month_nb[$month-1]}) {
                        $month++;
                        $day = "01";
                        }
                }
	$month++ if ($zipcut == 1);
        $month = "0".$month if (length($month) == 1);
	$year++ if ($month == 13);
	$month = "01" if ($month == 13);
	$lettermonth =  $month_nb[$month-1];
    }

	}   

}      

$filerefer = $fileroot.$prefixlog if (!(-f $filezip) && !(-f $filerefer));

if ($size < $sizeold) {
$nbline = 0;
print STDERR "Your logfile $filerefer have been cut\n";
}

while ($stop == 0) {

#print "$filezip - $filerefer - $nbline - $zipcut\n";
if (($zip == 1) && (-f $filezip) && ((($filerefer ne $filezip) && ($nbline == 0 || $opt_b == 0)) || ($zipcut == 2))) {

       print STDOUT "Scanning $filezip file...\n";
       open(INFILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
    } else {
           print STDOUT "Scanning $filerefer file...\n";
           open(INFILE,$filerefer) || die "Error, unable to open $filerefer\n";
      }
      
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$line = 0;

BOUCLE:
while (<INFILE>) {

$line++;

next BOUCLE if (-f "$path$dirinc$dirsep$increfsites" && $opt_b != 1 && $line <= $nbline);

if ($prefixlog eq $referlog) {

 @line_log = split(/$logfile_sep/);
 chop($line_log[$#line_log]);
 next if ($line_log[0] =~ /^#/);
 
 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

    $adresse = $line_log[$fields_logfile{'%host'}];
    $url = $line_log[$fields_logfile{'%page'}];
    $d = $line_log[$fields_logfile{'%method'}];
    $status = $line_log[$fields_logfile{'%status'}];
    $requetesize = $line_log[$fields_logfile{'%requetesize'}];
    $vserver = $line_log[$fields_logfile{'%virtualhost'}] if ($fields_logfile{'%virtualhost'} ne '');
    $vserver = $1 if ($url =~ /^\/\/([-.0-9a-z]+)\//i && $virtualCLF != 0);
    $vserver = $line_log[$#line_log] if ($#logfile_fields == $fields_logfile{'%virtualhost'});
    $url =~ s/\/\/$virtualfilter// if (($virtualCLF != 0 && $virtualfilter ne '') || ($d =~ /$localserver/));     
    $fullsite = $line_log[$fields_logfile{'%referer'}];
    next if ($status !~ /^(\d+)$/);
    next if ($url =~ /"$/ && $iis_format != 1); # all format should be %page %protocol
    next if ($d !~ /^"/ && $iis_format != 1); # all format should be %page %protocol

($tmp) = split(/:/,$date);
($daytoday,$monthtoday,$yeartoday) = split(/\//,$tmp);
next if ($month_equiv{$monthtoday} !~ /(\d+)/);
next if (length($yeartoday) != 4);
next if ($adresse eq '');
if ($adresse =~ /\//) {
    ($tmp,$adresse) = split(/:/,$adresse);
    print "Problem : found $tmp ... fixing done\n";
}

#     print "A : $fullsite\n";

       if ($fullsite !~ m/\"/) {
       $i = $fields_logfile{'%referer'};
       $tmpi = $i+1;
       $f = $fullsite;
       chop($f);
#       print "F $f :\n";
       while ($f ne "-" && $f !~ m/http:\/\//i && $f ne '') {
#       print "p $f o $tmpi\n";
       $f = $line_log[$tmpi];
#       chop($f);
#       print "A $f :\n";
       $tmpi++;

       }
     $fullsite = $f;
   }

    next if ($fullsite !~ m/http:\/\//i);     

    if ($fullsite =~ /\n/ && $type_serveur == 1) {
    chop($fullsite); # si referer is last field
    }

    $status = $1 if ($query =~ /(\d\d\d);http:\/\// && $type_serveur == 1);

    next if (($status >= 400) && ($status < 599));

    $url =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
    $url =~ tr/[A-Z]/[a-z]/ if ($type_serveur == 1);
    
    next if ($url =~ /$excluderepert/i && $excluderepert ne '');
    next if ($url !~ m#$tri#); # stats sur une partie du serveur
    next if ($url =~ /$dirsepurl[_]/ && $type_serveur == 1);
    next if ($d =~ /$localserver/ && $vserver ne '');
    next if ($vserver =~ /$excludevirtual/i && $excludevirtual ne '');   
    next if ($vserver !~ /$virtualfilter/i && $virtualfilter ne '' && $vserver ne '');

    next if ($requetesize == 0) ; #ote les pages ne contenant rien
    next if ($url =~ /$dirsepurl[_]/ && $type_serveur == 1);    
    next if ($date !~ m/^((\d+)\/(\w+)\/(\d\d\d\d):)(.*)/);
    
    $adresse = $nis{$adresse} if ($nis{$adresse} ne '');
    $adresse = &reversedns($adresse) if ($reverse_dns == 1 && $adresse =~ /^[0-9.]+$/);
    $adresse = $adresse.".".$localdomainename if (split(/[.]/,$adresse) == 1);

    next if (($adresse =~ m/$localdomaine/o) && ($locallog == 0));
    next if (($adresse !~ m/$localdomaine/o) && ($localonly == 1));    
    next if (($adresse =~ /$nolog/i) && ($nolog ne ''));

    if ($opt_d ne '') {
	($fa) = split(':',$date);
	($fa1,$fa2,$fa3) = split('/',$fa);
	next if ($fa3 < $pastyear);
	$mequiv = $month_equiv{$fa2};
	next if ($fa3 == $pastyear && $mequiv < $pastmonthnb);
	next if ($fa3 == $pastyear && $mequiv == $pastmonthnb && $fa1 < $pastday);
    }

    if ($fullsite eq '') {
       print STDERR "Not a extented common log file !!!\n";
       $fullsite = "-";
       print STDERR "This line may have problem : $_";
       next BOUCLE;
       }
	     

    ($jour) = split(/:/,$date);
    $jour =~ s/[\/]/ /g;
    $firstday = $jour if ($firstday eq '');
    $oldjour = $firstday if ($firstday eq $jour);

    $fullsite =~ s/"//g;

    $fullsite =~ s/^R://g;
    $fullsite =~ s/#.*//;    
     next if ($fullsite eq '');
#    print "$fullsite - $vserver\n";   

   } else {

   if ($type_serveur == 2) {
   ($date,$fullsite) = split(/"/);
   chop($fullsite);
    ($jour) = split(/:/,$date);
    $jour =~ s/[\/\[]/ /g;

    $firstday = $jour if ($firstday eq '');
    $oldjour = $firstday if ($firstday eq $jour);
   }
   
   ($fullsite,$separateur,$url) = split if ($type_serveur != 2);
   next if ($fullsite !~ m/http:\/\//i);

#   print  "$fullsite\n";
}


if ($jour ne $oldjour) {


## Tri Refer

    $oldjour =~ s/ /\//g;

foreach $tmp (sort (keys(%nbreday))) {
    push(@counternbre,$nbreday{$tmp}) unless $seen{"$oldjour $tmp $nbreday{$tmp}"}++;
    $countnbre[$nbreday{$tmp}]++;
    $occur_counternbre{$nbreday{$tmp},$countnbre[$nbreday{$tmp}]} = $tmp;
}

@bestnbreday = reverse sort bynumber @counternbre;

#

foreach $tmp (sort (keys(%nbrefullday))) {
    push(@counternbrefull,$nbrefullday{$tmp}) unless $seen{"$oldjour $tmp $nbrefullday{$tmp}"}++;
    $countnbrefull[$nbrefullday{$tmp}]++;
    $occur_counternbrefull{$nbrefullday{$tmp},$countnbrefull[$nbrefullday{$tmp}]} = $tmp;
}

@bestnbrefullday = reverse sort bynumber @counternbrefull;


#

foreach $tmp (sort (keys(%occurday))) {
    push(@counteroccur,$occurday{$tmp}) unless $seen{"$oldjour $tmp $occurday{$tmp}"}++;
    $countoccur[$occurday{$tmp}]++;
    $occur_counteroccur{$occurday{$tmp},$countoccur[$occurday{$tmp}]} = $tmp;
}

@bestoccurday = reverse sort bynumber @counteroccur;


    $oldjour =~ s/[\/]/ /g;
#

#$bouclewords = $topten unless (($#words+1) < $topten);
#$bouclewords = ($#words+1) unless (($#words+1) > ($topten-1));


for ($i=0;$i <= $#wordsday;$i++) {
	$maxi = 0;
	for ($j=0;$j<=$#wordsday;$j++) {
	if ($wday{$wordsday[$j]} > $maxi) {
		$maxi = $wday{$wordsday[$j]};
		$bestwordsday[$i] = $wordsday[$j];
		$occurwordsday[$i] = $wday{$wordsday[$j]};
		}
	}
        $wday{$bestwordsday[$i]} = 0;
    }


#

print FILEDATE "$oldjour\t$uniqueday\t$uniquenbrefullday\t$uniqueurlday\t$#wordsday\n" if ($prefixlog eq $referlog);

($tmp1,$tmp2,$tmp3) = split(/ /,$oldjour);
$dirresume = $tmp3."-".$tmp2."-".$tmp1;

for ($nblang=0;$nblang<=$#lang;$nblang++) {


$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
mkdir ($tmp,0775) unless -d $tmp;
$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume.$dirsep.$tabnamerefer;


#if (-e $tmp) {
#open(FILEDAYREFER,">>$tmp") || die "Error, unable to open $tmp\n";
#} else {
open(FILEDAYREFER,">$tmp") || die "Error, unable to open $tmp\n";
#}

&ReferDay(*FILEDAYREFER, eval($Lang{$lang[$nblang]}));

close (FILEDAYREFER);
}

$oldjour = $jour;


#undef %nbreday;
#undef %nbrefullday;
#undef %occurday;

$tmp1 = $#wordsday;
for ($i=0;$i<=$tmp1;$i++) {
    $site = shift(@wordsday);
    undef $wday{$site};
}

undef @wordsday;

foreach $tmp (keys(%nbreday)) {
for ($i=0;$i<=$countnbre[$nbreday{$tmp}];$i++) {
$occur_counternbre{$nbreday{$tmp},$i} = '';
}
$countnbre[$nbreday{$tmp}] = 0;
$nbreday{$tmp} = 0;
}

undef @counternbre;

#

foreach $tmp (keys(%nbrefullday)) {
for ($i=0;$i<=$countnbrefull[$nbrefullday{$tmp}];$i++) {
$occur_counternbrefull{$nbrefullday{$tmp},$i} = '';
}
$countnbrefull[$nbrefullday{$tmp}] = 0;
$nbrefullday{$tmp} = 0;
}

undef @counternbrefull;

#

foreach $tmp (keys(%occurday)) {
for ($i=0;$i<=$countoccur[$occurday{$tmp}];$i++) {
$occur_counteroccur{$occurday{$tmp},$i} = '';
}
$countoccur[$occurday{$tmp}] = 0;
$occurday{$tmp} = 0;
}

undef @counteroccur;


#

$uniqueurlday = 0;
$uniqueday = 0;
$uniquenbrefullday = 0;
}

$url =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
$url .= $defaulthomepage if (substr($url,length($url)-1) eq "/");

next if ($url !~ m#$tri#i);

$site = $fullsite;
$site =~ s/http:\/\///i;

next if ($site =~ m/$localdomaine/ && $localrefer == 0 && $vserver eq '');

($f1,$f2,$f3) = split(/\//,$fullsite);

next if ($f3 !~ m/\./);

# uncomment this if your host have several domain name alias
#$site_ip = gethostbyname($f3);
#next if ($site_ip eq $server_ip && $localrefer == 0);

($tmp,$query) = split(/\?/,$url);

if ($type_serveur != 2) {
$out = 0;
       $out = 1 if (substr($tmp,rindex($tmp,'.')) =~ m/$extension/i);
}

if ($type_serveur == 2) {
$out = 1;
for ($i=0;$i<=($#extensionimage);$i++) {
       $out = 0 if (substr($tmp,rindex($tmp,'.')+1) =~ m/^$extensionimage[$i]$/i);
}
}

next BOUCLE if ($out == 0);

#$fullsite =~ tr/A-Z/a-z/;

$sitesh = substr($site,0,index($site,'/')) if ($site =~ /\//);
$sitesh = $site if ($site !~ /\//);
#print "AA $sitesh - $site\n";
$sitesh =~ tr/[A-Z]/[a-z]/;
#print "BB $site - $sitesh\n" if ($sitesh =~ /\//);

next if ($sitesh eq $virtualfilter && $localrefer == 0 && $virtualfilter ne '');
next if ($sitesh eq $vserver && $localrefer == 0 && $vserver ne '');

if ($site =~ /\?/i) {
#print STDERR "$site\n";
# les sites les plus rares en premier
($a,$b) = split(/[&?]q=/,$site) if ($site =~ m/[&?]q=/i);
($a,$b) = split(/[&?]qt=/,$site) if ($site =~ m/[&?]qt=/i);
($a,$b) = split(/[&?]query=/,$site) if ($site =~ m/[&?]query=/);
($a,$b) = split(/[&?]QUERY=/,$site) if ($site =~ m/[&?]QUERY=/); # split sur min/maj /i ?
($a,$b) = split(/[&?]s=/,$site) if ($site =~ m/[&?]s=/i);
($a,$b) = split(/[&?]general=/,$site) if ($site =~ m/[&?]general=/i);
($a,$b) = split(/[&?]search=/,$site) if ($site =~ m/[&?]search=/i);
($a,$b) = split(/[&?]MT=/,$site) if ($site =~ m/[&?]MT=/i);
($a,$b) = split(/[&?]text=/,$site) if ($site =~ m/[&?]text=/i);
($a,$b) = split(/[&?]searchText=/,$site) if ($site =~ m/[&?]searchText=/i);
($a,$b) = split(/[&?]KW=/,$site) if ($site =~ m/[&?]KW=/i);
($a,$b) = split(/[&?]p=/,$site) if ($site =~ m/[&?]p=/i);
$b =~ s/\&.*//;
$b =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
$b =~ tr/[A-Z]/[a-z]/;
#$b =~ s/(.*)"(\+)"(.*)/$1""$3/g;  # supprimer les + entre les ""
next if ($b eq "search");
@string = split(/\+/,$b);
for ($k=0;$k<=$#string;$k++) {
if (length($string[$k]) > 2) {
$w{$string[$k]}++;
$wday{$string[$k]}++;
push(@words,$string[$k]) if ($w{$string[$k]} == 1);
push(@wordsday,$string[$k]) if ($wday{$string[$k]} == 1);
}
}
$b =~ s/\+/ /g;
$b =~ s/"//g;

$pospoint2 = rindex($sitesh,'.');
$tmp = substr($sitesh,0,$pospoint2);
$pospoint1 = rindex($tmp,'.')+1;

while ($pospoint1 > 1) {
$tmp2 = substr($tmp,0,$pospoint1-1);
$tmp = substr($tmp,$pospoint1,$pospoint2);
$pospoint2 = length($tmp2);
$pospoint1 = rindex($tmp2,'.')+1;

if (length($tmp) > 2 && $tmp ne "search") {
$grnb{$tmp}++;

if (!($seen{"$sitesh $tmp"}++)) {
$grnbtot{$tmp}++;
$grtot{$tmp,$grnbtot{$tmp}} = $sitesh;
#print STDERR "toto $sitesh $tmp $grnbtot{$tmp}\n";
}

$gr{$tmp,$grnb{$tmp}} = $sitesh;

push(@postring,$tmp) unless ($seen{$tmp}++);
$keysh{$tmp}++;
$pagerobot{$tmp,$keysh{$tmp}} = $b unless ($seen{"$tmp $b"}++);
$full{$tmp,$b}++;
$tmp = $tmp2;
}
}

$tmp = substr($tmp,0,$pospoint2);

if ($tmp ne "www" && length($tmp) > 2 && $tmp ne "search") {
$grnb{$tmp}++;
$gr{$tmp,$grnb{$tmp}} = $sitesh;

if (!($seen{"$sitesh $tmp"}++)) {
$grnbtot{$tmp}++;
$grtot{$tmp,$grnbtot{$tmp}} = $sitesh;
#print STDERR "toto $sitesh $tmp $grnbtot{$tmp}\n";
}
$keysh{$tmp}++;
$pagerobot{$tmp,$keysh{$tmp}} = $b unless ($seen{"$tmp $b"}++);
$full{$tmp,$b}++;
push(@postring,$tmp) unless ($seen{$tmp}++);
}

$keysh{$sitesh}++;

}

if ($opt_p ne '' && $url =~ /$pageselect/) {
$pagequery{$site} = $query if ($query ne '');
$page{$site}++;
$pagedate{$site} = $jour;
#print STDERR "$site $page{$site} $pagedate{$site}\n";
}

#$site = substr($site,0,index($site,'/'));

$nbre{$sitesh}++;
$nbreday{$sitesh}++;
$nbrefull{$fullsite}++;
$nbrefullday{$fullsite}++;
$uniquenbrefullday++ if ($nbrefullday{$fullsite} == 1);

$url =~ s/^\/\/[-.0-9a-z]+\//\//i;
#$loc{$url} = $fullsite;
#$locday{$url} = $fullsite;
$occur{$url}++;
$occurday{$url}++;

$uniqueurl++ if ($occur{$url} == 1);
$uniqueurlday++ if ($occurday{$url} == 1);
$unique++ if ($nbre{$sitesh} == 1);
$uniqueday++ if ($nbreday{$sitesh} == 1);

}

close (INFILE); 

### derniere journee

if ($prefixlog eq $referlog) {

($tmp1,$tmp2,$tmp3) = split(/ /,$jour);
$dirresume = $tmp3."-".$tmp2."-".$tmp1;

#print "Saving daily incremental data : $filerefday\n";

open(FILEDAYREFER,">$filerefday") || die "Error, unable to open $filerefday\n";
$jour = $oldjour if ($jour eq '');
print FILEDAYREFER "$jour\n";

foreach $site (keys(%nbreday)) {
    print FILEDAYREFER "A\t$site\t$nbreday{$site}\n";
}

foreach $site (keys(%nbrefullday)) {
    print FILEDAYREFER "B\t$site\t$nbrefullday{$site}\n";
}

foreach $site (keys(%occurday)) {
    print FILEDAYREFER "C\t$site\t$occurday{$site}\n";
}

#$tmp1 = $#wordsday;
for ($i=0;$i<=$#wordsday;$i++) {
#    $site = shift(@wordsday);
    $site = $wordsday[$i];
    print FILEDAYREFER "D\t$site\t$wday{$site}\n";
}

close (FILEDAYREFER);

}

# mois gzip suivant

$stop = 1 if (($zip != 1 && $zipcut == 0) || ($filerefer eq $filezip));

if ($zip == 1 || $zipcut != 0) {

$stop = 1 if ($filerefer eq "$fileroot$prefixlog" && $file eq $filerefer);

$nbline = 0;

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
          $filezip = $fileroot.$prefixlog if ($file eq $filerefer);
          $filerefer = $fileroot.$prefixlog if ($file eq $filerefer);
          $filezip = $fileroot.$referlog if ($file ne $filerefer);
          $filerefer = $fileroot.$referlog if ($file ne $filerefer);       
          $stop = 1 if (!(-f $filerefer));
      }
    }
} else {
   if (-e $filerefer && $zipcut != 0) {
   } else {
          $stop = 1 if (!(-f $filerefer));
   }
}

}
}

##### Last day

## Tri Refer

    $oldjour =~ s/ /\//g;

foreach $tmp (sort (keys(%nbreday))) {
    push(@counternbre,$nbreday{$tmp}) unless $seen{"$oldjour $tmp $nbreday{$tmp}"}++;
    $countnbre[$nbreday{$tmp}]++;
    $occur_counternbre{$nbreday{$tmp},$countnbre[$nbreday{$tmp}]} = $tmp;
}

@bestnbreday = reverse sort bynumber @counternbre;

#

foreach $tmp (sort (keys(%nbrefullday))) {
    push(@counternbrefull,$nbrefullday{$tmp}) unless $seen{"$oldjour $tmp $nbrefullday{$tmp}"}++;
    $countnbrefull[$nbrefullday{$tmp}]++;
    $occur_counternbrefull{$nbrefullday{$tmp},$countnbrefull[$nbrefullday{$tmp}]} = $tmp;
}

@bestnbrefullday = reverse sort bynumber @counternbrefull;


#

foreach $tmp (sort (keys(%occurday))) {
    push(@counteroccur,$occurday{$tmp}) unless $seen{"$oldjour $tmp $occurday{$tmp}"}++;
    $countoccur[$occurday{$tmp}]++;
    $occur_counteroccur{$occurday{$tmp},$countoccur[$occurday{$tmp}]} = $tmp;
}

@bestoccurday = reverse sort bynumber @counteroccur;


    $oldjour =~ s/[\/]/ /g;
#

#$bouclewords = $topten unless (($#words+1) < $topten);
#$bouclewords = ($#words+1) unless (($#words+1) > ($topten-1));


for ($i=0;$i <= $#wordsday;$i++) {
	$maxi = 0;
	for ($j=0;$j<=$#wordsday;$j++) {
	if ($wday{$wordsday[$j]} > $maxi) {
		$maxi = $wday{$wordsday[$j]};
		$bestwordsday[$i] = $wordsday[$j];
		$occurwordsday[$i] = $wday{$wordsday[$j]};
		}
	}
        $wday{$bestwordsday[$i]} = 0;
    }


#

print FILEDATE "$oldjour\t$uniqueday\t$uniquenbrefullday\t$uniqueurlday\t$#wordsday\n" if ($prefixlog eq $referlog);

($tmp1,$tmp2,$tmp3) = split(/ /,$oldjour);
$dirresume = $tmp3."-".$tmp2."-".$tmp1;

for ($nblang=0;$nblang<=$#lang;$nblang++) {

$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
mkdir ($tmp,0775) unless -d $tmp;
$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume.$dirsep.$tabnamerefer;

open(FILEDAYREFER,">$tmp") || die "Error, unable to open $tmp\n";
&ReferDay(*FILEDAYREFER, eval($Lang{$lang[$nblang]}));
close (FILEDAYREFER);
}

$jourfin = $jour;
close(FILEDATE) if ($prefixlog eq $referlog);

#################################################################
####             sauvegarde des donnees                   #######
#################################################################


open(FILE,">$path$dirinc$dirsep$increfsites") || die "Error, unable to open $path$dirinc$dirsep$increfersites\n";
print FILE "$line\t$firstday\t$jour\t$size\n";
foreach $site (keys(%nbre)) {
    print FILE "$site $nbre{$site}\n";
}
close(FILE);    

open(FILE,">$path$dirinc$dirsep$increfpages") || die "Error, unable to open $path$dirinc$dirsep$increfpages\n";    
foreach $fullsite (keys(%nbrefull)) {
     print FILE "$fullsite $nbrefull{$fullsite}\n";
}
close(FILE);

open(FILE,">$path$dirinc$dirsep$increfin") || die "Error, unable to open $path$dirinc$dirsep$increfin\n";    
foreach $url (keys(%occur)) {
print FILE "$url $occur{$url}\n";
}
close(FILE);

open(FILE,">$path$dirinc$dirsep$increfkey") || die "Error, unable to open $path$dirinc$dirsep$increfkey\n";    
for ($j=0;$j<=$#words;$j++) {
print FILE "$words[$j] $w{$words[$j]}\n";
}
close(FILE);

open(FILE,">$path$dirinc$dirsep$increfengine") || die "Error, unable to open $path$dirinc$dirsep$increfengine\n";    
for ($i=0;$i<=$#postring;$i++) {
print FILE "$postring[$i]\t$keysh{$postring[$i]}\t";
for ($j=1;$j<=$keysh{$postring[$i]};$j++) {
print FILE "$pagerobot{$postring[$i],$j}\t$full{$postring[$i],$pagerobot{$postring[$i],$j}}\t" if ($pagerobot{$postring[$i],$j} ne '');; 
}
print FILE "\n";
print FILE "$postring[$i]\t0\t";
for ($j=1;$j<=$grnbtot{$postring[$i]};$j++) {
print FILE "$grtot{$postring[$i],$j}\t$keysh{$grtot{$postring[$i],$j}}\t";
}
print FILE "\n";
}
close(FILE);

if ($opt_p ne '') {
open(FILE,">$path$dirinc$dirsep$increfselec") || die "Error, unable to open $path$dirinc$dirsep$increfselec\n";    
print FILE "$pageselect\n";
foreach $site (keys(%page)) {
    print FILE "$site\t$page{$site}\t$pagedate{$site}\t$pagequery{$site}\n";
}

close(FILE);
}

#############################################################################

&save_reverse_dns if ($reverse_dns == 1); # sauvegarde de la table de DNS

exit if ($line == $nbline);

sub nextlog {
$day++ if ($zipcut == 2);
if ($day > $month_of_year{$month_nb[$monthprev]}) {
$month++;
$monthprev++;
$day = "01";
} else {
$month++ if ($zipcut == 1);
$monthprev = $month-1;
}


$month = "0".$month unless (length($month) == 2);
$day = "0".$day unless (length($day) == 2);

$year++ if ($month == 13);
$month = "01" if ($month == 13);
$monthprev = 0 if ($month == 1);
$lettermonth = $month_nb[$monthprev];
$filerefer = $fileroot;
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
$compressed_logfile_fields[$i] =~ s/\%/\$/;
$filerefer .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}
      
$filezip = $filerefer.$zipext if ($zip == 1);
}

###################################################################

if ($prefixlog eq $referlog) {
for ($nblang=0;$nblang<=$#lang;$nblang++) {

        $tabdays = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$refer;

        open(TABOUT, ">$tabdays") || die "Error, unable to open $tabdays\n";
        &TableReferHeader(*TABOUT, eval($Lang{$lang[$nblang]}));
        &TableReferDays(*TABOUT, eval($Lang{$lang[$nblang]}));
        print TABOUT "</TABLE>\n";
        print TABOUT "<P><HR><P>\n";    
        print TABOUT "</BODY></HTML>\n";
        close(TABOUT);
}
}

#################################################################
####                  tri des meilleurs                   #######
#################################################################

# tri des $topten meilleurs sites de referer
$boucle = $topten unless ($unique < $topten);
$boucle = $unique unless ($unique > ($topten-1));
$bouclep = 0;
$tmp = 0;

for ($i=0;$i < $boucle;$i++) {
$maxi = 0;
foreach $site (keys(%nbre)) {
    if ($nbre{$site} > $maxi) {
         $maxi = $nbre{$site};
         $bestsite[$i] = $site;
        $occursite[$i] = $nbre{$site};
         }
    }
$nbre{$bestsite[$i]} = 0;
}


# tri des $topten meilleurs pages de referer

foreach $fullsite (keys(%nbrefull)) {
    $tmp++;
}

for ($i=0;$i < $boucle;$i++) {
$maxi = 0;
foreach $fullsite (keys(%nbrefull)) {
    $bouclep++ if ($fullsite =~ /\?/);
   if ($nbrefull{$fullsite} > $maxi && $fullsite !~ /\?/) {       
         $maxi = $nbrefull{$fullsite};
         $bestfullsite[$i] = $fullsite;
         $occurfullsite[$i] = $nbrefull{$fullsite};
#	 print "$i - $bestfullsite[$i] - $nbrefull{$fullsite}\n";
         }

    }
$nbrefull{$bestfullsite[$i]} = 0;
}

#print STDERR "B - $tmp - $bouclep - $boucle\n";

$bouclep = $bouclep/$boucle if ($boucle != 0);

#print STDERR "B - $tmp - $bouclep\n";

$bouclep = $tmp - $bouclep;
$bouclep = $boucle if ($bouclep > $boucle);

#print STDERR "B - $tmp - $bouclep\n";


# tri des $topten meilleurs page d'arrivee de referee

$boucle2 = $topten unless ($uniqueurl < $topten);
$boucle2 = $uniqueurl unless ($uniqueurl > ($topten-1));

for ($i=0;$i < $boucle2;$i++) {
$maxi = 0;
foreach $url (keys(%occur)) {
    if ($occur{$url} > $maxi) {
         $maxi = $occur{$url};
         $besturl[$i] = $url;
         $timeurl[$i] = $occur{$url};
         }
    }
$occur{$besturl[$i]} = 0;
}

# tri des $topten meilleurs keywords from engine search

$bouclewords = $topten unless (($#words+1) < $topten);
$bouclewords = ($#words+1) unless (($#words+1) > ($topten-1));

for ($i=0;$i < $bouclewords;$i++) {
	$maxi = 0;
	for ($j=0;$j<=$#words;$j++) {
	if ($w{$words[$j]} > $maxi) {
		$maxi = $w{$words[$j]};
		$bestwords[$i] = $words[$j];
		$occurwords[$i] = $w{$words[$j]};
		}
	}
        $w{$bestwords[$i]} = 0;
	}
	
# tri des $topten meilleurs search engine site

#for ($i=0;$i<=$#postring;$i++) {
#for ($j=1;$j<=$grnb{$postring[$i]};$j++) {
#print STDERR "AA - $i $j $postring[$i] $gr{$postring[$i],$j} $grnb{$postring[$i]}\n";
#}
#}
#print STDERR "\n";

for ($i=0;$i<=$#postring;$i++) {
#print STDERR "A- $postring[$i]\n";
$match = 0;
#$doublon++ if (length($postring[$i]) < 3);
#if ($match == 0) {
LABEL:
for ($k=0;$k<=$#postring;$k++) {
next LABEL if ($i == $k);
$match = 0; # if (length($postring[$i]) > 2);
LABEL2:
for ($j=1;$j<=$grnb{$postring[$i]};$j++) {
$match++ if ($gr{$postring[$k],1} eq $gr{$postring[$i],$j} && $postring[$k] ne '' && $postring[$i] ne '');
#print STDERR "$i $postring[$i] $k $postring[$k] $j $gr{$postring[$k],1} $gr{$postring[$i],$j}\n" if ($match > 0);
last LABEL2 if ($match > 0);
}
#}

if ($match > 0) {
#print STDERR "B : $match - $postring[$i] $postring[$k]\n";
if ($grnb{$postring[$i]} < $grnb{$postring[$k]}) {
#print STDERR "$postring[$i] $grnb{$postring[$i]} $grnb{$postring[$k]} est un doublon\n";
$grnb{$postring[$i]} = 0;
$postring[$i] = '';
}
if ($grnb{$postring[$i]} >= $grnb{$postring[$k]}) {
#print STDERR "$postring[$k] $grnb{$postring[$i]} $grnb{$postring[$k]} est un doublon\n";
$grnb{$postring[$k]} = 0;
$postring[$k] = '';
}
$doublon++;
}
}

}


$bouclerobot = $topten unless (($#postring+1-$doublon) < $topten);
$bouclerobot = ($#postring+1-$doublon) unless (($#postring+1-$doublon) > ($topten-1));

for ($i=0;$i<=$bouclerobot;$i++) {
    $maxi = 0;
    for ($j=0;$j<=$#postring;$j++) {
	if ($grnb{$postring[$j]} > $maxi) {
	    $maxi = $grnb{$postring[$j]};
	    $bestrobot[$i] = $postring[$j];
	    $occurrobot[$i] = $grnb{$postring[$j]};
	}
    }
    $grnb{$bestrobot[$i]} = 0;
}
		

#

for ($i=0;$i<$bouclerobot;$i++) {

    $tmpbou[$i] = $topten if ($occurrobot[$i] > $topten);
    $tmpbou[$i] = $occurrobot[$i] if ($occurrobot[$i] <= $topten);

    for ($k=1;$k <= $tmpbou[$i];$k++) {
	$maxi = 0;
	for ($j=0;$j<=$occurrobot[$i];$j++) {
	    $tmp2 = $full{$bestrobot[$i],$pagerobot{$bestrobot[$i],$j}};
	    if ($tmp2 > $maxi) {
		$maxi = $tmp2;
		$aa = $k;
		$pagerobot2{$bestrobot[$i],$k} = $pagerobot{$bestrobot[$i],$j};
		$full2{$bestrobot[$i],$pagerobot2{$bestrobot[$i],$k}} = $tmp2;
	    }
	}
	$full{$bestrobot[$i],$pagerobot2{$bestrobot[$i],$aa}} = 0;
    }
}


############################################
### creation du fichier pour les referer ###
############################################

$ydayfirst = &nbdayan($firstday);

foreach $site (sort keys(%pagedate)) {
	$yday = &nbdayan($pagedate{$site});
	$intervalle = $yday-$ydayfirst;
	$intervalle += 365 if ($intervalle < 0);
	$tri[$nb] = $intervalle;
	$pagesort[$nb] = $site;
	$nb++;
}

$nb--;

for ($j=0;$j<=$nb;$j++) {
	for ($i=0;$i<$nb;$i++) {
	if ($tri[$j] > $tri[$i]) {
		$tmp = $tri[$j];
		$tri[$j] = $tri[$i];
		$tri[$i] = $tmp;
		
		$tmp = $pagesort[$j];
		$pagesort[$j] = $pagesort[$i];
		$pagesort[$i] = $tmp;
		}
	}
}


for ($nblang=0;$nblang<=$#lang;$nblang++) {

 $tabrefer = $path.$lang[$nblang].$dirsep.$dirlist.$dirsep.$tabnamerefer;

 open(TABREFER,">$tabrefer") || die "Error, unable to open $tabrefer\n";
 &ReferHeader(*TABREFER, eval($Lang{$lang[$nblang]}));
 close(TABREFER);
 
 $tabkeyword = $path.$lang[$nblang].$dirsep.$dirlist.$dirsep.$tabnamekeyword;

 open(TABKEYWORD,">$tabkeyword") || die "Error, unable to open $tabkeyword\n";
 &Keyword(*TABKEYWORD, eval($Lang{$lang[$nblang]}));
 close(TABKEYWORD);
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

open(FILE,">>$history");
#print FILE "cron-refer\t$today\t$startrun\t$endrun\t$min:$sec\t$line\n";
printf FILE "cron-refer\t%s\t%s\t%s\t%d:%d\t%d\n",$today,$startrun,$endrun,$min,$sec,$line;
close(FILE);

#########################################################################

sub ReferHeader {
  local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Referer_about'} $localserver</TITLE>\n" if ($virtualfilter eq '');
 print FOUT "<TITLE>$L{'Referer_about'} $virtualfilter</TITLE>\n" if ($virtualfilter ne ''); 
 print FOUT "<!-- Page generated by w3perl - cron-refer.pl $version - $today $hourdate -->\n";
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1>$L{'References_for'} $localserver</H1>\n<P>\n" if ($virtualfilter eq '');
 print FOUT "<H1>$L{'References_for'} $virtualfilter</H1>\n<P>\n" if ($virtualfilter ne ''); 

 print FOUT "<HR size=5>\n";
 if ($prefixlog eq $referlog) {
 print FOUT "<CENTER><B>$firstday - $jourfin</B></CENTER>\n";
 print FOUT "<HR size=5>\n";
 }
 print FOUT "<P>\n<A HREF=\"$tabnamekeyword\">$L{'Search_engine'}</A> $L{'on'} $localserver\n" if ($virtualfilter eq '');
 print FOUT "<P>\n<A HREF=\"$tabnamekeyword\">$L{'Search_engine'}</A> $L{'on'} $virtualfilter\n" if ($virtualfilter ne '');

 if ($prefixlog eq $referlog) {
 print FOUT "<BR>$L{'Tab_about_lastdays1'} <A HREF=\"..$dirsepurl$dirdate$dirsepurl$refer\">$count_day $L{'Tab_about_lastdays2'}</A>";
}

 print FOUT "<HR><P>\n\n";

 print FOUT "$L{'The_Top'} $boucle $L{'most_successful_hosts'}<p>\n";
 print FOUT "<TABLE border=1 width=100%>\n";
 print FOUT "<TR><TH>$L{'Hosts_from'}</TH><TH>$L{'Occurence'}</TH></TR>\n";

for ($i=0;$i < $boucle;$i++) {
print FOUT "<TR>\n<TD>$bestsite[$i]</TD>\n<TD align=middle><B>$occursite[$i]</B> $L{'times'}</TD>\n</TR>\n";
}

 print FOUT "</TABLE>\n\n";

 print FOUT "<P><HR><P>\n\n";

 print FOUT "$L{'The_Top'} $bouclep $L{'referer_pages1'}<p>\n";
 print FOUT "<TABLE border=1 width=100%>\n";
 print FOUT "<TR><TH>$L{'Referer_pages2'}</TH><TH>$L{'Occurence'}</TH></TR>\n";

for ($i=0;$i < $bouclep;$i++) {
$newbestfullsite = $bestfullsite[$i];
$newbestfullsite =~ s/http:\/\///i;
print FOUT "<TR>\n<TD><A HREF=\"$bestfullsite[$i]\">$newbestfullsite</A></TD>\n<TD align=middle><B>$occurfullsite[$i]</B> $L{'times'}</TD>\n</TR>\n";
}

 print FOUT "</TABLE>\n\n";

if ($type_serveur != 2) {
 print FOUT "<P><HR><P>\n\n";

 print FOUT "$L{'The_Top'} $boucle $L{'server_pages1'}<p>\n";
 print FOUT "<TABLE border=1 width=100%>\n";
 print FOUT "<TR><TH>$L{'Server_pages2'}</TH><TH>$L{'Occurence'}</TH></TR>\n";

for ($i=1;$i < $boucle2;$i++) {
print FOUT "<TR>\n<TD><A HREF=\"http://$localserver$besturl[$i]\">";
print FOUT "$besturl[$i]" if ($titlename == 0 || $urlconv{$besturl[$i]} eq '');
print FOUT "<b>$urlconv{$besturl[$i]}</b>" if ($titlename == 1 && $urlconv{$besturl[$i]} ne '');
print FOUT "</A></TD>\n<TD align=middle><B>$timeurl[$i]</B> $L{'times'}</TD>\n</TR>\n";
}

 print FOUT "</TABLE>\n\n";
}

if ($opt_p ne '' && $nb > 0 && $type_serveur != 2) {

 print FOUT "<P><HR><P>\n\n";

 print FOUT "$L{'Referer_on'} $pageselect ($firstday - $jourfin)<p>\n";

 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR><TH>$L{'Referer_pages2'}</TH><TH>$L{'Occurence'}</TH><TH>$L{'Last_occurence'}</TH></TR>\n";

for ($i=0;$i<=$nb;$i++) {
    $site = $pagesort[$i];
print FOUT "<TR>\n<TD><A HREF=\"http://$site\">";
print FOUT "$site";
print FOUT "</A>";
print FOUT " <I>[$pagequery{$site}]</I>" if ($pagequery{$site} ne '');
print FOUT "</TD>\n";
print FOUT "<TD align=middle><B>$page{$site}</B> $L{'times'}</TD>\n";
print FOUT "<TD align=middle><I>$pagedate{$site}</I></TD>\n</TR>\n";
}


#foreach $site (keys(%page)) {
#print FOUT "<TR>\n<TD><A HREF=\"http://$site\">";
#print FOUT "$site";
#print FOUT "</A>";
#print FOUT " <I>[$pagequery{$site}]</I>" if ($pagequery{$site} ne '');
#print FOUT "</TD>\n";
#print FOUT "<TD align=middle><B>$page{$site}</B> $L{'times'}</TD>\n";
#print FOUT "<TD align=middle><I>$pagedate{$site}</I></TD>\n</TR>\n";
#}

 print FOUT "</TABLE>\n\n";
}

 print FOUT "</BODY></HTML>\n";
 }
 

#########################################################################

sub ReferDay {
  local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Referer_about'} $localserver - $oldjour</TITLE>\n" if ($virtualfilter eq '');
 print FOUT "<TITLE>$L{'Referer_about'} $virtualfilter - $oldjour</TITLE>\n" if ($virtualfilter ne ''); 
 print FOUT "<!-- Page generated by w3perl - cron-refer.pl $version - $today $hourdate -->\n";
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H3>$L{'References_for'} $localserver</H3>\n<P>\n" if ($virtualfilter eq '');
 print FOUT "<H3>$L{'References_for'} $virtualfilter</H3>\n<P>\n" if ($virtualfilter ne ''); 

 print FOUT "$L{'The_Top'} $topten $L{'most_successful_hosts'} ($L{'among'} $uniqueday)<p>\n";

# print FOUT "$uniqueday $L{'most_successful_hosts'}<p>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR><TH>$L{'Hosts_from'}</TH><TH>$L{'Occurence'}</TH></TR>\n";

#for ($i=0;$i <$topten;$i++) {
##for ($i=0;$i <$uniqueday;$i++) {
# $site = $bestnbreday[$i];

##foreach $site (sort keys(%nbreday)) {
##print FOUT "<TR>\n<TD>$site</TD>\n<TD ALIGN=CENTER><B>$nbreday{$site}</B> $L{'times'}</TD>\n</TR>\n" if ($nbreday{$site} != 0);
##    $nbreday{$site} = 0;
#}

$tmp = 0;
$i = 0;
while ($tmp < $topten && $bestnbreday[$i] ne '') {

for ($j=1;$j<= $countnbre[$bestnbreday[$i]];$j++) {
$tmp++;
last if ($tmp > $topten);
$site = $occur_counternbre{$bestnbreday[$i],$j};
print FOUT "<TR>\n<TD>$site</TD>\n<TD ALIGN=CENTER><B>$bestnbreday[$i]</B> $L{'times'}</TD>\n</TR>\n" if ($bestnbreday[$i] != 0);
}
$i += $countnbre[$bestnbreday[$i]];
}
 print FOUT "</TABLE>\n\n";

###

 print FOUT "<P><HR><P>\n\n";

 print FOUT "$L{'The_Top'} $topten $L{'referer_pages1'} ($L{'among'} $uniquenbrefullday)<p>\n";
# print FOUT "$L{'The_Top'} $uniquenbrefullday $L{'referer_pages1'}<p>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR><TH>$L{'Referer_pages2'}</TH><TH>$L{'Occurence'}</TH></TR>\n";

$tmp = 0;
$i = 0;
while ($tmp < $topten && $bestnbrefullday[$i] ne '') {

for ($j=1;$j<= $countnbrefull[$bestnbrefullday[$i]];$j++) {
$tmp++;
last if ($tmp > $topten);
$site = $occur_counternbrefull{$bestnbrefullday[$i],$j};
$tmp2 = $site;
$tmp2 =~ s/http:\/\///;
print FOUT "<TR>\n<TD><A HREF=\"$site\">$tmp2</A></TD>\n<TD ALIGN=CENTER><B>$bestnbrefullday[$i]</B> $L{'times'}</TD>\n</TR>\n" if ($bestnbrefullday[$i] != 0);
}
$i += $countnbrefull[$bestnbrefullday[$i]];
}

##for ($i=0;$i <$topten;$i++) {
##for ($i=0;$i <= $uniquenbrefullday;$i++) {
#    $site = $bestnbrefullday[$i];

##foreach $site (keys(%nbrefullday)) {
#$tmp = $site;
#$tmp =~ s/http:\/\///;
#print FOUT "<TR>\n<TD><A HREF=\"$site\">$tmp</A></TD>\n<TD ALIGN=CENTER><B>$nbrefullday{$site}</B> $L{'times'}</TD>\n</TR>\n" if ($nbrefullday{$site} != 0);
##    $nbrefullday{$site} = 0;    


 print FOUT "</TABLE>\n\n";


###

if ($type_serveur != 2) {
 print FOUT "<P><HR><P>\n\n";

 print FOUT "$L{'The_Top'} $topten $L{'server_pages1'} ($L{'among'} $uniqueurlday)<p>\n";
# print FOUT "$L{'The_Top'} $uniqueurlday $L{'server_pages1'}<p>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR><TH>$L{'Server_pages2'}</TH><TH>$L{'Occurence'}</TH></TR>\n";

$tmp = 0;
$i = 0;
while ($tmp < $topten && $bestoccurday[$i] ne '') {

for ($j=1;$j<= $countoccur[$bestoccurday[$i]];$j++) {
$tmp++;
last if ($tmp > $topten);
$site = $occur_counteroccur{$bestoccurday[$i],$j};
if ($bestoccurday[$i] != 0) {
print FOUT "<TR>\n<TD><A HREF=\"http://$localserver$site\">";
print FOUT "$site" if ($titlename == 0 || $urlconv{$site} eq '');
print FOUT "<b>$urlconv{$site}</b>" if ($titlename == 1 && $urlconv{$site} ne '');
print FOUT "</A></TD>\n<TD ALIGN=CENTER><B>$bestoccurday[$i]</B> $L{'times'}</TD>\n</TR>\n";
}
}
$i += $countoccur[$bestoccurday[$i]];

}

#$occurday{$site}

#for ($i=0;$i < $topten;$i++) {
##for ($i=0;$i < $uniqueurlday;$i++) {
#    $site = $bestoccurday[$i];
##foreach $site (keys(%occurday)) {

#if ($occurday{$site} != 0) {
#print FOUT "<TR>\n<TD><A HREF=\"http://$localserver$besturl[$i]\">";
#print FOUT "$site" if ($titlename == 0 || $urlconv{$besturl[$i]} eq '');
#print FOUT "<b>$urlconv{$site}</b>" if ($titlename == 1 && $urlconv{$besturl[$i]} ne '');
#print FOUT "</A></TD>\n<TD ALIGN=CENTER><B>$occurday{$site}</B> $L{'times'}</TD>\n</TR>\n";
##    $occurday{$site} = 0;
#}
#}

 print FOUT "</TABLE>\n\n";
}


#  @tmpword = @wordsday;

 print FOUT "<P><HR><P>\n\n";

print FOUT "$L{'The_Top'} $topten $L{'engine_keywords_used'} ($L{'among'} ",($#wordsday+1),")<p>\n";
#print FOUT "$L{'The_Top'} ",($#wordsday+1)," $L{'engine_keywords_used'}<p>\n";
print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
print FOUT "<TR><TH>$L{'Keywords'}</TH><TH>$L{'Occurence'}</TH></TR>\n";

#		$bestwordsday[$i] = $wordsday[$j];
#		$occurwordsday[$i] = $wday{$wordsday[$j]};

for ($i=0;$i<$topten;$i++) {
#for ($i=0;$i <=$#wordsday;$i++) {

#for ($i=0;$i<=$#wordsday;$i++) {
#   $site = shift(@tmpword);

$site = $bestwordsday[$i];
$site =~ s/\"//g; 
#if ($wday{$site} != 0) {
if ($occurwordsday[$i] != 0) {
#print FOUT "<TR><TD>$site</TD><TD ALIGN=CENTER><B>$wday{$site}</B> $L{'times'}</TD></TR>\n";
print FOUT "<TR><TD>$site</TD><TD ALIGN=CENTER><B>$occurwordsday[$i]</B> $L{'times'}</TD></TR>\n";
}
}
print FOUT "</TABLE>\n";

#print FOUT "<P><HR><P>\n\n";

 print FOUT "</BODY></HTML>\n";
 }

#########################################################################

sub TableReferHeader { 
 local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Referer'} - $L{'Tab_about_lastdays1'} $nbdays $L{'Tab_about_lastdays2'} ($L{'Textual_version'})</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-refer.pl $version - $today $hourdate -->\n";	 
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1> $L{'Tab_about_lastdays1'} $nbdays $L{'Tab_about_lastdays2'}</H1><P>\n";
 print FOUT "<P><HR><P>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR>\n";
 print FOUT "<TH>$L{'Date'}</TH>\n";
 print FOUT "<TH BGCOLOR=\"#FFFF00\">$L{'Hosts'}</TH>\n";
 print FOUT "<TH BGCOLOR=\"#00FFFF\">$L{'referer_pages1'}</TH>\n";
 print FOUT "<TH>$L{'server_pages1'}</TH>\n";
 print FOUT "<TH>$L{'engine_keywords_used'}</TH>\n";
 print FOUT "</TR>\n";
}

#########################################################################

sub TableReferDays { 
 local(*FOUT,*L) = @_;
 $line = 0;
 $inc = 0;
 $count_day = 1;
 $count_week = 1;
 $m_total = 0;
 $req_total = 0;
 $access_total = 0;

 open(INFILE, "$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";

 while (<INFILE>) {
     $line++;
     next unless ($line > 3);

     $count++;
     $oldjour = $jour;
     $oldmonth = $month;

    ($jour,$month,$year,$uniqueday,$uniquenbrefullday,$uniqueurlday,$words) = split('\s+');

     $words = 0 if ($words < 0);

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

                print FOUT "<TR><TD ALIGN=CENTER BGCOLOR=\"#E0E0E0\"><A NAME=\"$count_day\">$day</td>\n";
                print FOUT "<TD ALIGN=CENTER>0</TD><TD ALIGN=CENTER>0</TD><TD ALIGN=CENTER>0</TD><TD ALIGN=CENTER>0</TD></TR>\n";
        
                if ($inc == 7) {
                        print FOUT "<TR><TD></TD><TD ALIGN=CENTER>";
                        print FOUT "-" x (2 + length($m_total));
                        print FOUT "</TD><TD ALIGN=CENTER>";
                        print FOUT "-" x (2 + length($req_total));
                        print FOUT "</TD><TD ALIGN=CENTER>";
                        print FOUT "-" x (2 + length($access_total));
                        print FOUT "</TD></TR>\n";
                        print FOUT "<TR><TD></TD>\n";
                        print FOUT "<TD BGCOLOR=\"#FFFF00\" ALIGN=CENTER><B>$m_total</B></TD>\n";
                        print FOUT "\n";
                        print FOUT "<TD BGCOLOR=\"#00FFFF\" ALIGN=CENTER><B>$req_total</B></TD>\n";
                        print FOUT "<TD ALIGN=CENTER><B>$access_total</B></TD>\n";
                        print FOUT "<TD></TD></TR>\n";
                        print FOUT "<TR><TD COLSPAN=5>&nbsp;</TD></TR>\n";

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

     $access_total += $uniqueurlday;
     $m_total += $uniqueday;
     $req_total += $uniquenbrefullday;

     $day = $jour." ".$month." ".$year;

    $linkjour = "..".$dirsepurl.$dirdate.$dirsepurl.$year."-".$month."-".$jour.$dirsepurl.$refer;

      $fulljour = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$year."-".$month."-".$jour.$dirsep.$refer;

     if (-e $fulljour){
         $writeday = '<A HREF="'.$linkjour.'">'.$day;
         $writeday .= "</A>";
     } else {
        $writeday = $day;
        }
       #
    
    $previousday = $day;

#

        print FOUT "<TR><TD ALIGN=CENTER BGCOLOR=\"#E0E0E0\"><A NAME=\"$count_day\">$writeday</TD><TD ALIGN=CENTER>$uniqueday</TD><TD ALIGN=CENTER>$uniquenbrefullday</TD><TD ALIGN=CENTER>$uniqueurlday</TD><TD ALIGN=CENTER>$words</TD></TR>\n";

        
        if ($inc == 7) {

            print FOUT "<TR><TD></TD><TD ALIGN=CENTER>";
            print FOUT "-" x (2 + length($m_total));
            print FOUT "</TD><TD ALIGN=CENTER>";
        print FOUT "-" x (2 + length($req_total));
            print FOUT "</TD><TD ALIGN=CENTER>";
        print FOUT "-" x (2 + length($access_total));
            print FOUT "</TD></TR>\n";
            print FOUT "<TR><TD></TD>\n";
        print FOUT "<TD BGCOLOR=\"#FFFF00\" ALIGN=CENTER><B>$m_total</B></TD>\n";
                print FOUT "\n";
                print FOUT "<TD BGCOLOR=\"#00FFFF\" ALIGN=CENTER><B>$req_total</B></TD>\n";
                print FOUT "<TD ALIGN=CENTER><B>$access_total</B></TD>\n";
                print FOUT "</TR>\n";

                print FOUT "<TR><TD COLSPAN=5>&nbsp;</TD></TR>\n";

        $m_total = 0;
        $req_total = 0;
        $access_total = 0;
        $inc -= 7;
        }
        
     $count_day++;
     
}

 $count_day--;
 close(INFILE);

}

#########################################################################

sub Keyword {
  local(*FOUT,*L) = @_;
  local($tmp);

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Search_engine'} $L{'on'} $localserver</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-refer.pl $version - $today $hourdate -->\n";
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1>$L{'Search_engine'} $L{'on'} $localserver</H1>\n<P>\n";

 print FOUT "<HR size=5>\n";
 print FOUT "<CENTER><B>$firstday - $jourfin</B></CENTER>\n\n";
 print FOUT "<HR SIZE=5><P>\n\n";
 
print FOUT "$L{'The_Top'} $bouclewords $L{'engine_keywords_used'}<p>\n";
print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
print FOUT "<TR><TH>$L{'Keywords'}</TH><TH>$L{'Occurence'}</TH></TR>\n";
for ($i=0;$i<$bouclewords;$i++) {
print FOUT "<TR><TD>$bestwords[$i]</TD><TD ALIGN=CENTER><B>$occurwords[$i]</B> $L{'times'}</TD></TR>\n";
}
print FOUT "</TABLE>\n";

print FOUT "<P><HR><P>\n\n";

print FOUT "$L{'The_Top'} $bouclerobot $L{'search_engine'}<p>\n";
print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
print FOUT "<TR><TH>$L{'Search_engine'}</TH><TH>$L{'String'}</TH><TH>$L{'Occurence'}</TH></TR>\n";
for ($i=0;$i<$bouclerobot;$i++) {

print FOUT "<TR><TH BGCOLOR=\"#D0D0D0\">$bestrobot[$i]</TH>\n<TD BGCOLOR=\"#D0D0D0\">";

for ($j=1;$j<=$grnbtot{$bestrobot[$i]};$j++) {

print FOUT "<I>$grtot{$bestrobot[$i],$j} : $keysh{$grtot{$bestrobot[$i],$j}}</I><BR>";
}
print FOUT "</TD>\n<TD ALIGN=CENTER BGCOLOR=\"#E0E0E0\"><B>$occurrobot[$i]</B> $L{'times'}</TD></TR>\n";

#$tmp = $topten if ($occurrobot[$i] > $topten);
#$tmp = $occurrobot[$i] if ($occurrobot[$i] <= $topten);

#for ($j=1;$j<=$occurrobot[$i];$j++) {

#for ($k=1;$k <= $tmp;$k++) {
#$maxi = 0;
#for ($j=0;$j<=$occurrobot[$i];$j++) {
#    $tmp2 = $full{$bestrobot[$i],$pagerobot{$bestrobot[$i],$j}};
#    if ($tmp2 > $maxi) {
#         $maxi = $tmp2;
#	 $aa = $k;
#	 $pagerobot2{$bestrobot[$i],$k} = $pagerobot{$bestrobot[$i],$j};
#         $full2{$bestrobot[$i],$pagerobot2{$bestrobot[$i],$k}} = $tmp2;
#         }
#    }
#$full{$bestrobot[$i],$pagerobot2{$bestrobot[$i],$aa}} = 0;
#}

#for ($k=1;$k<=$tmp;$k++) {
#print "$k - $pagerobot2{$bestrobot[$i],$k} - $full2{$bestrobot[$i],$pagerobot2{$bestrobot[$i],$k}}\n";
#}

for ($j=1;$j<=$tmpbou[$i];$j++) {
print FOUT "<TR><TD>&nbsp;</TD><TD>$pagerobot2{$bestrobot[$i],$j}</TD><TD ALIGN=CENTER>$full2{$bestrobot[$i],$pagerobot2{$bestrobot[$i],$j}} $L{'times'}</TD></TR>\n" if ($pagerobot2{$bestrobot[$i],$j} ne '' && $full2{$bestrobot[$i],$pagerobot2{$bestrobot[$i],$j}} > 1);
}

#for ($j=1;$j<=$tmp;$j++) {
#print FOUT "<TR><TD>&nbsp;</TD><TD>$pagerobot{$bestrobot[$i],$j}</TD><TD ALIGN=CENTER>$full{$bestrobot[$i],$pagerobot{$bestrobot[$i],$j}} $L{'times'}</TD></TR>\n" if ($pagerobot{$bestrobot[$i],$j} ne '' && $full{$bestrobot[$i],$pagerobot{$bestrobot[$i],$j}} > 1);
#}

}
print FOUT "</TABLE>\n";

 print FOUT "</BODY></HTML>\n";
}

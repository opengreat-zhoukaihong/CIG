#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                    BROWSERS STATS                              #####
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

$fileagentday = $path.$dirinc.$dirsep."agentday";
#$datafile = "time-agent";

$starttime = time();
print "Agent stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

# debut de l'initialisation

$i = 0;
$count_day = 0;
$initday = 0;
$scan = 1;
$jour_of_year = 1;
$pastjour_of_year = 0;
$sizeold = 0;
$addit = 0;

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

%translate_agent = ('Mozilla','Netscape',
		    'MSIE','Microsoft Internet Explorer',
		    'Microsoft Internet Explorer','Microsoft Internet Explorer');		    

@agent = ('Mozilla','MSIE','Microsoft Internet Explorer');
	
%translate_os = ('Win98','Windows 98',
		 'Windows 98','Windows 98',
		 'Win95','Windows 95',
		 'Windows 95','Windows 95',
		 'Win32','Windows 95',		 
		 'Win16','Windows 3.1',
		 'Windows 16','Windows 3.1',
		 'Windows 3.1','Windows 3.1',		 
		 'WinNT','Windows NT',
		 'Windows NT','Windows NT',
		 'Windows NT 5.0','Windows NT',
		 'Windows NT 4.0','Windows NT',
		 'Mac_PPC','Macintosh',
		 'Mac_PowerPC','Macintosh');
		 
@os = ('Win98','Windows 98','Win95','Windows 95','Win32','Win16','Windows 16','Windows 3.1','WinNT','Windows NT','Windows NT 5.0','Windows NT 4.0','Mac_PPC','Mac_PowerPC');
	    
#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -a                    : show all browser\n";
      print STDOUT "        -b                    : don't run incremental mode\n";
      print STDOUT "        -c <file>             : load configuration file\n";
      print STDOUT "        -d <nbdays>           : number of days to scan (Extended NCSA logifle only)\n"; 
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
      print STDOUT "        -i <file>             : input logfile\n";
      print STDOUT "        -f                    : scan only HTML files (Extended NCSA logfile only)\n"; 
      print STDOUT "        -t <toplist>          : display only toplist browsers\n";
      print STDOUT "        -x                    : show default value for flag options\n";
      print STDOUT "        -v                    : version\n";
      print STDOUT "        -z                    : zip logfiles\n";        
      print STDOUT "\n";
      exit;
}


if ($opt_v == 1) {
      print STDOUT "cron-agent.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -a            : ";
      &id($opt_a);
      print STDOUT "          -b            : ";
      &id($opt_b);
      print STDOUT "          -c            : $configfile\n";
      print STDOUT "          -d <nbdays>   : $nbdays\n"; 
      print STDOUT "          -g <graphic>  : $graphic[0]\n";
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";
      print STDOUT "          -i <file>     : $fileagent\n";
      print STDOUT "          -f            : No\n";
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

if ($opt_i ne '') {
    $zip = 0;
$fileagent = $opt_i;
}

if ($opt_t ne '') {
$topten = $opt_t;
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


# switch

if ($opt_g ne '') {
  print STDERR "Only extended NSCA logfile !!!\nThis switch \".$opt_g.\" has no effect.\n" if ($file ne $fileagent);
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

if ($opt_f == 1) {
print STDERR "Only extended NSCA logfile !!!\nThis switch \"-f\" has no effect.\n" if ($file ne $fileagent);
}

###################################################################

if ($zipcut == 0) {
die "Agentlog file $fileagent not found\nAre you sure your server produce one ?\n" unless (-f $fileagent);
}
$nbline = 0;

$agentgraph = $path.$dirgraph.$dirsep."agent".$gifext;
$agentgraphx = $path.$dirgraph.$dirsep."agentx".$gifext;
$agentgraphy = $path.$dirgraph.$dirsep."agenty".$gifext;

$linkagentgraph = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."agent".$gifext;
$linkagentgraphx = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."agentx".$gifext;
$linkagentgraphy = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."agenty".$gifext;

$others = "others".$gifext;

$tmp = $path;
chop($tmp);
mkdir ($tmp,0775) unless -d $tmp;

$dir = $path.$dirinc;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirgraph;
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
#    push(@tmp,"$dir$dirsep$filenames[$i]") if ($filenames[$i] eq $tabnamebrowser);
#}
#if (-d "$dir$dirsep$filenames[$i]" && $filenames[$i] ne '.' && $filenames[$i] ne '..') {
#    push(@tmpdir,"$dir$dirsep$filenames[$i]");
#    chdir "$dir$dirsep$filenames[$i]";
#    &dodirdel("$dir$dirsep$filenames[$i]");
#    chdir '..';
#    }
#}
#}

#################################################################
####                   date de ce jour                    #######
#################################################################

if ($file eq $fileagent || $type_serveur == 2) {

### today date

#$datesyst = &ctime(time);
#($dayletter,$month,$day,$hourdate,$a,$year) = split(/\s+/,$datesyst);
#$year = $a if ($year eq '');
#$day = "0".$day if (length($day) == 1);
#($hour,$minute,$second) = split(/:/,$hourdate);
#$today = $day." ".$month." ".$year;

$month_number = $month_equiv{$month};
$month_number--;

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

$addit = 365 if ($pastjour_of_year > $jour_of_year_end || $pastyear != $year);
$jour_of_year_end +=365 if ($pastjour_of_year > $jour_of_year_end || $pastyear != $year);

$jour_of_year_end++ if ($pastjour_of_year > $jour_of_year_end || $pastyear != $year && $pastbisextil == 1);

#print "Aujourd'hui nous sommes le $today ($jour_of_year_end)\n";
#print "il y a $nbdays jours , nous etions le $pasttoday ($pastjour_of_year)\n";
}

$pastjour_of_year -=365 if ($pastjour_of_year > $jour_of_year_end);

($size)= (stat("$fileagent")) [7];
#$prefixlog = $agentlog if ($file ne $fileagent);

if ($opt_d ne '') {
$oldjour = $pasttoday;
}

#############################################################################

&load_reverse_dns if ($reverse_dns == 1); # chargement de la table de DNS

#################################################################
#######        chargement des anciennes valeurs      ############
#################################################################

$opt_b = 1 if (!(-f "$path$dirinc$dirsep$incbrowser"));

if ($opt_b != 1 && $opt_d eq '') {

if (-f "$path$dirinc$dirsep$incbrowser") {

open(OUT,"$path$dirinc$dirsep$incbrowser") || die "Error, unable to open $path$dirinc$dirsep$incbrowser\n";
$a = (<OUT>);
($nbline,$sizeold,$firstday,$oldjour) = split(/\t/,$a);
chop($oldjour);
while (<OUT>) {
($browser,$nb) = split(/\t/);
chop($nb);
$nbre{$browser} = $nb;
$unique++;
$browser[$unique] = $browser;
}
close(OUT);    

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
$jour_of_year -=365 if ($jour_of_year > $jour_of_year_end);
$jour_of_year_first = $jour_of_year; 

open(OUT,"$path$dirinc$dirsep$incos") || die "Error, unable to open $path$dirinc$dirsep$incos\n";
$count = (<OUT>);
chop($count);
while (<OUT>) {
($os,$nb) = split(/\t/);
chop($nb);
$nbreos{$os} = $nb;
$uniqueos++;
}
close(OUT);    


open(OUT,"$path$dirinc$dirsep$dayagent") || die "Error, unable to open $path$dirinc$dirsep$dayagent\n";
while (<OUT>) {
(@uni) = split;
for ($i=0;$i<=$#uni;$i++) {
$evolbrowser{$count_day,$i+1} = $uni[$i];
}
$count_day++;
}
close (OUT);
$count_day--;
for ($i=1;$i<=$unique;$i++) {
    $nbreday{$browser[$i]} = $evolbrowser{$count_day,$i};
}

}
}

# load inc day data

if (-f $fileagentday && $opt_d eq '' && $opt_b != 1 && $agentlog eq $prefixlog) {
print "Loading daily incremental data : $fileagentday\n";

open(FILEDAYAGENT,"$fileagentday") || die "Error, unable to open $fileagentday\n";

$oldjour = <FILEDAYAGENT>;
chop($oldjour);

#if ($today eq $checkdate) {

while (<FILEDAYAGENT>) {

($tmp,$tmp1,$tmp2) = split;
chop($tmp2);

if ($tmp eq "A") {
$nbrebrowserday{$tmp1} = $tmp2;
$uniqueday++;
}

if ($tmp eq "B") {
$nbreosday{$tmp1} = $tmp2;
$uniqueosday++;
}

if ($tmp eq "C") {
    chop($tmp1);
    $nb++;
    $browserday[$nb] = $tmp1; 
}

#}
}
close (FILEDAYAGENT);
}

#################################################################
###                     gzip log file                         ###
#################################################################

#$yeartmp = $year;

if (($zip == 1 || $zipcut != 0) && (($opt_b == 1) || ($nbline == 0))) {

$month = $monthindex;
$monthprev = $month-1;
$yyear = $year;
$year = $fyear;

   # detection du premier mois de log zipe


#     do {
while ($out == 0) {
#while (!(-e $filezip) || !(-e $fileagent)) {
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
       $fileagent = $fileroot;
       $smallyear = $year - int($year/100)*100;
       $smallyear = "0".$smallyear if (length($smallyear) == 1);
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$fileagent .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}
       $out = 1 if (-e $fileagent && $zip == 0);
       $filezip = $fileagent.$zipext if ($zip == 1);
	$out = 1 if (-e $filezip && $zip == 1);
     }
#        until (-e $filezip || -e $fileagent);

   $lastfile = $fileagent;
   $lastfilezip = $filezip;
   $stop = 0;
   $fyear = $year;
   $year = $yyear;
}

# nbre de jour il y a $nbdays days ($opt_d)

if ($opt_d ne '') {

$monthindex2 = $monthindex;
$monthindex2--;

$pastday = $day  - $opt_d; 
$pastyear = $fullyear;
$pastmonth = $month_nb[$monthindex2];

while ($pastday < 1) {
  $monthindex2--;
  if ($monthindex2 < 0) {
      $pastyear--;
      $monthindex2 = 11;
   }
   $pastmonth = $month_nb[$monthindex2];
   $pastday = $pastday + $month_of_year{$pastmonth};
}

$pasttoday = $pastday." ".$pastmonth." ".$pastyear;  

$pastmonthnb = $month_equiv{$pastmonth};
$pastmonthnb = "0".$pastmonthnb if (length($pastmonthnb) == 1);

}

#################################################################
#####               computing agent stats                  ######
#################################################################


#if ($prefixlog eq $agentlog) {
#print STDOUT "NCSA ";
#} else {
#print STDOUT "CERN or Netscape ";
#}

if ($zipcut != 0 && ($opt_b != 1 || $opt_d ne '')) {
    ($day,$month2,$year) = split(/ /,$oldjour);
$day = "0".$day unless (length($day) == 2);
$month = $month_equiv{$month2};
$month = "0".$month unless (length($month) == 2);
$lettermonth = $month_nb[$month-1];    
$out = 0 if (!(-f $fileagent));
while ($out == 0 && ($year <=  $fullyear && $month <= $monthindex)) {

    $fyear = $year;
        $smallyear = $year - int($year/100)*100;
        $smallyear = "0".$smallyear if (length($smallyear) == 1);

        $fileagent = $fileroot;

     	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$fileagent .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	        }
	$filezip = $fileagent.$zipext if ((!(-f $fileagent)) && $zip == 1);
$out = 1 if (-f $fileagent || -f $filezip);
        if (!(-f $filezip) && !(-f $fileagent)) {
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

$fileagent = $fileroot.$prefixlog if (!(-f $filezip) && !(-f $fileagent));


if ($size < $sizeold) {
$nbline = 0;
print STDERR "Your logfile $fileagent have been cut\n";
}

while ($stop == 0) {

print STDOUT "Scanning ";

if (($zip == 1) && (-f $filezip) && ((($fileagent ne $filezip) && ($nbline == 0 || $opt_b == 0)) || ($zipcut == 2))) {
#if (($zip == 1) && ((($fileagent ne $filezip) || ($nbline == 0)) || ($zipcut == 2))) {
       print STDOUT "$filezip file...\n";
       open(INFILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
    } else {
           print STDOUT "$fileagent file...\n";
           open(INFILE,$fileagent) || die "Error, unable to open $fileagent\n";
      }
      

print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$line = 0;

BOUCLE :
while (<INFILE>) {

$line++;
next BOUCLE if (-f "$path$dirinc$dirsep$incbrowser" && $line <= $nbline);

if ($prefixlog eq $agentlog) {

 $_ =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

 @line_log = split(/$logfile_sep/);
 chop($line_log[$#line_log]);
 next if ($line_log[0] =~ /^#/);
     
 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

    $adresse = $line_log[$fields_logfile{'%host'}];
    $page = $line_log[$fields_logfile{'%page'}];
    $d = $line_log[$fields_logfile{'%method'}];
    $query = $line_log[$fields_logfile{'%query'}] if ($fields_logfile{'%query'} ne '');     
    $status = $line_log[$fields_logfile{'%status'}];
    $requetesize = $line_log[$fields_logfile{'%requetesize'}];
    $vserver = $line_log[$fields_logfile{'%virtualhost'}] if ($fields_logfile{'%virtualhost'} ne '');
    $vserver = $line_log[$#line_log] if ($#logfile_fields == $fields_logfile{'%virtualhost'});
    $vserver = $1 if ($page =~ /^\/\/([-.0-9a-z]+)\//i && $virtualCLF != 0);
    $page =~ s/\/\/$virtualfilter// if (($virtualCLF != 0 && $virtualfilter ne '') || ($d =~ /$localserver/));

    next if ($status !~ /^(\d+)$/);
    next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
    next if ($page =~ /"$/ && $iis_format != 1); # all format should be %page %protocol
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

    $i = $fields_logfile{'%agent'};
    $f = $line_log[$i];
    $f3 = '';

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

    if ($type_serveur == 0 && $f3 eq '') {    
    while ((rindex($f,'"')+1) != length($f) && ($f !~ /\n/)) {
    $i++;
    $line_log[$i] = "[".$line_log[$i] if ($line_log[$i] =~ /\]/);
    $f .= " ".$line_log[$i];
    $tt = rindex($f,'"')+1;
    $tt1 = length($f);
#    print "$i - $tt - $tt1 - $f\n";
    print STDERR "$_ \n" if ($i > 80);
    print STDERR "\n\nAbort.....logfile format unknown !\n" if ($i > 80);
    exit if ($i > 80);         
    }

    }

    $f =~ s/\+/ /g if ($type_serveur == 1);
    $f =~ s/^A://;
    
    next if ($f eq '');



    chop($f);
    ($browser,$agent) = split(/ \(/,$f);

    $status = $1 if ($query =~ /(\d\d\d);http:\/\// && $type_serveur == 1);

    next if (($status >= 400) && ($status < 599));
    
    $page =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
    $page =~ tr/[A-Z]/[a-z]/ if ($type_serveur == 1);    
    $page = $page."?".$query if ($query ne '' && $query ne '-,');
    
    next if ($page !~ m#$tri#); # stats sur une partie du serveur
    next if ($d =~ /$localserver/ && $vserver ne '');
    next if ($vserver =~ /$excludevirtual/i && $excludevirtual ne '');    
    next if ($vserver !~ /$virtualfilter/i && $virtualfilter ne '' && $vserver ne '');
    next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
    next if ($page =~ /$excluderepert/i && $excluderepert ne '');
    next if ($page !~ /\.(s)?htm(l)?/i && $opt_f == 1);

    next if ($requetesize == 0) ; #ote les pages ne contenant rien
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


    if ($firstday eq '') {
       ($firstday) = $date =~ m/^((\d+)\/(\w+)\/(\d+))(.*)/;
        $firstday =~ s/[\/]/ /g;

       ($pastday,$pastmonth,$pastyear2) = split(/ /,$firstday);

       $jour_of_year = 0;
       $countmonth = 0;
       $month_end = $month_nb[$countmonth];

       while ($month_end ne $pastmonth) {
          $jour_of_year += $month_of_year{$month_end};
          $countmonth++;
          $month_end = $month_nb[$countmonth];
       }

       $jour_of_year += $pastday;
       $jour_of_year -=365 if ($jour_of_year > $jour_of_year_end);
       $jour_of_year_first = $jour_of_year; 
       $jour_of_year +=365 if ($pastyear < $pastyear2);
       $oldjour = $firstday;
    }

    ($jour) = split(/:/,$date);
    $jour =~ s/[\/]/ /g;


    next if ($browser eq '');
    next if ($agent =~ /http/);

    if ($agent ne '') {
    $agent =~ s/\)\"//g;
    ($os) = split(/[;(]+/,$agent);    
    } else {
    $os = $agent;
    }

    # explorer browser hiding in mozilla !
    if ($agent =~ /compatible/i) {
    	($a,$browser,@tmp) = split(/; /,$agent);    	
	$os = $tmp[$#tmp];
	$os = $tmp[$#tmp-1] if ($os =~ /DigExt/i); # patch
	$os = "" if ($agent !~ /; /);
	$browser = $a if ($agent !~ /; /);	
    	$os =~ s/\)(.*)/\)/;
    }

    if ($browser eq '') {
       print STDERR "$fileagent is not a extented common log file !!!\n";
       exit;
       }


     if ($jour ne $oldjour) {

       $yday = &nbdayan($jour);
       $ydayold = &nbdayan($oldjour);
       $diff = $yday - $ydayold;
       $diff += $ydayold if ($diff < 0);
       $diff++ if ($yday == 0);
	
       $jour_of_year += $diff;

#       $jour_of_year++;
#       print STDERR "$jour_of_year - $pastjour_of_year\n";
       
       if ($jour_of_year < $pastjour_of_year && $opt_b eq '') {
       $oldjour = $jour;
       $scan = 0;
       next BOUCLE;
       }

       ($var1,$var2) = split(' ',$jour);
       ($oldvar1,$oldvar2) = split(' ',$oldjour);

       next BOUCLE if (($var2 eq $oldvar2) && ($var1 < $oldvar1));
       next BOUCLE if (($var2 ne $oldvar2) && ($var1 > $oldvar1));

       ###


$unique_new_browserday = 0;

for ($l=1;$l<=$uniqueday;$l++) {

	for ($j=0;$j<=$#agent;$j++) {
		if ($browserday[$l] =~ /$agent[$j]/) {
			$tmp = $agent[$j];
			$tmp1 = $translate_agent{$tmp};
			$bro_ver = $browserday[$l];
			$bro_ver =~ /(\d)+/;
			$bro_ver = int($1);
			$new_browserday{$tmp1} += $nbreday{$browserday[$l]};
			$browser_versionday{$tmp1,$bro_ver} += $nbreday{$browserday[$l]};
			$browser_version_nbday{$tmp1} = $bro_ver if ($bro_ver > $browser_version_nbday{$tmp1});
			$browserday[$l] = '';
			$unique_new_browserday++ if (!($seen{$tmp1}++));
		}
	}
	$new_browserday{$browserday[$l]} += $nbreday{$browserday[$l]} if ($browserday[$l] ne '');
	$unique_new_browserday++ if ($browserday[$l] ne '');
}

#

# tri des $topten browser les plus frequents

for ($i=0;$i<$unique_new_browserday;$i++) {
$maxi = 0;
foreach $browser (keys(%new_browserday)) {
    if ($new_browserday{$browser} > $maxi) {
         $maxi = $new_browserday{$browser};
         $bestbrowserday[$i] = $browser;
         $occurbrowserday[$i] = $new_browserday{$browser};                 
         }
    }
$new_browserday{$bestbrowserday[$i]} = 0;
}

#

for ($i=0;$i<$unique_new_browser;$i++) {
for ($j=0;$j<=$#agent;$j++) {
if ($bestbrowserday[$i] =~ /$agent[$j]/) {
$tmp = $agent[$j];
$tmp1 = $translate_agent{$tmp};
}
}
$bestbrowserday[$i] =~ s/$tmp/$tmp1/ if ($tmp1 ne '');
}

#

$unique_new_osday = $uniqueosday;
foreach $osday (keys(%nbreosday)) {
	$ok = 0;
	for ($j=0;$j<=$#os;$j++) {
		if ($osday eq $os[$j]) {
			$tmp = $os[$j];
			$tmp1 = $translate_os{$tmp};
			$new_osday{$tmp1} += $nbreosday{$tmp} if ($ok == 0);
			$ok = 1;
			$unique_new_osday-- if ($seen{"$tmp1 $oldjour"}++);
		}
	}
	$new_osday{$osday} = $nbreosday{$osday} if ($ok != 1);
}



for ($i=0;$i<$unique_new_osday;$i++) {
$maxi = 0;
foreach $os (keys(%new_osday)) {
    if ($new_osday{$os} > $maxi) {
         $maxi = $new_osday{$os};
         $bestosday[$i] = $os;
         $occurosday[$i] = $new_osday{$os};                 
         }
    }
$new_osday{$bestosday[$i]} = 0;
}

       ###

	($tmp1,$tmp2,$tmp3) = split(/ /,$oldjour);
	$dirresume = $tmp3."-".$tmp2."-".$tmp1;

	for ($nblang=0;$nblang<=$#lang;$nblang++) {

	$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
	mkdir ($tmp,0775) unless -d $tmp;

	open(FILEDAYAGENT,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$tabnamebrowser") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$tabnamebrowser\n";

	&AgentDay(*FILEDAYAGENT, eval($Lang{$lang[$nblang]}));

	close (FILEDAYAGENT);
	}

       for ($i=1;$i<=$unique;$i++) {
           $evolbrowser{$count_day,$i} = $nbreday{$browser[$i]};
           }

           undef %nbreday;

       ###

for ($i=0;$i<=$unique_new_browserday;$i++) {
for ($l=$browser_version_nbday{$bestbrowserday[$i]};$l>0;$l--) {
$browser_versionday{$bestbrowserday[$i],$l} = '';
}
}

undef %new_browserday;
undef %nbrebrowserday;
undef %nbreosday;
undef %browser_version_nbday;
undef %browser_versionday;
undef $bestbrowserday;
undef $occurbrowserday;

$unique_new_browserday = 0;

	$countday = 0;
	$uniqueday = 0;
	$uniqueosday = 0;
	$unique_new_osday = 0;	
       $scan = 1;
       $count_day += $diff;
       $oldjour = $jour;
       }

   } else {

   ($date,$f) = split(/"/) if ($type_serveur == 2);
   $f = $_ if ($type_serveur != 2);
   chop($f);
   ($browser,$agent) = split(/ \(/,$f);

#   ($browser,$os,$nets) = split(/[ \t\n]+/,$agent);
#   ($browser,$langue,$os) = split(/[ \t\n(]+/,$agent);
#   $browser = $langue if ($nets =~ /^[(]/);

    if ($agent ne '') {
    $agent =~ s/\)\"//g;
    ($os) = split(/[;(]+/,$agent);    
    } else {
    $os = $agent;
    }
    
    # explorer browser hiding in mozilla !
    if ($agent =~ /compatible/i) {
    	($a,$browser,@tmp) = split(/; /,$agent);    	
	$os = $tmp[$#tmp];
	$os = "" if ($agent !~ /; /);
	$browser = $a if ($agent !~ /; /);	
    	$os =~ s/\)(.*)/\)/;
    }
   
	if ($type_serveur == 2) {
	   $date =~ s/\[//;
   	    if ($firstday eq '') {
	       	($firstday) = $date =~ m/^((\d+)\/(\w+)\/(\d+))(.*)/;
	        $firstday =~ s/[\/]/ /g;

	       ($pastday,$pastmonth,$pastyear2) = split(/ /,$firstday);

	       $jour_of_year = 0;
	       $countmonth = 0;
	       $month_end = $month_nb[$countmonth];

	       while ($month_end ne $pastmonth) {
	          $jour_of_year += $month_of_year{$month_end};
	          $countmonth++;
	          $month_end = $month_nb[$countmonth];
	       }

	       $jour_of_year += $pastday;
	       $jour_of_year -=365 if ($jour_of_year > $jour_of_year_end);
	       $jour_of_year_first = $jour_of_year; 
	       $jour_of_year +=365 if ($pastyear < $pastyear2);
	       $oldjour = $firstday;
	    }

	    ($jour) = split(/:/,$date);
	    $jour =~ s/[\/]/ /g;
	    
     if ($jour ne $oldjour) {
       $yday = &nbdayan($jour);
       $ydayold = &nbdayan($oldjour);
       $diff = $yday - $ydayold;
       $diff += $ydayold if ($diff < 0);
       $diff++ if ($yday == 0);
	
       $jour_of_year += $diff;

       if ($jour_of_year < $pastjour_of_year && $opt_b eq '') {
       $oldjour = $jour;
       $scan = 0;
       next BOUCLE;
       }

       ($var1,$var2) = split(' ',$jour);
       ($oldvar1,$oldvar2) = split(' ',$oldjour);

       next BOUCLE if (($var2 eq $oldvar2) && ($var1 < $oldvar1));
       next BOUCLE if (($var2 ne $oldvar2) && ($var1 > $oldvar1));

       ###

       ###

$unique_new_browserday = 0;

for ($l=1;$l<=$uniqueday;$l++) {

	for ($j=0;$j<=$#agent;$j++) {
		if ($browserday[$l] =~ /$agent[$j]/) {
			$tmp = $agent[$j];
			$tmp1 = $translate_agent{$tmp};
			$bro_ver = $browserday[$l];
			$bro_ver =~ /(\d)+/;
			$bro_ver = int($1);
			$new_browserday{$tmp1} += $nbreday{$browserday[$l]};
			$browser_versionday{$tmp1,$bro_ver} += $nbreday{$browserday[$l]};
			$browser_version_nbday{$tmp1} = $bro_ver if ($bro_ver > $browser_version_nbday{$tmp1});
			$browserday[$l] = '';
			$unique_new_browserday++ if (!($seen{$tmp1}++));
		}
	}
	$new_browserday{$browserday[$l]} += $nbreday{$browserday[$l]} if ($browserday[$l] ne '');
	$unique_new_browserday++ if ($browserday[$l] ne '');
}

#

# tri des $topten browser les plus frequents

for ($i=0;$i<$unique_new_browserday;$i++) {
$maxi = 0;
foreach $browser (keys(%new_browserday)) {
    if ($new_browserday{$browser} > $maxi) {
         $maxi = $new_browserday{$browser};
         $bestbrowserday[$i] = $browser;
         $occurbrowserday[$i] = $new_browserday{$browser};                 
         }
    }
$new_browserday{$bestbrowserday[$i]} = 0;
}

#

for ($i=0;$i<$unique_new_browser;$i++) {
for ($j=0;$j<=$#agent;$j++) {
if ($bestbrowserday[$i] =~ /$agent[$j]/) {
$tmp = $agent[$j];
$tmp1 = $translate_agent{$tmp};
}
}
$bestbrowserday[$i] =~ s/$tmp/$tmp1/ if ($tmp1 ne '');
}

#

$unique_new_osday = $uniqueosday;
foreach $osday (keys(%nbreosday)) {
	$ok = 0;
	for ($j=0;$j<=$#os;$j++) {
		if ($osday eq $os[$j]) {
			$tmp = $os[$j];
			$tmp1 = $translate_os{$tmp};
			$new_osday{$tmp1} += $nbreosday{$tmp} if ($ok == 0);
			$ok = 1;
			$unique_new_osday-- if ($seen{"$tmp1 $oldjour"}++);
		}
	}
	$new_osday{$osday} = $nbreosday{$osday} if ($ok != 1);
}


for ($i=0;$i<$unique_new_osday;$i++) {
$maxi = 0;
foreach $os (keys(%new_osday)) {
    if ($new_osday{$os} > $maxi) {
         $maxi = $new_osday{$os};
         $bestosday[$i] = $os;
         $occurosday[$i] = $new_osday{$os};                 
         }
    }
$new_osday{$bestosday[$i]} = 0;
}


       ###

	($tmp1,$tmp2,$tmp3) = split(/ /,$oldjour);
	$dirresume = $tmp3."-".$tmp2."-".$tmp1;

	for ($nblang=0;$nblang<=$#lang;$nblang++) {

	$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
	mkdir ($tmp,0775) unless -d $tmp;

	open(FILEDAYAGENT,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$tabnamebrowser") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$tabnamebrowser\n";

	&AgentDay(*FILEDAYAGENT, eval($Lang{$lang[$nblang]}));

	close (FILEDAYAGENT);
	}

	###

       for ($i=1;$i<=$unique;$i++) {
           $evolbrowser{$count_day,$i} = $nbreday{$browser[$i]};
           }

           undef %nbreday;

       ###

for ($i=0;$i<=$unique_new_browserday;$i++) {
for ($l=$browser_version_nbday{$bestbrowserday[$i]};$l>0;$l--) {
$browser_versionday{$bestbrowserday[$i],$l} = '';
}
}

undef %new_browserday;
undef %nbrebrowserday;
undef %nbreosday;
undef %browser_version_nbday;
undef %browser_versionday;
undef $bestbrowserday;
undef $occurbrowserday;

$unique_new_browserday = 0;

	$countday = 0;
	$uniqueday = 0;
	$uniqueosday = 0;
	$unique_new_osday = 0;	
       $scan = 1;
       $count_day += $diff;
       $oldjour = $jour;
       }	    
    }

}

#print "$scan - $jour_of_year - $pastjour_of_year\n";
if ($scan == 1 && ($jour_of_year >= $pastjour_of_year)) {
#$os = $langue if ($langue =~ /;/);
#chop ($os) if ($os ne '');

#print STDERR "AAA - $os - $f\n" if ($os eq '');
$os =~ s/;(.*)//;
$os =~ s/\)//;
$os =~ s/^\s+//;
$os = "<I>Unknown</I>" if ($os eq '');

#$browser =~ s/\s+//;
$browser =~ s/"//g;

$nbre{$browser}++;
$nbreday{$browser}++;
$nbreos{$os}++;

$nbrebrowserday{$browser}++;
$nbreosday{$os}++;

$count++;
$countday++;
#$countos++;

$unique++ if ($nbre{$browser} == 1);
$uniqueos++ if ($nbreos{$os} == 1);
$uniqueday++ if ($nbrebrowserday{$browser} == 1);
$uniqueosday++ if ($nbreosday{$os} == 1);

$browser[$unique] = $browser if ($nbre{$browser} == 1);
$browserday[$uniqueday] = $browser if ($nbreday{$browser} == 1);

}

}

close (INFILE); 

# last day


#($tmp1,$tmp2,$tmp3) = split(/ /,$jour);
#$dirresume = $tmp3."-".$tmp2."-".$tmp1;

	     if ($agentlog eq $prefixlog) {

#print "Saving daily incremental data : $fileagentday\n";

open(FILEDAYAGENT,">$fileagentday") || die "Error, unable to open $fileagentday\n";

$jour = $oldjour if ($jour eq '');
print FILEDAYAGENT "$jour\n";

foreach $browser (keys(%nbrebrowserday)) {
    print FILEDAYAGENT "A\t$browser\t$nbrebrowserday{$browser}\n";
}

foreach $browser (keys(%nbreosday)) {
    print FILEDAYAGENT "B\t$browser\t$nbreosday{$browser}\n";
}

for ($i=1;$i<=$uniqueday;$i++) {
    print FILEDAYAGENT "C\t$browserday[$i]\n"; 
}

close (FILEDAYAGENT);
}

# mois gzip suivant

$stop = 1 if (($zip != 1 && $zipcut == 0) || ($fileagent eq $filezip));

if ($zip == 1 || $zipcut != 0) {

$stop = 1 if ($fileagent eq "$fileroot$prefixlog");

$nbline = 0;
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
          $filezip = $fileroot.$prefixlog if ($file eq $fileagent);
          $fileagent = $fileroot.$prefixlog if ($file eq $fileagent);
          $filezip = $fileroot.$agentlog if ($file ne $fileagent);
          $fileagent = $fileroot.$agentlog if ($file ne $fileagent);       
          $stop = 1 if (!(-f $fileagent));
      }
    }
} else {
   if (-e $fileagent && $zipcut != 0) {
   } else {
          $stop = 1 if (!(-f $fileagent));
   }
}


   $fyear = $year;
   $year = $yyear;    
}

}


if ($file eq $fileagent || $type_serveur == 2) {

### last day

for ($i=1;$i<=$unique;$i++) {
    $evolbrowser{$count_day,$i} = $nbreday{$browser[$i]};
}

}


### Last day

$unique_new_browserday = 0;

for ($l=1;$l<=$uniqueday;$l++) {

	for ($j=0;$j<=$#agent;$j++) {
		if ($browserday[$l] =~ /$agent[$j]/) {
			$tmp = $agent[$j];
			$tmp1 = $translate_agent{$tmp};
			$bro_ver = $browserday[$l];
			$bro_ver =~ /(\d)+/;
			$bro_ver = int($1);
			$new_browserday{$tmp1} += $nbreday{$browserday[$l]};
			$browser_versionday{$tmp1,$bro_ver} += $nbreday{$browserday[$l]};
			$browser_version_nbday{$tmp1} = $bro_ver if ($bro_ver > $browser_version_nbday{$tmp1});
			$browserday[$l] = '';
			$unique_new_browserday++ if (!($seen{$tmp1}++));
		}
	}
	$new_browserday{$browserday[$l]} += $nbreday{$browserday[$l]} if ($browserday[$l] ne '');
	$unique_new_browserday++ if ($browserday[$l] ne '');
}

#

# tri des $topten browser les plus frequents

for ($i=0;$i<$unique_new_browserday;$i++) {
$maxi = 0;
foreach $browser (keys(%new_browserday)) {
    if ($new_browserday{$browser} > $maxi) {
         $maxi = $new_browserday{$browser};
         $bestbrowserday[$i] = $browser;
         $occurbrowserday[$i] = $new_browserday{$browser};                 
         }
    }
$new_browserday{$bestbrowserday[$i]} = 0;
}

#

for ($i=0;$i<$unique_new_browser;$i++) {
for ($j=0;$j<=$#agent;$j++) {
if ($bestbrowserday[$i] =~ /$agent[$j]/) {
$tmp = $agent[$j];
$tmp1 = $translate_agent{$tmp};
}
}
$bestbrowserday[$i] =~ s/$tmp/$tmp1/ if ($tmp1 ne '');
}

#

$unique_new_osday = $uniqueosday;
foreach $osday (keys(%nbreosday)) {
	$ok = 0;
	for ($j=0;$j<=$#os;$j++) {
		if ($osday eq $os[$j]) {
			$tmp = $os[$j];
			$tmp1 = $translate_os{$tmp};
			$new_osday{$tmp1} += $nbreosday{$tmp} if ($ok == 0);
			$ok = 1;
			$unique_new_osday-- if ($seen{"$tmp1 $oldjour"}++);
		}
	}
	$new_osday{$osday} = $nbreosday{$osday} if ($ok != 1);
}



for ($i=0;$i<$unique_new_osday;$i++) {
$maxi = 0;
foreach $os (keys(%new_osday)) {
    if ($new_osday{$os} > $maxi) {
         $maxi = $new_osday{$os};
         $bestosday[$i] = $os;
         $occurosday[$i] = $new_osday{$os};                 
         }
    }
$new_osday{$bestosday[$i]} = 0;
}

       ###

	($tmp1,$tmp2,$tmp3) = split(/ /,$oldjour);
	$dirresume = $tmp3."-".$tmp2."-".$tmp1;

	for ($nblang=0;$nblang<=$#lang;$nblang++) {

	$tmp = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$dirresume;
	mkdir ($tmp,0775) unless -d $tmp;

	open(FILEDAYAGENT,">$path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$tabnamebrowser") || die "Error, unable to open $path$lang[$nblang]$dirsep$dirdate$dirsep$dirresume$dirsep$tabnamebrowser\n";

	&AgentDay(*FILEDAYAGENT, eval($Lang{$lang[$nblang]}));

	close (FILEDAYAGENT);
	}

#################################################################
####             sauvegarde des donnees                   #######
#################################################################

open(OUT,">$path$dirinc$dirsep$incbrowser") || die "Error, unable to open $path$dirinc$dirsep$incbrowser\n";

print OUT "$line\t$size\t$firstday\t$oldjour\n";
for ($i=1;$i<=$unique;$i++) {
    print OUT "$browser[$i]\t$nbre{$browser[$i]}\n";
}
close(OUT);    

open(OUT,">$path$dirinc$dirsep$incos") || die "Error, unable to open $path$dirinc$dirsep$incos\n";
print OUT "$count\n";
foreach $os (keys(%nbreos)) {
    print OUT "$os\t$nbreos{$os}\n";
}
close(OUT);    


open(OUT,">$path$dirinc$dirsep$dayagent") || die "Error, unable to open $path$dirinc$dirsep$dayagent\n";
for ($j=0;$j<=$count_day;$j++) {
for ($i=1;$i<=$unique;$i++) {
	$evolbrowser{$j,$i} = 0 if ($evolbrowser{$j,$i} eq '');
        print OUT "$evolbrowser{$j,$i} ";
        }
print OUT "\n";
}
close (OUT);

#############################################################################

&save_reverse_dns if ($reverse_dns == 1); # sauvegarde de la table de DNS

exit if ($line == $nbline);

# tri par browser sans version

$unique_new_browser = 0;

for ($l=1;$l<=$unique;$l++) {

	$browser2[$l] = $browser[$l];
	$nbre2{$browser2[$l]} = $nbre{$browser[$l]};	
	for ($j=0;$j<=$#agent;$j++) {
		if ($browser[$l] =~ /$agent[$j]/) {
			$tmp = $agent[$j];
			$tmp1 = $translate_agent{$tmp};
			$bro_ver = $browser[$l];
			$bro_ver =~ /(\d)+/;
			$bro_ver = int($1);
#			$nb_browser{$tmp1} += $nbre{$browser[$l]};
			$new_browser{$tmp1} += $nbre{$browser[$l]};
			$browser_version{$tmp1,$bro_ver} += $nbre{$browser[$l]};
			$browser_version_nb{$tmp1} = $bro_ver if ($bro_ver > $browser_version_nb{$tmp1});
			$browser[$l] = '';
			$unique_new_browser++ if (!($seen{"$tmp1 priv"}++));
		}
	}
	$new_browser{$browser[$l]} += $nbre{$browser[$l]} if ($browser[$l] ne '');
	$unique_new_browser++ if ($browser[$l] ne '');
}

#foreach $browser (keys(%nb_browser)) {
#print "$browser - $nb_browser{$browser}\n";
#}

# New table

#foreach $browser (keys(%new_browser)) {
#print "B - $browser - $new_browser{$browser} - $unique_new_browser\n";
#}

# tri par os

foreach $os (keys(%nbreos)) {
	$ok = 0;
	for ($j=0;$j<=$#os;$j++) {
		if ($os eq $os[$j]) {
			$tmp = $os[$j];
			$tmp1 = $translate_os{$tmp};
			$new_os{$tmp1} += $nbreos{$tmp} if ($ok == 0);
#			print STDERR "A - $os - $tmp1 - $nbreos{$tmp}\n";
			$unique_new_os++ if (!($seen{"$tmp1 priv2"}++));
			$ok = 1;
		}
	}
	$new_os{$os} = $nbreos{$os} if ($ok != 1);
	$unique_new_os++ if ($ok != 1);
}


undef %nbreos;

$uniqueos = $unique_new_os;

foreach $os (keys(%new_os)) {
$nbreos{$os} = $new_os{$os};
#print STDERR "A - $os - $new_os{$os} - $unique_new_os\n";
}

#foreach $os (keys(%nbreos)) {
#print STDERR "B - $os $nbreos{$os}\n";
#}

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

$day = "0".$day unless (length($day) == 2);
$month = "0".$month unless (length($month) == 2);

$year++ if ($month == 13);
$month = "01" if ($month == 13);
$monthprev = 0 if ($month == 1);
$lettermonth = $month_nb[$monthprev];
$fileagent = $fileroot;
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
$compressed_logfile_fields[$i] =~ s/\%/\$/;
$fileagent .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}
      
$filezip = $fileagent.$zipext if ($zip == 1);
}

#################################################################
###                    computing maxima                       ###
#################################################################

#for ($l=1;$l<=$unique;$l++) {
#print STDERR " $browser2[$l] - $nbre{$browser2[$l]}\n";
#}


# tri de browser2

for ($i=1;$i<=$unique;$i++) {
$maxi = 0;
for ($j=1;$j<=$unique;$j++) {
    if ($nbre{$browser2[$j]} > $maxi) {
         $maxi = $nbre{$browser2[$j]};
         $browser3[$i] = $browser2[$j];
         $nbre3{$browser3[$i]} = $maxi;
         $maxix = $j       
         }
}
$nbre{$browser2[$maxix]} = 0;
}



#for ($l=1;$l<=$unique;$l++) {
#print STDERR "$browser3[$l] - $nbre3{$browser3[$l]}\n";
#}

# tri des $topten browser les plus frequents
$boucle = $topten unless ($unique_new_browser < $topten);
$boucle = $unique_new_browser unless ($unique_new_browser > ($topten-1));

for ($i=0;$i<$boucle;$i++) {
$maxi = 0;
foreach $browser (keys(%new_browser)) {
    if ($new_browser{$browser} > $maxi) {
         $maxi = $new_browser{$browser};
         $bestbrowser[$i] = $browser;
         $occurbrowser[$i] = $new_browser{$browser};                 
         }
    }
$new_browser{$bestbrowser[$i]} = 0;
}

###

$boucleall = $topten unless ($unique < $topten);
$boucleall = $unique unless ($unique > ($topten-1));

for ($i=0;$i<$boucleall;$i++) {
$maxi = 0;
foreach $browser (keys(%nbre2)) {
    if ($nbre2{$browser} > $maxi) {
         $maxi = $nbre2{$browser};
         $bestbrowserall[$i] = $browser;
         $occurbrowserall[$i] = $nbre2{$browser};                 
         }
    }
$nbre2{$bestbrowserall[$i]} = 0;
}


# tri des $topten OS les plus repandu
$boucleos = $topten unless ($uniqueos < $topten);
$boucleos = $uniqueos unless ($uniqueos > ($topten-1));

for ($i=0;$i<$boucleos;$i++) {
$maxi = 0;
foreach $os (keys(%nbreos)) {
    if ($nbreos{$os} > $maxi) {
         $maxi = $nbreos{$os};
         $bestos[$i] = $os;
         $occuros[$i] = $nbreos{$os};                 
         }
    }
$nbreos{$bestos[$i]} = 0;
}


#################################################################
#####             browser evolution graphs                #######
#################################################################

#$year = $yeartmp;

#if ($file eq $fileagent || $type_serveur == 2) {
if ($prefixlog eq $agentlog || $type_serveur == 2) {

# check if something have been scan !

if ($jour_of_year < $pastjour_of_year && $pastyear == $year && $line == 0) {
$increase = $jour_of_year_end - $jour_of_year_first;
$increase +=365 if ($increase < 1);
print STDERR "Last day recorded in logfile is too old.\n";
print STDERR "Use \"-d $increase\" option to scan all the logfile!\n";
exit;
}

if ($count_day == 0 && $unique == 0 && $line == 0) {
print STDERR "Don't seems to be a extended NCSA logfile !\n";
print STDERR "Check inside your $fileroot directory...\n";
exit;
}

### maximum

$start_date = $firstday;

if ($count_day > $nbdays) {
$initday = $count_day - $nbdays;
$start_date = $pasttoday;
}

$maxtot = 0;
for ($j=$initday;$j<=$count_day;$j++) {
    $max = 0;
    for ($i=1;$i<=$unique;$i++) {
       $max += $evolbrowser{$j,$i};
    }
    $newevol{$j-$initday,$boucleall} = $max;
    $maxtot = $max if ($max > $maxtot);
}


### recompute to select the $TOPTEN browsers

for ($j=$initday;$j<=$count_day;$j++) {
  for ($k=0;$k<$boucleall;$k++) {
     for ($i=1;$i<=$unique;$i++) {
       if ($bestbrowserall[$k] eq $browser2[$i]) {
         $newevol{$j-$initday,$k} = $evolbrowser{$j,$i};
       } 
     }
  }
}

for ($i=0;$i<=$nbdays;$i++) {
  for ($k=0;$k<$boucleall;$k++) {
    $newevol{$i,$boucleall} -= $newevol{$i,$k};
  }
}

### 

$count_day++;

$nbdays = $count_day if (($count_day+$jour_of_year_first) < $jour_of_year_end);
$nbdays = $count_day if ($count_day < $nbdays);

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

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 
 for ($i=0;$i<=$nbdays;$i++) {
 $x1 = $i*$xstep/$factx;
 $x2 = ($i+1)*$xstep/$factx;
 
 $y2 = $ymax;
 $y1 = $ymax;
 $yfinal = $ymax;

 for ($j=0;$j<=$boucleall;$j++) {
 $yfinal -= ($ystep/$facty * $newevol{$i,$j});
 }

 for ($j=0;$j<=$boucleall;$j++) {

 $ji = $j % ($#gcolor);
 $ji = 100 if ($j == $boucleall);

 if ($bargraph == 1) {
   $y2 -= ($ystep/$facty * $newevol{$i,$j});
   $y1 -= ($ystep/$facty * $newevol{$i,$j-1});
   print FLY "frect $x1,$y2,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
   print FLY "rect $x1,$y2,$x2,$y1,0,0,0\n";
   if ($tridim == 1 && ($y1-$y2) > 2) {
        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;
        $y1plus = $y1-$perspec;

        print FLY "fpoly $red[$ji],$green[$ji],$blue[$ji],$x2,$y1,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        print FLY "poly 0,0,0,$x2,$y1,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";

        if ($y2 == $yfinal) {
        print FLY "fpoly $red[$ji],$green[$ji],$blue[$ji],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        }

   }
 }

 if ($linegraph == 1) {
    $y2 = $ymax - ($ystep/$facty * $newevol{$i,$j});
    $y1 = $ymax - ($ystep/$facty * $newevol{$i+1,$j});
    print FLY "line $x1,$y2,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
    }

 if ($fillgraph == 1) {
     $ji = ($boucleall-$j) % ($#gcolor);
     $ji = 100 if ($j == 0);
     $y2 = $ymax;
     $y1 = $ymax;
     for ($l=0;$l<=($boucleall-$j);$l++) {
          $y2 -= ($ystep/$facty * $newevol{$i,$l});
          $y1 -= ($ystep/$facty * $newevol{$i+1,$l});
     }
     if ($y2 != $ymax || $y1 != $ymax) {
     print FLY "line $x1,$y2,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
 
     print FLY "line $x1,$ymax,$x1,$y2,$red[$ji],$green[$ji],$blue[$ji]\n";
     print FLY "line $x2,$ymax,$x2,$y1,$red[$ji],$green[$ji],$blue[$ji]\n";
     print FLY "line $x1,$yfirst,$x2,$yfirst,$red[$ji],$green[$ji],$blue[$ji]\n";

     $fx = ($x1+$x2)/2;
     $fy = $yfirst-1;

     print FLY "fill $fx,$fy,$red[$ji],$green[$ji],$blue[$ji]\n";
      } 
 }

 }
 }

 print FLY "transparent 200,200,200\n";
 close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $agentgraph |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

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
 
open(FOO,"$FLY -q -i $tmpfly -o $agentgraphx |");
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
 
open(FOO,"$FLY -q -i $tmpfly -o $agentgraphy |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);

}
#}

for ($i=0;$i<$boucle;$i++) {
for ($j=0;$j<=$#agent;$j++) {
#print STDERR "$agent[$j]\n";
if ($bestbrowser[$i] =~ /$agent[$j]/) {
#print "$bestbrowser[$i]\n";
$tmp = $agent[$j];
$tmp1 = $translate_agent{$tmp};
}
}
$bestbrowser[$i] =~ s/$tmp/$tmp1/ if ($tmp1 ne '');
}


for ($nblang=0;$nblang<=$#lang;$nblang++) {

 $tabbrowser = $path.$lang[$nblang].$dirsep.$dirlist.$dirsep.$tabnamebrowser;

 open(TABAGENT,">$tabbrowser") || die "Error, unable to open $tabbrowser\n";
 &AgentStats(*TABAGENT, eval($Lang{$lang[$nblang]}));
 close(TABAGENT);
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

#$today =~ s/ /\//g;

open(FILE,">>$history");
#print FILE "cron-agent\t$today\t$startrun\t$endrun\t$min:$sec\t$line\n";
printf FILE "cron-agent\t%s\t%s\t%s\t%d:%d\t%d\n",$today,$startrun,$endrun,$min,$sec,$line;
close(FILE);


############################################
### creation du fichier pour les browser ###
############################################

##########################################################################
sub AgentDay {
  local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Browsers_used'} - $oldjour</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-agent.pl $version - $today $hourdate -->\n";
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H3>$L{'Browsers_used'}</H3><P>\n";

# print FOUT "<HR size=5>\n";
# print FOUT "<CENTER><B>$oldjour</B></CENTER>\n" if ($file eq $fileagent);
# print FOUT "<HR size=5>\n" if ($file eq $fileagent);
# print FOUT "<P>\n";
# print FOUT "$L{'most_succf_browsers1'} $unique_new_browserday $L{'most_succf_browsers2'}<p>\n";

 print FOUT "$L{'most_succf_browsers1'} $topten $L{'most_succf_browsers2'} ($L{'among'} $unique_new_browserday)<p>\n";

 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR><TH>$L{'Browser'}</TH><TH>$L{'Occurence'}</TH></TH><TH>$L{'Percentage'}</TH></TR>\n";

#

for ($i=0;$i<$topten;$i++) {
#for ($i=0;$i<$unique_new_browserday;$i++) {
$pourcentage = ($occurbrowserday[$i]*100)/$countday if ($countday != 0);
$intpourcentage = int($pourcentage);

print FOUT "<TR><TD BGCOLOR=\"#DDDDDD\">$bestbrowserday[$i]</TD><TD ALIGN=CENTER BGCOLOR=\"#DDDDDD\"><B>$occurbrowserday[$i]</B> $L{'times'}</TD><TD BGCOLOR=\"#DDDDDD\">";
print FOUT "<img width=$intpourcentage height=$square src=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">" if ($intpourcentage != 0);
print FOUT " <B>";
printf FOUT "%.1f",$pourcentage;
print FOUT " %</B></TD></TR>\n";

for ($l=$browser_version_nbday{$bestbrowserday[$i]};$l>0;$l--) {

if ($browser_versionday{$bestbrowserday[$i],$l} ne '') {
print FOUT "<TR><TD>$bestbrowserday[$i] $l</TD><TD ALIGN=CENTER><B>$browser_versionday{$bestbrowserday[$i],$l}</B> $L{'times'}</TD><TD>";
$pourcentage = ($browser_versionday{$bestbrowserday[$i],$l}*100)/$occurbrowserday[$i];
$intpourcentage = int($pourcentage);
print FOUT "<img width=$intpourcentage height=$square src=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">" if ($intpourcentage != 0);
print FOUT " <B>";
printf FOUT "%.1f",$pourcentage;
print FOUT " %</B></TD></TR>\n";
}
}
}

#

print FOUT "</TABLE>\n";

 print FOUT "<P><HR><P>\n"; 

 print FOUT "$L{'OS_used1'} $topten $L{'OS_used2'} ($L{'among'} $unique_new_osday)<p>\n";
# print FOUT "$L{'OS_used1'} $unique_new_osday $L{'OS_used2'}<p>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR><TH>$L{'OS'}</TH><TH>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";


#for ($i=0;$i <$unique_new_osday;$i++) {         
for ($i=0;$i <$topten;$i++) {         
$pourcentage = ($occurosday[$i]*100)/$countday if ($countday != 0);
$intpourcentage = int($pourcentage);

if ($occurosday[$i] != 0) {
print FOUT "<TR><TD>$bestosday[$i]</TD><TD ALIGN=CENTER><B>$occurosday[$i]</B> $L{'times'}</TD><TD>";
print FOUT "<img width=$intpourcentage height=$square src=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">" if ($intpourcentage != 0);
print FOUT "<B>";
printf FOUT "&nbsp;%.1f",$pourcentage;
print FOUT " %</B></TD>";
print FOUT "</TR>\n";
}
}

#

#foreach $osday (keys (%nbreosday)) {
#$pourcentage = ($nbreosday{$osday}*100)/$countday;
#$intpourcentage = int($pourcentage);

#if ($nbreosday{$osday} != 0) {
#print FOUT "<TR><TD>$osday</TD><TD ALIGN=CENTER><B>$nbreosday{$osday}</B> $L{'times'}</TD><TD>";
#print FOUT "<img width=$intpourcentage height=$square src=\"..$dirsepurl..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">" if ($intpourcentage != 0);
#print FOUT "<B>";
#printf FOUT "&nbsp;%.1f",$pourcentage;
#print FOUT " %</B></TD>";
#print FOUT "</TR>\n";
#}
#}

 print FOUT "</TABLE><P>\n";

 print FOUT "</BODY></HTML>\n";
}

##########################################################################
sub AgentStats {
  local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Browsers_used'}</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-agent.pl $version - $today $hourdate -->\n";
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\" LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1>$L{'Browsers_used'}</H1><P>\n";

 print FOUT "<HR size=5>\n";
 print FOUT "<CENTER><B>$firstday - $jour</B></CENTER>\n" if ($file eq $fileagent);
 print FOUT "<HR size=5>\n" if ($file eq $fileagent);
 print FOUT "<P>\n";

if ($prefixlog eq $agentlog || $type_serveur == 2) {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkagentgraphy\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkagentgraph\" ALT=\"graph\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkagentgraphx\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "<TR><TD></TD>\n";
print FOUT "<TD ALIGN=CENTER>\n";

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$others\" ALT=\"$others\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'Others'}</TD></TR>\n";
for ($i=($boucleall-1);$i>=0;$i--) {
$j = $i % ($#gcolor);
$couleur = $gcolor[$j];
print FOUT "<TR><TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$couleur\" ALT=\"$couleur\"></TD>\n";
print FOUT "<TD>&nbsp; $bestbrowserall[$i]</TD></TR>\n";
}
print FOUT "</TABLE>\n";

print FOUT "</TD></TR>\n";        
print FOUT "</TABLE></CENTER>\n";


print FOUT "<P><I><CENTER>$L{'most_succf_browsers_vtime1'} $boucleall $L{'most_succf_browsers_vtime2'}</CENTER></I>\n";
print FOUT "<P><HR><P>\n"; 
}

 print FOUT "$L{'most_succf_browsers1'} $boucle $L{'most_succf_browsers2'}<p>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR><TH>$L{'Browser'}</TH><TH>$L{'Occurence'}</TH></TH><TH>$L{'Percentage'}</TH></TR>\n";


for ($i=0;$i<$boucle;$i++) {
$pourcentage = ($occurbrowser[$i]*100)/$count;
$intpourcentage = int($pourcentage);

print FOUT "<TR><TD BGCOLOR=\"#DDDDDD\">$bestbrowser[$i]</TD><TD ALIGN=CENTER BGCOLOR=\"#DDDDDD\"><B>$occurbrowser[$i]</B> $L{'times'}</TD><TD BGCOLOR=\"#DDDDDD\">";
print FOUT "<img width=$intpourcentage height=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">" if ($intpourcentage != 0);
print FOUT " <B>";
printf FOUT "%.1f",$pourcentage;
print FOUT " %</B></TD></TR>\n";

#print STDERR "A- $bestbrowser[$i] - $browser_version_nb{$bestbrowser[$i]}\n";
#for ($l=0;$l<=$browser_version_nb{$bestbrowser[$i]};$l++) {

if ($opt_a eq '') {
for ($l=$browser_version_nb{$bestbrowser[$i]};$l>0;$l--) {
#print STDERR "$bestbrowser[$i] $l - $browser_version{$bestbrowser[$i],$l}\n" 
if ($browser_version{$bestbrowser[$i],$l} ne '') {
print FOUT "<TR><TD>$bestbrowser[$i] $l</TD><TD ALIGN=CENTER><B>$browser_version{$bestbrowser[$i],$l}</B> $L{'times'}</TD><TD>";
$pourcentage = ($browser_version{$bestbrowser[$i],$l}*100)/$occurbrowser[$i];
$intpourcentage = int($pourcentage);
#if ($intpourcentage != 100) {
print FOUT "<img width=$intpourcentage height=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">" if ($intpourcentage != 0);
print FOUT " <B>";
printf FOUT "%.1f",$pourcentage;
print FOUT " %</B></TD></TR>\n";
#}
}
}
}

if ($opt_a ne '') {
for ($l=0;$l<=$unique;$l++) {
	for ($j=0;$j<=$#agent;$j++) {
		$tmp = $agent[$j];
		$tmp1 = $translate_agent{$tmp};
		$tmpnbre = $browser3[$l];
		$browsertmp = $browser3[$l];		
		$browsertmp =~ s/$tmp/$tmp1/;
		if ($browsertmp =~ /$bestbrowser[$i]/) {
			$pourcentage = ($nbre3{$tmpnbre}*100)/$occurbrowser[$i];
			$intpourcentage = int(($nbre3{$tmpnbre}*100)/$occurbrowser[$i]);			
#			if ($intpourcentage != 100) {
			print FOUT "<TR><TD>$browsertmp</TD><TD ALIGN=CENTER><B>$nbre3{$tmpnbre}</B> $L{'times'}</TD><TD>";
			print FOUT "<img width=$intpourcentage height=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\">" if ($intpourcentage != 0);
			print FOUT " <B>";
			printf FOUT "%.1f",$pourcentage;
			print FOUT " %</B></TD></TR>\n";
#			}
			last;
		}
	}
}
}



}

 print FOUT "</TABLE>\n";

 print FOUT "<P><HR><P>\n"; 

 print FOUT "$L{'OS_used1'} $boucleos $L{'OS_used2'}<p>\n";
 print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
 print FOUT "<TR><TH>$L{'OS'}</TH><TH>$L{'Occurence'}</TH><TH>$L{'Percentage'}</TH></TR>\n";

for ($i=0;$i < $boucleos;$i++) {
$pourcentage = ($occuros[$i]*100)/$count;
$intpourcentage = int($pourcentage);
print FOUT "<TR><TD>$bestos[$i]</TD><TD ALIGN=CENTER><B>$occuros[$i]</B> $L{'times'}</TD><TD>";
print FOUT "<img width=$intpourcentage height=$square src=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\">" if ($intpourcentage != 0);
print FOUT " <B>";
printf FOUT "%.1f",$pourcentage;
print FOUT " %</B></TD></TR>\n";
}

 print FOUT "</TABLE>\n";

 print FOUT "</BODY></HTML>\n";
}



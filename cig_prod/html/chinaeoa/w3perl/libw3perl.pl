#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                     W3PERL LIBRAIRY                            #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 20/08/2000     #####
####                                                                #####
####                                                                #####
#########################################################################

require "getopt.pl";
require "ctime.pl";

&Getopt('cdgijlopqrst');

&ReadParse;

if ($opt_c ne '') {
$conf_file = $opt_c;
require "$conf_file";
} else {
require "/usr/local/etc/w3perl/cgi-bin/w3perl/config.pl";
}	

$pos = rindex($cgipath,"cgi");
$cgiurl = substr($cgipath,$pos-1,length($cgipath));

&securecgi if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'HTTP_REFERER'} !~ /$cgiurl/);

if ($ENV{'REQUEST_METHOD'} eq "GET") {

    if ($opt_y != 1) {
    if ($0 !~ /cron-w3perl/) {
	print "Content-type: text/html\n\n";
	print "<HTML><HEAD><TITLE>Stats</TITLE></HEAD>\n";
	print "<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\">\n";
    }
}

    &ReadParse;

    print "<B>" if ($0 =~ /cron-w3perl/);
    print "<I>Computing $0 ....</I><BR>\n";
    print "</B>" if ($0 =~ /cron-w3perl/);

}

umask(002);

#########################################################################
### Language arrays
#########################################################################

%Lang = ( 
	"uk" , "*LangUK",
	"fr" , "*LangFR",
	"sp" , "*LangSP",
	"it" , "*LangIT",
	"jp" , "*LangJP",
	"fi" , "*LangFI",
	"de" , "*LangDE",
	"nl" , "*LangNL" );

for ($i=0;$i<=$#lang;$i++) {
$tmp = $dirress.$dirsepurl."lang".$dirsepurl.$lang[$i].$plext if ($dirsep eq ".");
$tmp = $dirress.$dirsep."lang".$dirsep.$lang[$i].$plext if ($dirsep ne ".");
$tmp = $pathinit.$tmp;
require "$tmp";
}

#################################################################
####                          date                        #######
#################################################################
### today date

@days_counter = (0,31,59,90,120,151,181,212,243,273,304,334,365);

@day_of_week = ('Sun','Mon','Tue','Wed','Thu','Fri','Sat');

%month_of_year = ('Jan','31',
                  'Feb','28',
                  'Mar','31',
                  'Apr','30',
                  'May','31',
                  'Jun','30',
                  'Jul','31',
                  'Aug','31',
                  'Sep','30',
                  'Oct','31',
                  'Nov','30',
                  'Dec','31');

@month_nb = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

%month_equiv = ( 'Jan','1',
                 'Feb','2',
                 'Mar','3',
                 'Apr','4',
                 'May','5',
                 'Jun','6',
                 'Jul','7',
                 'Aug','8',
                 'Sep','9',
                 'Oct','10',
                 'Nov','11',
                 'Dec','12');


$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
$year = $a if ($year eq '');
$day = "0".$day if (length($day) == 1);
$monthindex = $month_equiv{$month};
$countmonth = $month_equiv{$month};
($hour,$minute,$second) = split(/:/,$hourdate);
$today = $day."/".$month."/".$year;
$fullyear = $year;
$fyear = $fullyear - 10;
$smallyear2_today = int($year/100);
$smallyear_today = $year - $smallyear2_today*100;

if (($year%4 == 0 && $year%100 != 0) || $year%400 == 0) {
$month_of_year{'Feb'} = "29";
$bisextil = 1;
}

#################################################################
####      convert IIS date format to COMMON format        #######
#################################################################

sub date_common {
    local($date1,$date2) = @_;
    local($year,$month,$day,@val);
     
    @val = split(/[\/\.-]/,$date1);

    eval "\$$date_string[1] = $val[0]";
    eval "\$$date_string[2] = $val[1]";
    eval "\$$date_string[3] = $val[2]";

    $day = "0".$day if (length($day) == 1);

    if ($year < 100) {
 	$year = "0".$year if (length($year) == 1);
 	if ($year <= $smallyear_today) {
 	    $year = $smallyear2_today.$year;
 	} else {
 	    $year = eval($smallyear2_today-1).$year;
 	}
    }

    $date1 = $day."/".$month_nb[--$month]."/".$year;
    $date = $date1.":".$date2;
    $date;
}

#################################################################
####                   print flag value                   #######
#################################################################

sub id {
    local($affirmation) = @_;

print STDOUT "Yes\n" if ($affirmation == 1);
print STDOUT "No\n" if ($affirmation == 0);
}

#################################################################
####            compute hour and day format               #######
#################################################################

### entree : time en seconde, sortie : date, datehour et datemisc

sub get_time {
    local($timesec) = @_;
    local($sec,$min,$hour,$day,$monthnumber,$year,$wday,$yday,$isdst);

($sec,$min,$hour,$day,$monthnumber,$year,$wday,$yday,$isdst) = localtime($timesec);
$month = $month_nb[$monthnumber];
$day = "0".$day if (length($day) == 1);
$min = "0".$min if (length($min) == 1);
$hour = "0".$hour if (length($hour) == 1);
$wday = $day_of_week[$wday];
$yday++;
$isdst++;

# $year passe a 100 en 2000 !!!

$year = substr($year,length($year)-2,length($year));
$year = $smallyear2_today.$year;

#$year = '19'.$year if ($year > 95);
#$year = '20'.$year if ($year < 96);

$date = "$day/$month/$year";
$datehour = "$hour:$min:$sec";
$datemisc = "$yday $wday $isdst";
}

#################################################################
####            compute number of days                    #######
#################################################################

sub nbdayan {
    local($jour) = @_;
    local($dayjour,$monthjour,$yearjour);

    ($dayjour,$monthjour,$yearjour) = split(/ /,$jour);

    $monthjour = $month_equiv{$monthjour};

    $y = $days_counter[$monthjour-1]+$dayjour;
    $y++ if ($monthjour > 2 && $bisextil == 1);
    $y;
}

#################################################################
####            Lookup for DNS reverse                    #######
#################################################################

sub reversedns {
    local($adr,$tmp) = @_;
	
    $adr = $revdns{$adr} if ($revdns{$adr} ne '');
    if (($adr =~ /^[0-9.]+$/ && $revdns{$adr} eq '')) {
	($a,$b,$c,$d) = split(/\./,$adr);
	$tmp = pack('C4',$a,$b,$c,$d);
	($adresse) = gethostbyaddr($tmp,2);
	$adresse = $adr if (($adresse eq '') || (length(substr($adresse,rindex($adresse,'.'))) < 2));
	$revdns{$adr} = $adresse;
    } else {
    $adresse = $adr;
    }
    return($adresse);
}

#################################################################
####                Loading DNS table                     #######
#################################################################

sub load_reverse_dns {
	local($ipdata,$tmp);

	print STDOUT "Loading DNS table\n";
	open(IP,"$path$dirdata$dirsep$ip_table");
	while (<IP>) {
		chop;
		($ipdata,$tmp) = split(/\t/);
		$revdns{$ipdata} = $tmp;
		}
	close(IP);
}

#################################################################
####                Saving DNS table                      #######
#################################################################

sub save_reverse_dns {
	local($ipdata);
	
#	print STDOUT "Saving DNS table\n";
	open(IP,">$path$dirdata$dirsep$ip_table");
	foreach $ipdata (sort keys(%revdns)) {
		print IP "$ipdata\t$revdns{$ipdata}\n";
		}
	close(IP);
}

#################################################################
####         subroutine to compute the tree                 #####
#################################################################

sub row_end {
    local(*FOUT,*L,$temp,$value,$racine,$oldvalue,$coi,$script) = @_;
    local($boucle2,$affrac,$it,$loop,$z,$val,$tmp);

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
        $freqrac{$affrac} = 0 if ($freqrac{$affrac} eq '' && $script == 0);
        $freqracurl{$affrac} = 0 if ($freqracurl{$affrac} eq '' && $script == 1);
        $frequpdate{$affrac} = 0 if ($frequpdate{$affrac} eq '');

	if ($freqracurl{$affrac} != 0 && $script == 1) { 
	$tmp = $affrac;
	chop($tmp);
	$tmp = substr($tmp,1,length($tmp));
	$tmp =~ s/\//_/g;
	$tmp = $tmp.$htmlext;
	}
	
        print FOUT "<A HREF=\"$affrac\">$remind</A>" if ($script == 0);
	if ($script == 1) {
        print FOUT "<A HREF=\"$tmp\">" if ($freqracurl{$affrac} != 0);
        print FOUT "$remind";
        print FOUT "</A>" if ($freqracurl{$affrac} != 0);
        }
        
        print FOUT "<BR><I>[$freqracdepth{$affrac} - ";
        print FOUT "$freqracurl{$affrac}" if ($script == 1);
        print FOUT "$freqrac{$affrac} - $frequpdate{$affrac}" if ($script == 0);
	print FOUT "]</I>";
        }

        print FOUT "</TD>\n";

        $depthrac{$temp,$z,$loop} = '' if ($match == 1);

        if ($val != 1 && $val !=0) {
           &row_end(*FOUT,*L,$temp,$val,$affrac,$val,$coi,$script);
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
####                     Parsing forms                    #######
#################################################################
# Extracted from cgi-lib.pl from S.E.Brenner@bioc.cam.ac.uk


sub ReadParse {
  local (*in) = @_ if @_;
  local ($i, $key, $val);

  # Read in text
  if (&MethGet) {
    $in = $ENV{'QUERY_STRING'};
  } elsif (&MethPost) {
    read(STDIN,$in,$ENV{'CONTENT_LENGTH'});
  }

  @in = split(/[&;]/,$in);

  foreach $i (0 .. $#in) {
    # Convert plus's to spaces
    $in[$i] =~ s/\+/ /g;

    # Split into key and value.
    ($key, $val) = split(/=/,$in[$i],2); # splits on the first =.

    # Convert %XX from hex numbers to alphanumeric
    $key =~ s/%(..)/pack("c",hex($1))/ge;
    $val =~ s/%(..)/pack("c",hex($1))/ge;

    $opt = "opt_$key";
#    $$opt = $val;             # Work only with perl 5 and above
    eval "\$$opt = $val";
    
  }
  $ENV{'QUERY_STRING'} = '';
}

# MethGet
# Return true if this cgi call was using the GET request, false otherwise

sub MethGet {
  return ($ENV{'REQUEST_METHOD'} eq "GET");
}


# MethPost
# Return true if this cgi call was using the POST request, false otherwise

sub MethPost {
  return ($ENV{'REQUEST_METHOD'} eq "POST");
}

#################################################################
####       Parse html pages to replace accent             #######
#################################################################
# remplace les codes accent ascii accent par du html

sub accent2html {
    local($words) = @_;

    $words =~ s/é/&eacute;/g;
    $words =~ s/è/&egrave;/g;
    $words =~ s/ê/&ecirc;/g;
    $words =~ s/ë/&euml;/g;


    $words =~ s/É/&Eacute;/g;
    $words =~ s/È/&Egrave;/g;
    $words =~ s/Ê/&Ecirc;/g;
    $words =~ s/Ë/&Euml;/g;


    $words =~ s/á/&aacute;/g;
    $words =~ s/à/&agrave;/g;
    $words =~ s/â/&acirc;/g;
    $words =~ s/â/&auml;/g;

    $words =~ s/Á/&Aacute;/g;
    $words =~ s/À/&Agrave;/g;
    $words =~ s/Â/&Acirc;/g;
    $words =~ s/Ä/&Auml;/g;


    $words =~ s/í/&iacute;/g;
    $words =~ s/ì/&igrave;/g;
    $words =~ s/î/&icirc;/g;
    $words =~ s/ï/&iuml;/g;

    $words =~ s/Í/&Iacute;/g;
    $words =~ s/Ì/&Igrave;/g;
    $words =~ s/Î/&Icirc;/g;
    $words =~ s/Ï/&Iuml;/g;


    $words =~ s/ó/&oacute;/g;
    $words =~ s/ò/&ograve;/g;
    $words =~ s/ô/&ocirc;/g;
    $words =~ s/ö/&ouml;/g;

    $words =~ s/Ó/&Oacute;/g;
    $words =~ s/Ò/&Ograve;/g;
    $words =~ s/Ô/&Ocirc;/g;
    $words =~ s/Ö/&Ouml;/g;


    $words =~ s/ú/&uacute;/g;
    $words =~ s/ù/&ugrave;/g;
    $words =~ s/û/&ucirc;/g;
    $words =~ s/ü/&uuml;/g;

    $words =~ s/Ú/&Uacute;/g;
    $words =~ s/Ù/&Ugrave;/g;
    $words =~ s/Û/&Ucirc;/g;
    $words =~ s/Ü/&Uuml;/g;


    $words =~ s/ç/&ccedil;/g;
    $words =~ s/Ç/&Ccedil;/g;

    return $words;
    
}

#################################################################
####                 Sort data by number                  #######
#################################################################

sub bynumber { 
$a <=> $b;
}

#################################################################
####                 Recursive delete                     #######
#################################################################

sub dodirdel {
    local($dir) = @_;
    local($i,@filenames);

    if (-d $dir) {
	opendir(SOURCEDIR,$dir);
	@filenames = readdir(SOURCEDIR);
	closedir(SOURCEDIR);

	for ($i=0;$i<=$#filenames;$i++) {
	    if (-f "$dir$dirsep$filenames[$i]") {
		unlink("$dir$dirsep$filenames[$i]");
	    }

	    if (-d "$dir$dirsep$filenames[$i]" && $filenames[$i] ne '.' && $filenames[$i] ne '..') {
		chdir "$dir$dirsep$filenames[$i]";
		&dodirdel("$dir$dirsep$filenames[$i]");
		chdir '..';
		rmdir("$dir$dirsep$filenames[$i]");
	    }
	}
    }
}


#################################################################
####            Compute real time running                 #######
#################################################################

sub timetaken {
local($a,$b) = @_;
local($hour1,$hour2,$minute1,$minute2,$sec1,$sec2);
local ($sec,$min);

($hour1,$minute1,$sec1) = split(/:/,$a);
($hour2,$minute2,$sec2) = split(/:/,$b);

# suppose que les scripts ne depassent pas 24 h !

$min = (($hour2*60+$minute2) - ($hour1*60+$minute1));
$min = (($hour2*60+$minute2) - (1440 - ($hour1*60+$minute1))) if ($min < 0);
$sec = $sec2 - $sec1;

if (($sec < 0) && ($min > 0)) {
$min--;
$sec += 60;
}

return($min,$sec);
}

#################################################################
####                   Error debugging                    #######
#################################################################

sub error_open {
    local($file) = @_;
#    print "Content-type: text/html\n\n" if ($ENV{'REQUEST_METHOD'} eq "GET");
#    print "<HTML><HEAD><TITLE>Stats</TITLE></HEAD>\n";
#    print "<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\">\n";
    print "<P><DIR><FONT COLOR=\"#AA2020\">" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print "Unable to open $file - $!\n";
    print "</FONT><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print " ==> check read permission\n";
    print "</DIR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    exit;
}

#################################################################
####                   Check referer cgi                  #######
#################################################################

sub securecgi {
  local($file) = @_;
  local($tmp1,$tmp2);

  print "Content-type: text/html\n\n";
  print "<HTML><HEAD><TITLE>Installation forbidden access</TITLE></HEAD>\n";
  print "<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\">\n";
  print "<P><BR><H3><CENTER>";
  print "Forbidden access\n";
  print "</H3><P></CENTER><BR>";
  print "<P><DIR><FONT COLOR=\"#AA2020\">" if ($ENV{'REQUEST_METHOD'} eq "GET");
  print "You should run scripts from the interface administration\n";
  print "</FONT><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
  print " This is to avoid unsollicited access to your stats\n";
  print "</DIR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
  exit;
}

1;




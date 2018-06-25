#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                  INIT LIBRAIRY CONFIG STATS                    #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@w3perl.com                   version 04/08/2000     #####
####                                                                #####
#########################################################################


#############################################################################
# Do not modify anything

$cgipath = "/usr/local/etc/httpd/cgi-bin/w3perl"; # Do not remove this line !

$w3perlpath = "/home/domisse/public_html/w3perl"; # Do not change too !

# Constant, change if different on your server

$tildealias = "public_html"; # User directory alias
$gifext = ".gif";
$dirsepurl = "/";

# Perl path

open(ME,$0);
$perlpath = <ME>;
$perlpath =~ s/^#\!\s*(.*)\n$/$1/;
close (ME);

require "ctime.pl";

# Fly pour NT
$car = substr($cgipath,1,1);
$nt = 1 if ($car eq ':');

$pos = rindex($cgipath,$dirsepurl);
$tmp = substr($cgipath,0,$pos+1);
$flypath = $tmp."fly";
$flypath .= ".exe" if ($nt == 1);
 
# tags

$pos = length($w3perlpath)-1;
while ($pos >= 0) {
$dirsep = substr($w3perlpath,$pos,1);
last if ($dirsep !~ /[\.\w\s\d-_]/i);
#print "POS : $pos - $dirsep\n";
$pos--;
}

$pos = rindex($cgipath,"cgi");
$cgiurl = substr($cgipath,$pos-1,length($cgipath));
$bkg = substr($cgipath,$pos-1,1);

if ($bkg ne $dirsep) {
$tmp = substr($cgipath,0,$pos-1);
$pos2 = rindex($tmp,$dirsep);
$cgiurl = substr($cgipath,$pos2,length($cgipath));
}

$tmp = $w3perlpath;
$w3perlpath .= $dirsep;
$htmlext = ".html" if  ($dirsep ne "."); # All except RiscOS
$htmlext = "/html" if  ($dirsep eq "."); # RiscOS
$plext = ".pl" if  ($dirsep ne "."); # All except RiscOS
$plext = "/pl" if  ($dirsep eq "."); # RiscOS

#$dirsep = chop($tmp);
$pathsetup = $w3perlpath."admin".$dirsep."config".$dirsep;
$basefilename = $pathsetup."step";
$selected = " SELECTED";
$w3perlpathres = $w3perlpath."resources".$dirsep."admin"; # w3perl resources path
$dirress = "resources";
$dirdata = "data";
$diradmin = "admin";
$dirconfig = "config";
$dirhelp = "help";
$varforms = $w3perlpath.$dirress.$dirsep.$diradmin.$dirsep."var-forms";
$zipcut = 0;

# constants
$locconf = "locconf";
$w3perlloc = $w3perlpathres.$dirsep.$locconf;
$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
$year = $a if ($year eq '');
$day = "0".$day if (length($day) == 1);
$countmonth = $month_equiv{$month}-1;
($hour,$minute,$second) = split(/:/,$hourdate);
$date = $day."/".$month."/".$year;

# background
$bkg = $w3perlpath;

#############################################

if ($bkg =~ /\/(\w+)\/$tildealias/) {
    $tmp2 = $1;
    $bkg =~ s/.*\/$tildealias/\/~$tmp2/;
} else {
$pos = rindex($tmp,$dirsep);
$bkg = substr($tmp,$pos,length($bkg));
$bkg .= $dirsep;
}


$helpurl = $bkg.$diradmin.$dirsep.$dirhelp;
$w3perlurl = $bkg.$dirress;

$bkgline = $bkg."docs".$dirsepurl."img".$dirsepurl."line".$gifext;
$bkgback = $bkg."docs".$dirsepurl."img".$dirsepurl."back".$gifext;
$bkglink = $bkg.$diradmin.$dirsepurl."index.html";
$bkg = $bkg."docs".$dirsepurl."img".$dirsepurl."bg".$gifext;


########################################################################

sub error {
	local($msg) = @_;

print "<BODY BGCOLOR=\"#FFFFFF\">\n";
print "<CENTER><H3>Configuration Error</H3></CENTER><P><BR><BR>\n";	
print "<P><BR>\n";
print "$msg\n";
print "</HTML></BODY>\n";
exit;
}


sub loadvar {
  local($file) = @_;
  local($tmp1,$tmp2,$number);
  
        &error_open($file) if (!(-r $file));
	open(FILE,$file) || die "Can't open $file\n";
	while(<FILE>) {
	next if (/^#/);
	chop;
	$number = ($tmp1,$tmp2,$tmp3) = split(/\t/);

#	if ($tmp3 eq '') {
#	$type = $tmp1;
#	push(@tab,$type);
#	}

	if ($number == 1) {
#	    chop($tmp1);
	    $type = $tmp1;
	    push(@tab,$type);	
	}

	if ($number == 2) {
#	    chop($tmp2);
	    $nbvalueforms{$type}++;
	    $valueforms1{$type,$nbvalueforms{$type}} = $tmp1;
	    $valueforms2{$type,$nbvalueforms{$type}} = $tmp2;
	}
		
	if ($number == 3) {
#	    chop($tmp3);
	    $valueforms{$tmp1} = $tmp2;
	}
	
	}
	close(FILE);
}

#######################################################################
	
sub option {
	local($line,$out,$action) = @_;
	local($i,$field);

	#	
	### SELECT
	#
		
	if ($line =~ /<SELECT NAME="(\w+)"/ && $out == 0 && $line !~ /HIDDEN/i) {
	    # la valeur par defaut est la premiere ligne de var-forms
	    print "$_";
	    for ($i=1;$i<=$nbvalueforms{$1};$i++) {
		print "<OPTION VALUE=\"$valueforms2{$1,$i}\"";
		print " SELECTED" if ($valueforms2{$1,$i} eq $oldvalue{$1});
		print ">$valueforms1{$1,$i}\n";
	    }
	    return 1;
	}
	
	#
	### INPUT 
	#
		
	if ($line =~ /<INPUT NAME="(\w+)"/ && $out == 0 && $line !~ /HIDDEN/i) {
	$field = $1;
	
	### RADIO
	
	if ($line =~ /("radio").*(VALUE=")([0-9a-zA-Z]+)(")/i) {

	    if ($action eq "MODIFY") {
		print "$`$1 $2$3$4 CHECKED$'" if ($3 eq $oldvalue{$field}); 
		print "$`$1 $2$3$4$'" if ($3 ne $oldvalue{$field});
	    }
	    if ($action eq "BUILD") {
		# on lit la valeur par defaut qui doit etre selectionne
		# dans var-forms (la deuxieme valeur ne sert a rien excepte
		# pour le format de lecture
		print "$`$1 $2$3$4 CHECKED$'" if ($3 eq $valueforms{$field});
		print "$`$1 $2$3$4$'" if ($3 ne $valueforms{$field});
	    }			
	}

	### TEXT

	$line =~ s/ SIZE="?(\d+)"?//i;
	
	if ($line =~ /("text").*(VALUE=")(")/i) {
	    
	    $size = "";

	    if ($action eq "MODIFY") {
		$size1 = length($oldvalue{$field});
		$size = "SIZE=\"$size1\"" if ($size1 != 0);
		print "$`$1 $2$oldvalue{$field}$3 $size$'";
	    }
	    
	    if ($action eq "BUILD") {
		if ($field eq "pathinit") {
		    $size1 = length($w3perlpath);
		} elsif ($field eq "FLY") {
		    $size1 = length($flypath);
		} elsif ($field eq "prefixlog") {
		    $size1 = 2 if ($FORM{'server_used'} == 4);
		} else {
		    $size1 = length($valueforms{$field});
		}

		$size = "SIZE=\"$size1\"" if ($size1 != 0);

		if ($field eq "pathinit") {
		    print "$`$1 $2$w3perlpath$3 $size$'";
		} elsif ($field eq "FLY") {
		    print "$`$1 $2$flypath$3 $size$'";
		} elsif ($field eq "prefixlog") {
		    if ($FORM{'server_used'} == 4) {
			print "$`$1 $2in$3 $size$'" if ($FORM{'logfile'} eq "Microsoft");
			print "$`$1 $2ex$3 $size$'" if ($FORM{'logfile'} eq "W3C");
			print "$`$1 $2nc$3 $size$'" if ($FORM{'logfile'} eq "CLF");
		    } else {
			print "$`$1 $2$3 $size$'";
		    }
		} else {
		    print "$`$1 $2$valueforms{$field}$3 $size$'";
		}
	    }
	    
#	    if ($action eq "BUILD" && $field eq "pathinit") {

#		$size = "SIZE=\"$size1\"" if ($size1 != 0);

#	    }
	    
	}

	### CHECKBOX
					
	if ($line =~ /("checkbox").*(VALUE=")([0-9]+)(")/i) {
	    if ($action eq "MODIFY") {
		print "$`$1 $2$3$4 CHECKED$'" if ($3 eq $oldvalue{$field}); 
		print "$`$1 $2$3$4$'" if ($3 ne $oldvalue{$field}); 			
	    }
	    
	    if ($action eq "BUILD") {
		# on lit la valeur par defaut (1 = CHECKED)
		# dans var-forms (la deuxieme valeur ne sert a rien excepte
		# pour le format de lecture
		print "$`$1 $2$3$4 CHECKED$'" if ($3 eq $valueforms{$field});
		print "$`$1 $2$3$4$'" if ($3 ne $valueforms{$field});				
	    }				
	}			
#			print "<!-- $field - $1 - $2 - $3 - $oldvalue{$field} -->\n";
	return 1;
    }
	
	return $out;
    }

#######################################################################

sub load {
  local($file) = @_;
  local($tmp1,$tmp2);
  
        &error_open($file) if (!(-r $file));
	open(FILE,$file) || die "Can't open $file\n";
	while(<FILE>) {
	chop;
	($tmp1,$tmp2) = split(/\t/);
	$oldvalue{$tmp1} = $tmp2;
	}
	close(FILE);
}

sub securecgi {
  local($file) = @_;
  local($tmp1,$tmp2);

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

##################
# Errors report  #
##################

sub error_open {
    local($file) = @_;

    print "<P><DIR><FONT COLOR=\"#AA2020\">" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print "Unable to open $file : $!\n";
    print "</FONT><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print " ==> check read permission\n";
    print "</DIR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    exit;
}


sub error_write {
    local($file) = @_;

    print "<P><DIR><FONT COLOR=\"#AA2020\">" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print "Unable to write $file : $!\n";
    print "</FONT><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print " ==> check write permission\n";
    print "</DIR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    exit;
}

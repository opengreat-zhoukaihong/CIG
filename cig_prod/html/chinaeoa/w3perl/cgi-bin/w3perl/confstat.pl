#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                    CGI-BIN CONFIG STATS                        #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@w3perl.com                   version 20/08/2000     #####
####                                                                #####
#########################################################################

### To do : upgrade script (IN PROGRESS)
###         checking each fields

# Print out a content-type for HTTP/1.0 compatibility
print "Content-type: text/html\n\n";

require "init.pl";

#########################################################################
###                            UPGRADE                                ###
#########################################################################

if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'QUERY_STRING'} =~ /UPGRADE/) {

    &securecgi if ($ENV{'HTTP_REFERER'} !~ /admin/);

print "<HTML><HEAD><TITLE>Installation</TITLE></HEAD>\n";
print "<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\">\n";
print "<P><BR><H3><CENTER>";
print "Updating configuration scripts\n";
print "</H3><P></CENTER><BR>";


$param = $ENV{'QUERY_STRING'};

@in = split(/[&;]/,$param);
  
foreach $i (0 .. $#in) {
    # Convert plus's to spaces
    $in[$i] =~ s/\+/ /g;

    # Split into key and value.
    ($key, $val) = split(/=/,$in[$i],2); # splits on the first =.

    # Convert %XX from hex numbers to alphanumeric
    $key =~ s/%(..)/pack("c",hex($1))/ge;
    $val =~ s/%(..)/pack("c",hex($1))/ge;

    # Associate key and value
    $FORM{$key} .= "\0" if (defined($in{$key})); # \0 is the multiple separator
    $FORM{$key} .= $val;
}  

if (!(-f $w3perlloc)) {
    $msg = "You should first create one configuration file before running the script !";
    &error($msg);
    exit;
}

&error_open($w3perlloc) if (!(-r $w3perlloc));
if (-f $w3perlloc) {
    open(CONFLOC,"$w3perlloc"); # || die "Can't open $w3perlloc\n";
    @oldlines = (<CONFLOC>);
    close(CONFLOC);
}

#foreach $tmp (@oldlines) {
#    ($tmp1,$tmp2) = split(/\t/,$tmp);
#    $tab_oldlines{$tmp1} = $tmp2;
#}

$ok = 0;
$file_upgrade = $w3perlpath.$dirress.$dirsep."upgrade";
&error_open($file_upgrade) if (!(-r $file_upgrade));
open(FILE,"$file_upgrade");
while (<FILE>) {
    if ($_ =~ /\[\d.\d\d\]/) {
	$ver_nb = $_ ;
	$ver_nb =~ s/\[//;
	$ver_nb =~ s/\]//;
	$ok = 1 if ($ver_nb < $FORM{'version'});
	$ok = 0 if ($ver_nb >= $FORM{'version'});
    }
    $bigver_nb = $ver_nb*100;
    $up[$bigver_nb] .= $_ if ($ok == 1);
#    print "A - $bigver_nb - $up[$bigver_nb]<BR>\n";
#    push(@uplines,$_) if ($ok == 1);
}
close(FILE);

print "<LI> In order to update the package from a previous release, ";
print "you will need to copy these directories over the previous one<BR>";
print "<UL>";
print "<LI> /resources/";
print "<LI> /docs/";
print "<LI> /cgi-bin/";
print "<LI> /admin/";
print "</UL><P>";


foreach $oldline (@oldlines) {

    ($file,$ver) = split(/\s+/,$oldline);

    if ($ver < $FORM{'version'}) {
	print "<B><I> > Updating $file </B> : $ver to $FORM{'version'}</I><BR>\n";

	open(FILE,">>$file");
	print FILE "\n";
	for ($i=($ver*100);$i<=($FORM{'version'}*100);$i++) {
	    print FILE "# What's new - $up[$i]\n" if ($up[$i] =~ /\[\d.\d\d\]/);
	    print FILE "$up[$i]\n" if ($up[$i] !~ /\[\d.\d\d\]/);
	}
	close(FILE);

	foreach $tmp (@oldlines) {
	    ($tmp1,$tmp2) = split(/\t/,$tmp);
	}

	print "<BR><FONT COLOR=\"#FF0000\">You should now move the file $file to $cgipath$dirsep</FONT><P>\n";
    }
}

print "<LI> Either run 'install.pl' script (telnet) or fixperlpath.pl (ftp)<P>\n";
open(CONFLOC,">$w3perlloc");
foreach $tmp (@oldlines) {
    ($tmp1,$tmp2) = split(/\t/,$tmp);
    print CONFLOC "$tmp1\t$FORM{'version'}\n";
}
close(CONFLOC);

exit;
}



#########################################################################
###                            LAUNCH                                 ###
#########################################################################

if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'QUERY_STRING'} =~ /LAUNCH/) {

	&securecgi if ($ENV{'HTTP_REFERER'} !~ /admin/);

$param = $ENV{'QUERY_STRING'};

@in = split(/[&;]/,$param);
  
foreach $i (0 .. $#in) {
    # Convert plus's to spaces
    $in[$i] =~ s/\+/ /g;

    # Split into key and value.
    ($key, $val) = split(/=/,$in[$i],2); # splits on the first =.

    # Convert %XX from hex numbers to alphanumeric
    $key =~ s/%(..)/pack("c",hex($1))/ge;
    $val =~ s/%(..)/pack("c",hex($1))/ge;

    # Associate key and value
    $FORM{$key} .= "\0" if (defined($in{$key})); # \0 is the multiple separator
    $FORM{$key} .= $val;
}  

if (!(-f $w3perlloc)) {
    $msg = "You should first create one configuration file before running the script !";
    &error($msg);
    exit;
}

&error_open($w3perlloc) if (!(-r $w3perlloc));
if (-f $w3perlloc) {
    open(CONFLOC,"$w3perlloc"); # || die "Can't open $w3perlloc\n";
    @oldlines = (<CONFLOC>);
    close(CONFLOC);
}

foreach $oldline (@oldlines) {
    ($tmp) = split(/\t/,$oldline);
    $pos = rindex($tmp,$dirsep);
    $tmp = substr($tmp,$pos,length($tmp));
    $tmp = $cgipath.$tmp;
    push(@lines,$tmp);
}

$file = $basefilename."10".$htmlext;
$comment = 0;
&error_open($file) if (!(-r $file));
open(FILE,$file);
while (<FILE>) {
    $comment = 1 if (/<!-- DISPLAY -->/i);
    $comment = 2 if (/<!-- HIDDEN -->/i);
    $comment = 3 if (/<!-- STOP_BEGIN -->/i && $err_flag == ($#lines+1));
    $comment = 0 if (/<!-- STOP_END -->/i && $err_flag == ($#lines+1));

    if ($comment == 1) {
	for ($i=0;$i<=$#lines;$i++) {
	    print "<OPTION>$lines[$i]\n";
	    if (!(-f $lines[$i])) {
		$err_flag++;
		$pos = rindex($lines[$i],$dirsep);
		$tmp = substr($lines[$i],$pos,length($lines[$i]));
		$string_err .= "<B>Warning</B> :";
		$string_err .= "<P>File : $lines[$i] not found !<BR>";
		$string_err .= "Move <I>$w3perlpath$dirconfig$tmp</I> to <I>$lines[$i]</I><P>";
	    }
	}
	$comment = 0;
    }

    if ($comment == 2) {
	print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
	print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";
	$comment = 0;
    }

    if ($comment == 0) {
	s/<!-- HELP -->/$helpurl/;
	s/<!-- BG -->/$bkg/;
	s/<!-- LINE -->/$bkgline/;
	s/<!-- WARNING -->/$string_err/;
	s/<!-- cgiurl -->/$cgiurl/;
	print;
    }
    
}

#if ($err_found == 1) {
#    for ($i=0;$i<=$#err;$i++) {
#	$string_err .= "Warning : file $err[$i] not found\n";
#    }
#}


close(FILE);
exit;

}

#########################################################################
###                            MODIFY                                 ###
#########################################################################

if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'QUERY_STRING'} =~ /MODIFY/) {

    &securecgi if ($ENV{'HTTP_REFERER'} !~ /admin/);

$param = $ENV{'QUERY_STRING'};

@in = split(/[&;]/,$param);
  
foreach $i (0 .. $#in) {
    # Convert plus's to spaces
    $in[$i] =~ s/\+/ /g;

    # Split into key and value.
    ($key, $val) = split(/=/,$in[$i],2); # splits on the first =.

    # Convert %XX from hex numbers to alphanumeric
    $key =~ s/%(..)/pack("c",hex($1))/ge;
    $val =~ s/%(..)/pack("c",hex($1))/ge;

    # Associate key and value
    $FORM{$key} .= "\0" if (defined($in{$key})); # \0 is the multiple separator
    $FORM{$key} .= $val;
}  
    
#($name,$value) = split(/=/,$param);
#$FORM{$name} = $value;

if (!(-f $w3perlloc)) {
    $msg = "You should first create one configuration file before modify it !";
    &error($msg);
    exit;
}

&error_open($w3perlloc) if (!(-r $w3perlloc));
if (-f $w3perlloc) {
    open(CONFLOC,"$w3perlloc"); # || die "Can't open $w3perlloc\n";
    @oldlines = (<CONFLOC>);
    close(CONFLOC);
}

foreach $oldline (@oldlines) {
    ($tmp) = split(/\t/,$oldline);
    push(@lines,$tmp);
}

$file = $basefilename."0".$htmlext;
$comment = 0;
&error_open($file) if (!(-r $file));
open(FILE,$file);
while (<FILE>) {
    $comment = 1 if (/<!-- DISPLAY -->/i);
    $comment = 2 if (/<!-- HIDDEN -->/i);

    if ($comment == 1) {
	for ($i=0;$i<=$#lines;$i++) {
	    print "<OPTION>$lines[$i]\n";
	}
	$comment = 0;
    }

    if ($comment == 2) {
	print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
	print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";
	$comment = 0;
    }
    
    if ($comment == 0) {
	s/<!-- HELP -->/$helpurl/;
	s/<!-- BG -->/$bkg/;
	s/<!-- LINE -->/$bkgline/;
	s/<!-- cgiurl -->/$cgiurl/;
	print;
    }


}

close(FILE);
exit;

}

#########################################################################
###                            DELETE                                 ###
#########################################################################

if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'QUERY_STRING'} =~ /DELETE/) {

    &securecgi if ($ENV{'HTTP_REFERER'} !~ /admin/);

$param = $ENV{'QUERY_STRING'};

@in = split(/[&;]/,$param);
  
foreach $i (0 .. $#in) {
    # Convert plus's to spaces
    $in[$i] =~ s/\+/ /g;

    # Split into key and value.
    ($key, $val) = split(/=/,$in[$i],2); # splits on the first =.

    # Convert %XX from hex numbers to alphanumeric
    $key =~ s/%(..)/pack("c",hex($1))/ge;
    $val =~ s/%(..)/pack("c",hex($1))/ge;

    # Associate key and value
    $FORM{$key} .= "\0" if (defined($in{$key})); # \0 is the multiple separator
    $FORM{$key} .= $val;
}  
  
#($name,$value) = split(/=/,$param);
#$FORM{$name} = $value;

if (!(-f $w3perlloc)) {
    $msg = "You should first create one configuration file before deleting it !";
    &error($msg);
    exit;
}

&error_open($w3perlloc) if (!(-r $w3perlloc));
if (-f $w3perlloc) {
    open(CONFLOC,"$w3perlloc"); # || die "can't open $w3perlloc\n";
    @oldlines = (<CONFLOC>);
    close(CONFLOC);
}

foreach $oldline (@oldlines) {
    ($tmp) = split(/\t/,$oldline);
    push(@lines,$tmp);
}

$file = $basefilename."9".$htmlext;
$comment = 0;
&error_open($file) if (!(-r $file));
open(FILE,$file);
while (<FILE>) {
    s/<!-- HELP -->/$helpurl/;
    s/<!-- BG -->/$bkg/;
    s/<!-- LINE -->/$bkgline/;
    s/<!-- cgiurl -->/$cgiurl/;
    $comment = 1 if (/<!-- DISPLAY -->/i);
    $comment = 2 if (/<!-- HIDDEN -->/i);

    if ($comment == 0) {
	print;
    }

    if ($comment == 1) {
	for ($i=0;$i<=$#lines;$i++) {
	    print "<OPTION>$lines[$i]\n";
	}
	$comment = 0;
    }

    if ($comment == 2) {
	print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
	$comment = 0;
    }

}

close(FILE);
exit;

}

#########################################################################
###                            MAKE                                   ###
#########################################################################

#if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'QUERY_STRING'} =~ /BUILD/) {
#&securecgi if ($ENV{'QUERY_STRING'} !~ /=/);

# Get the input
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

# Split the name-value pairs
@pairs = split(/&/, $buffer);

foreach $pair (@pairs) {

    ($name, $value) = split(/=/, $pair);

    # Un-Webify plus signs and %-encoding
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

    # Stop people from using subshells to execute commands
    # Not a big deal when using sendmail, but very important
    # when using UCB mail (aka mailx).
    # $value =~ s/~!/ ~!/g; 

    # Uncomment for debugging purposes
#    print "Setting $name to $value<P>";
	
    $FORM{$name} = $value;
}

#$FORM{'configfile'} =~ s/\..*//;
$step = $FORM{'step'};
&loadvar($varforms);

if ($FORM{'action'} eq "MODIFY" && $step > 0) {
    $prefile = $FORM{'prefile'};
#$conftmp =  $FORM{'configfile'};
#    $FORM{'configfile'} =~ s/$FORM{'plext'}//;
#$loadconf = $prefile.$dirdata.$dirsep.$FORM{'configfile'};
    $loadconf = $w3perlpathres.$dirsep.$FORM{'configfile'};
    &load($loadconf);
}

&securecgi if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'HTTP_REFERER'} !~ /admin/);

if ($step == 0) {
    $nextstep = $step+1;
    
    if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'QUERY_STRING'} =~ /BUILD/) {
	$param = $ENV{'QUERY_STRING'};

#	&securecgi if ($ENV{'HTTP_REFERER'} !~ /admin/);

	@in = split(/[&;]/,$param);
  
	foreach $i (0 .. $#in) {
	    # Convert plus's to spaces
	    $in[$i] =~ s/\+/ /g;
	    
	    # Split into key and value.
	    ($key, $val) = split(/=/,$in[$i],2); # splits on the first =.
	    
	    # Convert %XX from hex numbers to alphanumeric
	    $key =~ s/%(..)/pack("c",hex($1))/ge;
	    $val =~ s/%(..)/pack("c",hex($1))/ge;
	    
	    # Associate key and value
	    $FORM{$key} .= "\0" if (defined($in{$key})); # \0 is the multiple separator
	    $FORM{$key} .= $val;
	}  
	
#($name,$value) = split(/=/,$param);
#$FORM{$name} = $value;

    }


#&securecgi if ($ENV{'QUERY_STRING'} =~ /BUILD/ && $param eq '');

    $filename = $basefilename.$nextstep.$htmlext; 
    $pos = rindex($FORM{'configfile'},$dirsep);
    $prefile = substr($FORM{'configfile'},0,$pos+1);
    $FORM{'configfile'} = substr($FORM{'configfile'},$pos+1,length($FORM{'configfile'}));
#$loadconf = $prefile.$dirsep.$FORM{'configfile'};
    $loadconf = $prefile.$FORM{'configfile'};
    if ($FORM{'action'} eq "MODIFY") {
	$pos = rindex($FORM{'configfile'},'.');
	$FORM{'configfile'} = substr($FORM{'configfile'},0,$pos);
	$loadconf = $w3perlpathres.$dirsep.$FORM{'configfile'};
	&load($loadconf);
    }

    &error_open($filename) if (!(-r $filename));
    open(IN,"$filename"); # || die "can't open $filename\n";
    while (<IN>) {
	s/<!-- HELP -->/$helpurl/;
	s/<!-- BG -->/$bkg/;
	s/<!-- LINE -->/$bkgline/;
	s/<!-- cgiurl -->/$cgiurl/;
	$out2 = 0;
	# HIDDEN to print
	if (/<!-- HIDDEN -->/) {
	    print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";
	    print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
	    print "<INPUT NAME=loadconf TYPE=hidden VALUE=\"$loadconf\">\n";
	    print "<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">\n";
	    print "<INPUT NAME=prefile TYPE=hidden VALUE=\"$prefile\">\n";
	}


#	print "- $aaa - $bbb - $pos - @INC - <P>\n";
	$out = 1 if (/<!-- BEGIN MODIFY -->/ && $FORM{'action'} eq "MODIFY");
	$out2 = &option($_,$out2,$FORM{'action'}) if ($out == 0);
	
	print if ($out2 == 0 && $out == 0);
	$out = 0 if (/<!-- END MODIFY -->/ && $FORM{'action'} eq "MODIFY");

	
#	if (/<SELECT NAME="(\w+)"/ && $out == 0) {
#	for ($i=1;$i<=$nbvalueforms{$1};$i++) {
#        print "<OPTION VALUE=\"$valueforms2{$1,$i}\" ";
#	print "SELECTED" if ($valueforms2{$1,$i} == $oldvalue{$1});
#        print ">$valueforms1{$1,$i}\n";
#        }
#	}

    }
close(IN);
}


if ($step == 1) {

#&securecgi if ($ENV{'HTTP_REFERER'} !~ /$cgiurl/);

# on recupere 2 champs

    $tmp1 = $FORM{'type_serveur'};
#    $tmp2 = $FORM{'server_used'};

#$type_serveur = 0 if ($tmp1 == 0 || $tmp1 == 2 || $tmp1 == 3);
#$type_serveur = 1 if ($tmp1 == 1);

#$dirsep = "/" if ($tmp1 == 0);
#$dirsep = "\\" if ($tmp1 == 1);
#$dirsep = "." if ($tmp1 == 2);
#$dirsep = ":" if ($tmp1 == 3);

# check coherence
# if Unix and IIS
# if Acorn and not others

    $nextstep = $step+1;
    $filename = $basefilename.$nextstep.$htmlext; 

    &error_open($filename) if (!(-r $filename));
    open(IN,"$filename"); # || die "can't open $filename\n";
    while (<IN>) {
	$out = 0;
	s/<!-- HELP -->/$helpurl/;
	s/<!-- BG -->/$bkg/;
	s/<!-- LINE -->/$bkgline/;
	s/<!-- cgiurl -->/$cgiurl/;
	# HIDDEN to print (saving 2 fields)
	if (/<!-- HIDDEN -->/) {
	    print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";		
	    print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
	    print "<INPUT NAME=loadconf TYPE=hidden VALUE=\"$loadconf\">\n";
	    print "<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">\n";
	    print "<INPUT NAME=prefile TYPE=hidden VALUE=\"$FORM{'prefile'}\">\n";
	    print "<INPUT NAME=type_serveur TYPE=hidden VALUE=\"$FORM{'type_serveur'}\">\n";
	    print "<INPUT NAME=server_used TYPE=hidden VALUE=\"$FORM{'server_used'}\">\n";
	}		

		# HTML extension
	if (/NAME=\"htmlext\"/) {
	    $out = 1;
	    print ;
	    print "<OPTION$selected>.html" if ($tmp1 == 0 || $tmp1 == 1 || $tmp1 == 3);
	    print "<OPTION>.htm" if ($tmp1 == 1);
	    print "<OPTION>/html" if ($tmp1 == 2);
	    print "<OPTION>&lt;none&gt;" if ($tmp1 == 3);
	    print "<OPTION$selected>&lt;none&gt;" if ($tmp1 == 2);			
	}
	
	# GIF extension
	if (/NAME=\"gifext\"/) {
	    $out = 1;
	    print ;
	    print "<OPTION$selected>.gif" if ($tmp1 == 0 || $tmp1 == 1 || $tmp1 == 3);
	    print "<OPTION>/gif" if ($tmp1 == 2);
	    print "<OPTION>&lt;none&gt;" if ($tmp1 == 3);
	    print "<OPTION$selected>&lt;none&gt;" if ($tmp1 == 2);			
	}
	
	# PERL extension
	if (/NAME=\"plext\"/) {
	    $out = 1;
	    print ;
	    print "<OPTION$selected>.pl" if ($tmp1 == 0 || $tmp1 == 1 || $tmp1 == 3);
	    print "<OPTION>/pl" if ($tmp1 == 2);
	    print "<OPTION>&lt;none&gt;" if ($tmp1 == 3);
	    print "<OPTION$selected>&lt;none&gt;" if ($tmp1 == 2);			
	}		
	
	$out = &option($_,$out,$FORM{'action'});
	print if ($out == 0);
	
    }
close(IN);
}

#
### level 2
#

if ($step == 2) {

# on recupere 2 + 5 champs

$tmp1 = $FORM{'type_serveur'};
#$tmp2 = $FORM{'server_used'};
$tmp3 = $FORM{'htmlext'};
$tmp4 = $FORM{'gifext'};
$tmp5 = $FORM{'plext'};
$tmp6 = $FORM{'extension'};
$tmp7 = $FORM{'extensionimage'};

$FORM{'htmlext'} = '' if ($FORM{'htmlext'} eq "<none>");
$FORM{'gifext'} = '' if ($FORM{'gifext'} eq "<none>");
$FORM{'plext'} = '' if ($FORM{'plext'} eq "<none>");

#$type_serveur = 0 if ($tmp1 == 0 || $tmp1 == 2 || $tmp1 == 3);
#$type_serveur = 1 if ($tmp1 == 1);

# copy du tableau

#for ($i=1;$i<=$nbvalueforms{$FORM{'logfile'}};$i++) {
#$val1{$i} = $valueforms1{$FORM{'logfile'},$i};
#$val2{$i} = $valueforms2{$FORM{'logfile'},$i};
#}
#$tmp8 = $nbvalueforms{$FORM{'logfile'};

# recherche des valeurs

#if ($FORM{'server_used'});

# ecriture dans le tableau

#$nbvalueforms{$FORM{'logfile'} = 0;

#for ($i=1;$i<=$tmp8};$i++) {
#$count++;
#$valueforms1{$FORM{'logfile'},$count} = 0; 
#$valueforms2{$FORM{'logfile'},$count} = 0;
#}
#$nbvalueforms{$FORM{'logfile'} = $count;
$out2 = 0;

$nextstep = $step+1;
$filename = $basefilename.$nextstep.$htmlext; 
&error_open($filename) if (!(-r $filename));
open(IN,"$filename"); # || die "can't open $filename\n";
	while (<IN>) {
		$out = 0;
		s/<!-- HELP -->/$helpurl/;
	        s/<!-- BG -->/$bkg/;
		s/<!-- LINE -->/$bkgline/;
		s/<!-- cgiurl -->/$cgiurl/;
		# HIDDEN to print
		if (/<!-- HIDDEN -->/) {
			print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";		
			print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
			print "<INPUT NAME=loadconf TYPE=hidden VALUE=\"$loadconf\">\n";
			print "<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">\n";
			print "<INPUT NAME=prefile TYPE=hidden VALUE=\"$FORM{'prefile'}\">\n";					
			print "<INPUT NAME=type_serveur TYPE=hidden VALUE=\"$FORM{'type_serveur'}\">\n";
			print "<INPUT NAME=server_used TYPE=hidden VALUE=\"$FORM{'server_used'}\">\n";		
			print "<INPUT NAME=htmlext TYPE=hidden VALUE=\"$FORM{'htmlext'}\">\n";
			print "<INPUT NAME=gifext TYPE=hidden VALUE=\"$FORM{'gifext'}\">\n";
			print "<INPUT NAME=plext TYPE=hidden VALUE=\"$FORM{'plext'}\">\n";
			print "<INPUT NAME=extension TYPE=hidden VALUE=\"$FORM{'extension'}\">\n";
			print "<INPUT NAME=extensionimage TYPE=hidden VALUE=\"$FORM{'extensionimage'}\">\n";
		}		
	$out2 = 1 if ($_ =~ /BEGIN_NTUSERS/ && $FORM{'type_serveur'} != 1);
	$out2 = 0 if ($_ =~ /END_NTUSERS/ && $FORM{'type_serveur'} != 1);	
		# Logfile used
#		if (/NAME="(\w+)"/) {
#			if ($1 eq "logfile") {
#			$out = 1;
#			print ;
#			$oldvalue{$1}
#			print "<OPTION$selected VALUE=\"CLF\">Common Log File (CLF)";
#			print "<OPTION VALUE=\"ECLF\">Extended Common Log File" if ($tmp2 == 0);
#			print "<OPTION VALUE=\"NECLF\">New Extended Common Log File" if ($tmp2 == 0);
#			print "<OPTION VALUE=\"IIS\">Standard IIS" if ($tmp2 == 4 || $tmp2 == 5);
#			}
#		}

	$out = &option($_,$out,$FORM{'action'}) if ($out2 == 0);
	print if ($out == 0 && $out2 == 0);
}
close(IN);
}


#
### level 3
#

if ($step == 3) {

# on recupere 2 + 5 + 3 champs

#$tmp1 = $FORM{'type_serveur'};
#$tmp2 = $FORM{'server_used'};
#$tmp3 = $FORM{'htmlext'};
#$tmp4 = $FORM{'gifext'};
#$tmp5 = $FORM{'plext'};
#$tmp6 = $FORM{'extension'};
#$tmp7 = $FORM{'extensionimage'};
#$tmp8 = $FORM{'logformat'};
#$tmp9 = $FORM{'logfile'};
#$tmp10 = $FORM{'stringlogfile'};
#$tmp11 = $FORM{'logfile_sep'};

#$type_serveur = 0 if ($tmp1 == 0 || $tmp1 == 2 || $tmp1 == 3);
#$type_serveur = 1 if ($tmp1 == 1);

#$extended = 1 if ($FORM{'logfile'} eq "ECLF" || $FORM{'logfile'} eq "NECLF" || $FORM{'logfile'} eq "IIS 3.0 patched" || $FORM{'logfile'} eq "IIS 4.0" || $FORM{'logfile'} eq "IIS 5.0");

$extended = 1 if ($FORM{'logfile'} eq "ECLF" || $FORM{'logfile'} eq "NECLF" || $FORM{'server_used'} == 4); # Pas de refer et agent file sous IIS

$extended = 1 if ($FORM{'stringlogfile'} =~ /\%refer/ || $FORM{'stringlogfile'} =~ /\%agent/);
#$error = 1 if ($FORM{'logfile'} =~ "IIS");
$error = 1 if ($FORM{'type_serveur'} == 1);
$extended = 1 if ($FORM{'type_serveur'} == 1);
$out2 = 0;
$out3 = 0;

$nextstep = $step+1;
$filename = $basefilename.$nextstep.$htmlext; 
&error_open($filename) if (!(-r $filename));
open(IN,"$filename"); # || die "can't open $filename\n";
	while (<IN>) {
		$out = 0;
		s/<!-- HELP -->/$helpurl/;
	        s/<!-- BG -->/$bkg/;
		s/<!-- LINE -->/$bkgline/;
		s/<!-- cgiurl -->/$cgiurl/;
		# HIDDEN to print
		if (/<!-- HIDDEN -->/) {
			print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";		
			print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
			print "<INPUT NAME=loadconf TYPE=hidden VALUE=\"$loadconf\">\n";
			print "<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">\n";
			print "<INPUT NAME=prefile TYPE=hidden VALUE=\"$FORM{'prefile'}\">\n";					
			print "<INPUT NAME=type_serveur TYPE=hidden VALUE=\"$FORM{'type_serveur'}\">\n";
			print "<INPUT NAME=server_used TYPE=hidden VALUE=\"$FORM{'server_used'}\">\n";		
			print "<INPUT NAME=htmlext TYPE=hidden VALUE=\"$FORM{'htmlext'}\">\n";
			print "<INPUT NAME=gifext TYPE=hidden VALUE=\"$FORM{'gifext'}\">\n";
			print "<INPUT NAME=plext TYPE=hidden VALUE=\"$FORM{'plext'}\">\n";
			print "<INPUT NAME=extension TYPE=hidden VALUE=\"$FORM{'extension'}\">\n";
			print "<INPUT NAME=extensionimage TYPE=hidden VALUE=\"$FORM{'extensionimage'}\">\n";			
			print "<INPUT NAME=logformat TYPE=hidden VALUE=\"$FORM{'logformat'}\">\n";
			print "<INPUT NAME=stringdateformat TYPE=hidden VALUE=\"$FORM{'stringdateformat'}\">\n";
			print "<INPUT NAME=logfile TYPE=hidden VALUE=\"$FORM{'logfile'}\">\n";
			print "<INPUT NAME=stringlogfile TYPE=hidden VALUE=\"$FORM{'stringlogfile'}\">\n";
			print "<INPUT NAME=virtualCLF TYPE=hidden VALUE=\"$FORM{'virtualCLF'}\">\n";
			print "<INPUT NAME=zip TYPE=hidden VALUE=\"$FORM{'zip'}\">\n";
			print "<INPUT NAME=struct_compressed_logfile TYPE=hidden VALUE=\"$FORM{'struct_compressed_logfile'}\">\n";
			print "<INPUT NAME=zipext TYPE=hidden VALUE=\"$FORM{'zipext'}\">\n";
			print "<INPUT NAME=GZIP TYPE=hidden VALUE=\"$FORM{'GZIP'}\">\n";			
		}		
	$out2 = 1 if ($_ =~ /BEGIN_EXTENDED/ && $extended == 1);
	$out2 = 0 if ($_ =~ /END_EXTENDED/ && $extended == 1);	
	$out3 = 1 if ($_ =~ /BEGIN_ERROR/ && $error == 1);
	$out3 = 0 if ($_ =~ /END_ERROR/ && $error == 1);		
	$out = &option($_,$out,$FORM{'action'}) if (($out2 == 0) && ($out3 == 0));
	print if (($out == 0) && ($out2 == 0) && ($out3 == 0));
	    }
close(IN);	
}


#
### level 4
#

if ($step == 4) {

# on recupere 2 + 5 + 3 + 9 champs

$tmp1 = $FORM{'type_serveur'};
#$tmp2 = $FORM{'server_used'};
#$tmp8 = $FORM{'logformat'};
#$tmp9 = $FORM{'logfile'};
#$tmp10 = $FORM{'stringlogfile'};

$nextstep = $step+1;
$filename = $basefilename.$nextstep.$htmlext;

### WARNING : detecter si $path+$configfile n'existe pas deja dans $locconf !!!!!
### si oui il faut utiliser modify instead of create

if ($FORM{'action'} eq "BUILD") {
$tmpa = $FORM{'pathinit'}.$dirconfig.$dirsep.$FORM{'configfile'}.$FORM{'plext'};

if (-f $w3perlloc) {
&error_open($w3perlloc) if (!(-r $w3perlloc));
open(CONFLOC,"$w3perlloc"); # || die "can't open $w3perlloc\n";
while (<CONFLOC>) {
($tmp) = split(/\t/);
$err = 1 if ($tmp eq $tmpa);
}
close(CONFLOC);
}

$msg = "There is already a configuration file with this name, use 'modify' to alter it or choose a different config filename\n" if ($err == 1);
&error($msg) if ($err == 1);
}

$virtual = 1 if ($FORM{'logfile'} eq "NECLF" || $FORM{'virtualCLF'} == 1);
$out2 = 0;

&error_open($filename) if (!(-r $filename));
open(IN,"$filename"); # || die "can't open $filename\n";
	while (<IN>) {
		$out = 0;
		s/<!-- HELP -->/$helpurl/;
	        s/<!-- BG -->/$bkg/;
		s/<!-- LINE -->/$bkgline/;
		s/<!-- cgiurl -->/$cgiurl/;
		# HIDDEN to print
		if (/<!-- HIDDEN -->/) {
			print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";		
			print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
			print "<INPUT NAME=loadconf TYPE=hidden VALUE=\"$loadconf\">\n";		
			print "<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">\n";
			print "<INPUT NAME=prefile TYPE=hidden VALUE=\"$FORM{'prefile'}\">\n";					
			print "<INPUT NAME=type_serveur TYPE=hidden VALUE=\"$FORM{'type_serveur'}\">\n";
			print "<INPUT NAME=server_used TYPE=hidden VALUE=\"$FORM{'server_used'}\">\n";		
			print "<INPUT NAME=htmlext TYPE=hidden VALUE=\"$FORM{'htmlext'}\">\n";
			print "<INPUT NAME=gifext TYPE=hidden VALUE=\"$FORM{'gifext'}\">\n";
			print "<INPUT NAME=plext TYPE=hidden VALUE=\"$FORM{'plext'}\">\n";
			print "<INPUT NAME=extension TYPE=hidden VALUE=\"$FORM{'extension'}\">\n";
			print "<INPUT NAME=extensionimage TYPE=hidden VALUE=\"$FORM{'extensionimage'}\">\n";			
			print "<INPUT NAME=logformat TYPE=hidden VALUE=\"$FORM{'logformat'}\">\n";
			print "<INPUT NAME=stringdateformat TYPE=hidden VALUE=\"$FORM{'stringdateformat'}\">\n";
			print "<INPUT NAME=logfile TYPE=hidden VALUE=\"$FORM{'logfile'}\">\n";
			print "<INPUT NAME=stringlogfile TYPE=hidden VALUE=\"$FORM{'stringlogfile'}\">\n";
			print "<INPUT NAME=virtualCLF TYPE=hidden VALUE=\"$FORM{'virtualCLF'}\">\n";			
			print "<INPUT NAME=zip TYPE=hidden VALUE=\"$FORM{'zip'}\">\n";
			print "<INPUT NAME=struct_compressed_logfile TYPE=hidden VALUE=\"$FORM{'struct_compressed_logfile'}\">\n";									
			print "<INPUT NAME=zipext TYPE=hidden VALUE=\"$FORM{'zipext'}\">\n";
#			print "<INPUT NAME=logfile_sep TYPE=hidden VALUE=\"$FORM{'logfile_sep'}\">\n";
			print "<INPUT NAME=path TYPE=hidden VALUE=\"$FORM{'path'}\">\n";
			print "<INPUT NAME=pathinit TYPE=hidden VALUE=\"$FORM{'pathinit'}\">\n";
#			print "<INPUT NAME=linkpathinit TYPE=hidden VALUE=\"$FORM{'linkpathinit'}\">\n";
			print "<INPUT NAME=pathserver TYPE=hidden VALUE=\"$FORM{'pathserver'}\">\n";
			print "<INPUT NAME=cgipath TYPE=hidden VALUE=\"$FORM{'cgipath'}\">\n";
			print "<INPUT NAME=fileroot TYPE=hidden VALUE=\"$FORM{'fileroot'}\">\n";
			print "<INPUT NAME=prefixlog TYPE=hidden VALUE=\"$FORM{'prefixlog'}\">\n";
			print "<INPUT NAME=refererlog TYPE=hidden VALUE=\"$FORM{'refererlog'}\">\n";
			print "<INPUT NAME=agentlog TYPE=hidden VALUE=\"$FORM{'agentlog'}\">\n";
			print "<INPUT NAME=errorlog TYPE=hidden VALUE=\"$FORM{'errorlog'}\">\n";
			print "<INPUT NAME=GZIP TYPE=hidden VALUE=\"$FORM{'GZIP'}\">\n";
			print "<INPUT NAME=FLY TYPE=hidden VALUE=\"$FORM{'FLY'}\">\n";
		}

	$out2 = 1 if ($_ =~ /BEGIN_VIRTUAL/ && $virtual != 1);
	$out2 = 0 if ($_ =~ /END_VIRTUAL/ && $virtual != 1);	
	$out = &option($_,$out,$FORM{'action'}) if ($out2 == 0);
	print if ($out == 0 && $out2 == 0);
	}
close(IN);	
}					


#
### level 5
#

if ($step == 5) {

# on recupere 2 + 5 + 3 + 9 + 8 champs

$nextstep = $step+1;
$filename = $basefilename.$nextstep.$htmlext; 
&error_open($filename) if (!(-r $filename));
open(IN,"$filename"); # || die "can't open $filename\n";
	while (<IN>) {
		$out = 0;
		s/<!-- HELP -->/$helpurl/;
	        s/<!-- BG -->/$bkg/;
		s/<!-- LINE -->/$bkgline/;
		s/<!-- cgiurl -->/$cgiurl/;
		# HIDDEN to print
		if (/<!-- HIDDEN -->/) {
			print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";		
			print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
			print "<INPUT NAME=loadconf TYPE=hidden VALUE=\"$loadconf\">\n";		
			print "<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">\n";
			print "<INPUT NAME=prefile TYPE=hidden VALUE=\"$FORM{'prefile'}\">\n";					
			print "<INPUT NAME=type_serveur TYPE=hidden VALUE=\"$FORM{'type_serveur'}\">\n";
			print "<INPUT NAME=server_used TYPE=hidden VALUE=\"$FORM{'server_used'}\">\n";		
			print "<INPUT NAME=htmlext TYPE=hidden VALUE=\"$FORM{'htmlext'}\">\n";
			print "<INPUT NAME=gifext TYPE=hidden VALUE=\"$FORM{'gifext'}\">\n";
			print "<INPUT NAME=plext TYPE=hidden VALUE=\"$FORM{'plext'}\">\n";
			print "<INPUT NAME=extension TYPE=hidden VALUE=\"$FORM{'extension'}\">\n";
			print "<INPUT NAME=extensionimage TYPE=hidden VALUE=\"$FORM{'extensionimage'}\">\n";			
			print "<INPUT NAME=logformat TYPE=hidden VALUE=\"$FORM{'logformat'}\">\n";
			print "<INPUT NAME=stringdateformat TYPE=hidden VALUE=\"$FORM{'stringdateformat'}\">\n";
			print "<INPUT NAME=logfile TYPE=hidden VALUE=\"$FORM{'logfile'}\">\n";
			print "<INPUT NAME=stringlogfile TYPE=hidden VALUE=\"$FORM{'stringlogfile'}\">\n";
			print "<INPUT NAME=virtualCLF TYPE=hidden VALUE=\"$FORM{'virtualCLF'}\">\n";			
			print "<INPUT NAME=zip TYPE=hidden VALUE=\"$FORM{'zip'}\">\n";
			print "<INPUT NAME=struct_compressed_logfile TYPE=hidden VALUE=\"$FORM{'struct_compressed_logfile'}\">\n";									
			print "<INPUT NAME=zipext TYPE=hidden VALUE=\"$FORM{'zipext'}\">\n";
#			print "<INPUT NAME=logfile_sep TYPE=hidden VALUE=\"$FORM{'logfile_sep'}\">\n";
			print "<INPUT NAME=path TYPE=hidden VALUE=\"$FORM{'path'}\">\n";
			print "<INPUT NAME=pathinit TYPE=hidden VALUE=\"$FORM{'pathinit'}\">\n";
#			print "<INPUT NAME=linkpathinit TYPE=hidden VALUE=\"$FORM{'linkpathinit'}\">\n";
			print "<INPUT NAME=pathserver TYPE=hidden VALUE=\"$FORM{'pathserver'}\">\n";
			print "<INPUT NAME=cgipath TYPE=hidden VALUE=\"$FORM{'cgipath'}\">\n";
			print "<INPUT NAME=fileroot TYPE=hidden VALUE=\"$FORM{'fileroot'}\">\n";
			print "<INPUT NAME=prefixlog TYPE=hidden VALUE=\"$FORM{'prefixlog'}\">\n";
			print "<INPUT NAME=refererlog TYPE=hidden VALUE=\"$FORM{'refererlog'}\">\n";
			print "<INPUT NAME=agentlog TYPE=hidden VALUE=\"$FORM{'agentlog'}\">\n";
			print "<INPUT NAME=errorlog TYPE=hidden VALUE=\"$FORM{'errorlog'}\">\n";
			print "<INPUT NAME=GZIP TYPE=hidden VALUE=\"$FORM{'GZIP'}\">\n";
			print "<INPUT NAME=FLY TYPE=hidden VALUE=\"$FORM{'FLY'}\">\n";
			print "<INPUT NAME=localserver TYPE=hidden VALUE=\"$FORM{'localserver'}\">\n";
			print "<INPUT NAME=localdomaine TYPE=hidden VALUE=\"$FORM{'localdomaine'}\">\n";
			print "<INPUT NAME=emailadr TYPE=hidden VALUE=\"$FORM{'emailadr'}\">\n";
			print "<INPUT NAME=exclude_frame TYPE=hidden VALUE=\"$FORM{'exclude_frame'}\">\n";
			print "<INPUT NAME=exclude_robot TYPE=hidden VALUE=\"$FORM{'exclude_robot'}\">\n";
			print "<INPUT NAME=tri TYPE=hidden VALUE=\"$FORM{'tri'}\">\n";
			print "<INPUT NAME=country_filtering TYPE=hidden VALUE=\"$FORM{'country_filtering'}\">\n";
			print "<INPUT NAME=nolog TYPE=hidden VALUE=\"$FORM{'nolog'}\">\n";
			print "<INPUT NAME=selection TYPE=hidden VALUE=\"$FORM{'selection'}\">\n";
			print "<INPUT NAME=selecrepert TYPE=hidden VALUE=\"$FORM{'selecrepert'}\">\n";
			print "<INPUT NAME=excluderepert TYPE=hidden VALUE=\"$FORM{'excluderepert'}\">\n";
			print "<INPUT NAME=virtualfilter TYPE=hidden VALUE=\"$FORM{'virtualfilter'}\">\n";
			print "<INPUT NAME=excludevirtual TYPE=hidden VALUE=\"$FORM{'excludevirtual'}\">\n";
		}

	$out = &option($_,$out,$FORM{'action'});
	print if ($out == 0);
	}
close(IN);	
}					

#
### level 6
#

if ($step == 6) {

# on recupere 2 + 5 + 3 + 9 + 8 + 8 champs

$nextstep = $step+1;
$filename = $basefilename.$nextstep.$htmlext; 
&error_open($filename) if (!(-r $filename));
open(IN,"$filename"); # || die "can't open $filename\n";
	while (<IN>) {
		$out = 0;
		s/<!-- HELP -->/$helpurl/;
	        s/<!-- BG -->/$bkg/;
		s/<!-- LINE -->/$bkgline/;
		s/<!-- cgiurl -->/$cgiurl/;
		# HIDDEN to print
		if (/<!-- HIDDEN -->/) {
			print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";		
			print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
			print "<INPUT NAME=loadconf TYPE=hidden VALUE=\"$loadconf\">\n";		
			print "<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">\n";
			print "<INPUT NAME=prefile TYPE=hidden VALUE=\"$FORM{'prefile'}\">\n";					
			print "<INPUT NAME=type_serveur TYPE=hidden VALUE=\"$FORM{'type_serveur'}\">\n";
			print "<INPUT NAME=server_used TYPE=hidden VALUE=\"$FORM{'server_used'}\">\n";		
			print "<INPUT NAME=htmlext TYPE=hidden VALUE=\"$FORM{'htmlext'}\">\n";
			print "<INPUT NAME=gifext TYPE=hidden VALUE=\"$FORM{'gifext'}\">\n";
			print "<INPUT NAME=plext TYPE=hidden VALUE=\"$FORM{'plext'}\">\n";
			print "<INPUT NAME=extension TYPE=hidden VALUE=\"$FORM{'extension'}\">\n";
			print "<INPUT NAME=extensionimage TYPE=hidden VALUE=\"$FORM{'extensionimage'}\">\n";			
			print "<INPUT NAME=logformat TYPE=hidden VALUE=\"$FORM{'logformat'}\">\n";
			print "<INPUT NAME=stringdateformat TYPE=hidden VALUE=\"$FORM{'stringdateformat'}\">\n";
			print "<INPUT NAME=logfile TYPE=hidden VALUE=\"$FORM{'logfile'}\">\n";
			print "<INPUT NAME=stringlogfile TYPE=hidden VALUE=\"$FORM{'stringlogfile'}\">\n";
			print "<INPUT NAME=virtualCLF TYPE=hidden VALUE=\"$FORM{'virtualCLF'}\">\n";			
			print "<INPUT NAME=zip TYPE=hidden VALUE=\"$FORM{'zip'}\">\n";
			print "<INPUT NAME=struct_compressed_logfile TYPE=hidden VALUE=\"$FORM{'struct_compressed_logfile'}\">\n";									
			print "<INPUT NAME=zipext TYPE=hidden VALUE=\"$FORM{'zipext'}\">\n";
#			print "<INPUT NAME=logfile_sep TYPE=hidden VALUE=\"$FORM{'logfile_sep'}\">\n";
			print "<INPUT NAME=path TYPE=hidden VALUE=\"$FORM{'path'}\">\n";
			print "<INPUT NAME=pathinit TYPE=hidden VALUE=\"$FORM{'pathinit'}\">\n";
#			print "<INPUT NAME=linkpathinit TYPE=hidden VALUE=\"$FORM{'linkpathinit'}\">\n";
			print "<INPUT NAME=pathserver TYPE=hidden VALUE=\"$FORM{'pathserver'}\">\n";
			print "<INPUT NAME=cgipath TYPE=hidden VALUE=\"$FORM{'cgipath'}\">\n";
			print "<INPUT NAME=fileroot TYPE=hidden VALUE=\"$FORM{'fileroot'}\">\n";
			print "<INPUT NAME=prefixlog TYPE=hidden VALUE=\"$FORM{'prefixlog'}\">\n";
			print "<INPUT NAME=refererlog TYPE=hidden VALUE=\"$FORM{'refererlog'}\">\n";
			print "<INPUT NAME=agentlog TYPE=hidden VALUE=\"$FORM{'agentlog'}\">\n";
			print "<INPUT NAME=errorlog TYPE=hidden VALUE=\"$FORM{'errorlog'}\">\n";
			print "<INPUT NAME=GZIP TYPE=hidden VALUE=\"$FORM{'GZIP'}\">\n";
			print "<INPUT NAME=FLY TYPE=hidden VALUE=\"$FORM{'FLY'}\">\n";
			print "<INPUT NAME=localserver TYPE=hidden VALUE=\"$FORM{'localserver'}\">\n";
			print "<INPUT NAME=localdomaine TYPE=hidden VALUE=\"$FORM{'localdomaine'}\">\n";
			print "<INPUT NAME=emailadr TYPE=hidden VALUE=\"$FORM{'emailadr'}\">\n";
			print "<INPUT NAME=exclude_frame TYPE=hidden VALUE=\"$FORM{'exclude_frame'}\">\n";
			print "<INPUT NAME=exclude_robot TYPE=hidden VALUE=\"$FORM{'exclude_robot'}\">\n";
			print "<INPUT NAME=tri TYPE=hidden VALUE=\"$FORM{'tri'}\">\n";
			print "<INPUT NAME=country_filtering TYPE=hidden VALUE=\"$FORM{'country_filtering'}\">\n";
			print "<INPUT NAME=nolog TYPE=hidden VALUE=\"$FORM{'nolog'}\">\n";
			print "<INPUT NAME=selection TYPE=hidden VALUE=\"$FORM{'selection'}\">\n";
			print "<INPUT NAME=selecrepert TYPE=hidden VALUE=\"$FORM{'selecrepert'}\">\n";
			print "<INPUT NAME=excluderepert TYPE=hidden VALUE=\"$FORM{'excluderepert'}\">\n";
			print "<INPUT NAME=virtualfilter TYPE=hidden VALUE=\"$FORM{'virtualfilter'}\">\n";
			print "<INPUT NAME=excludevirtual TYPE=hidden VALUE=\"$FORM{'excludevirtual'}\">\n";
			print "<INPUT NAME=precision TYPE=hidden VALUE=\"$FORM{'precision'}\">\n";
			print "<INPUT NAME=locallog TYPE=hidden VALUE=\"$FORM{'locallog'}\">\n";
			print "<INPUT NAME=localonly TYPE=hidden VALUE=\"$FORM{'localonly'}\">\n";
			print "<INPUT NAME=topten TYPE=hidden VALUE=\"$FORM{'topten'}\">\n";
			print "<INPUT NAME=seuilpage TYPE=hidden VALUE=\"$FORM{'seuilpage'}\">\n";
			print "<INPUT NAME=seuilsite TYPE=hidden VALUE=\"$FORM{'seuilsite'}\">\n";
			print "<INPUT NAME=seuilrepert TYPE=hidden VALUE=\"$FORM{'seuilrepert'}\">\n";
			print "<INPUT NAME=seuilscript TYPE=hidden VALUE=\"$FORM{'seuilscript'}\">\n";
			print "<INPUT NAME=nbdays TYPE=hidden VALUE=\"$FORM{'nbdays'}\">\n";			
		}
	$out = &option($_,$out,$FORM{'action'});
	print if ($out == 0);

	}
close(IN);
}

#
### level 7
#

if ($step == 7) {

# on recupere 2 + 5 + 3 + 9 + 8 + 8 + 6 champs

$nextstep = $step+1;
$filename = $basefilename.$nextstep.$htmlext; 
&error_open($filename) if (!(-r $filename));
open(IN,"$filename"); # || die "can't open $filename\n";
	while (<IN>) {
		$out = 0;
		s/<!-- HELP -->/$helpurl/;
	        s/<!-- BG -->/$bkg/;
		s/<!-- LINE -->/$bkgline/;
		s/<!-- cgiurl -->/$cgiurl/;
		# HIDDEN to print
		if (/<!-- HIDDEN -->/) {
			print "<INPUT NAME=version TYPE=hidden VALUE=\"$FORM{'version'}\">\n";		
			print "<INPUT NAME=action TYPE=hidden VALUE=\"$FORM{'action'}\">\n";
			print "<INPUT NAME=loadconf TYPE=hidden VALUE=\"$loadconf\">\n";		
			print "<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">\n";
			print "<INPUT NAME=prefile TYPE=hidden VALUE=\"$FORM{'prefile'}\">\n";					
			print "<INPUT NAME=type_serveur TYPE=hidden VALUE=\"$FORM{'type_serveur'}\">\n";
			print "<INPUT NAME=server_used TYPE=hidden VALUE=\"$FORM{'server_used'}\">\n";		
			print "<INPUT NAME=htmlext TYPE=hidden VALUE=\"$FORM{'htmlext'}\">\n";
			print "<INPUT NAME=gifext TYPE=hidden VALUE=\"$FORM{'gifext'}\">\n";
			print "<INPUT NAME=plext TYPE=hidden VALUE=\"$FORM{'plext'}\">\n";
			print "<INPUT NAME=extension TYPE=hidden VALUE=\"$FORM{'extension'}\">\n";
			print "<INPUT NAME=extensionimage TYPE=hidden VALUE=\"$FORM{'extensionimage'}\">\n";			
			print "<INPUT NAME=logformat TYPE=hidden VALUE=\"$FORM{'logformat'}\">\n";
			print "<INPUT NAME=stringdateformat TYPE=hidden VALUE=\"$FORM{'stringdateformat'}\">\n";
			print "<INPUT NAME=logfile TYPE=hidden VALUE=\"$FORM{'logfile'}\">\n";
			print "<INPUT NAME=stringlogfile TYPE=hidden VALUE=\"$FORM{'stringlogfile'}\">\n";
			print "<INPUT NAME=virtualCLF TYPE=hidden VALUE=\"$FORM{'virtualCLF'}\">\n";			
			print "<INPUT NAME=zip TYPE=hidden VALUE=\"$FORM{'zip'}\">\n";
			print "<INPUT NAME=struct_compressed_logfile TYPE=hidden VALUE=\"$FORM{'struct_compressed_logfile'}\">\n";									
			print "<INPUT NAME=zipext TYPE=hidden VALUE=\"$FORM{'zipext'}\">\n";
#			print "<INPUT NAME=logfile_sep TYPE=hidden VALUE=\"$FORM{'logfile_sep'}\">\n";
			print "<INPUT NAME=path TYPE=hidden VALUE=\"$FORM{'path'}\">\n";
			print "<INPUT NAME=pathinit TYPE=hidden VALUE=\"$FORM{'pathinit'}\">\n";
#			print "<INPUT NAME=linkpathinit TYPE=hidden VALUE=\"$FORM{'linkpathinit'}\">\n";
			print "<INPUT NAME=pathserver TYPE=hidden VALUE=\"$FORM{'pathserver'}\">\n";
			print "<INPUT NAME=cgipath TYPE=hidden VALUE=\"$FORM{'cgipath'}\">\n";
			print "<INPUT NAME=fileroot TYPE=hidden VALUE=\"$FORM{'fileroot'}\">\n";
			print "<INPUT NAME=prefixlog TYPE=hidden VALUE=\"$FORM{'prefixlog'}\">\n";
			print "<INPUT NAME=refererlog TYPE=hidden VALUE=\"$FORM{'refererlog'}\">\n";
			print "<INPUT NAME=agentlog TYPE=hidden VALUE=\"$FORM{'agentlog'}\">\n";
			print "<INPUT NAME=errorlog TYPE=hidden VALUE=\"$FORM{'errorlog'}\">\n";
			print "<INPUT NAME=GZIP TYPE=hidden VALUE=\"$FORM{'GZIP'}\">\n";
			print "<INPUT NAME=FLY TYPE=hidden VALUE=\"$FORM{'FLY'}\">\n";
			print "<INPUT NAME=localserver TYPE=hidden VALUE=\"$FORM{'localserver'}\">\n";
			print "<INPUT NAME=localdomaine TYPE=hidden VALUE=\"$FORM{'localdomaine'}\">\n";
			print "<INPUT NAME=emailadr TYPE=hidden VALUE=\"$FORM{'emailadr'}\">\n";
			print "<INPUT NAME=exclude_frame TYPE=hidden VALUE=\"$FORM{'exclude_frame'}\">\n";
			print "<INPUT NAME=exclude_robot TYPE=hidden VALUE=\"$FORM{'exclude_robot'}\">\n";
			print "<INPUT NAME=tri TYPE=hidden VALUE=\"$FORM{'tri'}\">\n";
			print "<INPUT NAME=country_filtering TYPE=hidden VALUE=\"$FORM{'country_filtering'}\">\n";
			print "<INPUT NAME=nolog TYPE=hidden VALUE=\"$FORM{'nolog'}\">\n";
			print "<INPUT NAME=selection TYPE=hidden VALUE=\"$FORM{'selection'}\">\n";
			print "<INPUT NAME=selecrepert TYPE=hidden VALUE=\"$FORM{'selecrepert'}\">\n";
			print "<INPUT NAME=excluderepert TYPE=hidden VALUE=\"$FORM{'excluderepert'}\">\n";
			print "<INPUT NAME=virtualfilter TYPE=hidden VALUE=\"$FORM{'virtualfilter'}\">\n";
			print "<INPUT NAME=excludevirtual TYPE=hidden VALUE=\"$FORM{'excludevirtual'}\">\n";
			print "<INPUT NAME=precision TYPE=hidden VALUE=\"$FORM{'precision'}\">\n";
			print "<INPUT NAME=locallog TYPE=hidden VALUE=\"$FORM{'locallog'}\">\n";
			print "<INPUT NAME=localonly TYPE=hidden VALUE=\"$FORM{'localonly'}\">\n";
			print "<INPUT NAME=topten TYPE=hidden VALUE=\"$FORM{'topten'}\">\n";
			print "<INPUT NAME=seuilpage TYPE=hidden VALUE=\"$FORM{'seuilpage'}\">\n";
			print "<INPUT NAME=seuilsite TYPE=hidden VALUE=\"$FORM{'seuilsite'}\">\n";
			print "<INPUT NAME=seuilrepert TYPE=hidden VALUE=\"$FORM{'seuilrepert'}\">\n";
			print "<INPUT NAME=seuilscript TYPE=hidden VALUE=\"$FORM{'seuilscript'}\">\n";
			print "<INPUT NAME=nbdays TYPE=hidden VALUE=\"$FORM{'nbdays'}\">\n";
			print "<INPUT NAME=titlename TYPE=hidden VALUE=\"$FORM{'titlename'}\">\n";
			print "<INPUT NAME=defaulthomepage TYPE=hidden VALUE=\"$FORM{'defaulthomepage'}\">\n";
			print "<INPUT NAME=tildealias TYPE=hidden VALUE=\"$FORM{'tildealias'}\">\n";
			print "<INPUT NAME=reversedns TYPE=hidden VALUE=\"$FORM{'reversedns'}\">\n";
			print "<INPUT NAME=yellowfile TYPE=hidden VALUE=\"$FORM{'yellowfile'}\">\n";
			print "<INPUT NAME=optdirsize TYPE=hidden VALUE=\"$FORM{'optdirsize'}\">\n";
		}

	$out = &option($_,$out,$FORM{'action'});
	print if ($out == 0);
	}
close(IN);	
}

#
### level 8
#

if ($step == 8) {

#
### Generate user config file
#

#$FORM{'zip'} = 1 if ($FORM{'struct_compressed_logfile'} ne '');

print "<HTML><HEAD><TITLE>Config saved</TITLE></HEAD>\n";
print "<BODY BACKGROUND=\"$bkg\" BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\" LINK=\"#0000C0\" VLINK=\"50508F\">\n";

$tmp1 = $FORM{'type_serveur'};
$type_serveur = 0 if ($tmp1 == 0 || $tmp1 == 2 || $tmp1 == 3);
$type_serveur = 1 if ($tmp1 == 1);

$filename_config = $FORM{'pathinit'}.$dirconfig.$dirsep.$FORM{'configfile'}.$FORM{'plext'}; # ne pas bouger de place !

#($dev,$ino,$mode) = stat($FORM{'pathinit'});
#print "A : $mode <P>\n";
# test si $FORM{'pathinit'} est en 777
#$mode = $mode - 16384;
#$dd1 = int($mode/64);
#$dd2 = $mode - $dd1*64;
#print "$FORM{'pathinit'} MODE : $mode : $dd1 - $dd2<P>\n";

#if ($dd1 != 1)
##############################aprint "I'm not able to save output file<P>\n";

$line_filename_config = "$filename_config\t$FORM{'version'}";

# Sauvegarde/MAJ de l'emplacement de tous les fichiers de config

$already = 0;

# test si $w3perlpathres est en 777
##############################aprint "I'm not able to save output file<P>\n";

$already = 0;

if (-f $w3perlloc) {
    &error_open($w3perlloc) if (!(-r $w3perlloc));
   open(CONFLOC,$w3perlloc); # || die "can't open $w3perlloc\n";
   @oldlines = <CONFLOC>;
   close(CONFLOC);

   foreach $oldline (@oldlines) {
       $tmp = $oldline;
#       $already = 0;
       chop($tmp);
#      print "AAA - $tmp<BR>\n";
       ($tmp1,$tmp2) = split(/\t/,$tmp);
#       $already = 1 if ($tmp1 eq $filename_config && $tmp2 == $FORM{'version'});
       $already = 1 if ($tmp1 eq $filename_config);
       if ($tmp1 eq $filename_config && $tmp2 != $FORM{'version'}) {
	   $tmp = "$filename_config\t$FORM{'version'}";
	   $already = 1;
#           push(@lines,$tmp);
       }
       push(@lines,$tmp); # if ($already == 0);
}

   push(@lines,$line_filename_config) if ($already == 0);
} else {
   push(@lines,$line_filename_config);
}

sort(@lines);

#if (-f $w3perlloc) {
#open(CONFLOC,">>$w3perlloc");
#} else {
&error_write($w3perlloc) if (!(-w $w3perlpathres));
open(CONFLOC,">$w3perlloc");
#}
for ($i=0;$i<=$#lines;$i++) {
print CONFLOC "$lines[$i]\n";
}
close(CONFLOC);

# Sauvegarde du fichier de config

# creation du repertoire $FORM{'path'} s'il n'existe pas ainsi que /data/

#$dir = $FORM{'pathinit'};
#chop($dir);
#mkdir ($dir,0777) unless -d $dir;

#$dir = $FORM{'pathinit'}.$dirdata;
#mkdir ($dir,0777) unless -d $dir;

&error_write($filename_config) if (!(-w "$FORM{'pathinit'}$dirconfig"));
open(CONF,">$filename_config"); # || die "can't open $filename_config\n";

&header(*CONF);

$localdomainename = substr($FORM{'localserver'},(index($FORM{'localserver'},'.')+1));

#$FORM{'emailadr'} =~ s/@/\\@/;
$emailadr = $FORM{'emailadr'};
$emailadr =~ s/@/\\@/;
$emailadr = "webmaster\\@".$localdomainename if ($FORM{'emailadr'} eq '');

print CONF "\n";
print CONF "#########################################################################\n";
print CONF "###                           Platform used                           ###\n";
print CONF "#########################################################################\n";
print CONF "\n";

print CONF "\$type_serveur = $type_serveur;  # (0 = Unix ; 1 = Windows NT; 2 = Domino)\n";

print CONF "\$dirsep = \"$dirsep\";      # path separator (Unix = '/' ; NT = '\\' ; Acorn = '.' ; Mac = ':')\n";
print CONF "\$dirsepurl = \"/\";   # URL separator (same on all platform)\n\n"; 
print CONF "\$htmlext = \"$FORM{'htmlext'}\"; # html file extension\n";
print CONF "\$gifext = \"$FORM{'gifext'}\";   # gif file extension\n";
print CONF "\$plext = \"$FORM{'plext'}\";     # perl file extension\n";
print CONF "\$zipext = \"$FORM{'zipext'}\";    # compression suffix\n";

print CONF "\n";
print CONF "#########################################################################\n";
print CONF "###                           Logfile format                          ###\n";
print CONF "#########################################################################\n";
print CONF "\n";
print CONF "### Define your own logfile format\n";
print CONF "# Use %host, %login, %date, %method, %page, %status, %requetesize, %referer, %agent, %virtualhost. %null for unsupported\n";
print CONF "# ECLF format : www.lyot.obspm.fr - - [01/Jan/97:23:12:24 +0000] \"GET /~domisse/w3perl/docs/html/index.html HTTP/1.0\" 200 1220 \"http://www.lyot.obspm.fr/~domisse/\" \"Mozilla/4.01 (X11; I; SunOS 5.3 sun4m)\" give :\n";
print CONF "#\$struct_logfile = \"%host %null %login %date %hourshift %method %page %protocol %status %requetesize %referer %agent\";\n";

# verif qu'un choix a bien ete fait

if ($FORM{'logformat'} eq "standard") {
    
    # NECLF
    $struct_logfile = "%host %null %login %date %hourshift %virtualhost %method %page %protocol %status %requetesize %referer %agent" if ($FORM{'logfile'} eq "NECLF");

    # ECLF
    $struct_logfile = "%host %null %login %date %hourshift %method %page %protocol %status %requetesize %referer %agent" if ($FORM{'logfile'} eq "ECLF");

    # CLF
    $struct_logfile = "%host %null %login %date %hourshift %method %page %protocol %status %requetesize" if ($FORM{'logfile'} eq "CLF");

    # Microsoft
    $struct_logfile = "%host %login %date %hour %null %null %null %null %null %requetesize %status %null %method %page %query" if ($FORM{'logfile'} eq "Microsoft");

    # IIS 3.0 patched
#    $struct_logfile = "%host %login %date %hour %null %null %null %null %null %requetesize %status %null %method %page %query %agent %referer" if ($FORM{'logfile'} eq "IIS 3.0 patched");

    # IIS 4.0
#    $struct_logfile = "%host %login %date %hour %null %null %null %null %requetesize %null %status %null %method %page %query" if ($FORM{'logfile'} eq "IIS 4.0");

    # W3C
    $struct_logfile = "%date %hour %host %method %page %query %status %agent %referer" if ($FORM{'logfile'} eq "W3C");
#$struct_logfile = "%host %login %date %hour %null %null %null %null %requetesize %null %status %null %method %page %query" if ($FORM{'logfile'} eq "IIS 5.0");
#$struct_logfile = "%date %hour %host %login %method %page %query %status %null %requetesize %null %agent %referer" if ($FORM{'logfile'} eq "IIS 4.0");

}

if ($FORM{'logformat'} eq "own") {
$struct_logfile = $FORM{'struct_logfile'};
# verif de la coherence
}

print CONF "\$struct_logfile = \"$struct_logfile\";\n";
print CONF "\n### Logfile filename \n";
print CONF "# Fields allowed : \n";
print CONF "# %year         [xxxx]\n";
print CONF "# %smallyear    [xx]\n";
print CONF "# %month        [00-12]\n";
print CONF "# %lettermonth  [Jan-Dec]\n";
print CONF "# %day          [00-31]\n";
print CONF "# %prefixlog is $FORM{'prefixlog'}\n";
print CONF "\$struct_compressed_logfile = \"$FORM{'struct_compressed_logfile'}\";\n";

print CONF "\n### Virtual server within CLF or ECLF (one logfile for several httpd server)\n";

print CONF "\$virtualfilter = \"$FORM{'virtualfilter'}\";  # select which virtual server you want to filter\n";
print CONF "\$virtualCLF = $FORM{'virtualCLF'};       # 1 for on (%virtualhost hidden in %page)\n";

print CONF "\n### Date format for IIS (only)\n";
print CONF "# Fields allowed : \n";
print CONF "# %year [YY] or [YYYY]\n";
print CONF "# %month [00-12]\n";
print CONF "# %day [00-31]\n";
print CONF "\$date_format = \"$FORM{'stringdateformat'}\";\n";			
print CONF "\n";
print CONF "#########################################################################\n";
print CONF "###                 W3Perl Path Configuration                         ###\n";
print CONF "#########################################################################\n";
print CONF "\n";

$linkpathserver_val = $dirsep;

if ($FORM{'pathserver'} =~ /$FORM{'tildealias'}/) {
$linkpathserver_val = $FORM{'pathserver'};
$pos = index($FORM{'pathserver'},$FORM{'tildealias'});

$tmpafter = substr($FORM{'pathserver'},$pos,length($FORM{'pathserver'}));
$pos = index($tmpafter,'/');
$tmpafter = substr($tmpafter,$pos,length($tmpafter));

$pos = index($FORM{'pathserver'},$FORM{'tildealias'});
$tmp = substr($FORM{'pathserver'},0,$pos-1);
$pos = rindex($tmp,'/');

$tmp = substr($tmp,$pos,length($tmp));
$tmp =~ s/\//\/~/;

$linkpathserver_val = $tmp.$tmpafter;
}

print CONF "## Output path\n";
print CONF "\$path = \"$FORM{'path'}\";\n";
print CONF "\n## Path where the package have been installed\n";
print CONF "\$pathinit = \"$FORM{'pathinit'}\";\n";
#print CONF "\$linkpathinit = \"$FORM{'linkpathinit'}\";\n";
print CONF "\n## Path where your HTML documents are stored\n";
print CONF "\$pathserver = \"$FORM{'pathserver'}\";\n";
print CONF "\n## Absolute URL where your HTML documents are located (usually $dirsepurl)\n";
print CONF "\$linkpathserver = \"$linkpathserver_val\";\n";
print CONF "\n## Cgi-bin path\n";
print CONF "\$cgipath = \"$FORM{'cgipath'}\";\n";
print CONF "\n## Path where log files are located on your server\n";
print CONF "\$fileroot = \"$FORM{'fileroot'}\";\n";
print CONF "\n## \$prefixlog is the name of your log file (located in $fileroot)\n";
print CONF "## \$referlog, \$agentlog and \$errorlog are the name of your referer,\n";
print CONF "## your agent log and error file if you have one.\n";
print CONF "## If you have the extented common log file,\n";
print CONF "## \$agentlog and \$referlog have the same value as \$prefixlog.\n";

print CONF "\$prefixlog = \"$FORM{'prefixlog'}\";\n";
print CONF "\$referlog = \"$FORM{'refererlog'}\";\n";
print CONF "\$agentlog = \"$FORM{'agentlog'}\";\n";
print CONF "\$errorlog = \"$FORM{'errorlog'}\";\n";
print CONF "\n## Fly path (graphic tool)\n";
print CONF "\$FLY = \"$FORM{'FLY'}\";\n";
if ($FORM{'zip'} == 1) {
print CONF "\n## Gzip or zip path (compression tool)\n";
print CONF "\$GZIP = \"$FORM{'GZIP'} ";
print CONF "-dc" if ($FORM{'zipext'} eq ".gz");
print CONF "\";\n";
}
print CONF "\n";
print CONF "#########################################################################\n";
print CONF "###                    W3Perl Configuration                           ###\n";
print CONF "#########################################################################\n";
print CONF "\n";

@nolog = split(/ /,$FORM{'nolog'});
$nolog = '';
for ($i=0;$i<=$#nolog;$i++) {
$nolog .= "'$nolog[$i]',";
}
chop($nolog);

@selection = split(/ /,$FORM{'selection'});
$selection = '';
for ($i=0;$i<=$#selection;$i++) {
$selection[$i] = $dirsepurl.$selection[$i] if ($selection[$i] !~ /^$dirsepurl/);
$selection .= "'$selection[$i]',";
}
chop($selection);

@selecrepert = split(/ /,$FORM{'selecrepert'});
$selecrepert = '';
for ($i=0;$i<=$#selecrepert;$i++) {
$selecrepert[$i] = $dirsepurl.$selecrepert[$i] if ($selecrepert[$i] !~ /^$dirsepurl/);
$selecrepert[$i] = $selecrepert[$i].$dirsepurl if ($selecrepert[$i] !~ /$dirsepurl$/);
$selecrepert .= "'$selecrepert[$i]',";
}
chop($selecrepert);

@excluderepert = split(/ /,$FORM{'excluderepert'});
$excluderepert = '';
for ($i=0;$i<=$#excluderepert;$i++) {
$excluderepert[$i] = $dirsepurl.$excluderepert[$i] if ($excluderepert[$i] !~ /^$dirsepurl/);
$excluderepert[$i] = $excluderepert[$i].$dirsepurl if ($excluderepert[$i] !~ /$dirsepurl$/);
$excluderepert .= "'$excluderepert[$i]',";
}
chop($excluderepert);

@excludevirtual = split(/ /,$FORM{'excludevirtual'});
$excludevirtual = '';
for ($i=0;$i<=$#excludevirtual;$i++) {
$excludevirtual .= "'$excludevirtual[$i]',";
}
chop($excludevirtual);

@extension = split(/ /,$FORM{'extension'});
$extension = '';
for ($i=0;$i<=$#extension;$i++) {
$extension .= "'$extension[$i]',";
}
chop($extension);

@extensionimage = split(/ /,$FORM{'extensionimage'});
$extensionimage = '';
for ($i=0;$i<=$#extensionimage;$i++) {
$extensionimage .= "'$extensionimage[$i]',";
}
chop($extensionimage);

$zipcut = 0;
$zipcut = 1 if ($FORM{'struct_compressed_logfile'} =~ /\%month/ || $FORM{'struct_compressed_logfile'} =~ /\%lettermonth/);
$zipcut = 2 if ($FORM{'struct_compressed_logfile'} =~ /\%day/);

print CONF "## WWW server address\n";

print CONF "\$localserver = \"$FORM{'localserver'}\";\n";
print CONF "\n## Directory filter\n";
print CONF "\$tri = \"$FORM{'tri'}\";\n";
print CONF "\n## Filtering only one country - use country extension\n";
print CONF "\$country_filtering = \"$FORM{'country_filtering'}\";\n";
print CONF "\n## Hosts to filter\n";
print CONF "## '.ens.fr' reject the ens.fr domain\n";
print CONF "## '.fr' reject all french hosts\n";
print CONF "\@nolog = ($nolog);\n";
print CONF "\n## full detailled stats for these html pages (URL from your Document root)\n";
print CONF "\@selection = ($selection);\n";
print CONF "\n## Subdirectories with graphical stats output\n";
print CONF "## (URL from your Document root)\n";
print CONF "\@selecrepert = ($selecrepert);\n";
print CONF "\n## Excluding subdirectories from your report\n";
print CONF "## (URL from your Document root)\n";
print CONF "\@excluderepert = ($excluderepert);\n";
print CONF "\n## Virtual server to exclude (available for NECLF)\n";
print CONF "\@excludevirtual = ($excludevirtual);\n";
print CONF "\n## Global variables\n";
print CONF "\$precision = $FORM{'precision'};     # level of accuracy (from 1 (basic) to 4 (huge))\n";
print CONF "\$locallog = $FORM{'locallog'};      # local access log (0 = no = exclude local log)\n";
print CONF "\$localonly = $FORM{'localonly'};     # only local access log (1 = yes = only local log)\n";
print CONF "\$zip = $FORM{'zip'};           # splitted and gziped log files (1 = yes)\n";
print CONF "\$zipcut = $zipcut;        # 1 => monthly ; 2 => daily\n";
print CONF "\$topten = $FORM{'topten'};       # Show only $topten best items\n";
print CONF "\$seuilpage = $FORM{'seuilpage'};    # Show pages with more than $seuilpage requests\n";
print CONF "\$seuilsite = $FORM{'seuilsite'};    # Show hosts with more than $seuilsite requests\n";
print CONF "\$seuilscript = $FORM{'seuilscript'};  # Show scripts with more than $seuilscript requests\n";
print CONF "\$seuilrepert = $FORM{'seuilrepert'}; # displaying directories with more than $seuilrepert requests\n";
print CONF "\$optdirsize = $FORM{'optdirsize'};    # directories traffic graphs [html pages ( 1 : total, 2 : external, 3 : local), all files ( 4 : total, 5 : external, 6 : local)]\n";
print CONF "\$nbdays = $FORM{'nbdays'};       # number of days to display for graphs (0 => one year)\n";
print CONF "\n";
print CONF "\@extension = ($extension);    # html pages extensions to parse\n";
print CONF "\@extensionimage = ($extensionimage); # images extensions to parse\n";
print CONF "\n";
print CONF "\$reverse_dns = $FORM{'reversedns'}; # Reverse IP to name (slow down computing by a large amount)\n";
print CONF "\$titlename = $FORM{'titlename'};   # convert URL to title (0 =  no)\n";
print CONF "\$defaulthomepage = \"$FORM{'defaulthomepage'}\"; # request on '/' means request on 'index.html'\n";
print CONF "\n## \$localdomainename is your domain name\n";
print CONF "## add your IP adresses if your hosts don't have a DNS\n";
print CONF "## ^ mean 'begin with', \$ mean 'end with', put \\ before any dot (using regex)\n";
print CONF "## Ex : ^145\.238\.44\.* (all hosts inside 145.238.44. are domain hosts)\n";
print CONF "\$localdomainename = \"$localdomainename\";\n";

@localdomaine = split(/ /,$FORM{'localdomaine'});
$localdomaine = '';
for ($i=0;$i<=$#localdomaine;$i++) {
$localdomaine[$i] =~ s/\./\\\./g;
$localdomaine .= "|^$localdomaine[$i]";
}

$localdomaine = $localdomainename.$localdomaine;

print CONF "\$localdomaine = \"$localdomaine\";\n";
print CONF "\n";
print CONF "\$emailadr = \"$emailadr\"; # your email here (default is webmaster's email)\n";

print CONF "\$tildealias = \"$FORM{'tildealias'}\";   # your aliases for users HTML directory\n";
print CONF "\$yellowfile = \"$FORM{'yellowfile'}\";   # Yellow pages NIS if available\n";

$exclude_frame = 0;
$exclude_robot = 0;

$exclude_frame = 1 if ($FORM{'exclude_frame'} == 1);
$exclude_robot = 1 if ($FORM{'exclude_robot'} == 1);

print CONF "\$exclude_frame = $exclude_frame; # exclude framed page\n";
print CONF "\$exclude_robot = $exclude_robot; # exclude robot \n";

print CONF "\n";
print CONF "#########################################################################\n";
print CONF "###                         w3perl output                             ###\n";
print CONF "#########################################################################\n";
print CONF "\n";

$lang = '';
$lang .= "'fr'," if ($FORM{'fr'} == 1);
$lang .= "'uk'," if ($FORM{'uk'} == 1);
$lang .= "'nl'," if ($FORM{'nl'} == 1);
$lang .= "'sp'," if ($FORM{'sp'} == 1);
$lang .= "'jp'," if ($FORM{'jp'} == 1);
$lang .= "'fi'," if ($FORM{'fi'} == 1);
$lang .= "'de'," if ($FORM{'de'} == 1);
chop($lang);

$defaulthomepage = $FORM{'defaulthomepage'};
$defaulthomepage =~ s/\.(.*)//;

#print UPGRADE "primarylang\t$FORM{'primarylang'}\n";

$homepages = '';
if ($FORM{'fr'} == 1) {
$homepages .= "'".$defaulthomepage;
$homepages .= "-fr" if ($FORM{'primarylang'} ne "fr");
$homepages .= "',";
}

if ($FORM{'uk'} == 1) {
$homepages .= "'".$defaulthomepage;
$homepages .= "-uk" if ($FORM{'primarylang'} ne "uk");
$homepages .= "',";
}

if ($FORM{'nl'} == 1) {
$homepages .= "'".$defaulthomepage;
$homepages .= "-nl" if ($FORM{'primarylang'} ne "nl");
$homepages .= "',";
}

if ($FORM{'sp'} == 1) {
$homepages .= "'".$defaulthomepage;
$homepages .= "-sp" if ($FORM{'primarylang'} ne "sp");
$homepages .= "',";
}

if ($FORM{'jp'} == 1) {
$homepages .= "'".$defaulthomepage;
$homepages .= "-jp" if ($FORM{'primarylang'} ne "jp");
$homepages .= "',";
}

if ($FORM{'de'} == 1) {
$homepages .= "'".$defaulthomepage;
$homepages .= "-de" if ($FORM{'primarylang'} ne "de");
$homepages .= "',";
}

if ($FORM{'fi'} == 1) {
$homepages .= "'".$defaulthomepage;
$homepages .= "-fi" if ($FORM{'primarylang'} ne "fi");
$homepages .= "',";
}

chop($homepages);

print CONF "# Choose languages output (\@lang and \@homepages must have the same number of elements)\n";
print CONF "# \@homepages filename should be different from each other (else it will be overwritten !)\n";
print CONF "\@homepages = ($homepages);\n";
print CONF "\@lang = ($lang);\n";

#$FORM{'topframelinks'} =~ s/"/\"/g;
print CONF "\n# Your own link in the top frame\n";
print CONF "\$topframelinks = \"$FORM{'topframelinks'}\";\n";
print CONF "\n# Choose between vertical or horizontal frame\n";
print CONF "\$frame_updown = $FORM{'frame_updown'};\n";

print CONF "\n### Choose which part of script should work (1 = on, 0 = off)\n";

$url_frame = 0;
$url_doublon = 0;
$url_absolute_link = 0;
$url_symbolic_link = 0;
$url_bad_link = 0;
$url_useless = 0;
$url_directory = 0;
$url_weight = 0;
$url_link = 0;
$url_image = 0;
$url_new_doc = 0;
$url_cdrom = 0;
$url_img_tag = 0;
$url_tree = 0;    

$url_frame = 1 if ($FORM{'url_frame'} == 1);
$url_doublon = 1 if ($FORM{'url_doublon'} == 1);
$url_absolute_link = 1 if ($FORM{'url_absolute_link'} == 1);
$url_symbolic_link = 1 if ($FORM{'url_symbolic_link'} == 1);
$url_bad_link = 1 if ($FORM{'url_bad_link'} == 1);
$url_useless = 1 if ($FORM{'url_useless'} == 1);
$url_directory = 1 if ($FORM{'url_directory'} == 1);
$url_weight = 1 if ($FORM{'url_weight'} == 1);
$url_link = 1 if ($FORM{'url_link'} == 1);
$url_image = 1 if ($FORM{'url_image'} == 1);
$url_new_doc = 1 if ($FORM{'url_new_doc'} == 1);
$url_cdrom = 1 if ($FORM{'url_cdrom'} == 1);
$url_img_tag = 1 if ($FORM{'url_img_tag'} == 1);
$url_tree = 1 if ($FORM{'url_tree'} == 1);    

print CONF "\n# cron-url.pl\n";

print CONF "\$url_frame = $url_frame;         # HTML pages without TITLE tag\n";
print CONF "\$url_doublon = $url_doublon;       # HTML pages with TITLE tag identical\n";
print CONF "\$url_absolute_link = $url_absolute_link; # List of absolute links to avoid\n";
print CONF "\$url_symbolic_link = $url_symbolic_link; # List of symbolics link (Unix)\n";
print CONF "\$url_bad_link = $url_bad_link;      # List of wrong links\n";
print CONF "\$url_useless = $url_useless;       # List of HTML pages never link from\n";
print CONF "\$url_directory = $url_directory;     # Stats about directories\n";
print CONF "\$url_weight = $url_weight;        # Stats about the most heavy pages\n";
print CONF "\$url_link = $url_link;          # Stats about number of links in HTML pages\n";
print CONF "\$url_image = $url_image;         # Stats about number of images in HTML pages\n";
print CONF "\$url_new_doc = $url_new_doc;       # New HTML pages on your server\n";
print CONF "\$url_cdrom = $url_cdrom;         # Show HTML pages without index.html link\n";
print CONF "\$url_img_tag = $url_img_tag;       # Images without ALT or having bad WIDTH and HEIGHT tags\n";
print CONF "\$url_tree = $url_tree;          # Show server tree\n";
print CONF "\n";

$session_connection = 0;
$session_visit = 0;
$session_average = 0;
$session_login = 0;
$session_description = 0;
$session_engine = 0;

$session_connection = 1 if ($FORM{'session_connection'} == 1);
$session_visit = 1 if ($FORM{'session_visit'} == 1);
$session_average = 1 if ($FORM{'session_average'} == 1);
$session_login = 1 if ($FORM{'session_login'} == 1);
$session_description = 1 if ($FORM{'session_description'} == 1);
$session_engine = 1 if ($FORM{'session_engine'} == 1);

print CONF "\n# cron-session.pl\n";
print CONF "\$session_connection = $session_connection;  # Average reading time\n";
print CONF "\$session_visit = $session_visit;       # Show the number of visits by day\n";
print CONF "\$session_average = $session_average;     # Show average load versus hour and day of the week\n";
print CONF "\$session_login = $session_login;       # Show people accessing password protected area\n";
print CONF "\$session_description = $session_description; # List of session by hosts\n";
print CONF "\$session_engine = $session_engine;      # List of robots scanning your web\n";
print CONF "\n";

$inc_host = 0;
$inc_page = 0;
$inc_directory = 0;
$inc_country = 0;
$inc_script = 0;    

$inc_host = 1 if ($FORM{'inc_host'} == 1);
$inc_page = 1 if ($FORM{'inc_page'} == 1);
$inc_directory = 1 if ($FORM{'inc_directory'} == 1);
$inc_country = 1 if ($FORM{'inc_country'} == 1);
$inc_script = 1 if ($FORM{'inc_script'} == 1);    

print CONF "\n# cron-pages.pl and cron-inc.pl\n";
print CONF "\$inc_host = $inc_host;      # not yet implemented\n";
print CONF "\$inc_page = $inc_page;      # not yet implemented\n";
print CONF "\$inc_directory = $inc_directory; # not yet implemented\n";
print CONF "\$inc_country = $inc_country;   # not yet implemented\n";
print CONF "\$inc_script = $inc_script;    # Stats about the scripts used and the parameters used\n";
print CONF "\n";

print CONF "### Graphical output\n\n";

$bargraph = 0;
$tridim = 0;
$linegraph = 0;
$fillgraph = 0;

$bargraph = 1 if ($FORM{'graphs'} eq "bargraph");
$tridim = 1 if ($FORM{'graphs'} eq "tridim");
$linegraph = 1 if ($FORM{'graphs'} eq "linegraph");
$fillgraph = 1 if ($FORM{'graphs'} eq "fillgraph");

print CONF "\$bargraph = $bargraph;  # bar chart\n";
print CONF "\$tridim = $tridim;    # 3d bar chart\n";
print CONF "\$linegraph = $linegraph; # line\n";
print CONF "\$fillgraph = $fillgraph; # line filled\n";

$FORM{'custom_text_red'} = "0".$FORM{'custom_text_red'} if (length($FORM{'custom_text_red'}) == 1);
$FORM{'custom_text_green'} = "0".$FORM{'custom_text_green'} if (length($FORM{'custom_text_green'}) == 1);
$FORM{'custom_text_blue'} = "0".$FORM{'custom_text_blue'} if (length($FORM{'custom_text_blue'}) == 1);
$FORM{'custom_link_red'} = "0".$FORM{'custom_link_red'} if (length($FORM{'custom_link_red'}) == 1);
$FORM{'custom_link_green'} = "0".$FORM{'custom_link_green'} if (length($FORM{'custom_link_green'}) == 1);
$FORM{'custom_link_blue'} = "0".$FORM{'custom_link_blue'} if (length($FORM{'custom_link_blue'}) == 1);
$FORM{'custom_vlink_red'} = "0".$FORM{'custom_vlink_red'} if (length($FORM{'custom_vlink_red'}) == 1);
$FORM{'custom_vlink_green'} = "0".$FORM{'custom_vlink_green'} if (length($FORM{'custom_vlink_green'}) == 1);
$FORM{'custom_vlink_blue'} = "0".$FORM{'custom_vlink_blue'} if (length($FORM{'custom_vlink_blue'}) == 1);

print CONF "\n### custom colours for links and background, graphs size\n";

print CONF "\$custom_text = \"\#$FORM{'custom_text_red'}$FORM{'custom_text_green'}$FORM{'custom_text_blue'}\";  # text color\n";
print CONF "\$custom_link = \"\#$FORM{'custom_link_red'}$FORM{'custom_link_green'}$FORM{'custom_link_blue'}\";  # link color\n";
print CONF "\$custom_vlink = \"\#$FORM{'custom_vlink_red'}$FORM{'custom_vlink_green'}$FORM{'custom_vlink_blue'}\"; # visited link color\n";

$FORM{'bgcolor_red'} = "0".$FORM{'bgcolor_red'} if (length($FORM{'bgcolor_red'}) == 1);
$FORM{'bgcolor_green'} = "0".$FORM{'bgcolor_green'} if (length($FORM{'bgcolor_green'}) == 1);
$FORM{'bgcolor_blue'} = "0".$FORM{'bgcolor_blue'} if (length($FORM{'bgcolor_blue'}) == 1);

print CONF "\n# choose either a BGCOLOR or/and a BACKGROUND images\n";

print CONF "\$bgcolor = \"#$FORM{'bgcolor_red'}$FORM{'bgcolor_green'}$FORM{'bgcolor_blue'}\";\n";

if ($FORM{'background'} == 1) {
#$background = $FORM{'linkpathinit'}.$dirres.$FORM{'background_file'};
#$background = $FORM{'background_file'};
print CONF "\$background = \"$FORM{'background_file'}\";\n";
}
# else {
#print CONF "\$backgrd = "\#$FORM{'bgcolor_red'}$FORM{'bgcolor_green'}$FORM{'bgcolor_blue'}\";\n";
#}
print CONF "\n";

### append global var

#$global = "global".$FORM{'plext'};
$global = "global".$plext;
$file = $w3perlpathres.$dirsep.$global;

&error_open($file) if (!(-r $file));
open(FILE,"$file"); # || die "Can't open $file\n";
while (<FILE>) {
print CONF;
}
close(FILE);

close (CONF);

# On essaye de copier $filename_config vers $cgipath$dirsep$FORM{'configfile'}

open(CONF2,$filename_config);
@linesconf = <CONF2>;
close(CONF2);

open(CONF2,">$cgipath$dirsep$FORM{'configfile'}$FORM{'plext'}");
foreach $line (@linesconf) {
    print CONF2 "$line";
}
close(CONF2);

$file_copied = 0;

$file_copied = 1 if (-f "$cgipath$dirsep$FORM{'configfile'}$FORM{'plext'}");

#
### save data for futur upgrade
#

#$upgrade_conf = $FORM{'pathinit'}.$dirdata.$dirsep.$FORM{'configfile'};
$upgrade_conf = $w3perlpathres.$dirsep.$FORM{'configfile'};

&error_write($upgrade_conf) if (!(-r $w3perlpathres));
open(UPGRADE,">$upgrade_conf"); # || die "can't open $upgrade_conf\n";
print UPGRADE "version\t$FORM{'version'}\n";
print UPGRADE "type_serveur\t$FORM{'type_serveur'}\n";
print UPGRADE "server_used\t$FORM{'server_used'}\n";
print UPGRADE "htmlext\t$FORM{'htmlext'}\n";
print UPGRADE "gifext\t$FORM{'gifext'}\n";
print UPGRADE "plext\t$FORM{'plext'}\n";
print UPGRADE "extension\t$FORM{'extension'}\n";
print UPGRADE "extensionimage\t$FORM{'extensionimage'}\n";
print UPGRADE "logformat\t$FORM{'logformat'}\n";
print UPGRADE "date_format\t$FORM{'stringdateformat'}\n";
print UPGRADE "logfile\t$FORM{'logfile'}\n";
print UPGRADE "virtualfilter\t$FORM{'virtualfilter'}\n";
print UPGRADE "virtualCLF\t$FORM{'virtualCLF'}\n";
print UPGRADE "zip\t$FORM{'zip'}\n";
print UPGRADE "zipcut\t$FORM{'zipcut'}\n";
print UPGRADE "zipext\t$FORM{'zipext'}\n";
print UPGRADE "stringlogfile\t$FORM{'stringlogfile'}\n";
#print UPGRADE "logfile_sep\t$FORM{'logfile_sep'}\n";
print UPGRADE "path\t$FORM{'path'}\n";
print UPGRADE "pathinit\t$FORM{'pathinit'}\n";
#print UPGRADE "linkpathinit\t$FORM{'linkpathinit'}\n";
print UPGRADE "pathserver\t$FORM{'pathserver'}\n";
print UPGRADE "cgipath\t$FORM{'cgipath'}\n";
print UPGRADE "fileroot\t$FORM{'fileroot'}\n";
print UPGRADE "prefixlog\t$FORM{'prefixlog'}\n";
print UPGRADE "refererlog\t$FORM{'refererlog'}\n";
print UPGRADE "agentlog\t$FORM{'agentlog'}\n";
print UPGRADE "errorlog\t$FORM{'errorlog'}\n";
print UPGRADE "struct_compressed_logfile\t$FORM{'struct_compressed_logfile'}\n";
print UPGRADE "GZIP\t$FORM{'GZIP'}\n";
print UPGRADE "FLY\t$FORM{'FLY'}\n";
print UPGRADE "localserver\t$FORM{'localserver'}\n";
print UPGRADE "localdomaine\t$FORM{'localdomaine'}\n";
print UPGRADE "emailadr\t$FORM{'emailadr'}\n";
print UPGRADE "exclude_frame\t$FORM{'exclude_frame'}\n";
print UPGRADE "exclude_robot\t$FORM{'exclude_robot'}\n";
print UPGRADE "tri\t$FORM{'tri'}\n";
print UPGRADE "country_filtering\t$FORM{'country_filtering'}\n";
print UPGRADE "nolog\t$FORM{'nolog'}\n";
print UPGRADE "selection\t$FORM{'selection'}\n";
print UPGRADE "selecrepert\t$FORM{'selecrepert'}\n";
print UPGRADE "excluderepert\t$FORM{'excluderepert'}\n";
print UPGRADE "excludevirtual\t$FORM{'excludevirtual'}\n";
print UPGRADE "precision\t$FORM{'precision'}\n";
print UPGRADE "locallog\t$FORM{'locallog'}\n";
print UPGRADE "localonly\t$FORM{'localonly'}\n";
print UPGRADE "topten\t$FORM{'topten'}\n";
print UPGRADE "seuilpage\t$FORM{'seuilpage'}\n";
print UPGRADE "seuilsite\t$FORM{'seuilsite'}\n";
print UPGRADE "seuilrepert\t$FORM{'seuilrepert'}\n";
print UPGRADE "seuilscript\t$FORM{'seuilscript'}\n";
print UPGRADE "titlename\t$FORM{'titlename'}\n";
print UPGRADE "defaulthomepage\t$FORM{'defaulthomepage'}\n";
print UPGRADE "tildealias\t$FORM{'tildealias'}\n";
print UPGRADE "reversedns\t$FORM{'reversedns'}\n";
print UPGRADE "yellowfile\t$FORM{'yellowfile'}\n";
print UPGRADE "optdirsize\t$FORM{'optdirsize'}\n";
print UPGRADE "nbdays\t$FORM{'nbdays'}\n";
print UPGRADE "frame_updown\t$FORM{'frame_updown'}\n";
print UPGRADE "topframelinks\t$FORM{'topframelinks'}\n";
print UPGRADE "fr\t$FORM{'fr'}\n";
print UPGRADE "uk\t$FORM{'uk'}\n";
print UPGRADE "nl\t$FORM{'nl'}\n";
print UPGRADE "sp\t$FORM{'sp'}\n";
print UPGRADE "jp\t$FORM{'jp'}\n";
print UPGRADE "fi\t$FORM{'fi'}\n";
print UPGRADE "primarylang\t$FORM{'primarylang'}\n";
print UPGRADE "graphs\t$FORM{'graphs'}\n";
print UPGRADE "custom_text_red\t$FORM{'custom_text_red'}\n";
print UPGRADE "custom_text_green\t$FORM{'custom_text_green'}\n";
print UPGRADE "custom_text_blue\t$FORM{'custom_text_blue'}\n";
print UPGRADE "custom_link_red\t$FORM{'custom_link_red'}\n";
print UPGRADE "custom_link_green\t$FORM{'custom_link_green'}\n";
print UPGRADE "custom_link_blue\t$FORM{'custom_link_blue'}\n";
print UPGRADE "custom_vlink_red\t$FORM{'custom_vlink_red'}\n";
print UPGRADE "custom_vlink_green\t$FORM{'custom_vlink_green'}\n";
print UPGRADE "custom_vlink_blue\t$FORM{'custom_vlink_blue'}\n";
print UPGRADE "bgcolor_blue\t$FORM{'bgcolor_blue'}\n";
print UPGRADE "bgcolor_red\t$FORM{'bgcolor_red'}\n";
print UPGRADE "bgcolor_green\t$FORM{'bgcolor_green'}\n";
print UPGRADE "url_frame\t$FORM{'url_frame'}\n";
print UPGRADE "url_doublon\t$FORM{'url_doublon'}\n";
print UPGRADE "url_absolute_link\t$FORM{'url_absolute_link'}\n";
print UPGRADE "url_symbolic_link\t$FORM{'url_symbolic_link'}\n";
print UPGRADE "url_bad_link\t$FORM{'url_bad_link'}\n";
print UPGRADE "url_useless\t$FORM{'url_useless'}\n";
print UPGRADE "url_directory\t$FORM{'url_directory'}\n";
print UPGRADE "url_weight\t$FORM{'url_weight'}\n";
print UPGRADE "url_link\t$FORM{'url_link'}\n";
print UPGRADE "url_image\t$FORM{'url_image'}\n";
print UPGRADE "url_new_doc\t$FORM{'url_new_doc'}\n";
print UPGRADE "url_cdrom\t$FORM{'url_cdrom'}\n";
print UPGRADE "url_img_tag\t$FORM{'url_img_tag'}\n";
print UPGRADE "url_tree\t$FORM{'url_tree'}\n";
print UPGRADE "session_connection\t$FORM{'session_connection'}\n";
print UPGRADE "session_visit\t$FORM{'session_visit'}\n";
print UPGRADE "session_average\t$FORM{'session_average'}\n";
print UPGRADE "session_login\t$FORM{'session_login'}\n";
print UPGRADE "session_description\t$FORM{'session_description'}\n";
print UPGRADE "session_engine\t$FORM{'session_engine'}\n";
print UPGRADE "session_reading\t$FORM{'session_reading'}\n";
print UPGRADE "inc_host\t$FORM{'inc_host'}\n";
print UPGRADE "inc_page\t$FORM{'inc_page'}\n";
print UPGRADE "inc_directory\t$FORM{'inc_directory'}\n";
print UPGRADE "inc_country\t$FORM{'inc_country'}\n";
print UPGRADE "inc_script\t$FORM{'inc_script'}\n";

close (UPGRADE);

#
### Greetings
#

print "<TABLE BORDER=0 CELLSPACING=5 WIDTH=100%>\n";
print "<TR>\n";
print "<TD WIDTH=120 VALIGN=TOP><IMG SRC=\"$bkgline\" WIDTH=110 HEIGHT=2></TD>\n";
print "<TD VALIGN=TOP ALIGN=CENTER>\n";
print "<FONT COLOR=\"#0000FF\"><H1>Config file saved</H1></FONT>\n";
print "</TD></TR><TR>\n";
print "<TD WIDTH=120 VALIGN=TOP><FONT SIZE=+2></FONT></TD>\n";
print "<TD ALIGN=CENTER VALIGN=TOP> </TD></TR><TR><TD WIDTH=120></TD><TD>\n";
    if ((-f $filename_config) && (-f $upgrade_conf)) {
	print "Your configuration file : $filename_config have been saved<BR>\n";
    } else {
	print "<FONT COLOR=\"#FF0000\">\n";
	print "Check permission right - /config/, /resources/admin/ should be writeable by the server\n<BR>\n";
	print "Please modify and then reload this page<BR>\n";
	print "</FONT>\n<BR>";
    }

if ($file_copied == 0) {
    print "<FONT COLOR=\"#FF0000\">\n";
    if ($type_serveur != 1) {
	print "You should now copy manually this file to your CGI-BIN directory : $cgipath$dirsep <BR>This step can't be done via the forms for security restriction\n";
    }
    if ($type_serveur == 1) {
	print "Your configuration have not been saved in $cgipath$dirsep\n<BR>\n";
	print "Either check permission right for $cgipath (to allow IIS to write in this directory) or copy manually the file in your cgi-bin\n<BR>";
    }
    
    print "</FONT>\n<BR>";
    
}
print "You'll need to call the scripts with the <I>-c</I> flag to load this
configuration file\n" if ($FORM{'configfile'} ne "config");
print "<P>If you need to modify some fieds in this configuration file, use the administration interface\n";
print "</TD></TR>\n";
print "<TR><TD BGCOLOR=\"#AAAAAA\" COLSPAN=2><IMG SRC=\"$bkgline\" WIDTH=1 HEIGHT=1></TD></TR>\n";

print "<TR><TD WIDTH=120 VALIGN=TOP>\n";
print "<I><FONT SIZE=+1>Test</FONT></I>\n";
print "</TD><TD VALIGN=TOP BGCOLOR=\"#DDDDDD\">\n";
print "Then we need to <A HREF=\"$bkglink#launch\">launch</A> the scripts, use the hour stats to check everything is working fine and watch the ouput, then use a short logfile to test the main stats output with <I>cron-pages ";
print "-c $FORM{'configfile'} " if ($FORM{'configfile'} ne "config");
print "-i &lt;logfile&gt;</I>\n";
print "or use the lowest level of precision <I>(cron-pages ";
print "-c $FORM{'configfile'} " if ($FORM{'configfile'} ne "config");
print "-p 1)</I>\n";
print "</TD></TR>\n";
print "<TR><TD BGCOLOR=\"#AAAAAA\" COLSPAN=2><IMG SRC=\"$bkgline\" WIDTH=1 HEIGHT=1></TD></TR>\n";
print "<TR><TD WIDTH=120 VALIGN=TOP>\n";
print "<I><FONT SIZE=+1>Initialisation</FONT></I>\n";
print "</TD><TD VALIGN=TOP BGCOLOR=\"#DDDDDD\">\n";
print "If you think you could go further, let's go but keep in mind that initialisation is a long process if your logfile is huge\n";
print "<BR>Of course, you can use the administration interface to launch the scripts<P>\n";
print "<TABLE CELLSPACING=5 BORDER=1><TR><TH VALIGN=TOP>";
print "Unix</TH>\n";
print "<TH VALIGN=TOP ALIGN=CENTER>NT</TH></TR><TR><TD VALIGN=TOP>\n";
print "You can now use <I>cron-w3perl -a</I> to launch all the scripts...<BR>time to take a cup of coffee ;)<P>\n";
print "</TD><TD VALIGN=TOP>";

print "You need to run the scripts now in the following order ...\n";
print "<OL>\n";
print "<LI><I> Cron-url</I> (Document stats : optional)\n";
print "<LI><I> Cron-pages</I> (Initialisation : run once only)\n";
print "<LI><I> Cron-hour</I> (Hourly stats)\n";
print "<LI><I> Cron-day</I> (Daily stats)\n";
print "<LI><I> Cron-week</I> (Weekly stats)\n";
print "<LI><I> Cron-month</I> (Monthly stats)\n";
print "<LI><I> Cron-agent</I> (Agent stats)\n";
print "<LI><I> Cron-refer</I> (Referer stats)\n";
print "<LI><I> Cron-error</I> (Error stats)\n";
print "<LI><I> Cron-sessio</I>n (Session stats)\n";
print "<LI><I> Cron-pages -u</I> (update stats homepage)\n";
print "</OL>\n";
print "</TD></TR></TABLE>";
print "<P></UL></TD></TR>";
print "<TR><TD BGCOLOR=\"#AAAAAA\" COLSPAN=2><IMG SRC=\"$bkgline\" WIDTH=1 HEIGHT=1></TD></TR>\n";
print "<TR><TD WIDTH=120 VALIGN=TOP>\n";
print "<I><FONT SIZE=+1>Crontab</FONT></I>\n";
print "</TD><TD VALIGN=TOP BGCOLOR=\"#DDDDDD\">\n";
print "Everything is fine ? ... if so, you can now edit cron-w3perl$FORM{'plext'} to customize the scripts timetable launch and finally get this script to be launch each night<P>\n";
print "<UL>\n";
print "<LI> <B>Unix</B> : add this line in your crontab : [will run everyday at 00:01]<BR>";
$tmp = $cgipath.$dirsep."cron-w3perl".$FORM{'plext'};
print "<I>01 00 * * * $tmp ";
print "-c $cgipath$dirsep$FORM{'configfile'}$FORM{'plext'} " if ($FORM{'configfile'} ne "config");
print "</I><BR>(add '<I>&gt; /dev/null 2&gt;&1</I>' at the end of the line if you don't want a crontab report)";
print "<BR>(add -e flag to force all scripts to run as incremental)\n";
print "<LI> <B>NT</B> : use the 'at' command for all scripts\n";
print "</UL><BR>\n";
print "</TD></TR></TABLE>\n";
print "<P><CENTER><A HREF=\"$bkglink\"><IMG SRC=\"$bkgback\" WIDTH=67 HEIGHT=39 BORDER=0></A></CENTER>\n";
print "</BODY></HTML>\n";
}


###

sub header {
  local(*FOUT,*L) = @_;
  
  print FOUT "\#\!$perlpath\n";
  print FOUT "\# <plaintext>  just in case you look at this via a browser\n\n";
  print FOUT "#########################################################################\n";
  print FOUT "####                                                                #####\n";
  print FOUT "####                  CONFIGURATION USER FILE                       #####\n";
  print FOUT "####                                                                #####\n";
  print FOUT "####                      (http server)                             #####\n";
  print FOUT "####                                                                #####\n";
  print FOUT "####                     v $FORM{'version'} ($date)                       #####\n";
  print FOUT "####                                                                #####\n";
  print FOUT "#########################################################################\n";
  print FOUT "\n";
}


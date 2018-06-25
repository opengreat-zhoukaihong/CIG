#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                  LAUNCH CONFIGURATION FILES                    #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@w3perl.com                   version 02/06/2000     #####
####                                                                #####
#########################################################################

require "init.pl";

# Print out a content-type for HTTP/1.0 compatibility

#########################################################################
###                            LAUNCH                                 ###
#########################################################################

if ($ENV{'REQUEST_METHOD'} eq "GET" && $ENV{'QUERY_STRING'} =~ /script/) {

print "Content-type: text/html\n\n";

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


$fileconf = $FORM{'configfile'};
$fileconf =~ s/$plext//;
$pos = rindex($fileconf,$dirsep);
$fileconf = substr($fileconf,$pos,length($fileconf));
$loadconf = $w3perlpathres.$dirsep.$fileconf;
&load($loadconf);
&loadvar($varforms);

($e1,$e2,$e3) = split(/\//,$date);
$oldvalue{'e1'} = $e1;
$oldvalue{'e2'} = $e2;
$oldvalue{'e3'} = $e3;
$oldvalue{'r1'} = "01";
$oldvalue{'r2'} = "Jan";
$oldvalue{'r3'} = $e3;

$hiddentag = "<INPUT NAME=\"script\" TYPE=\"hidden\" VALUE=\"$FORM{'script'}\"><BR>\n";
$hiddentag .= "<INPUT NAME=\"configfile\" TYPE=\"hidden\" VALUE=\"$FORM{'configfile'}\"><BR>\n";
$hiddentag .= "<INPUT NAME=\"version\" TYPE=\"hidden\" VALUE=\"1\">";

$filename = $pathsetup.$FORM{'script'}.$htmlext;
$size = length($FORM{'configfile'});
&error_open($filename) if (!(-r $filename));
open(FILE,"$filename") || die "Can't open $filename\n";
while (<FILE>) {
    $out = 0;
    s/<!-- HELP -->/$helpurl/;
    s/<!-- BG -->/$bkg/;
    s/<!-- LINE -->/$bkgline/;
#    s/<!-- configfile -->/$FORM{'configfile'}/;
    s/<!-- cgiurl -->/$cgiurl/;
    s/<!-- w3perlurl -->/$w3perlurl/;
    s/<!-- hidden -->/<!-- hidden -->\n$hiddentag/;

    s/NAME="conf"(.*)VALUE=""/NAME="conf"$1VALUE="$FORM{'configfile'}" SIZE="$size"/;

    $out = &option($_,$out,'MODIFY');

    print if ($out == 0);


#print "$tmp1 - $oldvalue{$tmp1}\n";
}
close (FILE);

exit;
}

#########################################################################
###                            DISPLAY                                ###
#########################################################################


# Get the input
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

# Split the name-value pairs
@pairs = split(/&/, $buffer);

foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair);

    # Un-Webify plus signs and %-encoding
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

    # Stop people from using subshells to execute commands
    # Not a big deal when using sendmail, but very important
    # when using UCB mail (aka mailx).
    # $value =~ s/~!/ ~!/g; 

    # Uncomment for debugging purposes
    #print "Setting $name to $value<P>";
	
    $FORM{$name} = $value;
}

$filename = $pathsetup."run".$htmlext; 
$file = $FORM{'configfile'}; 


print "Content-type: text/html\n\n" if ($FORM{'version'} != 1);

&securecgi if ($ENV{'HTTP_REFERER'} !~ /$cgiurl/);


#print "Content-type: text/html\n\n";

if ($FORM{'version'} == 1) {
#    &error_open($file) if (!(-r $file));
    require "$file";
}

# Affichage de la page de lancement des scripts.

if ($FORM{'version'} != 1) {
    &error_open($filename) if (!(-r $filename));
    open(FILE,"$filename") || die "Can't open $filename\n";
    while (<FILE>) {
        s/<!-- HELP -->/$helpurl/;
	s/<!-- BG -->/$bkg/;
	s/<!-- LINE -->/$bkgline/;
	s/<!-- configfile -->/$FORM{'configfile'}/;
	s/<!-- cgiurl -->/$cgiurl/;
	s/<!-- w3perlurl -->/$w3perlurl/;
#s/<!-- DISPLAY -->/$FORM{'configfile'}/;
#s/<!-- HIDDEN2 -->/<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">/;
	print;
    }
    close (FILE);
}

# Lancement des scripts - Generation de l'URL

$string = "c='$FORM{'configfile'}'&";
$tmpvar = "cron-";

if ($FORM{'version'} == 1) {

    ### General
    if ($FORM{'l'} == 1) {
	$string .= "l='";
	$string .= "fr, " if ($FORM{'fr'} == 1);
	$string .= "uk, " if ($FORM{'uk'} == 1);
	$string .= "nl, " if ($FORM{'nl'} == 1);
	$string .= "jp, " if ($FORM{'jp'} == 1);
	$string .= "sp, " if ($FORM{'sp'} == 1);
	$string .= "fi, " if ($FORM{'fi'} == 1);
	chop($string);
	chop($string);
	$string .= "'&";
    }

    if ($FORM{'g'} == 1) {
	$string .= "g='";
	$string .= "bar" if ($FORM{'graphs'} eq "bargraph");
	$string .= "3d" if ($FORM{'graphs'} eq "tridim");
	$string .= "line" if ($FORM{'graphs'} eq "linegraph");
	$string .= "fill" if ($FORM{'graphs'} eq "fillgraph");
	$string .= "'&";
    }

    ### Hour
    if ($FORM{'script'} eq "hour") {
	$string .= "a='$FORM{'a'}'&" if ($FORM{'a'} == 1);
	$string .= "i='$FORM{'fileroot'}$FORM{'prefixlog'}'&" if ($FORM{'i'} == 1);
	$string .= "o='$FORM{'fileroot'}$FORM{'outputfile'}'&" if ($FORM{'o'} == 1);
	$string .= "r='$FORM{'tri'}'&" if ($FORM{'q'} == 1);
	$string .= "p='$FORM{'precision'}'&" if ($FORM{'p'} == 1);
	$string .= "j='$FORM{'r1'}/$FORM{'r2'}/$FORM{'r3'}'&" if ($FORM{'j'} == 1);


	$string .= "t='$FORM{'topten'}'&" if ($FORM{'t'} == 1);
	$string .= "s='$FORM{'seuilsite'}'&" if ($FORM{'s'} == 1);
    }

    ### Pages
    if ($FORM{'script'} eq "pages") {
	$string .= "d='$FORM{'nbdays'}'&" if ($FORM{'d'} == 1);
	$string .= "i='$FORM{'fileroot'}$FORM{'prefixlog'}'&" if ($FORM{'i'} == 1);
	$string .= "p='$FORM{'precision'}'&" if ($FORM{'p'} == 1);
	$string .= "q='$FORM{'tri'}'&" if ($FORM{'q'} == 1);
	$string .= "s='$FORM{'r1'}/$FORM{'r2'}/$FORM{'r3'}'&" if ($FORM{'s'} == 1);
	$string .= "r='$FORM{'e1'}/$FORM{'e2'}/$FORM{'e3'}'&" if ($FORM{'r'} == 1);
	$string .= "t='$FORM{'topten'}'&" if ($FORM{'t'} == 1);
	$string .= "u='1'&" if ($FORM{'u'} == 1);
	$string .= "z='$FORM{'zip'}'&" if ($FORM{'z'} == 1);
    }

    ### Inc
    if ($FORM{'script'} eq "inc") {
	$string .= "d='$FORM{'nbdays'}'&" if ($FORM{'d'} == 1);
	$string .= "i='$FORM{'fileroot'}$FORM{'prefixlog'}'&" if ($FORM{'i'} == 1);
	$string .= "p='$FORM{'precision'}'&" if ($FORM{'p'} == 1);
	$string .= "s='$FORM{'diffmax'}'&" if ($FORM{'s'} == 1);
	$string .= "j='$FORM{'r1'}/$FORM{'r2'}/$FORM{'r3'}'&" if ($FORM{'j'} == 1);
	$string .= "t='$FORM{'topten'}'&" if ($FORM{'t'} == 1);
    }

    ### Day
    if ($FORM{'script'} eq "day") {
	$string .= "d='$FORM{'nbdays'}'&" if ($FORM{'d'} == 1);
	$string .= "p='$FORM{'precision'}'&" if ($FORM{'p'} == 1);
    }

    ### Week
    if ($FORM{'script'} eq "week") {
	$string .= "p='$FORM{'precision'}'&" if ($FORM{'p'} == 1);
    }

    ### Month
    if ($FORM{'script'} eq "month") {
	$string .= "b='$FORM{'b'}'&" if ($FORM{'b'} == 1);
	$string .= "p='$FORM{'precision'}'&" if ($FORM{'p'} == 1);
	$string .= "z='$FORM{'zip'}'&" if ($FORM{'z'} == 1);

    }

    ### Agent
    if ($FORM{'script'} eq "agent") {
	$string .= "a='$FORM{'a'}'&" if ($FORM{'a'} == 1);
	$string .= "b='$FORM{'b'}'&" if ($FORM{'b'} == 1);
	$string .= "d='$FORM{'nbdays'}'&" if ($FORM{'d'} == 1);
	$string .= "f='$FORM{'f'}'&" if ($FORM{'f'} == 1);
	$string .= "i='$FORM{'fileroot'}$FORM{'prefixlog'}'&" if ($FORM{'i'} == 1);
	$string .= "p='$FORM{'precision'}'&" if ($FORM{'p'} == 1);
	$string .= "t='$FORM{'topten'}'&" if ($FORM{'t'} == 1);
	$string .= "z='$FORM{'zip'}'&" if ($FORM{'z'} == 1);
    }

    ### Refer
    if ($FORM{'script'} eq "refer") {
	$string .= "b='$FORM{'b'}'&" if ($FORM{'b'} == 1);
	$string .= "d='$FORM{'nbdays'}'&" if ($FORM{'d'} == 1);
	$string .= "f='$FORM{'f'}'&" if ($FORM{'f'} == 1);
	$string .= "i='$FORM{'fileroot'}$FORM{'prefixlog'}'&" if ($FORM{'i'} == 1);
	$string .= "p='$FORM{'refererpage'}'&" if ($FORM{'p'} == 1);
	$string .= "t='$FORM{'topten'}'&" if ($FORM{'t'} == 1);
	$string .= "z='$FORM{'zip'}'&" if ($FORM{'z'} == 1);
    }

    ### Error
    if ($FORM{'script'} eq "error") {
	$string .= "b='$FORM{'b'}'&" if ($FORM{'b'} == 1);
	$string .= "d='$FORM{'nbdays'}'&" if ($FORM{'d'} == 1);
	$string .= "f='$FORM{'f'}'&" if ($FORM{'f'} == 1);
	$string .= "i='$FORM{'fileroot'}$FORM{'prefixlog'}'&" if ($FORM{'i'} == 1);
	$string .= "j='$FORM{'r1'}/$FORM{'r2'}/$FORM{'r3'}'&" if ($FORM{'j'} == 1);
	$string .= "s='$FORM{'seuilerror'}'&" if ($FORM{'s'} == 1);
	$string .= "q='$FORM{'tri'}'&" if ($FORM{'q'} == 1);
	$string .= "k='$FORM{'k'}'&" if ($FORM{'k'} == 1);
	$string .= "t='$FORM{'topten'}'&" if ($FORM{'t'} == 1);
	$string .= "z='$FORM{'zip'}'&" if ($FORM{'z'} == 1);
    }

    ### Session
    if ($FORM{'script'} eq "session") {
	$string .= "a='$FORM{'a'}'&" if ($FORM{'a'} == 1);
	$string .= "d='$FORM{'nbdays'}'&" if ($FORM{'d'} == 1);
	$string .= "m='$FORM{'m'}'&" if ($FORM{'m'} == 1);
	$string .= "i='$FORM{'fileroot'}$FORM{'prefixlog'}'&" if ($FORM{'i'} == 1);
	$string .= "u='$FORM{'u'}'&" if ($FORM{'u'} == 1);
	$string .= "t='$FORM{'tlim'}'&" if ($FORM{'t'} == 1);
	$string .= "r='$FORM{'tleclim'}'&" if ($FORM{'r'} == 1);
	$string .= "s='$FORM{'seuilt'}'&" if ($FORM{'s'} == 1);
	$string .= "j='$FORM{'r1'}/$FORM{'r2'}/$FORM{'r3'}'&" if ($FORM{'j'} == 1);
	$string .= "q='$FORM{'e1'}/$FORM{'e2'}/$FORM{'e3'}'&" if ($FORM{'q'} == 1);
	$string .= "z='$FORM{'zip'}'&" if ($FORM{'z'} == 1);
    }

    ### URL
    if ($FORM{'script'} eq "document") {
	$string .= "a='$FORM{'a'}'&" if ($FORM{'a'} == 1);
	$string .= "t='$FORM{'topten'}'&" if ($FORM{'t'} == 1);
    }

    ### W3Perl
    if ($FORM{'script'} eq "w3perl") {
	$string .= "d='$FORM{'nbdays'}'&" if ($FORM{'d'} == 1);
	$string .= "e='$FORM{'e'}'&" if ($FORM{'e'} == 1);
	$string .= "a='$FORM{'a'}'&" if ($FORM{'a'} == 1);
    }

    $tmp = "http://$localserver";
    chop($string);
    print "Location: $cgiurl$dirsep$tmpvar$FORM{'script'}$plext?$string\n\n";
}
exit;

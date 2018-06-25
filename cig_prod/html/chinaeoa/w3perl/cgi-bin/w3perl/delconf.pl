#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                  DELETE CONFIGURATION FILES                    #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@w3perl.com                   version 15/08/2000     #####
####                                                                #####
#########################################################################

require "init.pl";

# Print out a content-type for HTTP/1.0 compatibility
print "Content-type: text/html\n\n";

&securecgi if ($ENV{'HTTP_REFERER'} !~ /$cgiurl/);

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
#    print "Setting $name to $value<P>";
	
    $FORM{$name} = $value;
}


$filename = $pathsetup."confirm".$htmlext; 

if ($FORM{'confirm'} eq "yes") {

$file = $FORM{'configfile'}; 

$pos = rindex($file,$dirsep);
$tmp1 = substr($file,0,$pos);
$tmp2 = substr($file,$pos+1,length($file));

$tmp2 =~ s/\..*//;

$file2 = $tmp1.$dirsep.$dirdata.$dirsep.$tmp2;
$file2 = $w3perlpathres.$dirsep.$tmp2;

$succeed1 = unlink($file);
$succeed2 = unlink($file2);

print "<HTML><HEAD><TITLE>File deleted</TITLE></HEAD>\n";
print "<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\" LINK=\"#0000C0\" VLINK=\"50508F\">\n";

print "<P><BR>\n";
print "The file :<P>\n";
print "<UL><I>";

if ($succeed1 == 1 && $succeed2 == 1) {
print "<LI>$file";
print "<BR>";
print "<LI>$file2";
print "</I>\n";
print "</UL> have been deleted.<P>";
} else {


print "<LI>$file" if ($succeed1 == 0);
print "<BR>";
print "<LI>$file2" if ($succeed2 == 0);
print "</I></UL> can't be deleted<P>"; 
}

print "<P><CENTER><A HREF=\"$bkglink\"><IMG SRC=\"$bkgback\" WIDTH=67 HEIGHT=39 BORDER=0></A></CENTER>\n";
print "</BODY></HTML>\n";

#$w3perlloc = $w3perlpathres.$dirsep.$locconf;

open(CONFLOC,"$w3perlloc") || die "can't open $w3perlloc\n";
@lines = (<CONFLOC>);
close(CONFLOC);

open(CONFLOC,">$w3perlloc");
for ($i=0;$i<$#lines;$i++) {
($lines[$i],$ver) = split(/\t/,$lines[$i]);
print CONFLOC "$lines[$i]\t$ver" if ($lines[$i] ne $file);
}
close(CONFLOC);


} else {

open(FILE,$filename);
while (<FILE>) {
s/<!-- BG -->/$bkg/;
s/<!-- LINE -->/$bkgline/;
s/<!-- HIDDEN -->/yes/;
s/<!-- DISPLAY -->/$FORM{'configfile'}/;
s/<!-- HIDDEN2 -->/<INPUT NAME=configfile TYPE=hidden VALUE=\"$FORM{'configfile'}\">/;
print;
}
close (FILE);
}



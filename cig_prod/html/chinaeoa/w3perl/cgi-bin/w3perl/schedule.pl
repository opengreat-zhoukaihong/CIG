#!/usr/local/bin/perl

require "init.pl";

# Print out a content-type for HTTP/1.0 compatibility
print "Content-type: text/html\n\n";


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

$filename = $pathsetup."cron".$htmlext; 

open(CONFLOC,"$w3perlloc") || die "can't open $w3perlloc\n";
@lines = (<CONFLOC>);
close(CONFLOC);


for ($i=0;$i<=$#lines;$i++) {
chop($lines[$i]);
($tmp) = split(/\t/,$lines[$i]);
$pos = rindex($tmp,$dirsep);
$tmp1 = substr($tmp,0,$pos+1);
$newtmp = $tmp1.$dirdata.$dirsep."crontab"; # une seule crontab par serveur
$string .= "$newtmp<BR>\n" if (!($seen{$newtmp}++)); # if (-f $newtmp);
}


open(FILE,$filename);
while (<FILE>) {
s/<!-- DISPLAY -->/$string/;
print;
}
close (FILE);

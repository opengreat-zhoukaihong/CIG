#!/usr/local/bin/perl
#
#########################################################################
####                                                                #####
####                       FIX PERL PATH                            #####
####                                                                #####
####                       (http server)                            #####
####                                                                #####
####    domisse@w3perl.com                   version 28/07/2000     #####
####                                                                #####
#########################################################################
#

$pathcgi = "/www/vhosts/lawrence/cgi-bin/w3perl"; # Do not remove this line ! 

$pathw3perl = "/www/vhosts/lawrence/w3perl"; # Do not change too !

##########################
#     NT or Unix ?       #
##########################

$nt = 0;

# On teste le deuxieme caractere (':' sous NT)

$car = substr($pathw3perl,1,1);
$nt = 1 if ($car eq ':');

#########################################################################
#                        Do not modify below this line                  #
#########################################################################

if ($ENV{'REQUEST_METHOD'} eq "GET") {
        print "Content-type: text/html\n\n";
        print "<HTML><HEAD><TITLE>Installation</TITLE></HEAD>\n";
        print "<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\">\n";
}

########
# init #
########

$dirconfig = "config";
$dirresources = "resources";
$diradmin = "admin";
$verbose = 1;
#$nt = 0;
$plext = ".pl";  # Perl extension
$dirsep = "/";   # string separator
$mode = 0775;
$auto_install = 0;

#########
# Title #
#########

print "<P><BR><H3><CENTER>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Fixing path within scripts\n";
print "</H3><P></CENTER><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#################################################
# Reading parameters from the first three lines #
#################################################

print "<BR><B><LI>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Reading path paramaters within this script\n";
print "</B><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# Figure out the path to "perl" by reading ourself.

unless (defined $perlpath) {
        open(ME,$0) || die "Can't open $0\n";
        $perlpath = <ME>;
        $perlpath =~ s/^#\!\s*(.*)\/perl(.*)\n$/$1/;
        close(ME);
}

#$nt = 1 if ($pathcgi =~ /\\/);
#$dirsep = "\\" if ($nt == 1);
$path3 = $pathw3perl;
$initw3perl = $path3;
$path3 .= $dirsep;
$path2 = $pathcgi.$dirsep if ($nt != 1);
#$path2 = $pathcgi if ($nt == 1);

if ($verbose) {
print "Perl path is : ";
print "<I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "$perlpath\n";
print "</I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Cgi path is : ";
print "<I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "$pathcgi\n";
print "</I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "W3perl path is : ";
print "<I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "$pathw3perl\n";
print "</I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

# RiscOS
 
if ($dirsep eq "." && !(-f "$path2$conf")) {;
$plext = "/pl";
$conf = "config".$plext;
}

$conf = "config".$plext;
$lib = "libw3perl".$plext;
$oldlib = $lib;
$init = "init".$plext;
$confstat = "confstat".$plext;
$delconf = "delconf".$plext;
$schedule = "schedule".$plext;
$runconf = "runconf".$plext;
$cronw3perl = "cron-w3perl".$plext;

###############################################################
# Perform the substitutions for cron-* scripts                #
# It should leave it unchanged if the path is already correct #
###############################################################

print "<BR><LI><B>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print  "> Updating scripts ... \n" if $verbose;
print "</B><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# Si depuis une interface web, alors les scripts sont en fait dans /cgi-bin/
#$path3 = $path2 if ($ENV{'REQUEST_METHOD'} eq "GET");

&error_open($pathcgi) if (!(-r $pathcgi));
opendir(SOURCEDIR,$pathcgi);
local(@filenames) = readdir(SOURCEDIR);
closedir(SOURCEDIR);

for ($j=0;$j<$#filenames;$j++) {
    $file_update = $pathcgi.$dirsep.$filenames[$j];

    next if ($file_update =~ m/$lib/);
    next if ($file_update =~ m/$cronw3perl/);
    next if ($file_update !~ m/cron/);

    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");

    foreach $i (0 .. $#lines) {
	$lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
	$lines[$i] =~ s/^require \"?([^ ]*)libw3perl(.*)\";/require \"$path2$lib\";/;
	print FILE2 "$lines[$i]";
    }
    close (FILE2);

    &set_perm($file_update,$mode) if ($nt != 1);
    print "$filenames[$j] updated\n";

#    print "$file_update updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### Perform the substitutions for libw3perl script
#

$file_update = $pathcgi.$dirsep.$lib;

&error_open($file_update) if (!(-r $file_update));
open(FILE,"$file_update");
@lines = (<FILE>);
close FILE;

&error_write($file_update) if (!(-w $pathcgi));
open(FILE2,">$file_update");
   foreach $i (0 .. $#lines){
      $lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;   
      $lines[$i] =~ s/^require \"?([^ ]*)config(.*)\";/require \"$path2$conf\";/;
      print FILE2 "$lines[$i]";
   }
close (FILE2);

&set_perm($file_update,$mode) if ($nt != 1);
print  "$lib updated\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#
### Perform the substitutions for cron-w3perl script
#


$file_update = $pathcgi.$dirsep.$cronw3perl;

&error_open($file_update) if (!(-r $file_update));
open(FILE,"$file_update");
@lines = (<FILE>);
close FILE;

$ok = 0;
$past = '';
$already = 0;

&error_write($file_update) if (!(-w $pathcgi));
open(FILE2,">$file_update");
foreach $i (0 .. $#lines) {

    $lines[$i] =~ s/^require \"?([^ ]*)libw3perl(.*)\";/require \"$path2$oldlib\";/;
    
    if ($lines[$i] =~ /\$w3perlpath = "(.*)";/) {
	$already = 1;
	$past = $1;
    }
    
    $lines[$i] =~ s/^#\! ?([^ ]*)perl(.*)/#\!$perlpath\/perl$2/;

    $ok = 1 if ($lines[$i] =~ /Do not remove this line/ && $already != 1);
    $ok = 2 if ($lines[$i] =~ /Do not remove this line/ && ($already == 1 && $past ne $pathcgi));
    
    print FILE2 "\$w3perlpath = \"$pathcgi\"; " if ($ok == 1);
    if ($ok == 2) {
	$lines[$i] =~ s/$past/$pathcgi/;
    }
    $ok = 0 if ($ok == 1 || $ok == 2);
    print FILE2 "$lines[$i]";   
}
close (FILE2);

&set_perm($file_update,$mode) if ($nt != 1);
print  "$cronw3perl updated\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

###############################################################
# Perform the substitutions for the cgi-bin scripts           #
# Scripts located in the same level as cron-* scripts         #
###############################################################

# confstat script

$file_update = $pathcgi.$dirsep.$confstat;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
	$lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
	$lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$init\";/;       
	print FILE2 "$lines[$i]";
    }
    close (FILE2);

    &set_perm($file_update,$mode) if ($nt != 1);
    print  "$confstat updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### delconf script
#

$file_update = $pathcgi.$dirsep.$delconf;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
	$lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
	$lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$init\";/;
	print FILE2 "$lines[$i]";
    }
    close (FILE2);

    &set_perm($file_update,$mode) if ($nt != 1);
    print  "$delconf updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### schedule script
#

$file_update = $pathcgi.$dirsep.$schedule;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
        $lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
        $lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$init\";/;
        print FILE2 "$lines[$i]";      
    }
    close (FILE2);

    &set_perm($file_update,$mode) if ($nt != 1);
    print  "$schedule updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### runconf script
#

$file_update = $pathcgi.$dirsep.$runconf;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
        $lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
        $lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$init\";/;
        print FILE2 "$lines[$i]";      
    }
    close (FILE2);

    &set_perm($file_update,$mode) if ($nt != 1);
    print  "$runconf updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### init script
#

$file_update = $pathcgi.$dirsep.$init;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    $ok = 0;
    $past = '';
    $already = 0;

    &error_write($file_update) if (!(-w $pathcgi));    
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
#        $lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$init\";/;
	$lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;

        # pathcgi

	if ($lines[$i] =~ /\$cgipath = "(.*)";/) {
	    $already2 = 1;
	    $past2 = "$1";
	}

        $ok2 = 1 if ($lines[$i] =~ /Do not remove this line/ && $already2 != 1);
        $ok2 = 2 if ($lines[$i] =~ /Do not remove this line/ && ($already2 == 1 && $past2 ne $pathcgi));

       print FILE2 "\$cgipath = \"$pathcgi\"; " if ($ok2 == 1);
	if ($ok2 == 2) {
	    $lines[$i] =~ s/\"$past2\"/\"$pathcgi\"/;
	}

        $ok2 = 0 if ($ok2 == 1 || $ok2 == 2);

	# w3perlpath

	if ($lines[$i] =~ /\$w3perlpath = "(.*)";/) {
	    $already = 1;
	    $past = $1;
	}
		
        $ok = 1 if ($lines[$i] =~ /Do not change too/ && $already != 1);
        $ok = 2 if ($lines[$i] =~ /Do not change too/ && ($already == 1 && $past ne $initw3perl));
	
        print FILE2 "\$w3perlpath = \"$initw3perl\"; " if ($ok == 1);
	if ($ok == 2) {
	    $lines[$i] =~ s/$past/$initw3perl/;
	}
        $ok = 0 if ($ok == 1 || $ok == 2);
        print FILE2 "$lines[$i]";   
    }
    close (FILE2);

    &set_perm($file_update,$mode) if ($nt != 1);
    print  "$init updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

################################################################
# Checking permissions files for /config/ and /resources/admin #
################################################################

if ($nt != 1) {

$mode = 0777;

print "> Setting directories permission\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$tmp = $pathw3perl.$dirsep.$dirconfig;
&set_perm($tmp,$mode);
$tmp = $pathw3perl.$dirsep.$dirresources.$dirsep.$diradmin;
&set_perm($tmp,$mode);
}

print "<BR><B><I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "> Successfully completed\n";
print "</B></I><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

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

sub set_perm {
    local($file,$mode) = @_;

    $cnt = chmod $mode, $file;
    $msg = "Unable to change file permission in $file to set them executable : $!";
    &error($msg) if ($cnt != 1);
}


sub error {
    local($msg) = @_;

    print "<P><DIR><FONT COLOR=\"#AA2020\">" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print "$msg : $!\n";
    print "</FONT><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    print "</DIR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    exit;
}

1;

#!/usr/bin/perl
#
#########################################################################
####                                                                #####
####                     SET-UP CONFIG STATS                        #####
####                                                                #####
####                       (http server)                            #####
####                                                                #####
####    domisse@w3perl.com                   version 06/07/2000     #####
####                                                                #####
#########################################################################
#

$version = "2.70"; 
$verdate = "06/07/00";

require "getopt.pl";
 
&Getopt('cdgijlopqrst');       

# PERL Path (Unix only) :
# edit to reflect the location of Perl on your host
# usually /usr/local/bin/perl or /usr/bin/perl
# change if need the first line of this script 


#
# $pathcgi is the path where the perl scripts will be
# used. It should be somewhere inside your cgi-bin directory.
# It's a good idea to place the scripts inside a /w3perl/ subdirectory.
# Usual NT path is C:/Inetpub/wwwroot/cgi-bin/w3perl
# Your cgi path should at least have the word 'cgi' to be extracted later
# (/cgi-local/ or /richardsoncgi/ is ok, /binary-script/ not)
# (if you don't have cgi-bin, $pathcgi should be the same as $pathw3perl)

$pathcgi = "/home/httpd/cgi-bin/w3perl";

#
# $pathw3perl is the path where the package have been installed
# it should be somewhere inside your webserver root.
# Usual NT path is C:/Inetpub/wwwroot/w3perl
#

$pathw3perl = "/home/httpd/html/chinaeoa/w3perl";

#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -a                             : autodetect\n";
      print STDOUT "        -g <file>                      : use ghost installer config\n";
      print STDOUT "        -x                             : show default value for flag options\n";
      print STDOUT "        -v                             : version\n";
      print STDOUT "\n";
      exit;
}

if ($opt_v == 1) {
      print STDOUT "install.pl - version $version - $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -a               : ";
      &id($opt_a);
      print STDOUT "          -g               : ";
      &id($opt_g);
      print STDOUT "          -v               : $version\n";
      exit;
}


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

$fly = "fly.exe";
$delete_files = 0;
$dirconfig = "config";
$dirresources = "resources";
$diradmin = "admin";
$verbose = 1;
#$nt = 0;
$plext = ".pl";  # Perl extension
$dirsep = "/";   # string separator
$mode = 0755;

#########
# Title #
#########

print "<P><BR><H3><CENTER>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Fixing path within scripts\n";
print "</H3><P></CENTER><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#################################################
# Unix : looking for apache configuration files #
#################################################

if ($opt_a ne '') {

# Try to guess from ENV (work only on Unix)

#require "pwd.pl";
#&initpwd;
#$path = $ENV{'PWD'};
#if ($path =~ m/[\/:]+/) {
#    $pos = length($path)-1;
#    while ($pos >= 0) {
#	$dirsep = substr($path,$pos,1);
#	last if ($dirsep !~ /[\w\s\d-_]/i);
#	$pos--;
#    }
#    $dirsep = "/" if (substr($path,0,1) eq "/");
#    $nt = 1 if ($path =~ /\\/);
#    $dirsep = "\\" if ($nt == 1);
#}

# Try to find cgi-bin path from Apache configuration server

print "<P><BR><B><LI>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Trying to find apache configuration file on Unix ...\n";
print "</B><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$scriptalias = "ScriptAlias";
$perlpathtest = `/usr/bin/which perl`;
@apacheconf = ('srm.conf','httpd.conf');
@location = ('/etc/conf/','/home/httpd/conf/','/usr/local/etc/httpd/conf/');

# Looking for Apache configuration file

$fileconf = $location[0].$apacheconf[0];

BOUCLE:
for ($j=0;$j<=$#apacheconf;$j++) {
    for ($i=0;$i<=$#location;$i++) {
	$fileconf = $location[$i].$apacheconf[$j];
#	print "$j $i $fileconf\n";
	last BOUCLE if (-f $fileconf);
    }
}

# Plusieurs fichiers de conf peuvent etre trouve ==> menu ?

if (-f $fileconf) {
print "Apache configuration file found : ";
print "<I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "$fileconf";
print "</I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$out = 0;

# ScriptAlias doit etre en tout debut de ligne
# Exclus les scriptalias des virtualhost

open(FILE,"$fileconf") || die "Can't open $fileconf\n";
while (<FILE>) {
    chop;
    $out = 1 if /^\<VirtualHost/i;
    $out = 0 if (/^\<\/VirtualHost/i && $out == 1);
    ($scriptalias,$repcgi,$pathcgi) = split(/\s+/) if (/^ScriptAlias/i && $out == 0);
}
close(FILE);

$pathcgi =~ s/\"//g;
print "CGI Path : ";
print "<I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "$pathcgi";
print "</I>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

if ($pathcgi !~ /cgi-bin/) {
    print "Problem cgi-bin : $pathcgi\n";
    exit;
}
} else {
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Failed\n\n";
print "<P><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

# End auto-install
}

#################################################
# Reading parameters from the first three lines #
#################################################

if ($opt_g eq '') {
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
}

########################################
#         Flags option                 #
########################################

if ($opt_g ne '') {

    $file = $opt_g;
    &error_open($file) if (!(-r $file));
    open(FILE,"$file");
    while (<FILE>) {
	chop;
	($tmp1,$tmp2) = split(/=/,$_);
	$pathw3perl = $tmp2 if (/InstallPath/);
	$pathw3perl =~ s/\\/\//g;
	$pathcgi = $tmp2 if (/CGIPath/);
	$pathcgi =~ s/\\/\//g;
	$pathcgi_server = $tmp2 if (/CGIServer/);
	$pathcgi_server =~ s/\\/\//g;
    }
    close FILE;

#    ($pathw3perl,$pathcgi) = split(/,/,$opt_g);
#    $pathcgi = $pathcgi."cgi-bin/w3perl";
}

##########################
#     NT or Unix ?       #
##########################

$nt = 0;

# On teste le deuxieme caractere (':' sous NT)

$car = substr($pathw3perl,1,1);
$nt = 1 if ($car eq ':');

# Init

$path3 = $pathw3perl;
$initw3perl = $path3;
$path3 .= $dirsep;
$path2 = $pathcgi.$dirsep;

########################################
# Making subdirectory inside /cgi-bin/ #
########################################

if ($pathcgi ne $pathw3perl && ($ENV{'REQUEST_METHOD'} ne "GET")) {

$pos = rindex($pathcgi,$dirsep);
$cgisubdir = substr($pathcgi,0,$pos);
#($tmp) = (stat($cgisubdir)) [4];

#if ($tmp == 0 && $nt == 0) {
#    print "<BR><FONT COLOR=\"#AA2020\">" if ($ENV{'REQUEST_METHOD'} eq "GET");
#    print "\nYou should run this script as root\n";
#    print "</FONT><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
#    exit;
#}

if (!(-d $pathcgi)) {
    $tmp = mkdir ($pathcgi,0775);
    if ($tmp != 1) {
	print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
	print "\nError, unable to create $pathcgi - $!\n";
	print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
	print "Run the script as root or create the subdirectory by yourself\n";
	print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
	exit;
    }
}

print "> Making $pathcgi\n";
}

# RiscOS
 
if ($dirsep eq "." && !(-f "$path2$conf")) {;
$plext = "/pl";
$conf = "config".$plext;
}

$conf = "config".$plext;
$lib = "libw3perl".$plext;
$fixperlpath = "fixperlpath".$plext;
$oldlib = $lib;
$init = "init".$plext;
$confstat = "confstat".$plext;
$delconf = "delconf".$plext;
$schedule = "schedule".$plext;
$runconf = "runconf".$plext;
$cronw3perl = "cron-w3perl".$plext;

################################################
# Modify /cgi-bin/ links in /admin/index.html  #
################################################

######## Le code vient de init.pl pour calculer $cgiurl

$pos = rindex($pathcgi,"cgi");
$cgiurl = substr($pathcgi,$pos-1,length($pathcgi));
$bkg = substr($pathcgi,$pos-1,1);

if ($bkg ne $dirsep) {
$tmp = substr($pathcgi,0,$pos-1);
$pos2 = rindex($tmp,$dirsep);
$cgiurl = substr($pathcgi,$pos2,length($pathcgi));
}

### /cgi-bin/w3perl is default w3perl scripts installation

print  "> Updating admin page ... \n" if $verbose;
print "</B><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$admin_page = $pathw3perl."/admin/index.html";

# On modifie la page /admin/index.html (/cgi-bin/w3perl --> $cgiurl)

&error_open($admin_page) if (!(-r $admin_page));
open(FILE,"$admin_page");
@lines = (<FILE>);
close FILE;

&error_write($admin_page) if (!(-w $admin_page));
open(FILE,">$admin_page") || die "Can't open $admin_page";
foreach $line (@lines) {
#    $line =~ s/HREF=\"(.*)\/(\w+)\.(\w+)\?(.*)/HREF=\"$cgiurl\/$2\.$3\?$4/;
    $line =~ s/HREF=\"\/(.*)\/(\w+)\.(\w+)\??(.*)/HREF=\"$cgiurl\/$2\.$3\?$4/;
    print FILE "$line";
}



###############################################################
# Perform the substitutions for cron-* scripts                #
# It should leave it unchanged if the path is already correct #
###############################################################

print "<BR><LI><B>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print  "> Updating scripts ... \n" if $verbose;
print "</B><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# Si depuis une interface web, alors les scripts sont en fait dans /cgi-bin/
$path3 = $path2 if ($ENV{'REQUEST_METHOD'} eq "GET");

opendir(SOURCEDIR,$path3) || die "Couldn't open directory $path3 !!\n";
local(@filenames) = readdir(SOURCEDIR);
closedir(SOURCEDIR);

for ($j=0;$j<=$#filenames;$j++) {
    $file_update = $path3.$dirsep.$filenames[$j];

    next if ($file_update =~ m/$lib/);
    next if ($file_update =~ m/$cronw3perl/);
    next if ($file_update !~ m/cron/);

    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update") || die "Can't open $file_update\n";
    @lines = (<FILE>);
    close FILE;

    unlink($file_update) if ($delete_files == 1);
    $file_update = $pathcgi.$dirsep.$filenames[$j];
    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update") || die "Can't open $file_update";

    foreach $i (0 .. $#lines) {
	$lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
	$lines[$i] =~ s/^require \"?([^ ]*)libw3perl(.*)\";/require \"$path2$lib\";/;
	print FILE2 "$lines[$i]";
    }
    close (FILE2);


    &set_perm($file_update,$mode);
    print "$filenames[$j] updated\n";

#    print "$file_update updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### Perform the substitutions for fixperlpath script
#

$file_update = $path3.$fixperlpath;

&error_open($file_update) if (!(-r $file_update));
open(FILE,"$file_update") || die "Can't open $file_update\n";
@lines = (<FILE>);
close FILE;

unlink($file_update) if ($delete_files == 1);

$file_update = $pathcgi.$dirsep.$fixperlpath;
&error_write($file_update) if (!(-w $pathcgi));
open(FILE2,">$file_update") || die "Can't open $file_update\n";
   foreach $i (0 .. $#lines){
      $lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
      $lines[$i] =~ s/\$pathcgi = "(.*)";/\$pathcgi = "$pathcgi";/;   
#      $lines[$i] =~ s/\$pathw3perl = "(.*)";/\$pathw3perl = "$pathw3perl";/;   

        # pathcgi

	if ($lines[$i] =~ /\$pathcgi = "(.*)";/) {
	    $already2 = 1;
	    $past2 = "$1";
	}

        $ok2 = 1 if ($lines[$i] =~ /Do not remove this line/ && $already2 != 1);
        $ok2 = 2 if ($lines[$i] =~ /Do not remove this line/ && ($already2 == 1 && $past2 ne $pathcgi));

        print FILE2 "\$pathcgi = \"$pathcgi\"; " if ($ok2 == 1);
	if ($ok2 == 2) {
	    $lines[$i] =~ s/\"$past2\"/\"$pathcgi\"/;
	}

        $ok2 = 0 if ($ok2 == 1 || $ok2 == 2);

        # pathw3perl

	if ($lines[$i] =~ /\$pathw3perl = "(.*)";/) {
	    $already = 1;
	    $past = "$1";
	}
	
        $ok = 1 if ($lines[$i] =~ /Do not change too/ && $already != 1);
        $ok = 2 if ($lines[$i] =~ /Do not change too/ && ($already == 1 && $past ne $initw3perl));
	
        print FILE2 "\$pathw3perl = \"$pathw3perl\"; " if ($ok == 1);
	if ($ok == 2) {
	    $lines[$i] =~ s/\"$past\"/\"$pathw3perl\"/;
	}


        $ok = 0 if ($ok == 1 || $ok == 2);


      print FILE2 "$lines[$i]";
   }
close (FILE2);

&set_perm($file_update,$mode);
print  "$fixperlpath updated\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#
### Perform the substitutions for libw3perl script
#

$file_update = $path3.$lib;

&error_open($file_update) if (!(-r $file_update));
open(FILE,"$file_update") || die "Can't open $file_update\n";
@lines = (<FILE>);
close FILE;

unlink($file_update) if ($delete_files == 1);

$file_update = $pathcgi.$dirsep.$lib;
&error_write($file_update) if (!(-w $pathcgi));
open(FILE2,">$file_update") || die "Can't open $file_update\n";
   foreach $i (0 .. $#lines){
      $lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;   
      $lines[$i] =~ s/^require \"?([^ ]*)config(.*)\";/require \"$path2$conf\";/;
      print FILE2 "$lines[$i]";
   }
close (FILE2);

&set_perm($file_update,$mode);
print  "$lib updated\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#
### Perform the substitutions for cron-w3perl script
#

$file_update = $path3.$cronw3perl;

&error_open($file_update) if (!(-r $file_update));
open(FILE,"$file_update") || die "Can't open $file_update\n";
@lines = (<FILE>);
close FILE;

unlink($file_update) if ($delete_files == 1);

$ok = 0;
$past = '';
$already = 0;

$file_update = $pathcgi.$dirsep.$cronw3perl;
&error_write($file_update) if (!(-w $pathcgi));
open(FILE2,">$file_update") || die "Can't open $file_update\n";
foreach $i (0 .. $#lines) {

    $lines[$i] =~ s/^require \"?([^ ]*)libw3perl(.*)\";/require \"$path2$oldlib\";/;
    $lines[$i] =~ s/^#\! ?([^ ]*)perl(.*)/#\!$perlpath\/perl$2/;
    
    if ($lines[$i] =~ /\$w3perlpath = "(.*)";/) {
	$already = 1;
	$past = "$1";
    }
    
    $ok = 1 if ($lines[$i] =~ /Do not remove this line/ && $already != 1);
    $ok = 2 if ($lines[$i] =~ /Do not remove this line/ && ($already == 1 && $past ne $pathcgi));
    
    print FILE2 "\$w3perlpath = \"$pathcgi\"; " if ($ok == 1);
    if ($ok == 2) {
	$lines[$i] =~ s/\"$past\"/\"$pathcgi\"/;
    }
    $ok = 0 if ($ok == 1 || $ok == 2);
    print FILE2 "$lines[$i]";   
}
close (FILE2);

&set_perm($file_update,$mode);
print  "$cronw3perl updated\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#
### Copy fly.exe on NT
#

if ($nt == 1) {

$file_update = $path3.$fly;

($size) = (stat("$file_update"))[7];

&error_open($file_update) if (!(-r $file_update));
open(FILE,"$file_update") || die "Can't open $file_update\n";
binmode(FILE);
sysread(FILE,$tmp,$size);
close FILE;

unlink($file_update) if ($delete_files == 1);

$file_update = $pathcgi_server.$dirsep.$fly;
&error_write($file_update) if (!(-w $pathcgi));
open(FILE2,">$file_update") || die "Can't open $file_update\n";
binmode(FILE2);
syswrite(FILE2,$tmp,$size);   
close (FILE2);

#&set_perm($file_update,$mode);
print  "$fly copied\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

###############################################################
# Perform the substitutions for the cgi-bin scripts           #
# Scripts located in the same level as cron-* scripts         #
###############################################################

$path2b = $path3."cgi-bin".$dirsep."w3perl";
$tmp = "";
$tmp = $path2b.$dirsep if ($dirsep eq ".");

# confstat script

$file_update = $path3.$confstat;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    unlink($file_update) if ($delete_files == 1);

    $file_update = $pathcgi.$dirsep.$confstat;
    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
	$lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
	$lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$path2$init\";/;
	print FILE2 "$lines[$i]";
    }
    close (FILE2);

    &set_perm($file_update,$mode);
    print  "$confstat updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### delconf script
#

$file_update = $path3.$delconf;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    unlink($file_update) if ($delete_files == 1);

    $file_update = $pathcgi.$dirsep.$delconf;
    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
	$lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
	$lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$path2$init\";/;
	print FILE2 "$lines[$i]";
    }
    close (FILE2);

    &set_perm($file_update,$mode);    
    print  "$delconf updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### schedule script
#

$file_update = $path3.$schedule;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    unlink($file_update) if ($delete_files == 1);

    $file_update = $pathcgi.$dirsep.$schedule;
    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
        $lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
        $lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$tmp$init\";/;
        print FILE2 "$lines[$i]";      
    }
    close (FILE2);

    &set_perm($file_update,$mode);
    print  "$schedule updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}


#
### runconf script
#

$file_update = $path3.$runconf;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    unlink($file_update) if ($delete_files == 1);

    $file_update = $pathcgi.$dirsep.$runconf;
    &error_write($file_update) if (!(-w $pathcgi));
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
        $lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;
        $lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$tmp$init\";/;
        print FILE2 "$lines[$i]";      
    }
    close (FILE2);

    &set_perm($file_update,$mode);
    print  "$runconf updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

#
### init script
#

$file_update = $path3.$init;

if (-f $file_update) {
    &error_open($file_update) if (!(-r $file_update));
    open(FILE,"$file_update");
    @lines = (<FILE>);
    close FILE;

    unlink($file_update) if ($delete_files == 1);

    $ok = 0;
    $past = '';
    $already = 0;

    $file_update = $pathcgi.$dirsep.$init;
    &error_write($file_update) if (!(-w $pathcgi));    
    open(FILE2,">$file_update");
    foreach $i (0 .. $#lines){
#        $lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$path2$init\";/;
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
	    $past = "$1";
	}
	
        $ok = 1 if ($lines[$i] =~ /Do not change too/ && $already != 1);
        $ok = 2 if ($lines[$i] =~ /Do not change too/ && ($already == 1 && $past ne $initw3perl));
	
        print FILE2 "\$w3perlpath = \"$initw3perl\"; " if ($ok == 1);
	if ($ok == 2) {
	    $lines[$i] =~ s/\"$past\"/\"$initw3perl\"/;
	}
        $ok = 0 if ($ok == 1 || $ok == 2);


        print FILE2 "$lines[$i]";
    }
    close (FILE2);

    &set_perm($file_update,$mode);
    print  "$init updated\n";
    print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
}

###############################################################
# Scripts located in /w3perl/cgi-bin/w3perl/                  #
###############################################################

$path2b = $path3."cgi-bin".$dirsep."w3perl";
$tmp = "";
$tmp = $path2b.$dirsep if ($dirsep eq ".");

if (-d $path2b && ($ENV{'REQUEST_METHOD'} ne "GET")) {
    opendir(SOURCEDIR,$path2b) || die "Couldn't open directory $path2b !!\n";
    local(@filenames) = readdir(SOURCEDIR);
    closedir(SOURCEDIR);

    for ($j=0;$j<=$#filenames;$j++) {

	$file_update = $path2b.$dirsep.$filenames[$j];

	next if ($filenames[$j] eq ".");
	next if ($filenames[$j] eq "..");

	&error_open($file_update) if (!(-r $file_update));
        open(FILE,"$file_update");
        @lines = (<FILE>);
        close FILE;

	unlink($file_update) if ($delete_files == 1);

        $ok = 0;
	$past = '';
	$already = 0;

	$file_update = $pathcgi.$dirsep.$filenames[$j];
	&error_write($file_update) if (!(-w $pathcgi));
	open(FILE2,">$file_update") || die "Can't open $file_update";
        foreach $i (0 .. $#lines) {
	    $lines[$i] =~ s/^require \"?([^ ]*)init(.*)\";/require \"$path2$init\";/;
	    $lines[$i] =~ s/^\#\! ?([^ ]*)perl(.*)/\#\!$perlpath\/perl$2/;

        # pathcgi

	    if ($lines[$i] =~ /\$cgipath = "(.*)";/) {
		$already2 = 1;
		$past2 = "$1";
	    }

	    $ok2 = 1 if ($file_update =~ /$init/ && $lines[$i] =~ /Do not remove this line/ && $already2 != 1);
	    $ok2 = 2 if ($file_update =~ /$init/ && $lines[$i] =~ /Do not remove this line/ && ($already2 == 1 && $past2 ne $pathcgi));

	    print FILE2 "\$cgipath = \"$pathcgi\"; " if ($ok2 == 1);
	    if ($ok2 == 2) {
		$lines[$i] =~ s/\"$past2\"/\"$pathcgi\"/;
	    }

	    $ok2 = 0 if ($ok2 == 1 || $ok2 == 2);

	    # w3perlpath

	    if ($lines[$i] =~ /\$w3perlpath = "(.*)";/) {
		$already = 1;
		$past = "$1";
	    }
	    
	    $ok = 1 if ($file_update =~ /$init/ && $lines[$i] =~ /Do not change too/ && $already != 1);
	    $ok = 2 if ($file_update =~ /$init/ && $lines[$i] =~ /Do not change too/ && ($already == 1 && $past ne $initw3perl));

	    print FILE2 "\$w3perlpath = \"$initw3perl\"; " if ($ok == 1);
	    if ($ok == 2) {
		$lines[$i] =~ s/\"$past\"/\"$initw3perl\"/;
	    }
	    $ok = 0 if ($ok == 1 || $ok == 2);
	    print FILE2 "$lines[$i]";
	}
	close (FILE2);

	&set_perm($file_update,$mode);
	print  "$filenames[$j] updated\n";
	print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    }
}

################################################################
# Checking permissions files for /config/ and /resources/admin #
################################################################

$mode = 0777;

print "> Setting directories permission\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

$tmp = $pathw3perl.$dirsep.$dirconfig;
&set_perm($tmp,$mode);
$tmp = $pathw3perl.$dirsep.$dirresources.$dirsep.$diradmin;
&set_perm($tmp,$mode);

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
#    print " ==> check write permission\n";
    print "</DIR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
    exit;
}

sub id {
    local($affirmation) = @_;

print STDOUT "Yes\n" if ($affirmation == 1);
print STDOUT "No\n" if ($affirmation == 0);
}

1;

#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                    CONFIGURATION FILE                          #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 10/06/1999     #####
####                                                                #####
#########################################################################

# Never put a rem in front of these variables

#########################################################################
###                           platform used                           ###
#########################################################################

### Platform specifics

$type_serveur = 0;   # (0 = Unix ; 1 = Windows NT; 2 = Domino)

$dirsep = ".";     # path separator (Unix = '/' ; NT = '\\' ; Acorn = '.' ; Mac = ':')
$dirsepurl = "/";  # URL separator (same on all platform !)

$htmlext = "";     # html file extension
$gifext = "";      # gif file extension
$plext = "";       # perl file extension
$zipext = "/gz";   # compression suffix

#########################################################################
###                           Logfile format                          ###
#########################################################################

### Define your own logfile format - uncomment your logfile format used by your server

# Use %host, %login, %date, %method, %page, %status, %requetesize, %referer and %agent
### checking if all these fields are present
### checking if %agent is the last if present (CLF)
# Each string space separated in your logfile format should match the %something keyword in $struct_logfile
# (except for %referer and %agent which are " separated)
# you shouldn't have others fields after %agent
# common logfile
# ex : www.lyot.obspm.fr - - [01/Jan/97:23:12:24 +0000] "GET /~domisse/w3perl/docs/html/index.html HTTP/1.0" 200 1220
# %host = www.lyot.obspm.fr
# %null = -
# %login = -
# %date = [01/Jan/1997:23:12:24
# %hourshift = +0000]
# %method = "GET
# %page = /~domisse/w3perl/docs/html/index.html
# %protocol = HTTP/1.0"
# %status = 200
# %requetesize = 1220
# ---
# optional string
# %query (IIS)
#$struct_logfile = "%host %null %login %date %hourshift %method %page %protocol %status %requetesize";

### new extended common logfile
# ex : www.lyot.obspm.fr - - [01/Jan/97:23:12:24 +0000] (www.obspm.fr) "GET /~domisse/w3perl/docs/html/index.html HTTP/1.0" 200 1220 "http://www.lyot.obspm.fr/~domisse/" "Mozilla/4.01 (X11; I; SunOS 5.3 sun4m)"
#$struct_logfile = "%host %null %login %date %hourshift %virtualhost %method %page %protocol %status %requetesize %referer %null %agent";

### extended common logfile
# ex : www.lyot.obspm.fr - - [01/Jan/97:23:12:24 +0000] "GET /~domisse/w3perl/docs/html/index.html HTTP/1.0" 200 1220 "http://www.lyot.obspm.fr/~domisse/" "Mozilla/4.01 (X11; I; SunOS 5.3 sun4m)"
#$struct_logfile = "%host %null %login %date %hourshift %method %page %protocol %status %requetesize %referer %agent";

### common logfile
# ex : www.lyot.obspm.fr - - [01/Jan/97:23:12:24 +0000] "GET /~domisse/w3perl/docs/html/index.html HTTP/1.0" 200 1220
$struct_logfile = "%host %null %login %date %hourshift %method %page %protocol %status %requetesize";

### IIS logfile (IIS 3.0)
# ex : 129.142.90.150, -, 5/5/97, 14:33:27, W3SVC, RHINO, 194.182.141.6, 2601, 207, 1272, 200, 0, GET, /frabout.htm, -, 
#$struct_logfile = "%host %login %date %hour %null %null %null %null %null %requetesize %status %null %method %page";

### IIS logfile (IIS 3.0 patch with referrer and agent)
# ex : 129.142.90.150, -, 5/5/97, 14:33:27, W3SVC, RHINO, 194.182.141.6, 2601, 207, 1272, 200, 0, GET, /frabout.htm, Mozilla/2.0 (compatible; MSIE 3.0; Windows 95), http://www.iaefenet.org/fairs2.html, -, 
#$struct_logfile = "%host %login %date %hour %null %null %null %null %null %requetesize %status %null %method %page %agent %referer";

### IIS logfile (IIS 4.0)
#Fields: date time c-ip cs-username cs-method cs-uri-stem cs-uri-query sc-status sc-bytes cs-bytes time-taken cs(User-Agent) cs(Referer)
#1998-01-06 19:05:37 193.149.100.108 - GET /images/ap.gif - 304 122 362 651 Mozilla/4.0+(compatible;+MSIE+4.0;+Windows+95) http://www.defle.montaigne.u-bordeaux.fr/
#$struct_logfile = "%date %hour %host %login %method %page %query %status %null %requetesize %null %agent %referer";

### Domino logfile
# Use common logfile format

### Date format for IIS 3.0 logfile
# fields allowed : 
# %year [xx]
# %month [00-12]
# %day [00-31]
$date_format = "%year%month%day";

#####
# logfile filename syntax (used with crunched logfiles)
# fields allowed : 
# %year [xxxx]
# %smallyear [xx]
# %month [00-12]
# %lettermonth [Jan-Dec]
# %day [00-31]
# %prefixlog is $prefixlog
$struct_compressed_logfile = "%prefixlog/%year%month%day";

#########################################################################
###                 w3perl path configuration                         ###
#########################################################################

###
######## w3perl path configuration
###

# path should not contains symbolic links

## the directory where the output files should be stored

$path = 'ATAFS::New.$.Work.wtest.';

## the w3perl directory root (where the package have been installed)

$pathinit = 'ATAFS::New.$.Work.w3perlML.';

## absolute URL to w3perl directory root from your server
## should be http://www.foo.com/w3perl/ if you use w3perl on several web server

#$linkpathinit = "/Work/W3perlML/";
#$linkpathinit = "http://www.foo.com".$linkpathinit;  # uncomment and replace this for multi web server 

#-------------------------------------------------------------------------------
# Registered version only

## full path where your HTML documents are stored

$pathserver = 'ATAFS::New.$.w3perl.';

## absolute URL where your HTML documents are
# (usually $dirsepurl)

$linkpathserver = "/";

## full path for your cgi-bin directory 

$cgipath = "/usr/local/serveurs/cgi-bin/";

#-----------------------------------------------------------------------------

###
######## logfile path configuration
###

## full path where log files are located on your server

$fileroot = 'ATAFS::New.$.Work.w3perlML.log.';

## $prefixlog is the name of your log file (located in $fileroot)
## $referlog, $agentlog and $errorlog are the name of your referer,
## your agent log and error file if you have one.
## If you have the extented common log file used by NCSA > 1.4,
## $agentlog and $referlog have the same value as $prefixlog.

#$prefixlog = "in9712";
$prefixlog = "access";
$referlog = "referer_log";
$agentlog = "agent_log";
$errorlog = "error_log";

## full path for PD softs used in w3perl.
## run 'whereis <command>" or 'which <command>' to know the path

$FLY = 'ATAFS::New.$.Work.W3Perlsrc.bin.fly'; # graphic package
$GZIP = "/bin/gzip -dc";                           # to uncompress log file (optional)

#########################################################################
###                    w3perl configuration                           ###
#########################################################################

## adresse WWW de votre site serveur
## ---
## WWW server address

#$localserver = "209.42.196.40";
#$localserver = "www.suite.net";
$localserver = "hplyot.wanadoo.fr";
#$localserver = "www.defle.montaigne.u-bordeaux.fr";

###
######## logfile path configuration
###

## You can only compute stats for a part of your server (Eg : your public_html directory)
## Give the subdirectory you want to scan. 
## Ex : '/' to scan all accesses
## Ex : '/uk/' to scan only the uk accesses
## Ex : '/~domisse/ to scan only my own accesses

$tri = "/";

## remove these hosts for computing stats (give also IP address if DNS is not correct)
## (it is not the best place to disable your local server if you don't want to count them)
## '.ens.fr' means all hosts inside ens.fr domain are rejected
## 'star.com' mean all hosts ending with star.com (host1.digistar.com and host1.eurostar.com)
## '.grolier.' mean all hosts with the domain class grolier
## '.fr' mean all french hosts
## '144.238.44.' mean all hosts inside 144.238.44 domain

#@nolog = (''); # no hosts are rejected
#@nolog = ('.ext.jussieu.fr','chablis.jussieu.fr','ens.fr');
@nolog = ('.credm.fr');

## more detailled informations for these html pages (URL from your server root)

@selection = ('/~domisse/w3perl/Docs/html/need.html','/~domisse/w3conf/demo/w3perl.tar.gz');

## Subdirectories with a graphical stats output
## requests, html accesses, bytes transfer ... (URL from your server root)
## should be in the same depth level

#@selecrepert = (''); # no graphs output
@selecrepert = ('/www.dreier.com/','/www.softbytesys.com/');

## Excluding subdirectories from your report
## URL from your server root.

#@excluderepert = ('');  # no subdirectory is excluded
@excluderepert = ('/~domisse/private/');

# to select stats for one country
$country_filtering = '';

## Global variables

$precision = 3;                   # level of accuracy (from 1 (basic) to 4 (huge))
$locallog = 1;                    # local access log (0 = no = exclude local log)
$localonly = 0;                   # only local access log (1 = yes = only local log)
$zip = 1;                         # splitted and gziped log files (1 = yes)
$zipcut = 2;                         # 1 == monthly ; 2 == daily
$topten = 10;                     # displaying only $topten best pages
$seuilpage = 0;                  # displaying pages with more than $seuilpage requests
$seuilsite = 0;                   # displaying hosts with more than $seuilsite requests
$seuilscript = 5;                 # displaying scripts with more than $seuilscript requests
$seuilrepert = 0;                 # displaying directories with more than $seuilrepert requests
$optdirsize = 4;                  # directories traffic graphs
                                  # about html pages ( 1 : total, 2 : external, 3 : local)
                                  # about every files ( 4 : total, 5 : external, 6 : local)
$nbdays = 50;                     # number of days for the daily graph (0 => one year)

## fill this field if you are using virtual server with CLF

#$virtualfilter = "www.mac1-detectors.com";
#$virtualfilter = "www.poem.org";
$virtualfilter = "";
$virtualCLF = 0;

@excludevirtual = ('');

## extensions files to scan

@extension = ('html','htm','shtml');       # html pages extensions
#@extension = ('');       # html pages extensions
@extensionimage = ('gif','jpg','jpeg');    # images extensions

##

#$defaulthomepage = "index".$htmlext;  # request on '/' means a request on 'index.html'

### WARNING !

$defaulthomepage = "index".".".$extension[0];  # request on '/' means a request on 'index.html'
$titlename = 1;                       # convert URL to title (0 =  no) (registered version only)

## $localdomainename is your domain name
## add your IP adresses in $localdomaine if your hosts don't have a DNS after the |
## ^ mean 'begin with', $ mean 'end with', put \ before any dot
## Ex : ^145\.238\.44\.* (all hosts inside 145.238.44. are domain hosts)
## Ex : ^145.238.44.[58]$|^192\.35\.24\.4$ (145.238.44.5, 145.238.44.8 and 192.35.24.4)

if ($localserver =~ /^[0-9.]+$/) {
print "Assuming Class C address\n";
$localdomainename = substr($localserver,0,rindex($localserver,'.'));
} else {
$localdomainename = substr($localserver,(index($localserver,'.')+1));
}

#$localdomaine = "$localdomainename|^145\.238\.44\."; # Adding C Class IP for local match
$localdomaine = "$localdomainename";

## your email here (default is webmaster's email)

$mailadr = "webmaster\@$localdomainename";

## your aliases for users HTML directory

$tildealias = "public_html";

## Yellow pages NIS

$yellowfile = "";
#$yellowfile = "/usr/local/nis";

# avoid to use this..it will slow down computing by a large amount !
$reverse_dns = 0; # (1 = yes)

$exclude_robot = 0; # exclude robot 
$exclude_frame = 0; # exclude framed page

#########################################################################
###                         w3perl output                             ###
#########################################################################

###
###### text output
###

### frame left-right or up-down

$frame_updown = 1; # top and bottom frame (0 = left and right frames)

### language option

# choose your languages output (@lang and @homepages should have the same number of elements)
# @homepages filename should be different from each other (else it will be overwritten !)
# ex give french default home page 

#@lang = ('fr','uk','sp','nl','it','jp');              
#@homepages = ('index','welcome','spain','dutch','italy','japan');

@lang = ('fr');              
@homepages = ('index');

### Your own link in the top frame

# " should be \" in the string

$topframelinks = "<A HREF=\"http://$localserver$tri\" TARGET=\"_top\">HPLyot</A>";

### Choose which part of script should work (1 = on, 0 = off)

# cron-url.pl

$url_frame = 1;            # HTML framed pages
$url_no_title = 1;         # HTML pages without TITLE tag
$url_doublon = 1;          # HTML pages with TITLE tag identical
$url_absolute_link = 1;    # List of absolute links to avoid
$url_symbolic_link = 1;    # List of symbolics link (Unix)
$url_bad_link = 1;         # List of wrong links
$url_useless = 1;          # List of HTML pages never link from
$url_directory = 1;        # Stats about directories
$url_weight = 1;           # Stats about the most heavy pages
$url_link = 1;             # Stats about number of links in HTML pages
$url_image = 1;            # Stats about number of images in HTML pages
$url_new_doc = 1;          # New HTML pages on your server
$url_cdrom = 1;            # Show HTML pages without index.html link (if you want a local web)
$url_img_tag = 1;          # Images without ALT or having bad WIDTH and HEIGHT tags
$url_tree = 1;             # Show server tree

# cron-session.pl

$session_reading = 1;      # Average reading time
$session_connection = 1;   # Show session length
$session_visit = 1;        # Show the number of visits by day
$session_average = 1;      # Show average load versus hour and day of the week
$session_login = 1;        # Show people accessing password protected area
$session_description = 1;  # List of session by hosts
$session_engine = 1;       # List of robots scanning your web

# cron-pages and cron-inc.pl

$inc_host = 1;             # not working yet
$inc_page = 1;             # not working yet
$inc_directory = 1;        # not working yet
$inc_country = 1;          # not working yet
$inc_script = 1;           # Stats about the scripts used and the parameters used

###
###### graphical output
###

### default graphic option

$bargraph = 0;   # bar chart
$tridim = 1;     # 3d bar chart
$linegraph = 0;  # line
$fillgraph = 0;  # line filled

### custom colours for links and background, graphs size

$custom_text = "#000000";   # text color
$custom_link = "#000080";   # link color
$custom_vlink = "#800000";  # visited link color

# choose either a BGCOLOR or/and a BACKGROUND images

$bgcolor = "#FFFFFF";

# Uncomment to use a image background
# Specify the URL of the image background 
#$background = "/resources/background.jpg"; # img on the same web server
#$background = "http://".$localserver$tri."img/background.jpg"; # img on another web server

#-
#----------------------------------------------------------------------------#
#-                         Stop here for configuration                      -#
#-                  You should not modify anything after this line          -#
#----------------------------------------------------------------------------#
#-

#########################################################################
###                      w3perl global variables                      ###
#########################################################################
###                                                                   ###
###           Ne pas modifier !!! - Don't modify !!!                  ###

### checking few things

if ($zip == 1) {
($tmp) = split(/ /,$GZIP);
if (!(-x $tmp)) {
print "ERROR in configuration file\n";
print "Unable to find $GZIP\n";
exit;
}
}

if ($tri !~ /\//) {
print "ERROR in configuration file\n";
print "$tri should be at least '/'\n";
exit; 
}

### resources and documentation directories (don't modify)

$dirress = "resources";
$dirdocs = "docs".$dirsepurl."html";

# fly graphic size

$xmax = 450;               # x graph size
$ymax = 250;               # y graph size
$grad = 10;                # number of graduation
$xstep = int($xmax/$grad); # x step for graph
$ystep = int($ymax/$grad); # y step for graph
$xdecal = 75;              # x scale width
$xdecalm = $xdecal - 5;    # length of x scale
$ydecal = 40;              # y scale width
$ydecalm = $ydecal - 15;   # length of y scale

### Compressed logfiles

@compressed_logfile_fields = split(/\W+/,$struct_compressed_logfile);
@compressed_sep_fields = split(/\%\w+/,$struct_compressed_logfile);

for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
$compressed_logfile_fields[$i] = "%".$compressed_logfile_fields[$i] ; 
$fields_compressed_logfile{$compressed_logfile_fields[$i]} = $i;
#print STDERR "$i - $compressed_logfile_fields[$i] - $compressed_sep_fields[$i] - $fields_compressed_logfile{$compressed_logfile_fields[$i]}\n"; 
}

### NT or Unix logfile

# load the logfile format for parsing

@logfile_fields = split(/\s+/,$struct_logfile);

for ($i=0;$i<=$#logfile_fields;$i++) {
$fields_logfile{$logfile_fields[$i]} = $i;
}

# checking if IIS logfile format have been selected

if ($logfile_fields[0] eq "%date" || ($logfile_fields[4] eq "%null" && $logfile_fields[5] eq "%null")) {
#if ($logfile_fields[1] eq "%null") {

 # IIS (NT)
 
$iis_format = 1;
$type_serveur = 1;
@date_string = split(/%/,$date_format);

$logfile_sep = ", " if ($logfile_fields[1] eq "%login"); # Standard
$logfile_sep = " " if ($logfile_fields[1] ne "%login");

} else {

 # Common (Unix)
$iis_format = 0;
$logfile_sep = "[ \[]+";
}
 
# checking extended or common logfile format

if ($struct_logfile =~ "%referer") {
$referlog = $prefixlog; # for extented common logfile (NCSA > 1.4)
}

if ($struct_logfile =~ "%agent") {
$agentlog = $prefixlog; # for extented common logfile (NCSA > 1.4)
}

### yellow pages

if ($yellowfile ne '') {
open(NIS,"$yellowfile") || die "Error, unable to open $yellowfile\n";
while (<NIS>) {
($a,$b) = split;
$nis{$a} = $b;
}
close(NIS);
}

### init

for ($i=0;$i<=$#extension;$i++) {
$extension .= ".".$extension[$i]."\$|";
}
chop($extension);

#$maxlengthos = 10; # Maximum length filename (Mac = 31) 

# find the name of the package

$tmp = $pathinit;
chop($tmp);
$pos = rindex($tmp,$dirsep);
$packagename = substr($tmp,$pos+1,length($tmp));

# global variables

$localdomaine =~ tr/A-Z/a-z/;
$stop = 0;
$nbdays = 1 if ($nbdays < 0);
$nbdays = 366 if ($nbdays == 0 || $nbdays > 366);

$pi = atan2(1,1)*4;
$piradiant = $pi/180;
$halfxmax = $xmax/2;
$halfymax = $ymax/2;
$diam = $ymax;
$rayon = $diam/2;

# homepages filename

@homepagesframed = ('');
for ($nblang=0;$nblang<=$#homepages;$nblang++) {
        $homepagesframed[$nblang] = $homepages[$nblang]."2".$htmlext;
        $homepages[$nblang] = $homepages[$nblang].$htmlext;
}

# graphic flags

for ($nblang=0;$nblang<=$#homepages;$nblang++) {
$flag[$nblang] = "flag-".$lang[$nblang].$gifext;
}

# graphic option

@graphic = ('bar','3d','line','fill'); 
$bargraph = 1 if ($tridim == 1);
$linegraph = 1 if ($fillgraph == 1);
$perspec = 5; # perpective view for 3D graph

### output directories

if ($pathinit =~ /\/(\w+)\/$tildealias/) {
    $tmp2 = $1;
    $tmp3 = $';
} else {

$pos = rindex($path,$dirsep);
$pos2 = index($pathinit,$path);
$tmp = $path;

while ($pos2 == -1) {
$pos = rindex($tmp,$dirsep,$pos-1);
$tmp = substr($tmp,$dirsep,$pos+1);
$linkpathinit .= "..$dirsepurl";
$pos2 = index($pathinit,$tmp);
}

$b = substr($pathinit,$pos+1);
chop($b);

$linkpathinit .= "$b$dirsepurl" if ($b ne '');
}

if ($linkpathinit =~ /$tildealias/) {

$pos = rindex($path,$dirsep);
$pos2 = index($pathserver,$path);
$tmp = $path;
while ($pos2 == -1) {
$pos = rindex($tmp,$dirsep,$pos-1);
$tmp = substr($tmp,$dirsep,$pos+1);
$linkpathinit .= "..$dirsepurl";
$pos2 = index($pathserver,$tmp);
}

    $linkpathinit .= "~$tmp2$tmp3";
}


$homeicons = $linkpathinit;
$homeicons .= $dirress.$dirsepurl."homepage";

$backgrd = "BGCOLOR=\"$bgcolor\"";         # color background
$backgrd .= " BACKGROUND=\"$background\"" if ($background ne '');

$dirdata = "data";
$dirdate = "date";
$dirdays = "days";
$dirlist = "list";
$dirscript = "script";
$dirtmp = "tmp";
$dirframe = "frame";
$dirinc = "inc";
$dirpays = "pays";
$dirsite = "site";
$dirpage = "page";
$dirsession = "session";
$dirdocument = "document";
$dirgraph = "graph";
$tmpfly = $path.$dirtmp.$dirsep."tmpfly";
$history = $path.$dirdata.$dirsep."history";
$filecpu = "cpu".$htmlext;
$baudrate = 5;       

## building string match for speed

for ($i=0;$i<=$#nolog;$i++) {
    $nolog .= $nolog[$i]."|";
    }
chop($nolog);

for ($i=0;$i<=$#selection;$i++) {
    $selection .= $selection[$i]."|";
    }
chop($selection);


for ($i=0;$i<=$#excluderepert;$i++) {
    $excluderepert .= $excluderepert[$i]."|";
    }
chop($excluderepert);

for ($i=0;$i<=$#excludevirtual;$i++) {
    $excludevirtual .= $excludevirtual[$i]."|";
    }
chop($excludevirtual);

## colors table

# for fly output

$square = 10;         # images are $square square pixels
@gcolor = ('rouge','vert','bleufonce','bleu','violet','jaune','marron','vertfonce','bleunuit','bleuclair','jaunefonce','kaki','orange','rose');
@flycolor = (255,85,85,85,255,85,85,85,255,85,255,255,255,85,255,255,255,85,170,0,0,0,170,0,0,0,170,74,213,172,197,213,41,156,180,0,238,148,0,189,131,131);


for ($i=0;$i<$#gcolor;$i++) {
    $gcolor[$i] .= $gifext;

    $red[$i] = $flycolor[3*$i];
    $green[$i] = $flycolor[3*$i+1];
    $blue[$i] = $flycolor[3*$i+2];
    }

undef @flycolor;

# last color index is 100 (others.gif)

$red[100] = 102;
$green[100] = 102;
$blue[100] = 102;


##################################################################
### generic file names
##################################################################

### Data files ###

$file = $fileroot.$prefixlog; # a supprimer
$fileagent = $fileroot.$agentlog;
$filerefer = $fileroot.$referlog;

$help = "index.html";
$drawstat = "stats".$gifext;
$drawstatsmall = "statsmall".$gifext;
$paysgraph = "pays".$gifext;
$paysgraph2 = "pays2".$gifext;
$paysconv = "pays-conv";
$fileurl = "listeurl";
$ip_table = "ip";

#

$datafile = "time-stat";
$statrepert = "time-repert";
$filerepertsize = "time-rsize";

#

$filenamehour = "stat-hour".$htmlext;
$filenameday = "stat-day".$htmlext;
$statnameweek = "stat-week".$htmlext;
$statnamemonth = "stat-month".$htmlext;

$filenametabsize = "tab-size".$htmlext;

# 

$tabnamedays = "tab-days".$htmlext;
$tabnameweek = "tab-weeks".$htmlext;
$tabnamemonth = "tab-month".$htmlext;
$tabnamerefer = "refer".$htmlext;
$tabnamekeyword = "keyword".$htmlext;
$tabnamebrowser = "agent".$htmlext;
$tabnameerror = "error".$htmlext;

# version incrementale

$incgeneral = "general";
$incpage = "pages";
$incpays = "pays";
$incservtot = "serv-tot";
$incservexterne = "serv-externe";
$incservinterne = "serv-interne";
$incpageselect = "pages-select";
$increpert = "repert";
$inchosts = "hosts";
$incscript = "script";

$increfengine = "refengine";
$increfkey = "refkey";
$increfsites = "refsite";
$increfpages = "refpages";
$increfin = "refin";
$increfselec = "refselec";

$incbrowser = "browser";
$incos = "os";
$dayagent = "dayagent";

$incerror = "error";
$incerrpage = "errpage";
$dayerror = "dayerror";

$incrobot = "robot";
$incvirtual = "virtual";

## nom des fichiers dans le repertoire Ressources

$refer = "refer".$htmlext;
$agent = "agent".$htmlext;
$error = "error".$htmlext;
$filesession = "index".$htmlext;
$menu = "index".$htmlext;
$filemoyenne = "moyenne".$htmlext;
$fileresumemenu = "menu".$htmlext;

# graphs used by pages and computed by week
$statweekrepert = "week_rep";

#### a supprimer ????

$filehour = "stat-hour".$htmlext;
$fileday = "stat-day".$htmlext;
$fileweek = "stat-week".$htmlext;
$filemonth = "stat-month".$htmlext;

#

$filesites = "index".$htmlext;
$filepages = "index".$htmlext;
$filepays = "index".$htmlext;
$filerepert = "list-report".$htmlext;
$filescript = "index".$htmlext;

$filereport = $filerepert;  # a supprimer
$filevirtual = "virtual".$htmlext;

$topframe = "top".$htmlext;
$bottomframe = "bottom".$htmlext;

$unresolved = "unresolved".$htmlext;

# icons

$icon_hosts = "hosts".$gifext;
$icon_countries = "countries".$gifext;
$icon_pages = "pages".$gifext;
$icon_dir = "dir".$gifext;
$icon_hours = "hours".$gifext;
$icon_days = "days".$gifext;
$icon_weeks = "weeks".$gifext;
$icon_months = "months".$gifext;
$icon_refer = "refer".$gifext;
$icon_session = "session".$gifext;
$icon_error = "error".$gifext;
$icon_agent = "agent".$gifext;
$icon_doc = "document".$gifext;
$icon_script = "script".$gifext;
$icon_virtual = "virtual".$gifext;

$icon_tree = "tree".$gifext;
$icon_new = "new".$gifext;
$icon_linksym = "linksym".$gifext;
$icon_linkerr = "linkerr".$gifext;
$icon_docrepert = "docrepert".$gifext;
$icon_useless = "useless".$gifext;
$icon_linkabs = "linkabs".$gifext;
$icon_info = "info".$gifext;
$icon_info2 = "info2".$gifext;
$icon_temp = "temp".$gifext;
$icon_verif = "verif".$gifext;
$icon_pie = "pie".$gifext;
$icon_null = "null".$gifext;
$icon_links = "links".$gifext;
$icon_ima = "ima".$gifext;
$icon_trash = "trash".$gifext;
$icon_cdrom = "cdrom".$gifext;

$icon_duree = "duree".$gifext;
$icon_notes = "notes".$gifext;
$icon_descsess = "descsess".$gifext;
$icon_sessmul = "sessmul".$gifext;
$icon_time = "time".$gifext;
$icon_unread = "unread".$gifext;
$icon_login = "login".$gifext;
$icon_reading = "reading".$gifext;

$icon_new_w3perl = "new_stat".$gifext;
$icon_fleched = "fleched".$gifext;
$icon_flecheg = "flecheg".$gifext;

$extconv = "fileext";
$filetype = "filetype";
$dirdomain = "domain";
$dirdownload = "download";
$earthmap = "earth.jpg";
$icon_filetype = "filetype".$gifext;

#!/usr/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                  CONFIGURATION USER FILE                       #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####                     v 2.72 (28/Aug/2000)                       #####
####                                                                #####
#########################################################################


#########################################################################
###                           Platform used                           ###
#########################################################################

$type_serveur = 0;  # (0 = Unix ; 1 = Windows NT; 2 = Domino)
$dirsep = "/";      # path separator (Unix = '/' ; NT = '\' ; Acorn = '.' ; Mac = ':')
$dirsepurl = "/";   # URL separator (same on all platform)

$htmlext = ".html"; # html file extension
$gifext = ".gif";   # gif file extension
$plext = ".pl";     # perl file extension
$zipext = ".gz";    # compression suffix

#########################################################################
###                           Logfile format                          ###
#########################################################################

### Define your own logfile format
# Use %host, %login, %date, %method, %page, %status, %requetesize, %referer, %agent, %virtualhost. %null for unsupported
# ECLF format : www.lyot.obspm.fr - - [01/Jan/97:23:12:24 +0000] "GET /~domisse/w3perl/docs/html/index.html HTTP/1.0" 200 1220 "http://www.lyot.obspm.fr/~domisse/" "Mozilla/4.01 (X11; I; SunOS 5.3 sun4m)" give :
#$struct_logfile = "%host %null %login %date %hourshift %method %page %protocol %status %requetesize %referer %agent";
$struct_logfile = "%host %null %login %date %hourshift %method %page %protocol %status %requetesize";

### Logfile filename 
# Fields allowed : 
# %year         [xxxx]
# %smallyear    [xx]
# %month        [00-12]
# %lettermonth  [Jan-Dec]
# %day          [00-31]
# %prefixlog is access_log
$struct_compressed_logfile = "%prefixlog";

### Virtual server within CLF or ECLF (one logfile for several httpd server)
$virtualfilter = "";  # select which virtual server you want to filter
$virtualCLF = 0;       # 1 for on (%virtualhost hidden in %page)

### Date format for IIS (only)
# Fields allowed : 
# %year [YY] or [YYYY]
# %month [00-12]
# %day [00-31]
$date_format = "";

#########################################################################
###                 W3Perl Path Configuration                         ###
#########################################################################

## Output path
$path = "/home/httpd/html/chinaeoa/w3perl/";

## Path where the package have been installed
$pathinit = "/home/httpd/html/chinaeoa/w3perl/";

## Path where your HTML documents are stored
$pathserver = "/home/httpd/html/chinaeoa/";

## Absolute URL where your HTML documents are located (usually /)
$linkpathserver = "/";

## Cgi-bin path
$cgipath = "/home/httpd/cgi-bin/";

## Path where log files are located on your server
$fileroot = "/etc/httpd/logs/";

## $prefixlog is the name of your log file (located in )
## $referlog, $agentlog and $errorlog are the name of your referer,
## your agent log and error file if you have one.
## If you have the extented common log file,
## $agentlog and $referlog have the same value as $prefixlog.
$prefixlog = "access_log";
$referlog = "referer_log";
$agentlog = "agent_log";
$errorlog = "error_log";

## Fly path (graphic tool)
$FLY = "/home/httpd/cgi-bin/fly";

#########################################################################
###                    W3Perl Configuration                           ###
#########################################################################

## WWW server address
$localserver = "linux2";

## Directory filter
$tri = "/";

## Filtering only one country - use country extension
$country_filtering = "";

## Hosts to filter
## '.ens.fr' reject the ens.fr domain
## '.fr' reject all french hosts
@nolog = ();

## full detailled stats for these html pages (URL from your Document root)
@selection = ();

## Subdirectories with graphical stats output
## (URL from your Document root)
@selecrepert = ();

## Excluding subdirectories from your report
## (URL from your Document root)
@excluderepert = ();

## Virtual server to exclude (available for NECLF)
@excludevirtual = ();

## Global variables
$precision = 3;     # level of accuracy (from 1 (basic) to 4 (huge))
$locallog = 0;      # local access log (0 = no = exclude local log)
$localonly = 0;     # only local access log (1 = yes = only local log)
$zip = 0;           # splitted and gziped log files (1 = yes)
$zipcut = 0;        # 1 => monthly ; 2 => daily
$topten = 10;       # Show only  best items
$seuilpage = 10;    # Show pages with more than  requests
$seuilsite = 10;    # Show hosts with more than  requests
$seuilscript = 10;  # Show scripts with more than  requests
$seuilrepert = 100; # displaying directories with more than  requests
$optdirsize = 2;    # directories traffic graphs [html pages ( 1 : total, 2 : external, 3 : local), all files ( 4 : total, 5 : external, 6 : local)]
$nbdays = 50;       # number of days to display for graphs (0 => one year)

@extension = ('html','htm','shtml','xml');    # html pages extensions to parse
@extensionimage = ('gif','jpeg','jpg','png'); # images extensions to parse

$reverse_dns = 0; # Reverse IP to name (slow down computing by a large amount)
$titlename = 1;   # convert URL to title (0 =  no)
$defaulthomepage = "index.html"; # request on '/' means request on 'index.html'

## $localdomainename is your domain name
## add your IP adresses if your hosts don't have a DNS
## ^ mean 'begin with', $ mean 'end with', put \ before any dot (using regex)
## Ex : ^145.238.44.* (all hosts inside 145.238.44. are domain hosts)
$localdomainename = "linux2";
$localdomaine = "linux2|^192\.168\.0\.14";

$emailadr = "webmaster\@asdf"; # your email here (default is webmaster's email)
$tildealias = "";   # your aliases for users HTML directory
$yellowfile = "";   # Yellow pages NIS if available
$exclude_frame = 0; # exclude framed page
$exclude_robot = 0; # exclude robot 

#########################################################################
###                         w3perl output                             ###
#########################################################################

# Choose languages output (@lang and @homepages must have the same number of elements)
# @homepages filename should be different from each other (else it will be overwritten !)
@homepages = ('index');
@lang = ('uk');

# Your own link in the top frame
$topframelinks = "<A HREF='http://$localserver$tri' TARGET='_top'>Home</A>";

# Choose between vertical or horizontal frame
$frame_updown = 1;

### Choose which part of script should work (1 = on, 0 = off)

# cron-url.pl
$url_frame = 0;         # HTML pages without TITLE tag
$url_doublon = 0;       # HTML pages with TITLE tag identical
$url_absolute_link = 0; # List of absolute links to avoid
$url_symbolic_link = 0; # List of symbolics link (Unix)
$url_bad_link = 1;      # List of wrong links
$url_useless = 1;       # List of HTML pages never link from
$url_directory = 1;     # Stats about directories
$url_weight = 1;        # Stats about the most heavy pages
$url_link = 1;          # Stats about number of links in HTML pages
$url_image = 1;         # Stats about number of images in HTML pages
$url_new_doc = 1;       # New HTML pages on your server
$url_cdrom = 0;         # Show HTML pages without index.html link
$url_img_tag = 0;       # Images without ALT or having bad WIDTH and HEIGHT tags
$url_tree = 1;          # Show server tree


# cron-session.pl
$session_connection = 1;  # Average reading time
$session_visit = 1;       # Show the number of visits by day
$session_average = 1;     # Show average load versus hour and day of the week
$session_login = 0;       # Show people accessing password protected area
$session_description = 1; # List of session by hosts
$session_engine = 0;      # List of robots scanning your web


# cron-pages.pl and cron-inc.pl
$inc_host = 1;      # not yet implemented
$inc_page = 1;      # not yet implemented
$inc_directory = 1; # not yet implemented
$inc_country = 1;   # not yet implemented
$inc_script = 1;    # Stats about the scripts used and the parameters used

### Graphical output

$bargraph = 0;  # bar chart
$tridim = 1;    # 3d bar chart
$linegraph = 0; # line
$fillgraph = 0; # line filled

### custom colours for links and background, graphs size
$custom_text = "#000099";  # text color
$custom_link = "#000080";  # link color
$custom_vlink = "#800000"; # visited link color

# choose either a BGCOLOR or/and a BACKGROUND images
$bgcolor = "#FFFFFF";

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

if ($struct_logfile =~ "%referer" && $struct_logfile =~ "%agent") {
$referlog = $prefixlog; # for extented common logfile (NCSA > 1.4)
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

if ($pathinit =~ /\/(\w+)\/$tildealias/ && $tildealias ne '') {
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

if ($linkpathinit =~ /$tildealias/ && $tildealias ne '') {

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
$icon_filetype = "filetype".$gifext;

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

# New from 2.69
$dirdomain = "domain";
$dirdownload = "download";
$earthmap = "earth.jpg";

$extconv = "fileext";
$filetype = "filetype";

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

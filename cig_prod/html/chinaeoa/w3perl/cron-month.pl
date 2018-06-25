#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                     MONTHLY STATS                              #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@hplyot.obspm.fr              version 20/08/2000     #####
####                                                                #####
#########################################################################

$version = "2.72";
$verdate = "20/08/00";

$shift_factor = 0.3;

####### script a lancer a 00 heures 01 minutes tous les 1er du mois #####

require "/usr/local/etc/w3perl/cgi-bin/w3perl/libw3perl.pl";

$starttime = time();
print "Monthly stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

# variable liee au serveur

$domreq = 0;
$reqtot = 0;
$accesslues = 0;
$testday = 1;

if ($zipcut == 2) {
$monthtmp = $month;
$filetmpzip = $fileroot;
$month = $month_equiv{$month};
$month = "0".$month if (length($month) == 1);
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
$compressed_logfile_fields[$i] =~ s/\%/\$/;
$filetmpzip .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}
$filetmpzip = $filetmpzip.$zipext if ($zip == 1);
$month = $monthtmp;
}

#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_h == 1) {
      print STDERR "Usage : \n";
      print STDERR "        -b                    : incremental run\n";
      print STDOUT "        -c <file>             : load configuration file\n";
      print STDOUT "        -g <";
      for ($i=0;$i<$#graphic;$i++) {
      print STDOUT "$graphic[$i] ";
      } 
      print STDOUT "$graphic[$#graphic]";
      print STDOUT "> : graphic output (choose one)\n";
      print STDOUT "        -l <";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      } 
      print STDOUT "$lang[$#lang]";
      print STDOUT ">            : language output (comma split)\n";          
      print STDERR "        -p <level>            : precision level (from 1 to 4)\n";
      print STDERR "        -x                    : show default value for flag options\n";
      print STDERR "        -v                    : version\n";
      print STDOUT "        -z           : zip logfiles\n";      
      print STDERR "\n";
      exit;
}

if ($opt_v == 1) {
      print STDERR "cron-mois.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDERR "Default : \n";
      print STDERR "          -b            : ";
      &id($opt_b);
      print STDOUT "          -c            : $configfile\n";
      print STDOUT "          -g <graphic>  : $graphic[0]\n";
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDERR "          -p <level>    : $precision\n";
      print STDERR "          -v            : $version\n";
      print STDOUT "          -z            : ";
      &id($opt_z);         
      exit;
}

if ($opt_z ne '') {
$zip = $opt_z;
}

if ($opt_l ne '') {
  @lang = split(/, /,$opt_l);
  for ($i=0;$i<=$#lang;$i++) {
      $tmp = $dirress.$dirsep."lang".$dirsep.$lang[$i].$plext;
      $tmp = $pathinit.$tmp;
      require "$tmp";
  }
  if ($lang[0] eq '') {
      print STDERR "\nNone of your language choices have been yet translated !\n
";
      exit; 
      }
}


if ($opt_g ne '') {
  if ($opt_g eq "3d")  {
      $bargraph = 1;
      $linegraph = 0;
      $tridim = 1;
  }
  if ($opt_g eq "fill") {
      $bargraph = 0;
      $linegraph = 1;
      $fillgraph = 1;
  }
  if ($opt_g eq "line") {
      $bargraph = 0;
      $linegraph = 1;
  }
  if ($opt_g eq "bar") {
      $bargraph = 1;
      $linegraph = 0;
      $tridim = 0;
  }
}


# argument cmds line

if ($opt_p ne '') {
  $precision = $opt_p;
}

#################################################################
####          debut de l'initialisation                   #######
#################################################################

$outfile1 = $path.$dirgraph.$dirsep."month_mac".$gifext;
$outfile1x = $path.$dirgraph.$dirsep."month_macx".$gifext;
$outfile1y = $path.$dirgraph.$dirsep."month_macy".$gifext;

$linkoutfile1 = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."month_mac".$gifext;
$linkoutfile1x = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."month_macx".$gifext;
$linkoutfile1y = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."month_macy".$gifext;

$outfile2 = $path.$dirgraph.$dirsep."month_req".$gifext;
$outfile2x = $path.$dirgraph.$dirsep."month_reqx".$gifext;
$outfile2y = $path.$dirgraph.$dirsep."month_reqy".$gifext;

$linkoutfile2 = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."month_req".$gifext;
$linkoutfile2x = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."month_reqx".$gifext;
$linkoutfile2y = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."month_reqy".$gifext;

### URL to title conversion

chop($pathserver);

if (!(-e "$path$dirdata$dirsep$fileurl")) {
  $titlename = 0;
}

if ($titlename == 1) {
  open(URL,"$path$dirdata$dirsep$fileurl") || die "cannot open $path$dirdata$dirsep$fileurl\n";
  while (<URL>) {
    ($url,$title) = split(/\"/);
chop($url);
#$url =~ s/$pathserver//i;
$urlconv{$url} = $title;
}
close (URL);
}

### loading countries codes

open(PAYSCONV,"$pathinit$dirress$dirsep$paysconv") || die "Error, unable to open $pathinit$dirress$dirsep$paysconv\n";
while (<PAYSCONV>) {
    chop;
    ($newpays,$pays,$zone)=split(/\s+/);  # format 'France (.fr)'
    if ($zone eq '') {
	$zone[$pays] = $newpays;
    } else {
	$pays =~ s/\(\.(.*)\)/$1/;
	$newflag{$pays}=$newpays;
	$flagpage{$pays} = $newflag{$pays};
	$flagpage{$pays} .= $htmlext;
	$zonepays{$pays} = $zone; 
    }
}
$newflag{Unknown} = "Unknown";
$flagpage{Unknown} = "Unknown".$htmlext;
close PAYSCONV;

#############################################################################

&load_reverse_dns if ($reverse_dns == 1); # chargement de la table de DNS

#################################################################
#####              computing monthly stats                 ######
#################################################################

for ($nblang=0;$nblang<=$#lang;$nblang++) {

        $tabmonth = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamemonth;

        open(TABMONTH,">$tabmonth") || die "Error, unable to open $filemonth\n";
        &MonthHeader(*TABMONTH, eval($Lang{$lang[$nblang]}));
        close(TABMONTH);
        }


open(INFILE, "$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";

$line = 0;
$count_month = 1;

while (<INFILE>) {
     $line++;
     next if ($line <= 3);

     $count++;
     ($jour,$month,$year,$m_tot,$m_new,$m_dom,$req_tot,$req_dom,$access) = split('\s+');

     if ( $line == 4) {
       $start_date = $month." ".$year;
       $oldmonth = $month;
       $oldyear = $year;
     }

     if ( $month eq $oldmonth) {
          $machine_tot = $machine_tot + $m_tot;
          $machine_dom = $machine_dom + $m_dom;
          $machine_new = $machine_new + $m_new;
          $requete_tot = $requete_tot + $req_tot;
          $access_tot = $access_tot + $access;
          $requete_dom = $requete_dom + $req_dom;
          }
      else {

        $machmaxtot{$count_month} = $machine_tot;
        $newmaxtot{$count_month} = $machine_new;
        $dommaxtot{$count_month} = $machine_dom;

        $machmax = $machine_tot if ($machine_tot > $machmax);

        $reqmaxtot{$count_month} = $requete_tot;
        $accessmaxtot{$count_month} = $access_tot;
        $reqdommaxtot{$count_month} = $requete_dom;

        $reqmax = $requete_tot if ($requete_tot > $reqmax);

        for ($nblang=0;$nblang<=$#lang;$nblang++) {
          $tabmonth = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamemonth;
#          $taboldmonth = $linkpath.$lang[$nblang].$dirsepurl.$dirdate.$dirsepurl.$oldmonth;
          $taboldmonth = $oldyear."-".$oldmonth;

          $graphline[$count_month] = $taboldmonth if ($nblang == 0);

          open(TABMONTH,">>$tabmonth") || die "Error, unable to open $filemonth\n";
          print TABMONTH "<TR><TD ALIGN=CENTER bgcolor=\"#E0E0E0\"><A HREF=\"$taboldmonth$htmlext\">" if ($precision > 2);
          print TABMONTH "$oldyear $oldmonth";
          print TABMONTH "</A></TD>" if ($precision > 2);
          print TABMONTH "<TD BGCOLOR=\"#FFFF00\" ALIGN=MIDDLE>$machine_tot</td>";
          print TABMONTH "<TD ALIGN=MIDDLE>$machine_new</TD>";
          print TABMONTH "<TD ALIGN=MIDDLE>$machine_dom</TD>";
          print TABMONTH "<TD BGCOLOR=\"#00FFFF\" ALIGN=MIDDLE>$requete_tot</TD>";
          print TABMONTH "<TD BGCOLOR=\"#00FF00\" ALIGN=MIDDLE>$access_tot</TD>";
          print TABMONTH "<TD ALIGN=MIDDLE>$requete_dom</TD>";
          print TABMONTH "</TR>\n";
          close(TABMONTH);
        }
        
        $machine_tot = $m_tot;
        $machine_new = $m_new;
        $machine_dom = $m_dom;
        $requete_tot = $req_tot;
        $access_tot = $access;
        $requete_dom = $req_dom;
        $oldmonth = $month;
	$oldyear = $year;
        $count_month++;
        $line ++;
        }
}

 close(INFILE);

#

$monthindex = $month_equiv{$month};

if ($month_of_year{$month} == $jour) {

$machmaxtot{$count_month} = $machine_tot;
$newmaxtot{$count_month} = $machine_new;
$dommaxtot{$count_month} = $machine_dom;

$machmax = $machine_tot if ($machine_tot > $machmax);

$reqmaxtot{$count_month} = $requete_tot;
$accessmaxtot{$count_month} = $access_tot;
$reqdommaxtot{$count_month} = $requete_dom;

$reqmax = $requete_tot if ($requete_tot > $reqmax);

for ($nblang=0;$nblang<=$#lang;$nblang++) {
   $tabmonth = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamemonth;
#   $taboldmonth = $linkpath.$lang[$nblang].$dirsepurl.$dirdate.$dirsepurl.$oldmonth;
   $taboldmonth = $oldyear."-".$oldmonth;

   $graphline[$count_month] = $taboldmonth if ($nblang == 0);
          
   open(TABMONTH,">>$tabmonth") || die "Error, unable to open $filemonth\n";
   print TABMONTH "<TR><TD ALIGN=CENTER BGCOLOR=\"#E0E0E0\"><A HREF=\"$taboldmonth$htmlext\">" if ($precision > 2);
   print TABMONTH "$oldyear $oldmonth";
   print TABMONTH "</A></TD>" if ($precision > 2);  
   print TABMONTH "<TD BGCOLOR=\"#FFFF00\" ALIGN=MIDDLE>$machine_tot</TD>";
   print TABMONTH "<TD ALIGN=MIDDLE>$machine_new</TD>";
   print TABMONTH "<TD ALIGN=MIDDLE>$machine_dom</TD>";
   print TABMONTH "<TD BGCOLOR=\"#00FFFF\" ALIGN=MIDDLE>$requete_tot</TD>";
   print TABMONTH "<TD BGCOLOR=\"#00FF00\" ALIGN=MIDDLE>$access_tot</TD>";
   print TABMONTH "<TD ALIGN=MIDDLE>$requete_dom</TD>";
   print TABMONTH "</TR>\n";
   close(TABMONTH);
}

$count_month++;
}

        

# fermeture de la page HTML du tableau sur les mois

for ($nblang=0;$nblang<=$#lang;$nblang++) {
  $tabmonth = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnamemonth;
  
  open(TABMONTH,">>$tabmonth") || die "Error, unable to open $filemonth\n";
  &MonthFooter(*TABMONTH, eval($Lang{$lang[$nblang]}));
  close (TABMONTH);
}
$count_month--;

#################################################################
#####           hosts and requests graphs                 #######
#################################################################

if ($precision > 2) {

#################################################################
# Fly

  if (-x $FLY) {
    
    $it = length($count_month)-1;
    $div = 10**$it;
    $factx = ($div*(int($count_month/$div)+1))/$grad;
    
    $factx = 1 if ($it == 0);
    
    $it = length($machmax)-1;
    $div = 10**$it;
    $facty = ($div*(int(($machmax+$perspec)/$div)+1))/$grad;
    
    $fymax = $ymax-1;
    
    $perspec = $xstep/$factx if (($perspec > $xstep/$factx) && ($tridim == 1));
    
    open(FLY,">$tmpfly");
    print FLY "new\n";
    print FLY "size $xmax,$ymax\n";
    print FLY "frect 0,0,0,0,200,200,200\n";
    for ($i=1;$i<=($count_month+$bargraph);$i++) {
      $x1 = ($i-1+$linegraph+$tridim)*$xstep/$factx;
      $x2 = ($i+$linegraph+$tridim)*$xstep/$factx;
      
      $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
      $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
      
      $y2 = $ymax - ($ystep/$facty * $machmaxtot{$i});
      
      if ($bargraph == 1) {
        $x2 -= $perspec if ($tridim == 1);
        $x1 -= $perspec if ($tridim == 1);
        print FLY "frect $x1,$y2,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
        print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
        if ($tridim == 1 && $y2 != $ymax) {
          
          $x1plus = $x1+$perspec;
          $x2plus = $x2+$perspec;
          $y2plus = $y2-$perspec;
          $y1plus = $ymax - $perspec;
          
          print FLY "fpoly $red[0],$green[0],$blue[0],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
          print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
          
          print FLY "fpoly $red[0],$green[0],$blue[0],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
          print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
          
        }
      }
      
      if ($linegraph == 1) {
        $y1 = $ymax - ($ystep/$facty * $machmaxtot{$i+1});
        print FLY "line $x1,$y2,$x2,$y1,$red[0],$green[0],$blue[0]\n";
        
        if ($fillgraph == 1) {
          if ($y1 != $y2 || $y1 != $ymax) {
            print FLY "line $x1,$ymax,$x1,$y2,$red[0],$green[0],$blue[0]\n";
            print FLY "line $x2,$ymax,$x2,$y1,$red[0],$green[0],$blue[0]\n";
            print FLY "line $x1,$ymax,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
            $fx1 = $x1+1;
            
            print FLY "fill $fx1,$fymax,$red[0],$green[0],$blue[0]\n";
          }
        }
      }
      
      $x1 -= $factx*$shift_factor;
      $x2 -= $factx*$shift_factor;
      
      $y2 = $ymax - ($ystep/$facty * $newmaxtot{$i});
      
      if ($bargraph == 1) {
        $x2 -= $perspec if ($tridim == 1);
        $x1 -= $perspec if ($tridim == 1);
        print FLY "frect $x1,$y2,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
        print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
        if ($tridim == 1 && $y2 != $ymax) {
          
          $x1plus = $x1+$perspec;
          $x2plus = $x2+$perspec;
          $y2plus = $y2-$perspec;
          
          print FLY "fpoly $red[1],$green[1],$blue[1],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
          print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
          
          print FLY "fpoly $red[1],$green[1],$blue[1],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
          print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
          
        }
      }
      
      if ($linegraph == 1) {
        $y1 = $ymax - ($ystep/$facty * $newmaxtot{$i+1});
        print FLY "line $x1,$y2,$x2,$y1,$red[1],$green[1],$blue[1]\n";
        
        if ($fillgraph == 1) {
          if ($y1 != $y2 || $y1 != $ymax) {
            print FLY "line $x1,$ymax,$x1,$y2,$red[1],$green[1],$blue[1]\n";
            print FLY "line $x2,$ymax,$x2,$y1,$red[1],$green[1],$blue[1]\n";
            print FLY "line $x1,$ymax,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
            $fx1 = $x1+1;
            
            print FLY "fill $fx1,$fymax,$red[1],$green[1],$blue[1]\n";
          }
        }
      }
      
      $x1 -= $factx*2*$shift_factor;
      $x2 -= $factx*2*$shift_factor;
      
      $y2 = $ymax - ($ystep/$facty * $dommaxtot{$i});
      
      if ($bargraph == 1) {
        $x2 -= $perspec if ($tridim == 1);
        $x1 -= $perspec if ($tridim == 1);
        print FLY "frect $x1,$y2,$x2,$ymax,$red[2],$green[2],$blue[2]\n";
        print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
        if ($tridim == 1 && $y2 != $ymax) {
          
          $x1plus = $x1+$perspec;
          $x2plus = $x2+$perspec;
          $y2plus = $y2-$perspec;
          
          print FLY "fpoly $red[2],$green[2],$blue[2],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
          print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
          
          print FLY "fpoly $red[2],$green[2],$blue[2],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
          print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
          
        }
      }
      
      if ($linegraph == 1) {
        $y1 = $ymax - ($ystep/$facty * $dommaxtot{$i+1});
        print FLY "line $x1,$y2,$x2,$y1,$red[2],$green[2],$blue[2]\n";
        
        if ($fillgraph == 1) {
          if ($y1 != $y2 || $y1 != $ymax) {
            print FLY "line $x1,$ymax,$x1,$y2,$red[2],$green[2],$blue[2]\n";
            print FLY "line $x2,$ymax,$x2,$y1,$red[2],$green[2],$blue[2]\n";
            print FLY "line $x1,$ymax,$x2,$ymax,$red[2],$green[2],$blue[2]\n";
            $fx1 = $x1+1;
            
            print FLY "fill $fx1,$fymax,$red[2],$green[2],$blue[2]\n";
          }
        }
      }
      
    }
    print FLY "transparent 200,200,200\n";
    close (FLY);
    
    open(FOO,"$FLY -q -i $tmpfly -o $outfile1 |");
    while( <FOO> ) {print;}
    close(FOO);
    #unlink($tmpfly);
    
    ### image pour les abscisses
    
    $xlegend = "$count_month months (starting $start_date)";
    
    open(FLY,">$tmpfly");
    print FLY "new\n";
    print FLY "size $xmax,$ydecal\n";
    print FLY "frect 0,0,0,0,200,200,200\n";
    $posx = (($xmax/2)-(length($xlegend)*7/2));
    print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
    for ($i=$xstep;$i<$xmax;$i+=$xstep) {
#      $val = ($monthindex -1 - $count_month) + ($i*$factx/$xstep);
      $val = ($monthindex  - $count_month) + ($i*$factx/$xstep);
      $val--;
      $val += 12 if ($val < 0);
      $val -= 12 if ($val > 11);
      # print STDERR "$val $monthindex $count_month\n";
      $posx = $i - 8;
      print FLY "line $i,0,$i,5,0,0,0\n";
      print FLY "string 0,0,0,$posx,10,small,$month_nb[$val]\n";
    }
    print FLY "transparent 200,200,200\n";
    close (FLY);
    
    open(FOO,"$FLY -q -i $tmpfly -o $outfile1x |");
    while( <FOO> ) {print;}
    close(FOO);
    #unlink($tmpfly);
    
    ### image pour les ordonnees
    
    open(FLY,">$tmpfly");
    print FLY "new\n";
    print FLY "size $xdecal,$ymax\n";
    print FLY "frect 0,0,0,0,200,200,200\n";
    $posy = $ymax - (($ymax/2)-(length("Hosts")/2));
    print FLY "stringup 0,0,0,5,$posy,medium,Hosts\n";
    for ($i=$ystep;$i<$ymax;$i+=$ystep) {
      $valstep = int(($ymax - $i) * ($facty/$ystep));
      # $valstep = "1E6" if ($valstep > 10E+6);
      $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $outfile1y |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);
}
}


#####################  2 ieme GIF  #################################


#################################################################
# Fly

if (-x $FLY) {
  $it = length($count_month)-1;
  $div = 10**$it;
  $factx = ($div*(int($count_month/$div)+1))/$grad;
  
  $factx = 1 if ($it == 0);
  
  $it = length($reqmax)-1;
  $div = 10**$it;
  $facty = ($div*(int(($reqmax+$perspec)/$div)+1))/$grad;
  
  $perspec = $xstep/$factx if (($perspec > $xstep/$factx) && ($tridim == 1));

  ### image pour les abscisses
  
  $xlegend = "$count_month months (starting $start_date)";
  
  open(FLY,">$tmpfly");
  print FLY "new\n";
  print FLY "size $xmax,$ydecal\n";
  print FLY "frect 0,0,0,0,200,200,200\n";
  $posx = (($xmax/2)-(length($xlegend)*7/2));
  print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
  for ($i=$xstep;$i<$xmax;$i+=$xstep) {
#    $val = ($monthindex - 1 - $count_month) + ($i*$factx/$xstep);
    $val = ($monthindex - $count_month) + ($i*$factx/$xstep);
    $val--;
    $val += 12 if ($val < 0);
    $val -= 12 if ($val > 11);
    $posx = $i - 8;
    print FLY "line $i,0,$i,5,0,0,0\n";
    print FLY "string 0,0,0,$posx,10,small,$month_nb[$val]\n";
  }
  print FLY "transparent 200,200,200\n";
  close (FLY);
  
  open(FOO,"$FLY -q -i $tmpfly -o $outfile2x |");
  while( <FOO> ) {print;}
  close(FOO);
  #unlink($tmpfly);

#

  ### image pour les ordonnees
  
  open(FLY,">$tmpfly");
  print FLY "new\n";
  print FLY "size $xdecal,$ymax\n";
  print FLY "frect 0,0,0,0,200,200,200\n";
  $posy = $ymax - (($ymax/2)-(length("Requests")/2));
  print FLY "stringup 0,0,0,5,$posy,medium,Requests\n";
  
  for ($i=$ystep;$i<$ymax;$i+=$ystep) {
    $valstep = int(($ymax - $i) * ($facty/$ystep));
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $outfile2y |");
while( <FOO> ) {print;}
close(FOO);

###
  
  open(FLY,">$tmpfly");
  print FLY "new\n";
  print FLY "size $xmax,$ymax\n";
  print FLY "frect 0,0,0,0,200,200,200\n";
  for ($i=1;$i<=($count_month+$bargraph);$i++) {
    $x1 = ($i-1+$linegraph+$tridim)*$xstep/$factx;
    $x2 = ($i+$linegraph+$tridim)*$xstep/$factx;
    
    $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
    $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
    
    $y2 = $ymax - ($ystep/$facty * $reqmaxtot{$i});
    
    if ($bargraph == 1) {
      $x2 = int($x2 - $perspec) if ($tridim == 1);
      $x1 = int($x1 - $perspec) if ($tridim == 1);
      print FLY "frect $x1,$y2,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
      print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
      if ($tridim == 1 && $y2 != $ymax) {
        
        $x1plus = int($x1+$perspec);
        $x2plus = int($x2+$perspec);
        $y2plus = int($y2-$perspec);
        $y1plus = int($ymax - $perspec);
        
        print FLY "fpoly $red[0],$green[0],$blue[0],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        
        print FLY "fpoly $red[0],$green[0],$blue[0],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        
      }
    }
    
    if ($linegraph == 1) {
      $y1 = $ymax - ($ystep/$facty * $reqmaxtot{$i+1});
      print FLY "line $x1,$y2,$x2,$y1,$red[0],$green[0],$blue[0]\n";
      
      if ($fillgraph == 1) {
        if ($y1 != $y2 || $y1 != $ymax) {
          print FLY "line $x1,$ymax,$x1,$y2,$red[0],$green[0],$blue[0]\n";
          print FLY "line $x2,$ymax,$x2,$y1,$red[0],$green[0],$blue[0]\n";
          print FLY "line $x1,$ymax,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
          $fx1 = $x1+1;
          
          print FLY "fill $fx1,$fymax,$red[0],$green[0],$blue[0]\n";
        }
      }
    }
    
    $x1 -= $factx*$shift_factor;
    $x2 -= $factx*$shift_factor;
    
    $y2 = $ymax - ($ystep/$facty * $accessmaxtot{$i});
    
    if ($bargraph == 1) {
      $x2 = int($x2 - $perspec) if ($tridim == 1);
      $x1 = int($x1 - $perspec) if ($tridim == 1);
      print FLY "frect $x1,$y2,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
      print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
      if ($tridim == 1 && $y2 != $ymax) {
        
        $x1plus = int($x1+$perspec);
        $x2plus = int($x2+$perspec);
        $y2plus = int($y2-$perspec);
        
        print FLY "fpoly $red[1],$green[1],$blue[1],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        
        print FLY "fpoly $red[1],$green[1],$blue[1],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
      }
    }
    
    if ($linegraph == 1) {
      $y1 = $ymax - ($ystep/$facty * $accessmaxtot{$i+1});
      print FLY "line $x1,$y2,$x2,$y1,$red[1],$green[1],$blue[1]\n";
      
      if ($fillgraph == 1) {
        if ($y1 != $y2 || $y1 != $ymax) {
          print FLY "line $x1,$ymax,$x1,$y2,$red[1],$green[1],$blue[1]\n";
          print FLY "line $x2,$ymax,$x2,$y1,$red[1],$green[1],$blue[1]\n";
          print FLY "line $x1,$ymax,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
          $fx1 = $x1+1;
          
          print FLY "fill $fx1,$fymax,$red[1],$green[1],$blue[1]\n";
        }
      }
      
    }
    
    $x1 -= $factx*2*$shift_factor;
    $x2 -= $factx*2*$shift_factor;
    
    $y2 = $ymax - ($ystep/$facty * $reqdommaxtot{$i});
    
    if ($bargraph == 1) {
      $x2 = int($x2 - $perspec) if ($tridim == 1);
      $x1 = int($x1 - $perspec) if ($tridim == 1);
      print FLY "frect $x1,$y2,$x2,$ymax,$red[2],$green[2],$blue[2]\n";
      print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
      if ($tridim == 1 && $y2 != $ymax) {
        
        $x1plus = int($x1+$perspec);
        $x2plus = int($x2+$perspec);
        $y2plus = int($y2-$perspec);
        
        print FLY "fpoly $red[2],$green[2],$blue[2],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        
        print FLY "fpoly $red[2],$green[2],$blue[2],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$ymax\n";
      }
    }
    
    if ($linegraph == 1) {
      $y1 = $ymax - ($ystep/$facty * $reqdommaxtot{$i+1});
      print FLY "line $x1,$y2,$x2,$y1,$red[2],$green[2],$blue[2]\n";
      
      if ($fillgraph == 1) {
        if ($y1 != $y2 || $y1 != $ymax) {
          print FLY "line $x1,$ymax,$x1,$y2,$red[2],$green[2],$blue[2]\n";
          print FLY "line $x2,$ymax,$x2,$y1,$red[2],$green[2],$blue[2]\n";
          print FLY "line $x1,$ymax,$x2,$ymax,$red[2],$green[2],$blue[2]\n";
          $fx1 = $x1+1;
          
          print FLY "fill $fx1,$fymax,$red[2],$green[2],$blue[2]\n";
        }
      }
    }
    
  }
  print FLY "transparent 200,200,200\n";
  close (FLY);
  
  open(FOO,"$FLY -q -i $tmpfly -o $outfile2 |");
  while( <FOO> ) {print;}
  close(FOO);
  #unlink($tmpfly);
}

#################################################################
###          looking for months already processed             ###
#################################################################

$offset = 0;

if ($opt_b == 1) {
  if ($zip == 0) {
    
    $stop = 0;
    $nbmonthscan = 0;
    $monthscan = $month;
  }
 
 if ($zipcut != 0) {   
    $nbmonthscan = 0;
    $monthscan = $month;
    while ($fullyear != $fyear) {
    for ($i=$monthindex;$i<=($#month_nb+$monthindex);$i++) {

      $in = $i;
      $fyear++ if ($in == 12);
      $in -= 12 if ($i > 11);
#      $fyear++ if ($i = ($#month_nb+$monthindex)+1);
      $filetest = $path.$lang[0].$dirsep.$dirdate.$dirsep.$fyear."-".$month_nb[$in];
      $filetest .= $htmlext;

      if (-f $filetest) {
        $nbmonthscan++;
        $newmonth = $in + 1;
	$tmpyear = $fyear;
       $tmpyear-- if ($newmonth > 11);
        $newmonth = 0 if ($newmonth > 11);
       $prevmonthscan = $month_nb[$in];
       $monthscan = $month_nb[$newmonth];
    }
      }
    }

	$monthindex = $month_equiv{$monthscan} if ($zipcut == 2);

    
    print STDOUT "Month to scan : $monthscan $year ($nbmonthscan have been already processed)\n";
    
    ## seeking to the right place in the log file
    
    if ($nbmonthscan != 0) {
      
      # taille du fichier de log

	$monthbis = $month;
#        $year = $fyear;
	$month = $month_equiv{$monthscan};
	$month = "0".$month if (length($month) == 1);
        $lettermonth = $monthscan;
        $file = $fileroot;
	$day = "01" if ($zipcut == 2);
	$smallyear = $year - int($year/100)*100;
	$smallyear = "0".$smallyear if (length($smallyear) == 1);
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}
	       $filezip = $file.$zipext if (-f "$file$zipext");

	$month = $monthbis;
	print STDERR "No more logfile to scan\n" if (!(-f $file) && (!(-f $filezip)));
	exit if (!(-f $file) && (!(-f $filezip)));


	$size = 0;
      ($size)= (stat("$file")) [7] if (!(-f $filezip));

	if ($size != 0) {

#      open(INFILE, "$GZIP $filezip |") if (!(-f $filezip));      
      open(INFILE, $file) || die "Error, unable to open $file\n" if (-f $file);
      
	$scalar = (<INFILE>);
	while ($scalar =~ /^#/) {
	$scalar = (<INFILE>);
	}

 @line_log = split(/$logfile_sep/,$scalar);

 $data = $line_log[$fields_logfile{'%date'}];
 $data = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);
 
      ($firstjour) = split(/:/,$data);
      ($jourstart,$monthstart,$yearstart) = split(/\//,$firstjour);
      
    if ($monthstart eq $monthscan) {
      print STDERR "Your logfile seems to have been cut\nThe $monthscan report will start from $jourstart $monthstart $yearstart\n";
      $offset = 0;
    }

    if ($monthtoday eq $monthscan && $fullyear == $fyear) {
      print STDERR "This month is not yet over\n";
      print STDERR "Wait next month ...\n";
      exit;
    }

    if ($monthstart ne $monthscan) {
    while ($monthstart ne $prevmonthscan) {
      $oldoffset = $offset;
      $offset = int(($offset+$size)/2);
      seek(INFILE,$offset,0);
      $scalar = (<INFILE>);
      $scalar = (<INFILE>);
 
#      ($adresse,$date)=split(/[\[]/,$scalar);

 @line_log = split(/$logfile_sep/,$scalar);

 $date = $line_log[$fields_logfile{'%date'}];
 $date = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

      ($firstjour) = split(/:/,$date);
      ($jourstart,$monthstart,$yearstart) = split(/\//,$firstjour);

#       print STDOUT "$prevmonthscan $monthstart $size $offset $scalar\n";
      }
     }

   close (INFILE);

  }
   }
}

#  if ($zip == 1) {
#    $newmonth = "0".$newmonth unless (length($newmonth) == 2);
#    $oldmonth = $month;
#    $oldyear = $year;
#	$month = $newmonth;
#	$month = "0".$month if (length($month) == 1);
#        $lettermonth = $month_nb[$newmonth-1];	
#        $file = $fileroot;
#	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
#		$compressed_logfile_fields[$i] =~ s/\%/\$/;
#		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
#	}
#	       $filezip = $file.$zipext;
#
#    $month = $oldmonth;
#    $year = $oldyear;
#  }

}

# check for valid month

$opt_b = 0 if ($nbmonthscan == 0);

# detection du premier mois de log zipe

    $yearold = $year;

if (($zip == 1 || $zipcut != 0) && $opt_b != 1) {

while ($out == 0) {
#    while (!(-e $filezip) || !(-e $file)) {
#  do {

$yyear = $year;
#$year = $fyear;
    $monthindex = "0".$monthindex unless (length($monthindex) == 2);
    $testday = "0".$testday unless (length($testday) == 2);    
    $fyear++ if ($monthindex == 13);
    if ($fyear > $fullyear) {
      print "No compressed file found !\n<P>" if ($zip == 1);
      print "No log files found !\n<P>" if ($zip != 1);
      exit;
    }
    $monthindex = "01" if ($monthindex == 13);

    $year = $fyear;
	$month = $monthindex;
	$month = "0".$month if (length($month) == 1);
	$day = $testday;	
        $lettermonth = $month_nb[$monthindex-1];	
        $file = $fileroot;
        $smallyear = $year - int($year/100)*100;
        $smallyear = "0".$smallyear if (length($smallyear) == 1);
	for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
		$compressed_logfile_fields[$i] =~ s/\%/\$/;
		$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
	}
               $out = 1 if (-e $file && $zip == 0);
	       $filezip = $file.$zipext if ($zip == 1);
	$out = 1 if (-e $filezip && $zip == 1);
    $testday++ if ($zipcut == 2);
    if ($testday > $month_of_year{$month_nb[$monthindex-1]} && $zipcut == 2) {
$monthindex++;
$testday = "01";
}    
    $monthindex++ if ($zipcut == 1);
    
  }
#  until (-e $filezip || -e $file);
  $monthindex-- if ($zipcut == 1);  
   $fyear = $year;
   $year = $yyear;   

}

    $year = $yearold;

#######################################################

if ($exclude_robot == 1) { 
    if (-f "$path$dirinc$dirsep$incrobot") {
open(FILEROBOT,"$path$dirinc$dirsep$incrobot") || die "Error, unable to open $path$dirinc$dirsep$incrobot\n";
while (<FILEROBOT>) {
($tmp1,$tmp2) = split(/\t/);

   if ($tmp2 eq '') {
	print "Your robot file is not valid (too old). Run 'cron-session.pl -m' to update it\n";
	exit;
   }

push(@exclude_robot_address,$tmp2) unless ($seen{"$tmp2 $tmp1"}++);
}
#chop($exclude_robot_address);
close(FILEROBOT);

    if ($#exclude_robot_address == -1) {
	$exclude_robot = 0;
	print STDERR "No robot session found !\n";
    }

} else {
    print "Use cron-session.pl first to detect robot session\n";
    exit;
}

}

if ($exclude_frame == 1) {
    if (-f "$path$dirdata$dirsep$dirframe") {
open(FILEFRAME,"$path$dirdata$dirsep$dirframe") || die "Error, unable to open $path$dirdata$dirsep$dirframe\n";
while (<FILEFRAME>) {
    chop;
push(@exclude_page_frame,$_);
}
#chop($exclude_page_frame);
close(FILEFRAME);

    if ($#exclude_page_frame == -1) {
	$exclude_frame = 0;
	print STDERR "No HTML frame pages found !\n";
    }

} else {
    print "Use cron-url.pl first to detect framed pages\n";
    exit;
}
}

#################################################################
###       scanning the log file for a monthly summary         ###
#################################################################

#print STDERR "\nWarning : Reverse dns is on...it will slow down speed !\n" if ($reverse_dns == 1);

$oldmonth = '';

while ($stop == 0) {

print STDOUT "Logfile : $file\n";
print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

if (($zip == 1) && ($filezip ne $file)) {
     open(LOGFILE, "$GZIP $filezip |") || die "Error, unable to open $filezip\n";
#     print STDOUT "Fichier $filezip decompresse\n";
     print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
     } else {
        open(LOGFILE,$file) || die "Error, unable to open $file\n";
        }

#seek(INFILE,$offset,0);

BOUCLE:
while (<LOGFILE>) {
  
  $loglines++;
  
 @line_log = split(/$logfile_sep/);
 chop($line_log[$#line_log]);
 next if ($line_log[0] =~ /^#/);
 
 $data = $line_log[$fields_logfile{'%date'}];
 $data = &date_common($line_log[$fields_logfile{'%date'}],$line_log[$fields_logfile{'%hour'}]) if ($iis_format == 1);

   $adresse = $line_log[$fields_logfile{'%host'}];
   $page = $line_log[$fields_logfile{'%page'}];
   $d = $line_log[$fields_logfile{'%method'}];
   $query = $line_log[$fields_logfile{'%query'}] if ($fields_logfile{'%query'} ne ''); 
   $status = $line_log[$fields_logfile{'%status'}];
   $requetesize = $line_log[$fields_logfile{'%requetesize'}];
   $vserver = $line_log[$fields_logfile{'%virtualhost'}] if ($fields_logfile{'%virtualhost'} ne '');
   $vserver = $1 if ($page =~ /^\/\/([-.0-9a-z]+)\//i && $virtualCLF != 0);
 $vserver = $line_log[$#line_log] if ($#logfile_fields == $fields_logfile{'%virtualhost'});
   $page =~ s/\/\/$virtualfilter// if (($virtualCLF != 0 && $virtualfilter ne '') || ($d =~ /$localserver/));
  $page =~ s/"// if ($requetesize !~ /(\d+)/); 
  next if ($data !~ m/^((\d+)\/(\w+)\/(\d+))(.*)/);
  $status = $1 if ($query =~ /(\d\d\d);http:\/\// && $type_serveur == 1);

  next if ($page !~ /^\//);
  next if ($status !~ /^(\d+)$/);
  next if (($status >= 400) && ($status < 599));
  next if ($status == 304) ; #ote les pages ne contenant rien
  next if ($status == 302) ; #ote les pages ne contenant rien
  next if ($status == 301) ; #redirection automatique

  next if ($adresse eq '');

if ($adresse =~ /\//) {
    ($tmp,$adresse) = split(/:/,$adresse);
    print "Problem : found $tmp ... fixing done\n";
}

  $page =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $page =~ tr/[A-Z]/[a-z]/ if ($type_serveur == 1);

  next if ($page =~ /$excluderepert/i && $excluderepert ne '');

if ($exclude_frame == 1) {
    for ($i=0;$i<=$#exclude_page_frame;$i++) {
	if ($page eq $exclude_page_frame[$i]) {
	    $exclframed++ ;
	    next BOUCLE;
	}
    }
}

#  next if ($page =~ /$exclude_page_frame/i && ($exclude_frame == 1));

  next if ($page !~ m#$tri#);   # stats sur une partie du serveur
  next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
  next if ($d =~ /$localserver/ && $vserver ne '');
  next if ($vserver =~ /$excludevirtual/i && $excludevirtual ne '');
  next if ($vserver !~ /$virtualfilter/i && $virtualfilter ne '' && $vserver ne '');     
#  next if ($requetesize == 0) ; #ote les pages ne contenant rien
    next if ($status !~ /^(\d+)$/);
    next if ($page =~ /$dirsepurl[_]/ && $type_serveur == 1);
    next if ($page =~ /"$/ && $iis_format != 1); # all format should be %page %protocol
    next if ($d !~ /^"/ && $iis_format != 1); # all format should be %page %protocol

($tmp) = split(/:/,$data);
($daytoday,$monthtoday,$yeartoday) = split(/\//,$tmp);
next if ($month_equiv{$monthtoday} !~ /(\d+)/);
next if (length($yeartoday) != 4);

  $adresse = $nis{$adresse} if ($nis{$adresse} ne '');
  $adresse = &reversedns($adresse) if ($reverse_dns == 1 && $adresse =~ /^[0-9.]+$/);
  $adresse = $adresse.".".$localdomainename if (split(/[.]/,$adresse) == 1);
  
  next if (($adresse =~ m/$localdomaine/i) && ($locallog == 0));           
  next if (($adresse !~ m/$localdomaine/i) && ($localonly == 1));    
  next if (($adresse =~ /$nolog/i) && ($nolog ne ''));

if ($exclude_robot == 1) {
    for ($i=0;$i<=$#exclude_robot_address;$i++) {
	if ($adresse eq $exclude_robot_address[$i]) {
	    $exclrobots++ ;
	    next BOUCLE;
	}
    }
}
#  next if ($adresse =~ /$exclude_robot_address/i && ($exclude_robot == 1));

  $page .= $defaulthomepage if (substr($page,length($page)-1) eq "/");
  $page = $page."?".$query if ($query ne '' && $query ne '-,');
             
  ($jour,$heure,$minute,$seconde) = split(/:/,$data);
  ($day,$month,$year) = split(/\//,$jour); 
  $monthindex = $month_equiv{$month};
  $monthindex = "0".$monthindex unless (length($monthindex) == 2);
#  next if ($month ne $monthscan && $opt_b == 1 && $zipcut != 2);
           
if ($oldmonth eq '') {
    $oldmonth = $month;
    $oldyear = $year;
    $monthindexold = $monthindex;
    $monthindexold = "0".$monthindexold unless (length($monthindexold) == 2);
}

# maximum : 9 champs dans une adresse !

$pays = substr($adresse,rindex($adresse,'.')+1,length($adresse));
$pays =~ tr/A-Z/a-z/;
next if (length($pays) > 4);

next if ($pays ne $country_filtering && $country_filtering ne '');

#$page =~ tr/A-Z/a-z/;
$adresse =~ tr/A-Z/a-z/;

####################################################
# tri et creation de la page pour le mois en cours #
####################################################

if (($month ne $oldmonth && ((($year*12)+$month_equiv{$month}) > (($oldyear*12)+$month_equiv{$oldmonth}))) || (($monthindex ne $monthindexold))) { #&& (($year*12)+$monthindex) > (($oldyear*12)+$monthindexold)))) {

#	print STDOUT "Computing stats for $oldmonth $oldyear\n";
#	print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
	&nextmonth;

# Pages

foreach $tmp (keys(%pageslues)) {
$countpageslues[$pageslues{$tmp}] = 0;
}
undef %occur_counterpageslues;
undef %pageslues;
undef @counterpageslues;

# Hosts

foreach $tmp (keys(%server)) {
$countserver[$server{$tmp}] = 0;
}

undef %occur_counterserver;
undef %server;
undef @counterserver;

# Local Hosts

	if ($locallog != 0) {
foreach $tmp (keys(%localserver)) {
$countlocserver[$localserver{$tmp}] = 0;
}

undef %occur_counterlocserver;
undef %localserver;
undef @counterlocserver;
}

# Countries

foreach $tmp (keys(%payslist)) {
$countpays[$payslist{$tmp}] = 0;
}

undef %occur_counterpays;
undef %payslist;
undef @counterpays;

}

####################################################

$domreq++ unless ($adresse !~ m/$localdomaine/);
$reqtot++;

### liste des serveurs de ce mois
$server{$adresse}++ unless ($adresse =~ m/$localdomaine/);
$localserver{$adresse}++ unless ($adresse !~ m/$localdomaine/);
if ((($server{$adresse}) == 1) || ($localserver{$adresse} == 1)) {
   $listadresse[$serverunique] = $adresse;
   $serverunique++ if ($adresse !~ m/$localdomaine/);
   $locserver++ if ($adresse =~ m/$localdomaine/);
 }

### liste des pages lues de ce mois
#for ($i=0;$i<=($#extension);$i++) {
    if (substr($page,rindex($page,'.')) =~ /$extension/i) {
    $accesslues++;
    $accessmois++;
    $pageslues{$page}++;
    $pageunique++ unless ($pageslues{$page} != 1) ;
     }
#   }

### liste des acces par pays
$pays = "Unknown" if ($pays =~ /^[0-9]+/);
$payslist{$pays}++;
$paysunique++ if ($payslist{$pays} == 1);
}


close(LOGFILE);


# mois gzip suivant

$stop = 1 if (($zip != 1 && $zipcut == 0) || ($file eq $filezip));

if ($zip == 1 || $zipcut != 0) { # && $opt_b != 1) {

$yyear = $year;
$year = $fyear;

$monthindexold = $monthindex;
$monthindexold = "0".$monthindexold unless (length($monthindexold) == 2);
$monthtm = $month;
#$oldyear = $year;

if ($file ne $filezip) {

&nextlog;

if ($zip == 0) {
    if ($zipcut == 2) {
    &nextlog while (!(-f $file) && $file ne $filetmpzip);
$stop = 1 if ($file eq $filetmpzip);
}
}

if ($zip == 1) {
   if (-e $filezip) {
       } else {
    if ($zipcut == 2) {
	&nextlog while (!(-f $filezip) && $filezip ne $filetmpzip);
	$stop = 1 if ($filezip eq $filetmpzip);

    } else {       
          $filezip = $fileroot.$prefixlog;
          $file = $filezip;
	  $stop = 1 if (!(-f $file));
    }
    }
} else {
   if (-e $file && $zipcut != 0) {
   } else {
          $stop = 1 if (!(-f $file));
   }
}

}
   $fyear = $year;
   $year = $yyear;    

	  $month = $monthtm;
#	  $year = $oldyear;

}

#############################################################################

&save_reverse_dns if ($reverse_dns == 1); # sauvegarde de la table de DNS

sub nextlog {

$day++ if ($zipcut == 2);
$day = "0".$day unless (length($day) == 2);

$monthindex++ if ($zipcut == 1);
$monthprev = $monthindex-1 if ($zipcut == 1);
$monthindex = "0".$monthindex unless (length($monthindex) == 2);

if ($day > $month_of_year{$month_nb[$monthprev]} && $zipcut == 2) {
$monthindex++;
$monthprev++;
$day = "01";
}

$fyear++ if ($monthindex == 13);
$year++ if ($monthindex == 13);
$monthindex = "01" unless ($monthindex != 13);
$monthprev = $monthindex-1;
$monthprev = 0 if ($month == 1);

$month = $monthindex;

$lettermonth =  $month_nb[$monthprev];
$file = $fileroot;
$smallyear = $year - int($year/100)*100;
$smallyear = "0".$smallyear if (length($smallyear) == 1);
for ($i=1;$i<=$#compressed_logfile_fields;$i++) {
$compressed_logfile_fields[$i] =~ s/\%/\$/;
$file .= eval($compressed_logfile_fields[$i]).$compressed_sep_fields[$i];
}

	       $filezip = $file.$zipext;

}

}

#print STDOUT "Computing stats for $month $year\n";
#print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

if ($month_of_year{$month} == $day) {
$count_month++;
&nextmonth;
}

$affmois = $prevmonthscan if ($opt_b != 0);

for ($nblang=0;$nblang<=$#lang;$nblang++) {

        $statmonth = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$statnamemonth;
#        $datpath = $linkpath.$lang[$nblang].$dirsepurl.$dirdate;

        open(STATMONTH,">$statmonth") || die "Error, unable to open $statmonth\n";
        &MonthStats(*STATMONTH, eval($Lang{$lang[$nblang]}), $count_month);
 
close(STATMONTH);
}

unlink($tmpfly);

# calculer le temps mis pour le calcul

$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
($hour,$minute,$second) = split(/:/,$hourdate);

$endrun = "$hour:$minute:$second";

($min,$sec) = &timetaken($startrun,$endrun);

$endtime = time();
#printf STDOUT "Computing took %d CPU secondes\n",$endtime - $starttime;
#print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print STDOUT "Real time took $min min $sec sec\n\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

open(FILE,">>$history");
#print FILE "cron-month\t$today\t$startrun\t$endrun\t$min:$sec\t$loglines\n";
printf FILE "cron-month\t%s\t%s\t%s\t%d:%d\t%d\n",$today,$startrun,$endrun,$min,$sec,$loglines;
close(FILE);

########################################################################################
sub nextmonth {

# Tri Pages

$bouclepages = $topten unless ($pageunique < $topten);
$bouclepages = $pageunique unless ($pageunique > ($topten-1));

foreach $tmp (sort (keys(%pageslues))) {
    push(@counterpageslues,$pageslues{$tmp}) unless $seen{"$oldmonth $tmp $pageslues{$tmp}"}++;
    $countpageslues[$pageslues{$tmp}]++;
    $occur_counterpageslues{$pageslues{$tmp},$countpageslues[$pageslues{$tmp}]} = $tmp;
}

@bestpage = reverse sort bynumber @counterpageslues;

# Tri Hosts

$boucleservers = $topten unless ($serverunique < $topten);
$boucleservers = $serverunique unless ($serverunique > ($topten-1));

foreach $tmp (sort (keys(%server))) {
    push(@counterserver,$server{$tmp}) unless $seen{"$oldmonth $tmp $server{$tmp}"}++;
    $countserver[$server{$tmp}]++;
    $occur_counterserver{$server{$tmp},$countserver[$server{$tmp}]} = $tmp;
}

@bestserver = reverse sort bynumber @counterserver;

# Tri Local Hosts

if ($locallog != 0) {
$bouclelocservers = $topten unless ($locserver < $topten);
$bouclelocservers = $locserver unless ($locserver > ($topten-1));

foreach $tmp (sort (keys(%localserver))) {
    push(@counterlocserver,$localserver{$tmp}) unless $seen{"$oldmonth $tmp $localserver{$tmp}"}++;
    $countlocserver[$localserver{$tmp}]++;
    $occur_counterlocserver{$localserver{$tmp},$countlocserver[$localserver{$tmp}]} = $tmp;
}

@bestlocserver = reverse sort bynumber @counterlocserver;
}

# Tri Countries

$bouclepays = $topten unless ($paysunique < $topten);
$bouclepays = $paysunique unless ($paysunique > ($topten-1));

foreach $tmp (sort (keys(%payslist))) {
    push(@counterpays,$payslist{$tmp}) unless $seen{"$oldjour $tmp $payslist{$tmp}"}++;
    $countpays[$payslist{$tmp}]++;
    $occur_counterpays{$payslist{$tmp},$countpays[$payslist{$tmp}]} = $tmp;
}

@bestpays = reverse sort bynumber @counterpays;

$affmois = $oldmonth;
$oldmonth = $oldyear."-".$oldmonth.$htmlext;

if ($precision > 2) {

  for ($nblang=0;$nblang<=$#lang;$nblang++) {
    $taboldmonth = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$oldmonth;
    
    open(TABOLDMONTH,">$taboldmonth") || die "Error, unable to open $taboldmonth\n";
    &printmois(*TABOLDMONTH, eval($Lang{$lang[$nblang]}));
    close(TABOLDMONTH);
    }
}

$oldmonth = $month;
$monthindexold = $monthindex;
$oldyear = $year;
$domreq = 0;
$reqtot = 0;
for ($i=0;$i< $serverunique;$i++) {
   $server{$adresse} = 0;
   }
for ($i=0;$i< $locserver;$i++) {
   $localserver{$adresse} = 0;
}
for ($i=0;$i< $pageunique;$i++) {
   $pageslues{$page} = 0;
}
for ($i=0;$i< $paysunique;$i++) {
   $payslist{$pays} = 0;
}
$serverunique = 0;
$locserver = 0;
$pageunique = 0;
$paysunique = 0;
$accessmois = 0;
}


########################################################################################
sub MonthHeader {
  local(*FOUT,*L) = @_;
  
  print FOUT "<HTML><HEAD>\n";
  print FOUT "<TITLE>$L{'About_months'}</TITLE>\n";
  print FOUT "<!-- Page generated by w3perl - cron-month.pl $version - $today $hourdate -->\n";
  print FOUT "</HEAD>\n";
  print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
  print FOUT "<H1> $L{'About_months'}</H1><P>\n";
  print FOUT "<P><HR><P>\n";
  print FOUT "<TABLE BORDER=1 WIDTH=100%>\n";
  print FOUT "<TR>\n";
  print FOUT "<TH>$L{'Date'}</TH>\n";
  print FOUT "<TH BGCOLOR=\"#FFFF00\">$L{'Hosts'}</TH>\n";
  print FOUT "<TD ALIGN=CENTER><B>$L{'New_Hosts'}</B><BR><I><FONT SIZE=-1>(From start)</FONT></I></TD>\n";
  print FOUT "<TH>$L{'Domain_Hosts'}</TH>\n";
  print FOUT "<TH BGCOLOR=\"#00FFFF\">$L{'Requests'}</TH>\n";
  print FOUT "<TH BGCOLOR=\"#00FF00\">$L{'Accesses'}</TH>\n";
  print FOUT "<TH>$L{'DomReq'}</TH>\n";
  print FOUT "</TR>\n";
}

sub MonthFooter {
  local(*FOUT) = $_[0];
  print FOUT "</TABLE>\n";
  print FOUT "<P><HR><P>\n";
  print FOUT "</BODY></HTML>\n";
}

sub MonthStats {
  local(*FOUT,*L, $count_month) = @_;
  print FOUT "<HTML><HEAD>\n";
  print FOUT "<TITLE>$L{'Stats_about_months'}</TITLE>\n";
  print FOUT "<!-- Page generated by w3perl - cron-month.pl $version - $today $hourdate -->\n";
  print FOUT "</HEAD>\n";
  print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
  
  print FOUT "<CENTER>\n";
  print FOUT "<TABLE BORDER=0 WIDTH=100\%>\n";
  print FOUT "<TR>\n";
  print FOUT "<TD ALIGN=LEFT>\n";
  print FOUT "<A HREF=\"#utilisateur\">$L{'Users'}</A><br><br>\n" if ($precision > 2);
  print FOUT "<A HREF=\"$year-$affmois$htmlext\">$L{'Month_of'}$affmois $year</A><br><br>\n" if ($precision > 2);
  print FOUT "</TD>\n";
  print FOUT "<TD ALIGN=CENTER>\n";
  print FOUT "<TABLE BORDER=8 CELLPADDING=1><tr><td>\n";
  print FOUT "<TABLE BORDER=8 CELLPADDING=3><tr><td>\n";
  print FOUT "<TABLE BORDER=8 CELLPADDING=5><tr><td>\n";
  print FOUT "<H1><CENTER>$L{'Stats'} <br>$L{'about'} $L{'Months'}</CENTER>\n";
  print FOUT "</TD></TR></TABLE>\n";
  print FOUT "</TD></TR></TABLE>\n";
  print FOUT "</TD></TR></TABLE>\n";
  print FOUT "</H1>\n";
  print FOUT "</TD>\n";
  print FOUT "<TD ALIGN=RIGHT><A HREF=\"#requete\">$L{'Requests'}</A><br><br>\n";
  print FOUT "<A HREF=\"$tabnamemonth\">$L{'Table'} $L{'of_months'}</A><br><br>\n";
  print FOUT "</TD>\n";
  print FOUT "</TR>\n";
  print FOUT "</TABLE>\n";
  print FOUT "</CENTER>\n";
  
  if ($precision > 2) {
    print FOUT "<A NAME=\"utilisateur\">\n";
    
    if  (-x $FLY) {
      print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
      print FOUT "<TR>\n";
      print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkoutfile1y\"></TD>\n";
      print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkoutfile1\" BORDER=0 USEMAP=\"#month1\"></TD>\n";
      print FOUT "</TR><TR><TD></TD>\n";
      print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkoutfile1x\"></TD>\n";
      print FOUT "</TR><TR><TD></TD>\n";
      print FOUT "<TD ALIGN=CENTER>\n";

      print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
    print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[0]\"></TD>\n";
    print FOUT "<TD>&nbsp; $L{'Number_of'} $L{'Conn_Mach'}</TD>\n";
    print FOUT "</TR><TR>\n";
    print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"></TD>\n";
    print FOUT "<TD>&nbsp; $L{'Number_of'} $L{'New_Mach'}</TD>\n";
    print FOUT "</TR><TR>\n";    
    print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"></TD>\n";
    print FOUT "<TD>&nbsp; $L{'Number_of'} $L{'Mach_Dom'} $localdomainename</TD>\n";
    print FOUT "</TR></TABLE>\n";
    
      print FOUT "</TD></TR></TABLE></CENTER>\n";
    }
    
    }
  
  print FOUT "<A NAME=\"requete\">\n";
  
  if (-x $FLY)  {
    print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
    print FOUT "<TR>\n";
    print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkoutfile2y\"></TD>\n";
    print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkoutfile2\" BORDER=0 USEMAP=\"#month2\"></TD>\n";
    print FOUT "</TR><TR><TD></TD>\n";
    print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkoutfile2x\"></TD>\n";

      print FOUT "</TR><TR><TD></TD>\n";
      print FOUT "<TD ALIGN=CENTER>\n";

      print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
        print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[0]\"></TD>\n";
        print FOUT "<TD>&nbsp; $L{'No_Ttl_Req_Mnth'}</TD>\n";
    print FOUT "</TR><TR>\n";        
        print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\"></TD>\n";
        print FOUT "<TD>&nbsp; $L{'No_HTML_Acc'}</TD>\n";
    print FOUT "</TR><TR>\n";                
        print FOUT "<TD><IMG WIDTH=$square HEIGHT=$square SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\"></TD>\n";
        print FOUT "<TD>&nbsp; $L{'NoReq'} $L{'from_dom'} $localdomainename</TD>\n";      
    print FOUT "</TR></TABLE>\n";
    
      print FOUT "</TD></TR></TABLE></CENTER>\n";   
  }
  

        print FOUT "<P><HR>\n";
        if ($count_month != 1) {
        print FOUT "$L{'A_description'} <A HREF=\"$tabnamemonth\">$L{'MonthByMonth'}</A> $L{'More_Precise'}\n";

        print FOUT "<HR><P>\n";
        }


# USEMAP Month1

$num = 1;
$line = 0;

print FOUT "<MAP NAME=\"month1\">\n";
open(FLY,"$tmpfly");
while (<FLY>) {

if ($_ =~ /^rect/) {

   $line++;
   $line = 1 if ($line == 4);

if ($line == 1) {

   ($tmp,$x1,$tmp,$x2) = split(/[ ,]/);
   $x1 = 0 if ($x1 < 0);
   $x1 = int($x1);
   $x2 = int($x2);

print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$graphline[$num]$htmlext\">\n" if ($graphline[$num] ne '');
   $num++;
}
}
}
print FOUT "</MAP>\n";

# USEMAP Month2

$num = 1;
$line = 0;

print FOUT "<MAP NAME=\"month2\">\n";
open(FLY,"$tmpfly");
while (<FLY>) {

if ($_ =~ /^rect/) {

   $line++;
   $line = 1 if ($line == 4);

if ($line == 1) {

   ($tmp,$x1,$tmp,$x2) = split(/[ ,]/);
   $x1 = 0 if ($x1 < 0);
   $x1 = int($x1);
   $x2 = int($x2);

print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$graphline[$num]$htmlext\">\n" if ($graphline[$num] ne '');
   $num++;
}
}
}
print FOUT "</MAP>\n";

        print FOUT "</BODY></HTML>\n";
        close FOUT;
}

sub printmois {
  local(*FOUT,*L) = @_;
  print FOUT "<HTML><HEAD>\n";
  print FOUT "<TITLE>$L{'Stats_aboutMnth'} $affmois $oldyear</TITLE>\n";
  print FOUT "<!-- Page generated by w3perl - cron-month.pl $version - $today $hourdate -->\n";
  print FOUT "</HEAD>\n";
  print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\"VLINK=\"$custom_vlink\">\n";
  print FOUT "<H1> $L{'Stats'} $L{'about'} $affmois $oldyear</H1><P>\n";
  print FOUT "<P><HR>\n";
  print FOUT "<TABLE BORDER=1><TR>";
  print FOUT "<TD>$L{'Hits'}</TD><TD>$reqtot</TD></TR>";
  print FOUT "<TR><TD>$L{'Number_of_different_sites'}</TD><TD ALIGN=RIGHT>$serverunique</TD></TR>\n";
  print FOUT "<TR><TD>$localdomainename</TD><TD ALIGN=RIGHT>$domreq</TD></TR>\n" if ($locallog != 0 && $domreq != 0);
  print FOUT "<TR><TD>$L{'HTML_accesses'}</TD><TD ALIGN=RIGHT>$accessmois</TD></TR>\n";
  print FOUT "</TABLE><HR><P>\n";
  print FOUT "$L{'The_Top'} $topten $L{'pages'} ($L{'among'} $pageunique) $L{'MostSuccesf'} :<P><UL>\n";
  
  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
  print FOUT "<TH ALIGN=CENTER><FONT SIZE=-1>$L{'Pages'}</FONT></TH><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Occurence'}</FONT></TH></TR>\n";
$tmp = 0;
  $i = 0;
while ($tmp < $bouclepages && $bestpage[$i] != 0) {
for ($j=1;$j<= $countpageslues[$bestpage[$i]];$j++) {
$tmp++;
last if ($tmp > $bouclepages);
$adresse = $occur_counterpageslues{$bestpage[$i],$j};
    print FOUT "<TR><TD><A HREF=\"$adresse\">";
    print FOUT "$adresse" if ($titlename == 0);
    print FOUT "<b>$urlconv{$adresse}</b>" if ($titlename == 1 && $urlconv{$adresse} ne '');
    print FOUT "$adresse" if ($titlename == 1 && $urlconv{$adresse} eq '');
    print FOUT "</A>&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$bestpage[$i]</B> $L{'times'}</TD></TR>\n";
}
$i += $countpageslues[$bestpage[$i]];
}

  print FOUT "</TABLE></UL>\n<P><HR><P>\n";
  print FOUT "<I>$L{'The_Top'} $topten $L{'resolved_countries'} ($L{'among'} $paysunique)</I>:<P><UL>\n";

  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
  print FOUT "<TH ALIGN=CENTER><FONT SIZE=-1>$L{'Countries'}</FONT></TH><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Occurence'}</FONT></TH></TR>\n";

$tmp = 0;
  $i = 0;

while ($tmp < $bouclepays && $bestpays[$i] != 0) {
for ($j=1;$j<= $countpays[$bestpays[$i]];$j++) {
    $tmp++;
    last if ($tmp > $bouclepays);
    $pays = $occur_counterpays{$bestpays[$i],$j};
    print FOUT "<TR><TD>";
    print FOUT "<A HREF=\"..$dirsepurl$dirpays$dirsepurl$flagpage{$pays}\">" if ($precision > 2);
    print FOUT "$L{$newflag{$pays}}";
    print FOUT "</A>" if ($precision > 2);
    print FOUT " (<I>$pays</I>)";
    print FOUT "&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$bestpays[$i]</B> $L{'times'}</TD></TR>\n";
}
$i += $countpays[$bestpays[$i]];
}

  print FOUT "</TABLE>\n";

  if ($locallog != 0 && $locserver != 0) {
    print FOUT "</UL>\n<P><HR><P>\n";
    print FOUT "<I>$L{'The_Top'} $topten $L{'Mhosts'} ($L{'among'} $locserver) $L{'from_dom'} $localdomainename :</I><P><UL>\n";


  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
  print FOUT "<TH ALIGN=CENTER><FONT SIZE=-1>$L{'Domain_Hosts'}</FONT></TH><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Occurence'}</FONT></TH></TR>\n";
$tmp = 0;
$i = 0;
while ($tmp < $bouclelocservers && $bestlocserver[$i] != 0) {
for ($j=1;$j<= $countlocserver[$bestlocserver[$i]];$j++) {
$tmp++;
last if ($tmp > $bouclelocservers);
$adresse = $occur_counterlocserver{$bestlocserver[$i],$j};
print FOUT "<TR><TD>$adresse&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$bestlocserver[$i]</B>\n";
print FOUT "$L{'request'}" if ($bestlocserver[$i] == 1);
print FOUT "$L{'requests'}" if ($bestlocserver[$i] != 1);
print FOUT "</TD></TR>\n";
}
$i += $countlocserver[$bestlocserver[$i]];
}

     }
  
  print FOUT "</TABLE></UL>\n<P><HR><P>\n";
  print FOUT "<I>$L{'The_Top'} $topten $L{'Mhosts'} ($L{'among'} $serverunique) $L{'external'}</I>:<P><UL>\n";

  print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
  print FOUT "<TH ALIGN=CENTER><FONT SIZE=-1>$L{'Hosts'}</FONT></TH><TH ALIGN=CENTER><FONT SIZE=-1>$L{'Occurence'}</FONT></TH></TR>\n";
  
$tmp = 0;
$i = 0;
while ($tmp < $boucleservers && $bestserver[$i] != 0) {
for ($j=1;$j<= $countserver[$bestserver[$i]];$j++) {
$tmp++;
last if ($tmp > $boucleservers);
$adresse = $occur_counterserver{$bestserver[$i],$j};
print FOUT "<TR><TD>$adresse&nbsp;</TD><TD ALIGN=RIGHT>&nbsp;<B>$bestserver[$i]</B>\n";
print FOUT "$L{'request'}" if ($bestserver[$i] == 1);
print FOUT "$L{'requests'}" if ($bestserver[$i] != 1);
print FOUT "</TD></TR>\n";
}
$i += $countserver[$bestserver[$i]];
}

print FOUT "</TABLE></UL>\n";
print FOUT "</BODY></HTML>\n";
}


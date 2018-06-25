#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                     WEEKLY STATS                               #####
####                                                                #####
####                    (http server)                               #####
####                                                                #####
####    domisse@w3perl.com                   version 16/08/2000     #####
####                                                                #####
#########################################################################

$version = "2.72";
$verdate = "15/08/00";

$shift_factor = 0.3;

############ script to launch at 00 hours 01 minutes every monday ##########

require "/home/domisse/public_html/w3perl/libw3perl.pl";

$starttime = time();
print "Weekly stats : $version\n";
print "<P>" if ($ENV{'REQUEST_METHOD'} eq "GET");

### today date

$datesyst = &ctime(time);
($dayletter,$month,$day,$hourdate,$a,$year) = split(/[ \t\n\[]+/,$datesyst);
$year = $a if ($year eq '');
$day = "0".$day if (length($day) == 1);
$today = $day."/".$month."/".$year;
($hour,$minute,$second) = split(/:/,$hourdate);

# calculer le temps mis pour le calcul
$startrun = "$hour:$minute:$second";

#################################################################
###            parsing the command line option                ###
#################################################################

#&Getopt('glp');

# no argument cmds line

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
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
      print STDOUT "        -p <level>            : precision level (from 1 to 4)\n";
      print STDOUT "        -x                    : show default value for flag options\n";
      print STDOUT "        -v                    : version\n";
      print STDOUT "\n";
      exit;
}

if ($opt_v == 1) {
      print STDOUT "cron-week.pl version $version $verdate\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -c            : $configfile\n";
      print STDOUT "          -g <graphic>  : $graphic[0]\n";
      print STDOUT "          -l <language> : ";
      for ($i=0;$i<$#lang;$i++) {
      print STDOUT "$lang[$i],";
      }
      print STDOUT "$lang[$#lang]\n";      
      print STDOUT "          -p <level>    : $precision\n";
      print STDOUT "          -v            : $version\n";
      exit;
}


if ($opt_l ne '') {
  @lang = split(/, /,$opt_l);
  for ($i=0;$i<=$#lang;$i++) {
      $tmp = $dirress.$dirsep."lang".$dirsep.$lang[$i].$plext;
      $tmp = $pathinit.$tmp;
      require "$tmp";
  }
  if ($lang[0] eq '') {
      print STDERR "\nNone of your language choices have been yet translated !\n";
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

$dir = $path.$dirtmp;
mkdir ($dir,0775) unless -d $dir;

$dir = $path.$dirgraph;
mkdir ($dir,0775) unless -d $dir;

$outfile1 = $path.$dirgraph.$dirsep."week_mach".$gifext;
$outfile1x = $path.$dirgraph.$dirsep."week_machx".$gifext;
$outfile1y = $path.$dirgraph.$dirsep."week_machy".$gifext;

$linkoutfile1 = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."week_mach".$gifext;
$linkoutfile1x = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."week_machx".$gifext;
$linkoutfile1y = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."week_machy".$gifext;

$outfile2 = $path.$dirgraph.$dirsep."week_req".$gifext;
$outfile2x = $path.$dirgraph.$dirsep."week_reqx".$gifext;
$outfile2y = $path.$dirgraph.$dirsep."week_reqy".$gifext;

$linkoutfile2 = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."week_req".$gifext;
$linkoutfile2x = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."week_reqx".$gifext;
$linkoutfile2y = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl."week_reqy".$gifext;

$file3 = $path.$dirgraph.$dirsep.$statweekrepert.$gifext;
$file3x = $path.$dirgraph.$dirsep.$statweekrepert."x".$gifext;
$file3y = $path.$dirgraph.$dirsep.$statweekrepert."y".$gifext;

$linkfile3 = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert.$gifext;
$linkfile3x = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert."x".$gifext;
$linkfile3y = "..".$dirsepurl."..".$dirsepurl.$dirgraph.$dirsepurl.$statweekrepert."y".$gifext;


#################################################################

# # # # # # # # # # # #   weekly stats    # # # # # # # # # # # #


#################################################################
#####               computing weekly stats                 ######
#################################################################

for ($nblang=0;$nblang<=$#lang;$nblang++) {

        $tabweek = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnameweek;

        open(TABWEEKS,">$tabweek") || die "Error, unable to open $tabweek\n";
        &WeekHeader(*TABWEEKS, eval($Lang{$lang[$nblang]}));
        close(TABWEEKS);
        }

 open(INFILE, "$path$dirdata$dirsep$datafile") || die "Error, unable to open $path$dirdata$dirsep$datafile\n";

 $line = 0;
 $count_day = 0;
 $count_week = 1;

 while (<INFILE>) {
     $line++;
     next unless ($line > 3);

     $count++;

     $oldjour = $jour;
     $oldmonth = $month;

     $count_day++;

     ($jour,$month,$year,$m_tot,$m_new,$m_dom,$req_tot,$req_dom,$access) = split('\s+');

     $start_date = $jour." ".$month." ".$year if ( $line == 4);
     $past_date = $jour." ".$month." ".$year if ( $line == 4);
     $current_date = $jour." ".$month." ".$year;
     
     ### test sur le jour suivant

     $intervalle = $jour - $oldjour;
     if ($intervalle != 1 && $line > 4) {
        if ($oldmonth ne $month) {
        $intervalle = $month_of_year{$oldmonth} - $oldjour; # suppose le mois suivant
        $intervalle += $jour;
             }
     $count+=$intervalle-1;
     $count_day += $intervalle-1;
     }

     if ( $count_day <  8) {
          $machine_tot = $machine_tot + $m_tot;
          $machine_dom = $machine_dom + $m_dom;
          $machine_new = $machine_new + $m_new;
          $requete_tot = $requete_tot + $req_tot;
          $access_tot = $access_tot + $access;
          $requete_dom = $requete_dom + $req_dom;
	  $pre_date = $current_date;
          }
      else {

        $machmaxtot{$count_week} = $machine_tot;
        $newmaxtot{$count_week} = $machine_new;
        $dommaxtot{$count_week} = $machine_dom;

        $machmax = $machine_tot if ($machine_tot > $machmax);

        $reqmaxtot{$count_week} = $requete_tot;
        $accessmaxtot{$count_week} = $access_tot;
        $reqdommaxtot{$count_week} = $requete_dom;

        $reqmax = $requete_tot if ($requete_tot > $reqmax);

        for ($nblang=0;$nblang<=$#lang;$nblang++) {
                $tabweek = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnameweek;
          
                open(TABWEEK,">>$tabweek") || die "Error, unable to open $filemonth\n";
                print TABWEEK "<TR><TD BGCOLOR=\"#E0E0E0\" ALIGN=CENTER><A NAME=\"$count_week\"><I>$past_date - $pre_date</I></TD>";
		$past_date = $current_date;
		print TABWEEK "<TD BGCOLOR=\"#FFFF00\" align=CENTER>$machine_tot</TD>";
		print TABWEEK "<TD ALIGN=CENTER>$machine_new</TD>";
		print TABWEEK "<TD ALIGN=CENTER>$machine_dom</TD>";
		print TABWEEK "<TD BGCOLOR=\"#00FFFF\" align=CENTER>$requete_tot</TD>";
		print TABWEEK "<TD BGCOLOR=\"#00FF00\" align=CENTER>$access_tot</TD>";
		print TABWEEK "<TD ALIGN=CENTER>$requete_dom</TD>";
		print TABWEEK "</TR>\n";
                close(TABWEEK);
        }
        
        $machine_tot = $m_tot;
        $machine_new = $m_new;
        $machine_dom = $m_dom;
        $requete_tot = $req_tot;
        $access_tot = $access;
        $requete_dom = $req_dom;
        $count_day -= 7;   # suppose un intervalle inferieur a 7 !

        $count_week++;
        $line ++;
        }
}


 close(INFILE);


# fermeture de la page HTML du tableau sur les jours
for ($nblang=0;$nblang<=$#lang;$nblang++) {
  $tabweek = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$tabnameweek;
  
  open(TABWEEK,">>$tabweek") || die "Error, unable to open $tabweek\n";
  &WeekFooter(*TABWEEK, eval($Lang{$lang[$nblang]}));
  close (TABWEEK);
}

$count_week--;

#################################################################
#####           hosts and requests graphs                 #######
#################################################################

#################################################################
# Fly

if ($count > 14) {
if ($precision > 2) {

#if (-x $FLY) {

$it = length($count_week)-1;
$div = 10**$it;
$factx = ($div*(int($count_week/$div)+1))/$grad;

$perspec = $xstep/$factx if (($perspec > $xstep/$factx) && ($tridim == 1));

$it = length($machmax)-1;
$div = 10**$it;
$facty = ($div*(int(($machmax+$perspec)/$div)+1))/$grad;

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=1;$i<($count_week+$bargraph);$i++) {
 $x1 = ($i-1+$linegraph+$tridim)*$xstep/$factx;
 $x2 = ($i+$linegraph+$tridim)*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $machmaxtot{$i});

 $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
 $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);

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
         $fymax = $ymax-1;
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
         $fymax = $ymax-1;
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
          $fymax = $ymax-1;
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

($startday, $startmonth) = split(/ /,$start_date);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);

$xlegend = "$count_week weeks (starting $start_date)";

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<$xmax;$i+=$xstep) {

 $valstep = int(($i/$xmax)*(($xmax*$factx/$xstep)*7))+$startday;

 $moisvar = $startmonth;
 $valmois = $moischiffre;

 while  ($valstep > $month_of_year{$moisvar}) {
     $valstep = ($valstep - $month_of_year{$moisvar});
     $valmois++;
     $valmois = 0 if ($valmois > 11);
     $moisvar = $month_nb[$valmois];
 }

 $valstep = "0".$valstep if (length($valstep) == 1);
 $val = "$moisvar/$valstep";
 $posx = $i - length($valstep)*10;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$val\n";

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
#}

}

#####################  2 ieme GIF  #################################

#################################################################
# Fly

#if (-x $FLY) {

$it = length($count_week)-1;
$div = 10**$it;
$factx = ($div*(int($count_week/$div)+1))/$grad;

$perspec = $xstep/$factx if (($perspec > $xstep/$factx) && ($tridim == 1));

$it = length($reqmax)-1;
$div = 10**$it;
$facty = ($div*(int(($reqmax+$perspec)/$div)+1))/$grad;


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

##

### image pour les abscisses

$xlegend = "$count_week weeks (starting $start_date)";

($startday, $startmonth) = split(/ /,$start_date);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<$xmax;$i+=$xstep) {

 $valstep = int(($i/$xmax)*(($xmax*$factx/$xstep)*7))+$startday;

 $moisvar = $startmonth;
 $valmois = $moischiffre;

 while  ($valstep > $month_of_year{$moisvar}) {
     $valstep = ($valstep - $month_of_year{$moisvar});
     $valmois++;
     $valmois = 0 if ($valmois > 11);
     $moisvar = $month_nb[$valmois];
 }

 $valstep = "0".$valstep if (length($valstep) == 1);
 $val = "$moisvar/$valstep";
 $posx = $i - length($valstep)*10;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$val\n";

 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $outfile2x |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

##

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 for ($i=1;$i<($count_week+$bargraph);$i++) {
 $x1 = ($i-1+$linegraph+$tridim)*$xstep/$factx;
 $x2 = ($i+$linegraph+$tridim)*$xstep/$factx;

 $x1 = $x1 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);
 $x2 = $x2 - $xstep/$factx if ($x2-$x1 > $xstep && $tridim == 1);

 $y2 = $ymax - ($ystep/$facty * $reqmaxtot{$i});

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
    $y1 = $ymax - ($ystep/$facty * $reqmaxtot{$i+1});
    print FLY "line $x1,$y2,$x2,$y1,$red[0],$green[0],$blue[0]\n";

    if ($fillgraph == 1) {
      if ($y1 != $y2 || $y1 != $ymax) {
        print FLY "line $x1,$ymax,$x1,$y2,$red[0],$green[0],$blue[0]\n";
        print FLY "line $x2,$ymax,$x2,$y1,$red[0],$green[0],$blue[0]\n";
        print FLY "line $x1,$ymax,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
        $fx1 = $x1+1;
        $fymax = $ymax-1;
        print FLY "fill $fx1,$fymax,$red[0],$green[0],$blue[0]\n";
      }
    }

 }

 $x1 -= $factx*$shift_factor;
 $x2 -= $factx*$shift_factor;

 $y2 = $ymax - ($ystep/$facty * $accessmaxtot{$i});

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
    $y1 = $ymax - ($ystep/$facty * $accessmaxtot{$i+1});
    print FLY "line $x1,$y2,$x2,$y1,$red[1],$green[1],$blue[1]\n";

    if ($fillgraph == 1) {
      if ($y1 != $y2 || $y1 != $ymax) {
        print FLY "line $x1,$ymax,$x1,$y2,$red[1],$green[1],$blue[1]\n";
        print FLY "line $x2,$ymax,$x2,$y1,$red[1],$green[1],$blue[1]\n";
        print FLY "line $x1,$ymax,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
        $fx1 = $x1+1;
        $fymax = $ymax-1;
        print FLY "fill $fx1,$fymax,$red[1],$green[1],$blue[1]\n";
      }
    }

 }

 $x1 -= $factx*2*$shift_factor;
 $x2 -= $factx*2*$shift_factor;

 $y2 = $ymax - ($ystep/$facty * $reqdommaxtot{$i});

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
    $y1 = $ymax - ($ystep/$facty * $reqdommaxtot{$i+1});
    print FLY "line $x1,$y2,$x2,$y1,$red[2],$green[2],$blue[2]\n";

    if ($fillgraph == 1) {
     if ($y1 != $y2 || $y1 != $ymax) {
       print FLY "line $x1,$ymax,$x1,$y2,$red[2],$green[2],$blue[2]\n";
       print FLY "line $x2,$ymax,$x2,$y1,$red[2],$green[2],$blue[2]\n";
       print FLY "line $x1,$ymax,$x2,$ymax,$red[2],$green[2],$blue[2]\n";
       $fx1 = $x1+1;
       $fymax = $ymax-1;
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

#}
}

for ($nblang=0;$nblang<=$#lang;$nblang++) {

        $statweek = $path.$lang[$nblang].$dirsep.$dirdate.$dirsep.$statnameweek;
#        $datpath = $linkpath.$lang[$nblang].$dirsepurl.$dirdate;

        open(STATWEEK,">$statweek") || die "Error, unable to open $statweek\n";
        &WeekStats(*STATWEEK, eval($Lang{$lang[$nblang]}));
}

unlink($tmpfly);

###################################################################
# date de ce jour

$month = '';
$jour = '';

# # # # # # # # # # # #    directories stats    # # # # # # # # # # # #

#####
#######################################################################
#####            graphs for the selected directories            #######
#######################################################################
#####

# page HTML pour le tableau de donnees

 open(INFILE, "$path$dirdata$dirsep$statrepert") || die "Error, unable to open $path$dirdata$dirsep$statrepert\n";

 $line = 0;
 $count_day = 0;
 $count_week = 1;
 $count = 0;

 while (<INFILE>) {
     @dirname = split(/\s+/) unless ($line != 0);
     $line++;
     $count++;
     $count-- unless ($line > 3);
     next unless ($line > 3);

     $oldjour = $jour;
     $oldmonth = $month;

     $count_day++;

     ($jour,$month,$year,@dir) = split('\s+');
     if ( $line == 4) {
       $start_date = $jour." ".$month." ".$year;
     }
     ### test sur le jour suivant

     $intervalle = $jour - $oldjour;
     if ($intervalle != 1 && $line > 4) {
        if ($oldmonth ne $month) {
        $intervalle = $month_of_year{$oldmonth} - $oldjour; # suppose le mois suivant
        $intervalle += $jour;
             }
     $count+=$intervalle-1;
     $count_day += $intervalle-1;
     }

     if ( $count_day <  8) {
           for ($i=0;$i<=($#dir);$i++) {
              $dir_tot[$i] += $dir[$i];
           }
          }
      else {
           for ($i=0;$i<=($#dir);$i++) {
         $maxdir_tot{$count_week,$i} = $dir_tot[$i];
         $repmax = $dir_tot[$i] if ($dir_tot[$i] > $repmax);
         }
           for ($i=0;$i<=($#dir);$i++) {
        $dir_tot[$i] = $dir[$i];
        }
        $count_day -= 7;   # suppose un intervalle inferieur a 7 !

        $count_week++;
        $line ++;
        }

}


 close(INFILE);

if ($precision < 3)
{
exit;
}

$count_week--;


#################################################################
#####                     graphs                          #######
#################################################################

#################################################################
# Fly

if ($count > 14) {

#if (-x $FLY) {
$it = length($count_week)-1;
$div = 10**$it;
$factx = ($div*(int($count_week/$div)+1))/$grad;

$it = length($repmax)-1;
$div = 10**$it;
$facty = ($div*(int($repmax/$div)+1))/$grad;

$fymax = $ymax-1;

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";


 for ($i=1;$i<$count_week;$i++) {
   for ($j=0;$j<=($#dir);$j++) {
         $newtabtmp{$i,$j} = $maxdir_tot{$i,$j};
    }
  }

# calculez le max des 3 colonnes pour les 2 premiers points consecutifs

$i = 1;
$maxval = $ymax;
for ($k=$i;$k<=$i+1;$k++) {
for ($l=0;$l<=($#dir);$l++) {
   $y2 = $maxdir_tot{$k,$l};
        if ($y2 < $maxval) {
            $maxval = $y2;
            $maxiplus = $k;
         }
     }
}


# calculez le max des 3 colonnes pour le point selectione
# $maxdir_tot{$i,$j} de $j a $#dir

   for ($l=0;$l<=($#dir);$l++) {
      $maxval = 0;

      for ($j=0;$j<=($#dir);$j++) {

         if ($newtabtmp{$maxiplus,$j} > $maxval) {
            $maxval = $newtabtmp{$maxiplus,$j};
            $maxvalidx[$l] = $j;
         }
      }
      $newtabtmp{$maxiplus,$maxvalidx[$l]} = 0;
   }

if ($maxvalidx[$#dir] eq '') {
      for ($j=0;$j<=($#dir);$j++) {
            $maxvalidx[$j] = $j;
   }
}

for ($i=1;$i<($count_week+$bargraph);$i++) {

 $x1 = ($i-1+$linegraph)*$xstep/$factx;
 $x2 = ($i+$linegraph)*$xstep/$factx;

#for ($j=0;$j<=($#dir);$j++) {
for ($l=0;$l<=($#dir);$l++) {
$j = $maxvalidx[$l];
#print STDERR "$j\n";

#   if ($bargraph == 1) {
#      $y2 = $ymax - ($ystep/$facty * $maxdir_tot{$i,$maxvalidx[$j]});
#      print FLY "frect $x1,$y2,$x2,$ymax,$red[$maxvalidx[$j]],$green[$maxvalidx[$j]],$blue[$maxvalidx[$j]]\n";
#      print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
#      if ($tridim == 1 && $y2 != $ymax) {

#        $x1plus = $x1+$perspec;
#        $x2plus = $x2+$perspec;
#        $y2plus = $y2-$perspec;
#        $y1plus = $ymax-$perspec;

#        print FLY "fpoly $red[$maxvalidx[$j]],$green[$maxvalidx[$j]],$blue[$maxvalidx[$j]],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
#        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";

#        if ($j == 0) {
#        print FLY "fpoly $red[$maxvalidx[$j]],$green[$maxvalidx[$j]],$blue[$maxvalidx[$j]],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
#        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
#        }
#      }
#   }

#  if ($linegraph == 1) {
     $y2 = $ymax - ($ystep/$facty * $maxdir_tot{$i,$j});
     $y1 = $ymax - ($ystep/$facty * $maxdir_tot{$i+1,$j});
     print FLY "line $x1,$y2,$x2,$y1,$red[$j],$green[$j],$blue[$j]\n";

#     if ($fillgraph == 1) {
#       if ($y2old > $y2 && $y1old > $y1) {
#       if ($y2 < ($ymax-1) && $y1 < ($ymax-1)) {
#         print FLY "line $x1,$ymax,$x1,$y2,$red[$j],$green[$j],$blue[$j]\n";
#         print FLY "line $x2,$ymax,$x2,$y1,$red[$j],$green[$j],$blue[$j]\n";
#         print FLY "line $x1,$ymax,$x2,$ymax,$red[$j],$green[$j],$blue[$j]\n";
#         $fx1 = $x2-1 if ($y2 > $y1);
#         $fx1 = $x1+1 if ($y2 < $y1);
#         $fymax = int($y1+1) if ($y2 < $y1);
#         $fymax = int($y2+1) if ($y2 > $y1);
#         print STDERR "$x1 $x2 $fx1 $y2 $y1 $fymax $j\n";

        print FLY "fpoly $red[$j],$green[$j],$blue[$j],$x1,$ymax,$x1,$y2,$x2,$y1,$x2,$ymax\n";

#         print FLY "fill $fx1,$fymax,$red[$j],$green[$j],$blue[$j]\n";
#          }
#       }
#     }
#  }
#   $y2old = $y2;
#   $y1old = $y1;
}
}
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $file3 |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);


### image pour les abscisses

$xlegend = "$count_week weeks (starting $start_date)";

($startday, $startmonth) = split(/ /,$start_date);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";
 for ($i=$xstep;$i<$xmax;$i+=$xstep) {

 $valstep = int(($i/$xmax)*(($xmax*$factx/$xstep)*7))+$startday;

 $moisvar = $startmonth;
 $valmois = $moischiffre;

 while  ($valstep > $month_of_year{$moisvar}) {
     $valstep = ($valstep - $month_of_year{$moisvar});
     $valmois++;
     $valmois = 0 if ($valmois > 11);
     $moisvar = $month_nb[$valmois];
 }

 $valstep = "0".$valstep if (length($valstep) == 1);
 $val = "$moisvar/$valstep";
 $posx = $i - length($valstep)*10;
 print FLY "line $i,0,$i,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$val\n";

 }
print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $file3x |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("Request by directory")*3));
 print FLY "stringup 0,0,0,5,$posy,medium,Requests by directory\n";

 for ($i=$ystep;$i<$ymax;$i+=$ystep) {
 $valstep = int(($ymax - $i) * ($facty/$ystep));
 $pos = ($xdecal - length($valstep)*9);
 $posy = $i-5;
 print FLY "line $xdecalm,$i,$xdecal,$i,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $file3y |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);
#}

#####
####################################################################
###  requests and data traffic for each selected directories  ######
####################################################################
#####


####################################################################
####     requests graphs for each selected directories         #####
####################################################################

for ($i=0;$i<=($#dir);$i++) {
 $range = $i +2;
# $dirname[$i] =~ s/\///g;
# $dirname[$i] =~ s/~/_/g;
 $dirname[$i] = "dir".$i;
 $namerepert = $dirname[$i];
 $dirnamex[$i] = $dirname[$i]."x".$gifext;
 $dirnamey[$i] = $dirname[$i]."y".$gifext;
 $dirname[$i] .= $gifext;

#################################################################
# Fly

#if (-x $FLY) {

$it = length($count_week)-1;
$div = 10**$it;
$factx = ($div*(int($count_week/$div)+1))/$grad;

$repmax = 0;

 for ($j=1;$j<$count_week;$j++) {
$repmax = $maxdir_tot{$j,$i} if ($maxdir_tot{$j,$i} > $repmax);
}

$it = length($repmax)-1;
$div = 10**$it;
$facty = ($div*(int($repmax/$div)+1))/$grad;

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";

 for ($j=1;$j<($count_week+$bargraph);$j++) {

 $x1 = ($j-1+$linegraph)*$xstep/$factx;
 $x2 = ($j+$linegraph)*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $maxdir_tot{$j,$i});

 if ($bargraph == 1) {
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
    $y1 = $ymax - ($ystep/$facty * $maxdir_tot{$j+1,$i});
    print FLY "line $x1,$y2,$x2,$y1,$red[0],$green[0],$blue[0]\n";

    if ($fillgraph == 1) {
      if ($y1 != $y2 || $y1 != $ymax) {
         print FLY "line $x1,$ymax,$x1,$y2,$red[0],$green[0],$blue[0]\n";
         print FLY "line $x2,$ymax,$x2,$y1,$red[0],$green[0],$blue[0]\n";
         print FLY "line $x1,$ymax,$x2,$ymax,$red[0],$green[0],$blue[0]\n";
         $fx1 = $x1+1;
         $fymax = $ymax-1;
         print FLY "fill $fx1,$fymax,$red[0],$green[0],$blue[0]\n";
       }
    }
 }

}

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$dirname[$i] |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

$xlegend = "$count_week weeks (starting $start_date)";

($startday, $startmonth) = split(/ /,$start_date);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);


open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";

 for ($j=$xstep;$j<$xmax;$j+=$xstep) {

 $valstep = int(($j/$xmax)*(($xmax*$factx/$xstep)*7))+$startday;

 $moisvar = $startmonth;
 $valmois = $moischiffre;

 while  ($valstep > $month_of_year{$moisvar}) {
     $valstep = ($valstep - $month_of_year{$moisvar});
     $valmois++;
     $valmois = 0 if ($valmois > 11);
     $moisvar = $month_nb[$valmois];
 }

 $valstep = "0".$valstep if (length($valstep) == 1);
 $val = "$moisvar/$valstep";
 $posx = $j - length($valstep)*10;
 print FLY "line $j,0,$j,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$val\n";

 }

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$dirnamex[$i] |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);


### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("Requests")));
 print FLY "stringup 0,0,0,5,$posy,medium,Requests\n";

 for ($j=$ystep;$j<$ymax;$j+=$ystep) {
 $valstep = int(($ymax - $j) * ($facty/$ystep));
 $pos = ($xdecal - length($valstep)*9);
 $posy = $j-5;
 print FLY "line $xdecalm,$j,$xdecal,$j,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$dirnamey[$i] |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);
#}
}
}

#################################################################
####       data traffic for each selected directories       #####
#################################################################

$line = 0;
$count_day = 0;
$count_week = 1;
$count = 0;

open(INFILE, "$path$dirdata$dirsep$filerepertsize") || die "Error, unable to open sizerepert $path$dirdata$dirsep$filerepertsize\n";

 while (<INFILE>) {
     @dirname = split(/\s+/) unless ($line != 0);
     $line++;
     $count++;
     $count-- unless ($line > 3);
     next unless ($line > 3);

     $oldjour = $jour;
     $oldmonth = $month;

     $count_day++;

     ($jour,$month,$year,@dir) = split('\s+');
     if ( $line == 4) {
       $start_date = $jour." ".$month." ".$year;
     }
     ### test sur le jour suivant

     $intervalle = $jour - $oldjour;
     if ($intervalle != 1 && $line > 4) {
        if ($oldmonth ne $month) {
        $intervalle = $month_of_year{$oldmonth} - $oldjour; # suppose le mois suivant
        $intervalle += $jour;
             }
     $count+=$intervalle-1;
     $count_day += $intervalle-1;
     }

     if ( $count_day <  8) {
           for ($i=0;$i<=($#dir);$i++) {
              $dir_tot[$i] += $dir[$i];
           }
          }
      else {
           for ($i=0;$i<=($#dir);$i++) {
         $maxdir_tot{$count_week,$i} = $dir_tot[$i];
         }
           for ($i=0;$i<=($#dir);$i++) {
        $dir_tot[$i] = $dir[$i];
        }
        $count_day -= 7;   # suppose un intervalle inferieur a 7 !

        $count_week++;
        $line ++;
        }

}



close (INFILE);

$count_week--;

########################################################################
###             data traffic graphs and the HTML pages            ######
########################################################################

for ($i=0;$i<=($#dirname);$i++) {
 $range = $i*6 +2;
 $namerepert = $dirname[$i];
# $dirname[$i] =~ s/\///g;
# $dirname[$i] =~ s/~/_/g;
 $dirname[$i] = "dir".$i;
 $dirsizename[$i] = $dirname[$i];
 $dirsizename[$i] .= "-size".$gifext;
 $dirsizenamex[$i] = $dirname[$i]."-sizex".$gifext;
 $dirsizenamey[$i] = $dirname[$i]."-sizey".$gifext;
 $dirname[$i] .= $htmlext;

#####
for ($nblang=0;$nblang<=$#lang;$nblang++) {

        $tabsize = $path.$lang[$nblang].$dirsep.$dirlist.$dirsep.$dirname[$i];
        $dirname[$i] =~ s/$htmlext/$gifext/;

        open(SIZEFILE, ">$tabsize") || die "Error, unable to open $tabsize\n";

        &SizeStats(*SIZEFILE, eval($Lang{$lang[$nblang]}));

        $dirname[$i] =~ s/$gifext/$htmlext/;
        close(SIZEFILE);
        }

#### leave dirname[$i] in the state it had before ML support ####

$dirname[$i] =~ s/$htmlext/$gifext/;

if ($count > 14) {

#################################################################
# Fly

#if (-x $FLY) {

$it = length($count_week)-1;
$div = 10**$it;
$factx = ($div*(int($count_week/$div)+1))/$grad;

$repmax = 0;

 for ($j=1;$j<$count_week;$j++) {
$repmax = $maxdir_tot{$j,6*$i} if ($maxdir_tot{$j,6*$i} > $repmax);
}

$it = length($repmax)-1;
$div = 10**$it;
$facty = ($div*(int($repmax/$div)+1))/$grad;

 open(FLY,">$tmpfly");
 print FLY "new\n";
 print FLY "size $xmax,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";

 for ($j=1;$j<($count_week+$bargraph);$j++) {

 $x1 = ($j-1+$linegraph)*$xstep/$factx;
 $x2 = ($j+$linegraph)*$xstep/$factx;

 $y2 = $ymax - ($ystep/$facty * $maxdir_tot{$j,6*$i});

 if ($bargraph == 1) {
    print FLY "frect $x1,$y2,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
    print FLY "rect $x1,$y2,$x2,$ymax,0,0,0\n";
   if ($tridim == 1 && $y2 != $ymax) {

        $x1plus = $x1+$perspec;
        $x2plus = $x2+$perspec;
        $y2plus = $y2-$perspec;
        $y1plus = $ymax - $perspec;

        print FLY "fpoly $red[1],$green[1],$blue[1],$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";
        print FLY "poly 0,0,0,$x1,$y2,$x1plus,$y2plus,$x2plus,$y2plus,$x2,$y2\n";

        print FLY "fpoly $red[1],$green[1],$blue[1],$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
        print FLY "poly 0,0,0,$x2,$ymax,$x2,$y2,$x2plus,$y2plus,$x2plus,$y1plus\n";
   }
 }

 if ($linegraph == 1) {
    $y1 = $ymax - ($ystep/$facty * $maxdir_tot{$j+1,6*$i});
    print FLY "line $x1,$y2,$x2,$y1,$red[1],$green[1],$blue[1]\n";
    if ($fillgraph == 1) {
      if ($y1 != $y2 || $y1 != $ymax) {
         print FLY "line $x1,$ymax,$x1,$y2,$red[1],$green[1],$blue[1]\n";
         print FLY "line $x2,$ymax,$x2,$y1,$red[1],$green[1],$blue[1]\n";
         print FLY "line $x1,$ymax,$x2,$ymax,$red[1],$green[1],$blue[1]\n";
         $fx1 = $x1+1;
         $fymax = $ymax-1;
         print FLY "fill $fx1,$fymax,$red[1],$green[1],$blue[1]\n";
       }
    }
 }

}

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$dirsizename[$i] |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les abscisses

$xlegend = "$count_week weeks (starting $start_date)";

($startday, $startmonth) = split(/ /,$start_date);

$moischiffre = $month_equiv{$startmonth};
$moischiffre--;
$moisvar = $startmonth;
$valmois = $moischiffre;

$valstep = $startday;
$valstep = "0".$valstep if (length($valstep) == 1);


open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xmax,$ydecal\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posx = (($xmax/2)-(length($xlegend)*7/2));
 print FLY "string 0,0,0,$posx,$ydecalm,medium,$xlegend\n";

 for ($j=$xstep;$j<$xmax;$j+=$xstep) {

 $valstep = int(($j/$xmax)*(($xmax*$factx/$xstep)*7))+$startday;

 $moisvar = $startmonth;
 $valmois = $moischiffre;

 while  ($valstep > $month_of_year{$moisvar}) {
     $valstep = ($valstep - $month_of_year{$moisvar});
     $valmois++;
     $valmois = 0 if ($valmois > 11);
     $moisvar = $month_nb[$valmois];
 }

 $valstep = "0".$valstep if (length($valstep) == 1);
 $val = "$moisvar/$valstep";
 $posx = $j - length($valstep)*10;
 print FLY "line $j,0,$j,5,0,0,0\n";
 print FLY "string 0,0,0,$posx,10,small,$val\n";

 }

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$dirsizenamex[$i] |");
while( <FOO> ) {print;}
close(FOO);
#unlink($tmpfly);

### image pour les ordonnees

open(FLY,">$tmpfly");
print FLY "new\n";
print FLY "size $xdecal,$ymax\n";
 print FLY "frect 0,0,0,0,200,200,200\n";
 $posy = $ymax - (($ymax/2)-(length("Kbytes")));

 if ($repmax > 1024*1024) {
 print FLY "stringup 0,0,0,5,$posy,medium,Mbytes\n";
 } else {
 print FLY "stringup 0,0,0,5,$posy,medium,Kbytes\n";
 }
 for ($j=$ystep;$j<$ymax;$j+=$ystep) {
 $valstep = int(($ymax - $j) * ($facty/$ystep));
 $valstep /= 1024; # in Kb
 $valstep /= 1024 if ($repmax > 1024*1024);
 $valstep = int($valstep*10)/10;
 $valstep .= ".0" if ($valstep !~ /\./);
 $pos = ($xdecal - length($valstep)*9);
 $posy = $j-5;
 print FLY "line $xdecalm,$j,$xdecal,$j,0,0,0\n";
 print FLY "string 0,0,0,$pos,$posy,small,$valstep\n";
 }

print FLY "transparent 200,200,200\n";
close (FLY);

open(FOO,"$FLY -q -i $tmpfly -o $path$dirgraph$dirsep$dirsizenamey[$i] |");
while( <FOO> ) {print;}
close(FOO);
unlink($tmpfly);
#}
}
}

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
#print FILE "cron-week\t$today\t$startrun\t$endrun\t$min:$sec\n";
printf FILE "cron-week\t%s\t%s\t%s\t%d:%d\n",$today,$startrun,$endrun,$min,$sec;
close(FILE);

#################################################################
sub SizeStats {
  local(*FOUT,*L) = @_;

 print FOUT "<HTML><HEAD>\n";
 print FOUT "<TITLE>$L{'Graphs_for_dir'} $namerepert</TITLE>\n";
 print FOUT "<!-- Page generated by w3perl - cron-week.pl $version - $today $hourdate -->\n";
 print FOUT "</HEAD>\n";
 print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
 print FOUT "<H1> $L{'Graphs_for'} $L{'directory'} $namerepert</H1><P>\n";
 print FOUT "<P><HR><P>\n";

#if  (-x $FLY) {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"..$dirsepurl..$dirsepurl$dirgraph$dirsepurl$dirnamey[$i]\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"..$dirsepurl..$dirsepurl$dirgraph$dirsepurl$dirname[$i]\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"..$dirsepurl..$dirsepurl$dirgraph$dirsepurl$dirnamex[$i]\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";
#}

 print FOUT "<BR><H3>$L{'Number_of_req_by_weeks'}</H3></CENTER>\n";
 print FOUT "<P><HR><P>\n";

#if  (-x $FLY) {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"..$dirsepurl..$dirsepurl$dirgraph$dirsepurl$dirsizenamey[$i]\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"..$dirsepurl..$dirsepurl$dirgraph$dirsepurl$dirsizename[$i]\"></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"..$dirsepurl..$dirsepurl$dirgraph$dirsepurl$dirsizenamex[$i]\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "</TABLE>\n";
#}

print FOUT "<BR><H3>$L{'Data_traffic_by_weeks'}</H3></CENTER>\n";
print FOUT "<P>\n";
print FOUT "</BODY></HTML>\n";
}

#################################################################
###                     weekly  HTML page                     ###
#################################################################

sub WeekStats {
  local(*FOUT,*L) = @_;
print FOUT "<HTML><HEAD>\n";
print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
print FOUT "<TITLE>$L{'Stats_about_weeks'}</TITLE>\n";
print FOUT "<!-- Page generated by w3perl - cron-week.pl $version - $today $hourdate -->\n";
print FOUT "</HEAD>\n";

print FOUT "<CENTER>\n";
print FOUT "<table border=0 width=100\%>\n";
print FOUT "<tr>\n";
print FOUT "<td align=left>\n";
print FOUT "<A HREF=\"#utilisateur\">$L{'Users'}</A><br><br>\n" if ($precision > 2);
print FOUT "<A HREF=\"$tabnameweek\">$L{'Textual_version'}</A><br><br>\n";
print FOUT "</td>\n";
print FOUT "<td align=center>\n";
print FOUT "<table border=8 cellpadding=1><tr><td>\n";
print FOUT "<table border=8 cellpadding=3><tr><td>\n";
print FOUT "<table border=8 cellpadding=5><tr><td>\n";
print FOUT "<H1><center>$L{'Stats'} <br>$L{'about'} $L{'Weeks'}</center>\n";
print FOUT "</td></tr></table>\n";
print FOUT "</td></tr></table>\n";
print FOUT "</td></tr></table>\n";
print FOUT "</H1>\n";
print FOUT "</td>\n";
print FOUT "<td align=right><A HREF=\"#requete\">$L{'Requests'}</A><br><br>\n";
print FOUT "<A HREF=\"..$dirsepurl$dirlist$dirsepurl$filereport\">$L{'Directories_graphs'}</A><br><br>\n" if ($precision > 2);
print FOUT "</td>\n";
print FOUT "</tr>\n";
print FOUT "</table>\n";
print FOUT "</center>\n";

if ($precision > 2) {
print FOUT "<A NAME=\"utilisateur\">\n";

#if  (-x $FLY) {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkoutfile1y\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkoutfile1\" ALT=\"graph1\" USEMAP=\"#week1\" BORDER=0></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkoutfile1x\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "<TR><TD></TD>\n";
print FOUT "<TD ALIGN=CENTER>\n";

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[0]\" ALT=\"$gcolor[0]\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'Number_of'} $L{'Conn_Mach'}</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\" ALT=\"$gcolor[1]\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'Number_of'} $L{'New_Mach'}</TD>\n";
if ($locallog == 1) {
print FOUT "</TR><TR>\n";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\" ALT=\"$gcolor[2]\"></TD>\n";
print FOUT "<TD>&nbsp;  $L{'Number_of'} $L{'Mach_Dom'} $localdomainename</TD>\n";
}
print FOUT "</TR></TABLE>\n";

print FOUT "</TD></TR>\n";
print FOUT "</TABLE></CENTER>\n";
#}

print FOUT "<BR>\n";
}

print FOUT "<A NAME=\"requete\">\n";

#if (-x $FLY)  {
print FOUT "<CENTER><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
print FOUT "<TR>\n";
print FOUT "<TD><IMG WIDTH=$xdecal HEIGHT=$ymax SRC=\"$linkoutfile2y\" ALT=\"y\"></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ymax SRC=\"$linkoutfile2\" ALT=\"graph2\" USEMAP=\"#week2\" BORDER=0></TD>\n";
print FOUT "</TR><TR><TD></TD>\n";
print FOUT "<TD><IMG WIDTH=$xmax HEIGHT=$ydecal SRC=\"$linkoutfile2x\" ALT=\"x\"></TD>\n";
print FOUT "</TR>\n";
print FOUT "<TR><TD></TD>\n";
print FOUT "<TD ALIGN=CENTER>\n";

print FOUT "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0><TR>\n";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[0]\" ALT=\"$gcolor[0]\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'No_Ttl_Req_Week'}</TD>\n";
print FOUT "</TR><TR>\n";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[1]\" ALT=\"$gcolor[1]\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'No_HTML_Acc'}</TD>\n";
if ($locallog == 1) {
print FOUT "</TR><TR>\n";
print FOUT "<TD><IMG SRC=\"..$dirsepurl..$dirsepurl$linkpathinit$dirress$dirsepurl$gcolor[2]\" ALT=\"$gcolor[2]\"></TD>\n";
print FOUT "<TD>&nbsp; $L{'NoReq'} $L{'from_dom'} $localdomainename</TD>\n";
}
print FOUT "</TR></TABLE>\n";

print FOUT "</TD></TR>\n";
print FOUT "</TABLE></CENTER>\n";
#}

print FOUT "<P><HR>\n";
print FOUT "$L{'For_people'}\n";
print FOUT "$L{'there_is'} <A HREF=\"$tabnameweek\">$L{'table_of_data'}\n"; ### $L contains /A!!!! 

# USEMAP Week1

$num = 1;
$line = 0;

print FOUT "<MAP NAME=\"week1\">\n";
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

print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$tabnameweek#$num\">\n";
   $num++;

}
}
}
print FOUT "</MAP>\n";

# USEMAP Week1

$num = 1;
$line = 0;

print FOUT "<MAP NAME=\"week2\">\n";
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

print FOUT "<AREA SHAPE=\"rect\" COORDS=\"$x1,0,$x2,$ymax\" HREF=\"$tabnameweek#$num\">\n";
   $num++;

}
}
}
print FOUT "</MAP>\n";
print FOUT "<HR><P>\n";
print FOUT "</BODY></HTML>\n";
close FOUT;
}

########################################################################################
sub WeekHeader {
  local(*FOUT,*L) = @_;
  
  print FOUT "<HTML><HEAD>\n";
  print FOUT "<TITLE>$L{'About_weeks'}</TITLE>\n";
  print FOUT "<!-- Page generated by w3perl - cron-week.pl $version - $today $hourdate -->\n";
  print FOUT "</HEAD>\n";
  print FOUT "<BODY $backgrd TEXT=\"$custom_text\"  LINK=\"$custom_link\" VLINK=\"$custom_vlink\">\n";
  print FOUT "<H1> $L{'About_weeks'}</H1><P>\n";
  print FOUT "<P><HR><P>\n";
  print FOUT "<table border=1 width=100%>\n";
  print FOUT "<tr>\n";
  print FOUT "<th>$L{'Date'}</th>\n";
  print FOUT "<th bgcolor=\"#FFFF00\">$L{'Hosts'}</th>\n";
  print FOUT "<th>$L{'New_Hosts'}</th>\n";
  print FOUT "<th>$L{'Domain_Hosts'}</th>\n";
  print FOUT "<th bgcolor=\"#00FFFF\">$L{'Requests'}</th>\n";
  print FOUT "<th bgcolor=\"#00FF00\">$L{'Accesses'}</th>\n";
  print FOUT "<th>$L{'DomReq'}</th>\n";
  print FOUT "</tr>\n";
}

########################################################################################
sub WeekFooter {
  local(*FOUT) = $_[0];
  print FOUT "</TABLE>\n";
  print FOUT "<P><HR><P>\n";
  print FOUT "</BODY></HTML>\n";
}

#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                       CRON SCRIPT                              #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 18/07/2000     #####
####                                                                #####
#########################################################################

# option available in crontab 
# 01 * * * * /home/domisse/public_html/w3perl/cron-w3perl.pl -c /home/domisse/public_html/w3perl/config-hplyot.pl
 
# customise your own value in the 'user launching configuration' part.

$version = "2.71";
$verdate = "18/07/00";

require "/home/domisse/public_html/w3perl/libw3perl.pl";

$w3perlpath = "/home/domisse/public_html/w3perl"; # Do not remove this line

$w3perlpath .= $dirsep;

#use Cwd;

# init

$process_to_launch = 0;

$today = $day."/".$month."/".$year." ".$hour."h".$minute;

$wday = (localtime)[6];

#################################################################
###                      get local time                       ###
#################################################################

($a,$min,$hour,$d,$month,$year,$weekofday,$yearday) = localtime(time);

$month++;
$weekofyear = int($yearday/7)+1;

#################################################################
###            user launching configuration                   ###
#################################################################

### run cron-xxx.pl -h to see specific script options 

### hour

$option_hour = "";
$hour_launch = 1; # every hour

### day

$option_day = "";
$day_launch = 1; # every day
$day_launch_time = 0; # launch at midnight

### week

$option_week = "";
$week_launch = 1; # every week
$week_launch_time = 1; # launch at 1 am o'clock
$week_launch_day = 1; # launch on monday (0 = sunday, 6 = saturday)

### month

$option_month = "";
$month_launch = 1; # every month
$month_launch_time = 1; # launch at 1 am o'clock
$month_launch_day = 1; # launch on the first day of each month

### pages (manual use for reset)

$option_pages = "";

### inc

$option_inc = "";
$inc_launch = 1; # everyday
$inc_launch_time = 0; # launch at midnight

## refer

$option_refer = "";
$refer_launch = 1; # everyday
$refer_launch_time = 0; # launch at 0 o'clock

## agent

$option_agent = "";
$agent_launch = 1; # everyday
$agent_launch_time = 0; # launch at 0 am o'clock

## error

$option_error = "-k";
$error_launch = 1; # everyday
$error_launch_time = 1; # launch at 1 am o'clock

## session

$option_session = "";
$session_launch = 1; # every 5 days
$session_launch_time = 0; # launch at 0 o'clock

## url

$option_url = "";
$url_launch = 5; # every 5 days
$url_launch_time = 1; # launch at 1 o'clock

## history

$option_history = "";
$history_launch = 1; # everyday
$history_launch_time = 2; # launch at 2 am o'clock

#################################################################
###            checking everything could be launch            ###
#################################################################

if ($hour_launch != 1) {
&warning("cron-day",$day_launch_time);
&warning("cron-week",$week_launch_time);
&warning("cron-month",$month_launch_time);
&warning("cron-inc",$inc_launch_time);
&warning("cron-refer",$refer_launch_time);
&warning("cron-agent",$agent_launch_time);
&warning("cron-error",$error_launch_time);
&warning("cron-session",$session_launch_time);
&warning("cron-url",$url_launch_time);
&warning("cron-history",$history_launch_time);
}

#################################################################
###            parsing the command line option                ###
#################################################################

if ($opt_c ne '') {
$configfile = $opt_c;
$option = "-c ".$configfile; 
}

if ($opt_h == 1) {
      print STDOUT "Usage : \n";
      print STDOUT "        -c <file> : load configuration file\n";
      print STDOUT "        -a        : reset all your stats\n";
      print STDOUT "        -d <nbdays> : number of days to scan\n";      
      print STDOUT "        -e        : incremental run for all scripts\n";
#      print STDOUT "        -u        : reset all your stats (manual use)\n";
      print STDOUT "        -x        : show default value for flag options\n";
      print STDOUT "        -b        : show crontab\n";
      print STDOUT "        -v        : version\n";
      print STDOUT "\n";
      exit;
}

if ($opt_x == 1) {
      print STDOUT "Default : \n";
      print STDOUT "          -c : $configfile\n";
      print STDOUT "          -a : ";
      &id($opt_a);
      print STDOUT "          -d <nbdays>   : $nbdays\n";      
      print STDOUT "          -e : ";
      &id($opt_e);      
#      print STDOUT "          -u : ";
#      &id($opt_u);
      print STDOUT "          -v : $version\n";
      exit;
}

if ($opt_v == 1) {
      print STDOUT "cron-w3perl.pl version $version $verdate\n";
      exit;
}

if ($opt_d ne '') {
$option .= " -d $opt_d";
$opt_a = 1;
}


if ($opt_b == 1) {
    print STDOUT "Crontab :\n";

    # hour
    
    print STDOUT "0 ";

    if ($hour_launch == 1) {
    print STDOUT "*";
    } else {
        $cday = "(";
    for ($k=2;$k<=24;$k++) {
    $cday .= "$k," if (($k/$hour_launch) == int($k/$hour_launch));
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * * * cron-hour$plext $option_hour $option\n";

    # day

    print STDOUT "0 $day_launch_time ";
    if ($day_launch == 1) {
    print STDOUT "*";
    } else {
    $cday = "(";
    for ($k=2;$k<=31;$k++) {
    $cday .= "$k," if (($k/$day_launch) == int($k/$day_launch));
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * * cron-day$plext $option_day $option\n";

    # week
    
    print STDOUT "0 $week_launch_time ";
    if ($week_launch == 1) {
    print STDOUT "*";
    } else {
    $begin = $day+($week_launch_day-$wday);
    $begin = $begin - (7*int($begin/7));
    $cday = "(";
    for ($k=$begin;$k<=31;$k+=7*$week_launch) {
	$cday .= "$k,";
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * $week_launch_day cron-week$plext $option_week $option\n";

    # month
    
    print STDOUT "0 $month_launch_time $month_launch_day * * cron-month$plext $option_month $option\n";

    # inc
    
    print STDOUT "0 $inc_launch_time ";
    if ($inc_launch == 1) {
    print STDOUT "*";
    } else {
    $cday = "(";
    for ($k=2;$k<=31;$k++) {
    $cday .= "$k," if (($k/$inc_launch) == int($k/$inc_launch));
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * * cron-inc$plext $option_inc $option\n";

    # refer

    print STDOUT "0 $refer_launch_time ";
    if ($refer_launch == 1) {
    print STDOUT "*";
    } else {
    $cday = "(";
    for ($k=2;$k<=31;$k++) {
    $cday .= "$k," if (($k/$refer_launch) == int($k/$refer_launch));
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * * cron-refer$plext $option_refer $option\n";    
 
    # agent

    print STDOUT "0 $agent_launch_time ";
    if ($agent_launch == 1) {
    print STDOUT "*";
    } else {
    $cday = "(";
    for ($k=2;$k<=31;$k++) {
    $cday .= "$k," if (($k/$agent_launch) == int($k/$agent_launch));
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * * cron-agent$plext $option_agent $option\n";    
 
    # error

    print STDOUT "0 $error_launch_time ";
    if ($error_launch == 1) {
    print STDOUT "*";
    } else {
    $cday = "(";
    for ($k=2;$k<=31;$k++) {
    $cday .= "$k," if (($k/$error_launch) == int($k/$error_launch));
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * * cron-error$plext $option_error $option\n";    

    # session

    print STDOUT "0 $session_launch_time ";
    if ($session_launch == 1) {
    print STDOUT "*";
    } else {
    $cday = "(";
    for ($k=2;$k<=31;$k++) {
    $cday .= "$k," if (($k/$session_launch) == int($k/$session_launch));
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * * cron-session$plext $option_session $option\n";    

    # url

    print STDOUT "0 $url_launch_time ";
    if ($url_launch == 1) {
    print STDOUT "*";
    } else {
    $cday = "(";
    for ($k=2;$k<=31;$k++) {
    $cday .= "$k," if (($k/$url_launch) == int($k/$url_launch));
    }
    chop($cday);
    $cday .= ")";
    print STDOUT "$cday";
    }
    print STDOUT " * * cron-url$plext $option_url $option\n";    
            
    exit;
}



#if ($ENV{'REQUEST_METHOD'} ne "GET") {
#print STDOUT "\nAdd the following line in your crontab :\n";
#print STDOUT "0 ";

#if ($hour_launch == 1) {
#print STDOUT "*";
#} else {
#   $cday = "(";
#   for ($k=2;$k<=24;$k++) {
#      $cday .= "$k," if (($k/$hour_launch) == int($k/$hour_launch));
#   }
#   chop($cday);
#   $cday .= ")";
#   print STDOUT "$cday";
#   }

#print STDOUT " * * * ".$w3perlpath."cron-w3perl$plext $option\n";
#print STDOUT "where 0 is the minute of the hour, change it to whatever you want. (0-59)";
#print STDOUT "\n(if you are using w3perl for several web, better to use different minute launch time to avoid CPU increase)\n\n";
#}

#################################################################
###       reset for first use (don't use in crontab !)        ###
#################################################################

#if ($opt_u != 0) {
#print "<I><B>" if ($ENV{'REQUEST_METHOD'} eq "GET");
#print "Resetting all stats data....\n";
#print "<BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

#print "Deleting stats data....\n";
#print "<BR></I></B>" if ($ENV{'REQUEST_METHOD'} eq "GET");

# deleting files

#$tmp = $w3perlpath.$dirinc;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;

#$tmp = $w3perlpath.$dirdata;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;

#$tmp = $w3perlpath.$dirgraph;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;

#for ($i=0;$i<=$#lang;$i++) {
#unlink "$path$homepages[$i]" if -f $path.$homepages[$i];
#}

#for ($i=0;$i<=$#lang;$i++) {
#$dir = $path.$lang[$i];

#$tmp = $dir.$dirsep.$dirdate;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
##$tmp = $dir.$dirsep.$dirdays;
##$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#$tmp = $dir.$dirsep.$dirlist;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#$tmp = $dir.$dirsep.$dirpays;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#$tmp = $dir.$dirsep.$dirsite;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#$tmp = $dir.$dirsep.$dirdocument;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#$tmp = $dir.$dirsep.$dirframe;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#$tmp = $dir.$dirsep.$dirpage;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#$tmp = $dir.$dirsep.$dirsession;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#$tmp = $dir.$dirsep.$dirdomain;
#$tmp2 = $tmp.$dirsep."*";
#unlink (<$tmp$dirsep*>) if -d $tmp;
#}
#}


#if ($opt_a != 0 || $opt_u != 0) {
if ($opt_a != 0) {

$string = $w3perlpath."cron-url".$plext." ".$option_url;        
push(@list,$string) ;

if ($exclude_robot == 1) {
$option_session = "-m"; 
$string = $w3perlpath."cron-session".$plext." ".$option_session;        
push(@list,$string) ;
}

$option_agent = "-b";
$string = $w3perlpath."cron-agent".$plext." ".$option_agent;        
push(@list,$string) ;

$option_refer = "-b";
$string = $w3perlpath."cron-refer".$plext." ".$option_refer;        
push(@list,$string) ;

$string = $w3perlpath."cron-pages".$plext." ".$option_pages;        
push(@list,$string) ;

$string = $w3perlpath."cron-hour".$plext." ".$option_hour;        
push(@list,$string) ;

$string = $w3perlpath."cron-week".$plext." ".$option_week;        
push(@list,$string) ;

$string = $w3perlpath."cron-month".$plext." ".$option_month;        
push(@list,$string) ;

$option_session = ""; 
$option_session = "-u" if ($exclude_robot == 1); 
$string = $w3perlpath."cron-session".$plext." ".$option_session;        
push(@list,$string) ;

$string = $w3perlpath."cron-day".$plext." ".$option_day;        
push(@list,$string) ;

$option_error = "-b";
$string = $w3perlpath."cron-error".$plext." ".$option_error;        
push(@list,$string) ;

$option_pages = "-u";
$string = $w3perlpath."cron-pages".$plext." ".$option_pages;  
push(@list,$string);

for ($i=0;$i<=$#list;$i++) {

    $contentype = "-y";
    $contentype = "" if ($i == 0);

print "<B>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Launching $list[$i] $option ($today)\n";
print "</B><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

    $cron = fork;

	if ($cron == 0) {
		exec "$list[$i] $contentype $option";
#		exit 0;
	} elsif ($cron != 0) {
	    $pid =  wait;
	    } 
}

print "<B>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Stats computed.\n";
print "<BR></B>" if ($ENV{'REQUEST_METHOD'} eq "GET");

exit;	
}

#################################################################
###                    force incremental fork                 ###
#################################################################

if ($opt_e != 0) {

$string = $w3perlpath."cron-url".$plext." ".$option_url;
push(@list,$string);
$process_to_launch++;

$string = $w3perlpath."cron-refer".$plext." ".$option_refer;
push(@list,$string);
$process_to_launch++;

$string = $w3perlpath."cron-agent".$plext." ".$option_agent;
push(@list,$string);
$process_to_launch++;

if ($exclude_robot == 1) {
    $option_session = "-m";
    $string = $w3perlpath."cron-session".$plext." ".$option_session;
    push(@list,$string);
    $option_session = "";
    $process_to_launch++;
}

$string = $w3perlpath."cron-inc".$plext." ".$option_inc;        
push(@list,$string);
$process_to_launch++;

$string = $w3perlpath."cron-hour".$plext." ".$option_hour;
push(@list,$string);
$process_to_launch++;

$string = $w3perlpath."cron-week".$plext." ".$option_week;
push(@list,$string);
$process_to_launch++;

$option_month = "-b";
$string = $w3perlpath."cron-month".$plext." ".$option_month;
push(@list,$string);
$process_to_launch++;

$option_session = "-u";
$string = $w3perlpath."cron-session".$plext." ".$option_session;
push(@list,$string);
$process_to_launch++;

$option_session = "";
$string = $w3perlpath."cron-day".$plext." ".$option_day;
push(@list,$string);
$process_to_launch++;

$string = $w3perlpath."cron-error".$plext." ".$option_error;
push(@list,$string);
$process_to_launch++;

#$process_to_launch = 11;
#$process_to_launch++ if ($exclude_robot == 1);
}

#################################################################
###         adding the script in the fork list                ###
#################################################################

if ($opt_e != 1) {

&daily("cron-refer",$option_refer,$refer_launch,$refer_launch_time);
&daily("cron-agent",$option_agent,$agent_launch,$agent_launch_time);
&daily("cron-session",$option_session,$session_launch,$session_launch_time);

### inc

$string = "cron-inc";
&daily($string,$option_inc,$inc_launch,$inc_launch_time);

### hour 

$string = $w3perlpath."cron-hour".$plext." ".$option_hour;        

    if (($hour/$hour_launch) == int($hour/$hour_launch)) {
	push(@list,$string) ;
	$process_to_launch++;
    }

### week

$string = $w3perlpath."cron-week".$plext." ".$option_week;

    if ((($weekofyear/$week_launch) == int($weekofyear/$week_launch)) && ($weekofday == $week_launch_day) && ($hour == $week_launch_time)) {
	push(@list,$string);
	$process_to_launch++;
    }

### month

$string = $w3perlpath."cron-month".$plext." ".$option_month;

    if ((($month/$month_launch) == int($month/$month_launch)) && ($day == $month_launch_day) && ($hour == $month_launch_time)) {
	push(@list,$string);
	$process_to_launch++;
    }

### make a comment in front of the line you don't want to run

&daily("cron-url",$option_url,$url_launch,$url_launch_time);
&daily("cron-error",$option_error,$error_launch,$error_launch_time);
&daily("cron-history",$option_history,$history_launch,$history_launch_time);

### day 

$string = "cron-day";
&daily($string,$option_day,$day_launch,$day_launch_time);

}

#################################################################
###              main loop to fork processes                  ###
#################################################################

print "<B>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Stats ($today) : \n";
print "</B><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

for ($i=0;$i<$process_to_launch;$i++) {

    $contentype = "-y";
    $contentype = "" if ($i == 0);

print "<B>" if ($ENV{'REQUEST_METHOD'} eq "GET");
print "Launching $list[$i] $option\n";
print "</B><BR>" if ($ENV{'REQUEST_METHOD'} eq "GET");

    $cron = fork;

	if ($cron == 0) {
		exec "$list[$i] $contentype $option";
#		exit 0;
	} elsif ($cron != 0) {
	    $pid =  wait;
	    } 
}

exit;

#----------------------------------------------------
# daily
sub daily {
    local($string,$option,$launch,$launch_time) = @_;

    $string = $w3perlpath.$string.$plext." ".$option;        

    if (($day/$launch) == int($day/$launch) && $hour == $launch_time) {
	push(@list,$string);
	$process_to_launch++;
    }
}

#----------------------------------------------------
# warning
sub warning {
    local($string,$launch_time) = @_;

    $string = $string.$plext;        

    if (($launch_time/$hour_launch) != int($launch_time/$hour_launch)) {
    	print STDERR "$string will never be launch...\n";
    	}	
}

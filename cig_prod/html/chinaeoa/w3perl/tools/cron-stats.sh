#!/bin/sh

#########################################################################
# Upload logfiles file and then launch w3perl for weekly and full stats 
#
# This script upload logfiles from differents web server and compute
# weekly and full stats for each of them from a crontab each night
# My provider don't allow to run more than one crontab per day.
#
# Upload :
# You'll need to get as many netrc files as upload to do.
# .netrc file are needed to launch ftp session automatically
# syntax is : "default login <your_login> password <your_password>"
# this file should not be readable by other people as password are
# not crypted !
# Filename of netrc file could be netrc_<webdomain>
# They are moved to .netrc for upload and then deleted.
# Feel free to modify your ftp session. My own log file are located
# in the stats directory (cd stats)...and I upload only the current
# logfile. They are nammed old_access_log.1998Nov.gz on my server 
# (get $prefixlog.$year$month.gz)
#
# Stats :
# Each stats are computed twice, one full, one weekly
# You'll need one configuration files for every stats
# They are loaded via the -c flag
# The -d flag precise the number of previous days to scan
# The -e flag are for full stats.

### Get logfiles data
# PATH   : Location where the logfile will be download
# PATHRC : Location of the user of the netrc file
# FTP    : Location of the ftp binary
# prefixlog : Name of your log filename

PATH=/usr/local/etc/w3perl/logs
PATHRC=/home/domisse
FTP=/usr/bin/ftp

### CONSTANT

FILERCACTIVE=$PATHRC/.netrc
prefixlog=access
errorlog=error

### Get the date and the name of the current logfilename.

day=`/bin/date +"%d"`
month=`/bin/date +"%m"`
year=`/bin/date +"%y"`

#
# First day of the month test
#

day=`/usr/bin/expr $day - 1`

if [ "$day" = "0" ]
   then
      month=`/usr/bin/expr $month - 1`
   else
      month=`/usr/bin/expr $month - 0`
fi

if [ "$day" = "0" ]
then
if [ $month = "1" ] 
then day=31 
fi
if [ $month = "2" ] 
then day=28 
fi
if [ $month = "3" ] 
then day=31 
fi
if [ $month = "4" ] 
then day=30 
fi
if [ $month = "5" ] 
then day=31 
fi
if [ $month = "6" ] 
then day=30 
fi
if [ $month = "7" ] 
then day=31 
fi
if [ $month = "8" ] 
then day=31 
fi
if [ $month = "9" ] 
then day=30 
fi
if [ $month = "10" ] 
then day=31 
fi
if [ $month = "11" ] 
then day=30 
fi
if [ $month = "12" ] 
then day=31 
fi
fi

#
# First day of the year test
#

if [ "$month" = "0" ]
   then
      month=12;year=`/usr/bin/expr $year - 1`
fi

#
# add two digit for one digit month
#

if [ $month -lt 10 ]
   then
      month=0$month
fi

#
# add two digit for one digit day
#

if [ $day -lt 10 ]
   then
      day=0$day
fi

#
# get year 2000 compliant ;)
#

if [ $year -lt 95 ]
   then
      year="20"$year
   else
      year="19"$year
fi

########################## Upload #################################

### w3perl.com

PATHLOG=$PATH/futurequest
FILERC=$PATHRC/netrc_w3perl

cd $PATHLOG

/bin/mv $FILERC $FILERCACTIVE 
$FTP ftp.w3perl.com <<EOF
bin
pass
cd ../logs
get $prefixlog.$year$month$day.gz
get $errorlog
EOF
/bin/mv $FILERCACTIVE $FILERC

######################## Compute stats #####################################

### Full stats from the beginning

#/usr/local/etc/w3perl/cgi-bin/w3perl/cron-w3perl.pl -c /usr/local/etc/w3perl/cgi-bin/w3perl/config.pl -e

### Weeks stats (compute only the 8 last days)

#/usr/local/etc/w3perl/cgi-bin/w3perl/cron-w3perl.pl -c /home/domisse/public_html/w3perl/config-w3perl-week.pl -d 8

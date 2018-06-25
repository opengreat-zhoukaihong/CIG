#! /usr/bin/sh
#
# @(#)newhttplog.sh        Laurent Domisse, 17 sept 95
#             Revised by:  C. Daniel Chase, 1 April 1996
              Revised by:  Laurent Domisse, 03 sept 97

# Uncomment to kill server before running log cut
# -------------------------------------
kill -HUP `cat /usr/local/httpd/logs/httpd-pid`
# -------------------------------------

#
# Reset LOGDIR var for log directory in use
#

GZIP=/usr/local/bin/gzip
GUNZIP=/usr/local/bin/gunzip

HOME=/usr/local/serveurs
LOG=access_log
ERRORS=error_log
REFER=referer_log
AGENT=agent_log
LOGDIR=$HOME/credm/logs/

cd $LOGDIR
day=`date +"%d"`
lmonth=`date +"%b"`
month=`date +"%m"`
year=`date +"%y"`

#
# Added var THIS_MONTH to distinguish operations for current month vs previous
#
# --------------------------------------
# on est le premier du mois (compute previous month)
# donc  on calcule le mois precedent
# -------------------------------------

#
# To run cut on other than first of month and split two months change 01 to...
#

if [ "$day" = "01" ]
   then
      this_month=`expr $month - 0`
      month=`expr $month - 1`
   else
      this_month=`expr $month - 0`
      month=`expr $month - 0`
fi
if [ "$month" = "0" ]
   then
      month=12;year=`expr $year - 1`
fi
#
if [ $month -lt 10 ]
   then
      month=0$month
fi
if [ $this_month -lt 10 ]
   then
      this_month=0$this_month
fi
# -------------------------------------
# quel siecle ? (which century ?)
# -------------------------------------
if [ $year -lt 95 ]
   then
      year="20"$year
   else
      year="19"$year
fi
# -------------------------------------
# on bouge le fichier des logs
# et celui des erreurs (moving error and logs files)
# -------------------------------------

if test -f $ERRORS
   then

# Make copy of file for later operations

      cp $ERRORS $ERRORS"_current"

# If a .gz file already exists for the current log file, open to append

      if test -f $ERRORS"."$month"-"$year".gz"
         then
            $GUNZIP $ERRORS"."$month"-"$year".gz"
            mv $ERRORS"."$month"-"$year tmp

# If operating on current month only (not 1st of mth) then grep contents 
# of .gz file and current error log back to current month file to .gz

            if [ $month = $this_month ]
               then
                  grep -h " $lmonth " tmp $ERRORS >$ERRORS"."$month"-"$year     

# If not current month take all NOT matching current month and combine

               else
                  grep -h -v " $lmonth " tmp $ERRORS >$ERRORS"."$month"-"$year
            fi

# If no .gz already exists, do same for just current error file

         else
            if [ $month = $this_month ]
               then
                  grep " $lmonth " $ERRORS >$ERRORS"."$month"-"$year
               else
                  grep -v " $lmonth " $ERRORS >$ERRORS"."$month"-"$year
            fi
      fi

# Re-gzip files and create empty file and chmod

      $GZIP $ERRORS"."$month"-"$year
      cp /dev/null $ERRORS
      chmod 644    $ERRORS

# If 1st of mth cut, there may be some current month errors to add back 
# to error log if cut not done timely

      if [ $this_month -ne $month ]
         then
           grep -h " $lmonth " $ERRORS"_current" >$ERRORS
      fi
fi

# --------------------------------------------------------------------
# Only valid for common logfile format 
# (should be run at the first day of each month)
# No information about date is provided with this format
# --------------------------------------------------------------------

if test -f $REFER
   then

      mv $REFER $REFER"."$month"-"$year
      $GZIP $REFER"."$month"-"$year
      cp /dev/null $REFER
      chmod 644    $REFER

fi


if test -f $AGENT
   then

      mv $AGENT $AGENT"."$month"-"$year
      $GZIP $AGENT"."$month"-"$year
      cp /dev/null $AGENT
      chmod 644    $AGENT

fi

# --------------------------------------------------------------------
# The following code is a duplicate of that for error log, just for the 
# log file itself
# --------------------------------------------------------------------

if test -f $LOG
   then

# Make copy of file for later operations

      cp $LOG $LOG"_current"

# If a .gz file already exists for the current log file, open to append

      if test -f $LOG"."$month"-"$year".gz"
         then
            $GUNZIP $LOG"."$month"-"$year".gz"
            mv $LOG"."$month"-"$year tmp

# If operating on current month only (not 1st of mth) then grep contents 
# of .gz file and current log back to current month file to .gz

            if [ $month = $this_month ]
               then
                  grep -h "/$lmonth/" tmp $LOG >$LOG"."$month"-"$year   

# If not current month take all NOT matching current month and combine

               else
                  grep -h -v "/$lmonth/" tmp $LOG >$LOG"."$month"-"$year
            fi

# If no .gz already exists, do same for just current log file

         else
            if [ $month = $this_month ]
               then
                  grep "/$lmonth/" $LOG >$LOG"."$month"-"$year
               else
                  grep -v "/$lmonth/" $LOG >$LOG"."$month"-"$year
            fi
      fi

# Re-gzip files and create empty file and chmod

      $GZIP $LOG"."$month"-"$year
      cp /dev/null $LOG
      chmod 644    $LOG

# If 1st of mth cut, there may be some current month errors to add back 
# to error log if cut not done timely

      if [ $this_month -ne $month ]
         then
           grep -h "/$lmonth/" $LOG"_current" >$LOG
      fi
fi

# Cleanup - Remove temporary files

rm $LOG"_current"
rm $ERRORS"_current"
rm tmp if test -f tmp


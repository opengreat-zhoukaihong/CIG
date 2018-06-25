#!/usr/local/bin/perl
# <plaintext>  just in case you look at this via a browser

#########################################################################
####                                                                #####
####                     W3PERL DATABASE IBRAIRY                    #####
####                                                                #####
####                      (http server)                             #####
####                                                                #####
####    domisse@w3perl.com                   version 24/02/2000     #####
####                                                                #####
####                                                                #####
#########################################################################

require "getopt.pl";
require "ctime.pl";

&Getopt('cdgijlopqrst');

if ($opt_c ne '') {
$conf_file = $opt_c;
require "$conf_file";
} else {
require "/usr/local/etc/w3perl/cgi-bin/w3perl/config.pl";
}	

#########################################################################
### Language arrays
#########################################################################

#######################################################################
### Connexion a une base de donnee
# Entree : $database (type de base : Oracle, mysql, Sybase...)
#          $database_name (nom de la base)
#          $userdb (utilisateur)

sub connexion_db {
    local($database,$database_name,$userdb) = @_;
    $dbh = DBI->connect("DBI:$database:$database_name","$userdb");
    if ( !defined $dbh ) {
	die print "Cannot connect to $database server: $DBI::errstr\n";
    }
}

1;

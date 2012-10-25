#!/bin/env perl

use strict;
use warnings;

use File::Spec;
use File::Basename;
use lib File::Spec->catdir( dirname(__FILE__), 'lib' );

use Getopt::Long;
use Haruna::Client;

my %opts;
Getopt::Long::GetOptions( \%opts, qw( url=s host=s ipaddr=s) );

my $url  = $opts{url}  || die 'url is required';
my $host = $opts{host} || die 'host is required';
my $ipaddr = $opts{ipaddr};

my $h = Haruna::Client->new;
warn $h->request( $url, $host, $ipaddr );


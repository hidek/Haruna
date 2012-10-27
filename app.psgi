use strict;
use utf8;

use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'lib');

use Haruna::Server;
use Haruna::Util;
use Plack::Builder;

my $config = Haruna::Util->load_config(
    File::Spec->catfile(dirname(__FILE__), 'config.pl'));

my $h   = Haruna::Server->new($config);
my $app = sub {
    $h->run(shift);
};

builder {
    enable "Log::Minimal",
        autodump => 1,
        loglevel => 'DEBUG';
    enable "Auth::OAuth",
        'consumer_key'    => $h->{config}{consumer_key},
        'consumer_secret' => $h->{config}{consumer_secret};
    $app;
};

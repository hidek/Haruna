package Haruna::Client;
use strict;
use warnings;

use JSON;
use OAuth::Lite::Consumer;
use LWP::UserAgent;

sub new {
    my ($class, $config) = @_;
    my $self = bless {}, $class;
    $self->{config} = $config;
    return $self;
}

sub request {
    my ($self, $url, $host, $ipaddr) = @_;

    my $config = $self->{config};

    my $consumer = OAuth::Lite::Consumer->new(
        consumer_key    => $config->{consumer_key},
        consumer_secret => $config->{consumer_secret},
    );

    my %params = ();
    $params{host} = $host;
    $params{ipaddr} = $ipaddr if $ipaddr;

    my $req = $consumer->gen_oauth_request(
        method => 'GET',
        url    => $url,
        params => \%params,
    );

    my $ua  = LWP::UserAgent->new;
    my $res = $ua->request($req);

    return $res->content;
}

1;
__END__

=head1 NAME

Haruna -

=head1 SYNOPSIS

  use Haruna;

=head1 DESCRIPTION

Haruna is

=head1 AUTHOR

Hideo Kimura E<lt>hide@hide-k.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


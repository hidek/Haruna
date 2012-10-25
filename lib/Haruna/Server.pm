package Haruna::Server;
use strict;
use warnings;

use Haruna::Util;
use Plack::Request;
use Log::Minimal;
use Net::DNS;
use JSON;

sub new {
    my $self = bless {}, shift;
    $self->{config} = Haruna::Util->load_config('config.pl');

    return $self;
}

sub run {
    my ( $self, $env ) = @_;

    my $req = Plack::Request->new($env);

    my $res    = {};
    my $status = 500;

    my $ipaddr = $req->param("ipaddr") || $req->address;
    my $host = $req->param("host");

    if ($host) {
        my $update = $self->update_dns( $host, $ipaddr );
        if ($update) {
            infof("update fail: $update");
            $res->{error} = $update;
            $status = 400;
        }
        else {
            infof('update success');
            $status = 200;
        }
    }
    else {
        infof("update fail: invalid parameter");
        $res->{error} = 'invalid parameter';
        $status = 400;
    }

    $res->{ipaddr} = $ipaddr;
    $res->{host}   = $host;

    my $json = JSON->new;
    return [
        $status,
        [ 'Content-Type' => 'application/json' ],
        [ $json->encode($res) ]
    ];
}

sub update_dns {
    my ( $self, $host, $ipaddr ) = @_;

    my $zone = $self->{config}{zone};
    my $ns   = $self->{config}{ns};
    my $ttl  = $self->{config}{ttl} || 300;

    my $res = Net::DNS::Resolver->new;
    $res->nameservers($ns);

    my $update = Net::DNS::Update->new($zone);

    $update->push( update => rr_del("$host.$zone A") );
    $update->push( update => rr_add("$host.$zone $ttl A $ipaddr") );

    my $reply = $res->send($update);

    if ($reply) {
        my $rcode = $reply->header->rcode;
        $rcode eq 'NOERROR' ? return : return "failed: $rcode";
    }
    else {
        return 'failed: ', $res->errorstring;
    }
}

1;
__END__

=head1 NAME

Haruna::Server -

=head1 SYNOPSIS

  use Haruna::Server;

=head1 DESCRIPTION

Haruna is

=head1 AUTHOR

Hideo Kimura E<lt>hide@hide-k.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


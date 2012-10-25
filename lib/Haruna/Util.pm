package Haruna::Util;
use strict;
use warnings;

use File::Spec;
use Carp qw(croak);

sub load_config {
    my ($class, $file) = @_;

    my $fname  = File::Spec->catfile($file);
    my $config = do $fname;
    croak ("$fname: $@") if $@;
    croak ("$fname: $!") unless defined $config;
    unless ( ref($config) eq 'HASH' ) {
        croak ("$fname does not return HashRef.");
    }
    return $config;
}

1;
__END__

=head1 NAME

Haruna::Util -

=head1 SYNOPSIS

  use Haruna::Util;

=head1 DESCRIPTION

Haruna is

=head1 AUTHOR

Hideo Kimura E<lt>hide@hide-k.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

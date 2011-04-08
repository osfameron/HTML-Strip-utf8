package HTML::Strip::utf8;

=head1 NAME

HTML::Strip::utf8 - strip HTML that may include utf8 characters

=head1 SYNOPSIS

    my $hs = HTML::Strip::utf8->new;
    my $stripped = $hs->parse($some_string); # utf8, latin1, or ascii
    $hs->eof;

=head1 DESCRIPTION

RT bug https://rt.cpan.org/Ticket/Display.html?id=42834 fails to work
with utf8.  Until this is fixed, here's a workaround, suggested by
Zefram and ilmari on #london.pm

=head1 AUTHORS

    (C) osfameron@cpan.org 2011
    (C) zefram@cpan.org    2011
    (C) ilmari@cpan.org    2011

=cut

use strict; use warnings;
use parent 'HTML::Strip';

use utf8;
use Encode;

our $VERSION = 0.1;

sub parse {
    my ($self, $string) = @_;
    my $octets = encode_utf8( $string );
    utf8::downgrade( $octets );
    my $stripped = $self->SUPER::parse( $octets );
    return decode_utf8( $stripped );
}

1;

use strict; use warnings;

use HTML::Strip;
use HTML::Strip::utf8;
use Devel::Peek;
use Test::More tests => 3;
use Encode;
use utf8;

=head1 Workaround for HTML::Strip with utf8

As discussed with Zefram and ilmari on #london.pm, thanks!

L<HTML::Strip> doesn't handle utf8 properly, as it's XS and probably not
written to work on characters, only bytes.

By default the parse method, when given unicode, returns a bytestring with no
unicode markings.

A naive way to handle this would be to simply decode_utf8.  This works for
utf8 strings... but not for extended latin1.

A better workaround, suggested by Zefram, is to encode and downgrade first,
then decode after.

NB: this is just a workaround.  Better solutions would be to a) fix HTML::Strip
or b) use HTML::Parser instead

=cut

my @strings = (
    {
        type   => 'ascii',
        string => 'test',
    },
    {
        type   => 'unicode',
        string => "\x{2603}",  # snowman
    },
    {
        type   => 'latin1',
        string => "L\x{e9}on",
    }
);

my $hs  = HTML::Strip->new();
my $hsu = HTML::Strip::utf8->new();

for my $record (@strings) {
    my $string = $record->{string};
    my $html = $string . "<br>"; # some sample html to strip

    # my $stripped = parse_simple( $html );  # fails unicode test
    # my $stripped = parse_unicodey( $html ); # fails the latin1 test
    my $stripped   = parse_utf8( $html );   

    is( $string, $stripped, $record->{type} );
        # or do { Dump($string); Dump($stripped) };
}

sub parse_simple {
    my $html = shift;
    my $stripped = $hs->parse($html);
    $hs->eof;
    return $stripped;
}

sub parse_unicodey {
    my $html = shift;
    my $stripped = $hs->parse($html);
    $hs->eof;
    return decode_utf8($stripped);
}

sub parse_utf8 {
    my $html = shift;
    my $stripped = $hsu->parse($html); # this uses workaround
    $hsu->eof;
    return $stripped;
}

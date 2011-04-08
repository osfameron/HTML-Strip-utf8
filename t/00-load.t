#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'HTML::Strip::utf8' ) || print "Bail out!\n";
}

diag( "Testing HTML::Strip::utf8 $HTML::Strip::utf8::VERSION, Perl $], $^X" );

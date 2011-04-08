use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'HTML::Strip::utf8',
    AUTHOR              => q{osfameron <osfameron@cpan.org>},
    VERSION_FROM        => 'lib/HTML/Strip/utf8.pm',
    ABSTRACT_FROM       => 'lib/HTML/Strip/utf8.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'HTML-Strip-utf8-*' },
);

use Test::More;
use Test::Warnings;

use Mojo::File qw/curfile/;
use Test::Mojo;
 
my $script = curfile
    ->dirname
    ->dirname
    ->dirname
    ->sibling('ft_api.pl');
 
my $t = Test::Mojo
    ->new($script);

subtest 'can fetch vendors data' => sub {
    plan tests => 3;
    $t
        ->get_ok('/v1/foodtruck/permits')
        ->status_is(200)
        ->json_like('/status'  => qr/^(?:success|error)$/,
                    '/data'    => qr/.+/,
                    '/permits' => qr/^\d+$/);
};

done_testing();

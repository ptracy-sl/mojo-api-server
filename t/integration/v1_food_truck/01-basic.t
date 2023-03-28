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

subtest 'can instantiate mojo app' => sub {
    plan tests => 2;
    $t
        ->get_ok('/')
        ->status_is(404);
};

done_testing();

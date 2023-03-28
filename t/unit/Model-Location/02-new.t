use strict;
use warnings;

use Test::More;
use Test::Exception;
use Test::Warnings;

use Log::Any qw/$log/;
use Model::Location;
can_ok('Model::Location', 'new');

subtest 'exception thrown on invalid args' => sub {
    plan tests => 4;

    throws_ok {Model::Location->new}
              qr|^Missing required arguments:|,
              'ctor without args - exception caught';

    throws_ok {Model::Location->new(db => 'db', log => $log)}
              'Error::TypeTiny::Assertion',
              'ctor with invalid :db type - exception caught';

    throws_ok {Model::Location->new(db => bless {}, 'DBI::db')}
              qr|^Missing required arguments:|,
              'ctor with :log arg - exception caught';

    throws_ok {Model::Location->new(db => bless({}, 'DBI::db'), log => 'log')}
              'Error::TypeTiny::Assertion',
              'ctor with invalid :log type - exception caught';
};

subtest 'can instantiate' => sub {
    plan tests => 1;

    new_ok('Model::Location' => [
        db  => bless({}, 'DBI::db'),
        log => $log,
    ], 'Model::Location');

};

done_testing;

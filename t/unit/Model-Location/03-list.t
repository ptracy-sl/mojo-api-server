use strict;
use warnings;

use DBI;
use DBD::Mock;

use Test::More;
use Test::Exception;
use Test::Warnings;

use Log::Any qw/$log/;
use Model::Location;
can_ok('Model::Location', 'list');

my $dbh = DBI->connect('dbi:Mock:MySQL', '', '', {
    RaiseError  => 0,
    AutoCommit  => 1,
});

my $obj = Model::Location
    ->new(db  => $dbh,
          log => $log);

subtest 'fetch all permits' => sub {
    plan tests => 1;

    local $dbh->{mock_session} = DBD::Mock::Session->new({
            statement    => 'SELECT locationid, applicant, facilitytype, fooditems, address, locationdescription FROM Mobile_Food_Facility_Permit WHERE status = ? ORDER BY locationid',
            bound_params => ['APPROVED'],
            results      => [
                [qw|locationid applicant|],
                [1, 'app1'],
                [2, 'app2'],
                [3, 'app3'],
            ]
        });

    lives_and {
        my $res = $obj->list;
        is_deeply($res, [
            {locationid => '1', applicant => 'app1'},
            {locationid => '2', applicant => 'app2'},
            {locationid => '3', applicant => 'app3'},
        ], 'results ok');
    } 'list: no exceptions';
};

done_testing;

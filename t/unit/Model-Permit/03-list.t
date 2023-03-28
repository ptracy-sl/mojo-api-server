use strict;
use warnings;

use DBI;
use DBD::Mock;

use Test::More;
use Test::Exception;
use Test::Warnings;

use Log::Any qw/$log/;
use Model::Permit;
can_ok('Model::Permit', 'list');

my $dbh = DBI->connect('dbi:Mock:MySQL', '', '', {
    RaiseError  => 0,
    AutoCommit  => 1,
});

my $obj = Model::Permit
    ->new(db  => $dbh,
          log => $log);

subtest 'fetch all permits' => sub {
    plan tests => 1;

    local $dbh->{mock_session} = DBD::Mock::Session->new({
            statement    => 'SELECT distinct permit, applicant FROM Mobile_Food_Facility_Permit ORDER BY permit',
            bound_params => [],
            results      => [
                [qw|permit applicant|],
                [qw|11-ff app1|],
                [qw|22-ee app2|],
                [qw|33-dd app3|],
            ]
        });

    lives_and {
        my $res = $obj->list;
        is_deeply($res, [
            {permit => '11-ff', applicant => 'app1'},
            {permit => '22-ee', applicant => 'app2'},
            {permit => '33-dd', applicant => 'app3'},
        ], 'results ok');
    } 'list: no exceptions';
};

done_testing;

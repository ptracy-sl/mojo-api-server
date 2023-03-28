#!/usr/bin/env perl
use Mojolicious::Lite;

use lib 'lib';
use Model::Permit;
use Model::Location;
#
# use csv file as db
#
plugin Database => {
    dsn         => 'dbi:CSV:',
    options     => {
        f_dir       => 'data',
        f_ext       => '.csv/r',    # filename minus ext is dbname
        f_encoding  => 'utf8',
    },
    helper      => 'db',
    RaiseError  => 1,
    PrintError  => 1,
};
#
# controllers
#
under '/v1/foodtruck';

get '/permits' => sub {
    my $c = shift;

    my $list = Model::Permit
        ->new(db  => $c->db,
              log => $c->log)
        ->list;

    $c
        ->render(json => {status  => 'success',
                          data    => $list,
                          permits => scalar @$list})
};

get '/locations' => sub {
    my $c = shift;

    my $list = Model::Location
        ->new(db  => $c->db,
              log => $c->log)
        ->list;

    $c
        ->render(json => {status => 'success',
                          data   => $list,
                          locations => scalar @$list})
};

app->start;
__END__

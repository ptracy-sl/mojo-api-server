package Role::Model;
use Try::Tiny;
use Types::Standard qw/InstanceOf HasMethods/;
use SQL::Abstract::More -extends => qw/SQL::Abstract/;
use Moo::Role;

has db => (
    is  => 'ro',
    isa => InstanceOf['DBI::db'],
    required => 1,
);

has log => (
    is  => 'ro',
    isa => HasMethods[qw|trace debug info error|],
    required => 1,
);

has _sql_builder => (
    is  => 'ro',
    isa => InstanceOf['SQL::Abstract::More'],
    init_arg => undef,
    default  => sub {SQL::Abstract::More->new},
);

sub select {
    my ($self, %args) = @_;

    try {
        my ($stmt, @bind) = $self
            ->_sql_builder
            ->select(%args);

        my $sth = $self
            ->db
            ->prepare($stmt);
        $sth
            ->execute(@bind);

        my @ret;
        while (my $row = $sth->fetchrow_hashref) {
            push @ret, $row;
        }

        $sth
            ->finish;

        \@ret
    }
    catch {
        die "sql error: $_";
    };
}

1;
__END__

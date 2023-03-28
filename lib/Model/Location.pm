package Model::Location;
use Moo;
with qw/Role::Model/;
use namespace::clean;

sub list {
    my ($self, %args) = @_;
    return $self
        ->select(
            -columns  => [qw|locationid applicant facilitytype fooditems address locationdescription|],
            -from     => 'Mobile_Food_Facility_Permit',
            -where    => {status => 'APPROVED'},
            -order_by => 'locationid',
        )
}

1;
__END__

=head1 NAME

Model::Location

=head1 SYNOPSIS

    use Model::Location;

    # instantiate with deps injection
    my $locations = Model::Location
        ->new(db  => self->db,
              log => $self->log);

    # fetch all locations
    my $locs = $locations
        ->list;

=head1 DESCRIPTION

=head1 SUBROUTINES/METHODS

=head2 CONSTRUCTOR

=head2 list

=head1 AUTHOR

    Phil Tracy <phil22_t@proton.me>

=head1 COPYRIGHT AND LICENSE

Same as perl


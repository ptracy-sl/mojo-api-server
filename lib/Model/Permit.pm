package Model::Permit;
use Moo;
with qw/Role::Model/;
use namespace::clean;

sub list {
    my ($self, %args) = @_;
    return $self
        ->select(
            -columns  => [ -distinct => qw|permit applicant|],
            -from     => 'Mobile_Food_Facility_Permit',
            -order_by => 'permit',
        )
}

1;
__END__

=head1 NAME

Model::Permit

=head1 SYNOPSIS

    use Model::Permit;

    # instantiate with deps injection
    my $locations = Model::Permit
        ->new(db  => self->db,
              log => $self->log);

    # fetch all locations
    my $perms = $permits
        ->list;

=head1 DESCRIPTION

=head1 SUBROUTINES/METHODS

=head2 CONSTRUCTOR

=head1 AUTHOR

    Phil Tracy <phil22_t@proton.me>

=head1 COPYRIGHT AND LICENSE

Same as perl


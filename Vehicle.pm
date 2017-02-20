package Vehicle;

use Moose;

has 'model_name'     => ( is  => 'ro', isa => 'Str' );
has 'armor_thikness' => ( is  => 'ro', isa => 'Num' );

has 'speed'          => ( is  => 'rw', isa => 'Num' );
has 'durability'     => ( is  => 'rw', isa => 'Num' );

sub destroy {
    return 1;
};

sub get_damage {
    
    my ( $self, $damage ) = @_;
    
    $self->durability( $self->durability - 1 );
    
    $self->destroy if $self->durability <= 0;
    
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;

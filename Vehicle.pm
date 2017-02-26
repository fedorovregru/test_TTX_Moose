# класс техника
package Vehicle;

use Moose;

my $critical_damage_chance = 10;

has 'model_name'     => ( is => 'ro', isa => 'Str' );
has 'armor_thikness' => ( is => 'ro', isa => 'Num' );

has 'speed'          => ( is => 'rw', isa => 'Num' );
has 'durability'     => ( is => 'rw', isa => 'Num' );

# уничтожение конкретного экземпляра техники
sub destroy {
	my ( $self ) = @_;
    print 'уничтожен';
    return 1;
};

# по технике получено попадание
sub get_damage {
    my ( $self, $damage ) = @_;
    
    $self->durability( $self->durability - $damage );
    
    return $self->destroy if $self->durability <= 0;
    
    return 1;
};

# рассчет критического попадания
sub is_get_critical_damage {
	
	return 1 if int( rand(100) ) <= $critical_damage_chance;
    return 0;
}

no Moose;
__PACKAGE__->meta->make_immutable;

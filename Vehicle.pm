# класс техника
package Vehicle;

use Modern::Perl;
use Moose;

has 'critical_damage_chance' => ( is => 'ro', isa => 'Num', default => 10 );

has 'model_name'     => ( is => 'ro', isa => 'Str' );
has 'armor_thikness' => ( is => 'ro', isa => 'Num' );
has 'speed'          => ( is => 'rw', isa => 'Num' );
has 'durability'     => ( is => 'rw', isa => 'Num' );

has 'destroyed'      => ( is => 'rw', clearer => 'revive', predicate => 'is_destroyed' );

# уничтожение конкретного экземпляра техники
sub destroy {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    $self->destroyed('1');
    say '[уничтожен]';
    
    return 1;
};

# по технике получено попадание
sub get_damage {
    my ( $self, $damage ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    $self->durability( $self->durability - $damage );
    
    return $self->durability <= 0 ? $self->destroy : 1;
};

# рассчет критического попадания
sub is_get_critical_damage {
    my ( $self ) = @_;
    
    return int( rand(100) ) <= $self->critical_damage_chance;
}

no Moose;
__PACKAGE__->meta->make_immutable;

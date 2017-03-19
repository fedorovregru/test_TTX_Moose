# класс техника
package Vehicle;

use Modern::Perl;
use Moose;

has 'model_name'     => ( is => 'ro', isa => 'Str' );
has 'armor_thikness' => ( is => 'ro', isa => 'Num' );
has 'speed'          => ( is => 'rw', isa => 'Num' );
has 'durability'     => ( is => 'rw', isa => 'Num' );

has 'critical_damage_chance' => ( is      => 'ro',
                                  isa     => 'Num',
                                  default => 10 );

has 'is_destroyed'           => ( is      => 'rw',
                                  isa     => 'Bool',
                                  default => 0 );

# если объект уничтожен выходим со статусом "ноль"
around [qw( destroy get_damage )] => sub {
    my $orig = shift;
    my $self = shift;
    
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    $self->$orig(@_);
};

# уничтожение конкретного экземпляра техники
sub destroy {
    my ( $self ) = @_;
    
    $self->is_destroyed('1');
    say '[уничтожен]';
    
    return 1;
};

# по технике получено попадание
sub get_damage {
    my ( $self, $damage ) = @_;
    
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

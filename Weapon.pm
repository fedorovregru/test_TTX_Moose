# класс оружие
package Weapon;

use Modern::Perl;
use Moose;

has 'ammo_type'  => ( is => 'ro', isa => 'Str' );
has 'ammo_count' => ( is => 'rw', isa => 'Num' );

has 'destroyed'  => ( is => 'rw', clearer => 'revive', predicate => 'is_destroyed' );

# прицеливаемся
sub aim {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    say '[прицелился]';
    return 1;
}

# стреляем
sub shot {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    # если боезапас пуст, выходим с ошибкой
    if ( $self->ammo_count == 0 ) {
        say '[боезапас пуст!]';
        return 0;
    }
    
    $self->ammo_count( $self->ammo_count - 1 );
    say '[выстрелил]';
    return 1;
}

no Moose;
__PACKAGE__->meta->make_immutable;

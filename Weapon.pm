# класс оружие
package Weapon;

use Moose;

has 'ammo_type'  => ( is => 'ro', isa => 'Str' );
has 'ammo_count' => ( is => 'rw', isa => 'Num' );

# прицеливаемся
sub aim {
    print 'прицелился';
    return 1;
}

# стреляем
sub shot {
    my ( $self ) = @_;
    
    # если боезапас пуст, выходим с ошибкой
    if ( $self->ammo_count == 0 ) {
        print 'боезапас пуст!';
        return 0;
    }
    
    $self->ammo_count( $self->ammo_count - 1 );
    print 'выстрелил';
    return 1;
}

no Moose;
__PACKAGE__->meta->make_immutable;

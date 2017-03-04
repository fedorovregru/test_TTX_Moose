# класс оружие пушка
package Cannon;

use Modern::Perl;

use Moose;
extends 'Weapon';
with 'Reloadable';

# после выстрела пытаемся перезарядиться если оружие не заряжено
after 'shot' => sub {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
		say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    return ( !$self->magazine_ammo && !$self->reload ) ? 0 : 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;

# класс оружие пулемет
package Machinegun;

use Moose;
extends 'Weapon';
with 'Reloadable';

# после выстрела пытаемся перезарядиться если оружие не заряжено
after 'shot' => sub {
    my ( $self ) = @_;
	
    return ( !$self->magazine_ammo && !$self->reload ) ? 0 : 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
